require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection

class User < ActiveRecord::Base
    has_secure_password
    validates :name,
        presence: true,
        format: { with: /\A\w+\z/ }
    validates :password,
        length: { in: 5..15 }
    has_many :schedules
end

class Schedule < ActiveRecord::Base
    validates :time, presence: true
    belongs_to :user
end