#/example/tester.rb

require_relative "../lib/tic_tac_toe.rb"

puts "Welcome to tic tac toe"

playerOne = "dayn"
playerTwo = "computer"
P1 = TicTacToe::Player.new({color: "X", name: playerOne})
P2 = TicTacToe::Player.new({color: "O", name: playerTwo})
players = [P1, P2]

TicTacToe::Game.new(players).play