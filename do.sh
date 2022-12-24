#!/bin/bash
mac_addr=XX:XX:XX:XX:XX:XX
source venv/bin/active
sudo hcitool -i hci0 cmd 0x04 0x009
sudo hcitool -i hci0 cmd 0x3f 0x001 0x56 0x34 0x12 0xCB 0x58 0x94
sudo systemctl restart bluetooth.service
sudo ~/kinsaku-kun/venv/bin/joycontrol-pluginloader -r ${mac_addr} ./ContinueButtonA.py
