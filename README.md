# gitlab
gitlab on AWS

## Following Sample from [link](https://docs.aws.amazon.com/codebuild/latest/userguide/sample-docker.html)

# Main Branch
* *Main* branch will always have `buildspec.yml` which can use to build alpine.
* Check [g2](https://ap-southeast-1.console.aws.amazon.com/codesuite/codebuild) to build image using above branch.

# Build badge from main branch
![badge](https://codebuild.ap-southeast-1.amazonaws.com/badges?uuid=eyJlbmNyeXB0ZWREYXRhIjoiN3NGSkFWUjFPZjE3NGZKK3o4U0J3WUhUNEdmSEZlQW94VmU5bm5yWDdCaVpaK0JEMjFjQU9nYXhYRlFhMGpXVTQyTTFPV2F2KzlMM1BQUWxYZFpENWVJPSIsIml2UGFyYW1ldGVyU3BlYyI6ImtBZTc0SlBtbG0xbEx4MkwiLCJtYXRlcmlhbFNldFNlcmlhbCI6MX0%3D&branch=main)

# Dev Branch
* *Dev* branch will always have `dev-buildspec.yml` which can use to build debian:12-slim.
* Check [gitlab-dev](https://ap-southeast-1.console.aws.amazon.com/codesuite/codebuild/) to build image using above branch.
