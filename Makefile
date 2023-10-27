SHELL := /bin/bash -i # Bourne-Again SHell command-line interpreter on Linux.
PYTHON_VERSION := 3.6.1
PYTHON := python$(PYTHON_VERSION)

### 

# Hack for displaying help message in Makefile
help: 
	@grep -E '(^[0-9a-zA-Z_-]+:.*?##.*$$)' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'

###

conda-build-gpu: ## Create Python environement with conda for GPU.
conda-build-gpu:
	-( \
	test -f ~/activate/miniconda3 && . ~/activate/miniconda3 || true \
	&& conda env list | grep '^SUNSET\s' > /dev/null  \
	|| conda env create -f environment.yml -y \
	&& conda activate SUNSET \
	&& pip install -U pip \
	&& pip install -r requirements.txt \
	)

conda-clean-gpu: ## Clean Python environement with conda for GPU.
conda-clean-gpu:
	-(\
	test -f ~/activate/miniconda3 && . ~/activate/miniconda3 || true \
	&& conda env remove --name SUNSET \
	)

conda-test-gpu: ## Clean Python environement with conda for GPU.
conda-test-gpu:
	-(\
	test -f ~/activate/miniconda3 && . ~/activate/miniconda3 || true \
	&& conda activate SUNSET \
	&& python -c "import paddle; paddle.utils.run_check()" \
	)

