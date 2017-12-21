module ServicesHelper

  def self.get_services_by_driver id
    Service.where('info @> ?', {cabman: {id: id}}.to_json)
  end

  def self.get_services_by_user id
    Service.where('info @> ?', {user: {id: "#{id}"}}.to_json)
  end

  # order-accept-arrive-aboard-end
  def self.get_services_by_status status
    Service.where('info @> ?', {action: "#{status}"}.to_json)
  end

  def self.get_service_by_id id
    Service.where('info @> ?', {service: {id: id}}.to_json)[0]
  end

end
