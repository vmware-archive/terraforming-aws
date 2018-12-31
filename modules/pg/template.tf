provider "postgresql" {
  host     = "${var.db_address}"
  port     = "${var.db_port}"
  username = "${var.db_username}"
  password = "${var.db_password}"
}

resource "postgresql_database" "my_db1" {
  provider = "postgresql"
  name     = "my_db1"
}
