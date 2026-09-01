# 1. Project pages render READMEs from their source repositories

Date: 2026-09-01

## Status

Accepted

## Context

The portfolio website exists to demonstrate infrastructure engineering
capability to prospective employers. Project pages are the primary evidence.

Writing project descriptions directly into the portfolio site creates a
synchronization problem. The same project is then documented in two places:
the README in its own repository, which developers read when they clone it,
and the portfolio page, which visitors read. These two documents describe the
same work, are maintained by hand, and will diverge. In practice the portfolio
copy goes stale first, because the repository is where the work actually
happens.

A portfolio that advertises infrastructure engineering while containing a
manual synchronization problem undercuts its own argument.

## Decision

Project pages render the README from the project's own repository, fetched at
build time. The README in the source repository is the single source of truth
for that project's description.

The portfolio site owns presentation. It does not own project content.

This decision applies only to projects. Blog posts have no corresponding
repository and remain native Jekyll content.

## Consequences

### Intended

Project documentation is written once. The page a visitor reads is provably
the same document a developer sees when cloning the repository, because it is
that document.

Every project page requires a real, cloneable repository behind it. A project
cannot be listed unless the code exists. This is a deliberate quality
constraint: it makes it structurally impossible to publish an
impressive-sounding project with nothing to inspect.

The build pipeline that performs the fetch and render is itself demonstrable
infrastructure work, and is legitimate portfolio material.

### Costs accepted

The build now depends on external repositories. A rename, a visibility change,
or a deletion breaks the build. The pipeline must fail loudly and clearly when
a source is unreachable.

Relative paths inside a fetched README — images, links to sibling files — do
not resolve once the document is rendered on a different domain. These must be
rewritten at build time.

Build time increases with each project fetched.

Formatting control is reduced. READMEs must be written with awareness that
they render in two contexts.

### Boundary

A write-up with no code behind it is not a project. It is a blog post and
belongs in `_posts`.

## Alternatives considered

**Duplicate content by hand.** Rejected. This is the synchronization problem
the decision exists to eliminate.

**Link out to the repository instead of rendering.** Lower cost, but pushes
visitors off the site at the exact moment they are evaluating the work.
Rejected as a default; individual pages may still link out for depth.

**Git submodules rather than a build-time fetch.** Viable and possibly
simpler for a small number of projects. Deferred: the choice of fetch
mechanism is an implementation detail and does not need to be settled here.

## Notes

This site builds via GitHub Actions rather than the default GitHub Pages
build, so it is not restricted to the GitHub Pages plugin allowlist. Custom
plugins, submodules, and arbitrary build steps are all available.
