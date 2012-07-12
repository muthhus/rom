require 'spec_helper'

describe Session::ObjectState, '#persist' do
  let(:object)        { described_class.new(mapper, domain_object) }
  let(:mapper)        { DummyMapper.new                           }
  let(:domain_object) { DomainObject.new(:foo, :bar) }

  subject do
    object.persist
  end

  it 'should raise StateError' do
    expect { subject }.to raise_error(Session::StateError, "Session::ObjectState cannot be persisted")
  end
end
