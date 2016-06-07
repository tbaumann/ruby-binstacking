#!/usr/bin/env ruby

$LOAD_PATH.push("./lib/")

require 'talk'
require 'session'
require 'afternoon_session'
require 'morning_session'
require 'solver/first_fit'
require 'view/session_printer'
require 'pp'


def print_sessions(sessions)
  session_count = 0 # FIXME this is shit. There should be some kind of track container
  track_count = 0
  sessions.each do |session|
    session_count += 1
    if session_count % 2 != 0
      track_count += 1
      puts "\nTrack: #{track_count}"
    end
    puts Printer::SessionPrinter.print(session)
  end
end

def add_one_track(sessions)
  morning   = MorningSession.new(3*60, Time.local(2016,"jan",1,13,0,0))
  afternoon = AfternoonSession.new(4*60, Time.local(2016,"jan",1,13,0,0))
  sessions.push(morning)
  sessions.push(afternoon)
end

def read_input(all_talks)
  ARGF.each_line do |line|
    begin
      all_talks.push(Talk.parse_new(line))
    rescue TalkParseError
      $stderr.puts "Skipping unparsable line"
    end
  end
end

def finalize_sessions(sessions)
  sessions.each do |session|
    session.finalize
  end
end

all_talks = []
read_input(all_talks)

solver = Solver::FirstFit.new
solver.input = all_talks

# Define sorting algorythm
solver.sort_by do |a, b|
  b.length <=> a.length
end

#try stuffing it into track boxes
tracks = 1
begin
  sessions = [] #It's a bit dumb to re-create that all the time. But the solver modifies this at every run
  tracks.times do
    add_one_track(sessions)
  end
  solver.sessions = sessions
  solver.solve

rescue NotEnoughTimeInSessionError
  #Retry with more boxes. This is a little bute force but works
  tracks += 1
  retry
end

finalize_sessions(sessions)

print_sessions(sessions)
