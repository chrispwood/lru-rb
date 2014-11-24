module LRU_RB
  class Node
    attr_accessor :value, :next, :previous

    def initialize(value=nil)
      @value = value
      @next = nil
      @previous = nil
    end
  end
end
