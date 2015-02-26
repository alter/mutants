module Status
  ALIVE   = 1
  WOUNDED = 0
  DEAD    = -1
end

class Mutant
  include Status
  attr_accessor :name
  attr_accessor :max_hp
  attr_accessor :hp
  attr_accessor :status

  def initialize(name="Mutant_id#{rand(0..99999999999)}", hp=95, damage=10)
    @name = name
    @max_hp = @hp = hp
    @damage = damage
    @status = Status::ALIVE
    @heal = 3
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

  def stroke(object)
    object.hp -= @damage
  end
end

class Healer < Mutant
  attr_accessor :heal

  def heal(object)
    object.hp += @heal# if object.is_wounded?
  end
end
