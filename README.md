# Koine::SqlBuilder

Simple SQL builder created with MySql in mind - although I will try to make it compatible with other SQL based databases.
A port to other databases can potentially be achieved by replacing the adapter.

**This is a WIP**

[![Build Status](https://travis-ci.org/mjacobus/koine-sql_builder.svg?branch=master)](https://travis-ci.org/mjacobus/koine-sql_builder)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/koine-sql_builder/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/koine-sql_builder?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/eb8b4ea26c2110d67732/maintainability)](https://codeclimate.com/github/mjacobus/koine-sql_builder/maintainability)
[![Issue Count](https://codeclimate.com/github/mjacobus/koine-sql_builder/badges/issue_count.svg)](https://codeclimate.com/github/mjacobus/koine-sql_builder)

[![Gem Version](https://badge.fury.io/rb/koine-sql_builder.svg)](https://badge.fury.io/rb/koine-sql_builder)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-sql_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install koine-sql_builder

## Usage

See  [examples](https://github.com/mjacobus/koine-sql_builder/tree/master/examples)

```ruby
builder = Koine::SqlBuilder::Builder.new

builder.select
  .from(users: :u)
  .where(lastname: 'Jacobus')
  .where(age: 18)

# SELECT *
# FROM users u
# WHERE lastname = "Jacobus" AND age = 18

builder
  .select(:id, last_name: :lastname)
  .from(:users)
  .where(lastname: 'Jacobus')

# SELECT id, last_name AS lastname
# FROM users
# WHERE lastname = "Jacobus"

builder
  .select
  .from(:users)
  .where(age: nil)

# SELECT *
# FROM users
# WHERE age IS NULL

age_not_null = builder.adapter.equal(:age, nil).not

builder
  .select
  .from(:users)
  .where(age_not_null)

# SELECT *
# FROM users
# WHERE age IS NOT NULL
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-sql_builder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Koine::SqlBuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/mjacobus/koine-sql_builder/blob/master/CODE_OF_CONDUCT.md).
