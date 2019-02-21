# $GOOGLE_CLOUD_PROJECT MUST BE SET
# NOT REQUIRED IF IN CLOUD SHELL
# gcloud config set project $GOOGLE_CLOUD_PROJECT
echo 'enabling apis'
gcloud services enable container.googleapis.com  
gcloud services enable vision.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
echo 'creating bucket and copying in default images'
gsutil mb -c multi_regional gs://$GOOGLE_CLOUD_PROJECT/
gsutil cp ../frontend/static/images/NoImage.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/NoImage.jpg
gsutil cp ../frontend/static/images/pending.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/pending.jpg
echo 'deploying cloud function'
cd ../cloud-function
gcloud functions deploy make_thumbnail --runtime python37 --trigger-resource $GOOGLE_CLOUD_PROJECT --trigger-event google.storage.object.finalize
echo 'using sed to update kubernetes configuration for this project'
cd ../backend
sed -i 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
cd ../frontend
sed -i 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' config.py
sed -i 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' main.py
sed -i 's/roi-hiplocal/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
sed -i 's/hiplocal.kwikstart.net/'"$MYDOMAIN"'/g' kubernetes-config.yaml
echo 'completed successfully'









