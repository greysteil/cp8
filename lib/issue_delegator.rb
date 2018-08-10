class IssueDelegator
  LABEL_PREFIX="move-to:"
  def initialize(label:, issue:)
    @label = label
    @issue = issue
  end

  def run
    if label.name.start_with?(LABEL_PREFIX)
      require 'pry'; binding.pry
    end
  end

  private

    attr_reader :label, :issue
end
