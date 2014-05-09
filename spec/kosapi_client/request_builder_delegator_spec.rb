require 'spec_helper'

describe KOSapiClient::RequestBuilderDelegator do

  let(:response) { double(:response) }
  let(:builder) { double(:builder, response: response, finalize: nil) }
  subject(:delegator) { KOSapiClient::RequestBuilderDelegator.new(builder) }

  it 'delegates methods which builder responds to, to the builder' do
    expect(builder).to receive(:foo)
    delegator.foo
  end

  it 'evaluates builder when builder is not responding to a delegated method' do
    expect(builder).to receive(:finalize)
    expect(response).to receive(:bar)
    delegator.bar
  end

  it 'delegates all methods to response once RequestBuilder is evaluated' do
    allow(response).to receive(:bar)
    expect(builder).not_to receive(:foo)
    delegator.bar
    expect { delegator.foo }.to raise_error(NoMethodError)
  end

  it 'throws error when method is not defined on builder or response' do
    expect { delegator.foo }.to raise_error(NoMethodError)
  end


end
