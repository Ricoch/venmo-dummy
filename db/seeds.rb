Setting.create_or_find_by!(key: 'min_version', value: '0.0')

user_1 = User.create!(email: 'user@example.com',
                      username: 'Example',
                      first_name: 'Name',
                      last_name: 'LastName')

user_2 = User.create!(email: 'user2@example.com',
                      username: 'Example2',
                      first_name: 'Name2',
                      last_name: 'LastName2')

user_3 = User.create!(email: 'user3@example.com',
                      username: 'Example3',
                      first_name: 'Name3',
                      last_name: 'LastName3')

user_4 = User.create!(email: 'user4@example.com',
                      username: 'Example4',
                      first_name: 'Name4',
                      last_name: 'LastName4')

user_5 = User.create!(email: 'user5@example.com',
                      username: 'Example5',
                      first_name: 'Name5',
                      last_name: 'LastName5')

user_6 = User.create!(email: 'user6@example.com',
                      username: 'Example6',
                      first_name: 'Name6',
                      last_name: 'LastName6')

user_7 = User.create!(email: 'user7@example.com',
                      username: 'Example7',
                      first_name: 'Name7',
                      last_name: 'LastName7')

user_8 = User.create!(email: 'user8@example.com',
                      username: 'Example8',
                      first_name: 'Name8',
                      last_name: 'LastName8')

user_9 = User.create!(email: 'user9@example.com',
                      username: 'Example9',
                      first_name: 'Name9',
                      last_name: 'LastName9')

[user_1, user_2, user_3, user_4, user_5, user_6, user_7, user_8, user_9].each do |user|
  source = ExternalPaymentSource.create!(user: user)

  amount = (300..3000).to_a.sample

  source.balances.create!(total: amount, change: amount)
end

# Friendships
FriendshipService.add_mutual_friends(user_1, user_3)
FriendshipService.add_mutual_friends(user_1, user_6)
FriendshipService.add_mutual_friends(user_2, user_4)
FriendshipService.add_mutual_friends(user_2, user_6)
FriendshipService.add_mutual_friends(user_3, user_5)
FriendshipService.add_mutual_friends(user_3, user_6)
FriendshipService.add_mutual_friends(user_3, user_4)
FriendshipService.add_mutual_friends(user_4, user_5)

# Some basic payments
Payment.create!(sender: user_1, receiver: user_3, amount: 31.4, description: 'Thanks for the cake! 🎂')
Payment.create!(sender: user_4, receiver: user_5, amount: 6.9, description: 'This is what I owe you from the beers')
Payment.create!(sender: user_6, receiver: user_1, amount: 4.2, description: 'Welp')
Payment.create!(sender: user_6, receiver: user_2, amount: 100, description: 'Happy birthday buddy!')
Payment.create!(sender: user_5, receiver: user_3, amount: 88.8, description: 'Hello 👋')
Payment.create!(sender: user_2, receiver: user_6, amount: 999, description: 'A Lannyster always pays his debts')
Payment.create!(sender: user_5, receiver: user_3, amount: 314.15, description: 'Valar Morghulis')
Payment.create!(sender: user_2, receiver: user_4, amount: 72.59, description: 'I am not in danger, Skyler. I am the danger.')

# A large list of payments for pagination feature
25.times do |index|
  amount = (1..999).to_a.sample
  days_ago = (0..60).to_a.sample

  Payment.create!(sender: user_1,
                  receiver: user_6,
                  amount: amount,
                  description: "Some description, bye. #{index} - #{days_ago}",
                  created_at: days_ago.days.ago)
end
