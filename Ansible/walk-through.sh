#NOT AN ACTUAL PLAYBOOK
#just a reference for introducing Ansible to new Linux Team members on CSUN CCDC Team

#Installation
sudo apt-get install ansible
sudo yum install ansible

#Host file set up
- name: install and start apache  #### Human understandable naming convention
  hosts: web                      #### Host selector
    become: yes                   #### Privilege escalation to root
    vars:                         #### Variables used by the playbook
      http_port: 80               
tasks:                            #### Tasks performed by the playbook
- name: httpd package is present
  yum:
    name: httpd
    state: latest
- name: latest index.html file is present
  copy:
    src: files/index.html
    dest: /var/www/html/
    
#Loops
- yum:
name: "{{ item }}"
state: latest
with_items:
- httpd
- mod_wsgi

#Conditionals
- yum:
name: httpd
state: latest
when: ansible_os_family == "RedHat"

#If you want to run the same command/variable/role
allow_duplicates: true

#https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html
#need to actually read up on using the roles:
#https://ansible-docs.readthedocs.io/zh/stable-2.0/rst/playbooks_roles.html
#apparently by default the roles are stored in /etc/ansible/roles
