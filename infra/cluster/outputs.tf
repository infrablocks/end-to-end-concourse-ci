output "ecs_cluster_id" {
  value = module.ecs_cluster.cluster_id
}
output "ecs_cluster_log_group" {
  value = module.ecs_cluster.log_group
}
output "ecs_cluster_instance_role_arn" {
  value = module.ecs_cluster.instance_role_arn
}
output "ecs_service_role_arn" {
  value = module.ecs_cluster.service_role_arn
}
