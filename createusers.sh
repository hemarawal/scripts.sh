#!/bin/bash

#check if script is executed being sudo or root.

if [[ "${UID}" -ne 0 ]]
then
        echo "Please run with sudo or root"
        exit 1
fi

if [[ "${#}" -lt 1 ]]
then
        echo "Usage: ${0} USER_NAME [comment].."
        echo 'Create a user with name USER_NAME and give some [comment]...'
        exit 1
fi

USER_NAME="${1}"
echo "Create user $USER_NAME"
shift
COMMENT="${@}"

# Create a password
PASSWORD=$(date +%S%N)
echo "$USER_NAME password is $PASSWORD"

# Create a user
useradd -c "${COMMENT}" -m $USER_NAME
if [[ $? -ne 0 ]]
then
        echo "Account could not be created"
        exit 1
fi

# Set the password for user
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Check if password is successfully set or not
if [[ $? -ne 0 ]]
then
        echo "Password could not be set"
        exit 1
fi

# Force password change on first login
passwd -e $USER_NAME

#display username and hostname
echo "Username is $USER_NAME"
echo "Hostname is $(hostname)"

#Create group

add_group() {
	read -p "enter $User_Name secondary group:" group_name
        groupadd $group_name
	echo "group created successfully"
}
add_group

#check group is created or not
if [[ $? -ne 0 ]]; then
    echo "Failed to create group for user"
    exit 1
fi

#add user to secondary group
usermod -aG $group_name $USER_NAME
echo "user added to secondary group successfully"
if [[ $? -ne 0 ]]; then
   echo "Failed to add user to secondary group"
   exit 1
fi

