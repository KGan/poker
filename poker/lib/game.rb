class Game
  def initialize(*players)
    @players = players
    @bets = {}
    @deck = Deck.new
  end

  def play
    @deck.cards.shuffle!
    until winner
      until no_folds
        round
      end
      distribute_pot
    end
    print winner
  end

  def round
    take_blinds
    deal_cards
    collect_bets
    collect_cards
  end

  def take_blinds

  end

  def deal_cards

  end

  def collect_bets

  end

  def collect_cards

  end

  def distribute_pot

  end

  def winner

  end

  def no_folds

  end
end
