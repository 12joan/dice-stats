require_relative "../src/cache"

RSpec.describe Cache do
  let(:cache_a) { Cache.new(:id_a, :result_a) }
  let(:cache_b) { Cache.new(:id_b, :result_b) }
  let(:cache_c) { Cache.new(:id_b, :result_c) }

  describe '#==' do
    context 'when the caches are different' do
      subject { cache_a == cache_b }
      it { is_expected.to eq(false) }
    end

    context 'when the caches are similar' do
      subject { cache_c == cache_b }
      it { is_expected.to eq(true) }
    end
  end
end
