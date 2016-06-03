require 'view/session_printer'
require 'session'
require 'talk'

RSpec.describe Printer::SessionPrinter do
  it 'prints' do
    talks = []
    talks.push(Talk.new("foo", 30))
    talks.push(Talk.new("bar", 5))
    expect(
        Printer::SessionPrinter.print(double("Session", talks: talks, start: Time.local(2016,"jan",1,9,0,0)))
      ).to eq("09:00AM foo 30min\n09:30AM bar lightning\n")
  end
end
