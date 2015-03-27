# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cities = City.create([
  { name: 'Boston', time_zone: 'Eastern Time (US & Canada)'}, 
  { name: 'Seattle', time_zone: 'Pacific Time (US & Canada)'}, 
  { name: 'Chicago', time_zone: 'Central Time (US & Canada)'}, 
  { name: 'Buffalo', time_zone: 'Eastern Time (US & Canada)'}])