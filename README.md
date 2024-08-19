# gitlab
gitlab on AWS

## Following Sample from [link](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)

# Main Branch
* *Main* branch will always have `buildspec.yml` which can use to build alpine.
* Check [g2](https://ap-southeast-1.console.aws.amazon.com/codesuite/codebuild) to build image using above branch.

# Dev Branch
* *Dev* branch will always have `dev-buildspec.yml` which can use to build debian:12-slim.
* Check [gitlab-dev](https://ap-southeast-1.console.aws.amazon.com/codesuite/codebuild/) to build image using above branch.
