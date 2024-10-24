class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    # PFP not required
    # Email removed to be handled by Devise 

    validates :major, presence: true


    VALID_GRADUATION_RELATIONS = ["Before", "After"]
    validates :graduation_date, presence: true


    has_one_attached :profile_picture

    VALID_MAJORS = ["Computer Engineering BS","Computer Information Systems BS","Computer Science BS","Cybersecurity BS","Data Science and Machine Learning"]
    validates :major, inclusion: {in: VALID_MAJORS, message: "%{value} is not a valid major"}

    # Currently unused, though will be a part of the optional count-per-page limit option
    VALID_STUDENT_COUNTS = [5,15,50]
end