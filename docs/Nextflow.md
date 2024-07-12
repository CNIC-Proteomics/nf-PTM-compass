# Install Nextflow

## Check prerequisites

Make sure 11 or later is installed on your computer by using the command:
```
java -version
```
Otherwise:
```
sudo apt install openjdk-21-jre-headless
  or
sudo apt install openjdk-19-jre-headless
```

## Set up
Dead easy to install

Enter this command in your terminal:
```
mkdir -p ~/softwares/nextflow && \
cd ~/softwares/nextflow && \
curl -s https://get.nextflow.io | bash
```
(it creates a file nextflow in a bin folder in your home)

Set the Environment variable PATH to point to ~/bin:
```
echo 'export PATH=~/softwares/nextflow:$PATH' >> ~/.bashrc && \
  source ~/.bashrc
```
