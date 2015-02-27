require 'deck.rb'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }
  let(:cards) {[
    instance_double("Card", :suit => :hearts, :value => :king),
    instance_double("Card", :suit => :spades, :value => :three)
  ]}
  context 'deck creation' do
    it 'should instantiate a 52 card poker deck' do
      expect(Deck.all_cards.length).to eq(52)
      expect(Deck.all_cards.uniq).to eq(Deck.all_cards)
    end
  end

  context 'taking cards from deck' do
    it 'should take cards from the deck' do
      deck.take(2)
      expect(deck.count).to be(50)
    end

    it 'should raise an error if not enough cards' do
      expect do
        deck.take(100)
      end.to raise_error("not enough cards")
    end
  end

  context 'returning cards to deck' do
    it 'should receive cards' do
      deck.return_cards(cards)
      expect(deck.count).to be(54)
    end
  end
end
