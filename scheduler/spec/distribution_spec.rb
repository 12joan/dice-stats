require_relative "../src/distribution"

data = "0\n0\n0\n1\n3\n6\n10\n12\n12\n10\n6\n3\n1\n"

RSpec.describe Distribution do
  let(:distribution) { Distribution.new(data) }

  describe '#paths_to' do
    subject { distribution.paths_to(4) }
    it { is_expected.to eq(3) }
  end

  describe '#outcomes' do
    subject { distribution.outcomes }
    it { is_expected.to eq(64) }
  end

  describe '#probability_of' do
    subject { distribution.probability_of(4) }
    it { is_expected.to eq(0.046875) }
  end
end
