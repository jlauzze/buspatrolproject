resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name = "buspatrol-logs"

  tags = {
    Name = "buspatrol-logs"
  }
}