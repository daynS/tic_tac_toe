# lib/tic_tac_toe/game.rb

module TicTacToe
	class Game
		attr_reader :players, :board, :current_player, :other_player, :turn_number

		def initialize(players, board = Board.new)
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
				random_corner = [1,3,7,9]
				return human_move_to_coordinate(random_corner.sample.to_s)

			elsif @turn_number == 3 && board.get_cell(1,1).value.empty?
					return human_move_to_coordinate("5")
			else
				increment_turn_number
				move = computer_strategy
				if move.is_a? Array
					return move
				else
					return human_move_to_coordinate(move.to_s)
				end
															#Program errors if I pass an int to coordininate.
															#is it because int.to_i causes error?
			end
		end

		def computer_strategy
			x_cells = find_Xs
			puts "X cells #{x_cells}"
			o_cells = find_Os
			puts "O cells #{o_cells}"
			valid_moves = find_valid_moves
			puts "valid moves #{valid_moves}"

			puts "columninfo: #{current_board_columns}"

			if winning_move(current_board_rows, current_board_columns, current_board_diagonals) != 0
				puts "win move: #{winning_move(current_board_rows, current_board_columns, current_board_diagonals)}"
				return winning_move(current_board_rows, current_board_columns, current_board_diagonals)
			end

			if defensive_move(current_board_rows, current_board_columns, current_board_diagonals) != 0
				return defensive_move(current_board_rows, current_board_columns, current_board_diagonals)
			end

			return valid_moves.sample
		end


		#return the x,y coordinate for winning move
		def winning_move(rows, columns, diagonals)
			row_number = 0
			rows.each do |row|
				counter = 0
				if row.include? ""
					row.each do |cell|
						if cell == "O"
							counter += 1
						end
					end
					if counter == 2
						return [row.index(""), row_number]
					end
				end
				row_number += 1
			end

			column_number = 0
			columns.each do |column|
				counter = 0
				if column.include? ""
					column.each do |cell|
						if cell == "O"
							counter += 1
						end
					end
					if counter == 2
						return [column_number, column.index("")]
					end
				end
				column_number += 1
			end

			diagonal_number = 0 #1,5,9 is 0; 753 is 1
			diagonals.each do |diagonal|
				counter = 0
				if diagonal.include? ""
					diagonal.each do |cell|
						if cell == "O"
							counter += 1
						end
					end
					if counter == 2
						winning_move = [diagonal_number, diagonal.index("")]
						return check_diagonal(winning_move)
					end
				end
				diagonal_number += 1
			end


			return 0
		end

		#translates the position in the diagonals array to an actual cell location
		def check_diagonal(winning_move)
			case winning_move
			when [0,0]
				return [0,0]
			when [0,1], [1,1]
				return [1,1]
			when [0,2]
				return [2,2]
			when [1,0]
				return [0,2]
			when [1,2]
				return [2,0]
			end
		end


		def defensive_move(rows, columns, diagonals)
			row_number = 0
			rows.each do |row|
				counter = 0
				if row.include? ""
					row.each do |cell|
						if cell == "X"
							counter += 1
						end
					end
					if counter == 2
						return [row.index(""), row_number]
					end
				end
				row_number += 1
			end

			column_number = 0
			columns.each do |column|
				counter = 0
				if column.include? ""
					column.each do |cell|
						if cell == "X"
							counter += 1
						end
					end
					if counter == 2
						return [column_number, column.index("")]
					end
				end
				column_number += 1
			end

			diagonal_number = 0 #1,5,9 is 0; 753 is 1
			diagonals.each do |diagonal|
				counter = 0
				if diagonal.include? ""
					diagonal.each do |cell|
						if cell == "X"
							counter += 1
						end
					end
					if counter == 2
						winning_move = [diagonal_number, diagonal.index("")]
						return check_diagonal(winning_move)
					end
				end
				diagonal_number += 1
			end

			return 0
		end


		def current_board_diagonals
			diag_one_cells = [1,5,9]
			diag_two_cells = [7,5,3]

			diag_one = []
			diag_one_cells.each do |cell|
				x, y = human_move_to_coordinate(cell.to_s)
				if board.get_cell(x,y).value.empty?
					diag_one.push("")
				else
					diag_one.push(board.get_cell(x,y).value)
				end
			end
			
			diag_two = []
			diag_two_cells.each do |cell|
				x, y = human_move_to_coordinate(cell.to_s)
				if board.get_cell(x,y).value.empty?
					diag_two.push("")
				else
					diag_two.push(board.get_cell(x,y).value)
				end
			end

			return diagonals = [diag_one, diag_two]
		end
 

		def current_board_rows
			cell_number = 1

			row_one = []
			until cell_number == 4
				x, y = human_move_to_coordinate(cell_number.to_s)
				if board.get_cell(x,y).value.empty?
					row_one.push("")
				else
					row_one.push(board.get_cell(x,y).value)
				end
				cell_number += 1
			end

			row_two = []
			until cell_number >= 7
				x, y = human_move_to_coordinate(cell_number.to_s)
				if board.get_cell(x,y).value.empty?
					row_two.push("")
				else
					row_two.push(board.get_cell(x,y).value)
				end
				cell_number += 1
			end

			row_three = []
			until cell_number >= 10
				x, y = human_move_to_coordinate(cell_number.to_s)
				if board.get_cell(x,y).value.empty?
					row_three.push("")
				else
					row_three.push(board.get_cell(x,y).value)
				end
				cell_number += 1
			end

			rows = [row_one, row_two, row_three]
			return rows
		end

		def current_board_columns
			current_board_rows.transpose
		end

		def find_Xs
			cell_number = 1
			x_cells = []
			until cell_number >= 9
				x, y = human_move_to_coordinate(cell_number.to_s)
				if board.get_cell(x,y).value == "X"
					x_cells.push(cell_number)
				end
				cell_number += 1
			end
			return x_cells
		end

		def find_Os
			cell_number = 1
			o_cells = []
			until cell_number >= 9
				x, y = human_move_to_coordinate(cell_number.to_s)
				if board.get_cell(x,y).value == "O"
					o_cells.push(cell_number)
				end
				cell_number += 1
			end
			return o_cells
		end

		def find_valid_moves
			cell_number = 1
			valid_moves = []
				until cell_number >= 10
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