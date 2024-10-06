MAKEFLAGS += -j2

nginx-init: prod-nginx-link-common prod-nginx-link

STACK_NAME = n8n
COMPOSE_FILE = ./docker-swarm.yml

prod-start:
	docker stack deploy -c $(COMPOSE_FILE) $(STACK_NAME) --detach=true

prod-update: prod-start

prod-stop:
	docker stack stop $(STACK_NAME)  # Stops services without removing configuration.

prod-rm:
	docker stack rm $(STACK_NAME)  # Removes the stack and all associated resources.


prod-nginx-link-common:
	ln -s ${shell pwd}/nginx/common.conf /etc/nginx/sites-enabled/
	ln -s ${shell pwd}/nginx/proxy_common.conf /etc/nginx/sites-enabled/

prod-nginx-link:
	ln -s ${shell pwd}/nginx/automate.jsmx.org.conf /etc/nginx/sites-enabled/
	ln -s ${shell pwd}/nginx/automate.junox.net.conf /etc/nginx/sites-enabled/
	nginx -s reload
