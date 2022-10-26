
locals {
  # locals do aws_autoscaling_schedule
  min_off           = 0
  max_off           = 0
  desired_off       = 0
  recorrencia_start = "0 6 * * *"  # 06h00 da manha BR
  recorrencia_stop  = "0 20 * * *" # 20h00 da noite BR
}


resource "aws_autoscaling_schedule" "on" {

  depends_on = [aws_autoscaling_schedule.off]

  scheduled_action_name  = "EKS-START"
  min_size               = var.auto_sg_min
  max_size               = var.auto_sg_max
  desired_capacity       = var.auto_sg_desired
  start_time             = timeadd(timestamp(), "90m")
  recurrence             = local.recorrencia_start
  time_zone              = "Brazil/East"
  autoscaling_group_name = var.auto_sg
  lifecycle {
    ignore_changes = [start_time]
  }
}

resource "aws_autoscaling_schedule" "off" {
  scheduled_action_name  = "EKS-SHUTDOWN"
  min_size               = local.min_off
  max_size               = local.max_off
  desired_capacity       = local.desired_off
  start_time             = timeadd(timestamp(), "10m")
  recurrence             = local.recorrencia_stop
  time_zone              = "Brazil/East"
  autoscaling_group_name = var.auto_sg
  lifecycle {
    ignore_changes = [start_time]
  }
}


# Validar o nome do auto scaling group
# A região usado pelo cliente
# Validar o valores do Group details