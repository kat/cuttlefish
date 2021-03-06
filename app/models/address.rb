class Address < ActiveRecord::Base
  has_many :emails_sent, :class_name => "Email", :foreign_key => "from_address_id"
  has_and_belongs_to_many :emails_received, :class_name => "Email", :join_table => "deliveries"

  # All addresses that have been sent mail
  def self.all_received_email
    Address.joins(:emails_received).group(:address_id)
  end

  # All addresses that have sent mail
  def self.all_sent_email
    Address.joins(:emails_sent).group(:from_address_id)
  end

  # Time this email address was last sent an email (doesn't necessarily mean that it arrived)
  def time_last_received
    a = emails_received.order("created_at DESC").first
    a.created_at if a
  end

  def time_last_sent
    a = emails_sent.order("created_at DESC").first
    a.created_at if a
  end

  def emails
    Email.joins(:from_address, :to_addresses).where("addresses.id = ? OR deliveries.address_id = ?", id, id)
  end

  def status
    most_recent_log_line = PostfixLogLine.joins(:delivery => :address).where("address_id = ?", id).order("time DESC").first
    most_recent_log_line ? most_recent_log_line.status : "unknown"
  end
end
