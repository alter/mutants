#!/usr/bin/env ruby
require_relative( 'mutant' )

mob1 = Fighter.new('Red fighter', rand(90..100), rand(8..13))
mob2 = Fighter.new('Green fighter', rand(90..100), rand(8..13))
mob3 = Healer.new('Green healer', rand(20..30), rand(3..15))
mob4 = Fighter.new()
mob5 = Fighter.new()

puts "#{mob4.name} hp: #{mob4.hp} damage: #{mob4.damage}"
puts "#{mob5.name} hp: #{mob5.hp} damage: #{mob5.damage}"

def check_if_alive(mob)
    puts ">#{mob.name} still has hp: #{mob.hp}"
    if mob.hp <= 0
      puts "  #{mob.name} was killed"
      mob.status = Status::DEAD
    end
end

def check_status(mob)
    mob.status = Status::WOUNDED if mob.hp < mob.max_hp and mob.status != Status::WOUNDED
end

def fight(mob1, mob2, mob3)
  mob1_max_hp = mob1.hp
  mob2_max_hp = mob2.hp
  while mob2.status != Status::DEAD and mob1.status != Status::DEAD do
    mob1.stroke(mob2)
    check_status(mob2)
    check_if_alive(mob2)
    break if mob2.status == Status::DEAD

    mob2.stroke(mob1)
    check_status(mob1)
    check_if_alive(mob1)
    break if mob1.status == Status::DEAD

    mob3.heal(mob2)
  end
end

fight(mob4, mob5, mob3)
puts "#{mob4.name} status: #{mob4.status_readable}"
puts "#{mob5.name} status: #{mob5.status_readable}"
