TAG = 1.0.0-0
PREFIX = bismarck

all: image

code:
	glide install
	go install .

builder-image:
	docker build -f images/builder/Dockerfile -t builder .

build-in-docker: builder-image
	docker run -it -v `pwd`:/src builder /onbuild.sh

image: build-in-docker
	docker build -t $(PREFIX)/aws-es-proxy:$(TAG)  -f images/aws-es-proxy/Dockerfile .

push: image
	docker push $(PREFIX)/aws-es-proxy:$(TAG)
