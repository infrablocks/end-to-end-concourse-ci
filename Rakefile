require 'confidante'
require 'ruby_terraform/output'
require 'rake_terraform'
require 'rake_docker'
require 'rake_factory/kernel_extensions'

require_relative 'lib/version'

configuration = Confidante.configuration
version = Version.from_file('build/version')

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '1.1.7')

namespace :bootstrap do
  RakeTerraform.define_command_tasks(
      configuration_name: 'bootstrap',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'bootstrap'))

    t.source_directory = 'infra/bootstrap'
    t.work_directory = 'build'

    t.state_file =
        File.join(
            Dir.pwd,
            "state/bootstrap/#{args.deployment_identifier}.tfstate")
    t.vars = configuration.vars
  end
end

namespace :domain do
  RakeTerraform.define_command_tasks(
      configuration_name: 'domain',
      argument_names: [:deployment_identifier, :domain_name]
  ) do |t, args|
    configuration = configuration
        .for_overrides(domain_name: args.domain_name)
        .for_scope(
            {deployment_identifier: args.deployment_identifier}
                .merge(role: 'domain'))

    t.source_directory = 'infra/domain'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :certificate do
  RakeTerraform.define_command_tasks(
      configuration_name: 'certificate',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'certificate'))

    t.source_directory = 'infra/certificate'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :network do
  RakeTerraform.define_command_tasks(
      configuration_name: 'network',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: 'network'))

    t.source_directory = 'infra/network'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

[:web, :worker].each do |role|
  namespace "#{role}_image_repository" do
    RakeTerraform.define_command_tasks(
        configuration_name: "#{role} image repository",
        argument_names: [:deployment_identifier]
    ) do |t, args|
      configuration = configuration
          .for_scope(args.to_h.merge(role: "#{role}-repository"))

      t.source_directory = "infra/image_repository"
      t.work_directory = 'build'

      t.backend_config = configuration.backend_config
      t.vars = configuration.vars
    end
  end

  namespace "#{role}_image" do
    RakeDocker.define_image_tasks(
        image_name: "concourse-#{role}",
        argument_names: [:deployment_identifier]
    ) do |t, args|
      configuration = configuration
          .for_scope(args.to_h.merge(role: "#{role}-repository"))

      t.work_directory = 'build/images'

      t.copy_spec = [
          "src/concourse-#{role}/Dockerfile"
      ]

      t.create_spec = [
          {content: version.to_s, to: 'VERSION'},
          {content: version.to_docker_tag, to: 'TAG'}
      ]

      t.repository_name = "infrablocks-examples/concourse-#{role}"

      t.repository_url = dynamic do
        RubyTerraform::Output.for(
            name: 'repository_url',
            source_directory: "infra/image_repository",
            work_directory: 'build',
            backend_config: configuration.backend_config)
      end

      t.credentials = dynamic do
        RakeDocker::Authentication::ECR.new { |c|
          c.region = configuration.region
          c.registry_id = RubyTerraform::Output.for(
              name: 'registry_id',
              source_directory: "infra/image_repository",
              work_directory: 'build',
              backend_config: configuration.backend_config)
        }.call
      end

      t.tags = [version.to_docker_tag, 'latest']
    end
  end
end

namespace :database do
  RakeTerraform.define_command_tasks(
      configuration_name: 'database',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: "database"))

    t.source_directory = 'infra/database'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :cluster do
  RakeTerraform.define_command_tasks(
      configuration_name: 'cluster',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_scope(args.to_h.merge(role: "cluster"))

    t.source_directory = 'infra/cluster'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end

namespace :services do
  RakeTerraform.define_command_tasks(
      configuration_name: 'concourse services',
      argument_names: [:deployment_identifier]
  ) do |t, args|
    configuration = configuration
        .for_overrides(version_number: version.to_docker_tag)
        .for_scope(args.to_h.merge(role: "services"))

    t.source_directory = 'infra/services'
    t.work_directory = 'build'

    t.backend_config = configuration.backend_config
    t.vars = configuration.vars
  end
end
