vsphere_server = ""
vsphere_user = ""
vsphere_password = ""
datacenter = ""
datastore = ""
cluster = ""
network = ""
template = ""
folder = ""

nodes = {
  GLPI-NODE-1 = {
    Name = "GLPI-NODE-1"
    IP = "192.168.1.10"
    netmask = "24"
    gateway = "192.168.1.1"
    dns_server = ["192.168.1.1", "1.1.1.1"]
    domain = "myhomelab.local"
    mac_address = "00:50:56:96:e6:ed"
    cpu = 4
    RAM = 8192
    disk0 = 40
    disk1 = 100
  }
  GLPI-NODE-2 = {
    Name = "GLPI-NODE-2"
    IP = "192.168.1.11"
    netmask = "24"
    gateway = "192.168.1.1"
    dns_server = ["192.168.1.1", "1.1.1.1"]
    domain = "myhomelab.local"
    mac_address = "00:50:56:96:e6:ee"
    cpu = 4
    RAM = 8192
    disk0 = 40
    disk1 = 100
  }
  GLPI-NODE-3 = {
    Name = "GLPI-NODE-3"
    IP = "192.168.1.12"
    netmask = "24"
    gateway = "192.168.1.1"
    dns_server = ["192.168.1.1", "1.1.1.1"]
    domain = "myhomelab.local"
    mac_address = "00:50:56:96:e6:ef"
    cpu = 4
    RAM = 8192
    disk0 = 40
    disk1 = 100
  }
  
