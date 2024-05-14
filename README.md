# OraiChain Validator Node Deployment Script

Welcome to the OraiChain Validator Node Deployment Script repository! The primary objective of this script is to facilitate seamless and error-free deployment of the OraiChain Validator node. This script offers a significant advantage by enabling almost 100% Zero Touch Provisioning (ZTP) of the validator node server.

Key Features:

Seamless Deployment: 
The script streamlines the deployment process, ensuring a hassle-free experience.

Error-Free Execution: 
With careful design and testing, the script minimizes the occurrence of errors during deployment.

ZTP Provisioning: Enjoy the convenience of almost 100% Zero Touch Provisioning, reducing manual intervention.

Efficient Installation: The approximate installation time ranges between 10 to 15 minutes, enabling swift setup of the validator node server.


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
3) Systemd Service Setup and Enablement:
Ensure that the systemd service is set up and enabled for proper functionality.


**Note: Kindly be aware that the validator setup utilizes the oraid binary built from source in a non-Docker environment.**


Script Functionality Overview:

The deployment script automates the setup process for deploying an OraiChain Validator node. Below is a detailed breakdown of its functionality:

Set System File Limit: 
Adjusts the system file limit to 65535, optimizing performance for the validator node.

Configure and Install UFW: 
Configures and installs the Uncomplicated Firewall (UFW) if not already installed, enhancing server security.

Install Essential Packages:
Installs essential packages including build-essential, git, make, gcc, wget, liblz4-tool, Go, and libwasmvm, ensuring all necessary dependencies are met.

Set Go Path: 
Sets the Go binary path to the system PATH, enabling seamless execution of Go commands.

Install Orai Binary from Source: 
Fetches and installs the latest Orai binary from the source, ensuring the latest version is deployed.

Install Latest Snapshot: 
Downloads and installs the latest blockchain snapshot, reducing synchronization time for the validator node.

Setup oraid.service Daemon: 
Configures the oraid.service daemon, enabling automatic startup and management of the validator node as a service.

Configuration Customization:
Sets minimum gas price, pruning settings in the app.toml configuration file.
Configures seed nodes in the config.toml file, optimizing network connectivity.

Automatic Node Activation: 
Initiates the validator node automatically upon completion of the installation process, ensuring immediate functionality.

Usage:
To deploy your OraiChain Validator node using this script, simply execute the deployment script and follow the on-screen prompts.

Getting Started:
To get started with deploying your OraiChain Validator node using this script, follow these simple steps:

Installation Instructions:

1. **Download the Files:** Retrieve the necessary files onto your server.
   ```
   cd $HOME
   sudo git clone https://github.com/Crypt0Genesis/diskchecker_orai-orai-oraid.git
   ```
2. **Permissions:** Set executable permissions for the `disk-space-script.sh` file using:
   ```
   sudo chmod +x disk-space-script.sh
   ```

3. **Disk Space Monitoring:** Make the `check_disk_script.sh` file executable:
   ```
   sudo chmod +x check_disk_script.sh
   ```

4. **Crontab Configuration:** Access the crontab scheduler with:
   ```
   crontab -e
   ```
 5.  Then, add the following lines on the bottom to schedule disk space checks every 6 hours:
   ```
   # Check disk space every 6 hours
   0 */6 * * * /$HOME/diskchecker_orai-orai-oraid/check_disk_script.sh
   ```
Save and exit the file. "Ctrl + x -> Y and Enter"


**Setup Example**

```
cryptogenesis@Orai-Node:~$ cd $HOME
cryptogenesis@Orai-Node:~$ sudo git clone https://github.com/Crypt0Genesis/diskchecker_orai-orai-oraid.git
Cloning into 'diskchecker_orai-orai-oraid'...
remote: Enumerating objects: 86, done.
remote: Counting objects: 100% (86/86), done.
remote: Compressing objects: 100% (85/85), done.
remote: Total 86 (delta 49), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (86/86), 41.19 KiB | 3.17 MiB/s, done.
Resolving deltas: 100% (49/49), done.

cryptogenesis@Orai-Node:~$ ls
diskchecker_orai-orai-oraid  go  orai 

cryptogenesis@Orai-Node:~$ cd diskchecker_orai-orai-oraid

cryptogenesis@Orai-Node:~/diskchecker_orai-orai-oraid$ ls
LICENSE  README.md  check_disk_script.sh  disk-space-script.sh

cryptogenesis@Orai-Node:~/diskchecker_orai-orai-oraid$ sudo chmod +x check_disk_script.sh

cryptogenesis@Orai-Node:~/diskchecker_orai-orai-oraid$ sudo chmod +x disk-space-script.sh

cryptogenesis@Orai-Node:~/diskchecker_orai-orai-oraid$ crontab -e
no crontab for orainode - using an empty one

Select an editor.  To change later, run 'select-editor'.
  1. /bin/nano        <---- easiest
  2. /usr/bin/vim.basic

Choose 1-2 [1]: 1

#m h  dom mon dow   command
   # Check disk space every 6 hours
   0 */6 * * * /$HOME/diskchecker_orai-orai-oraid/check_disk_script.sh

Now Run the Script Manually:
orainode@Orai-Node:~/diskchecker_orai-orai-oraid$ ./check_disk_script.sh
Disk space is below 80%. No action required.
```


**If Disk Space reach at 80% or Above**
```
cryptogenesis@Orai-Node:~/diskchecker_orai-orai-oraid$ ./check_disk_script.sh
Disk space is at 80%. Running script...
Copy the priv_validator_state.json to the .oraid directory...
File moved successfully to .oraid.

Snapshot Download
Choose download option:
1. Download the BLOCKVAL latest snapshot
2. Download a NYSA-NETWORK snapshot 
Please enter the option 1 or 2
Waiting for input... (Timeout in 1 minute)
2
(Visit https://snapshots.nysa.network/Oraichain/#Oraichain/)
Please enter the latest snapshot number:
20431522

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 9073M  100 9073M    0     0  25.2M      0  0:05:58  0:05:58 --:--:-- 39.3M
Snapshot downloaded successfully.

Stopping the oraid service...
Removing old Data and Wasm folders...
Removed old Data and Wasm folders...
Unzipping the new Snapshot Folders...
New Snapshot Folders unzipped successfully.
Removing the new priv_validator_state.json and add the old one...
Existing priv_validator_state.json file removed from data directory.
File moved successfully to /home/cryptogenesis/orai/orai/.oraid/data/.
Starting the oraid service...
Deleting remaining tar.lz4 files...
Script execution completed....
Script Developed By Crypto-Genesis.... Happy Validating :)
```


```
If your server disk is running full and you need to run the script immediately, you can execute it directly using the following command:

./disk-space-script.sh
```

**Additional Information:**

We've implemented options for downloading snapshots, allowing users to select the desired image. A special acknowledgment to NysaNetwork and Blockval for extending their snapshot services to the Orai community.

Efforts are underway to swiftly deploy our own Orai validator dashboard, Sentry node, RPC, and snapshots. Once available, we'll promptly share them with our Orai community. In the interim, we'll utilize the snapshots provided by NysaNetworks and Blockval.

1. BlockVal Usage:
   By default, Blockval's snapshot feature selects the latest available snapshot. However, please note that sometimes the snapshot size can range from 40-50GB.
   The script will automatically opt for Blockval's image, as the link directs to the latest snapshot. 

2. NysaNetwork Usage (Recommended):
   The snapshot size from NysaNetwork is approximately 9GB. However, the image name varies each time.
 

If you opt to use the script manually, you'll have the choice to select your preferred snapshot image. Upon manual execution, the script will present you with Option 1 and Option 2. If no option is selected, the script will wait for 1 minute before proceeding to download the default snapshot from BlockVal.
If you run the script manually and choose Option 2 to download the Nysa snapshot, the script will prompt you to enter the latest image reference. You can obtain this reference from the Nysa Network website.


**NOTE**
```
I've thoroughly tested the script and it operates flawlessly. However, I welcome your feedback and suggestions for further enhancements. Feel free to reach out with any concerns or improvement ideas. Thanks!
