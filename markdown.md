class: center, bottom


# Chef & Ansible

---
# Desclaimer

???
1. We won't talk about objects because it's not a priority for this training.
1. This is not Algorithm 101 - We're not gonna cover all python data types

---
# Immutable Infrastructure

Deploy/Provision uma vez, **nunca** mais mude o estado

--

**Why???**

- Deterministicidade!

--

- Fácil de replicar!


???
Deterministico = facil de prever.

Reprovisione um novo componente se você precisar de mudar

Velocidade = 

Funciona na minha máquina, funciona em ambiente de teste, em produção falhou.
Live patch que quebra ambientes.

Bake (Packer / Chef/Ansible) / Deploy (Run new EC2/GCE)

---

# Objetivo

- Gerir/manter estado de configurações

???
Falar do twelve factor app

--
- Automatizar processsos

???
Dev and Ops = Instalar aplicações

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

# Server/node Architecture - Pull based

**Server**

 - Máquina detentora de todas as informações da sua infrastutura.
 - Source of truth
 - Mantem arquivado o estado atual de todos os nodes

???
CONS - Single point of failure
PROS - Single pane of glass da sua infraestrutura

--

**Client**

  - Entra em contato com o server periodicamente para verificar se o estado desejado mudou
  - Aplica mudanças se for necessário
  - Reportar estado ao server

---

# Server/Node - Push Based

**Server/Controller**

- Aplica mudanças nos nodes quando requisitado manualmente ou através de eventos (time, scm...)

**Node**

- Recebe/Aplica mudanças de for necessário

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

