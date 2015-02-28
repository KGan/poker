require 'rspec'
require 'hand.rb'
require 'humanize'

describe Hand do

  context "Initialize hand" do
    subject(:hands) { hand('as ks qs js 10s') }
    it "should initialize the hand to five cards" do
      expect(hands.num_cards).to eq(5)
    end
  end

  context "#hit" do

    it "should hit until five cards" do
      deck = Deck.new
      hand = Hand.deal_from(deck, 2)
      hand.hit(deck)
      expect(hand.num_cards).to eq(5)
    end
  end

  context '#return_cards' do
    it "should return cards to the deck" do
      deck = Deck.new
      cards_to_return = deck.take(3)
      hand = Hand.new(cards_to_return)
      hand.hit(deck)
      hand.return_cards(deck, cards_to_return)
      expect(hand.cards).to_not include(*cards_to_return)
      expect(hand.num_cards).to eq(2)
    end
  end

  context "Hand Evaluation" do
    #straight flush > 4kind > full house > flush > straight, 3kind, 2pair, pair, 1card high
    #straight flush is suit agnostic and can tie if high card is same value
    #4kind uses 5th as kicker after value
    #full house uses 3-card over 2-card, 3 first then 2
    #flush is value only comparison of decreasing value cards
    # value only, suit-agnostic can tie
    # two pair kicker.
    let(:straight_flush) { hand('as ks qs js 10s') }
    let(:four_kind) { hand('ks kd kc kh as') }
    let(:full_house) { hand('ks kd kc as ac') }
    let(:flush) { hand('ad qd jd 9d 6d') }
    let(:straight) { hand('ac kd qh jd 10s') }
    let(:three_kind) { hand('as ac ah qd jd') }
    let(:two_pair) { hand('as ac kh kd js') }
    let(:pair) { hand('as ac qh 7d js') }
    let(:card_high) { hand('as 3c 6h 9d js') }
    let(:straight_flush_low) { hand('ks qs js 10s 9s') }
    let(:four_kind_low) { hand('qd qs qc qh js') }
    let(:full_house_low) { hand('qs qc qh kd ks') }
    let(:flush_low) { hand('kh qh jh 9h 6h') }
    let(:straight_low) { hand('kc qd jh 10d 9s') }
    let(:three_kind_low) { hand('ks kc kh qd jd') }
    let(:two_pair_low) { hand('kh kd js jd qh') }
    let(:pair_low) { hand('ks kc qh 7d 4h') }
    let(:two_pair_kicker) { hand('ad ah kc ks 10s') }
    let(:pair_kicker) { hand('ad ah 10h 8d js') }
    let(:card_high_kicker) { hand('ad 10d 6h 8s 2d') }
    context "strict win by hand category value" do
      it 'should rank successive hands correctly' do
        expect(straight_flush).to have_higher_value_than(four_kind)
        expect(four_kind).to have_higher_value_than(full_house)
        expect(full_house).to have_higher_value_than(flush)
        expect(flush).to have_higher_value_than(straight)
        expect(straight).to have_higher_value_than(three_kind)
        expect(three_kind).to have_higher_value_than(two_pair)
        expect(two_pair).to have_higher_value_than(pair)
        expect(pair).to have_higher_value_than(card_high)
      end
    end

    context "within-category primary comparison" do
      it 'should rank higher hands of the same category' do
        expect(straight_flush).to have_higher_value_than(straight_flush_low)
        expect(four_kind).to have_higher_value_than(four_kind_low)
        expect(full_house).to have_higher_value_than(full_house_low)
        expect(flush).to have_higher_value_than(flush_low)
        expect(straight).to have_higher_value_than(straight_low)
        expect(three_kind).to have_higher_value_than(three_kind_low)
        expect(two_pair).to have_higher_value_than(two_pair_low)
        expect(pair).to have_higher_value_than(pair_low)
      end
    end

    context "within-category secondary comparison" do
      it 'should account for kickers' do
        expect(two_pair).to have_higher_value_than(two_pair_kicker)
        expect(pair).to have_higher_value_than(pair_kicker)
        expect(card_high).to have_higher_value_than(card_high_kicker)
      end
    end


  end
end



def hand(hand_str) # "5s 6c Kd 6c Kd"
  cards = []
  hand_str.split(" ").each do |card|
    value = card_value(card[0...-1])
    suit = suit_value(card[-1])
    cards << Card.new(suit, value)
  end
  Hand.new(cards)
end

def card_value(str)
  case str
  when "k"
    :king
  when 'q'
    :queen
  when 'j'
    :jack
  when 'a'
    :ace
  when '2'
    :deuce
  else
    str.to_i.humanize.to_sym
  end
end

def suit_value(str)
  case str
  when 's'
    :spades
  when 'd'
    :diamonds
  when 'c'
    :clubs
  when 'h'
    :hearts
  else
  end
end
