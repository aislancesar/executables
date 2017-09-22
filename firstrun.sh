#!/bin/bash

echo -e "\n\e[1;35m    -=  THIS IS THE FIRST RUN PROGRAM =-"
echo "Insert M for Master computer or S for Slave."
read MASTER
while [[ $MASTER != 'M' && $MASTER != 'S' ]] ; then
do
    echo -e "\e[31mInserted $MASTER."
    echo "Insert M for Master computer or S for Slave."
    read MASTER
done

if [[ $MASTER = 'M' ]] ; then
    echo "Master computer activated."
    MASTER=true
else
    echo "Slave computer activated."
    MASTER=false
fi

mkdir build
cd build

mkdir ~/brix # Create mounting folder
mkdir ~/.local/bin # Create binary folders

mv * ~/.local/bin # Move binaries

cp bashrc ~/.bashrc # Copy terminal things
cp git-* ~/

sudo chmod 777 !(.git*|*.*) # Give permission to all binaries

# Install programs
TELEGRAM=false
echo "Installing Telegram!"
if sudo add-apt-repository ppa:atareao/telegram && sudo apt update && sudo apt install telegram ; then
    echo "Telegram was installed."
    TELEGRAM=true
fi

SPOTIFY=false
echo "Installing Spotify!"
if sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 0DF731E45CE24F27EEEB1450EFDC8610341D9410 && echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list && sudo apt update && sudo apt install spotify-client ; then
    echo "Spotify was installed."
    SPOTIFY=true
fi

SUBLIME=false
echo "Installing Sublime!"
if wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && sudo apt install apt-transport-https && echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list && sudo apt update && sudo apt install sublime-text ; then
    echo "Sublime was installed."
    SUBLIME=true
fi

BRDICTS=false
MVBRDICTS=false
echo "Downloading dictionaries!"
if wget "https://github.com/titoBouzout/Dictionaries/raw/master/Portuguese%20(Brazilian).dic" && wget "https://github.com/titoBouzout/Dictionaries/raw/master/Portuguese%20(Brazilian).aff" ; then
    echo "Dictionaries downloaded.\nTrying to move it."
    BRDICTS=true

    if mv Portuguese\ \(Brazilian\).* ~/.config/sublime-text-3/Packages/User/pt-br.* ; then
        echo "Dictionaries were moved."
        MVBRDICTS=true
    fi
fi

DROPBOX=false
echo "Installing Dropbox."
if cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf - ; then
    ~/.dropbox-dist/dropboxd ;
    echo "Dropbox was installed."
    DROPBOX=true
fi

GIT=false
echo "Installing GIT."
if sudo apt install -y git ; then
    echo "GIT was installed."
    GIT=true
fi

PYTHON=false
echo "Installing Python dependencies."
if sudo apt -y install -y python-pygame && sudo apt -y install -y python-matplotlib && sudo apt -y install -y python-scipy ; then
    echo "Python dependencies were installed."
    PYTHON=true
fi

C=false
echo "Installing C++ dependencies."
if sudo apt install -y cmake && sudo apt -y install libboost-all-dev ; then
    echo "C++ dependencies were installed."
    C=true
fi

OKULAR=false
echo "Installing Okular."
if sudo apt install -y okular ; then
    echo "Okular was installed."
    OKULAR=true
fi

KRAKEN=false
echo "Installing Gitkraken."
if wget https://release.gitkraken.com/linux/gitkraken-amd64.deb && dpkg -i gitkraken-amd64.deb ; then
    echo "Gitkraken was installed."
    KRAKEN=true
fi

if !$MASTER ; then
    OPEN=false
    echo "Installing OpenSSH."
    if sudo apt install openssh-server ; then
        echo "OpenSSH was installed."
        OPEN=true
    fi

    GLANCES=false
    echo "Installing Glances."
    if sudo apt install python-pip build-essential python-dev && sudo pip install Glances && sudo pip install PySensors ; then
        echo "Glances was installed."
        GLANCES=false
    fi
fi

TEXLIVE=false
FONTS=false
echo "Installing Texlive."
if wget "https://raw.githubusercontent.com/scottkosty/install-tl-ubuntu/master/install-tl-ubuntu" && sudo chmod +x install-tl-ubuntu && sudo ./install-tl-ubuntu ; then
    echo "Download and installation of the of texlive finished, now it will install non free fonts."
    TEXLIVE=true

    if sudo apt install -y perl-tk && wget "http://tug.org/fonts/getnonfreefonts/install-getnonfreefonts" && sudo chmod 777 install-getnonfreefonts && sudo ./install-getnonfreefonts && getnonfreefonts --all ; then
        echo "Non free fonts installed."
        FONTS=false
    fi
fi

# TODO's after instalations
# Install and update everything deprecated.
echo -e "\e[1;31mTHINGS TO REINSTALL"

if ! $TELEGRAM ; then
    echo "    Telegram Desktop."
fi

if ! $SPOTIFY ; then
    echo "    Spotify."
fi

if ! $SUBLIME ; then
    echo "    Sublime Text."
fi

if ! $BRDICTS ; then
    echo "    Download Dictionaries."
elif ! $MVBRDICTS ; then
    echo "    Move Dictionaries."
fi

if ! $DROPBOX ; then
    echo "    Dropbox."
fi

if ! $GIT ; then
    echo "    GIT."
fi

if ! $PYTHON ; then
    echo "    Reinstall pygame, matplotlib and/or scipy."
fi

if ! $C ; then
    echo "    Reinstall cmake and/or libboost-all-dev."
fi

if ! $OKULAR ; then
    echo "    Okular."
fi

if ! $KRAKEN ; then
    echo "    Gitkraken."
fi

if ! $MASTER && ! $OPEN ; then
    echo "    OpenSSH."
fi

if ! $MASTER && ! $GLANCES ; then
    echo "    Glances."
fi

if ! $TEXLIVE ; then
    echo "    Texlive."
elif ! $FONTS ; then
    echo "    Non free fonts."
fi

echo -e "\n\e[1;35mFURTHER INSTRUCTIONS"
echo "    Configure Dropbox to use *@fei.edu.br as user."
echo "    Gnome extensions installed should be:"
echo "        AlternateTab,"
echo "        Dash to Dock,"
echo "        Pixel Saver,"
echo "        Removable Drive Menu,"
echo "        System Monitor,"
echo "        TopIcons Plus,"
echo "        User Themes and"
echo "        windowNavigator."
echo "    Configure SSH key."
echo "    Reboot the computer."
echo "    Type sudo visudo on terminal and add /opt/texbin to the line >>> Defaults."