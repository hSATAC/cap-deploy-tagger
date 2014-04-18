namespace :deploy do

  desc "Tag deployed release"
  task :tag do
    if ENV['SKIP_DEPLOY_TAGGING'] || fetch(:skip_deploy_tagging, false)
      puts "[cap-deploy-tagger] Skipped deploy tagging"
    else
      tag = CapDeployTagger::Helper.tag(fetch(:deploy_tag, CapDeployTagger::Helper.formatted_time), fetch(:stage))
      puts "[cap-deploy-tagger] Tagged #{CapDeployTagger::Helper.latest_revision} with #{tag}"
    end
  end

  #before 'deploy', 'git:prepare_tree'
  #before 'deploy:migrations', 'git:prepare_tree'
  after :cleanup, 'deploy:tag'

end
