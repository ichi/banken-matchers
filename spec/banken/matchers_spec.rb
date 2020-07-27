RSpec.describe Banken::Matchers do
  subject { loyalty }

  describe 'permit_action/forbid_action matcher' do
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

  describe 'permit_actions/forbid_actions matcher' do
    let(:loyalty) {
      Class.new do
        def test1?
          true
        end

        def test2?
          true
        end

        def test3?
          false
        end

        def test4?
          false
        end
      end.new
    }

    it { is_expected.to permit_actions(:test1, :test2) }
    it { is_expected.to forbid_actions(:test3, :test4) }
  end
end
