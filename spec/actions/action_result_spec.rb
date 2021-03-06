# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActionResult do
  let!(:errors) { %i[errors] }

  describe '.new' do
    it 'returns an ActionResult class with the given members and errors' do
      result_class = described_class.new(:abc)
      expect(result_class.members).to match(%i[abc errors])
    end

    it 'returns an ActionResult class with only errors when called without arguments' do
      result_class = described_class.new
      expect(result_class.members).to eq(%i[errors])
    end
  end

  describe '.success' do
    it 'returns an ActionResult populated with the given values' do
      result = described_class.new(:abc).success(abc: 123)

      expect(result.abc).to eq(123)
      expect(result.errors).to be_empty
    end
  end

  describe '.failure' do
    it 'returns an ActionResult populated with the given errors' do
      result = described_class.new(:a_key).failure(errors)

      expect(result.a_key).to be_nil
      expect(result.errors).to eq(errors)
    end
  end

  describe '#and_then' do
    it 'calls the given block and returns self for a successful ActionResult' do
      called = false
      success = described_class.new.success
      returned_value = success.and_then { called = true }

      expect(called).to eq(true)
      expect(success).to eq(returned_value)
    end

    it 'does not call the given block and returns self for a failure ActionResult' do
      called = false
      failure = described_class.new.failure(errors)
      returned_value = failure.and_then { called = true }

      expect(called).to eq(false)
      expect(returned_value).to eq(failure)
    end

    it 'passes the ActionResult values as an argument to the given block' do
      success = described_class.new(:abc, :xyz).success(abc: 123, xyz: 456)

      success.and_then do |abc:, xyz:|
        expect(abc).to eq(123)
        expect(xyz).to eq(456)
      end
    end
  end

  describe '#or_else' do
    it 'does not call the given block and returns self for a successful ActionResult' do
      called = false
      success = described_class.new.success
      returned_value = success.or_else { called = true }

      expect(called).to eq(false)
      expect(returned_value).to eq(success)
    end

    it 'calls the given block and returns self for a failure ActionResult' do
      called = false
      failure = described_class.new.failure(errors)
      returned_value = failure.or_else { called = true }

      expect(called).to eq(true)
      expect(failure).to eq(returned_value)
    end

    it 'passes the ActionResult errors as an argument to the given block' do
      success = described_class.new.failure(errors)

      success.and_then do |result_errors|
        expect(result_errors).to eq(errors)
      end
    end
  end
end
