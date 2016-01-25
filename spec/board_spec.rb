require_relative '../test.rb'
require 'spec_helper'

describe Board do

  let(:board) { Board.new(3) }

  describe '#get_rows' do
    before do
      io_obj = double
      expect(board).to receive(:gets).and_return(io_obj)  
      expect(io_obj).to receive(:chomp).and_return(3)
    end
    
    it 'should take user input and set that to @rows' do
      board.get_rows
      expect(board.instance_variable_get(:@rows)).to eq(3)
    end
  end
  
  it 'layout should be an array' do
    expect(board.layout.class).to eq(Array)
  end

  it 'layout should have correct amount of rows' do
    expect(board.layout.length).to eq(board.rows)
  end
end
