.PHONY: all
all: build

# Build slide PDF.
.PHONY: build
build: slide.pdf

slide.pdf: slide.saty
	docker run \
		--rm \
		--name satysfi \
		--mount type=bind,src=$$(pwd),dst=/work \
		satysfi \
		sh -c "satysfi slide.saty && chown "$$(id -u):$$(id -g)" slide.pdf slide.satysfi-aux"

# Enter Docker shell.
.PHONY: shell
shell:
	docker run \
		-it \
		--rm \
		--name satysfi \
		--mount type=bind,src=$$(pwd),dst=/work \
		satysfi \
		sh

# Build Docker container.
.PHONY: docker
docker:
	docker build --tag satysfi .

# Clean all artifacts.
.PHONY: clean
clean:
	rm -f *.pdf *.satysfi-aux
