class: center, bottom


# Chef & Ansible

---
# Os três grandes desafios

1. Automação da aplicação

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



---

# Automação do Runtime

1. Infraestrutura base

???
Log rotate, users, Package managers (yum/apt)

--

1. Instalação da Infraestrutura da aplicação

???
Python, Java, Wildfy/Tomcat

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

--

# Meu código é idempotente?

---

class: top, center

# Rápido

--

# Confiável

--

# Repetível 
--

# Previsível

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/cfg_tools.png)

???
foo

---
class: top, middle

# Conjunto de recursos que simplificam automação de infraestrutura.

???
Minha jornada shell scripts depois python depois cfg. management

---

# Chef snippet

# Ansible snippet

# Puppet snippet

---
# Conceitos Chaves

- Nós
- Recipe / Playbook
- Resources / Tasks

???
Nos = maquinas que receberão automações

---
class: middle, center

# Como este problema vem sendo resolvido?

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/puppet-client-server.jpg)

???
AGENT = Ruby program
FACTER = Collects info about machine

---
class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/chef-client-server.png)

---

# Server/node Architecture - Pull based

**Server**

 - Máquina detentora de todas as informações da sua infrastutura.
 - Source of truth
 - Mantem arquivado o estado atual de todos os nodes

???
Puppet = 2004
Chef = 2009
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
Histórico de mudanças

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

# Evolução de Configuration Managements

Todas as máquinas registradas

Imperativo = Chef
Declarativo = Ansible, Puppet


---

# Imperativo x Declarativo

**Declarativo**

Descrever o que o programa deve fazer ao invés de como fazer!

**Imperativo**

Escrever codigo, declarando explicitamente uma série de passos para resolver um problema.

???
Hibrido = salt, ansible
Declarativo = Puppet
Chef = imperativo

---

# Qual ferramenta é melhor para minha equipe?

---

# Quem sou eu?

---

Sou apaixonado por escrever codigo eficiente, estruturado, fácil de entender.

--

Não sou muito fã de modelos declarativos que implicam em abstrações de alto nível!

--

Estou acostumado a ditar como as coisas devem acontecer com loops, condicionais, variáveis.

--

**Chef**

---

# Quem sou eu?

Não sou fã de Ruby, manjo muito de bash/Perl/Python.

--

Meu código não precisa ser um poema. Quero resolver os desafios da empresa que trabalho e ainda prover
uma infraestrutura simples e fácil de manter.

--

**Ansible**, **Salt**

???

---

Dois grandes desafios


A infrastrutura dentro da máquina (Provisionadores)

A infraestutura fora da maquina (Provides)

---

Automatizar a criação das máquinas

Primeira ideia:

1. Crio as máquinas no meu provedor de nuvem utilizando chef/ansible
2. Instalo meu provisionador na nova máquina e executo 
3. Provisiono o ambiente

???
knife-ec2 commands for chef
Ansible cloud provider commands

---

# Configuration Management orientado a Patches

Todas as máquinas possuem um desired state que é periodicamente checado.

--

Em algum ponto, esse estado precisa ser modificado


---

# Configuration Manangement Imutável

Infraestrutura é imutável!

--

- Qualquer mudança (patch) requer a reconstrução total da infraesturtura

--

- Nova versão substitui a antiga

???
Docker
Fast boot time!

---

# Task Runners / Deployers

Crontab?
Rundeck
Spinnaker

---

# Cloud Provisioners

CloudFormation
Terraform

---

# Masterless

# Desenvolvimento

**Chef**

Seu time manja de Ruby? Vai ficar preso nessa linguagem (não que isso seja um problema).

--

**Ansible**

Qualquer um consegue enterpretar um `yaml`. 

Precisa de fazer coisas mais complexas? Seu time manja `Python`? Você pode precisar.

Modulos podem ser criados em qualquer linguagem capaz de fazer um output em `json`.

--

Vale `bash`?

--

Vale tudo

---
# Multi OS Support

**Ansible**

Suporta *nix e Windows, porém o suporte Windows é recente

--

**Chef**

Suporta *unix e Windows

---

# Abstração de distros

**Ansible**

Implementada pelo próprio time

```yml

```

---

# Documentação

**Ansible**

Por ser mais recente, ainda é mais limitada.

**Chef**

Documentação extremamente rica. 

---

# Comunidade

**Ansible**

Um dos projetos mais movimentados do Github. 25.5mil stars no github.

8433 perguntas no stackoverflow.

**Chef**

Comunidade menor

5181 perguntas no stackoverflow.

---

# Workflow

**Ansible**

Git based

---

# Dependency Management



**Ansible**

`ansible-galaxy install -r requirements.yml`

--

**Chef**

Declaração de dependencias via `Berksfile`:

```
berks vendor
```


---

# Reusabilidade

**Ansible**

https://galaxy.ansible.com

**Chef**

https://supermarket.chef.io/

???
Chef possui bem mais opções por ter uma comunidade mais antiga.

---

# Cenários

Quero deployar uma nova versão da minha aplicação Java em um conjunto de hosts

---


# Ansible

Hosts definidos no `inventory` file.

Execução de um playbook com rolling update

`deploy.yml`:

```yml
- name: Deploy new version
  hosts: webservers
  serial:
  - "10%"
  - "20%"
  - "100%"
``` 

```shell
ansible-playbook deploy.yml -e VERSION=v1.1
```

---

# Chef

Nodes possuem cookbook da aplicação na versão 1.0

Utualização da versão via `knife`

```shell
knife ssh "role:web_server"
```

---

# Mantendo a Configuração de uma Aplicação

Chef, Puppet, Ansible, and SaltStack are all “configuration management” tools, which means they are designed to install and manage software on existing servers. CloudFormation and Terraform are “orchestration tools”, which means they are designed to provision the servers themselves, leaving the job of configuring those servers to other tools. These two categories are not mutually exclusive, as most configuration management tools can do some degree of provisioning and most orchestration tools can do some degree of configuration management. But the focus on configuration management or orchestration means that some of the tools are going to be a better fit for certain types of tasks.

https://blog.gruntwork.io/why-we-use-terraform-and-not-chef-puppet-ansible-saltstack-or-cloudformation-7989dad2865c

# Mutable vs Immutable Infrastructure

Configuration management tools such as Chef, Puppet, Ansible, and SaltStack typically default to a mutable infrastructure paradigm. For example, if you tell Chef to install a new version of OpenSSL, it’ll run the software update on your existing servers and the changes will happen in-place. Over time, as you apply more and more updates, each server builds up a unique history of changes. This often leads to a phenomenon known as configuration drift, where each server becomes slightly different than all the others, leading to subtle configuration bugs that are difficult to diagnose and nearly impossible to reproduce.

https://www.theregister.co.uk/2013/03/18/servers_pets_or_cattle_cern/


If you view a server (whether metal, virtualized, or containerized) as inherently something that can be destroyed and replaced at any time, then it’s a member of the herd. If, however, you view a server (or a pair of servers attempting to appear as a single unit) as indispensable, then it’s a pet.


Measure http://devopsflowmetrics.org/