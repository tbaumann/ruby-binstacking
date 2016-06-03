class Talk
  attr_accessor :desc, :length
  def initialize(desc, length)
    if(length)
      @desc = desc
      @length = length
    else
      parse(desc)
    end
  end

  def self.parse_new(input)
    ## FIXME parameter checking
    input =~ /^(.*?) (\d*min|lightning)$/
    desc = $1
    length = $2
    if(length == 'lightning')
      length = 5
    else
      length =~ /(\d+)min/
      length = Integer($1)
    end
    Talk.new(desc, length)
    rescue
      raise TalkParseError
  end

  private
end
class TalkParseError < StandardError
end
