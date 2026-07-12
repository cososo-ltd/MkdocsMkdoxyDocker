# MkdocsMkdoxyDocker

Documentation toolchain image for building the [SolidSyslog](https://github.com/cososo-ltd/solid-syslog)
documentation site (and any other MkDocs + Doxygen docs). Published as
**`ghcr.io/cososo-ltd/mkdocs-mkdoxy`**.

Doxygen extracts the API from C/C++ headers; [mkdoxy](https://github.com/JakubAndrysek/mkdoxy)
renders that as native [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
pages, so the API reference shares the site shell instead of dated Doxygen HTML.

## Contents

| Tool | Version |
|---|---|
| Base | `python:3.12-slim-bookworm` |
| Doxygen | 1.9.4 (Debian bookworm) |
| MkDocs | 1.6.1 |
| Material for MkDocs | 9.7.6 |
| mkdoxy | 1.2.8 |
| mkdocs-github-admonitions-plugin | 0.1.1 |

## Usage

Mount the docs repo at `/docs` and run MkDocs:

```bash
docker run --rm -v "$PWD:/docs" ghcr.io/cososo-ltd/mkdocs-mkdoxy \
  mkdocs build --strict
```

## Publishing

A push to `main` builds and pushes `ghcr.io/cososo-ltd/mkdocs-mkdoxy` at both
`sha-<short>` and `latest` (see [`.github/workflows/build.yml`](.github/workflows/build.yml)).
Consuming repos pin the `sha-<short>` tag; bump it there when this image changes.
