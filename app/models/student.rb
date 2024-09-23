class Student < ApplicationRecord
    #MSU_REGEX = /'[A-Za-z0-9]+@msudenver\.edu/
    #MSU_REGEX = /\A[\w+\-.]+@msudenver\.edu\z/i #Thanks to Evan lastname for the regex.
    validates :first_name, presence: true
    validates :last_name, presence: true
    #PFP not required
    validates :school_email, uniqueness: true
    #validates :school_email, format: { with: /\A[\w]+@msudenver\.edu+\z/, message: "does not match expected format." }, uniqueness: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    has_one_attached :profile_picture
end