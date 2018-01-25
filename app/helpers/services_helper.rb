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

  def self.get_last_service id
    Service.where('info @> ? OR info @> ? OR info @> ? OR info @> ?', {action: "accept"}.to_json, {action: "arrive"}.to_json, {action: "aboard"}.to_json, {action: "cancel"}.to_json).where('info @> ?', {user: {id: "#{id}"}}.to_json).order(created_at: :desc).limit(1)
  end

  def self.get_service_by_date one, two, id
    Service.where('created_at BETWEEN ? AND ?', one.to_time, two.to_time).where('info @> ?', {cabman: {id: id.to_i}}.to_json)
  end

end
