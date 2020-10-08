Setting.create_or_find_by!(key: 'min_version', value: '0.0')

user1 = User.create!(email: 'user@example.com',
                     username: 'Example',
                     first_name: 'Name',
                     last_name: 'LastName')

user2 = User.create!(email: 'user2@example.com',
                     username: 'Example2',
                     first_name: 'Name2',
                     last_name: 'LastName2')

user3 = User.create!(email: 'user3@example.com',
                     username: 'Example3',
                     first_name: 'Name3',
                     last_name: 'LastName3')

user4 = User.create!(email: 'user4@example.com',
                     username: 'Example4',
                     first_name: 'Name4',
                     last_name: 'LastName4')

user5 = User.create!(email: 'user5@example.com',
                     username: 'Example5',
                     first_name: 'Name5',
                     last_name: 'LastName5')

user6 = User.create!(email: 'user6@example.com',
                     username: 'Example6',
                     first_name: 'Name6',
                     last_name: 'LastName6')

user7 = User.create!(email: 'user7@example.com',
                     username: 'Example7',
                     first_name: 'Name7',
                     last_name: 'LastName7')

user8 = User.create!(email: 'user8@example.com',
                     username: 'Example8',
                     first_name: 'Name8',
                     last_name: 'LastName8')

user9 = User.create!(email: 'user9@example.com',
                     username: 'Example9',
                     first_name: 'Name9',
                     last_name: 'LastName9')

[user1, user2, user3, user4, user5, user6, user7, user8, user9].each do |user|
  source = ExternalPaymentSource.create!(user: user)

  amount = (300..3000).to_a.sample

  source.balances.create!(total: amount, change: amount)
end

# Friendships
FriendshipService.add_mutual_friends(user1, user3)
FriendshipService.add_mutual_friends(user1, user6)
FriendshipService.add_mutual_friends(user2, user4)
FriendshipService.add_mutual_friends(user2, user6)
FriendshipService.add_mutual_friends(user3, user5)
FriendshipService.add_mutual_friends(user3, user6)
FriendshipService.add_mutual_friends(user3, user4)
FriendshipService.add_mutual_friends(user4, user5)

# Some basic payments
Payment.create!(sender: user1,
                receiver: user3,
                amount: 31.4,
                description: 'Thanks for the cake! 🎂')

Payment.create!(sender: user4,
                receiver: user5,
                amount: 6.9,
                description: 'This is what I owe you from the beers')

Payment.create!(sender: user6,
                receiver: user1,
                amount: 4.2,
                description: 'Welp')

Payment.create!(sender: user6,
                receiver: user2,
                amount: 100,
                description: 'Happy birthday buddy!')

Payment.create!(sender: user5,
                receiver: user3,
                amount: 88.8,
                description: 'Hello 👋')

Payment.create!(sender: user2,
                receiver: user6,
                amount: 999,
                description: 'A Lannyster always pays his debts')

Payment.create!(sender: user5,
                receiver: user3,
                amount: 314.15,
                description: 'Valar Morghulis')

Payment.create!(sender: user2,
                receiver: user4,
                amount: 72.59,
                description: 'I am not in danger, Skyler. I am the danger.')

# A large list of payments for pagination feature
25.times do |index|
  amount = (1..999).to_a.sample
  days_ago = (0..60).to_a.sample

  Payment.create!(sender: user1,
                  receiver: user6,
                  amount: amount,
                  description: "Some description, bye. #{index} - #{days_ago}",
                  created_at: days_ago.days.ago)
end
