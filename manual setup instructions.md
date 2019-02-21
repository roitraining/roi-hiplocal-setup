# instructions for setting up in a new project.

# preconditions:
1. python3 and GCP SDK installed in your environment
2. Firestore enabled and database created in your project
3. $GOOGLE_CLOUD_PROJECT has been set in terminal/shell to reference the project you will be running in

# 1. set project
gcloud config set project $GOOGLE_CLOUD_PROJECT

# 2. enable kubernetes, vision, cloud function apis 

gcloud services enable container.googleapis.com  
gcloud services enable vision.googleapis.com
gcloud services enable cloudfunctions.googleapis.com

# 3. create bucket with same name as project

gsutil mb -c multi_regional gs://$GOOGLE_CLOUD_PROJECT/

# 4. copy images to bucket and make public
gsutil cp NoImage.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/NoImage.jpg
gsutil cp pending.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/pending.jpg

# 5 deploy the cloud function
cd /path/to/cloud-function/folder
gcloud functions deploy make_thumbnail --runtime python37 --trigger-resource $GOOGLE_CLOUD_PROJECT --trigger-event google.storage.object.finalize

# 6 reserve a static ip for domain - needed for firebase authentication
gcloud compute addresses create hip-local --global

# 7. replace all project names in source code with your project id
# e.g for mac - may need adjustment elsewhere
cd /path/to/frontend/folder
sed -i '' 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' config.py
sed -i '' 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' main.py
cd /path/to/backend/folder
sed -i '' 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml

# 8. manual steps:
1. Setup a DNS entry for hiplocal.yourdomain.whatever using your hip-local static ip
2. Setup a firebase project for your project, $GOOGLE_CLOUD_PROJECT
3. Enable Google login
4. Add your domain to the list of authorized domains
5. Copy the web setup config and paste over the config in frontend/templates/layout
    (it is at the end of the head section)
6. modify frontend kubernetes-config.yaml to reference your domain
FINALLY:
- build your docker containers
- create your k9s cluster
- deploy to cluster
- optionally deploy to appengine as well