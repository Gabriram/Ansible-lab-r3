#! bin/bash
set -e
command -v ansible-playbook >/dev/null
command -v aws >/dev/null
command -v ssh >/dev/null
command -v jq >/dev/null
aws sts get-caller-identity >/dev/null
aws ec2 describe-key-pairs --key-names "$KEY_PAIR_NAME" >/dev/null
DEFAULT_VPC=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true \
  --query 'Vpcs[0].VpcId' --output text)
[ "$DEFAULT_VPC" != "None" ] && [ -n "$DEFAULT_VPC" ]
test -d "$LAB_DIR"
test -r "$SSH_KEY_PATH"
echo "Setup OK"
set +e
