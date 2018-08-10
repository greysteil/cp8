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
      github.create_issue(label.suffix, issue.title, moved_issue_body)
    end

    def github
      Cp8.github_client
    end

    def moved_issue_body
      issue_header + issue.body
    end

    def issue_header
      "_Moved from #{issue.html_url}_\n\n---\n"
    end
end
