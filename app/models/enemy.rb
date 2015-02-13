class Enemy < ActiveRecord::Base
  # Model methods get generated here.
    def enemy_currency
      self.currency = (self.level * 2) + rand(-2..5)
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
        if self.current_hp > self.max_hp
          diff = self.current_hp - self.max_hp
          self.current_hp = self.current_hp - diff
        end
      else
        return false
      end
    end
end
# End of File
