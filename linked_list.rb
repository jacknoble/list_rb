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
    return if empty?
    block.(@hd)
    @tl.each(&block)
  end

  def reverse
    reduce(empty_list) do |list, element|
      cons(element, list)
    end
  end

  # In-place reversal
  def reverse!(new_tail = empty_list)
    return self if empty?
    old_tail, @tl = @tl, new_tail
    return self if old_tail.empty?
    old_tail.reverse!(self)
  end

  def at(index)
    return if empty?
    return @hd if index.zero?
    tail.at(index - 1)
  end
  alias_method :[], :at

  def +(list)
    reverse.reduce(list) do |list, element|
      cons(element, list)
    end
  end

  def ==(other_list)
    return false if empty? != other_list.empty?
    return false if head != other_list.head
    return true if empty?
    @tl == other_list.tail
  end

  private

  def empty_list
    self.class.empty_list
  end

  def cons(head, tail)
    self.class.cons(head, tail)
  end
end

List = LinkedList
