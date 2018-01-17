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

  def self.get_service_by_date one, two
    Service.where('info @> BETWEEN ? AND ?', {service: {date_creation: one}}.to_json, {service: {date_creation: two}}.to_json)
  end

end
