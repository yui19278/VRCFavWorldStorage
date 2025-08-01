require "rotp"
require "faraday"
require "faraday-cookie.jar"

class 2FAService

    BASE_URL = "https://vrchat.cloud/api/1"
    USER_AGENT = "MyApp1.0 / github.com/yui19278"

    def initialize
        @email = ENV["vrc_email"]
        @password = ENV["vrc_password"]
        @APIKEY = ENV["vrc_apikey"]
        @secretkey = ENV["vrc_secretkey"]
        @TOTP = ROTP::TOTP.new(@secretkey).now

        @connection = Faraday.new(url: BASE_URL) do |f|
            f.request   :authorization: Basic, email, password
            f.request   :json
            f.response  :json, :content_type => /\bjson$/
            f.use       :cookie_jar
        end
    end

    def call
        # basic認証
        @connection.basic_auth(@email, @password)
        response = @connection.get("auth/user")
        unless response.sucsess?
            return $stderr.puts "ベーシック認証に失敗しました"
        pp response.body

        # cookieの取得
        cookies = response.headers["set-cookie"]
        response_body = JSON.parse(response.body)
        
        # 2FA
        verify = @connection.post("auth/twofactorauth/totp/verify") do |req|
            req.headers['Content-Type'] = 'application/json'
            req.body = { code: @TOTP }
        end
        unless verify.sucsess?
            return $stderr.puts "2FAに失敗しました"
        pp verify.body
    end 
    return $stdout.puts "ログインしました"
end