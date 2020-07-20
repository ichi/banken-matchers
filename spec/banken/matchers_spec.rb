RSpec.describe Banken::Matchers do
  subject { loyalty }

  context 'test? is permitted' do
    let(:loyalty) {
      Class.new do
        def test?
          true
        end
      end.new
    }

    it { is_expected.to permit_action(:test) }
    it { is_expected.to_not forbid_action(:test) }
  end

  context 'test? is forbidden' do
    let(:loyalty) {
      Class.new do
        def test?
          false
        end
      end.new
    }

    it { is_expected.to_not permit_action(:test) }
    it { is_expected.to forbid_action(:test) }
  end
end
