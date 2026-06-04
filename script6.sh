# Retry per dare tempo al servizio di completare l'avvio della JVM e il warm-up Spring.
for attempt in 1 2 3 4 5 6; do
  if curl -fsS --max-time 10 "http://${INSTANCE_PUBLIC_IP}:8080/" -o /tmp/lab_response.html; then
    echo "App responded on attempt $attempt"
    break
  fi
  echo "Attempt $attempt failed, retrying in 20s..."
  sleep 20
done
