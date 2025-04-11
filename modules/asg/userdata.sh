#!/bin/bash
dnf install docker -y
#pip3.11 install ansible hvac 2>&1 | tee -a /opt/userdata.log
#ansible-pull -i localhost, -U https://github.com/kuppalaORG/basic_ansible.git main.yml -e env=${env} -e role_name=${role_name} -e vault_token=${vault_token} 2>&1 | tee -a /opt/userdata.log

growpart /dev/nvme0n1 4
lvextend -r -L +5G /dev/mapper/RootVG-varVol

#docker run -d -p 80:80 -e CATALOGUE_HOST=catalogue.codedeploywithbharath.tech -e CATALOGUE_PORT=80 -e USER_HOST=user.codedeploywithbharath.tech -e USER_PORT=80 -e CART_HOST=cart.codedeploywithbharath.tech -e CART_PORT=80 -e SHIPPING_HOST=shipping.codedeploywithbharath.tech -e SHIPPING_PORT=80 -e PAYMENT_HOST=payment.codedeploywithbharath.tech -e PAYMENT_PORT=80 public.ecr.aws/w8x4g9h7/roboshop-v3/frontend
#
#docker run -d -p 8080:8080 -e MONGO=true -e MONGO_URL="mongodb://mongod.codedeploywithbharath.tech:27017/catalogue" public.ecr.aws/w8x4g9h7/roboshop-v3/catalogue
#
#
#docker run -e DB_TYPE=mongo -e APP_GIT_URL=https://github.com/roboshop-devops-project-v3/catalogue -e DB_HOST=mongod.codedeploywithbharath.tech -e SCHEMA_FILE=db/master-data.js public.ecr.aws/w8x4g9h7/roboshop-v3/schema-load
