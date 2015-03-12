# lib/tic_tac_toe/player.rb
module TicTacToe
	#initialized with a hash
	#fetch grabs value pair of key, throws error if no value
	#fetch has many other great features
	class Player
		attr_reader :color, :name
		def initialize(input) 
			@color = input.fetch(:color) 
			@name = input.fetch(:name)
		end
	end
	
end