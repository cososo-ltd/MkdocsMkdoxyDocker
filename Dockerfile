# Documentation toolchain image for SolidSyslog (and other MkDocs + Doxygen docs).
# Doxygen extracts the API from C/C++ headers; mkdoxy renders that as native
# Material for MkDocs pages, so the API reference shares the site shell.
#
# Published as ghcr.io/cososo-ltd/mkdocs-mkdoxy — see docs/containers.md in the
# consuming repo for how it is pinned by sha-<short>.
FROM python:3.12-slim-bookworm

# doxygen: the API extractor (Debian bookworm ships 1.9.4). graphviz: dot graphs.
RUN apt-get update \
 && apt-get install -y --no-install-recommends doxygen graphviz \
 && rm -rf /var/lib/apt/lists/*

# Pinned so local and CI builds are identical. mkdocs-material pulls mkdocs;
# it is pinned explicitly for reproducibility.
RUN pip install --no-cache-dir \
      mkdocs==1.6.1 \
      mkdocs-material==9.7.6 \
      mkdoxy==1.2.8 \
      mkdocs-github-admonitions-plugin==0.1.1

WORKDIR /docs
