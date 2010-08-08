Names = ['Zaphod Beeblebrox', 'Ford Prefect', 'Arthur Dent', 'Trisha McMillan', 'Marvin'].freeze
Factory.sequence :name  do |n|
  Names[n % Names.size] + (n / Names.size).to_s
end

Factory.sequence :identity_url  do |n|
  'http://' + Factory.next(:name).downcase.gsub(/[^a-z0-9_]/, '.') + '.com'
end

Factory.define :user  do |u|
  u.identity_url Factory.next(:identity_url)
  u.full_name    Factory.next(:name)
  u.email        { |u|  u.full_name.gsub(' ','').downcase + '@example.com.invalid' }
  u.after_build  { |u|  u.skip_confirmation!  }
end

