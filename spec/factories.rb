FactoryGirl.define do

    factory :individual_type do
        title "test"        
    end

    factory :setting do
        title "ADMIN_STRONG_AUTH"    
        value true
    end

    factory :translation_en, class: Translation do
        locale "en" 
        key "hello"
        value "Hello"        
    end

    factory :translation_es, class: Translation do
        locale "es" 
        key "hello"
        value "Hola"        
    end

    factory :user do
        email "test@gmail.com" 
        first_name "user"
        last_name "user"
        password "123456"  
        password_confirmation "123456"    
        is_admin false 
    end

    factory :admin, class: User do
        email "admin@gmail.com" 
        first_name "admin"
        last_name "admin"
        password "123456"  
        password_confirmation "123456"
        is_admin true     
    end
end