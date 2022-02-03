# #-------------------------
# # Parameter group
# #-------------------------
# resource "aws_db_parameter_group" "my_sql_standalone_param_g" {
#   name   = "${var.project}-${var.environment}-mysql-standalone-param-g"
#   family = "mysql8.0"

#   parameter {
#     name  = "character_set_database"
#     value = "utf8mb4"
#   }

#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
# }

# #-------------------------
# # Option group
# #-------------------------
# resource "aws_db_option_group" "my_sql_standalone_option_g" {
#   name                 = "${var.project}-${var.environment}-mysql-standalone-option-g"
#   engine_name          = "mysql"
#   major_engine_version = "8.0"
# }

# #-------------------------
# # Subnet group
# #-------------------------
# resource "aws_db_subnet_group" "my_sql_standalone_subnet_g" {
#   name = "${var.project}-${var.environment}-mysql-standalone-subnet-g"
#   subnet_ids = [
#     aws_subnet.ina_terra_private_subnet_2a.id,
#     aws_subnet.ina_terra_private_subnet_2c.id
#   ]

#   tags = {
#     Name    = "${var.project}-${var.environment}-mysql-standalone_subnet_g"
#     Project = var.project
#     Env     = var.environment
#   }
# }

# #-------------------------
# # Random string
# #-------------------------
# resource "random_string" "db_pass" {
#   length  = 16
#   special = false
# }

# #-------------------------
# # Create RDS
# #-------------------------
# resource "aws_db_instance" "mysql_standalone" {
#   engine         = "mysql"
#   engine_version = "8.0.20"

#   identifier = "${var.project}-${var.environment}-mysql-standalone"
#   username   = "admin"
#   password   = random_string.db_pass.result

#   instance_class = "db.t2.micro"

#   # Giga byte
#   allocated_storage     = 20
#   max_allocated_storage = 50
#   storage_type          = "gp2"
#   storage_encrypted     = false

#   multi_az               = false
#   availability_zone      = "us-east-2a"
#   db_subnet_group_name   = aws_db_subnet_group.my_sql_standalone_subnet_g.name
#   vpc_security_group_ids = [aws_security_group.ina-terra-db-sg.id]
#   publicly_accessible    = false
#   port                   = 3306

#   name                 = "ina"
#   parameter_group_name = aws_db_parameter_group.my_sql_standalone_param_g.name
#   option_group_name    = aws_db_option_group.my_sql_standalone_option_g.name

#   backup_window              = "04:00-05:00"
#   backup_retention_period    = 7
#   maintenance_window         = "Mon:05:00-Mon:08:00"
#   auto_minor_version_upgrade = false

#   deletion_protection = true
#   skip_final_snapshot = false

#   apply_immediately = true

#   tags = {
#     Name    = "${var.project}-${var.environment}-mysql-standalone"
#     Project = var.project
#     Env     = var.environment
#   }
# }