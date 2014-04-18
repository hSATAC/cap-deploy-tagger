# Ensure deploy tasks are loaded before we run
require 'capistrano/deploy'

# Load extra tasks into the deploy namespace
load File.expand_path("../cap-deploy-tagger/tasks/tagger.rake", __FILE__)

module CapDeployTagger
  class Helper
    
    def self.tag(tag, stage)
      tag_name = "#{stage}/#{tag}"
      git "tag -f #{tag_name}"
      git "push origin #{tag_name}" # FIXME: force origin is not good.
      tag_name
    end
    
    def self.git(cmd)
      `git #{cmd} 2>&1`.chomp
    end
    
    def self.latest_revision
      git "rev-parse --short HEAD"
    end
    
  end
end
