# Truss Software Engineering Interview Solution

## Installation / Setup

My solution has been tested on a Mac running 10.12.6; Mac OS 10.13 should be preferred for running it.

I have been using Ruby 2.5.3 per the `.ruby-version` file, although any maintainter-supported version of Ruby should be fine. To install particular Ruby versions, I recommend using RVM or another Ruby version manager; install instructions for those are included in the suggested installation script below. Note that RVM's install process assumes that Homebrew is already installed.

```bash
# install RVM
curl -sSL https://get.rvm.io | bash -s stable
source ~/.bash_profile

# install Ruby & its package management tools RubyGems & Bundler
rvm install 2.5.3
rvm use 2.5.3
gem install bundler

# install project dependencies
cd $REPO_WORKING_DIRECTORY
bundle
```

## Running My Solution

The CLI tool itself can be run with:

```
bin/normalize_csv
```

To run the test suite, use:

```
bin/rake
```
