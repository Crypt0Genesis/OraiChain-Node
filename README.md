# OraiChain Validator Node Deployment Script

```
  ____                  _               ____                      _     
 / ___|_ __ _   _ _ __ | |_ ___        / ___| ___ _ __   ___  ___(_)___ 
| |   | '__| | | | '_ \| __/ _ \ _____| |  _ / _ \ '_ \ / _ \/ __| / __|
| |___| |  | |_| | |_) | || (_) |_____| |_| |  __/ | | |  __/\__ \ \__ \
 \____|_|   \__, | .__/ \__\___/       \____|\___|_| |_|\___||___/_|___/
            |___/|_|                                                   

Crypto-Genesis Validator:
Orai RPC: https://rpc-orai.cryptogenesis.xyz
https://scan.orai.io/validators/oraivaloper1r8zzyp7ffnuzlqv5hp75yhqrxf4g9fad532p7h
```

************************************************************************************************************************
Welcome to the OraiChain Validator Node Deployment Script repository! The primary objective of this script is to facilitate seamless and error-free deployment of the OraiChain Validator node. This script offers a significant advantage by enabling almost 100% Zero Touch Provisioning (ZTP) of the validator node server.

Our principal aim is to offer deployment tools and support to the community, streamlining the process of deploying our OraiChain Network with minimal hassle.

************************************************************************************************************************

**Key Features:**

**Seamless Deployment:**
The script streamlines the deployment process, ensuring a hassle-free experience.

**Error-Free Execution:** 
With careful design and testing, the script minimizes the occurrence of errors during deployment.

**ZTP Provisioning:**
Enjoy the convenience of almost 100% Zero Touch Provisioning, reducing manual intervention.

**Efficient Installation:**
The approximate installation time ranges between 10 to 15 minutes, enabling swift setup of the validator node server.

************************************************************************************************************************

**System Requirements**


1) Operating System: Ubuntu

2) Sudo Permissions with No Password Prompt:
To disable the password prompt for sudo privileges, follow these steps:

Open the sudoers file using the command: 
```
sudo visudo

Add or replace the following line to the file:

#Allow members of group sudo to execute any command#

%sudo   ALL=(ALL:ALL) NOPASSWD:ALL

Save and exit the file. "Ctrl + x -> Y and Enter"
```
3) "git" if not installed, you can install it from the following link:
```
sudo apt install git
```

************************************************************************************************************************
**Note: Kindly be aware that the validator setup utilizes the oraid binary built from source in a non-Docker environment.**
*************************************************************************************************************************

**Script Functionality Overview:**

The deployment script automates the setup process for deploying an OraiChain Validator node. Below is a detailed breakdown of its functionality:

**Set System File Limit:** 
Adjusts the system file limit to 65535, optimizing performance for the validator node.

**Configure and Install UFW:** 
Configures and installs the Uncomplicated Firewall (UFW) if not already installed, enhancing server security.

**Install Essential Packages:**
Installs essential packages including build-essential, git, make, gcc, wget, liblz4-tool, Go, and libwasmvm, ensuring all necessary dependencies are met.

**Set Go Path:** 
Sets the Go binary path to the system PATH, enabling seamless execution of Go commands.

**Install Orai Binary from Source:** 
Fetches and installs the latest Orai binary from the source, ensuring the latest version is deployed.

**Install Latest Snapshot:** 
Downloads and installs the latest blockchain snapshot, reducing synchronization time for the validator node.

**Setup oraid.service Daemon:** 
Configures the oraid.service daemon, enabling automatic startup and management of the validator node as a service.

**Configuration Customization:**
Sets minimum gas price, pruning settings in the app.toml configuration file.
Configures seed nodes in the config.toml file, optimizing network connectivity.

**Automatic Node Activation:** 
Initiates the validator node automatically upon completion of the installation process, ensuring immediate functionality.

**Usage:**
To deploy your OraiChain Validator node using this script, simply execute the deployment script and follow the on-screen prompts.

**Getting Started:**
To get started with deploying your OraiChain Validator node using this script, follow these simple steps:

************************************************************************************************************************

Installation Instructions:

1. **Download the Files:** Retrieve the necessary files onto your server.
   ```
   cd $HOME
   sudo git clone https://github.com/Crypt0Genesis/OraiChain-Node.git
   ```
2. ""Go to the downloaded folder "OraiChain-Node"
   ```
   cd OraiChain-Node
   ```
3. **Permissions:**
   Set executable permissions for the `setup_oraid.sh` file to install "oraid" in $HOME/.oraid environment:
   ```
   sudo chmod +x setup_oraid.sh
   ```
   
4. **$HOME/.oraid:** To deploy your OraiChain Validator node using this script, simply execute the deployment script and follow the on-screen prompts:
   ```
   ./setup_oraid.sh
   ```

************************************************************************************************************************
**Additional Information:**

We've implemented options for downloading snapshots, allowing users to select the desired image. A special acknowledgment to OWALLET and Blockval for extending their snapshot services to the Orai community.

Efforts are underway to swiftly deploy our own Orai validator dashboard, Sentry node, RPC, and snapshots. Once available, we'll promptly share them with our Orai community. In the interim, we'll utilize the snapshots provided by Polkachu and Blockval.

1. BlockVal Usage:
   By default, Blockval's snapshot feature selects the latest available snapshot. However, please note that sometimes the snapshot size can range from 30-40GB.
   The script will automatically opt for Blockval's image, as the link directs to the latest snapshot. 

2. OWALLET Usage (Recommended):
   The snapshot size from OWALLET is approximately 16GB. However, the image name varies each time.
 
If you opt to use the script manually, you'll have the choice to select your preferred snapshot image. Upon manual execution, the script will present you with Option 1 and Option 2. If no option is selected, the script will wait for 1 minute before proceeding to download the default snapshot from BlockVal.

3. Setup Validator:
This script sets up a full mainnet node. Once synchronization is complete, please follow the official OraiChain guide to create a validator wallet and register your validator node on the OraiChain Network.

https://docs.orai.io/nodes-and-validators/networks/mainnet/become-a-validator

************************************************************************************************************************

**NOTE**

I've thoroughly tested the script and it operates flawlessly. However, I welcome your feedback and suggestions for further enhancements. Feel free to reach out with any concerns or improvement ideas. Thanks!

**************************
Crypto-Genesis Validator:
https://t.me/crypt0genesis
**************************
