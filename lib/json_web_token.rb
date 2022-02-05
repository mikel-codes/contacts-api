module JsonWebToken
	class << self
		def encode(payload)
			payload[:exp] = 60.days.from_now.to_i
			JWT.encode(payload, Rails.application.secrets.secret_key_base)
		end

		def decode(token)
			body = JWT.decode(token.split(" ")[1], Rails.application.secrets.secret_key_base, false).first
			HashWithIndifferentAccess.new body
			rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        nil
      end
		end
	end
