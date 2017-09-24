class: center, bottom


# Chef & Ansible

---

# Motificação

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

???
DevOps é agilidade
--

# Confiável

???
Tem que funcionar sempre.
--

# Repetível 

???
Não pode falhar na segunda vez
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

# Como automatizo minhas automações?

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/rundeck.jpg)

---

class: top, right, fit-image
layout: false
background-image: url(http://localhost:8000/images/spinnaker.jpg)

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

# Dependency Managemen

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
