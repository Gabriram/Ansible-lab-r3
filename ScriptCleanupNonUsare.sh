# 1. Termina tutte le istanze taggate workshop=ansible-lab nella region corrente.
INSTANCE_IDS=$(aws ec2 describe-instances \
  --filters "Name=tag:workshop,Values=$LAB_TAG" \
            "Name=instance-state-name,Values=pending,running,stopping,stopped" \
  --query 'Reservations[].Instances[].InstanceId' \
  --output text)

if [ -n "$INSTANCE_IDS" ]; then
  aws ec2 terminate-instances --instance-ids $INSTANCE_IDS >/dev/null
  echo "Terminating: $INSTANCE_IDS"
  aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS
  echo "Instances terminated"
fi

# 2. Elimina il Security Group del lab. Possibile solo dopo terminazione delle istanze.
SG_IDS=$(aws ec2 describe-security-groups \
  --filters "Name=tag:workshop,Values=$LAB_TAG" \
  --query 'SecurityGroups[].GroupId' \
  --output text)

for sg in $SG_IDS; do
  aws ec2 delete-security-group --group-id "$sg" && echo "Deleted SG $sg"
done

# 3. Rimuovi la directory locale del lab.
cd "$HOME"
rm -rf "$LAB_DIR"
echo "Local lab directory removed"

# 4. Rimuovi file temporanei creati durante la verifica.
rm -f /tmp/lab_response.html /tmp/lab_second_run.txt

# 5. Unset variabili d'ambiente del lab (igiene di shell).
unset KEY_PAIR_NAME SSH_KEY_PATH LAB_TAG LAB_DIR LAB_SG_ID MY_IP INSTANCE_PUBLIC_IP
echo "Cleanup complete"