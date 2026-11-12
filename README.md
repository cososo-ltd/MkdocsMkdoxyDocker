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
| Base | `python:3.12-slim-trixie`, pinned by digest |
| Doxygen | 1.9.8 (Debian trixie) |
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
A pull request builds the image without pushing it. Consuming repos pin the
`sha-<short>` tag; bump it there when this image changes.

## Keeping the pins current

[Renovate](https://docs.renovatebot.com/), installed on the organisation as
the Mend GitHub App, opens a pull request when the digest the `FROM` line pins
`python:3.12-slim-trixie` at moves, and for the SHA-pinned actions in the
workflow. `renovate.json` holds the configuration. Nothing merges itself: the
pull request build proves the image builds, not that the site still does, so
each one is merged by hand. A new Python minor in the tag waits on the
Dependency Dashboard until ticked.
