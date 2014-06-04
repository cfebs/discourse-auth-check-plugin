# name: auth-check-plugin
# about: adds simple http auth validation
# version: 0.1
# authors: tennis <cr4sh.mail@gmail.com>

load File.expand_path("../auth_check.rb", __FILE__)

AuthCheckPlugin = AuthCheckPlugin

after_initialize do
  module AuthCheckPlugin
    class Engine < ::Rails::Engine
      engine_name "auth_check_plugin"
      isolate_namespace AuthCheckPlugin
    end

    class AuthCheckController < ActionController::Base

      def check

        begin
          AuthCheckPlugin::AuthCheck.check params

        rescue AuthCheckPlugin::AuthCheckException
          render status: :forbidden, json: false
          return
        end

        render status: 200, json: false
        return

      end
    end

    AuthCheckPlugin::Engine.routes.draw do
      get '/' => 'auth_check#check'
    end

    Discourse::Application.routes.append do
      mount ::AuthCheckPlugin::Engine, at: '/auth_check'
    end

  end
end
