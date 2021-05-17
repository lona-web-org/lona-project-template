SHELL=/bin/bash
PYTHON=python3
PYTHON_ENV=env

HOST=localhost
PORT=8080
LOG_LEVEL=info
SHELL_SERVER_URL=file://socket

.PHONY: clean freeze shell server shell-server

# environment #################################################################
$(PYTHON_ENV)/.created: REQUIREMENTS.txt
	rm -rf $(PYTHON_DEV) && \
	$(PYTHON) -m venv $(PYTHON_ENV) && \
	. $(PYTHON_ENV)/bin/activate && \
	pip install pip --upgrade && \
	pip install -r ./REQUIREMENTS.txt && \
	date > $(PYTHON_ENV)/.created

env: $(PYTHON_ENV)/.created

clean:
	rm -rf $(PYTHON_ENV)

freeze: env
	. $(PYTHON_ENV)/bin/activate && \
	pip freeze

shell: env
	. $(PYTHON_ENV)/bin/activate && \
	rlpython

# lona ########################################################################
server: env
	. $(PYTHON_ENV)/bin/activate && \
	lona run-server \
		--project-root=lona_project \
		-s settings.py \
		--host $(HOST) \
		--port $(PORT) \
		--log-level=$(LOG_LEVEL) \
		--shell-server-url=$(SHELL_SERVER_URL) \
		$(args)

server-shell: env
	. $(PYTHON_ENV)/bin/activate && \
	rlpython $(SHELL_SERVER_URL) $(args)
