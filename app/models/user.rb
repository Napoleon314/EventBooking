class User < ApplicationRecord
  has_many  :events,  :dependent        => :delete_all
  has_many  :books,   :dependent        => :delete_all

  has_many  :booked_events, through: :books, source: :event

  enum title: [ :'Mr.', :'Ms.', :'Mrs.', :'Dr.', :'Prof.' ]
  enum gender: [ :'Male', :'Female' ]
  enum status: [ :'Student', :'Staff' ]

  attr_accessor :password

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :email,       :presence     => true,
            :format                     => { :with => email_regex },
            :uniqueness                 => { :case_sensitive => false }

  validates :password,    :presence     => true,
            :confirmation               => true,
            :length                     => { :within => 6..40 }

  validates :first_name,  :presence     => true

  validates :last_name,  :presence      => true

  before_save :encrypt_password

  def has_password(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)

    return nil if user.nil?
    return user if user.has_password(submitted_password)
  end

  def title_name
    "#{title} #{first_name} #{last_name}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
    def encrypt_password
      self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(pass)
      Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
    end

end
