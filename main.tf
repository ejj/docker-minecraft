# Specify the provider and access details

locals {
    port   = 25565
    region = "us-west1-c"
}

provider "google" {
  credentials = file("~/.ejj_gcp_key.json")
  project     = "ray-minecraft"
  region      = local.region
}

resource "google_container_cluster" "primary" {
  name               = "minecraft"
  location           = local.region
  initial_node_count = 1
  logging_service = "none"
  monitoring_service = "none"

  cluster_autoscaling {
    enabled = false
  }

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = true
    }
  }

  node_config {
    preemptible = true
    machine_type = "e2-standard-2"
    disk_size_gb = 20
    metadata = {
       disable-legacy-endpoints = "true"
    }
  }
}
