class Session < Array
  attr_reader :capacity, :talks, :end_time

  def initialize(capacity, end_time = nil)
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
    if can_fit?(talk)
      @talks.push(talk)
    else
      raise NotEnoughTimeInSessionError
    end
  end


  def to_ary
    @talks
  end

#  def to_a
#    @talks
#  end

  private
end

class NotEnoughTimeInSessionError < StandardError
end
