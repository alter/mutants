#!/usr/bin/env ruby
require_relative 'mutant'
require_relative 'group'

mob4 = Fighter.new('Red fighter', rand(90..100), rand(8..13))
mob5 = Fighter.new('Green fighter', rand(90..100), rand(8..13))
mob3 = Healer.new('Green healer', rand(20..30), 1, rand(3..15))

puts "#{mob3.name} hp: #{mob3.hp} damage: #{mob3.damage} heal_power: #{mob3.heal_power}"
puts "#{mob4.name} hp: #{mob4.hp} damage: #{mob4.damage} heal_power: #{mob4.heal_power}"
puts "#{mob5.name} hp: #{mob5.hp} damage: #{mob5.damage} heal_power: #{mob5.heal_power}"

def check_if_dead( obj )
    puts ">#{obj.name} still has hp: #{obj.hp}"
    if obj.hp <= 0
      puts "  #{obj.name} was killed"
      obj.dead
    end
end

def check_status( obj )
    obj.wounded if obj.hp < obj.max_hp and !obj.is_wounded?
end

def fight_steps( obj1, obj2 )
  obj1.stroke( obj2 )
  check_status( obj2 )
  check_if_dead( obj2 )
end

def group_fight_steps( obj1, obj2 )
  fight_steps( obj1, obj2 )
  obj2.heal
end

def fight(mob1, mob2, mob3)
  while !mob1.is_dead? and !mob2.is_dead? do
    fight_steps( mob1, mob2 )
    break if mob2.is_dead?

    fight_steps( mob2, mob1 )
    break if mob1.is_dead?

    mob3.heal(mob2)
  end
end

def group_fight( group1, group2 )
  while !group1.is_dead? or !group2.is_dead?
    group_fight_steps( group1, group2 )
    break if group2.is_dead?

    group_fight_steps( group2, group1 )
    break if group1.is_dead?
  end
end

fight(mob4, mob5, mob3)
puts "#{mob4.name} status: #{mob4.status_readable}"
puts "#{mob5.name} status: #{mob5.status_readable}"

# 2/3 - Fighters, 1/3 - Healers
def generate_group( size=10 )
  group = []
  size.times do |t|
    choice = rand(0..2)
    case choice
    when 0..1
      group << Fighter.new("Fighter_id#{rand(0..99999999)}", rand(80..110), rand(8..13) )
    when 2
      group << Healer.new("Healer_id#{rand(0..99999999)}", rand(20..60), rand(8..13) )
    end
  end
  group
end

group_red = Group.new( 'red', generate_group )
group_green = Group.new( 'green', generate_group )

puts
puts 'Groups'
puts "group_red name: #{group_red.name}"
puts "group_red size: #{group_red.size}"
puts "group_red damage: #{group_red.damage}"
puts "group_red max_hp: #{group_red.max_hp}"
puts "group_red hp: #{group_red.hp}"
puts "group_red heal_power: #{group_red.heal_power}"

puts
puts "group_green name: #{group_green.name}"
puts "group_green size: #{group_green.size}"
puts "group_green damage: #{group_green.damage}"
puts "group_green max_hp: #{group_green.max_hp}"
puts "group_green hp: #{group_green.hp}"
puts "group_green heal_power: #{group_green.heal_power}"

puts
puts 'Groups fight'
group_fight( group_red, group_green )
