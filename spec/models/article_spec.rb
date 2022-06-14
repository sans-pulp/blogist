require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'will not create without a title' do
    described_class.create({ body: 'This is a body....' })
    expect(described_class.count).to eq 0
  end

  it 'will not create without a body' do
    article = described_class.create({ title: 'Post #1' })
    expect(article.valid?).to be false
  end

  it 'will not create article with less that 50 chars in body' do
    article = described_class.create({ title: 'Post #1', body: 'Too short...' })
    expect(article.valid?).to be(false)
  end

  it 'will not createa an article with a duplicate title' do
    @article = described_class.create({ title: 'First!',
                                        body: 'This is a body......aaskdlaslkdjaaslksalkareweenough?asdalkdasdlkj' })
    article_two = described_class.create({ title: 'First!',
                                           body: 'This is another bodyThis is a body......aaslaslkdjaadsdreweenough' })
    expect(article_two.valid?).to be(false) # ask about # of assertions per test block...
  end

  it 'will create with all required parameters' do
    article = described_class.create({ title: 'Post #1',
                                       body: 'This is a body......aaskdlaslkdjaaslksalkareweenough?asdalkdasdlkjasdl' })
    expect(article.valid?).to be(true)
  end
  # write a test that creates the article, + search for the article Id and expect it to be present...

  it 'is located by its title' do
    article = described_class.create({ title: 'First!',
                                       body: 'This is a body of workThis is a body of workThis is a body of workThis' })
    # expect(Article.find_by(title: "First!")).to be_truthy
    expect(described_class.find_by(title: 'First!')).to eq article
  end
end
