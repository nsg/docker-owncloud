IMAGE = nsgb/owncloud
TAG = 8.0.4

build:
	docker build -t ${IMAGE}:${TAG} .
	docker build -t ${IMAGE}:latest .

run: build
	docker run -ti \
		-p 8080:80 \
		${IMAGE}:${TAG}

push: build
	docker push ${IMAGE}:${TAG}
	docker push ${IMAGE}:latest
