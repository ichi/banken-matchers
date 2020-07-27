module Banken
  module Matchers
    class Configuration
      attr_accessor :user_alias

      def initialize
        @user_alias = :user
      end
    end

    class << self
      def configure
        yield(configuration)
      end

      def configuration
        @configuration ||= Banken::Matchers::Configuration.new
      end
    end
  end
end

RSpec::Matchers.define(:permit_action) { |action|
  include Banken::Matchers

  match { |loyalty|
    loyalty.public_send "#{action}?"
  }

  failure_message { |loyalty|
    "#{loyalty.class} does not permit #{action} for #{loyalty.public_send(Banken::Matchers.configuration.user_alias).inspect}."
  }
}

RSpec::Matchers.define(:forbid_action) { |action|
  include Banken::Matchers

  match { |loyalty|
    ! loyalty.public_send "#{action}?"
  }

  failure_message { |loyalty|
    "#{loyalty.class} does not forbid #{action} for #{loyalty.public_send(Banken::Matchers.configuration.user_alias).inspect}."
  }
}

RSpec::Matchers.define(:permit_actions) { |*actions|
  include Banken::Matchers

  match { |loyalty|
    return false if actions.count.zero?

    @forbidden_actions = actions.select do |action|
      ! loyalty.public_send "#{action}?"
    end

    @forbidden_actions.empty?
  }

  failure_message { |loyalty|
    if actions.count.zero?
      "At least one action must be specified when using the permit_actions matcher."
    else
      "#{loyalty.class} expected to permit #{actions}, but forbade #{@forbidden_actions} for #{loyalty.public_send(Banken::Matchers.configuration.user_alias).inspect}."
    end
  }
}

RSpec::Matchers.define(:forbid_actions) { |*actions|
  include Banken::Matchers

  match { |loyalty|
    return false if actions.count.zero?

    @permitted_actions = actions.select do |action|
      loyalty.public_send "#{action}?"
    end

    @permitted_actions.empty?
  }

  failure_message { |loyalty|
    if actions.count.zero?
      "At least one action must be specified when using the forbid_actions matcher."
    else
      "#{loyalty.class} expected to forbade #{actions}, but permitted #{@permitted_actions} for #{loyalty.public_send(Banken::Matchers.configuration.user_alias).inspect}."
    end
  }
}
