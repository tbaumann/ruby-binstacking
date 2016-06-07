class AfternoonSession < Session

  def initialize(capacity)
    super(capacity)
    @start_time = Time.local(2016,"jan",1,13,0,0)
  end

  def start_time
    @start_time
  end

  # This appends the Networking Event which lasts as long as the remaining day
  def finalize
    @talks.push(Talk.new("Networking Event", (capacity - minutes)))
  end
end
