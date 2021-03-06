require 'test_helper'

describe Lotus::Model::Config::Adapter do

  describe '#load!' do
    let(:mapper) { Lotus::Model::Mapper.new }
    let(:adapter) { config.load!(mapper) }

    describe 'given adapter type is memory' do
      let(:config) { Lotus::Model::Config::Adapter.new(:memory) }

      it 'instantiates memory adapter' do
        adapter = config.load!(mapper)
        adapter.must_be_kind_of Lotus::Model::Adapters::MemoryAdapter
      end
    end

    describe 'given adapter type is SQL' do
      let(:config) { Lotus::Model::Config::Adapter.new(:sql, SQLITE_CONNECTION_STRING) }

      it 'instantiates SQL adapter' do
        adapter = config.load!(mapper)
        adapter.must_be_kind_of Lotus::Model::Adapters::SqlAdapter
      end
    end

    describe 'given adapter type does not exist' do
      let(:config) { Lotus::Model::Config::Adapter.new(:redis, 'redis://not_exist') }

      it 'raises an error' do
        -> {
          config.load!(mapper)
        }.must_raise(Lotus::Model::Config::AdapterNotFound)
      end
    end
  end

end
