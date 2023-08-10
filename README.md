# 🍵 teaMachineSomOS

## Supported Hardware:
- **Raspberry Pi Zero W**
- **Raspberry Pi Zero 2 W**

## Installation:

**Source:** [Raspberry Pi OS with desktop](https://downloads.raspberrypi.org/raspios_armhf/images/raspios_armhf-2023-05-03/)
- **Release Date:** May 3rd, 2023
- **System:** 32-bit
- **Kernel Version:** 6.1
- **Debian Version:** 11 (bullseye)
- **Size:** 872MB

Ensure the SD card is flashed using the **Raspberry Pi Imager software**.

## Configuration:

### Configure Swap Space (500MB):

```bash
sudo swapoff -a
sudo dd if=/dev/zero of=/var/swapfile bs=1M count=500
sudo chmod 600 /var/swapfile
sudo mkswap /var/swapfile
sudo swapon /var/swapfile
echo "/var/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
```

### System Updates:

```bash
sudo apt update -y
sudo apt upgrade -y
```

### Installing System Packages:

```bash
sudo apt-get install -y matchbox-keyboard
sudo apt install -y python3 python3-pip
sudo apt-get install -y python3-pil.imagetk python3-tk libatlas-base-dev
```

### Installing Python Libraries:

```bash
pip3 install --no-input customtkinter Pillow
pip3 install --no-input serial plotly dash collections-extended numpy scikit-fuzzy matplotlib pyusb
pip3 install opencv-python==4.6.0.66
pip3 install --upgrade numpy
```

### Update /boot/config.txt:

```bash
echo "max_usb_current=1" | sudo tee -a /boot/config.txt
echo "hdmi_group=2" | sudo tee -a /boot/config.txt
echo "hdmi_mode=87" | sudo tee -a /boot/config.txt
echo "hdmi_cvt 1024 600 60 6 0 0 0" | sudo tee -a /boot/config.txt
echo "hdmi_drive=1" | sudo tee -a /boot/config.txt
```

### Set vm.swappiness:

```bash
echo "vm.swappiness=0" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```


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
