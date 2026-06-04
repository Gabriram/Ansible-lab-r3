cd "$LAB_DIR"

# 1. Recupera l'IP pubblico corrente e usalo come CIDR /32 nelle regole del SG.
#    Se sei dietro NAT/VPN questo è l'IP visto da AWS, non quello della tua macchina.
export MY_IP="$(curl -fsS https://checkip.amazonaws.com)/32"
echo "Your public IP: $MY_IP"

# 2. Provisioning del Security Group. Idempotente: rieseguirlo non duplica regole.
ansible-playbook playbooks/security_group.yml

# 3. Salva l'ID del SG in una variabile d'ambiente per i task successivi.
#    La query JMESPath cerca il SG col tag workshop=ansible-lab.
export LAB_SG_ID=$(aws ec2 describe-security-groups \
  --filters "Name=tag:workshop,Values=$LAB_TAG" \
  --query 'SecurityGroups[0].GroupId' \
  --output text)
echo "Security Group ID: $LAB_SG_ID"
