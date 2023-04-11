output "instance_ip_address" {
  value = google_compute_address.public_ip.address
}
