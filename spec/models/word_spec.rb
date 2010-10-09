require 'spec_helper'

describe Word do
  before do
    @words = [Factory.create(:word)]
  end
  it 'computes statistics' do
    counts = Word.letter_counts @words.first.denotations.first.lang
    counts.should == { @words[0].name[0,1] => 1 }
  end
end
