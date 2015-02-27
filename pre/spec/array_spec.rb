require 'rspec'
require 'array.rb'

RSpec.describe "Array Exercises" do

  describe '#my_uniq' do
    let(:unsorted) {(1..1000).to_a * 10}
    let(:sorted) {(1..1000).to_a}

    it 'removes duplicates' do
      expect(unsorted.my_uniq).to eq(sorted)
    end
  end

  describe '#two_sum' do
    let(:arr) { [-1, 0, 2, -2, 1] }
    it 'returns pair indices that sum to 0' do


      expect(arr.two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe '#my_transpose' do
      let(:rows) { [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8],
          [9, 10, 11]
        ] }
    it 'transposes the matrix' do
      expect(rows.my_transpose).to eq(rows.transpose)
      expect(rows).to_not receive(:transpose)

    end
  end

  describe '#stockpicker' do
    let (:stocks) {  [1, 10, 4, 8, 13, 6, 13]  }
    it 'picks the two best days' do

      expect(stockpicker(stocks)).to eq([0,4]).or eq([0,6])
    end
  end

end
