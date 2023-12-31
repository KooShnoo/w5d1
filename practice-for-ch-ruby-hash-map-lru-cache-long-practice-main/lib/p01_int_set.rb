require "byebug"
class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' unless num.between?(0,  @store.length)
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def length
    # creating a length that gives us n 
    @store.map(&:length).sum
  end

  def insert(num)
    return if include?(num) 
    @count += 1 
    self[num] << num 
    if count > num_buckets
      resize!
    end
  end

  def remove(num)
    return unless include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    values = @store.flatten
    @store = [[]] * (num_buckets * 2)
    values.each { |val| self[val] << val  }
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end
end
