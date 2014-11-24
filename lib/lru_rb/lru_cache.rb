require 'thread'

module LRU_RB
  class LruCache
    attr_reader :max_size, :current_size

    def initialize(max_size=100)
      @max_size = max_size
      @current_size = 0

      @cache_h = Hash.new
      @cache_lru = LinkedList.new
      @mutex = Mutex.new
    end

    def add(key,val)
      @mutex.synchronize do
        if @cache_h.has_key? key
          @cache_lru.push(@cache_lru.remove([key,val]))
        else
          @cache_lru.push [key,val]
        end
        @cache_h[key] = val

        ret = nil
        if @cache_lru.size > max_size
          val = @cache_lru.remove_tail
          @cache_h.delete(val[0])
          ret = val
        end

        ret
      end
    end

    def get(key)
      @mutex.synchronize do
        val = nil
        if @cache_h.has_key? key
          val = @cache_h[key]
          @cache_lru.push(@cache_lru.remove([key,val]))
        end
        val
      end
    end

    def print
      @mutex.synchronize do
        @cache_lru.print
      end
    end

  end
end
