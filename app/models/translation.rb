class Translation < ActiveRecord::Base
  attr_accessible :interpolations, :is_proc, :key, :locale, :value

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
      
      d['en']['dynamic_translations'][splitted_key[0]] = (Hash[d['en']['dynamic_translations'][splitted_key[0]].to_a + final_hash[splitted_key[0]].to_a])
      
      hash = {}
      values_buffer = final_hash
      final_hash.keys.each do |global_key|
        if d["en"]["dynamic_translations"].has_key?(global_key)
          d["en"]["dynamic_translations"][global_key].each do |key,value|
            hash = hash.merge(key => value)         
          end          
          final_hash[global_key] = hash.merge(final_hash[global_key])        

        end
      end
      d["en"]["dynamic_translations"] = d["en"]["dynamic_translations"].merge(final_hash)
      
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
      # value = nested_hash_value(splitted_key)

          
      
      d['en']['dynamic_translations'][splitted_key[0]] = (Hash[d['en']['dynamic_translations'][splitted_key[0]].to_a - final_hash[splitted_key[0]].to_a])
      if d['en']['dynamic_translations'][splitted_key[0]].blank?
        d['en']['dynamic_translations'].delete splitted_key[0]
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

      begin
        res = Net::HTTP.start(uri.host, 80) do |http|
          request = Net::HTTP::Put.new uri.request_uri
          request.basic_auth ENV['TRANSIFEX_CREDENTIAL_LOGIN'], ENV['TRANSIFEX_CREDENTIAL_SECRET']
          request.content_type = "application/json"
          request.body = file
          
          response = http.request request
          
          case response.code 
            when "404"
              request_response = "transifex repo not found"          
            when "200"
              request_response = response.body
          end
        
        end
      rescue
        request_response = "An error occured on transifex"      
      end

    return request_response
  end

  # def destroy_value_in_hash(initial_hash, splitted_key, occurences = 1, buffer_hash = nil, final_hash = nil)
      
      
  #       if buffer_hash.blank? 
  #         buffer_hash = initial_hash 
  #         final_hash = {}
  #         final_hash['en'] = {}
  #         final_hash['en']['dynamic_translations'] = {}
          
  #       else
  #         buffer_hash = buffer_hash
  #       end     
        
  #       if buffer_hash.keys.include?(splitted_key[occurences])
  #         if buffer_hash[splitted_key[occurences]].instance_of?(Hash)

              
  #           final_hash =final_hash['en']['dynamic_translations']
                          
            
            
  #           # initial_hash = Hash(initial_hash, buffer_hash[splitted_key[occurences]])
  #           buffer_hash = buffer_hash[splitted_key[occurences]]
  #           occurences +=1
            
  #           destroy_value_in_hash(initial_hash,splitted_key,occurences,buffer_hash, final_hash)
  #         else
            
  #           final_hash = Hash[splitted_key[occurences-1],buffer_hash]
  #           xx
  #         end
  #       end
  #   return buffer_hash
  # end

  

end
