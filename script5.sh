cd "$LAB_DIR" \
  && test -f roles/springboot/tasks/main.yml \
  && test -f roles/springboot/defaults/main.yml \
  && test -f roles/springboot/handlers/main.yml \
  && python3 -c "import yaml; yaml.safe_load(open('roles/springboot/tasks/main.yml'))" \
  && python3 -c "import yaml; yaml.safe_load(open('roles/springboot/defaults/main.yml'))" \
  && python3 -c "import yaml; yaml.safe_load(open('roles/springboot/handlers/main.yml'))" \
  && ! grep -q "Placeholder" roles/springboot/tasks/main.yml \
  && grep -q "changed_when: git_clone.changed" roles/springboot/tasks/main.yml \
  && ansible-playbook playbooks/deploy.yml --syntax-check >/dev/null 2>&1
