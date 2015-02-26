#!/usr/bin/env ruby
require_relative( 'mutant' )

mob1 = Mutant.new('mob1',100,10)
mob2 = Mutant.new('mob2',90,12)

puts "#{mob1.name} hp: #{mob1.hp} damage: #{mob1.damage}"
puts "#{mob2.name} hp: #{mob2.hp} damage: #{mob2.damage}"

def fight(mob1, mob2)
  while mob2.hp > 0 or mob1.hp > 0 do
    mob1.stroke(mob2)
    puts ">#{mob2.name} still has hp: #{mob2.hp}"
    if mob2.hp <= 0
      puts ">#{mob2.name} was killed"
      mob2.status = "dead"
      break
    end

    mob2.stroke(mob1)
    puts "<#{mob1.name} still has hp: #{mob1.hp}"
    if mob1.hp <=0
      puts "<#{mob1.name} was killed"
      mob1.status = "dead"
      break
    end
  end
end

fight(mob1, mob2)
puts "#{mob1.name} status: #{mob1.status}"
puts "#{mob2.name} status: #{mob2.status}"
