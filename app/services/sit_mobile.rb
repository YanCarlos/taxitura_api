module SitMobile
  require 'rest-client'

  def self.set
    @domain =  ENV['SIT_MOBILE_DOMAIN']
    @user = ENV['SIT_MOBILE_USER']
    @password = ENV['SIT_MOBILE_PASSWORD']
    @client_id = ENV['SIT_MOBILE_CLIENT_ID']
    @account_id = ENV['SIT_MOBILE_ACCOUNT_ID']
  end

  def self.send destination, message
    self.set
    response = RestClient.get @domain + '/HTTPConnector/SendMessage' , {
      params: {
        login: @user, 
        password: @password,
        clientID: @client_id,
        accountID: @account_id,
        destination: destination,
        text: message,
        seq: 123456789,
        source: 'Taxitura'
      }
    }
    return response
  end
    
end
