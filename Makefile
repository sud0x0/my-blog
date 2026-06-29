# Build and run the container
.PHONY: run
run:
	podman build -t sud0x0_blog .
	podman run --rm -it -p 4000:4000 -p 35729:35729 -v $$(pwd):/app sud0x0_blog

# Delete the content that podman created in the main codebase
.PHONY: clean
clean: 
	podman image rm localhost/sud0x0_blog 
	rm -rf _site
	rm -f Gemfile.lock
	rm .jekyll-metadata
	rm -rf .jekyll-cache

# Make sure to add docker before make run. Tested in Ubuntu
# sudo vim /etc/containers/registries.conf
# unqualified-search-registries = ["docker.io"]