# TODO: Figure out whether it makes more sense to use rake tasks or just custom commands using commander.
namespace :dot_example do
  desc "Setup the githooks to automate the dot_example tasks"
  task :setup => :environment do
    # Call other classes and do stuff
  end

  desc "Creates a new .env.example file with the keys from .env."
  task :sync => :environment do
  end

  desc "Checks ENV keys to make sure they are up to date with those found in .env.example"
  task :check => :environment do
    # Call other classes and do stuff
  end

end
