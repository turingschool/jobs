# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Rails.application.config.session_store(:cookie_store,
                                         key:    '_turing_session',
                                         domain: "jobs-turing.herokuapp.com")

else
Rails.application.config.session_store :cookie_store,
                                       key:    '_turing_session',
                                       domain: :all
end
