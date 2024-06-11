# Max's Flock MBP Settings

alias cache-lib='cd ~/Projects/flock-cache-lib'
alias cache='cd ~/Projects/flock-cache-lib'
alias fireball='cd ~/Projects/fireball-ts'
alias hur='cd ~/Projects/flock-hurricane'
alias marg='cd ~/Projects/flock-margarita'
alias mp4='cd ~/Projects/flock-mp4-decoder-service'
alias msi='cd ~/Projects/flock-moonshine-internal-api'
alias msw='cd ~/Projects/flock-moonshine-worker'
alias p='cd ~/Projects'
alias pimms='cd ~/Projects/pimms-ts'
alias rbs='cd ~/Projects/flock-redbull-search'
alias server='cd ~/Projects/flock-server-lib'
alias smoke='cd ~/Projects/flock-pipeline-smoke-tests'
alias sss='cd ~/Projects/flock-saved-search-service'
alias tf='cd ~/Projects/flock-terraform'
alias vg='cd ~/Projects/flock-vodka-gimlet'

alias uuid="uuidgen | tr '[:upper:]' '[:lower:]' | tee >(tr -d '\n' | pbcopy)"
alias iso="node -e 'console.log(new Date().toISOString())' | tee >(tr -d '\n' | pbcopy)"
alias cdp='cd ~/Projects'
alias pr='gh pr create --web'
alias c='code .'
alias k=kubectl

alias cabo='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-cabo.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "cabo password copied to clipboard"'
alias tanqueray='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-tanqueray-replica.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-prod password copied to clipboard"'
alias tanqueray_admin='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-prod password copied to clipboard"'
alias dev_tanqueray='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname dev-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_ro --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-dev password copied to clipboard"'
alias dev_tanqueray_admin='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname dev-tanqueray.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "tanq-dev admin password copied to clipboard"'
alias saved_search='export PGPASSWORD=$(aws rds generate-db-auth-token --hostname prod-saved-search.cc0b62yca12h.us-east-1.rds.amazonaws.com --port 5432 --region us-east-1 --username iam_role_admin --no-cli-auto-prompt); echo -n $PGPASSWORD | pbcopy; echo "saved-search-service prod password copied to clipboard"'

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
		nvm use default
	fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

do_node_stuff() {
	if [ -e package.json ]; then
		load-nvmrc
		echo "npm installing..."
		npm i >/dev/null
	fi
}

# Git stuff
alias gs='git status'

gp() {
	git pull
	do_node_stuff
}

gc() {
	local branch_name="$1"
	local success=0
	local current_branch=$(git rev-parse --abbrev-ref HEAD)
	if [[ $branch_name == $current_branch ]]; then
		echo "already on that branch!"
		return
	fi

	if git rev-parse --verify --quiet "refs/heads/$branch_name" >/dev/null; then
		local branch_exists=true
	else
		local branch_exists=false
	fi

	# Check if a branch with the given name already exists locally
	if [[ "$branch_exists" == "true" ]]; then
		git checkout "$branch_name"
		# echo "Checked out existing local branch: $branch_name"
		do_node_stuff
	else
		# Check if a branch with the given name exists remotely
		if git show-ref --verify --quiet "refs/remotes/origin/$branch_name"; then
			git checkout -t "origin/$branch_name"
			# echo "Created and checked out a new tracking branch: $branch_name"
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

# Add shell completion for gc
_gc() {
	local branches
	branches=($(git branch -a --sort='-committerdate:iso8601' --format='%(refname:short)' | sed 's|remotes/origin/||' | sed 's|^origin/||'))
	_describe -V branches 'branches' branches
}

compdef _gc gc
