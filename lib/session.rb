class Session < Array
  attr_reader :capacity

  def initialize(capacity)
    @talks = []
    @capacity = capacity
  end

  # total length of all containing talks
  def minutes
    @talks.reduce(0){|sum, talk| sum + talk.length}
  end

  def can_fit?(talk)
    @capacity >= minutes + talk.length
  end

  def push(talk)
    @talks.push(talk)
  end

  def to_ary
    @talks
  end

  def to_a
    @talks
  end

  private
end
