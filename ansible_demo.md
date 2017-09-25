
startup:

```
python2.7 -m virtualenv venv
source venv/bin/activate
pip install molecule
pip install docker-py
pip install ansible==2.3.2
molecule init role -d docker --role-name deploy
```

Setup requirements.txt
```
pip install requests
```
Fix file molecule.yml
```yml
platforms:
  - name: instance
    image: centos:7
    privileged: True
    command: /usr/sbin/init
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup
    ports:
      - 8081:8080
    capabilities:
      - SYS_PTRACE
```

Fix file create.yml:
```yml
- name: Create molecule instance(s)
  docker_container:
    name: "{{ item.name }}"
    hostname: "{{ item.name }}"
    image: "molecule_local/{{ item.image }}"
    state: started
    recreate: False
    log_driver: syslog
    command: "{{ item.command | default('sleep infinity') }}"
    privileged: "{{ item.privileged | default(omit) }}"
    volumes: "{{ item.volumes | default(omit) }}"
    capabilities: "{{ item.capabilities | default(omit) }}"
    ports: "{{ item.ports | default(omit) }}"
  with_items: "{{ molecule_yml.platforms }}"
```

Create docker container:
```
molecule create
```

Write first test:
```python
def test_tomcat_installed(host):
    assert host.package("tomcat").is_installed
```

run molecule verify

Write ansible base.yml call it inside default.yml:

base.yml
```yml
- name: Install latest tomcat version
  yum:
    name: tomcat
    state: latest
```

main.yml
```yml
- include: base.yml
```

run converge:
```
molecule converge
```

Test if tomcat is enabled and running:

```python
def test_tomcat_running(host):
    tomcat = host.service("tomcat")
    assert tomcat.is_running
    assert tomcat.is_enabled
```

Finish base.yml:
```yml
- name: Enable tomcat service
  service: name=tomcat state=started enabled=yes
```

converge && verify

Deploy Java application and get the md5

Write final test:
```python
import requests

...

def test_application_running():
    r = requests.get("http://localhost:8081/app/")
    assert r.status_code == 200
    assert r.content == 'Hello ZetraSoft v1'
```

Write defaults.yml:

```yml
deploy:
  tomcat:
    home: /var/lib/tomcat/webapps
    user: tomcat
    group: tomcat
  artifact:
    url: https://s3.amazonaws.com/ac-zetra-deploy
    name: zetra.war

artifact_checksum: 0885628bfba9560288766852f26affb1bbb56ddc8c24ce0114f6d668d96e270d
```

Write deploy.yml:

```yml
- name: Fetch Application WAR
  get_url:
    url: "{{deploy.artifact.url}}/{{deploy.artifact.name}}"
    dest: "{{deploy.tomcat.home}}/app.war"
    owner: "{{deploy.tomcat.user}}"
    group: "{{deploy.tomcat.group}}"
    mode: 0640
    checksum: "sha256:{{artifact_checksum}}"
    
```

Explain handlers:
```yml
- name: restart tomcat
  service: name=tomcat state=restarted
```

add notify:
```yml
notify:
  - restart tomcat
```

molecule converge && molecule verify

Change playbook.yml:
```yml
---
- name: Converge
  hosts: all
  vars:
    artifact_checksum: newchecksum
  roles:
    - role: deploy
```

Change deploy.yml:
```yml
register: deployed_app

...
- name: Clean old deployment
  file:
    path: "{{deploy.tomcat.home}}/app"
    state: absent
  when: deployed_app.changed
```

Change test to use v2

molecule converge && molecule verify

