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

  def self.get_last_service_user id
    Service.where('info @> ? OR info @> ? OR info @> ? OR info @> ?', {action: "order"}.to_json, {action: "arrive"}.to_json, {action: "aboard"}.to_json, {action: "accept"}.to_json).where('info @> ?', {user: {id: "#{id}"}}.to_json).order(created_at: :desc).limit(1)
  end

  def self.get_last_service_cabman id
    Service.where('info @> ? OR info @> ? OR info @> ?', {action: "accept"}.to_json, {action: "arrive"}.to_json, {action: "aboard"}.to_json).where('info @> ?', {cabman: {id: id}}.to_json).order(created_at: :desc).limit(1)
  end

  def self.get_service_by_date one, two, id, status
    if status != 'all'
      Service.where('created_at BETWEEN ? AND ?', one.to_time, two.to_time).where('info @> ?', {cabman: {id: id.to_i}}.to_json).where('info @> ?', {action: "#{status}"}.to_json)
    else
      Service.where('created_at BETWEEN ? AND ?', one.to_time, two.to_time).where('info @> ?', {cabman: {id: id.to_i}}.to_json)
    end
  end

  def self.get_service_by_ids ids
    lista_ids = ids.split(',')
    servicios = []

    for i in (0..(lista_ids.count) - 1)
      temp = Service.where('info @> ?', {service: {id: lista_ids[i].to_i}}.to_json).where('info @> ?', {action: "order"}.to_json)
      if temp.count > 0
        servicios.push(temp.to_json)
      end
    end

    servicios_temp = "";
    for i in (0..(servicios.count)- 1)
      servicios[i] = JSON.parse(servicios[i])
      
      if i < (servicios.count) - 1
        servicios_temp += servicios[i].join(',') + ','
      else
        servicios_temp += servicios[i].join(',')
      end
    end
    servicios_temp += ""
    
    servicios.clear.push(servicios_temp)
    servicios
  end
end
