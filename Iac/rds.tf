# Creating a RDS
resource "aws_db_instance" "default" {
allocated_storage = 20
identifier = "task11-rds-instance"
storage_type = "gp2"
engine = "mysql"
engine_version = "5.7"
instance_class = "db.t2.micro"
name = "task11"
multi_az = true
username = "admin"
password = "Qwerty1234"
parameter_group_name = "default.mysql5.7"
skip_final_snapshot = true
}
# Creating a subnet group for RDS
resource "aws_db_subnet_group" "db-subnet" {
name = "db subnet group"
subnet_ids = ["${element(module.vpc.private_subnets, 0)}", "${element(module.vpc.private_subnets, 1)}"]
}