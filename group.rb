require_relative 'status'

class Group < Mutant
  attr_accessor :name
  attr_accessor :size
  attr_accessor :max_hp
  attr_accessor :hp
  attr_accessor :status
  attr_accessor :damage
  attr_accessor :heal_power

  def initialize( name="Group_id#{rand(0..9999999999)}", mutants_array )
    @size = @max_hp = @hp = @damage = @heal_power = 0
    @name = name
    @size = mutants_array.size
    mutants_array.each do |mutant|
      @max_hp += mutant.max_hp
      @hp += mutant.hp
      @damage += mutant.damage
      @heal_power += mutant.heal_power
    end
  end

  def stroke( obj )
    obj.hp -= @damage
  end

  def heal
    @hp += @heal_power if self.is_wounded?
  end

end
