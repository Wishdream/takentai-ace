#==============================================================================
# ■ SideView Battler Setup Ver100
#------------------------------------------------------------------------------
# Tankentai Sideview Battle System
#       by Enu (http://rpgex.sakura.ne.jp/home/)
# English Translation v1.1
#       by Wishdream (http://wishdream.org/)
#       Help by Okamikurainya
# Version Log:
#		1.1 - All actions, programs and full actions translated.
#		1.0 - Start of project, all documentation translated.
#------------------------------------------------------------------------------
# 　Actions made in Action Setup can be set for the Battler here.
# 　Battler Setup
#==============================================================================
class SideView
  #--------------------------------------------------------------------------
  # ● Cell config for Battlers = [Horizontal, Vertical]
  #   If no animation is used, use [1, 1]
  #--------------------------------------------------------------------------
  def max_pattern
    # Single ID Check
    case id
    when  1 # Actor no. 1
      return [ 3, 4]
    when -1 # Enemy no. 1 (Negative numbers are used for the enemy)
      return [ 1, 1]
    else # Ranged ID Check
      return [ 3, 4] if id > 0 # All actors (Above 0/Positive)
      return [ 1, 1] if id < 0 # All enemies (Below 0/Negative)
    end
    # Refer to the this area if you want to branch ID settings on the others
  end 
  #--------------------------------------------------------------------------
  # ● Shadow Filename
  #   Place Shadow file in the "Characters" folder.
  #   Use false for no shadow.
  #--------------------------------------------------------------------------
  def shadow
    return "shadow01" if id > 0 # All actors
    return false      if id < 0 # All enemies
  end 
  #--------------------------------------------------------------------------
  # ● Battler Invert Settings
  #   Set to true if you want to flip.
  #--------------------------------------------------------------------------
  def graphic_mirror_flag
    return false if id > 0 # All actors
    return true  if id < 0 # All enemies
  end 
  #--------------------------------------------------------------------------
  # ● Fixed Image Battler
  #   Battler index must be set to "" if true.
  #--------------------------------------------------------------------------
  def graphic_fix
    return false if id > 0 # All actors
    return true  if id < 0 # All enemies
  end 
  #--------------------------------------------------------------------------
  # ● Normal Idle/Standby
  #-------------------------------------------------------------------------- 
  def normal
    return "Idle"   if id > 0 # All actors
    return "Wait(Fixed) WT" if id < 0 # All enemies
    # You can also use an ACTION than a FULL ACTION here.
  end
  #--------------------------------------------------------------------------
  # ● Weak Idle/Standy
  #   Plays only if you have 1/4 of your HP is left.
  #-------------------------------------------------------------------------- 
  def pinch
    return "Weak Stance" if id > 0 # All actors
  end
  #--------------------------------------------------------------------------
  # ● State Action
  #   If multiple states are overlapping, the top most priority is done.
  #-------------------------------------------------------------------------- 
  def state(state_id)
    # Branch for State ID
    case state_id 
    when 1
      return "Dead" if id > 0 # All Actors
      return "Collapse Enemy" if id < 0 # All Enemies
    when 2
      return "Poison Stance"
    when 6
      return "Sleep Stance"
    when 3,4,5,7,8
      return "General Abnormal Stance"
    when 9
      return "Defense Stance"
    end
  end
  #--------------------------------------------------------------------------
  # ● After Skill Input Action
  #-------------------------------------------------------------------------- 
  def command
    # Branch for Skill ID
    case skill_id 
    when 2
      return "Command Defend"
    end
    # Branch for Skill Type
    case skill_type
    when 1 # Special
      return "Command Skill"
    when 2 # Magic
      return "Command Magic"
    end
  end
  #--------------------------------------------------------------------------
  # ● Entrance Action
  #-------------------------------------------------------------------------- 
  def first_action
    return "Battle Start Ally" if id > 0 # All Actors
    return "Wait(Fixed) WT"   if id < 0 # All Enemies
  end
  #--------------------------------------------------------------------------
  # ● Victory Action
  #-------------------------------------------------------------------------- 
  def win
    case id
    when  2,7,10 # Actors No. 2,7 and 10
      return "Victory Backward Somersault"
    else # All Actors
      return "Victory Pose"
    end
  end
  #--------------------------------------------------------------------------
  # ● Exit Action
  #   Action made if the party is changed
  #-------------------------------------------------------------------------- 
  def remove_action
    return "Ally Exit"
  end
  #--------------------------------------------------------------------------
  # ● Escape Action
  #-------------------------------------------------------------------------- 
  def escape
    return "Escape"   if id > 0 # All actors
    return "Enemy Escape" if id < 0 # All enemies
  end
  #--------------------------------------------------------------------------
  # ● Escape Fail Action
  #-------------------------------------------------------------------------- 
  def escape_ng
    return "Escape Fail"
  end
  #--------------------------------------------------------------------------
  # ● Command Input Start Action
  #-------------------------------------------------------------------------- 
  def command_b
    return "Command"
  end
  #--------------------------------------------------------------------------
  # ● Command Input End Action
  #-------------------------------------------------------------------------- 
  def command_a
    return "Command End"
  end
  #--------------------------------------------------------------------------
  # ● Damage Action
  #-------------------------------------------------------------------------- 
  def damage(attacker)
    # If critical damage
    if critical? 
      return "Big Damage"
    # If healed
    elsif recovery? 
      # Use return only if there isn't any action
      return
    end
    # Branch Skill ID
    case damage_skill_id 
    when 1 # Skill ID 1
      return "Damage"
    when 136 # Use return only if there isn't any action
      return 
    end
    # Branch Item ID (If an action is set on recovery then it is already set
    #                 by the recovery branch)
    case damage_item_id 
    when 1 # Item ID 1
      return
    else
      # If item other than above
      if damage_item_id != 0
        return
      end  
    end
    # Damage is 0 (Buff / Debuff magic, defend, an enemy's escape, etc. )
    if damage_zero?
      return
    end 
    # None of the above
    return "Damage"
  end
  #--------------------------------------------------------------------------
  # ● Evade Action 
  #   Branch the same as the damage action is possible
  #-------------------------------------------------------------------------- 
  def evasion(attacker)
    return "Shield Guard" if shield? # If equipped with a shield
    return "Evade"
  end
  #--------------------------------------------------------------------------
  # ● Miss Action
  #   Branch the same as the damage action is possible
  #-------------------------------------------------------------------------- 
  def miss(attacker)
    return "Shield Guard" if shield? # If equipped with a shield
    return "Evade"
  end
  #--------------------------------------------------------------------------
  # ● Weapon Action
  #   Specify the action used in each weapon.
  #   You can set the weapons of the enemy below.
  #-------------------------------------------------------------------------- 
  def weapon_action
    # Weapon ID
    case weapon_id
    when 0 # No Weapon / Bare Hands
      return "Normal Attack"
    when 1 # Weapon ID 1
      return "Slash Attack"
    end
    # Weapon Type
    case weapon_type 
    when 1 # Weapon Type 1
      return "Slash Attack"
    when 4,5,7,8,9 # Multiple Weapon Types
      return "Slash Attack"
    when 2
      return "Fist Attack"
    when 3
      return "Thrust Attack"
    when 6
      return "Bow Attack"
    end
  end
  #--------------------------------------------------------------------------
  # ● Enemy Right Hand Weapon
  #   Specify the Right Hand weapon of the enemy.
  #--------------------------------------------------------------------------
  def enemy_weapon1_id
    case id
    when -1 # Enemy ID 1 (Enemies are determined by a negative number)
      return 10 # Weapon ID. 0 is no weapon/bare hands
    else
      return 0
    end
  end
  #--------------------------------------------------------------------------
  # ● Enemy Left Hand Weapon
  #   Specify the Left Hand weapon of the enemy.
  #--------------------------------------------------------------------------
  def enemy_weapon2_id
    return 0
  end
  #--------------------------------------------------------------------------
  # ● Enemy Shield
  #   Specify the shield of the enemy. Overrides the Left Hand weapon.
  #--------------------------------------------------------------------------
  def enemy_shield_id
    return 0
  end
  #--------------------------------------------------------------------------
  # ● Weapon Graphics
  #--------------------------------------------------------------------------
  # In the settings of the weapon action [1: Single Image] [2: 2k3 Style]
  # return "001-Weapon01" ← Filename of the weapon.
  #                         Should be in the "Characters" folder.
  # Use an empty filename to hide the weapon instead.
  def weapon_graphic(weapon_id, weapon_type)
    # Weapon ID
    case weapon_id
    when 1 # Weapon ID 1
      return ""
    end
    # Weapon Type
    case weapon_type 
    when 6 # Weapon Type 6
      return "bow01"
    end
  end
  #--------------------------------------------------------------------------
  # ● Shield Graphics
  #--------------------------------------------------------------------------
  # In the settings of the weapon action [1: Single Image] [2: 2k3 Style]
  # The weapon action shield display option must be set to true to display.
  # 
  # return "001-Shield01" ← Filename of the shield.
  #                         Should be in the "Characters" folder.
  def shield_graphic(weapon_id, shield_type)
    # Armor ID
    case shield_id
    when 41 # Armor ID 41 (Buckler)
      return ""
    end
    # Armor Type
    case shield_type 
    when 5 # Armor Type 5 (Small Shield)
      return ""
    end
  end 
  
  #--------------------------------------------------------------------------
  # ● Skill Action
  #-------------------------------------------------------------------------- 
  def skill_action
    # Skill ID
    case skill_id 
    when 1 # Skill ID 1 (Normal Attack - Use Weapon Action)
      return weapon_action
    when 2 # Skill ID 2 (Defend)
      return "Defend"
    when 3,4,5 # Skill ID 3/4/5 (Multi-Attack)
      return weapon_action
    when 6 # Skill ID 6 (Enemy Escape)
      return escape
    when 7 # Skill ID 7 (Wait)
      return "Standby"
    when 128
      return "Water Gun"
    when 129
      return "Throw Weapon"
    when 130
      return "Attack 5 Times"
    when 131
      return "Cut-in Attack"
    when 132
      return "Movie Attack"
    when 133
      return "Wolf Transformation"
    when 134
      return "Derived Skill"
    when 135
      return "Dim Attack"
    when 136
      return "Air Attack"
    end
    # Skill Name (Recommended to use Skill ID instead)
    case skill_name 
    when "Starstorm"
      return "Background Change Attack"
    when "Sacred Tome"
      return "Picture Attack"
    end
    # Skill Type
    case skill_type 
    when 1 # Special
      return "Generic Skill"
    when 2 # Magic
      return "Generic Magic"
    end
    # None of the above
    return "Generic Skill"
  end
  #--------------------------------------------------------------------------
  # ● Item Action
  #-------------------------------------------------------------------------- 
  def item_action
    case item_id # Item ID
    when 1 
      return "Use Item"
    else
      return "Use Item"
    end
  end
  #--------------------------------------------------------------------------
  # ● Counter Skill ID
  #   Skill ID used for a counterattack.
  #-------------------------------------------------------------------------- 
  # ► Two or more times attack set up in the database is not reflected. 
  def counter_skill_id
    return 1
  end
  #--------------------------------------------------------------------------
  # ● Reflect Animation ID
  #   Animation ID used for a magic reflection.
  #-------------------------------------------------------------------------- 
  def reflection_anime_id
    return 118
  end
  #--------------------------------------------------------------------------
  # ● Substitute/Protect Start Action
  #-------------------------------------------------------------------------- 
  def substitute_start_action
    return "Substitute Start"
  end
  #--------------------------------------------------------------------------
  # ● Substitute/Protect End Action
  #-------------------------------------------------------------------------- 
  def substitute_end_action
    return "Substitute End"
  end
  #--------------------------------------------------------------------------
  # ● Substitute/Protect Receiver Start
  #-------------------------------------------------------------------------- 
  def substitute_receiver_start_action
    return "Substitute Start - Receiver"
  end
  #--------------------------------------------------------------------------
  # ● Substitute/Protect Receiver End
  #-------------------------------------------------------------------------- 
  def substitute_receiver_end_action
    return "Substitute End - Receiver"
  end
  #--------------------------------------------------------------------------
  # ● Enemy Level
  #   It is intended for the use of conditional branch, etc...
  #   Parameters are not reflected.
  #-------------------------------------------------------------------------- 
  def level
    case id
    when -1 # Enemy no. 1
      return 0
    end
    return 0
  end
  
end

