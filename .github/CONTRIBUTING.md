# Contributing

First of all, thanks for your interest in contributing to the cyclecheck-api-docker! 🎉

PRs are the preferred way to spike ideas and address issues, if you have time. If you plan on contributing frequently, please feel free to ask to become a maintainer; the more the merrier. 🤙

#### Commit conventions (via commitizen)

- this is preferred way how to create conventional-changelog valid commits
- if you prefer your custom tool we provide a commit hook linter which will error out, it you provide invalid commit message
- if you are in rush and just wanna skip commit message validation just prefix your message with `WIP: something done` ( if you do this please squash your work when you're done with proper commit message so semantic-release can create Changelog and bump version of your library appropriately )

```sh
# invoke commitizen CLI
yarn commit
```

## Getting started

You will need to install Docker on your system.

### Creating a Pull Request

If you've never submitted a Pull request before please visit http://makeapullrequest.com/ to learn everything you need to know.

#### Setup

1.  Fork the repo.
1.  `git clone` your fork.
1.  Make a `git checkout -b branch-name` branch for your change.
1.  Run `yarn install --ignore-scripts` (make sure you have node and yarn installed first)
1.  When your work is done run `yarn build`.
1.  Commit changes.

---

## 🚀 Publishing

> releases are handled by awesome [semantic-release](https://github.com/semantic-release/semantic-release)

Whenever a commit is pushed to the `master` branch, the CI server will validate the commit, then run `semantic-release`.

If `semantic-release` decides that the commit is worthy of a new release it will:

- bump package version and git tag
- push to github master branch + push tags
- Docker Hub will then build the new image

## License

By contributing your code to the cyclecheck-api-docker GitHub Repository, you agree to license your contribution under the MIT license.
