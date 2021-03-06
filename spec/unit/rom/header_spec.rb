require 'spec_helper'

describe ROM::Header do
  describe '.coerce' do
    subject(:header) { ROM::Header.coerce(input) }


    context 'with a primitive type' do
      let(:input) { [[:name, type: String]] }

      let(:expected) { ROM::Header.new(name: ROM::Header::Attribute.coerce(input.first)) }

      it 'returns a header with coerced attributes' do
        expect(header).to eql(expected)

        expect(header[:name].type).to be(String)
      end
    end

    context 'with a collection type' do
      let(:input) { [[:tasks, header: [[:title]], type: Array, model: model]] }
      let(:model) { Class.new }

      let(:expected) { ROM::Header.new(tasks: ROM::Header::Attribute.coerce(input.first)) }

      it 'returns a header with coerced attributes' do
        expect(header).to eql(expected)

        tasks = header[:tasks]

        expect(tasks.type).to be(Array)
        expect(tasks.model).to be(model)
        expect(tasks.header).to eql(ROM::Header.coerce([[:title]]))

        expect(input.first[1]).to eql(header: [[:title]], type: Array, model: model)
      end
    end

    context 'with a hash type' do
      let(:input) { [[:task, header: [[:title]], type: Hash, model: model]] }
      let(:model) { Class.new }

      let(:expected) { ROM::Header.new(task: ROM::Header::Attribute.coerce(input.first)) }

      it 'returns a header with coerced attributes' do
        expect(header).to eql(expected)

        tasks = header[:task]

        expect(tasks.type).to be(Hash)
        expect(tasks.model).to be(model)
        expect(tasks.header).to eql(ROM::Header.coerce([[:title]]))

        expect(input.first[1]).to eql(header: [[:title]], type: Hash, model: model)
      end
    end
  end
end
