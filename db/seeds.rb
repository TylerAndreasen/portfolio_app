# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# IMPORTANT:: The below was supplied by my professor, though snippets to 
# implement add random images have been removed, as I don't feel the need to 
# fill up my disc more than necessary.
require 'faker' # Make sure the Faker gem is installed

# Purge existing profile photos and remove associated blobs and attachments
Student.find_each do |student|
 student.profile_picture.purge if student.profile_picture.attached?
end

# Ensure there are no orphaned attachments or blobs
ActiveStorage::Blob.where.missing(:attachments).find_each(&:purge)

#The above doesn’t delete the empty folders
# run the following to remove empty folders
# find storage/ -type d -empty -delete

Student.destroy_all # Clear existing records if any

50.times do |i|
  student =Student.create!(
    first_name: "First #{i + 1}",
    last_name: "Last #{i + 1}",
    major: Student::VALID_MAJORS.sample, # Assuming you have a VALID_MAJORS constant
    graduation_date: Faker::Date.between(from: 2.years.ago, to: 2.years.from_now),
    email: "student#{i + 1}@msudenver.edu"
  )
 end
 
puts "50 students created."