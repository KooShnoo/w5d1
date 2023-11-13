class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    inject { |acc, v| (acc + v) * 7 }.hash
  end
end

class String
  def hash
    each_char.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.flatten.map(&:to_s).sort.hash
  end
end
