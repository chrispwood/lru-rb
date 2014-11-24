require "lru_rb/version"
require 'thread'
require 'lru_rb/node'
require 'lru_rb/linked_list'
require 'lru_rb/lru_cache'
require 'lru_rb/queue'

module LRU_RB

  def self.test
    puts "testing..."
  end

  def self.cache
    @curr_cache ||= LruCache.new
  end
end
