# Use the base Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary tools
RUN apt-get update 
RUN apt-get install -y  dnsutils iputils-ping  net-tools  curl   wget   telnet   nmap   net-tools  traceroute   tmux  lsof  vim nano  tcpdump &&   apt-get clean &&   rm -rf /var/lib/apt/lists/*

# Create a non-root user 'User' and add to sudoers
RUN useradd -m User && \
    echo "User ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chmod g+rwx /home/User 
RUN chgrp -R root /home/User  && usermod -a -G root User

# Switch to the 'User' user
USER User

# Set the working directory to the user's home directory
WORKDIR /home/User

# Set a default command to keep the container running
CMD ["sleep", "infinity"]
