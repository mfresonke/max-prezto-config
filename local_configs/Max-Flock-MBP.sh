# Max's Flock MBP Settings

alias tf='cd ~/Projects/flock-terraform'
alias sss='cd ~/Projects/flock-saved-search-service'
alias mp4='cd ~/Projects/flock-mp4-decoder-service'
alias p='cd ~/Projects'
alias vg='cd ~/Projects/flock-vodka-gimlet'
alias rbs='cd ~/Projects/flock-redbull-search'
alias smoke='cd ~/Projects/flock-pipeline-smoke-tests'
alias msi='cd ~/Projects/flock-moonshine-internal-api'
alias msw='cd ~/Projects/flock-moonshine-worker'
alias gs='git status'

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tee >(tr -d '\n' | pbcopy)"
alias iso="node -e 'console.log(new Date().toISOString())' | tee >(tr -d '\n' | pbcopy)"
alias cdp='cd ~/Projects'
alias pr='gh pr create --web'
alias c='code .'
alias k=kubectl

unalias gc
gc() {
  local branch_name="$1"

  # Check if a branch with the given name already exists locally
  if git rev-parse --verify --quiet "refs/heads/$branch_name"; then
    git checkout "$branch_name"
    echo "Checked out existing local branch: $branch_name"
  else
    # Check if a branch with the given name exists remotely
    if git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; then
      git checkout -t "origin/$branch_name"
      echo "Created and checked out a new tracking branch: $branch_name"
    else
      read -q "REPLY?The branch '$branch_name' does not exist locally or remotely. Do you want to create a new local branch? (y/n): "
      echo
      if [[ "$REPLY" = [yY] ]]; then
        git checkout -b "$branch_name"
        echo "Created and checked out a new local branch: $branch_name"
      else
        echo "No branch was created."
      fi
    fi
  fi
}

alias cabo='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-cabo.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "cabo password copied to clipboard"'
alias tanqueray='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-tanqueray-replica.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-prod password copied to clipboard"'
alias tanqueray_admin='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-prod password copied to clipboard"'
alias dev_tanqueray='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname dev-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-dev password copied to clipboard"'
alias dev_tanqueray_admin='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname dev-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-dev admin password copied to clipboard"'
alias saved_search='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-saved-search.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "saved-search-service prod password copied to clipboard"'

# Fix the cluster that is python
eval "$(pyenv init -)"

# NVM Stuff place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
