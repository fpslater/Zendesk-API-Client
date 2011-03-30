
# API Client allows the user to perform three different requests on Zendesk's API. 
# The requests must be performed in sequence.
# Note: Driver at bottom of class

class ZendeskAPIClient
  require 'rest-client'
  attr_accessor :url, :private_client
 
  #Log in
  def initialize(account,email,pass)
    @account = account
    @email = email
    @pass = pass 
    @private_client = RestClient::Resource.new url, email, pass
  end

  def url
    url = 'http://' + @account + '.zendesk.com/'
  end

  #Create user
  def create_user(email, name)
    @email_latest = email
    @name_latest = name
    xml = '<user><email>'+email+'</email><name>'+name+'</name></user>'
    @private_client['users.xml'].post xml, :content_type => 'application/xml'
  end
  
  #Create ticket for user
  def create_ticket(description, priority_number)
    xml = '<ticket><description>'+description+'</description><priority-id>'+priority_number+'</priority-id><requester-name>'+@email_latest+'</requester-name><requester-email>'+@name_latest+'</requester-email></ticket>'
    @private_client['tickets.xml'].post xml, :content_type => 'application/xml'
  end
  
  #Modify user's ticket
  def validate ticket end		
end

# Driver ( set parameters ):
#zen = ZendeskAPIClient.new("forresttest", "forrest.slater@gmail.com", "gzzozexl")
#zen.create_user("buddy@gmail.com","buddy")
#zen.create_ticket("THIS IS A TICKET CREATED BY BUDDY", 0)



