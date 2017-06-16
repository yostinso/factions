module YieldHelper
  class YieldProbe
    def self.probe(method, limit: 20)
      YieldProbe.new(method, limit: limit).probe!
    end

    def initialize(method, limit: 20)
      @method = method
      @limit = limit
    end

    def record_probe(args)
      @values << args
    end

    def results
      @values
    end

    def probes
      @probes
    end

    def probe!
      @values = []
      @probes = catch(:limit_reached) {
        @method.call(self)
        0
      }
      self
    end

    def to_proc
      probe = self
      probes = 0
      Proc.new do |*args|
        probes += 1
        if @limit && @limit.to_i > 0 && probes > @limit
          throw :limit_reached, probes
        end
        probe.record_probe(args)
        nil
      end
    end
  end

  RSpec::Matchers.define :yield_matchable_args do |matcher, limit: 20|
    match do |method|
      probe = YieldProbe.probe(method, limit: limit)
      if probe.probes > limit
        @actual = { calls: probe.probes }
        @expected = { calls: limit }
        false
      else
        @actual = probe.results
        values_match? matcher, @actual
      end
    end

    failure_message do |actual|
      if @actual.is_a?(Hash) && actual[:limit]
        "expected that block would yield fewer than #{limit} times"
      else
        formatted_expected = RSpec::Support::ObjectFormatter.format(matcher)
        formatted_actual = RSpec::Support::ObjectFormatter.format(actual)
        "expected block would yield with\n" +
	"         #{formatted_expected}\n" +
        " but got #{formatted_actual}"
      end
    end

    diffable
    supports_block_expectations
  end
end
