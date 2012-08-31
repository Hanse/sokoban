$:.unshift File.join(File.dirname(__FILE__), *%w[lib])

require 'sokoban'

level = ARGV.first ? ARGV.shift : 1
sokoban = Sokoban::Board.new(File.open("data/level#{level}.skn", "r").read)


loop do
  puts sokoban.draw
  input = gets.chomp
  exit if ["q", "quit", "exit"].include? input
  
  case input
    when "w" then sokoban.move :up
    when "s" then sokoban.move :down
    when "a" then sokoban.move :left
    when "d" then sokoban.move :right
  end

  if sokoban.solved?
    puts sokoban.draw
    puts "You solved the game in #{sokoban.moves} moves!"
    #sokoban.next_level!
    break
  end
end