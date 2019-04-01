workflow "build and push to dockerhub" {
  on = "push"
  resolves = ["login", "build", "push"]
}

action "login" {
  uses = "actions/docker/login@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  secrets=["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  env = {
    DOCKER_USERNAME = "DOCKER_USERNAME"
    DOCKER_PASSWORD = "DOCKER_PASSWORD"
  }
}

action "build" {
  uses = "actions/docker/cli@master"
  args = "build -t metrue/moodz:latest -f devops/dockerfile ."
}

action "push" {
  needs = ["build", "login"]
  secrets=["DOCKER_USERNAME", "DOCKER_PASSWORD"]
  uses = "actions/docker/cli@master"
  args = "push metrue/moodz:latest"
}
