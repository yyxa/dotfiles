[openshell]
version = 2

[openshell.gateway]
compute_driver = "docker"

[openshell.drivers.docker]
default_image     = "${UBUNTU_IMAGE}"
image_pull_policy = "if_not_present"
host_gateway_ip   = "172.17.0.1"