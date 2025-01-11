echo "Setting up workstation..."

echo "Deteting OS and Package Manager..."

case "$OSTYPE" in
  darwin*)  
    pkg_manager="brew"
    ;;
  linux*)   
    . /etc/os-release
    case $ID in
      fedora) 
        pkg_manager="dnf"
        ;;
      ubuntu) 
        pkg_manager="apt"
        ;;
      *) 
        echo "Platform $ID not supported!"
        ;;
    esac
    ;;
  *)        
    echo "Platform $OSTYPE not supported!"
    ;;
esac

if [[ ! -v pkg_manager ]]; then
  echo "Aborting Setup..."
  exit 1
fi

echo "Detected Package Manager: $pkg_manager"

echo "Updating System Packages..."
sudo $pkg_manager update -y && $pkg_manager upgrade -y

echo "Installing git..."
sudo $pkg_manager install -y git

echo "Installing ansible..."
sudo $pkg_manager install -y ansible

echo "Setting up Workstation Configuration"
PROJECT_DIR="$HOME/Projects"
REPO_DIR="$PROJECT_DIR/workstation-setup"
REPO_URL="git@github.com:teaall/workstation-setup.git"
echo "Create Projects Directory if not existing..."
mkdir -p $PROJECT_DIR
if [ ! -d "$REPO_DIR" ] ; then
    git clone $REPO_URL $REPO_DIR
else
    cd "$REPO_DIR"
    git pull $REPO_URL
fi

