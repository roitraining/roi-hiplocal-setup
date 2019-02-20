# $GOOGLE_CLOUD_PROJECT MUST BE SET
# NOT REQUIRED IF IN CLOUD SHELL
# gcloud config set project $GOOGLE_CLOUD_PROJECT
gcloud services enable container.googleapis.com  
gcloud services enable vision.googleapis.com
gcloud services enable cloudfunctions.googleapis.com
gsutil mb -c multi_regional gs://$GOOGLE_CLOUD_PROJECT/
gsutil cp ../frontend/static/images/NoImage.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/NoImage.jpg
gsutil cp ../frontend/static/images/pending.jpg gs://$GOOGLE_CLOUD_PROJECT/
gsutil acl ch -u AllUsers:R gs://$GOOGLE_CLOUD_PROJECT/pending.jpg
cd ../cloud-function
gcloud functions deploy make_thumbnail --runtime python37 --trigger-resource $GOOGLE_CLOUD_PROJECT --trigger-event google.storage.object.finalize
gcloud compute addresses create hip-local --global
#version for mac
# cd ../backend
# sed -i '' 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
# cd ../frontend
# sed -i '' 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' config.py
# sed -i '' 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' main.py
# sed -i '' 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
#version for cloud shell
cd ../backend
sed -i 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
cd ../frontend
sed -i 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' config.py
sed -i 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' main.py
sed -i 's/roi-hip-local/'"$GOOGLE_CLOUD_PROJECT"'/g' kubernetes-config.yaml
# OPTIONAL - create k8s cluster
# OPTIONAL - deploys the app engine version
# OPTIONAL - build and deploy the kubernetes engine app
# OPTIONAL - deploy the kubernetes engine app
# gcloud container clusters create cluster-demo --zone us-central1-a --machine-type "g1-small" --num-nodes "3" --scopes cloud-platform
# yes Y | gcloud app deploy
# cd ../backend
# yes Y | gcloud app deploy
# gcloud builds submit -t gcr.io/$GOOGLE_CLOUD_PROJECT/ui:v0.1 .
# cd ../backend
# gcloud builds submit -t gcr.io/$GOOGLE_CLOUD_PROJECT/api:v0.1 .
# gcloud container clusters get-credentials cluster-demo --zone us-central1-a --project $GOOGLE_CLOUD_PROJECT
# kubectl create -f kubernetes-config.yaml
# cd ../backend
# kubectl create -f kubernetes-config.yaml







