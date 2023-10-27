# frozen_string_literal: true

JWTSessions.encryption_key = ENV.fetch('JWT_SECRET')
JWTSessions.algorithm = 'HS256'
JWTSessions.token_store = :redis, {
  redis_host: '127.0.0.1',
  redis_port: '6379',
  redis_db_name: '0',
  token_prefix: 'jwt_',
  pool_size: Integer(ENV.fetch('RAILS_MAX_THREADS', 5))
}
