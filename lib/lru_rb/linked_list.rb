module LRU_RB
  class LinkedList

    def initialize()
      @head = nil
      @tail = nil
      @length = 0
    end

    def size
      @length
    end

    def push(value)
      val = Node.new(value)
      val.next = @head
      @head.previous = val unless @head.nil?
      @tail = val if @head.nil?
      @head = val
      @length += 1
    end

    def enqueue(value)
      val = Node.new(value)

      if @head.nil?
        @head = val
        @tail = @head
      else
        @tail.next = val
        val.previous = @tail
        @tail = val
      end

      @length += 1
    end

    def add_at(value, location)
      raise "location must be between 0 and the size of the list (#{@length})" \
        if location < 0 || location > @length

      val = Node.new(value)
      if location==@length
        @tail.next = val
        val.previous = @tail
        @tail = val
        @length += 1
      else
        iterate(->(i, node) do
          if location==i
            val = @head if node==@head
            val.previous = node.previous
            val.next = node
            node.previous.next = val
            node.previous = val
            @length += 1
          end
          end)
      end

    end

    def value_at(location)
      raise "location must be between 0 and the size of the list (#{length})" \
        if location < 0 || location > @length

      val = nil
      iterate(->(i, node) { if i==location; val = node.value; false end })
      val
    end

    def pop
      return nil if @length == 0

      tmp = @head
      @head = @head.next
      @length -= 1

      if @length==0
        @tail = nil
      end

      tmp.value
    end

    def remove(value)
      return nil if @length == 0
      val = nil
      iterate(->(i,node) do
          if node.value==value
            node.previous.next = node.next unless node.previous.nil?
            node.next.previous = node.previous unless node.next.nil?
            @head = node.next if node==@head
            @tail = node.previous if node==@tail
            @length -= 1
            val = node.value
            false
          end
        end)
      val
    end

    def remove_tail
      return nil if @length == 0
      val = @tail
      @tail.previous.next = nil if !@tail.previous.nil?
      @tail = @tail.previous
      @length -= 1
      val.value
    end

    def iterate(lamb)
      raise 'iterate requires a lambda!' unless lamb.lambda?

      node = @head
      i = 0
      while !node.nil? do
        if lamb.call(i,node)
          break
        end
        node = node.next
        i += 1
      end
      node
    end

    def print
      iterate(->(i,node){puts "#{node.value}\n"; false})
    end
  end
end
