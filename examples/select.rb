# frozen_string_literal: true

require_relative 'config'

examples = Examples.new

examples.add do |builder|
  builder
    .select
    .from(users: :u)
    .where(lastname: 'Jacobus')
    .where(age: 18)
end

examples.add do |builder|
  builder
    .select(:id, last_name: :lastname)
    .from(:users)
    .where(lastname: 'Jacobus')
end

examples.add do |builder|
  builder
    .select
    .from(:users)
    .where(age: nil)
end

examples.add do |builder|
  age_not_null = builder.adapter.equal(:age, nil).not

  builder
    .select
    .from(:users)
    .where(age_not_null)
end

puts examples.to_a.join("\n\n")
