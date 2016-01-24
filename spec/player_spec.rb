require_relative '../app.rb'
require 'spec_helper'


describe Player do

  let(:player) { Player.new("X", "The Computer") }

  it 'should create 4 empty arrays on initialize' do
    expect(player.nested_selections).to eq([])
    expect(player.outer_selections).to eq([])
    expect(player.diags).to eq([])
    expect(player.diags2).to eq([])  
  end
  
  describe '#get_letter' do
    before do
      io_obj = double
      expect(player).to receive(:gets).and_return(io_obj)  
      expect(io_obj).to receive(:chomp).and_return("x")
    end
    
    it 'will receive user input from gets.chomp and upcase letter' do
      player.get_letter
      expect(player.instance_variable_get(:@letter)).to eq("X")
    end
  end  

  describe '#get_name' do    
    before do
      io_obj = double
      expect(player).to receive(:gets).and_return(io_obj)
      expect(io_obj).to receive(:chomp).and_return("Test User")
    end
    
    it 'sets name according to user input' do
      player.get_name      
      expect(player.instance_variable_get(:@name)).to eq("Test User")
    end
  end

  describe '#opponent' do
    it 'will return the opponent\'s letter' do
      expect(player.opponent).to eq("O")
    end
  end
end
