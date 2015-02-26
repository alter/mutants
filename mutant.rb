class Mutant
  attr_accessor :name
  attr_accessor :hp
  attr_accessor :damage
  attr_accessor :status
  
  def initialize(name, hp, damage) 
    @name = name
    @hp = hp
    @damage = damage
    @status = 'alive'
  end 

  def stroke(enemy_obj)
    enemy_obj.hp -= damage
  end 
end
