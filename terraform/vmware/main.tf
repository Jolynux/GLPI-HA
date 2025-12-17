terraform {
  required_providers {
    vsphere = {
      source = "vmware/vsphere"
      version = "~> 2.14.2"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  api_timeout          = 10
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
    for_each          = var.nodes
    name              = "${each.value["Name"]}"
    folder            = var.folder
    ressource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    datastore_id      = "${data.vsphere_datastore.datastore.id}"
    firmware          = "${data.vsphere_virtual_machine.template.firmware}"
    num_cpus          = "${each.value["cpu"]}"
    memory            = "${each.value["RAM"]}"
    guest_id          = "${data.vsphere_virtual_machine.template.guest_id}"
    network_interface {
        network_id     = "${data.vsphere_network.network.id}"
        mac_address    = "${each.value["mac_address"]}"
        use_static_mac = true
    }
    disk {
        label            = "disk0"
        size             = "${each.value["disk0"]}"
        eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
        thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
        unit_number      = 0
    }
    disk {
        label        = "disk1"
        size         = "${each.value["disk1"]}"
        unit_number  = 1
        datastore_id = "${data.vsphere_datastore.datastore.id}"
    }
    clone {
        template_uuid  = "${data.vsphere_virtual_machine.template.id}
        customize {
          linux_options {
            host_name = "${each.value["Name"]}"
            domain    = "${each.value["domain"]}"
          }
          network_interface {
            ipv4_address = "${each.value["IP"]}"
            ipv4_netmask = "${each.value["netmask"]}"
          }
          ipv4_gateway    = "${each.value["gateway"]}"
          dns_server_list = "${each.value["dns_server"]}"
        }
    }
}
