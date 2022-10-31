source "vmware-iso" "debian-bullseye" {
  headless = true
  iso_url = "https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-11.3.0-arm64-netinst.iso"
  iso_checksum = "sha512:2b6a6ca123b6b53436966ac99a3115cc7f11e30d48032c6f86b33f1075682756ea8dc1aa5919dd5956bfb38c427be1162bea69bf9492afae0c1eebedd03ae2fa"
  ssh_username = "vagrant"
  ssh_password = "vagrant"
  ssh_timeout = "30m"
  shutdown_command = "sudo shutdown -h now"
  guest_os_type = "arm-debian11-64"
  disk_adapter_type = "nvme"
  version = 19
  http_directory = "http"
  boot_command = [
        "c",
        "linux /install.a64/vmlinuz auto=true priority=critical url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
        "<enter>",
        "initrd /install.a64/initrd.gz",
        "<enter>",
        "boot",
        "<enter><wait>"
  ]
  usb = true
  vmx_data = {
    "usb_xhci.present" = "true"
  }
  memory = 2048
  cpus = 2
  disk_size = 40000
  vm_name = "Debian_11"
  output_directory = "output"
}

build {
  sources = ["sources.vmware-iso.debian-bullseye"]

  provisioner "shell" {
    scripts = [
      "add-key.sh",
      "vmware-cleanup.sh"
    ]
  }
}
