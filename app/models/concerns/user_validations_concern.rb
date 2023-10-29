# frozen_string_literal: true

module UserValidationsConcern
  extend ActiveSupport::Concern
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PASSWORD_REGEX = /(?=.*\d)(?=.*[A-Z])/.freeze
  USERNAME_REGEX = /\A[a-zA-Z]+\z/.freeze

  included do
    validates :username, :email, :password, presence: true, on: :create
    validates :username, length: { in: 2..20 }, format: { with: USERNAME_REGEX,
                                                          message: 'only allows letters' }, if:
                                                          :username_changed?
    validates :email, uniqueness: true, format: { with: EMAIL_REGEX,
                                                  message: 'is not a valid email address' },
                      if: :email_changed?

    validates :password, format: { with: PASSWORD_REGEX }, length: { in: 6..120 },
                         if: :password_digest_changed?

    validates :password_confirmation, presence: true, on: :create
  end
end
