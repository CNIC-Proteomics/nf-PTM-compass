# Install Nextflow

## Check Prerequisites

Make sure Java 11 or later is installed on your computer by using the command:
```
java -version
```

### Debian/Ubuntu distribution

If not installed, use one of the following commands to install it (for Debian/Ubuntu distribution):
```
sudo apt install openjdk-21-jre-headless
```
<!-- or
```
sudo apt install openjdk-19-jre-headless
``` -->

### Unix (MacOS) distribution

To install a specific version of Java on macOS using brew, you need to ensure that Homebrew is installed and then follow these steps to check for and install the desired version of Java.

- Run this command to check if Homebrew is installed:
```
brew --version
```
- If it’s not installed, you can install it with:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install the Java (openJDK 21):
```
brew install openjdk@21
```


## Set Up

Nextflow is distributed as an easy to use **self-installing** package downloading the latest stable release.

To install Nextflow with the self-installing package, follow these steps:

1. Enter this command in your terminal:
```
mkdir -p ~/bin && \
cd ~/bin && \
curl -s https://get.nextflow.io | bash
```
(This creates a `nextflow` file in a bin folder in your home directory.)


2. Make sure nextflow is executable:
```
chmod +x nextflow
```

3. Add `~/bin` to your `PATH` environment variable:
```
echo 'export PATH=~/bin:$PATH' >> ~/.bashrc && \
source ~/.bashrc
```

4. Confirm Nextflow is installed correctly:
```
nextflow info
```

### Version selection

The **NXF_VER** environment variable can be used to define which version of Nextflow to use. To switch to a specific version of Nextflow for a single run, set the NXF_VER environment variable in your execution command. For example:
```
NXF_VER=23.10.0 nextflow info
```

To set a specific version of Nextflow for a terminal session, export the NXF_VER environment variable. For example:
```
export NXF_VER=23.10.0
```

To set a specific version of Nextflow for your user profile, add the above NXF_VER export command to your shell configuration file, such as `~/.bashrc` or `~/.zshrc`, and restart your session.


## References

For further information, read the [Install section of Nextflow documentation](https://www.nextflow.io/docs/latest/install.html).
