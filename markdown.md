class: center, bottom


# Chef & Ansible

---
# Desclaimer

???
1. We won't talk about objects because it's not a priority for this training.
1. This is not Algorithm 101 - We're not gonna cover all python data types

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

