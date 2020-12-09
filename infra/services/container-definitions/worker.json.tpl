[
  {
    "name": "${name}",
    "image": "${image}",
    "memoryReservation": 2048,
    "essential": true,
    "privileged": true,
    "portMappings": [
      {
        "containerPort": ${garden_port},
        "hostPort": ${garden_port}
      },
      {
        "containerPort": ${baggageclaim_port},
        "hostPort": ${baggageclaim_port}
      },
      {
        "containerPort": ${gc_port},
        "hostPort": ${gc_port}
      }
    ],
    "environment": [
      { "name": "AWS_S3_BUCKET_REGION", "value": "${region}" },
      { "name": "AWS_S3_ENV_FILE_OBJECT_PATH", "value": "${environment_object_path}" }
    ],
    "mountPoints": [
      {
        "sourceVolume": "work-dir",
        "containerPath": "/var/opt/concourse"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "worker"
      }
    }
  }
]
