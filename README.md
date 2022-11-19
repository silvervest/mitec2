
## Programming

I am using an el cheapo USB to FT232H UART adapter from AliExpress

### Pin connections

| JTAG | FTDI |
|------|------|
| TCK  | AD0  |
| TDI  | AD1  |
| TDO  | AD2  |
| TMS  | AD3  |
| VCC  | 3.3V |
| GND  | GND  |

### Steps

First we need to change the frequency line in the SVF file... The default 1MHz is too fast, so we're slowing it to 300KHz which seems to work fine.
```bash
$ sed -i "s/FREQUENCY 1E6 HZ/FREQUENCY 3E5 HZ/" mitec2.svf
```

Second we need to setup UrJTAG for the CPLD, but adding the xc9536xl_vq44 stepping to the configuration (you may need to change this file path depending on your install)
```bash
$ echo "0101    xc9536xl_vq44   5" | sudo tee -a /usr/local/share/urjtag/xilinx/xc9536xl/STEPPINGS
```

Finally, we can program
```bash
$ sudo jtag

UrJTAG 2021.03 #
Copyright (C) 2002, 2003 ETC s.r.o.
Copyright (C) 2007, 2008, 2009 Kolja Waschk and the respective authors

UrJTAG is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
There is absolutely no warranty for UrJTAG.

warning: UrJTAG may damage your hardware!
Type "quit" to exit, "help" for help.

jtag> cable jtagkey vid=0x0403 pid=0x6014
Connected to libftdi driver.
jtag> detect
IR length: 8
Chain length: 1
Device Id: 01011001011000000010000010010011 (0x59602093)
  Manufacturer: Xilinx (0x093)
  Part(0):      xc9536xl (0x9602)
  Stepping:     5
  Filename:     /usr/local/share/urjtag/xilinx/xc9536xl/xc9536xl_vq44
jtag> svf hdl/mitec2.svf stop progress
detail: Parsing   5160/5163 ( 99%)detail: 
detail: Scanned device output matched expected TDO values.
jtag> 
```

If all went well, you will get the success message

`detail: Scanned device output matched expected TDO values.`

Your device is now programmed!