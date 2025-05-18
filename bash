
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Updating package list..."
sudo apt-get update

echo "Installing Java 17..."
sudo apt-get install -y openjdk-17-jdk

echo "Verifying Java installation..."
java -version

echo "Installing Maven..."
sudo apt-get install -y maven

echo "Verifying Maven installation..."
mvn -version

echo "Installing Docker..."

# Remove older versions if any
sudo apt-get remove -y docker docker-engine docker.io containerd runc

# Install dependencies
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker’s repository
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again with Docker repo
sudo apt-get update

# Install Docker Engine
echo "Installing Docker..."

# Remove any old versions
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# Install required packages
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up the Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list to include Docker's repo
sudo apt-get update

# Install Docker Engine and CLI
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add your user to the docker group (requires re-login)
sudo usermod -aG docker $USER

echo "Docker installed successfully. Run 'docker version' to verify."
echo "You may need to log out and back in to use Docker without sudo."

