User.create(username: 'Abed', email: 'abed@greendale.com', password: 'password', password_confirmation: 'password')
User.create(username: 'Troy', email: 'troy@greendale.com', password: 'password', password_confirmation: 'password')

User.first.maps.create(title: 'Dreamatorium', description: 'Where we play Professor Spacetime and make dreams come true. Come join us!')
User.first.maps.create(title: 'Study Room', description: 'Where we admire Annie')
