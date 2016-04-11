#!/usr/bin/env ruby

require 'csv'
require 'desk'

def connect_to_desk
  Desk.configure do |config|
    config.support_email = ENV['DESK_EMAIL']
    config.subdomain = ENV['DESK_SUBDOMAIN']
    config.consumer_key = ENV['DESK_KEY']
    config.consumer_secret = ENV['DESK_SECRET']
    config.oauth_token = ENV['DESK_TOKEN']
    config.oauth_token_secret = ENV['DESK_TOKEN_SECRET']
  end
end

def get_cases(case_types = 'all', since_case = 1, queue = 'all')
  inbox_id = ENV['DESK_INBOX_ID']
  stale_id = ENV['DESK_24_ID']
  connect_to_desk
  if queue == 'all'
    Desk.cases(status: case_types, since_id: since_case)
  else
    queue == '24' ? Desk.filter_cases(stale_id) : Desk.filter_cases(inbox_id)
  end
end

def count_cases(queue, case_totals = { all: 0, new: 0, open: 0 })
  cases = get_cases('all', 1, queue)
  while cases
    cases.each do |c|
      case_totals[:open] += 1 if c.status == 'open'
      case_totals[:new] += 1 if c.status == 'new'
      case_totals[:all] += 1
    end
    cases = cases.next
  end
  case_totals
end

def write_to_csv(filename, new_cases, open_cases, stale_cases)
  CSV.open(filename, 'a') do |csv|
    csv << [Time.now, new_cases, open_cases, stale_cases]
  end
end

stats_file = ENV['QUEUE_STATS_FILE']
inbox = count_cases('inbox')
stale = count_cases('24')
write_to_csv(stats_file, inbox[:new], inbox[:open], stale[:all])
