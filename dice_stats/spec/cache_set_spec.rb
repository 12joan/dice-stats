require_relative '../src/cache_set'
require_relative '../src/cache'

cache_a = Cache.new(:id_a, :result_a)
cache_b = Cache.new(:id_b, :result_b)

RSpec.describe CacheSet do
  let(:cache_set) { CacheSet.new([ cache_a, cache_b ]) }

  describe '#find' do
    context 'when the cache exists' do
      subject { cache_set.find(:id_a) }
      it { is_expected.to eq(cache_a) }
    end

    context 'when the cache does not exist' do
      subject { cache_set.find(:id_c) }
      it { is_expected.to eq(nil) }
    end
  end

  describe '#cache_exists?' do
    context 'when the cache exists' do
      subject { cache_set.exists?(:id_b) }
      it { is_expected.to eq(true) }
    end

    context 'when the cache does not exist' do
      subject { cache_set.exists?(:id_c) }
      it { is_expected.to eq(false) }
    end
  end
end
