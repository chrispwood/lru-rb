module LRU_RB
  class Queue
    def initialize()
      @items = []
      @mutex = Mutex.new
      @condvar = ConditionVariable.new
    end

    def push(value)
      @mutex.synchronize do
        @items << value
        @condvar.signal
      end
    end

    def pop()
      @mutex.synchronize do
        while @items.empty?
          @condvar.wait(@mutex)
        end

        @items.shift
      end
    end
  end
end
