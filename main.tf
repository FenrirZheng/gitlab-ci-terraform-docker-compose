
resource "null_resource" "docker_compose_app" {
  triggers = {
    # This trigger ensures that the docker-compose command is re-run
    # whenever the docker-compose.yml file changes.
    docker_compose_hash = filemd5("docker-compose.yml")
  }


  provisioner "local-exec" {
    command = "/usr/bin/docker compose up -d"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "/usr/bin/docker compose down"
  }
}
