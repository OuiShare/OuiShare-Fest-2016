set :application, "OuiShare-Fest"
set :repository,  "ouishare@ouishare.webfactional.com:webapps/git/repos/OuiShare-Fest.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :scm, :git

set :deploy_to, "~/webapps/ouishare_fest"

set :default_env, {
  'PATH' => "#{deploy_to}/bin:$PATH",
  'GEM_HOME' => "#{deploy_to}/gems" 
}

role :web, "ouishare.webfactional.com"                          # Your HTTP server, Apache/etc
role :app, "ouishare.webfactional.com"                          # This may be the same as your `Web` server
role :db,  "ouishare.webfactional.com", :primary => true # This is where Rails migrations will run
## role :db,  "your slave db-server here"

set :user, "ouishare"
set :scm_username, "ouishare"
set :use_sudo, false
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end