# Banken::Matchers

Inspired by [pundit-matchers](https://github.com/chrisalley/pundit-matchers) gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'banken-matchers'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install banken-matchers

## Configuration

```ruby
Banken::Matchers.configure do |config|
  config.user_alias = :account
end
```

## Usage

### Mathers

- `permit_action(:action_name)`
- `forbid_action(:action_name)`
- `permit_actions(:action_name1, :action_name2, ...)`
- `forbid_actions(:action_name1, :action_name2, ...)`

## Example

```ruby
RSpec.describe ArticleLoyalty, type: :loyalty do
  subject { described_class.new(user, article) }

  let(:article) { Artcle.create }

  context 'user has normal role' do
    let(:user) { User.create(role: :normal) }

    it{ is_expected.to permit_action(:index) }
    it{ is_expected.to forbid_action(:show) }
  end

  context 'user has admin role' do
    let(:user) { User.create(role: :admin) }

    it{ is_expected.to permit_action(:index) }
    it{ is_expected.to permit_action(:show) }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ichi/banken-matchers.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
