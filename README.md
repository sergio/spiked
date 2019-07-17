1. Build:

    > chmod +x build.sh
    > ./build.sh
    
2. Start vagrant machine:

    > vagrant up && vagrant ssh

3. Install service:

    vagrant@vagrant: cd /deploy
    vagrant@vagrant: sudo chmod +x install.sh
    vagrant@vagrant: sudo ./install.sh

4. Test service

    vagrant@vagrant: curl localhost:8080/hello

5. Deploy new version

    > ./build.sh
    > vagrant ssh
    vagrant@vagrant: cd /deploy
    vagrant@vagrant: sudo ./install.sh

6. See logs

    vagrant@vagrant: cat /var/log/spiked.log
