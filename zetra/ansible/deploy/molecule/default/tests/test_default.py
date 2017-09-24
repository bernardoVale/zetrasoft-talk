import os

import requests
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_tomcat_installed(host):
    assert host.package("tomcat").is_installed


def test_tomcat_running(host):
    tomcat = host.service("tomcat")
    assert tomcat.is_running
    assert tomcat.is_enabled


def test_application_running():
    r = requests.get("http://localhost:8080/app/chef/ping")
    assert r.status_code == 200
    assert r.text == 'Hello Chef deployed war'


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'
