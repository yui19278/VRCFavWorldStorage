require "rotp"
require "faraday/retry"

class 2FAService
    def initialize
        @email = ENV["vrc_email"]
        @password = ENV["vrc_password"]
        @APIKEY = ENV["vrc_apikey"]
        @secretkey = ENV["vrc_secretkey"]
        @TOTP = ROTP::TOTP.new(@secretkey).now

        @connection = Faraday.new(url: "https://vrchat.cloud/api/1") 

    def call
        @connection.basic_auth(@email, @password)
        response = @connection.get("auth/user")

        cookies = response.headers["set-cookie"]

        verify = @connection.post("auth/twofactorauth/totp/verify") do |req|
            req.headers
