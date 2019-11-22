# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  name: 'Admin',
  middlename: 'Task',
  lastname: 'Manager',
  birthdate: '1666-66-66',
  gender: 'male',
  email: 'admin@admin.com',
  password: 'godmode01',
  role: 2
)

User.create(
  name: 'Supervisor',
  middlename: 'Task',
  lastname: 'Manager',
  birthdate: '1998-06-12',
  gender: 'male',
  email: 'supervisor@supervisor.com',
  password: 'godmode01',
  role: 1
)

User.create(
  name: 'User',
  middlename: 'Task',
  lastname: 'Manager',
  birthdate: '1997-12-96',
  gender: 'male',
  email: 'user@user.com',
  password: 'godmode01',
  role: 0
)

t = Token.create(user_id: 1)
t.update_attribute(:secret, 'cd7f27e1bbfa4ca4959fbb3dbcc6c3fb') # Admin

t = Token.create(user_id: 2)
t.update_attribute(:secret, 'ca3f1d74b2734998966ab573b9f6e3eb') # Supervisor

t = Token.create(user_id: 3)
t.update_attribute(:secret, '48a39eb305214916afdb7011c302c3d7') # Normal
