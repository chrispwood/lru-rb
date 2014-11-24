require "bundler/gem_tasks"
require "lru_rb"

desc "test thread safety"
task :thread_test do
  get_queue = Queue.new
  discard_queue = Queue.new
  cache = LRU_RB::LruCache.new(75)

  total = 1_000_000
  hits = 0

  data = Hash.new
  100.times do |i|
    data["key#{i+1}"] = "item # #{i+1}"
  end

  threads = []

  # main thread
  threads << Thread.new do
    total.times do
      v = Random.rand(1..100)
      key = "key#{v}"
      val = cache.get(key)
      if val.nil?
        d = cache.add(key, data[key])
        if !d.nil?
        end
        discard_queue.push(d) unless d.nil?
      else
        get_queue.push(val)
      end
    end
    discard_queue.push(:kill)
    get_queue.push(:kill)
  end

  threads << Thread.new do
    while true do
      d = discard_queue.pop
      break if d == :kill
      print "grabbed discard item #{d}\n"
    end
  end

  threads << Thread.new do
    while true do
      v = get_queue.pop
      break if v == :kill
      hits += 1
      print "grabbed get item #{v}\n"
    end
  end

  threads.each {|t| t.join}

  puts "There were #{hits} hits out of #{total} total reqests, with a cache hit ratio of #{((hits.to_f/total.to_f)*100)}"
end

desc "test the cache"
task :test do
  puts "testing..."
  puts "cache max size is #{LRU_RB.cache.max_size}"
  puts "cache curr size is #{LRU_RB.cache.current_size}"

  cache = LRU_RB::LruCache.new(5)
  cache.add('a',"a good thing")
  cache.add('b',"b good thing")
  cache.add('c',"c good thing")
  cache.add('d',"d good thing")
  cache.add('e',"e good thing")
  val = cache.add('f',"f good thing")
  raise "expected cache to reject a but instead it was #{val}" unless val[0]=='a'

  cache.get('b')
  val = cache.add('a','a good thing')
  raise "expected cache to reject c but instead it was #{val}" unless val[0]=='c'
  cache.print

  cache.add('a',"a good thing")
  cache.add('a',"a good thing")
  cache.add('a',"a good thing")
  cache.add('a',"a good thing")
  cache.add('a',"a good thing")
end

desc "test the linked list"
task :test_ll do
  ll = LRU_RB::LinkedList.new
  raise 'Head should be nil' unless ll.value_at(0).nil?
  puts "head is nil #{ll.value_at(0).to_s}"

  # add some items
  ll.enqueue('cool')
  ll.enqueue('fun')
  ll.enqueue('boring')
  raise "linked list should be 3 but was #{ll.size}" unless ll.size==3

  # add at
  ll.add_at('nice', 2)
  raise 'item at 1 should be fun' unless ll.value_at(1) == 'fun'
  raise 'item at 2 should be nice' unless ll.value_at(2) == 'nice'
  raise 'item at 3 should be boring' unless ll.value_at(3) == 'boring'
  ll.add_at('wow',4)
  raise 'item at 3 should be boring' unless ll.value_at(3) == 'boring'
  raise 'item at 3 should be wow' unless ll.value_at(4) == 'wow'
  raise "size should be 5 but was #{ll.size}" unless ll.size == 5
  puts "----------"
  ll.print

  val = ll.pop
  raise "pop should be cool but was #{val}" unless val=='cool'
  val = ll.pop
  raise "pop should be fun but was #{val}" unless val=='fun'
  raise "size should be 3 but was #{ll.size}" unless ll.size == 3

  puts "----------1"
  ll.print
  val = ll.remove('nice')
  raise "value should be 'nice' but was #{val}" unless val=='nice'
  raise "ll should be 2 but was #{ll.size}" unless ll.size==2
  ll.push('nice')
  puts "----------2"
  ll.print
  val = ll.remove('boring')
  raise "value should be 'boring' but was #{val}" unless val=='boring'
  raise "ll should be 2 but was #{ll.size}" unless ll.size==2
  ll.add_at('boring',1)
  puts "----------3"
  ll.print
  val = ll.remove('wow')
  raise "value should be 'wow' but was #{val}" unless val=='wow'
  raise "ll should be 2 but was #{ll.size}" unless ll.size==2
  ll.add_at('wow',2)
  puts "----------4"
  ll.print
end
