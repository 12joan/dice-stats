require_relative '../src/caching_roller'
require_relative '../src/cache_set'
require_relative '../src/cache'

cacher = CacheSet.new([ Cache.new([1, 2], :cached_data) ])
roller = Struct.new(:roll_value) {
  def roll(a, b)
    roll_value
  end
}.new(:rolled_data)

RSpec.describe CachingRoller do
  let(:caching_roller) { CachingRoller.new(roller, cacher) }

  describe '#roll' do
    context 'when the roll is cached' do
      subject { caching_roller.roll(1, 2) }
      it { is_expected.to eq(:cached_data) }
    end

    context 'when the roll is not cached' do
      subject { caching_roller.roll(3, 4) }
      it { is_expected.to eq(:rolled_data) }
    end
  end
end
