require 'view/session_printer'
require 'session'
require 'talk'

RSpec.describe Printer::SessionPrinter do
  it 'prints' do
    talks = []
    talks.push(Talk.new("foo", 30))
    talks.push(Talk.new("bar", 5))
    expect(
        Printer::SessionPrinter.print(double("Session", talks: talks, minutes: 35, start_time: Time.local(2016,"jan",1,11,0,0)))
      ).to eq("11:00AM foo 30min\n11:30AM bar lightning\n")
  end
end
