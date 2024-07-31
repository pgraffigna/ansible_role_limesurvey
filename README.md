# ansible_role_limesurvey

Playbook role para instalar un servidor Limesurvey para realizar encuestas.

Testeado con Vagrant + qemu + ubuntu_20.04 + ansible 2.10.8

---

### Descripción

La idea del proyecto es automatizar vía ansible la instalación/configuración de un servicio [limesurvey](https://community.limesurvey.org/) para pruebas de laboratorio, el repo cuenta con 2 roles:

1. mariadb
2. limesurvey

### Dependencias

* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Uso

```
git clone https://github.com/pgraffigna/ansible_role_limesurvey.git
cd ansible_role_limesurvey
ansible-playbook main.yml
```

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* notas sobre migración entre versiones

### Uso Vagrant (opcional)
```
vagrant up
vagrant ssh
```