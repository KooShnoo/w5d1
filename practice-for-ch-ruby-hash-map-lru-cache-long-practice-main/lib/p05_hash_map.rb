require_relative 'p04_linked_list'

class HashMap
  # attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    !get(key).nil?
  end

  def set(key, val)
    unless self[key].nil?
      bucket(key).update(key, val)
      return
    end
    resize! if count > num_buckets
    @store[key.hash % num_buckets].append(key, val)
  end

  def get(key)
   bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
  end

  def each
    @store.map(&:to_a).map { |bucket| bucket.map { |node| [node.key, node.val] } }.flatten(1).each do |kvpair|
      yield kvpair
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    data = to_a
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    data.each do |key, value|
      self[key] = value
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
