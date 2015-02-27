require 'rspec'
require 'towers_of_hanoi.rb'

describe 'TowersOfHanoi' do
  subject(:game) { TowersOfHanoi.new }
  context 'initialization' do
    let(:starting_array) { [[3, 2, 1], [], []] }
    let(:custom_array) { [[2], [3,1], []] }
    it 'should initialize the stacks' do
      expect(game.stacks).to eq(starting_array)
    end

    it 'should initialize specific stacks' do
      g = Game.new(custom_array)
      expect(g.stacks).to eq(custom_array)
    end
  end

  context 'movement' do
    let(:invalid_move) { [2, 0] }
    let(:valid_moves) { [[0, 1], [0, 2]]}

    it 'should error on invalid moves' do
      expect(game.move(invalid_move)).to raise_error
    end

    it 'should accept valid moves' do
      valid_moves.each do |move|
        game.move(move)
      end
      expect(game.stacks).to eq([[3], [1], [2]])
    end
  end

  context 'winning' do
    let(:winning_arrays) { [  [[],[],[3,2,1]], [[],[3,2,1],[]]  ] }

    it 'should win on farthest stack' do
      expect(Game.new(winning_arrays[0])).to be_won
    end

    it 'should win on closer stack' do
      expect(Game.new(winning_arrays[1])).to be_won
    end

    it 'should not win on starting stack' do
      expect(game).to_not be_won
    end

  end
end
