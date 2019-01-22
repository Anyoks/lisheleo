# == Schema Information
#
# Table name: admins
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  role_id                :integer
#

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  belongs_to :role
  before_validation :set_default_role
  devise :database_authenticatable, :registerable,
		 :recoverable, :rememberable, :trackable, :validatable
  before_create :set_default_role

  has_many :activities
  has_many :client_activities, through: :activities
  has_many :booking_activities, through: :activities

   

	def log_booking_activity(type_id, activity_name, activity_description, booking_id )
		activity = self.activities.build(activity_type_id: type_id, name: activity_name, description: activity_description)
		activity.save

		booking_activity = activity.booking_activities.build(booking_id: booking_id, description: activity_description)
		booking_activity.save
		return booking_activity
	end

	def log_client_activity(type_id, activity_name, activity_description, client_id )
		activity = self.activities.build(activity_type_id: type_id, name: activity_name, description: activity_description)
		activity.save

		client_activity = activity.client_activities.build(client_id: client_id, description: activity_description)
		client_activity.save
		return client_activity
	end

   def is_admin?
		if self.role.nil?
			false
		elsif self.role.name == "admin"
			true
		else
			false
		end
	end

	def set_default_role
		self.role ||= Role.find_by_name('moderator') 
	end

	def is_moderator?
		if self.role.nil?
			false
		elsif self.role.name == "moderator"
			true
		else
			false
		end
	end

	def is_previlaged?
		if self.role.nil?
			false
		elsif self.role.name == "admin" || self.role.name == "moderator"
			true
		else
			false
		end
	end

	def make_admin
		role = 
		self.update_attributes :role_id => Role.find_by_name('admin').id
	end

	def make_moderator
		role = 
		self.update_attributes :role_id => Role.find_by_name('moderator').id
	end

	def make_customer
		self.update_attributes :role_id => Role.find_by_name('customer').id
	end

   protected
   def set_default_role
	   self.role ||= Role.find_by_name('moderator') 
	
   end
end
