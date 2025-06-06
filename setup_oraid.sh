#!/bin/bash

echo -e "\e[33mInstalling System Updates\e[0m"
sudo apt update && sudo apt upgrade -y
sudo apt-get install figlet cowsay -y

figlet "Crypto-Genesis"

wait_and_display_message() {
    sleep $1
    echo -e "\e[32m$2\e[0m"
}

pink_space() {
    echo -e "\e[95m===============>>>>>>>>>>>>>>\e[0m"
}

light_blue_text() {
    echo -e "\e[1;94m$1\e[0m"
}


light_blue_text "**Welcome to the ZTP script developed by Crypto-Genesis for Orai Validator Installation. Let's streamline your setup process!**"


echo -e "\e[32m**Orai will install in $HOME/.oraid**\e[0m"

echo -e "\e[32m<Oraid Installation in Progress>\e[0m"

wait_and_display_message 30 "Preparing Installation"

pink_space

 
echo -e "\e[33mAdding user\e[0m"
cd $HOME
sudo chown -R $USER:$USER /home/$USER/

echo -e "\e[32mUSER added\e[0m"

pink_space


echo -e "\e[33mIncreasing file limit\e[0m"
sudo sh -c 'echo "* soft nofile 65535" >> /etc/security/limits.conf'
sudo sh -c 'echo "* hard nofile 65535" >> /etc/security/limits.conf'

echo -e "\e[32mFile Limit Increased\e[0m"

pink_space


if ! command -v ufw &> /dev/null
then
    echo -e "\e[33mUFW is not installed. Installing...\e[0m"
    sudo apt update
    sudo apt install ufw -y
fi


echo -e "\e[33mAdding FW Rules\e[0m"
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 123/udp
sudo ufw allow 26656/tcp
sudo ufw --force enable <<< "yes"
sudo ufw reload
echo "UFW setup completed."
echo -e "\e[32mUFW is now configured and Enabled\e[0m"

pink_space


echo -e "\e[33mInstalling - Build-essential, git, make, gcc, wget, liblz4-tool and wasmlib\e[0m"


send_enter_if_needed() {
    read -t 1 -n 10000 discard || return  
    [ -n "$discard" ] && echo -ne '\n'  
}


sudo apt update && sudo apt upgrade -y
send_enter_if_needed

sudo apt install -y build-essential
send_enter_if_needed

sudo apt install -y make gcc wget git liblz4-tool
send_enter_if_needed

#Install Wasmlib
sudo wget https://github.com/oraichain/wasmvm/raw/v1.5.2/internal/api/libwasmvm.x86_64.so -O /lib/libwasmvm.x86_64.so
send_enter_if_needed

echo -e "\e[32mSuccessfully Installed - Build-essential, git, make, gcc, wget, liblz4-tool and wasmlib\e[0m"

pink_space


echo -e "\e[33mInstalling Go\e[0m"

cd $HOME
sudo wget https://go.dev/dl/go1.22.9.linux-amd64.tar.gz
tar xvzf go1.22.9.linux-amd64.tar.gz
wait_and_display_message 30 "Installation in Progress..."

echo -e "\e[33mRemoving existing Go installation and installing the new one\e[0m"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.22.9.linux-amd64.tar.gz

pink_space

echo -e "\e[33mCreating a user directory for the current user\e[0m"
sudo useradd -d /home/$USER $USER
sudo chown -R $USER:$USER /home/$USER/
echo -e "\e[32mUSER added\e[0m"

pink_space

echo -e "\e[33mAdding Go Binaries to PATH\e[0m"
export PATH=/usr/local/go/bin:$PATH
export PATH=$HOME/go/bin:$PATH
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.profile
echo -e "\e[32mGo Binaries added to PATH\e[0m"

pink_space


echo -e "\e[33mCleaning Up Extracted files\e[0m"
rm go1.22.9.linux-amd64.tar.gz
echo -e "\e[32mExtracted Fles Cleaned\e[0m"

pink_space


echo -e "\e[32mSource the profiles to apply changes immediately\e[0m"

pink_space

source ~/.profile
source $HOME/.bashrc

echo -e "\e[32mGo has been installed successfully.\e[0m"

pink_space

# Step 15
check_directory() {
    if [ -d "$1" ]; then
        echo -e "\e[33m$2\e[0m"
    else
        echo -e "\e[31m$3\e[0m"
        exit 1
    fi
}


echo -e "\e[33mInstalling Oraid binary from source\e[0m"
echo "Please visit https://github.com/oraichain/wasmd - To check the latest version"

read -p "Enter the Oraid version to checkout (e.g., v0.50.11): " version

cd $HOME

git clone https://github.com/oraichain/wasmd/

cd $HOME/wasmd/

git checkout "$version"

echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> ~/.profile

source ~/.profile
source $HOME/.bashrc

make build

wait_and_display_message 30 "Download Completed"

pink_space

echo -e "\e[33mCreating Oraid genesis.json File and addrbook.json\e[0m"

# Ask for moniker name
read -p "Enter your moniker name: " moniker_name

# Change directory to the specified location
cd "$HOME/"

# Run the command
oraid init "$moniker_name" --chain-id Oraichain


# Define the genesis.json file paths
CONFIG_DIR="$HOME/.oraid/config/"
GENESIS_JSON="$CONFIG_DIR/genesis.json"

# Remove existing JSON file if it exists
if [ -f "$GENESIS_JSON" ]; then
    rm "$GENESIS_JSON"
    echo "Existing genesis.json file removed."
fi

pink_space

wget -P "$CONFIG_DIR" https://raw.githubusercontent.com/oraichain/oraichain-static-files/master/genesis.json

echo -e "\e[32mNew genesis.json file downloaded\e[0m"

pink_space

wget -P "$CONFIG_DIR" https://snapshots.polkachu.com/addrbook/orai/addrbook.json --inet4-only

echo -e "\e[32mNew addrbook.json file downloaded\e[0m"

pink_space


echo -e "\e[33mStarting Snapshot Download\e[0m"

# Download the latest snapshot
download_latest_snapshot() {
    echo -e "\e[32mDownloading the latest snapshot...\e[0m"
    # Download the latest snapshot from BlockVal
    curl -L https://snap.blockval.io/oraichain/oraichain_latest.tar.lz4 -o "$HOME/oraichain_latest.tar.lz4"
}

download_specific_snapshot() {
    echo "Visit https://snapshot.owallet.io/"
    echo "Please enter the snapshot number:"
    read snapshot_number
    url="https://snapshot.owallet.io/files/oraichain_${snapshot_number}.tar.lz4"
    curl -L "$url" -o "$HOME/oraichain_${snapshot_number}.tar.lz4"
}


echo -e "\e[33mChoose download option:\e[0m"
echo "1. Download the BLOCKVAL latest snapshot"
echo "2. Download a OWALLET snapshot  (Minimum Disk Space)"
pink_space
echo "Please enter the option 1 or 2"
echo "Waiting for input... (Timeout in 1 minute)"

if read -t 60 option; then
    
    case $option in
        1)
            download_latest_snapshot
            ;;
        2)
            download_specific_snapshot
            ;;
        *)
            echo "Invalid option. Downloading the latest snapshot by default."
            download_latest_snapshot
            ;;
    esac
else
    echo "No input received. Downloading the latest snapshot automatically."
    download_latest_snapshot
fi

while [ ! -f "$HOME/oraichain_latest.tar.lz4" ] && [ ! -f "$HOME/oraichain_${snapshot_number}.tar.lz4" ]; do
    sleep 1
done

echo -e "\e[32mSnapshot downloaded successfully\e[0m"

echo "Unzipping the new Snapshot Folders..."
for file in $HOME/*.tar.lz4; do
        tar -I lz4 -xf "$file" -C $HOME/.oraid
        rm "$file"
done

while [ -n "$(find $HOME -maxdepth 1 -name '*.tar.lz4')" ]; do
        sleep 1
done

echo -e "\e[32mNew Snapshot Folders unzipped successfully\e[0m"


cd $HOME

cd "$HOME/.oraid"

wait_and_display_message 30 "Installation in Progress..."

pink_space


cd $HOME
wait_and_display_message 30 "Creating Oraid Directory..."

pink_space


echo -e "\e[33mCreating systemd daemon for Oraid\e[0m"


# Define the content for the oraid.service file
cat <<EOF | sudo tee /etc/systemd/system/oraid.service > /dev/null
[Unit]
Description       = Oraid Service
Wants             = network-online.target
After             = network-online.target

[Service]
User              = $USER
Type              = simple
ExecStart         = $HOME/go/bin/oraid start --home $HOME/.oraid
TimeoutStopSec    = 300
LimitNOFILE       = 65535
Restart           = on-failure
RestartSec        = 10
SyslogIdentifier  = oraid

[Install]
WantedBy          = multi-user.target
EOF

sudo chmod 644 /etc/systemd/system/oraid.service

sudo systemctl daemon-reload

sudo systemctl enable oraid.service

sudo systemctl start oraid.service

echo "Oraid daemon created successfully"

pink_space

wait_and_display_message 30 "Installation in Progress..."

pink_space


check_directory "$HOME/.oraid" ".oraid directory is created" ".oraid directory not found, installation failed"


change_config_values() {
    sed -i 's|seeds = ""|seeds = "8542cd7e6bf9d260fef543bc49e59be5a3fa9074@seed.publicnode.com:26656,defeea41a01b5afdb79ef2af155866e122797a9c@seed4.orai.zone:26656,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@seeds.polkachu.com:23356,8b346750e75fd584645192a65c62c7ab88741791@134.209.106.91:26656,4d0f2d042405abbcac5193206642e1456fe89963@3.134.19.98:26656"|' "$1/config.toml"
    sed -i 's|pruning = "default"|pruning = "custom"|' "$1/app.toml"
    sed -i 's|pruning-keep-recent = "0"|pruning-keep-recent = "100"|' "$1/app.toml"
    sed -i 's|pruning-interval = "0"|pruning-interval = "20"|' "$1/app.toml"
    sed -i 's|minimum-gas-prices = ""|minimum-gas-prices = "0.001orai"|' "$1/app.toml"
    sed -i 's|chain-id = ""|chain-id = "Oraichain"|' "$1/client.toml"
}


echo "Config and app configuration in progress..."
check_directory "$HOME/.oraid/config/" "config.toml file found" "config.toml file not found, configuration failed"
check_directory "$HOME/.oraid/config/" "app.toml file found" "app.toml file not found, configuration failed"
check_directory "$HOME/.oraid/config/" "client.toml file found" "client.toml file not found, configuration failed"
echo -e "\e[32mConfig and app configuration completed\e[0m"

pink_space

cd $HOME

change_config_values "$HOME/.oraid/config"
echo "Values changed successfully"

echo "Running Oraid Service"

sudo systemctl restart oraid.service

echo -e "\e[32mOrai validator Node Setup Completed Successfully\e[0m"

pink_space

echo -e "\e[32m**Orai successfully installed in $HOME/.oraid**\e[0m"

pink_space

echo -e "\e[5;32mPreparing Services >>>>>>\e[0m"

pink_space

echo "Please run < sudo systemctl status oraid > to check the node status"

echo "To start ORAID = sudo systemctl start oraid"
echo "To stop ORADI = sudo systemctl stop oraid"
echo "To restart Oraid = sudo systemctl restart oraid"
echo "To check logs = sudo journalctl --unit=oraid --follow"

pink_space

#echo -e "\e[34mHappy Validating\e[0m"
#light_blue_text "**HAPPY VALIDATING!**"
cowsay "Stay positive and HAPPY VALIDATING!"

echo -e "\e[31mInitiating server reboot to apply configuration changes...\e[0m"

pink_space

echo -e "\e[5;32mPreparing for server reboot...\e[0m"

pink_space

echo -e "\e[31m<<< Server is now rebooting >>>\e[0m"

wait_and_display_message 30
sudo reboot
