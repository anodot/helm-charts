HELM:=helm

build-charts:
	$(HELM) init --client-only
	$(HELM) version --client
	@$(HELM) plugin install https://github.com/instrumenta/helm-kubeval || echo "Skipping error..."
	HELM=$(HELM) ./kubeval.sh
	$(HELM) lint charts/*
	$(HELM) package charts/*
	$(HELM) repo index --url https://anodot.github.io/helm-charts/ --merge index.yaml .