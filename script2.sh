cd "$LAB_DIR" \
  && OUT=$(ansible-inventory --graph 2>&1) \
  && echo "$OUT" | grep -q "^@all:" \
  && ! echo "$OUT" | grep -q "Failed to parse" \
  && ! echo "$OUT" | grep -qi "AuthFailure"
