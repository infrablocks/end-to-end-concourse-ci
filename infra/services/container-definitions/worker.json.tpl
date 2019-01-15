[
  {
    "name": "${name}",
    "image": "${image}",
    "memoryReservation": 2048,
    "essential": true,
    "privileged": true,
    "portMappings": [
      {
        "containerPort": 7777,
        "hostPort": 7777
      },
      {
        "containerPort": 7788,
        "hostPort": 7788
      },
      {
        "containerPort": 7799,
        "hostPort": 7799
      }
    ],
    "environment": [
      { "name": "AWS_REGION", "value": "${region}" },
      { "name": "ENVIRONMENT_OBJECT_PATH", "value": "${environment_object_path}" }
    ],
    "mountPoints": [
      {
        "sourceVolume": "work-dir",
        "containerPath": "/concourse-work-dir"
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
