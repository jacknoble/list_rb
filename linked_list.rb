class LinkedList
  include Enumerable
  attr_reader :hd, :tl
  alias_method :head, :hd
  alias_method :tail, :tl

  class << self
    alias_method :cons, :new

    def [](*members)
      from_a(members)
    end

    def from_a(members)
      return empty_list if members.empty?
      head, *rest = members
      cons(head, from_a(rest))
    end

    def empty_list
      cons(nil, nil)
    end
  end

  def initialize(head, tail)
    @hd = head
    @tl = tail
  end

  def to_s
    "List#{self.to_a}"
  end

  def empty?
    @hd.nil? && @tl.nil?
  end

  def each(&block)
    block.(@hd)
    @tl.each(&block) unless @tl.empty?
  end

  def reverse
    reduce(self.class.empty_list) do |list, element|
      self.class.cons(element, list)
    end
  end

  def at(index)
    return if empty?
    return @hd if index.zero?
    tail.at(index - 1)
  end
  alias_method :[], :at

  def +(list)
    reverse.reduce(list) do |list, element|
      self.class.cons(element, list)
    end
  end
end

List = LinkedList
