class Subscribers
   def self.add_subscriber subscriber
    begin
      gibbon.lists(subscribers_list_id).members.create(
        body: {
          email_address: subscriber, 
          status: "subscribed", 
          merge_fields: {
            FNAME: 'Subscriber', 
            LNAME: 'Taxitura'
          }
        }
      ) unless includes_subscriber? subscriber
    rescue Exception => e
      false
    end
  end

  def self.includes_subscriber? subscriber
    email_hash = Digest::MD5.hexdigest(subscriber)
    begin 
      gibbon.lists(subscribers_list_id).members(email_hash).retrieve
      true
    rescue Exception => e
      false
    end
  end

  private
  def self.gibbon
    Gibbon::Request
  end

  def self.subscribers_list_id
    ENV['SUBSCRIBERS_LIST_ID'] || 'e92c139581'
  end

end
