require "spec_helper"
require "active_record"
require "muffin_blog/app/models/application_record"
require "muffin_blog/app/models/post"

RSpec.describe "Post", type: :model do
  before(:each) do
    Post.establish_connection(
      database: "#{__dir__}/muffin_blog/db/development.sqlite3")
    @post = Post.new(id: 1, title: "My first post")
  end

  it 'should have_one title' do
    expect(@post.title).to eq("My first post")
  end

  it 'should have_one id' do
    expect(@post.id).to eq(1)
  end

  it 'should be able to find all instances in the db' do
    post = Post.all.first
    expect(post).to_not be_nil
    expect(post.id).to eq(1)
    expect(post.title).to eq("Blueberry Muffins")
  end

  it 'should be able to find instances in db' do
    @post2 = Post.find(1)
    expect(@post2).to_not be_nil
    expect(@post2.id).to eq(1)
    expect(@post2.title).to eq("Blueberry Muffins")
  end

  it 'should have a db connection' do
    results = Post.connection.execute("SELECT * FROM posts")
    expect(results).to be_an_instance_of(Array)
    row = results.first
    expect(row).to have_key(:title)
  end
end
