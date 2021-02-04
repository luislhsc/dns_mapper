# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Models::DnsRecord.create(ip: '1.1.1.1', hostnames: 'lorem.com ipsum.com dolor.com amet.com')
Models::DnsRecord.create(ip: '2.2.2.2', hostnames: 'ipsum.com')
Models::DnsRecord.create(ip: '3.3.3.3', hostnames: 'ipsum.com dolor.com amet.com')
Models::DnsRecord.create(ip: '4.4.4.4', hostnames: 'ipsum.com dolor.com sit.com amet.com')
Models::DnsRecord.create(ip: '5.5.5.5', hostnames: 'dolor.com sit.com')
