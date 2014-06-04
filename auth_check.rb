module ::AuthCheckPlugin

  class AuthCheckException < Exception
  end

  class AuthCheck
    TOKEN = "044324350768fcd77362c49b5f241ec6b4002304"

    def self.check(params)
        username = params[:u]
        password = params[:p]
        token = params[:token]

        if token.nil? || username.nil? || password.nil?
          raise AuthCheckException
        end

        if token != TOKEN
          raise AuthCheckException
        end

        user = User.find_by_username(username)

        if user.nil?
          raise AuthCheckException
        end

        hashed = AuthCheck.hash_password(password, user.salt)

        puts user
        puts hashed
        puts user.password_hash

        if user.password_hash != hashed
          render status: :forbidden, json: false
          return
        end
    end

    # hashes pass using same discourse method
    # see User.hash_password
    def self.hash_password(password, salt)
        return Pbkdf2.hash_password(password, salt, Rails.configuration.pbkdf2_iterations, Rails.configuration.pbkdf2_algorithm)
    end

  end
end
