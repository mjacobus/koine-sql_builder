# frozen_string_literal: true

require_relative 'config'

examples = Examples.new

examples.add do |builder|
  builder
    .select
    .from(users: :u)
    .where(lastname: 'Jacobus')
    .where(age: 18)

  # SELECT *
  # FROM users u
  # WHERE lastname = "Jacobus" AND age = 18
end

examples.add do |builder|
  builder
    .select(:id, last_name: :lastname)
    .from(:users)
    .where(lastname: 'Jacobus')

  # SELECT id, last_name AS lastname
  # FROM users
  # WHERE lastname = "Jacobus"
end

examples.add do |builder|
  builder
    .select
    .from(:users)
    .where(age: nil)

  # SELECT *
  # FROM users
  # WHERE age IS NULL
end

examples.add do |builder|
  age_not_null = builder.adapter.equal(:age, nil).not

  builder
    .select
    .from(:users)
    .where(age_not_null)

  # SELECT *
  # FROM users
  # WHERE age IS NOT NULL
end

examples.add do |builder|
  builder
    .select
    .from(:users)
    .join(:articles).on('users.id = articles.user_id')

  # SELECT *
  # FROM users
  # INNER JOIN articles ON users.id = articles.user_id
end

examples.add do |builder|
  builder
    .select
    .from(:users)
    .join(:articles, :a).on('users.id = a.user_id')

  # SELECT *
  # FROM users
  # INNER JOIN articles a ON users.id = a.user_id
end

puts
puts
puts examples.to_a.join("\n\n")
puts
puts
