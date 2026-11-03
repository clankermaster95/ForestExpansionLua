.PHONY: build test verify-port test-original bootstrap export-data
build:
	python3 tools/project.py build
test:
	python3 tests/refactor.py
	python3 tests/workflow.py
verify-port:
	python3 tests/layout_baseline.py
test-original:
	python3 tools/prepare_tests.py
	python3 tests/verify.py --baseline
bootstrap:
	python3 tools/bootstrap.py
export-data:
	python3 tools/project.py export-data
