require 'securerandom'
require 'bcrypt'

class User < ApplicationRecord
    

    has_many(:cats, {
        class_name: "Cat",
        foreign_key: :user_id,
        primary_key: :id
    })

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!  
        self.session_token
    end

    def password=(password)
        # @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)

    end

    def self.find_by_credentials(user_name, password)
        user = User.find_by(user_name: user_name)
        if user.nil?
            return nil
        else
            if user.is_password?(password)
                return user
            else
                return nil
            end
        end
    end

    


end
