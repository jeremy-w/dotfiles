## Standards
- Changes and their tests belong in the same commit
- Commits should be small and focused to support understanding the associated
  diffs; the commit history should tell a clear story
- Check the VCS system in use, and use the user's preferred one; in order:
  - Jujutsu (`jj`): If `jj status` succeeds, you're in a Jujutsu repo.
  - Sapling (`sl`)
  - Git (`git`)
- When testing, do not mock UI components.

## Workflow
Between steps in a plan, `jj commit`, rather than making me manually tease
apart changes later. Do this even if the repo instructions say not to `git
commit`. This isn't `git`; this is `jj`: The "commit" ship has already sailed!
I'll conduct review before PRing changes.

## Tools
You have access to `rg` and `fd` for quick searching.

The user's preferred shell is `fish` and preferred VCS is `jj`. Expect to find
most repos being colocated git & jj repos.

## Commit Messages
Ensure the commit has a body. Be concise; either short paragraphs, or
a sequence of short bullets, where appropriate.
When there's a detectable change in behavior, begin with a "Before, ..." graf,
followed by a "Now, ..." graf. If fixing a lint, warning, or error, include the
output for the lint, trimming path components above the repo root to make the
logs more concise and avoid leaking local environment config.

## Jujutsu
Jujutsu differs from git in that you are always working in the context of
a current commit, which is regularly snapshotted. Manipulating commits is far
simpler than with git, and conflicts are non-blocking.

The biggest differences that impact work:

- **There is no staging area.** Everything is already committed. Usual practice
  is to work in a new commit to make changes. If they're all one batch, commit
  (combines describe + new). If they belong with existing work, absorb or
  selectively squash. If part of it makes sense as a new parent commit, then
  split.
- **There are no commit hooks.** You'll have to ensure you've run
  `pre-commit` yourself. (There's support for fixing commits by piping content
  through filters to format/lint, but many checks have a hard assumption that
  the entire working copy is consistent with a single commit, so they don't
  work with this.)
