docker buildx build --platform linux/amd64 --load --tag kurtyoon/teatime-server:0.0.1 ./teatime-server
docker buildx build --platform linux/amd64 --load --tag kurtyoon/teatime-gateway:0.0.1 ./teatime-gateway
docker buildx build --platform linux/amd64 --load --tag kurtyoon/teatime-api:0.0.1 ./teatime-api
docker buildx build --platform linux/amd64 --load --tag kurtyoon/teatime-external:0.0.1 ./teatime-external
docker buildx build --platform linux/amd64 --load --tag kurtyoon/teatime-model:0.0.1 ./teatime-model

docker push kurtyoon/teatime-server:0.0.1
docker push kurtyoon/teatime-gateway:0.0.1
docker push kurtyoon/teatime-api:0.0.1
docker push kurtyoon/teatime-external:0.0.1
docker push kurtyoon/teatime-model:0.0.1