# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ['moderator', 'admin'].each do |role|
#   Role.find_or_create_by({name: role})
# end

require 'csv'

programs_csv_text = File.read(Rails.root.join('lib', 'seeds', 'programs.csv'))
programs_csv = CSV.parse(programs_csv_text, :headers => true, :encoding => 'ISO-8859-1')

programs_csv.each do |row|
	# puts row.to_hash

	name 			= row['Program']
	description 	= row['Description']
	fixed 			= row['Fixed']
	confirmation 	= row['confirmation']
	parallel 		= row['Parallel']
	sms_description	= row['Short sms Desc']


	# check if the program exists or create it.
	Program.where(name: "#{name}").first_or_create do |prog|
		prog.description 		= description
		prog.fixed 		 		= fixed
		prog.confirmation		= confirmation
		prog.parallel 			= parallel
		prog.sms_description	= sms_description
		prog.save

		puts "Program => #{name}, === SAVED!"
	end
	# puts "\n"
	# puts "Program => #{name}, Desc => #{description}, Fixed => #{fixed}, confirmation => #{confirmation}, Parallel => #{parallel},  Sms => #{sms_description}"
	# puts "\n"
end


time_csv_text = File.read(Rails.root.join('lib', 'seeds', 'available_times.csv'))
time_csv      = CSV.parse(time_csv_text, :headers => true, :encoding => 'ISO-8859-1')


time_csv.each do |row|
	# puts row.to_hash

	prog_name 		= row['Program']
	day			 	= row['Day']
	start_time 		= row['Start time']
	end_time	 	= row['End time']
	

	# check if the program exists 
	program = Program.where(name: "#{name}").first

	if program

	 	program.available_times.where( start_time: start_time, end_time: end_time).first_or_create do |time|
			
			time.day 		= day
			time.start_time = start_time # need to format time
			time.end_time   = end_time
			time.save

			puts "Program => #{name}, === SAVED!"
		end
	end
	# puts "\n"
	# puts "Program => #{name}, Desc => #{description}, Fixed => #{fixed}, confirmation => #{confirmation}, Parallel => #{parallel},  Sms => #{sms_description}"
	# puts "\n"
end