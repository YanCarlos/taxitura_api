module ChartsHelper

  def self.time_calculate total_seconds
    days = 0
    hours = 0
    minutes = 0
    seconds = 0

    while total_seconds > 0  do
       if total_seconds >= 86400
         days += 1
         total_seconds -= 86400
       end

       if total_seconds >= 3600 && total_seconds < 86400
         hours += 1
         total_seconds -= 3600
       end

       if total_seconds >= 60 && total_seconds < 3600
         minutes += 1
         total_seconds -= 60
       end

       if total_seconds > 0 && total_seconds < 60
         seconds += total_seconds
         total_seconds -= total_seconds
       end
    end

    if days < 10
      days = "0#{days}"
    end

    if hours < 10
      hours = "0#{hours}"
    end

    if minutes < 10
      minutes = "0#{minutes}"
    end

    if seconds < 10
      seconds = "0#{seconds}"
    end

    {:days => days, :hours => hours, :minutes => minutes, :seconds => seconds.to_i}

  end

  def self.get_time_occupied id
    services = ServicesHelper.get_services_by_driver id.to_i
    seconds = 0.0
    #Recorre cada uno de los servicios obtenidos
    services.each do |key|
      #En caso de que exista una calificación para el taxista
      if !key['info']['date'].nil?
        if !key['info']['date']['aboard'].nil? && !key['info']['date']['end'].nil?
        aboard = key['info']['date']['aboard'].to_datetime
        ends = key['info']['date']['end'].to_datetime
        seconds = seconds + ("%.1f" % ((ends - aboard)*24*60*60).to_f).to_f
      end
      end
    end

    time_calculate seconds

  end

  def self.get_time_arrive id
    services = ServicesHelper.get_services_by_driver id.to_i
    seconds = 0.0
    services_true = 0
    #Recorre cada uno de los servicios obtenidos
    services.each do |key|
      #En caso de que exista una calificación para el taxista
      if !key['info']['date'].nil?
        if !key['info']['date']['arrive'].nil? && !key['info']['date']['accept'].nil?
        arrive = key['info']['date']['arrive'].to_datetime
        accept = key['info']['date']['accept'].to_datetime
        seconds = seconds + ("%.1f" % ((arrive - accept)*24*60*60).to_f).to_f
        services_true += 1
      end
      end
    end

    puts seconds
    puts services_true

    time_calculate (seconds / services_true)

  end
  
  def self.get_services_by_months id
  initial_date = DateTime.now() - 12.months
  services = Service.where('created_at > ?', initial_date).where('info @> ?', {cabman: {id: id}}.to_json)

  months = []

  for i in (1..12)
    month = (initial_date + i.months).to_s.split('-')
    month = month[0] + '-' + month[1]
    months.push([month, 0])
  end

  #Recorre cada uno de los servicios obtenidos
  services.each do |key|
    #En caso de que exista una calificación para el taxista
    if !key['created_at'].nil?
      month = (key['created_at']).to_s.split('-')
      month = month[0] + '-' + month[1]
      for m in (0..(months.count) - 1)
        if month == months[m][0]
          months[m][1] = months[m][1].to_i + 1
          m = (months.count) - 1
        end
      end
    end
  end
  months
  end

  def self.get_services_by_days id
  initial_date = DateTime.now() - 7.days
  services = Service.where('created_at > ?', initial_date).where('info @> ?', {cabman: {id: id}}.to_json)

  days = []

  for i in (1..7)
    day = (initial_date + i.days).to_s.split('-')
    day = day[1] + '-' + (day[2].to_s).split('T')[0]
    days.push([day, 0])
  end

  #Recorre cada uno de los servicios obtenidos
  services.each do |key|
    #En caso de que exista una calificación para el taxista
    if !key['created_at'].nil?
      day = (key['created_at']).to_s.split('-')
      day = day[1] + '-' + (day[2].to_s).split(' ')[0]
      for m in (0..(days.count) - 1)
        puts day + " = "+ days[m][0]
        if day == days[m][0]
          days[m][1] = days[m][1].to_i + 1
          m = (days.count) - 1
        end
      end
    end
  end
  days
  end

  def self.get_services_last_recharge id
    #Obtiene la ultima recarga que se le ha hecho al taxista
  	@recharges = Recharge.where("user_id  = #{id}").order(created_at: :desc).limit(1)[0]
    #Con base en la fecha de la ultima recarga y el identificador del taxista se obtiene la lista de servicios
  	@services = Service.where('created_at > ?', @recharges['created_at']).where('info @> ?', {cabman: {id: id}}.to_json)
    #Al controlador se retornará un json con la cantidad de servicios
    { :quantity => @services.count }
  end.to_json

  def self.get_services_by_driver id
    #Obtiene los servicios que pertenecen al conductor 
    @services = ServicesHelper.get_services_by_driver id.to_i
    quantity = 0
    qualification = 0

    #Recorre cada uno de los servicios obtenidos
    @services.each do |key|
      #En caso de que exista una calificación para el taxista
      if !key['info']['quality'].nil?
        quantity += 1
        qualification += key['info']['quality']['quality']["value"].to_i
      end
    end

    #Json que se retornará al controlador con la cantidad de personas y la calificación parcial del taxista
    { :persons => quantity, :qualification => ("%.1f" % (qualification.to_f / quantity.to_f)).to_f }

  end.to_json
end