module Printer
  class SessionPrinter

    def self.print(session)
      out = ""
      curr_time = session.start_time
      session.talks.each do |talk|
        out += "#{curr_time.strftime("%I:%M%p")} #{talk.desc} #{talk.length != 5?"#{talk.length}min":"lightning"}\n"
        curr_time += talk.length * 60
      end
      out
    end

  end
end
