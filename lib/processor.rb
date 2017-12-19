require "card_updater"
require "issue_closer"
require "labeler"

class Processor
  def initialize(payload, config: nil)
    @payload = payload
    @config = config || {}
  end

  def process
    return if event_triggered_by_cp8?

    ping_reviewers if recycle_request?
    update_trello_cards # backwards compatibility for now
    add_labels
    close_stale_issues
  end

  private

    attr_reader :payload, :config

    def update_trello_cards
      CardUpdater.new(payload).run
    end

    def add_labels
      Labeler.new(payload.issue).run
    end

    def close_stale_issues
      IssueCloser.new(repo, weeks: config[:stale_issue_weeks]).run
    end

    def ping_reviewers
      chat.post text: payload.issue.reviewers.map(&:chat_name).join(", ") + " :recycle: please #{payload.issue.html_url}"
    end

    def event_triggered_by_cp8?
      current_user.id == payload.sender_id
    end

    def current_user
      github.user
    end

    def repo
      payload.repo
    end

    def recycle_request?
      payload.comment&.recycle_request?
    end

    def github
      Cp8.github_client
    end

    def chat
      Cp8.chat_client
    end
end
