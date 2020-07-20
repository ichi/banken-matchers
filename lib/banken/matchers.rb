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
