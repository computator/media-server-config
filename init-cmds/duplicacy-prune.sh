#!/bin/sh
exec echo 'No Direct Execution!'

head -n 1 | tr -d '\n' | podman secret create duplicacy_key -
podman run --rm -i \
	--secret duplicacy_key,type=env,target=DUPLICACY_PASSWORD \
	-v duplicacy_prune:/repo \
	-v /srv/media/files/duplicacy:/data \
	ghcr.io/computator/duplicacy \
	init -e maint_prune /data
