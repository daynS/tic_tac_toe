# lib/tic_tac_toe/game.rb

module TicTacToe
	class Game
		attr_reader :players, :board, :current_player, :other_player, :turn_number

		def initialize(players,board = Board.new)
			@players = players
			@board = board
			@current_player, @other_player = players.shuffle
			@turn_number = 1
		end

		def increment_turn_number
			@turn_number += 1
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def solicit_move
			"(Turn number #{turn_number}) #{current_player.name}: Enter a number between 1 and 9 to make your move"
		end

		def get_move(human_move = gets.chomp)
			increment_turn_number
			check = false			
			while check == false
				if valid_move?(human_move)
					check = true
					return human_move_to_coordinate(human_move)
				else
					puts "Invalid move. Try again."
					human_move = gets.chomp
				end
			end
		end

		def get_move_computer
			if @turn_number == 1
				increment_turn_number
				return human_move_to_coordinate("1")
			else
				valid_moves = find_valid_moves
				move = computer_strategy(valid_moves)
				increment_turn_number
				return human_move_to_coordinate(move.to_s) #Program errors if I pass an int to coordininate.
															#is it because int.to_i causes error? 
			end
		end

		def computer_strategy(valid_moves)
			current_board = board.current_board
			return 9

			#TODO add strategy
		end

		def find_valid_moves
			cell_number = 1
			valid_moves = []
				until cell_number >= 9
					if valid_move?(cell_number.to_s)
						valid_moves.push(cell_number)
					end
					cell_number += 1 
				end
			return valid_moves
		end

		

		def game_over_message
			return "#{current_player.name} won!" if board.game_over == :winner
			return "The game ended in a tie" if board.game_over == :draw
		end


		def play
			puts "#{current_player.name} has randomly been selected as the first player"
  			while true
  				board.formatted_grid
  				puts ""
  				if current_player.name != 'computer'
  					puts solicit_move
  					x, y = get_move
  					board.set_cell(x,y,current_player.color)
  				else
  					x, y = get_move_computer
  					board.set_cell(x,y,current_player.color)
  				end

  				if board.game_over
  					puts game_over_message
  					board.formatted_grid
  					return
  				else
  					switch_players
  				end
  			end
  		end

		private

		def valid_move?(human_move)
			if human_move.to_i.between?(1,9)
				x, y = human_move_to_coordinate(human_move)
				if board.get_cell(x,y).value.empty?
					return true
				else return false
				end
			else
				return false
			end
		end

		def human_move_to_coordinate(human_move)
			mapping = {
				"1" => [0, 0],
    			"2" => [1, 0],
    			"3" => [2, 0],
    			"4" => [0, 1],
   				"5" => [1, 1],
    			"6" => [2, 1],
    			"7" => [0, 2],
    			"8" => [1, 2],
    			"9" => [2, 2]
			}
			mapping[human_move]
		end

	end
end