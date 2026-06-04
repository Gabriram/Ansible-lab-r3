cd "$LAB_DIR" \
  && test -f ansible.cfg \
  && test -d roles/springboot/tasks \
  && test -d inventory \
  && test -d playbooks \
  && ! ls -1 "$LAB_DIR" | grep -E '^=' \
  && ansible-galaxy collection list amazon.aws 2>/dev/null | grep -q "amazon.aws"
