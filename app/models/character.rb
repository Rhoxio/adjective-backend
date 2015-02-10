class Character < ActiveRecord::Base
  # Model methods get generated here.

  def level_up
    level_table = {1 => 10, 2 => 50, 3 => 100, 4 => 175, 5 => 260, 6 => 365, 7 => 480, 8 => 630, 9 => 830, 10 => 1010}

    # Need to make this class-specific. 

    if self.exp >= level_table[self.level]
      self.exp = self.exp - level_table[self.level]
      self.level += 1
      self.max_hp += 20
      self.defense += 1
      self.initiative += 1
      self.attack_rating += 2
      self.current_hp = self.max_hp
      self.save!
      return true
    else
      return false
    end
  end


  def give_currency(amount) 
    if self.currency >= amount
      self.currency -= amount
    else
      return "Not enough currency..."
    end
  end

  def acquire_currency(amount)
    self.currency += amount
    self.save!
  end

  def dead?
    if self.current_hp <= 0
      return true
    else
      return false
    end
  end

  def heal(healing)
    if self.dead? == false
      self.current_hp += healing
      self.save!
      if self.current_hp > self.max_hp
        diff = self.current_hp - self.max_hp
        self.current_hp = self.current_hp - diff
        self.save!
      end
    return self.current_hp

    else
      return false
    end

  end

  def located?
    self.location
  end
end
# End of File
