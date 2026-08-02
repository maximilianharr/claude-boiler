# blink(1) mk3 color control

## Setup on a new machine

Install the Python library (talks to the device over HID):

```
pip install --user --break-system-packages blink1
```

Plug in the blink(1) and confirm it's detected:

```
lsusb | grep -i -E "blink|27b8"
```

Expect a line like `ID 27b8:01ed ThingM blink(1)`.

By default `/dev/hidraw*` is root-only, so the script can't open the device as a
normal user:

```
ls -la /dev/hidraw*
```

Add a udev rule granting access (one-time, requires sudo):

```
sudo tee /etc/udev/rules.d/51-blink1.rules <<'EOF'
SUBSYSTEM=="usb", ATTR{idVendor}=="27b8", MODE="0666"
KERNEL=="hidraw*", ATTRS{idVendor}=="27b8", MODE="0666"
EOF
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Unplug and replug the device (or re-run `udevadm trigger`), then verify the
matching `/dev/hidrawN` is now world read/write (`crw-rw-rw-`):

```
ls -la /dev/hidraw*
```

## Usage

```
python3 blink_color.py <red 0-255> <green 0-255> <blue 0-255>
python3 blink_color.py --off
```

Examples:

```
python3 blink_color.py 255 0 0     # red
python3 blink_color.py 0 255 0     # green
python3 blink_color.py 0 0 255     # blue
python3 blink_color.py --off
```
