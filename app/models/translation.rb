class Translation < ActiveRecord::Base
  attr_accessible :interpolations, :is_proc, :key, :locale, :value

  # after_create :export_to_yaml
  after_save :export_to_yaml
  after_destroy :delete_from_yaml

  def export_to_yaml
    if self.locale == 'en' && value_changed?
      d = YAML::load_file(ENV['YAML_OUISHARE_FILE_PATH']) #Load
      
      if d['en']['dynamic_translations'].blank?
        d['en']['dynamic_translations'] = {}
      end
      splitted_key = key.split('.')
      final_hash = []
      older_hash = {}
      new_hash = {}
      count = splitted_key.length-1
      splitted_key.length.times do           
          if count == splitted_key.length-1
            new_hash = Hash[splitted_key[count],self.value]           
          else            
            new_hash = Hash[splitted_key[count],older_hash]
          end                 
        older_hash = new_hash
        count -= 1
      end
      final_hash = new_hash
      
      hash = {}
      values_buffer = final_hash
      final_hash.keys.each do |global_key|
        if d["en"]["dynamic_translations"].has_key?(global_key)
          d["en"]["dynamic_translations"][global_key].each do |key,value|            
            
            hash = hash.merge(key => value)
            # final_hash = final_hash[global_key].merge(hash)
            # final_hash_buffer = final_hash_buffer.merge(new_final_hash)
            # new_final_hash = final_hash[global_key].merge(hash)
            
            
            # final_hash_buffer = final_hash[global_key].merge(hash)
            # d["en"]["dynamic_translations"][key].merge(final_hash[key])
            # new_final_hash = Hash[global_key, final_hash_buffer]         
          
          end
          
          final_hash[global_key] = hash.merge(final_hash[global_key])
         # final_hash[global_key] = final_hash[global_key].merge(hash)

        end
      end

      
      d["en"]["dynamic_translations"] = d["en"]["dynamic_translations"].merge(final_hash)
      
      # d["en"]["dynamic_translations"] = d["en"]["dynamic_translations"].merge(final_hash)
      
      # d['en']['dynamic_translations'][self.key] = self.value
      
      File.open(ENV['YAML_OUISHARE_FILE_PATH'], 'w') do |f|
        f.write d.to_yaml
      end
    
      connect_and_push_to_transifex()
    end
  end

  def delete_from_yaml
    d = YAML::load_file(ENV['YAML_OUISHARE_FILE_PATH'])
    if !d['en']['dynamic_translations'].blank?
      if !d['en']['dynamic_translations'][self.key].blank?
          d['en']['dynamic_translations'].delete self.key
      end 
    end
    
    File.open(ENV['YAML_OUISHARE_FILE_PATH'], 'w') do |f|
        f.write d.to_yaml
    end
  
    connect_and_push_to_transifex()
  end

  private 

  def connect_and_push_to_transifex
    base_url = ENV['TRANSIFEX_BASE_URL']
       
    request_response = nil    
    d = YAML::load_file(ENV['YAML_OUISHARE_FILE_PATH'])
    file = {}
    file['content'] = d.to_yaml
    file = file.to_json

    request_url = ENV['TRANSIFEX_OUISHARE_URL']
    uri = URI(base_url + request_url)

    res = Net::HTTP.start(uri.host, 80) do |http|
      request = Net::HTTP::Put.new uri.request_uri
      request.basic_auth ENV['TRANSIFEX_CREDENTIAL_LOGIN'], ENV['TRANSIFEX_CREDENTIAL_SECRET']
      request.content_type = "application/json"
      request.body = file
      
      response = http.request request
     
      request_response = response.body
      
    end
    return request_response
  end

end
