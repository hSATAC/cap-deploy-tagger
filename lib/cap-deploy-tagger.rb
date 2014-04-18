# Ensure deploy tasks are loaded before we run
require 'capistrano/deploy'

# Load extra tasks into the deploy namespace
load File.expand_path("../cap-deploy-tagger/tasks/tagger.rake", __FILE__)

module CapDeployTagger
  class Helper
    def self.tag(tag, stage)
      tag_name = "#{stage}/#{tag}"
      current_sha = latest_revision
      git "tag -a #{tag_name} -m '#{username} deployed #{current_sha}.'"
      git "push --tags" # FIXME: force origin is not good.
      tag_name
    end

    def self.git(cmd)
      `git #{cmd} 2>&1`.chomp
    end

    def self.latest_revision
      git "rev-parse --short HEAD"
    end

    def self.formatted_time
      Time.new.strftime(fetch(:deploytag_time_format, "%Y.%m.%d-%H%M%S"))
    end

    def self.username
      `git config user.name`
    end
  end
end
