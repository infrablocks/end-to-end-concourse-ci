require 'confidante'
require 'rake_terraform'
require 'rake_docker'

require_relative 'lib/terraform_output'
require_relative 'lib/version'

configuration = Confidante.configuration
version = Version.from_file('build/version')

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.11.3')

namespace :bucket do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_identifier]

    t.configuration_name = 'state bucket'
    t.source_directory = 'infra/state_bucket'
    t.work_directory = 'build'

    t.state_file = lambda do |args|
      File.join(Dir.pwd, "state/state_bucket/#{args.deployment_identifier}.tfstate")
    end

    t.vars = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'state_bucket')
          .vars
    end
  end
end

namespace :domain do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_identifier]

    t.configuration_name = 'domain'
    t.source_directory = 'infra/domain'
    t.work_directory = 'build'

    t.backend_config = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'domain')
          .backend_config
    end

    t.vars = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'domain')
          .vars
    end
  end
end

namespace :network do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_identifier]

    t.configuration_name = 'network'
    t.source_directory = 'infra/network'
    t.work_directory = 'build'

    t.backend_config = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'network')
          .backend_config
    end

    t.vars = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'network')
          .vars
    end
  end
end

[:web, :worker].each do |role|
  namespace "#{role}_image_repository" do
    RakeTerraform.define_command_tasks do |t|
      t.argument_names = [:deployment_identifier]

      t.configuration_name = "#{role} image repository"
      t.source_directory = "infra/image_repository"
      t.work_directory = 'build'

      t.backend_config = lambda do |args|
        configuration
            .for_overrides(args)
            .for_scope(role: "#{role}-repository")
            .backend_config
      end

      t.vars = lambda do |args|
        configuration
            .for_overrides(args)
            .for_scope(role: "#{role}-repository")
            .vars
      end
    end
  end

  namespace "#{role}_image" do
    RakeDocker.define_image_tasks do |t|
      t.argument_names = [:deployment_identifier]

      t.image_name = "concourse-#{role}"
      t.work_directory = 'build/images'

      t.copy_spec = [
          "src/concourse-#{role}/Dockerfile",
          "src/concourse-#{role}/entrypoint.sh"
      ]

      t.create_spec = [
          {content: version.to_s, to: 'VERSION'},
          {content: version.to_docker_tag, to: 'TAG'}
      ]

      t.repository_name = "infrablocks/concourse-#{role}"

      t.repository_url = lambda do |args|
        backend_config =
            configuration
                .for_overrides(args)
                .for_scope(role: "#{role}-repository")
                .backend_config

        TerraformOutput.for(
            name: 'repository_url',
            source_directory: "infra/image_repository",
            work_directory: 'build',
            backend_config: backend_config)
      end

      t.credentials = lambda do |args|
        backend_config =
            configuration
                .for_overrides(args)
                .for_scope(role: "#{role}-repository")
                .backend_config

        region =
            configuration
                .for_overrides(args)
                .for_scope(role: "#{role}-repository")
                .region

        authentication_factory = RakeDocker::Authentication::ECR.new do |c|
          c.region = region
          c.registry_id = TerraformOutput.for(
              name: 'registry_id',
              source_directory: "infra/image_repository",
              work_directory: 'build',
              backend_config: backend_config)
        end

        authentication_factory.call
      end

      t.tags = [version.to_docker_tag, 'latest']
    end

    desc 'Build and push custom concourse image'
    task :publish, [:deployment_identifier] do |_, args|
      Rake::Task["#{role}_image:clean"].invoke(args.deployment_identifier)
      Rake::Task["#{role}_image:build"].invoke(args.deployment_identifier)
      Rake::Task["#{role}_image:tag"].invoke(args.deployment_identifier)
      Rake::Task["#{role}_image:push"].invoke(args.deployment_identifier)
    end
  end

end
