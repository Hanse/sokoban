module Sokoban
  class Board
    attr_accessor :player, :tiles, :moves

    def initialize(level)
      @tiles, @moves = [], 0
      level.split("\n").each_with_index do |line, row|
        @tiles[row] = []
        line.split(//).each_with_index do |tile, column|
          @player = Sokoban::Player.new(column, row) if tile == Sokoban::ICONS[:player]
          @tiles[row][column] = Sokoban::Tile.new(:icon => tile)
        end
      end
    end

    def move(direction)
      case direction
        when :up    then dx, dy = 0, -1
        when :down  then dx, dy = 0, 1
        when :left  then dx, dy = -1, 0
        when :right then dx, dy = 1, 0
      end

      tile = @tiles[player.y + dy][player.x + dx]

      if tile.floor? or tile.storage?
        move_player(dx, dy)
        @moves += 1
      elsif tile.crate?
        push_crate(dx, dy)
        @moves += 1
      end
    end

    def push_crate(dx, dy)
      adj = @tiles[player.y+2*dy][player.x+2*dx]
      unless adj.wall? or adj.crate? or adj.storage_with_crate?
        adj.icon = adj.storage? ? Sokoban::ICONS[:storage_with_crate] : Sokoban::ICONS[:crate]
        move_player(dx, dy)
      end
    end

    def move_player(dx, dy)
      adj = @tiles[@player.y + dy][@player.x + dx]
      adj.icon = adj.storage? ? Sokoban::ICONS[:player_on_storage] : Sokoban::ICONS[:player]
      cur = @tiles[@player.y][@player.x]
      cur.icon = cur.player_on_storage? ? Sokoban::ICONS[:store] : Sokoban::ICONS[:floor]
      @player.x += dx
      @player.y += dy
    end

    def solved?
      @tiles.each_with_index do |line, row|
        line.each_with_index do |tile, column|
          return false if tile.crate?
        end
      end
      true
    end

    def draw
      @tiles.map { |row| row.join }.join("\n")
    end
  end
end