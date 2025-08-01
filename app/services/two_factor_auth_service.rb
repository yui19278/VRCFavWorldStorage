require "rotp"
require "faraday"
require "faraday-cookie_jar"

class TwoFactorAuthService
    BASE_URL = "https://vrchat.cloud/api/1"
    USER_AGENT = "MyApp1.0 / github.com/yui19278"
    def initialize
        @email = ENV["vrc_email"]
        @password = ENV["vrc_password"]
        @APIKEY = ENV["vrc_apikey"]
        @secretkey = ENV["vrc_secretkey"]

        @connection = Faraday.new(url: BASE_URL, headers: { 'User-Agent': USER_AGENT }) do |f|
            f.request   :authorization, :Basic, @email, @password
            f.request   :json
            f.response  :json, content_type: /\bjson$/
            f.use       :cookie_jar
        end
    end

    def call
        # basic認証
        @connection.basic_auth(@email, @password)
        response = @connection.get("auth/user")
        unless response.succes?
            return $stderr.puts "ベーシック認証に失敗しました"
        end
        pp response.body

        # 2FA
        totpcode = ROTP::TOTP.new(@secretkey).now
        verify = @connection.post("auth/twofactorauth/totp/verify") do |req|
            req.headers["Content-Type"] = "application/json"
            req.body = { code: totpcode }
        end
        unless verify.succes?
            return $stderr.puts "2FAに失敗しました"
        end
        $stdout.puts "ログインしました"
        pp verify.body
    end
end
