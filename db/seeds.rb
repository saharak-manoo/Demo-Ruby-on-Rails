if User.where(email: 'admin@test.com').count == 0
  User.create!(
    email: 'admin@test.com',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: DateTime.now
  )

  ap "created admin@test.com"
end

if ClassLevel.count == 0
  levels = (1..6).to_a
  levels.each do |level|
    ClassLevel.create!(name: "ประถม #{level}")
    ClassLevel.create!(name: "มัธยม #{level}")
  end
end

if Subject.count == 0
  subject_codes = ['คพ313', 'กง313', 'คม113', 'วท413', 'คพ513', 'คพ213', 'คพ123', 'ศท112', 'ศท100', 'ศท001']
  subjects = ['การเขียนโปรแกรมคอมพิวเตอร์', 'การจัดการบริหารธุระกิจ', 'เคมี' , 'วิทยาการคอมพิวเตอร์', 'การเขียนบนมือถือ', 'ภาษา C++', 'ภาษาไทย', 'ภาษาอังกฤษ', 'ภาษาคอม']
  credits = [3, 3, 1, 3, 3, 3, 1, 3, 3, 3]
  subjects.each_with_index do |subject, index|
    Subject.create!(name: subject, credit: credits[index], subject_code: subject_codes[index])
  end
end
