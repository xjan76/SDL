#!/bin/bash

apt install python3-pip ansible sshpass
pip install mako pyone pyvmomi
ansible-galaxy collection install community.general
ansible-galaxy collection install ansible.windows