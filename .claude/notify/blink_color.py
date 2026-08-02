#!/usr/bin/env python3
"""Set blink(1) mk3 color. Usage: blink_color.py <red> <green> <blue> [--off]"""
import sys
from blink1.blink1 import Blink1


def main():
    b1 = Blink1()
    try:
        if "--off" in sys.argv:
            b1.off()
            return

        if len(sys.argv) != 4:
            sys.exit(f"usage: {sys.argv[0]} <red 0-255> <green 0-255> <blue 0-255> | --off")

        r, g, b = (int(x) for x in sys.argv[1:4])
        b1.fade_to_rgb(0, r, g, b)
    finally:
        b1.close()


if __name__ == "__main__":
    main()
