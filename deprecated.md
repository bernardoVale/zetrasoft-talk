
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
