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
        "containerPort": ${http_port},
        "hostPort": ${http_port}
      },
      {
        "containerPort": ${ssh_port},
        "hostPort": ${ssh_port}
      }
    ],
    "environment": [
      { "name": "AWS_S3_BUCKET_REGION", "value": "$${region}" },
      { "name": "AWS_S3_ENV_FILE_OBJECT_PATH", "value": "${environment_object_path}" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "$${log_group}",
        "awslogs-region": "$${region}",
        "awslogs-stream-prefix": "web"
      }
    }
  }
]
