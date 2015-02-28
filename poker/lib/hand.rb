require_relative 'deck.rb'
require 'byebug'
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
    cardsh = card_hash
    cards_with_counts = cardsh.sort_by {|key, value| value}
    high_count_card = cards_with_counts[-1]
    if is_straight? && is_flush?
      return [8, cardsh.keys.max]

    elsif high_count_card[1] == 4
      return [7, high_count_card[0]]

    elsif high_count_card[1] == 3 && cardsh.values.include?(2)
      return [6, high_count_card[0]] #, cardsh.keys - high_count_cards[0]

    elsif is_flush?
      return [5] + cardsh.keys.sort.reverse

    elsif is_straight?
      return [4, cardsh.keys.max]

    elsif high_count_card[1] == 3
      return [3, high_count_card[0]]

    elsif high_count_card[1] == 2 && cards_with_counts[-2][1] == 2
       return [2, high_count_card[0], cards_with_counts[-2][0], cards_with_counts[0][0]]

    elsif high_count_card[1] == 2
      cards_keys = cards_with_counts.map { |card, count| card }
      return [1, high_count_card[0]] + (cards_keys - [high_count_card[0]])

    else
      return [0] + @cards
    end
  end

  def hit(deck)
    @cards += deck.take(5 - num_cards)
  end

  def has_higher_value_than?(other_hand)
    cate = points
    oth_cate = other_hand.points

    until cate.empty? || oth_cate.empty?
      elem1, elem2 = cate.shift, oth_cate.shift
      if elem1 > elem2
        return true
      elsif elem2 > elem1
        return false
      end
    end
    nil
  end


  def sort_hand
    @cards = @cards.sort_by { |card| card.poker_value }
  end

  def return_cards(deck, cards)
    deck.return_cards(cards)
    @cards -= cards
  end

  def to_s
    @cards.join(",") + " (#{points})"
  end

  def is_straight?
    sort_hand
    previous_card = @cards.first
    @cards[1..-1].each do |card|
      return false if (card.poker_value - previous_card.poker_value).abs != 1
      previous_card = card
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
    hash = Hash.new(0)
    @cards.each do |card|
      hash[card.poker_value] += 1
    end
    hash
  end

  def num_cards
    @cards.length
  end
end
