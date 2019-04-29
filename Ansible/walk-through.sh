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
      vhost: Ansible-Test-VM
tasks:                            #### Tasks performed by the playbook
- name: httpd package is present
  yum:
    name: httpd
    state: latest
- name: latest index.html file is present
  copy:
    src: files/index.html
    dest: /var/www/html/
    
tasks:                            #### Playing around with using vars
  - name: create a virtual host file for {{ vhost }}
    template:
      src: somefile.j2
      dest: /etc/httpd/conf.d/{{ vhost }}

tasks:                            #### How to use "command" option
  - name: enable selinux
    command: /sbin/setenforce 1
    
tasks:                            #### How to use "shell" option
  - name: run this command and ignore the result
    shell: /usr/bin/somecommand
    ignore_errors: True

# Handlers
handlers:
    - name: restart memcached
      service:
        name: memcached
        state: restarted
      listen: "restart web services"
    - name: restart apache
      service:
        name: apache
        state:restarted
      listen: "restart web services"

tasks:
    - name: restart everything
      command: echo "this task will restart the web services"
      notify: "restart web services"
      
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

#Do you not care about errors?
ignore_errors: True

#Check hosts affected
ansible-playbook playbook.yml --list-hosts

#Run playbook
ansible-playbook playbook.yml

#https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html
#need to actually read up on using the roles:
#https://ansible-docs.readthedocs.io/zh/stable-2.0/rst/playbooks_roles.html
#apparently by default the roles are stored in /etc/ansible/roles
#another page for playbook intro
#https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html
