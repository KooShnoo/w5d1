require_relative "p01_int_set"

class HashSet < ResizingIntSet
  # attr_reader :count

  # def initialize(num_buckets = 8)
  #   @store = Array.new(num_buckets) { Array.new }
  #   @count = 0
  # end

  # def insert(key)
  #   super
  # end

  # def include?(key)
  #   # self[key].include?(key)
  #   super
  # end

  # def remove(key)
  #   super
  # end

  # private

  # def num_buckets
  #   @store.length
  # end

  # def resize!
  #   super
  # end

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets] 
  end
end