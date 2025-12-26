resource "aws_instance" "example" {
  connection {
    type = "ssh"
    host = "192.168.50.15"
    private_key = ".vagrant/machines/default/private_key"
  }
}
