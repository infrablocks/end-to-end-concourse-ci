[
  {
    "name": "$${name}",
    "image": "$${image}",
    "memoryReservation": 1024,
    "essential": true,
    "privileged": true,
    "command": $${command},
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      },
      {
        "containerPort": 2222,
        "hostPort": 2222
      }
    ],
    "environment": [
      { "name": "AWS_REGION", "value": "$${region}" },
      { "name": "ENVIRONMENT_OBJECT_PATH", "value": "${environment_object_path}" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "$${log_group}",
        "awslogs-region": "$${region}"
      }
    }
  }
]
