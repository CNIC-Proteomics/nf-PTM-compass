# How to install WSL2 (Windows Subsystem for Linux 2) on Windows 10

https://pureinfotech.com/install-windows-subsystem-linux-2-windows-10/#install_wsl_command_2004_windows10
https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#1-overview
https://linuxconfig.org/ubuntu-22-04-on-wsl-windows-subsystem-for-linux

1. Open Start on Windows 10.

2. Search for Command Prompt, right-click the top result, and select the Run as administrator option.

3. Type the following command to install the WSL on Windows 10 and press Enter:
```
wsl --install
```

4. Restart your computer to finish the WSL installation on Windows 10.

## Install WSL with specific distro

To install WSL with a specific distro on Windows 10, use these steps:

1. Open Start.

2. Search for Command Prompt, right-click the top result, and select the Run as administrator option.

3. Type the following command to view a list of available WSL distros to install on Windows 10 and press Enter:
```
	wsl --list --online
```
Quick note: At the time of this writing, you can install Ubuntu, Debian, Kali Linux, openSUSE, and SUSE Linux Enterprise Server.

4. Install the Ubuntu 22.04 from the Windows Store!!!

UNUSEFUL:
Type the following command to install the WSL with a specific distro on Windows 10 and press Enter:
```
wsl --install -d Ubuntu
```

## Increase the limiting Memory Usage in WSL2

https://www.aleksandrhovhannisyan.com/blog/limiting-memory-usage-in-wsl-2/

1. Check the current memory
You can check how much memory and swap space are allocated to WSL using the free command from within a WSL distribution:
```
free -h --giga
```

2. Create .wslconfig
Refer to the Microsoft docs on configuration settings for **.wslconfig** if you need help with this step. Below is the config that I’m currently using for my machine since I don't have a lot of RAM to work with:

"C:\Users\YourUsername\.wslconfig"
```
[wsl2]
memory=100GB
```

3. Restart WSL
You can either close out of WSL manually and wait a few seconds for it to fully shut down, or you could launch Command Prompt or PowerShell and run the following command to forcibly shut down all WSL distributions:
```
wsl --shutdown
```
4. Verify That WSL Respects .wslconfig
Finally, run the free command again to verify that WSL respects your specified resource limits:
```
free -h --giga
```
