class MorningSession < Session

  def initialize(capacity)
    super(capacity)
    @end_time = Time.local(2016,"jan",1,13,0,0)
  end

  def start_time
    @end_time - minutes * 60
  end

  # This appends the Lunch slot
  def finalize
    @capacity += 60
    @talks.push(Talk.new("Lunch", 60))
  end
end
