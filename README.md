# DotExample
It's become common practice to use a tool like the `dotenv` gem to manage environment variables locally, keeping all environment variables in a key value store in a dotfile (`.env`) and then leaving this file out of version control. However when working on a team it's easy to lose track of the latest variables that need to be added to `.env`. Often it isn't obvious when one is needed until a problem arises. Adding the keys to the README and/or to a `.env.example` file is one way to share the ENV variables needed with the rest of the team, but like many kinds of documentation it is easy for these files to get out of date.

Enter `dot_example`, a simple tool for automatically documenting the environment variables in use across the team and alerting team members when a new variable has been added. This is accomplished through the use of a `.env.example` file and setting up git hooks. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dot_example'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dot_example

## Quick Start
Most of the time you should only need to manually run one command

```
dot_example setup
```

And you're done. That was easy!

Running this setup script will do the following:
1. Create a new pre-commit git hook that will add the keys from your `.env` file to a `.env.example` file whenever you create a new commit.
2. Create a new post-checkout git hook that will check for new variables in the `.env.example` whenever you checkout a branch.
3. Create or add to a bin/setup file so that this setup script will be run automatically whenever anyone runs `./bin/setup`

Now for anyone else who joins the project all they have to do is run `./bin/setup` and `dot_example` will get setup along with the rest of the app. They won't even need to know that it's there!

## Usage

dot_example ships with three commands `setup`, `sync` and `check`

### Setup

```
$ dot_example setup
```

Sets up the githooks that will cause sync and check to run automatically. Assuming this works without a hitch this should keep you from having to manually run anything ever. You can even put a line in the bin/setup script to call this command:

and then you won't even have to manually run `setup` just have everyone run `./bin/setup` when they start the project. In case you do need to run the commands for whatever reason you can run the other two commands are as follows:

### Sync
```
$ dot_example snyc
```
sync will take the keys to the ENV variables are in your `.env` file and write them to a `.env.example` file. By keeping _this_ file in source control rather than the actual `.env` file you can make sure that other team members are always up to date on which ENV variables they are missing.

### Check

```
$ dot_example check
```

`check` will look at the ENV variables you currently have defined in your `.env` file and ensure they are up to date with the keys in the latest `.env.example`. This doesn't guarantee that their _values_ are correct but at least you'll receive a warning if you're missing keys and you'll know to ask someone for the ENV variables you're missing.

After running `dot_example setup` the `check` command will be run whenever you checkout code. This could easily be changed though if you'd rather the check happen in a different common task such as running tests with rake. All you'd need to do then is add `dot_example check` to your rake task.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smcabrera/dot_example. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

