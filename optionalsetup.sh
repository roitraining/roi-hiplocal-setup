echo 'create k8s cluster'
gcloud container clusters create cluster-demo --zone us-central1-a --machine-type "g1-small" --num-nodes "3" --scopes cloud-platform
echo 'deploying appengine default service'
cd ../frontend
yes Y | gcloud app deploy
echo 'deploying appengine backend service'
cd ../backend
yes Y | gcloud app deploy
echo 'building backend container'
gcloud builds submit -t gcr.io/$GOOGLE_CLOUD_PROJECT/api:v0.1 .
cd ../frontend
echo 'building frontend container'
gcloud builds submit -t gcr.io/$GOOGLE_CLOUD_PROJECT/ui:v0.1 .
echo 'deploying to k8s'
gcloud container clusters get-credentials cluster-demo --zone us-central1-a --project $GOOGLE_CLOUD_PROJECT
kubectl create -f kubernetes-config.yaml
cd ../backend
kubectl create -f kubernetes-config.yaml

