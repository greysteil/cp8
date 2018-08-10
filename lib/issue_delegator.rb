class IssueDelegator
  LABEL_PREFIX = "move-to"

  def initialize(label:, issue:)
    @label = label
    @issue = issue
  end

  def run
    if label.prefix == LABEL_PREFIX
      create_copy_of_issue_in_selected_repo
    end
  end

  private

    attr_reader :label, :issue

    def create_copy_of_issue_in_selected_repo
      github.create_issue(label.suffix, issue.title, issue.body)
    end

    def github
      Cp8.github_client
    end
end
