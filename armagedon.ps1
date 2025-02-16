$containers = docker ps --all --quiet
foreach ($container in $containers) {
    docker stop $container
    docker rm $container
}
