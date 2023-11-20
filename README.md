## docker commands
to build run 'docker compose build'
to run the app run 'docker compose up -d'
access api endpoints host/ip address:4000
access app user interface host/ip address:8080

## Ansible deploy
To install user and docker 

`ansible-playbook -i inventory.yml configuration.yml -e "ansible_user=tm_admin"`

To install/configure/run github action runner

`ansible-playbook -i inventory.yml configuration.yml -e "ansible_user=tm_admin" -t install`

To uninstall and remove github action runner

`ansible-playbook -i inventory.yml configuration.yml -e "ansible_user=tm_admin" -t remove`
