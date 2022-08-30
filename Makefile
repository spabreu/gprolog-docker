IMAGES=$(shell ls -1 */Dockerfile | sed -e s:/Dockerfile::)
#COPY=sim2c_2.0-1_all.deb

CODE=code
WORKDIR=/root/$(CODE)
HUBU=rodalvas
# TAG=$(shell arch)
TAG=latest

all: $(IMAGES)

.PHONY: $(IMAGES)

gprolog:
	docker build $@ --tag $@:$(TAG)
	docker tag $@:$(TAG) $(HUBU)/$@:$(TAG)

gprolog-cx: gprolog
	docker build $@ --tag $@:$(TAG)
	docker tag $@:$(TAG) $(HUBU)/$@:$(TAG)

publish: $(IMAGES)
	for IMAGE in $(IMAGES); do		\
	  docker image push $(HUBU)/$$IMAGE:$(TAG);	\
	done

# sim2c: 
# 	cp $(COPY) data/sim2c.deb
# 	scp data/sim2c.deb host.di.uevora.pt:public_html/
# 	docker build $@ --tag $@:latest
# 	docker tag $@:latest $(HUBU)/$@:latest


run-%::
	docker run -ti \
		-v $(PWD)/$(CODE):$(WORKDIR) \
		$(subst run-,,$@):$(TAG) \
			$(CMD)

# logtalk.deb::
# 	[ -e $(LGTDEB) ] || wget -q https://logtalk.org/files/$(LGTDEB)
# 	ln -sf $(LGTDEB) logtalk.deb

clean:
	docker container prune -f
	docker image prune -f
	docker image rm -f $(IMAGES)
