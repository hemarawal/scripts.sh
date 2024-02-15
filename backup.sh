#!/bin/bash
# Function to perform directory backup

# Define the directory path for backup

DIRECTORY_PATH="/home/ubuntu/ALL_DIR_BACKUPS"

# Function to perform directory backup

Backup_dir() {
	# Checking if the backup path exists
    if [[ ! -d "$DIRECTORY_PATH" ]]; then
        echo "Error: Directory '$DIRECTORY_PATH' does not exist."
        exit 1
    fi
#Input from user which dir want to backup and Creating the backup 
    read -p "Enter the directory to backup: " directory
    timestamp=$(date +%Y%m%d%H%M%S)
    sudo tar -czvf "$DIRECTORY_PATH/backup_$timestamp.tar.gz" "$directory"

#Checking if the backup command was successful
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully"
    else
        echo "Backup failed"
    fi
}

# Calling the backup function
Backup_dir
