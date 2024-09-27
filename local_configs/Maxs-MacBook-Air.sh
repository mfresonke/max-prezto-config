  if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
  fi

alias dark='cd ~/Projects/dark-secret'
alias p='cd ~/Projects'
alias xiso=extract-xiso
alias cr='cd ~/Projects/ClonedRepos'
alias nr='npm run'

# export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export PATH="/usr/local/share/dotnet:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/node@20/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/node@20/include"

export PATH="/Users/max/Applications/flutter/bin:$PATH"

#export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
#export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
#export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
#export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

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
