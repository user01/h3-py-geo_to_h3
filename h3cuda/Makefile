test:
	pytest -lsvvv -k "few_simple" test.py
	pytest -lsvvv test.py

wheel:
	python setup.py bdist_wheel

install:
	python setup.py install

format:
	clang-format -i src/kernel.cu
	clang-format -i src/manager.cu
	clang-format -i src/manager.hh
	python -m black -l 119 -t py38 .

lint:
	python -m flake8 .

clean:
	pip uninstall -y h3cuda
	rm -rf build/ dist/ __pycache__

all: clean format lint install test
	@echo Complete
