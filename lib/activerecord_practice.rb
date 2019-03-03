require 'sqlite3'
require 'active_record'
require 'byebug'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'customers.sqlite3')

class Customer < ActiveRecord::Base
  def to_s
    "  [#{id}] #{first} #{last}, <#{email}>, #{birthdate.strftime('%Y-%m-%d')}"
  end

  #  NOTE: Every one of these can be solved entirely by ActiveRecord calls.
  #  You should NOT need to call Ruby library functions for sorting, filtering, etc.

  def self.any_candice
    return self.where(:first=>'Candice')
    # YOUR CODE HERE to return all customer(s) whose first name is Candice
    # probably something like:  Customer.where(....)
  end
  def self.with_valid_email
    return self.where("email LIKE '%@%'")
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
  end

  def self.with_dot_org_email
    return self.where("email LIKE '%.org%'")
  end

  def self.with_invalid_email
    return self.where("email NOT LIKE '%@%'")
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
  end

  def self.with_blank_email
    return self.where(:email=>[nil, ""])
    # YOUR CODE HERE to return only customers with valid email addresses (containing '@')
  end

  def self.born_before_1980
    return self.where("birthdate < '1980-01-01'")
  end

  def self.with_valid_email_and_born_before_1980
    return self.where("birthdate < '1980-01-01' AND email LIKE '%@%'")
  end

  def self.twenty_youngest
    return self.where("first LIKE '%%'").order("birthdate desc").limit(20)
  end

  def self.last_names_starting_with_b
    return self.where("last LIKE 'b%'").order("birthdate")
  end

  def self.update_gussie_murray_birthdate
    cust = self.find_by(:first=>"Gussie", :last=>"Murray")
    self.update(cust.id, :birthdate=>Time.parse("2004-02-08"))
  end

  def self.change_all_invalid_emails_to_blank
    custs = self.where("email NOT LIKE '%@%'")
    custs.update_all(:email=>'')
  end

  def self.delete_maggie_herman
    cust = self.find_by(:first=>'Meggie', :last=>'Herman')
    cust.destroy
  end

  def self.delete_everyone_born_before_1978
    custs = self.where("birthdate < '1978-01-01'")
    custs.destroy_all
  end







  # etc. - see README.md for more details
end
