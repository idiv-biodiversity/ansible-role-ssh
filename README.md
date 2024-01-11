Ansible Role: OpenSSH
=====================

An Ansible role that installs and configures **OpenSSH**.

Table of Contents
-----------------

<!-- toc -->

- [Requirements](#requirements)
- [Role Variables](#role-variables)
  * [Known Hosts](#known-hosts)
  * [Authorized Keys and User Management](#authorized-keys-and-user-management)
  * [Moduli](#moduli)
- [Dependencies](#dependencies)
- [Example Playbook](#example-playbook)
  * [Top-Level Playbook](#top-level-playbook)
  * [Role Dependency](#role-dependency)
- [License](#license)
- [Author Information](#author-information)

<!-- tocstop -->

Requirements
------------

- Ansible 2.9

Role Variables
--------------

```yml
ssh_accept_env:
  - "LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES"
  - "LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT"
  - "LC_IDENTIFICATION LC_ALL LANGUAGE"
  - "XMODIFIERS"

ssh_host_keys:
  - /etc/ssh/ssh_host_ed25519_key

ssh_ciphers:
  - chacha20-poly1305@openssh.com
  - aes256-gcm@openssh.com
  - aes128-gcm@openssh.com
  - aes256-ctr
  - aes192-ctr
  - aes128-ctr

ssh_kex_algorithms:
  - curve25519-sha256
  - curve25519-sha256@libssh.org
  - diffie-hellman-group18-sha512
  - diffie-hellman-group16-sha512
  - diffie-hellman-group14-sha256
  - diffie-hellman-group-exchange-sha256

ssh_macs:
  - hmac-sha2-512-etm@openssh.com
  - hmac-sha2-256-etm@openssh.com
  - umac-128-etm@openssh.com

ssh_log_level: VERBOSE

# possible values: prohibit-password, yes, no
# note: this must be string not bool, so you need to quote 'yes' and 'no'
ssh_permit_root_login: 'no'

ssh_strict_modes: yes

ssh_pubkey_authentication: yes

ssh_pubkey_accepted_key_types:
  - ssh-ed25519

ssh_password_authentication: yes

ssh_permit_empty_password: no

ssh_challenge_response_authentication: yes

ssh_gssapi_authentication: no

ssh_gssapi_cleanup_credentials: yes

ssh_agent_forwarding: yes

ssh_tcp_forwarding: yes

ssh_x11_forwarding: no

ssh_banner:
  src: path/to/local/ssh-banner
  dest: /etc/ssh/banner

ssh_subsystems:
  - name: sftp
    command: /usr/lib/ssh/sftp-server -f AUTHPRIV -l INFO
```

For more information, read `man 5 sshd_config`.

### Known Hosts

```yml

ssh_known_hosts:

  - aliases:
      - login1.example.com
      - login1
      - a.b.c.d
    type: ssh-ed25519
    key: xxx

  - aliases:
      - login2.example.com
      - login2
      - a.b.c.d
    type: ssh-ed25519
    key: xxx

```

### Authorized Keys and User Management

```yml

ssh_users:

  - name: alice
    authorized_keys: |
      ssh-ed25519 xxx alice@workstation
      ssh-ed25519 xxx alice@laptop
    settings:
      AuthenticationMethods: publickey

  - name: bob
    authorized_keys: |
      ssh-ed25519 xxx bob@workstation
      ssh-ed25519 xxx bob@laptop
    settings:
      AuthenticationMethods: publickey

```

### Moduli

To configure the minimum modulus for `/etc/ssh/moduli`:

```yml
ssh_modulus_min: 3071
```

Dependencies
------------

```yml
---

# requirements.yml

roles:

  - name: idiv_biodiversity.ssh
    src: https://github.com/idiv-biodiversity/ansible-role-ssh
    version: vX.Y.Z

...
```

Example Playbook
----------------

### Top-Level Playbook

Write a top-level playbook:

```yml
---

- name: head server
  hosts: heads

  roles:
    - role: idiv_biodiversity.ssh
      tags:
        - ssh

...
```

### Role Dependency

Define the role dependency in `meta/main.yml`:

```yml
---

dependencies:

  - role: idiv_biodiversity.ssh
    tags:
      - ssh

...
```

License
-------

MIT

Author Information
------------------

This role was created in 2019 by [Christian Krause][author] aka [wookietreiber
at GitHub][wookietreiber], HPC cluster systems administrator at the [German
Centre for Integrative Biodiversity Research (iDiv)][idiv].

[author]: https://www.idiv.de/en/groups_and_people/employees/details/61.html
[idiv]: https://www.idiv.de/
[wookietreiber]: https://github.com/wookietreiber
