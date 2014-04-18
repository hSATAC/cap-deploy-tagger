namespace :deploy do
  
  desc "Tag deployed release"
  task :tag do
    if ENV['SKIP_DEPLOY_TAGGING'] || fetch(:skip_deploy_tagging, false)
      puts "[cap-deploy-tagger] Skipped deploy tagging"
    else
      tag = CapDeployTagger::Helper.tag(fetch(:deploy_tag, "deployed"), fetch(:stage))
      puts "[cap-deploy-tagger] Tagged #{CapDeployTagger::Helper.latest_revision} with #{tag}"
    end
  end
  
  after :cleanup, 'deploy:tag'
  
end
