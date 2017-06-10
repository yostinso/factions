class Factorio::API::Error < StandardError
  attr_reader :category, :message, :inner_exception

  def initialize(category, message, inner_exception=nil)
    @category = category
    @message = message
    @inner_exception = inner_exception
  end

  def to_s
    "(#{category}) #{message}" + (inner_exception ? " [#{inner_exception.class.name}: #{inner_exception.to_s}]" : "")
  end
end
