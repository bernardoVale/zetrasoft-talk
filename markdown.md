
class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/intro.jpg)

---

# Motivação

Introduzir ferramentas que auxiliam a resolver quatro grandes
problemas nesse novo "universo" chamado DevOps

???
Mundo de tecnologia é desesperador.

- Duas horas da pra explicar como funciona ansible e chef

  Será que será útil?

- Duas horas **da** pra mostrar que ferramentas utilizar para cada problema

---

# Quatro grandes desafios

1. Automação da aplicação / Infraestrutura da aplicação

???
Tomcat, Java, Python, Ruby, 
logging, 

--

1. Automação do runtime (virtual machine / container) de uma aplicação

???
Como criar, remover, modificar esse runtime

Memoria, CPU, Como criar a maquina em si

--

1. Automação da infraestrutura de uma aplicação

???
Load balancers, DNS, CDN, VPC
Montagem da casa

--

1. Automação do processo das automações

???
Executo na minha máquina?
Como as alterações vão parar na produção



---

# Automação do Aplicação / Infraestrutura da Aplicação

1. Infraestrutura base

???
Log rotate, users, Package managers (yum/apt)

--

1. Instalação da Infraestrutura da aplicação

???
Python, Java, Wildfy/Tomcat

--

1. Deploy da aplicação

???
Versionamento da aplicação

---

# Como esses problemas eram resolvidos?

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/artesao.jpeg)

---

**install.sh**

```shell
#!/bin/bash

groupadd app
useradd myapp

yum -y install tomcat java8

cp $APP.war $TOMCAT_HOME/webapps/

systemctl restart tomcat

```

???
Quem nunca

--

# Meu código é idempotente?

--

# É previsível ?

--

# Funciona sempre ????

---

class: top, center

# Rápido

???
Devops = Entregar software com qualidade o mais rápido possível

DevOps é agilidade
--

# Confiável

???
Exemplo: Deploy da sexta-feira as 18h
--

# Previsível

???
Deploy falha de staging pra produção

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/cfg_tools.png)

???


---
class: top, middle

# Conjunto de recursos que simplificam automação de infraestrutura.

???
Scripts simplificados
Minha jornada shell scripts depois python depois cfg. management

---

# Chef snippet

```ruby
package 'tomcat' do
  action :install
end
```

# Ansible snippet

```yml
- yum: name=tomcat state=installed
```
# Puppet snippet

```conf
package { 'tomcat':
  ensure => 'installed',
}
```

---

# Como este problema vem sendo resolvido?

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/puppet-client-server.jpg)

???
Puppet = 2004
AGENT = Ruby program
FACTER = Collects info about machine

---
class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/chef-client-server.png)

???

Chef = 2009

---

# Server/node Architecture - Pull based

**Server**

 - Máquina detentora de todas as informações da sua infrastutura.
 - Source of truth
 - Mantem arquivado o estado atual de todos os nodes

???
Ansible = 2012

CONS - Single point of failure
PROS - Single pane of glass da sua infraestrutura

--

**Client**

  - Entra em contato com o server periodicamente para verificar se o estado desejado mudou
  - Aplica mudanças se for necessário
  - Reportar estado ao server

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/ansible-architecture.png)

---

# Server/Node - Push Based

**Server/Controller**

- Aplica mudanças nos nodes quando requisitado manualmente ou através de eventos (time, scm...)

**Node**

- Recebe/Aplica mudanças se for necessário

---
class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/shut-up-code.jpg)

---
class: middle, center

# Mutable Infrastructure

Deploy/Provision uma vez, estado modificado diversas vezes.

--

# Immutable Infrastructure

Deploy/Provision uma vez, **nunca** mais mude o estado

???
Estado imutável, uma vez criado nunca mais alterado

Introduzir o conceito de Pets x Cattle

---

class: middle, center

# Immutable Infrastructure

Deterministicidade!

???
Deterministico = facil de prever. Seu processo todo deveria ser assim

IRFR (Infrastructure-Related Failure Rate)
% of build/deployment failures related to infrastructure issues

--

Fácil de replicar/recriar!


???
Reprovisione um novo componente se você precisar de mudar

--

Velocidade de correção

???
Histórico de mudanças = toda mudança uma imagem
Rollback facil = so subir outra instancia

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/pets-cattle.jpeg)

---
class: top, right, fit-image
background-image: url(http://localhost:8000/images/one-does-ansible.jpg) 

???

Cfg. Management tools foram criados no paradigma "mutable"

Criadas para instalar e gerenciar softwares em ambientes já existentes


---
class: middle, center
# 2 Automação do runtime de uma aplicação
---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/packer.png)

---

# Packer Conceitos

**Builder**

Constroi infrastrutura utilizando um "Cloud" provider

--

**Provisioner**

Provisiona a infraestrutura criada utilizando uma ferramenta de provisionamento/cfg. management

--

**Post Processors**

Ações que devem ser executadas após o provisionamento. 

E.g: Docker Tag / Docker Push

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/shut-up-code.jpg)

---
class: middle, center

# Ok, construimos uma imagem. Como crio a maquina virtual?

--

# E quanto aos outros componentes? 

# Security Groups, Load Balancers?

--

# Auto Scaling?

---
class: middle, center

# 3 Automação da infraestrutura de uma aplicação

---
class: middle, center

# Configuration Management Tools
#  vs 
# Orchestration tools

---

Ansible:

```yml
- hosts: localhost
  gather_facts: no
  connection: local
  tasks:
    - name: Provision new machine
      ec2:
        count: 1
        image: ami-9b86fe8d
        region: us-east-1
        instance_type: t2.micro
```

Chef:

```
knife ec2 server create -r 'role[webserver]' -I ami-9b86fe8d -f t2.micro
```

---
class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/logo_terraform.png)

???
Infrastructure as code

Execution Plan

Resource Graph

---
class: middle, center

# Demo Terraform

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/cloudformation.png)

---

# Sparkle && Troposphere

???
https://github.com/cloudtools/troposphere/blob/master/examples/EC2InstanceSample.py

https://github.com/sparkleformation/sparkle_formation/blob/develop/examples/allinone/cloudformation/ec2_example.rb
---

### Develop

**Chef**: Kitchen + Docker/Vagrant/EC2

--

**Ansible**:  Molecule + Docker/Vagrant/EC2

--

### Test

**Chef:** Kitchen + Inspec

**Ansible:** Molecule + Testinfra

--

### Bake

Packer

--

### Provision / Deploy

CloudFormation (Troposphere / Sparkle) / Terraform

---
class: middle, center

# 4 Automação do processo das automações

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/rundeck.jpg)

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/spinnaker.jpg)

---
# Final Thoughts

- Não comece automatizando os casos complicados

???
Comece com apps simples, monitoramento

--

- Não se esqueça de escrever testes 

--

- Não tente utilizar todas essas ferramentas de uma vez!

???
Start small. Iterate


---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/thanks.png)
