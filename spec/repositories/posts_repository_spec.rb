# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsRepository, type: :repository do
  subject(:repository) { described_class.new }

  let(:post1) { PostRecord.create(title: 'Abc', body: 'lorem ipsum') }
  let(:post2) { PostRecord.create(title: 'Xyz', body: 'ipsum lorem') }

  before do
    post1
    post2
  end

  describe '#all' do
    it 'returns all post records' do
      posts = repository.all
      expect(posts.count).to eq(2)
    end

    it 'instanciates the correct post records' do
      posts = repository.all
      expect(posts).to all be_a(Post)
      expect(posts[0].title).to eq('Abc')
      expect(posts[0].body).to eq('lorem ipsum')
      expect(posts[1].title).to eq('Xyz')
      expect(posts[1].body).to eq('ipsum lorem')
    end
  end

  describe '#find' do
    it 'returns the correct post' do
      id = post1.id
      post = repository.find(id)

      expect(post).not_to be_nil
      expect(post).to be_a(Post)
      expect(post.title).to eq('Abc')
      expect(post.body).to eq('lorem ipsum')
    end
  end

  describe '#create' do
    let(:input) do
      PostInput.new(title: 'New Post', body: 'lorem ipsum')
    end

    it 'creates a post' do
      expect do
        repository.create(input)
      end.to change(PostRecord, :count).by(1)

      post = repository.all.last

      expect(post).to be_a(Post)
      expect(post.title).to eq('New Post')
      expect(post.body).to eq('lorem ipsum')
    end
  end

  describe '#update' do
    let(:input) do
      PostInput.new(title: 'Updated Post', body: 'lorem ipsum')
    end

    it 'updates a post' do
      post = repository.all.first

      expect(post.title).to eq('Abc')

      post = repository.update(post.id, input)

      expect(post).to be_a(Post)
      expect(post.title).to eq('Updated Post')
      expect(post.body).to eq('lorem ipsum')
    end
  end
end
