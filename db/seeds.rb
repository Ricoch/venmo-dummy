Setting.create_or_find_by!(key: 'min_version', value: '0.0')

User.create!(email: 'ricardo@rootstrap.com', username: 'Ricoch', first_name: 'Ricardo', last_name: 'Cortio')
User.create!(email: 'ricardo@rootstrap2.com', username: 'Ricoch2', first_name: 'Ricardo2', last_name: 'Cortio2')
