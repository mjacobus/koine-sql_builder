# frozen_string_literal: true

require 'bundler/setup'
require 'koine/sql_builder'

builder = Koine::SqlBuilder::Builder.new

examples = []

examples.push builder.select
  .from(users: :u)
  .where(lastname: 'Jacobus')
  .where(age: 18)

puts examples.join("\n\n")
