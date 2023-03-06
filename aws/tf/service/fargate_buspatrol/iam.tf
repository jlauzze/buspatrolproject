# ECS execution role
resource "aws_iam_role" "execution_role" {
  name        = "buspatrol-role"
  description = "Execution Role"
  path        = "/"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AssumeRole",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          }
        }
      ]
    }
  )

  tags = {
    Name = "buspatrol-role"
  }
}

resource "aws_iam_role" "task_role" {
  name        = "buspatrol-task-role"
  description = "Task Role"
  path        = "/"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "AssumeRole",
          "Effect" : "Allow",
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ecs-tasks.amazonaws.com"
          }
        }
      ]
    }
  )

  tags = {
    Name = "buspatrol-task-role"
  }
}

resource "aws_iam_policy" "buspatrol_task_policy" {
  name        = "bus-patrol-task-policy"
  description = "Policy for the ECS task"
  path        = "/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "S3Permissions",
          "Effect" : "Allow",
          "Action" : [
            "s3:List*",
            "s3:Get*",
            "s3:Put*",
            "s3:Delete*"
          ],
          "Resource" : ["*"] #Typically you wouldn't do this, but for the purposes of this demo, I am doing it.
        },
      ]
    },
  )
}

resource "aws_iam_role_policy_attachment" "buspatrol_task_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.buspatrol_task_policy.arn
}

resource "aws_iam_policy" "execution_policy" {
  name        = "buspatrol-execution-policy"
  description = "Allows the service to access other services within AWS."
  path        = "/"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "EcrAuthorizationPermissions",
          "Effect" : "Allow",
          "Action" : "ecr:GetAuthorizationToken",
          "Resource" : "*"
        },
        {
          "Sid" : "EcrReadPermissions",
          "Effect" : "Allow",
          "Action" : [
            "ecr:GetDownloadUrlForLayer",
            "ecr:BatchGetImage",
            "ecr:BatchCheckLayerAvailability"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "CloudwatchWritePermissions",
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "${aws_cloudwatch_log_group.ecs_log_group.arn}*"
        },
        {
          "Sid" : "S3Permissions",
          "Effect" : "Allow",
          "Action" : [
            "s3:List*",
            "s3:Get*",
            "s3:Put*",
            "s3:Delete*"
          ],
          "Resource" : ["*"] #Typically you wouldn't do this, but for the purposes of this demo, I am doing it.
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "execution_policy_attachment" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.execution_policy.arn
}