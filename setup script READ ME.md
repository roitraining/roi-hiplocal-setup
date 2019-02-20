# Instructions for running the setup script...
# NB Read the whole doc. There are manual steps that must be completed 
# before and after running the script. 

1. Create a new project
2. Use the cloud console to create an empty Firestore database
3. Open a cloud shell window in the project
4. Run the following commands to create a hip directory and move into it

mkdir hip
cd hip

5. clone the frontend, backend and cloudfunction and setup repos
6. run the following commands to move into the directory and run the script

cd setup
./setup.sh

7. ADDITIONAL NECESSARY STEPS
    1. Setup a DNS entry for hiplocal.yourdomain.whatever using the hip-local static ip created by the script
    2. Setup a firebase project for your project
    3. Enable Google login in the authentication section
    4. Add your domain to the list of authorized domains
    5. Copy the web setup config from firebase and paste over the config in
    frontend/templates/layout.  (it is at the end of the head section)
    6. modify frontend/kubernetes-config.yaml to reference your domain as the host

FINALLY:
# commented script for all these operations is available at the end of setup.sh
# commented because a) you probably want to demo this stuff, no autcomplete
# and b) you must do the additional steps above first for the site to work
- create the cluster
- build your docker containers
- deploy to cluster
- optionally deploy to appengine as well


