deploy-tools
---
- Requirements 
    - sshpass


Prepare Inventory
---   
Into the `inventory` directory , file name `inventory` is used for server list where no space can be in between two lines.

- Example `inventory`
        
    
      
       192.168.122.187:root:password
       127.0.0.1:uzzal:mypass

*Note:* New Line need to add at the end of inventory 

Prepare Deploy Scripts
---
Under `deploy/scripts` edit `main.sh` for the scripts you want to work with. You can create more than one scripts but  have to make sure that `main.sh` is main script.  
- Examples `main.sh`

        #!/usr/bin/env bash
        ping -c 2 google.com
        ip a
        hostname
        df -h
        ls -la
        lsblk



How to Run 
 ---
    git clone https://github.com/uzzal2k5/deploy-tools.git
    cd deployment-tools
    sh main.sh 
    
    
 Tested
 ---
 Tested on  CentOs 7, Debian 9.12 (stretch), Debian 10.3 (buster) & Ubuntu Server 18.04.4 LTS