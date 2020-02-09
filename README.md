deploy-tools
---
- Requirements 
    - sshpass
    - openssl

Prepare Inventory
---   
Into the `inventory` directory , file name `inventory` is used for server list where `# ` can be use for comments. 

- Example `inventory`
        
    
    #IP_ADDRESS:USER_NAME:PASSWORD_HASH(base64)
    192.168.122.187:root:b3ZpcnQK
    #127.0.0.1:uzzal:c2hhZmlxMms1Cg==

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
        blkid
        lsblk



How to Run 
 ---
    chmod +x  deployment-tools/main.sh   
    cd deployment-tools
    main.sh 
    
    
 Tested
 ---
 Tested only CentOs 7