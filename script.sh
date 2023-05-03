#!/bin/bash
input="./names.csv"
while read -r line
do
 output=$(getent passwd "$line") ## check if the user already using getent output
 if [ -n "$output" ]; then       ## if the out is not empty user already exit
  echo "User exist already"
  continue
 else
  sudo useradd -m "$line" -s /bin/bash
  mkdir /home/$line/.ssh
  cp -r ./.ssh/authorized_keys /home/$line/.ssh/authorized_keys
  chown -R $line:$line /home/$line/.ssh

  chmod 700 /home/$line/.ssh
  chmod 600 /home/$line/.ssh/authorized_keys
  echo "$line"
fi
done < "$input"
