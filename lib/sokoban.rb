require 'sokoban/board'
require 'sokoban/tile'
require 'sokoban/player'

module Sokoban
  ICONS = {
    :storage => '.',
    :player  => '@',
    :crate   => 'o',
    :wall    => '#',
    :floor   => ' ',
    :storage_with_crate => '*',
    :player_on_storage  => '+'
  }

  class IllegalMove < Exception; end;
end