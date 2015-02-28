class Player
  attr_reader :name, :bankroll
  attr_accessor :hand

  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
  end

  def pay_winnings(bet_amt)
    @bankroll += bet_amt
  end

  def return_cards(deck)
    hand.return_cards(deck, hand.cards)
  end

  def place_bet(game, bet_amt)
    raise "you're too poor" if bet_amt > bankroll
    game.take_bet(self, bet_amt)
    @bankroll -= bet_amt
  end
end
