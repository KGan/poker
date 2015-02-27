require_relative 'deck.rb'
class Hand
  # This is called a *factory method*; it's a *class method* that
  # takes the a `Deck` and creates and returns a `Hand`
  # object. This is in contrast to the `#initialize` method that
  # expects an `Array` of cards to hold.
  def self.deal_from(deck, num)
    Hand.new(deck.take(num))
  end

  attr_accessor :cards

  def initialize(cards)
    @cards = cards
  end


  def points
    c = card_hash
    cards_with_counts = c.sort_by {|key, value| value}
    high_count_card = cards_with_counts[-1]
    if is_straight? && is_flush?
      return 8, c.keys.max
    elsif high_count_card[1] == 4
      return 7, high_count_card[0]
    elsif high_count_card[1] == 3 && c.values.include?(2)
      return 6, high_count_card[0], c.keys - high_count_cards[0]
    elsif is_flush?
      return 5, c.keys.max
    elsif is_straight?
      return 4, c.keys.max
    elsif high_count_card[1] == 3
      return 3, high_count_card[0]
    elsif high_count_card[1] == 2 && cards_with_counts[-2][1] == 2
      return 2, high_count_card[0], cards_with_counts[-2][0], cards_with_counts[0]
    elsif high_card_count[1] == 2
      return 1, high_card_count[0], cards_with_counts - high_card_count
    else
      return 0, @cards
    end
  end

  def hit(deck)
  end

  def has_higher_value?(other_hand)
    return false
  end

  def sort_hand
    @cards = @cards.sort_by { |card| card.poker_value }
  end

  def return_cards(deck)
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end

  def is_straight?
    previous_card = @cards.first
    @cards[1..-1].each do |card|
      return false if card.poker_value - previous_card.poker_value != 1
    end
    true
  end

  def is_flush?
    previous_card = @cards.first
    @cards[1..-1].all? do |card|
      card.suit == previous_card.suit
    end
  end

  def card_hash
    Hash.new(0).tap do |hash|
      @cards.each do |card|
        hash[card.value] += 1
      end
    end
  end

end
