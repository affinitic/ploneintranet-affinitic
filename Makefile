up:
	docker-compose up

clone:
	if ! [ -d "./src/affinitic.ploneintranet" ]; then \
		git clone git@github.com:affinitic/affinitic.ploneintranet.git src/affinitic.ploneintranet; \
	fi

debug: clone
	docker-compose -f docker-compose-debug.yml up

start:
	docker-compose start

stop:
	docker-compose stop
