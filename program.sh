#!/bin/bash -xe

sed -i "s/FREQUENCY 1E6 HZ/FREQUENCY 3E5 HZ/" hdl/mitec2.svf
sudo jtag program.jtag
