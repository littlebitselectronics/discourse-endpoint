module LittlebitsNav
  class Engine < ::Rails::Engine
    isolate_namespace LittlebitsNav

    config.after_initialize do
      ActionController::Base.send :include, LittlebitsNav::NavController
    end
  end
end