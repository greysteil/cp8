class IssueDelegator
  LABEL_PREFIX = "move-to"

  def initialize(label:, issue:)
    @label = label
    @issue = issue
  end

  def run
    if label.prefix == LABEL_PREFIX
    end
  end

  private

    attr_reader :label, :issue
end
