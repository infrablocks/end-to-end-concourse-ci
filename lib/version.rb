# frozen_string_literal: true

require 'semantic'
require 'securerandom'

class Version
  def self.from_file(path)
    git_sha = ENV['GIT_SHA'] || 'LOCAL'
    metadata = git_sha.to_s

    base_version = if File.exist?(path)
                     File.read(path)
                   else
                     '0.0.0'
                   end

    Version.new("#{base_version}+#{metadata}")
  end

  def initialize(version_string)
    @version = Semantic::Version.new(version_string)
  end

  def to_docker_tag
    to_s.gsub(/\+/, '_').downcase
  end

  def to_s
    @version.to_s
  end
end
