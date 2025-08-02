Rails.application.config.after_initialize do
    begin
        TwoFactorAuthService.new.call
        Rails.logger.info "2fa ok"
    rescue => e
        Rails.logger.error "2fa failed"
    end
end
