require_relative 'status'

class Mutant
  include Status
  attr_accessor :name
  attr_accessor :max_hp
  attr_accessor :hp
  attr_accessor :status
  attr_reader :damage
  attr_reader :heal_power

  def initialize( name="Mutant_id#{rand(0..99999999999)}", hp=75, damage=1, heal_power=0 )
    @name = name
    @max_hp = @hp = hp
    @damage = damage
    @heal_power = heal_power
    @status = Status::ALIVE
  end

  def status_readable
    case @status
    when Status::ALIVE
      'ALIVE'
    when Status::WOUNDED
      'WOUNDED'
    when Status::DEAD
      'DEAD'
    end
  end

  def alive
    @status = Status::ALIVE
  end

  def is_alive?
    if @status == Status::ALIVE
      true
    else
      false
    end
  end

  def dead
    @status = Status::DEAD
  end

  def is_dead?
    if @status == Status::DEAD
      true
    else
      false
    end
  end

  def wounded
    @status = Status::WOUNDED
  end

  def is_wounded?
    if @status == Status::WOUNDED
      true
    else
      false
    end
  end
end

class Fighter < Mutant
  attr_accessor :damage

  def initialize( name="Fighter_id#{rand(0..99999999999)}", hp=95, damage=10 )
    super
    @damage = damage
  end

  def stroke(object)
    object.hp -= @damage
  end
end

class Healer < Mutant
  attr_accessor :heal_power

  def initialize( name="Healer_id#{rand(0..99999999999)}", hp=30, damage=1, heal_power=5 )
    super
    @heal_power = heal_power
  end

  def heal(object)
    object.hp += @heal_power# if object.is_wounded?
  end
end
