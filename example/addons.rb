#/example/addons.rb

require_relative "../lib/tic_tac_toe.rb"

puts "Welcome to tic tac toe"

puts "Player one, please enter your name: "
playerOne = gets.chomp
puts "Player two, please enter your name (enter 'computer' for AI player): "
playerTwo = gets.chomp
P1 = TicTacToe::Player.new({color: "X", name: playerOne})
P2 = TicTacToe::Player.new({color: "O", name: playerTwo})
players = [P1, P2]

TicTacToe::Game.new(players).play