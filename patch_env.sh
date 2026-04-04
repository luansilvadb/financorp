#!/bin/bash
cat << 'INNER_EOF' >> divi/pubspec.yaml

  # To add assets to your application, add an assets section, like this:
  assets:
    - .env
INNER_EOF
