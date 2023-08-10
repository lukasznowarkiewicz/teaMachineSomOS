#!/bin/bash

# Lists to store results
successful_installs=()
failed_installs=()

# Helper function to execute a command and check its result
execute_and_check() {
    "$@"
    if [ $? -eq 0 ]; then
        successful_installs+=("$1")
    else
        failed_installs+=("$1")
    fi
}

# Configure swap space to 500MB
echo "Configuring swap size to 500MB..."
sudo swapoff -a
sudo dd if=/dev/zero of=/var/swapfile bs=1M count=500
sudo chmod 600 /var/swapfile
sudo mkswap /var/swapfile
sudo swapon /var/swapfile
echo "/var/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

# Update the system
execute_and_check sudo apt update -y
execute_and_check sudo apt upgrade -y

# Install various packages
execute_and_check sudo apt-get install -y matchbox-keyboard
execute_and_check sudo apt install -y python3 python3-pip
execute_and_check sudo apt-get install -y python3-pil.imagetk python3-tk libatlas-base-dev

# Install Python packages
execute_and_check pip3 install --no-input customtkinter Pillow
execute_and_check pip3 install --no-input serial plotly dash collections-extended numpy scikit-fuzzy matplotlib pyusb
execute_and_check pip3 install opencv-python==4.6.0.66 
execute_and_check pip3 install --upgrade numpy

# Append lines to /boot/config.txt
echo "max_usb_current=1" | sudo tee -a /boot/config.txt
echo "hdmi_group=2" | sudo tee -a /boot/config.txt
echo "hdmi_mode=87" | sudo tee -a /boot/config.txt
echo "hdmi_cvt 1024 600 60 6 0 0 0" | sudo tee -a /boot/config.txt
echo "hdmi_drive=1" | sudo tee -a /boot/config.txt

# Set vm.swappiness to 0
echo "Setting vm.swappiness to 0..."
echo "vm.swappiness=0" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Display the summary
echo -e "\n===== INSTALLATION SUMMARY ====="
if [ ${#successful_installs[@]} -ne 0 ]; then
    echo -e "\nSuccessful installs:"
    for item in "${successful_installs[@]}"; do
        echo "- $item"
    done
fi

if [ ${#failed_installs[@]} -ne 0 ]; then
    echo -e "\nFailed installs:"
    for item in "${failed_installs[@]}"; do
        echo "- $item"
    done
fi
