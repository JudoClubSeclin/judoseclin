#!make

.PHONY: stop
stop:
	docker compose -p judoseclin down
	docker image prune --all -f
	docker volume prune --all -f
	docker network prune -f
	docker builder prune --all -f

.PHONY: start
start:
	docker compose -p judoseclin up -d --build

.PHONY: restart
restart:
	docker compose -p judoseclin down
	docker volume prune --all -f
	docker network prune -f
	docker compose -p judoseclin up -d --build

.PHONY: create
create:
	@cd features && flutter create $(firstword $(filter-out $@,$(MAKECMDGOALS))) --template=package


.PHONY: test
test:
	@echo "Get dependencies..."
	@flutter pub get
	@echo "Upgrade dependencies..."
	@flutter pub upgrade --tighten --major-versions
	@echo "Generate code..."
	@dart run build_runner build --delete-conflicting-outputs
	@{ \
  		errors=""; \
		echo "Analyze entire Flutter codebase..."; \
		( dart analyze --no-fatal-warnings ) || errors="$$errors\n- flutter analyze"; \
		echo "Run tests on website..."; \
		( cd app && dart run build_runner build --delete-conflicting-outputs && flutter test --coverage --no-pub ) || errors="$$errors\n- application"; \
		dirs=$$(find features -mindepth 1 -maxdepth 1 -type d); \
		for d in $$dirs; do \
			if [ -d "$$d/test" ]; then \
				echo "Run tests on feature $$d..."; \
				( cd "$$d" && dart run build_runner build --delete-conflicting-outputs &&flutter test --coverage --no-pub ) || errors="$$errors\n- tests $$d"; \
			fi; \
		done; \
		if [ "$$errors" = "" ]; then \
			echo ""; \
			echo "All tests passed ✅"; \
		else \
			echo ""; \
			echo "======================"; \
			echo "❌ Tests failed in:"; \
			echo "    $$errors"; \
			echo "======================"; \
			exit 1; \
		fi; \
	}
