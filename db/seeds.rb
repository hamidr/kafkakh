# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

def foo id
  begin
    user = user.find(id)
    user.role = :admin
    user.save!
  rescue
  end
end

foo 0
foo 1

user = User.create(email: 'hrdavodi@gmail.com', password: '12345678', role: :admin)
if !user.valid?
  user = User.find_by!(email:'hrdavodi@gmail.com') 
  user.role = :admin
  user.save!
end

o = User.create(email: 'shemy785@gmail.com', password: '12345678', role: :admin)
if !o.valid?
  o = User.find_by!(email:'shemy785@gmail.com') if !o.valid?
  o.role = :admin
  o.save!
end

#(0..10).each do |n|
#
#  options = (0..4).map do |x|
#    "#{n} - opt #{x}"
#  end
#
#  Poll.create!(title: "poll title #{n}", options: options, user_id: user.id)
#end

