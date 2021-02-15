terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
}

variable "do_token" {}

variable "world" {
  type = string
}

provider "digitalocean" {
    token = var.do_token
}


resource "digitalocean_droplet" "mc" {
    image = "78211853"
    name = var.world
    region = "sfo3"
    size = "g-2vcpu-8gb"
    ssh_keys = [ "8d:5b:c2:34:72:42:71:67:54:8e:69:4f:e0:d1:79:50" ]
    user_data = <<EOF
#!/bin/bash
mkdir -p /mnt/worlds

#  Mount your volume at the newly-created mount point:
mount -o discard,defaults,noatime /dev/disk/by-id/scsi-0DO_Volume_worlds /mnt/worlds

# Change fstab so the volume will be mounted after a reboot
echo '/dev/disk/by-id/scsi-0DO_Volume_worlds /mnt/worlds ext4 defaults,nofail,discard 0 0' | sudo tee -a /etc/fstab

/root/do-start.sh
EOF
}

resource "digitalocean_floating_ip_assignment" "mc" {
  droplet_id = digitalocean_droplet.mc.id
  ip_address = "64.225.90.204"
}

resource "digitalocean_volume_attachment" "foobar" {
  droplet_id = digitalocean_droplet.mc.id
  volume_id  = "13697785-67fd-11eb-82f8-0a58ac120185"
}
