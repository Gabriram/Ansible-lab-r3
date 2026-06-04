test -n "$INSTANCE_PUBLIC_IP" \
  && [ "$INSTANCE_PUBLIC_IP" != "None" ] \
  && grep -E "changed=0" /tmp/lab_second_run.txt
