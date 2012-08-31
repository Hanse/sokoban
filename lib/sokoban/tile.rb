module Sokoban
  class Tile
    attr_accessor :icon

    def initialize(options)
      @icon = options[:icon]  
    end

    %w(floor crate wall storage storage_with_crate player_on_storage).each do |type|
      define_method("#{type}?") { @icon == Sokoban::ICONS[type.to_sym] }
    end

    def to_s
      @icon
    end
  end
end