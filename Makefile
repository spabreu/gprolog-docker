IMAGES=$(shell ls -1 */Dockerfile | sed -e s:/Dockerfile::)
#COPY=sim2c_2.0-1_all.deb

DATA=data
WORKDIR=/root/code
HUBU=rodalvas

all: $(IMAGES)

.PHONY: $(IMAGES)

gprolog:
	docker build $@ --tag $@:latest
	docker tag $@:latest $(HUBU)/$@:latest

gprolog-cx:
	docker build $@ --tag $@:latest
	docker tag $@:latest $(HUBU)/$@:latest

publish: $(IMAGES)
	for IMAGE in $(IMAGES); do		\
	  docker image push $(HUBU)/$$IMAGE;	\
	done

# sim2c: 
# 	cp $(COPY) data/sim2c.deb
# 	scp data/sim2c.deb host.di.uevora.pt:public_html/
# 	docker build $@ --tag $@:latest
# 	docker tag $@:latest $(HUBU)/$@:latest


run-%::
	docker run -ti \
		-v $(PWD)/$(DATA):$(WORKDIR)/$(DATA) \
		$(subst run-,,$@):latest

# logtalk.deb::
# 	[ -e $(LGTDEB) ] || wget -q https://logtalk.org/files/$(LGTDEB)
# 	ln -sf $(LGTDEB) logtalk.deb

clean:
	rm -f $(DATA)/*
	docker container prune -f
	docker image prune -f
	docker image rm -f $(IMAGES)
