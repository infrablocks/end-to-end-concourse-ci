require 'confidante'
require 'rake_terraform'

configuration = Confidante.configuration

RakeTerraform.define_installation_tasks(
    path: File.join(Dir.pwd, 'vendor', 'terraform'),
    version: '0.11.3')

namespace :bucket do
  RakeTerraform.define_command_tasks do |t|
    t.argument_names = [:deployment_type, :deployment_label]

    t.configuration_name = 'state bucket'
    t.source_directory = 'infra/state_bucket'
    t.work_directory = 'build'

    t.state_file = lambda do |args|
      deployment_identifier =
          configuration
              .for_overrides(args)
              .deployment_identifier

      File.join(Dir.pwd, "state/state_bucket/#{deployment_identifier}.tfstate")
    end

    t.vars = lambda do |args|
      configuration
          .for_overrides(args)
          .for_scope(role: 'state_bucket')
          .vars
    end
  end
end
