module Solver
  class FirstFit

    attr_accessor :input, :sessions

    def initialize
      @input = []
      @sessions = []
    end

    def sort_by(&sorter)
      @sort_by = sorter
    end

    def solve
      @input.sort!(&@sort_by)

      # get cyclic enumerator
      session_enum = sessions.cycle

      @input.each do |talk|
        tries = 0
        begin
          session_enum.next.push(talk)
        rescue NotEnoughTimeInSessionError => e
          if tries < @sessions.length
            # Chances are we can still find a session to fit it in
            tries += 1
            retry
          else
            ## Pass the exeption down
            raise e
          end
        end
      end
      @input = []
    end

    private

  end
end
