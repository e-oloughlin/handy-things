#!/bin/zsh
declare -A applications

applications["Alfred 4"]="alfred"
applications["Alt-C"]="alt-c"
applications["Bluesnooze"]="bluesnooze"
applications["Google Chrome"]="google-chrome"
applications["Docker"]="docker"
applications["Firefox"]="firefox"
applications["iTerm"]="iterm2"
applications["Postman"]="postman"
applications["Slack"]="slack"
applications["Spectacle"]="spectacle"
applications["Spotify"]="spotify"
applications["Statusfy"]="statusfy"
applications["Tunnelblick"]="tunnelblick"
applications["Visual Studio Code"]="visual-studio-code"
applications["Zoom"]="zoom"
applications["Figma"]="figma"
applications["Loom"]="loom"
applications["VLC"]="vlc"
applications["Authy"]="authy"

# ------------------------------------------------------------------------------------------------

declare -A cli_tools

cli_tools["AWS CLI"]="awscli"
cli_tools["jq"]="jq"
cli_tools["Docker Credential Helper ECR"]="docker-credential-helper-ecr"
cli_tools["node.js"]="node"
cli_tools["nvm"]="nvm"
cli_tools["tldr"]="tldr"
cli_tools["tree"]="tree"

# ------------------------------------------------------------------------------------------------

bold=$(tput bold)
normal=$(tput sgr0)

# ------------------------------------------------------------------------------------------------

install_oh_my_zshell() {
  echo "π Checking for ${bold}oh my zsh${normal}"
  echo ""
  if [[ ! -f ~/.zshrc ]]; then
    echo "    β No installation found, installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  else
    echo "    Found oh-my-zsh π"
  fi
}

# ------------------------------------------------------------------------------------------------

install_homebrew() {
  which -s brew
  if [[ $? != 0 ]] ; then
    echo "πΊπΊπΊ ${bold}First, installing Homebrew${normal} πΊπΊπΊ"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo ""
    echo "πΊ ${bold}Homebrew already installed${normal} π"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

install_cask_with_homebrew() {
  echo $1 | tr -d '"' | read name

  echo "πΉ ${bold}$name${normal}"
  echo ""

  application_path="/Applications/$name.app"

  if [[ -f $application_path || -d $application_path ]]; then
    echo "   Found in Applications π"
  elif brew list $2 &>/dev/null; then
    echo "   Found installation with brew π"
  else
    echo "    β  No installation found, installing with brew"
    brew install --cask $2 && echo "${bold}$app${normal} installed β"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

install_with_homebrew() {
  echo $1 | tr -d '"' | read name

  echo "πΉ ${bold}$name${normal}"
  echo ""

  if brew ls --versions $2 > /dev/null; then
    echo "   Tool already installed π"
  else
    echo "   β Tool not found, installing with brew"
    echo ""
    brew install $2 && echo "${bold}$1${normal}"
  fi
  echo ""
}

# ------------------------------------------------------------------------------------------------

echo ""
echo "π This script installs Homebrew & basic apps needed for π» development π"
echo ""

install_homebrew

# ------------------------------------------------------------------------------------------------

echo "π Checking for applications to install"
echo ""

for name safe_name in ${(kv)applications}; do
  install_cask_with_homebrew $name $safe_name
done

echo "π Checking for CLI tools to install"
echo ""

for name safe_name in ${(kv)cli_tools}; do
  install_with_homebrew $name $safe_name
done

echo "π€ Computer all set up for development π"
echo ""
