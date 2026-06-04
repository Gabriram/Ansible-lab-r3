cd "$LAB_DIR"
cat > roles/springboot/tasks/main.yml <<'EOF'
---
# Stub temporaneo. Verrà sovrascritto nel Task 5.
- name: Placeholder
  ansible.builtin.debug:
    msg: stub
EOF
