# teaMachineSomOS

Supported hardware:
- raspberry pi zero W
- raspberry pi zero 2 W

# Installation:
SD card flashed from Raspberry pi imager software

Image:
url:https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2023-05-03/
Raspberry Pi OS with desktop
Release date: May 3rd 2023
System: 32-bit
Kernel version: 6.1
Debian version: 11 (bullseye)
Size: 872MB

# Configuring required packages

# Configure swap space to 500MB
sudo swapoff -a

sudo dd if=/dev/zero of=/var/swapfile bs=1M count=500

sudo chmod 600 /var/swapfile

sudo mkswap /var/swapfile

sudo swapon /var/swapfile

echo "/var/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab

# Update the system

sudo apt update -y

sudo apt upgrade -y

# Install various packages

sudo apt-get install -y matchbox-keyboard

sudo apt install -y python3 python3-pip

sudo apt-get install -y python3-pil.imagetk python3-tk libatlas-base-dev

# Install Python packages

pip3 install --no-input customtkinter Pillow

pip3 install --no-input serial plotly dash collections-extended numpy scikit-fuzzy matplotlib pyusb

pip3 install opencv-python==4.6.0.66 

pip3 install --upgrade numpy

# Append lines to /boot/config.txt
echo "max_usb_current=1" | sudo tee -a /boot/config.txt

echo "hdmi_group=2" | sudo tee -a /boot/config.txt

echo "hdmi_mode=87" | sudo tee -a /boot/config.txt

echo "hdmi_cvt 1024 600 60 6 0 0 0" | sudo tee -a /boot/config.txt

echo "hdmi_drive=1" | sudo tee -a /boot/config.txt


# Set vm.swappiness to 0

echo "vm.swappiness=0" | sudo tee -a /etc/sysctl.conf

sudo sysctl -p


Certainly! Here's a concise version:

# Enable Camera on Raspberry Pi Zero

### Setup:
1. **Power Off** Pi Zero.
2. **Connect** camera: ensure blue side of ribbon faces USB ports.
3. **Boot** Pi Zero.

### Configuration:
1. Open terminal.
2. Update with:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```
3. Run:
   ```bash
   sudo raspi-config
   ```
4. Go to `Interfacing Options` > `Camera` > Select `<Yes>`.

5. **Reboot**:
   ```bash
   sudo reboot
   ```

### Test:
1. Capture image:
   ```bash
   raspistill -o test.jpg
   ```
