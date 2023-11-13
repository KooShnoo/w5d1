require "byebug"
class Node
  # attr_reader :key
  attr_accessor :val, :next, :prev, :key

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

end

class LinkedList
  include Enumerable

  def initialize 
    @head = Node.new()
    @tail = Node.new()
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    return nil if empty?
    @head.next
  end

  def last
    return nil if empty?
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    node = find { |node| node.key == key }
    node.nil? ? nil : node.val
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    new_node = Node.new(key, val)

    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev.next = new_node
    @tail.prev = new_node
  end

  def update(key, val)
    node = find { |node| node.key == key }
    return nil if node.nil?
    node.key = key
    node.val = val
  end

  def remove(key)
    node = find { |node| node.key == key }
    node.prev.next = node.next
    node.next.prev = node.prev
  end

  def each
    curr_node = @head
    while curr_node != @tail.prev
      curr_node = curr_node.next
      yield curr_node
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end