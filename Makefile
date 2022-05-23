CURRENT_UID := $(shell id -u)

test:
	pytest test.py

bench:
	mkdir -p ./bench_memory/
	mkdir -p ./bench_cpu/
	python bench_battery.py

results.csv:
	python benchmark_digest.py

format:
	black h3_tools bench.py bench_battery.py benchmark_digest.py test.py -l 119 -t py310

flowchart:
	docker run --rm -u ${CURRENT_UID} -it -v ${PWD}/docs:/data minlag/mermaid-cli -i /data/flow-chart.mmd
