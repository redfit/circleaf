require 'spec_helper'

class TestArticle
  include Markdownable
  attr_accessor :content
  markdownable :content
end

describe Markdownable do
  let(:content) { '# head' }
  let(:article) do
    a = TestArticle.new
    a.content = content
    return a
  end
  subject { article } 
  it { subject.content_markdown.should eq "<h1>head</h1>\n" } 
end
