# Documentation toolchain image for SolidSyslog (and other MkDocs + Doxygen docs).
# Doxygen extracts the API from C/C++ headers; mkdoxy renders that as native
# Material for MkDocs pages, so the API reference shares the site shell.
#
# Published as ghcr.io/cososo-ltd/mkdocs-mkdoxy — see docs/containers.md in the
# consuming repo for how it is pinned by sha-<short>.
FROM python:3.12-slim-trixie@sha256:5e2bdb1b0d542d5039cffb8181c65930093949194a65c365dfb1b0fe13a4fa5b

# doxygen: the API extractor (Debian trixie ships 1.9.8). graphviz: dot graphs.
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
