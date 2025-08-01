#!/bin/bash

sed -i 's/^#[[:blank:]]*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd
