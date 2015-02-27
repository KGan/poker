require_relative 'card.rb'
class Deck

  def self.all_cards
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
          cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = Deck.all_cards)
    @cards = cards
  end

  def count
    @cards.length
  end

  def take(num)
    raise "not enough cards" if num > count
    @cards.shift(num)
  end

  def return_cards(cards)
    @cards += cards
  end
end
