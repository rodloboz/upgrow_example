# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsRepository, type: :repository do
  subject(:repository) { described_class.new }

  let(:post1) { PostRecord.create(title: 'Abc', body: '123') }
  let(:post2) { PostRecord.create(title: 'Xyz', body: '456') }

  before do
    post1
    post2
  end

  describe '#all' do
    it 'returns all post records' do
      posts = repository.all
      expect(posts.count).to eq(2)
    end

    it 'instanciates the correct post models' do
      posts = repository.all
      expect(posts).to all be_a(Post)
      expect(posts[0].title).to eq('Abc')
      expect(posts[0].body).to eq('123')
      expect(posts[1].title).to eq('Xyz')
      expect(posts[1].body).to eq('456')
    end
  end

  describe '#find' do
    it 'returns the correct post' do
      id = post1.id
      post = repository.find(id)

      expect(post).not_to be_nil
      expect(post).to be_a(Post)
      expect(post.title).to eq('Abc')
      expect(post.body).to eq('123')
    end
  end

  describe '#create' do
    it 'creates a post' do
      expect do
        repository.create(title: 'New Post', body: 'abc')
      end.to change(PostRecord, :count).by(1)

      post = repository.all.last

      expect(post).to be_a(Post)
      expect(post.title).to eq('New Post')
      expect(post.body).to eq('abc')
    end
  end

  describe '#update' do
    it 'updates a post' do
      post = repository.all.first

      expect(post.title).to eq('Abc')

      post = repository.update(post.id, title: 'Updated Post')

      expect(post).to be_a(Post)
      expect(post.title).to eq('Updated Post')
    end
  end
end
