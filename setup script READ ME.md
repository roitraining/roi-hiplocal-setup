# Instructions for running the setup script...
# NB Read the whole doc. There are manual steps that must be completed 
# before and after running the script.

# Prerequisites:
1. Must have a domain you control where you can add DNS entries
    (this is required for authentication using firebase)
2. Must have ability to create GCP projects

# Instructions

1. Create a new project
2. Use the cloud console to create an empty Firestore database
3. Run the following command in cloud shell in your new project to create 
    a static ip  hip-local:

    gcloud compute addresses create hip-local --global
    
4. Setup a DNS entry for hiplocal.yourdomain.ext pointing at the hip-local static ip 
   created by the command
5. Return to cloud shell window and run the following commands to create a hip directory and move into it

mkdir hip
cd hip

6. clone the frontend, backend and cloudfunction and setup repos from roi-hiplocal

gcloud source repos clone backend --project=roi-hiplocal
gcloud source repos clone frontend --project=roi-hiplocal
gcloud source repos clone cloud-function --project=roi-hiplocal
gcloud source repos clone setup --project=roi-hiplocal

7. Setup a firebase project for your new project
8. Enable Google login in the authentication section
9. Add your new domain and the appspot.com appengine domain from your new project to 
   the list of authorized domains 
10. Copy the web setup config from firebase 
11. Paste the config over the matching section in: frontend/templates/layout.html
    (It is at the end of the head section)
12. export a variable to hold your new domain name created at step 4

export MYDOMAIN=<hiplocal.yourdomain.ext>

13. Move into the setup directory and run the following commands to run the setup script

chmod +x setup.sh
./setup.sh

14. FINALLY:
- create the cluster
- build your docker containers
- deploy to cluster
- optionally deploy to appengine as well
# you probably want to demo all these steps, but if not, 
# they are all done inside the optionalsetup.sh script


