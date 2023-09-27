# Max's Flock MBP Settings

alias cabo='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-cabo.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "cabo password copied to clipboard"'
