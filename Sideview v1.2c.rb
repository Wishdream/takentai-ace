#==============================================================================
# ■ Sideview Ver100
#------------------------------------------------------------------------------
# Tankentai Sideview Battle System
#       by Enu (http://rpgex.sakura.ne.jp/home/)
# English Translation v1.2
#       by Wishdream (http://wishdream.org/)
#       Help by Okamikurainya
# Version Log:
#		1.2c - Sprite_Battle_Picture, Sprite_Back_Picture,and Sprite_Damage translated.
#		1.2b - Sprite_Weapon translated.
#   	1.2 - Sideview main class translated.
#		1.1 - All actions, programs, and full actions translated.
#		1.0 - Start of project, all documentation translated.
#------------------------------------------------------------------------------
# 　The class that manages the sideview battle system.
#==============================================================================
class SideView
  #--------------------------------------------------------------------------
  # ● Public instance variables
  #--------------------------------------------------------------------------
  attr_accessor   :x                    # X screen coordinate
  attr_accessor   :y                    # Y screen coordinate
  attr_accessor   :z                    # Z screen coordinate
  attr_accessor   :h                    # Height coordinate
  attr_accessor   :j                    # Jump coordinates
  attr_accessor   :c                    # Curve coordinates
  attr_accessor   :ox                   # Horizontal origin
  attr_accessor   :oy                   # Vertical origin
  attr_accessor   :oy_adjust            # Vertical origin adjustment
  attr_accessor   :angle                # Rotation angle
  attr_accessor   :zoom_x               # X zoom
  attr_accessor   :zoom_y               # Y zoom
  attr_accessor   :pattern_w            # Cell horizontal position(rectangle)
  attr_accessor   :pattern_h            # Cell vertical position(rectangle)
  attr_accessor   :sx                   # Cell horizontal position(entire image)
  attr_accessor   :sy                   # Cell vertical position(entire image)
  attr_accessor   :pattern_type         # Cell update type
  attr_accessor   :pattern_time         # Cell update interval
  attr_accessor   :graphic_name         # Battler image filename
  attr_accessor   :graphic_file_index   # Battler image file index
  attr_accessor   :graphic_index        # Battler image index
  attr_accessor   :cw                   # Cell rectangle width
  attr_accessor   :ch                   # Cell rectangle height
  attr_accessor   :shadow_visible       # Shadow display
  attr_accessor   :weapon_visible       # Weapon display
  
  attr_accessor   :wait                 # Following operation wait time
  attr_accessor   :weapon_index         # Weapon display index array
  attr_accessor   :weapon_end           # Weapon animation end flag
  attr_accessor   :force_action         # Force action
  attr_accessor   :target_battler       # Target battler information
  attr_accessor   :second_targets       # Second target information
  attr_accessor   :m_a_targets          # Moving target information
  attr_accessor   :individual_targets   # Individual process target information
  attr_accessor   :effect_data          # Effect Data
  attr_accessor   :anime_id             # Animation ID array
  attr_accessor   :anime_move_id        # Moving Animation ID array
  attr_accessor   :mirror               # Flip Flag
  attr_accessor   :opacity              # Transparency
  attr_accessor   :opacity_data         # Transparency operation information
  attr_accessor   :set_damage           # Damage processing in-battle
  attr_accessor   :m_a_data             # Moving animation information
  attr_accessor   :m_a_starter          # Moving animation start target info
  attr_accessor   :action_end           # Action end of the battle scene
  attr_accessor   :damage_anime_data    # Damage combat animation data
  attr_accessor   :anime_no_mirror      # Battle anim NoFlip flag
  attr_accessor   :anime_horming        # Battle anim Homing flag
  attr_accessor   :anime_camera_zoom    # Battle anim scale to fit on camera
  attr_accessor   :anime_plus_z         # Battle anim Z adjustment
  attr_accessor   :derivation_skill_id  # Derive skill ID
  attr_accessor   :immortal             # Invunerability flag
  attr_accessor   :mirage               # Afterimage data
  attr_accessor   :balloon_data         # Balloon data
  attr_accessor   :timing               # Timing data from another battler
  attr_accessor   :timing_targets       # Pass timing data from another battler
  attr_accessor   :color_set            # Color change data
  attr_accessor   :color                # Color data
  attr_accessor   :change_up            # Image change flag
  attr_accessor   :hit                  # Number of hits
  attr_accessor   :add_state            # Prevent display of additional states
  attr_accessor   :counter_id           # Skill ID on counter
  attr_accessor   :reflection_id        # Skill ID on reflect
  attr_accessor   :result_damage        # HP change data at the end of the turn
  attr_accessor   :active               # Action permission
  attr_accessor   :anime_off            # Combat animation erase
  attr_accessor   :command_action       # Command action flag
    
  attr_accessor   :base_x               # Initial position X coordinate
  attr_accessor   :base_y               # Initial position Y coordinate
  attr_accessor   :base_h               # Initial position height coordinate
  attr_accessor   :max_pattern_w        # The horizontal division number of a cell
  attr_accessor   :max_pattern_h        # The vertical division number of a cell
  
  attr_reader     :collapse             # Collapse flag
  attr_reader     :picture              # Picture display flag
  #--------------------------------------------------------------------------
  # ● Object initialization
  #--------------------------------------------------------------------------
  def initialize(battler)
    @battler = battler
    reset
  end
  #--------------------------------------------------------------------------
  # ● Initialize / Reset
  #--------------------------------------------------------------------------
  def reset
    @x = 0
    @y = 0
    @z = 0
    @h = 0
    @j = 0
    @c = 0
    @jump = []
    @curve = []
    @ox = 0
    @oy = 0
    @oy_adjust = 0
    @z_plus = 0
    @move_time = 0
    @angle = 0
    @angle_time = 0
    @zoom_x = 1
    @zoom_y = 1
    @zoom_time = 0
    @pattern_w = 0
    @pattern_h = 0
    @sx = 0
    @sy = 0
    @pattern_type = 0
    @pattern_time = 0
    @pattern_rest_time = 0
    @graphic_name = ""
    @graphic_file_index = ""
    @graphic_index = 0
    @cw = 0
    @ch = 0
    @shadow_visible = false
    @weapon_visible = true
    
    @wait = 0
    @weapon_index = []
    @weapon_end = true
    @full_action = []
    @action = []
    @force_action = ""
    @target_battler = []
    @second_targets = []
    @individual_targets = []
    @m_a_targets = []
    @effect_data = []
    @anime_id = []
    @anime_move_id = []
    @opacity = 255
    @opacity_data = []
    @set_damage = false
    @m_a_data = []
    @m_a_starter = []
    @action_end = false
    @damage_anime_data = []
    @anime_no_mirror = false
    @anime_horming = false
    @anime_camera_zoom = false
    @anime_plus_z = true
    @derivation_skill_id = 0
    @immortal = false
    @mirage = []
    @play_data = []
    @balloon_data = []
    @picture = false
    @timing = []
    @timing_targets = []
    @color_set = []
    @color = []
    @change_up = false
    @non_motion = false
    @graphics_change = false
    @hit = []
    @add_state = []
    @collapse = false
    @counter_id = 0
    @reflection_id = 0
    @result_damage = [0,0]
    @active = false
    @anime_off = false
    @command_action = false
    
    @base_x = 0
    @base_y = 0
    @base_z = 0
    @base_h = 0
    @max_pattern_w = 0
    @max_pattern_h = 0
    @pattern_kind = 0
    @pattern_count = 0
    @move_time = 0
    @mirror = false
    @battler.set_graphic(@pre_change_data[0], @pre_change_data[1], @pre_change_data[2], @pre_change_data[3]) if @pre_change_data != nil
    @pre_change_data = nil
  end  
  #--------------------------------------------------------------------------
  # ● Setup
  #--------------------------------------------------------------------------
  def setup(bitmap_width, bitmap_height, first_action_flag)
    reset if first_action_flag
    set_data
    set_base_position if !@graphics_change
    set_graphics(bitmap_width, bitmap_height)
    set_target
    setup_graphics_change if @graphics_change
    first_battler_anime_set if first_action_flag
  end  
  #--------------------------------------------------------------------------
  # ● Retrieve Battler Data
  #--------------------------------------------------------------------------
  def set_data
    return if @battler == nil
    if @battler.actor?
      @graphic_name = @battler.character_name
      @graphic_index = @battler.character_index
    else
      @graphic_name = @battler.battler_name
      @graphic_index = 0
    end
    @max_pattern_w = max_pattern[0]
    @max_pattern_h = max_pattern[1]
  end
  #--------------------------------------------------------------------------
  # ● Set base position data = [X-axis, Y-axis, H-axis]
  #   moment_set - current placement
  #--------------------------------------------------------------------------
  def set_base_position(moment_set = true)
    mirroring_reset
    if @battler.actor?
      data = N03::ACTOR_POSITION[@battler.index].dup
      @base_x = data[0] * 100 if !@mirror
      @base_x = (Graphics.width - data[0]) * 100 if @mirror
    else
      data = [@battler.screen_x, @battler.screen_y, 0].dup
      @base_x = data[0] * 100 if !$sv_camera.mirror
      @base_x = (Graphics.width - data[0]) * 100 if $sv_camera.mirror
    end
    @base_y = data[1] * 100
    @base_h = data[2] * 100
    @base_z = @y
    return if !moment_set
    @x = @base_x 
    @y = @base_y
    @z = @base_z
  end
  #--------------------------------------------------------------------------
  # ● Retrieve graphics data
  #--------------------------------------------------------------------------
  def set_graphics(bitmap_width, bitmap_height)
    sign = @graphic_name[/^[\!\$]./]
    if sign && sign.include?('$')
      @cw = bitmap_width / @max_pattern_w
      @ch = bitmap_height / @max_pattern_h
    elsif @max_pattern_w == 1 && @max_pattern_h == 1
      @cw = bitmap_width
      @ch = bitmap_height
    else
      @cw = bitmap_width / (@max_pattern_w * 4)
      @ch = bitmap_height / (@max_pattern_h * 2)
    end
    @ox = @cw / 2
    @oy = @ch
    @sx = (@graphic_index % 4 * @max_pattern_w + @pattern_w) * @cw
    @sy = (@graphic_index / 4 * @max_pattern_h + @pattern_h) * @ch
  end
  #--------------------------------------------------------------------------
  # ● Set target
  #--------------------------------------------------------------------------
  def set_target(target = nil)
    @target_battler = target
    @target_battler = [@battler] if target == nil
    @second_targets = @target_battler
  end
  #--------------------------------------------------------------------------
  # ● Setup graphics change
  #--------------------------------------------------------------------------
  def setup_graphics_change
    @graphics_change = false
    @sx = (@graphic_index % 4 * @max_pattern_w + @pattern_w) * @cw
    @sy = (@graphic_index / 4 * @max_pattern_h + @pattern_h) * @ch
  end  
  #--------------------------------------------------------------------------
  # ● Set idle animation data at the start of the battle
  #--------------------------------------------------------------------------
  def first_battler_anime_set
    loop do
      update
      break if @action_data == nil
      break if @action_data[0] == "motion"
      break if @action_data[0] == "move" && @action_data[8] != ""
      break if @full_action == []
    end
    start_action(first_action) if @battler.movable?
  end
  #--------------------------------------------------------------------------
  # ● Start action
  #--------------------------------------------------------------------------
  def start_action(kind = nil)
    return if @event_fix && $game_troop.interpreter.running?
    # If it is canceled while waiting
    return @wait -= 1 if @wait > 0 && kind == nil
    action_setup(false) if kind != nil
    set_action(kind)
    @action = kind if @action == nil
    # When there is no action, it shifts to action termination processing.
    action_terminate if @action == nil
    # The next action decision 
    @action_data = N03::ACTION[@action]
    next_action
  end
  #--------------------------------------------------------------------------
  # ● Action parameter initialize
  #--------------------------------------------------------------------------
  def action_setup(reset = true)
    @event_fix = false
    @set_damage = false
    @action_end = false
    @balloon_data = []
    @loop_act = []
    angle_reset if reset
    zoom_reset if reset
    opacity_reset if reset
    @curve = []
    @c = 0
    convert_jump
  end  
  #--------------------------------------------------------------------------
  # ● Terminate action
  #--------------------------------------------------------------------------
  def action_terminate
    @mirage = [] if @mirage_end
    mirroring_reset
    @picture = false
    @individual_targets = []
    action_setup if @active
    action_setup(false) if !@active
    # Shift to the idle/standby action
    stand_by_action if !@non_motion
    # Exit control of the battler
    next_battler
  end  
  #--------------------------------------------------------------------------
  # ● Determine the content of the new action
  #--------------------------------------------------------------------------
  def set_action(kind = nil)
    full_act = N03::FULLACTION[kind]
    @full_action = full_act.dup if full_act != nil
    @action = @full_action.shift
    # Intergrate the action into a full action
    full_act2 = N03::FULLACTION[@action]
    @full_action = full_act2.dup + @full_action if full_act2 != nil
  end
  #--------------------------------------------------------------------------
  # ● Next Action
  #--------------------------------------------------------------------------
  def next_action
    @wait = 0
    # Shortcut check
    eval(@action) if @action != nil && @action_data == nil && N03::FULLACTION[@action] == nil
    # Wait setup
    @wait = @action.to_i if @wait == 0 && @action_data == nil
    @wait = rand(@wait.abs + 1) if @wait < 0
    # Start action
    action_play
  end
  #--------------------------------------------------------------------------
  # ● Shift to Idle/Stand by action
  #--------------------------------------------------------------------------
  def stand_by_action
    # Normal Idle
    stand_by_act = normal
    # Weak Idle
    stand_by_act = pinch if @battler.hp <= @battler.mhp / 4
    # State Idle
    stand_by_act = state(@battler.states[0].id) if @battler.states[0] != nil && state(@battler.states[0].id) != nil
    # Command Idle
    stand_by_act = command if @command_action && command != nil
    set_action(stand_by_act)
    @action = stand_by_act if @action == nil
  end
  #--------------------------------------------------------------------------
  # ● Force action start
  #--------------------------------------------------------------------------
  def start_force_action
    return if @active
    start_action(@force_action)
    @force_action = ""
  end  
  #--------------------------------------------------------------------------
  # ● Add action
  #--------------------------------------------------------------------------
  def add_action(kind)
    @full_action.push(kind)
  end  
  #--------------------------------------------------------------------------
  # ● Insert action
  #--------------------------------------------------------------------------
  def unshift_action(kind)
    @full_action.unshift(kind)
  end  
  #--------------------------------------------------------------------------
  # ● Frame Update
  #--------------------------------------------------------------------------
  def update
    # Action start
    start_action
    # Force action start
    start_force_action if @force_action != ""
    # Animation pattern update
    update_pattern
    # Move update
    update_move
    # Rotation update
    update_angle if @angle_time != 0
    # Zoom update
    update_zoom if @zoom_time != 0
    # Transparency update
    update_opacity if @opacity_data != []
  end
  #--------------------------------------------------------------------------
  # ● Animation pattern update
  #--------------------------------------------------------------------------
  def update_pattern
    return @pattern_rest_time -= 1 if @pattern_rest_time != 0
    return if @max_pattern_w == 1 && @max_pattern_h == 1
    @pattern_rest_time = @pattern_time
    # Get the playback start and end cell position
    if @pattern_kind > 0 # During normal playback
      @pattern_start = 0
      @pattern_end = @max_pattern_w - 1
    elsif @pattern_kind < 0 # Play in reverse
      @pattern_start = @max_pattern_w - 1
      @pattern_end = 0
    end
    # Finished playing one way
    @pattern_count += 1 if @pattern_w == @pattern_end && @pattern_kind != 0
    # Loop processing
    case @pattern_type.abs
    when  1,3 # Normal
      @pattern_kind =  0 if @pattern_count != 0 && @pattern_type ==  1
      @pattern_kind =  0 if @pattern_count != 0 && @pattern_type == -1
      @pattern_kind =  1 if @pattern_count != 0 && @pattern_type ==  3
      @pattern_kind = -1 if @pattern_count != 0 && @pattern_type == -3
      @pattern_w = @pattern_start - @pattern_kind if @pattern_count != 0 && @pattern_type.abs == 3
      @pattern_count = 0
    when  2,4 # Ping-pong
      @pattern_kind = -1 if @pattern_count == 1 && @pattern_type ==  2
      @pattern_kind =  1 if @pattern_count == 1 && @pattern_type == -2
      @pattern_kind =  0 if @pattern_count == 2 && @pattern_type ==  2
      @pattern_kind =  0 if @pattern_count == 2 && @pattern_type == -2
      @pattern_kind = -1 if @pattern_count == 1 && @pattern_type ==  4
      @pattern_kind =  1 if @pattern_count == 1 && @pattern_type == -4
      @pattern_kind =  1 if @pattern_count == 2 && @pattern_type ==  4
      @pattern_kind = -1 if @pattern_count == 2 && @pattern_type == -4
      @pattern_count = 0 if @pattern_count == 2
    end
    # Cell Update
    @pattern_w += 1 * @pattern_kind
    @sx = (@graphic_index % 4 * @max_pattern_w + @pattern_w) * @cw
  end
  #--------------------------------------------------------------------------
  # ● Movement Update
  #--------------------------------------------------------------------------
  def update_move
    @z = @y / 100 + @z_plus
    return if @move_time == 0
    target_position_set if @horming_move
    @x = (@x * (@move_time - 1) + @target_x) / @move_time
    @y = (@y * (@move_time - 1) + @target_y) / @move_time
    @h = (@h * (@move_time - 1) + @target_h) / @move_time if @move_h != nil
    @c += @curve[@move_time - 1] if @curve[@move_time - 1] != nil
    @j += @jump[@move_time - 1] if @jump[@move_time - 1] != nil
    @move_time -= 1
    convert_jump if @move_time == 0
  end
  #--------------------------------------------------------------------------
  # ● Update moving target
  #--------------------------------------------------------------------------
  def target_position_set
    target_position = N03.get_targets_position(@move_targets, @horming_move)
    @target_x = target_position[0] + @move_x
    @target_y = target_position[1] + @move_y
    @target_h = target_position[2] + @move_h if @move_h != nil
  end  
  #--------------------------------------------------------------------------
  # ● Rotation update
  #--------------------------------------------------------------------------
  def update_angle
    @angle += @angling
    @angle_time -= 1
    return if @angle_time != 0
    return angle_reset if @angle_data[4] == 0
    angling(@angle_data) if @angle_data[4] == 2
  end  
  #--------------------------------------------------------------------------
  # ● Zoom update
  #--------------------------------------------------------------------------
  def update_zoom
    @zoom_x += @zooming_x
    @zoom_y += @zooming_y
    @zoom_time -= 1
    return if @zoom_time != 0
    return zoom_reset if @zoom_data[4] == 0
    zooming(@zoom_data) if @zoom_data[4] == 2
  end
  #--------------------------------------------------------------------------
  # ● Transparency update
  #--------------------------------------------------------------------------
  def update_opacity
    @opacity += @opacity_data[2]
    @opacity_data[0] -= 1
    return if @opacity_data[0] != 0
    return if !@opacity_data[5]
    @opacity_data[2] *= -1
    @opacity_data[0] = @opacity_data[1]
  end
  #--------------------------------------------------------------------------
  # ● Start action
  #--------------------------------------------------------------------------
  def action_play 
    return if @action_data == nil
    action = @action_data[0]
    # Flip
    return mirroring                    if action == "mirror"
    # Afterimage
    return mirage_set                   if action == "mirage"
    # Rotate
    return angling                      if action == "angle"
    # Zoom
    return zooming                      if action == "zoom"
    # Transparency
    return set_opacity                  if action == "opacity"
    # Battler animation
    return battler_anime                if action == "motion"
    # Movement
    return move                         if action == "move"
    # Weapon
    return weapon_anime([@action_data]) if action == "wp"
    # Moving animation
    return move_anime                   if action == "m_a"
    # Collapse or No collapse
    return set_play_data                if action == "collapse" or action == "no_collapse"
    # Animation  
    return battle_anime                 if action == "anime"
    # Camera
    return camera                       if action == "camera"
    # Screen shake
    return shake                        if action == "shake"
    # Screen color
    return color_effect                 if action == "color"
    # Transition
    return transition                   if action == "ts"
    # Balloon
    return balloon_anime                if action == "balloon"
    # Picture
    return picture_set                  if action == "pic"
    # State
    return state_set                    if action == "sta"
    # FPS
    return fps                          if action == "fps"
    # Change battler graphic
    return graphics_change              if action == "change"
    # Derive
    return derivating_skill             if action == "der"
    # Play BGM/BGS/SE
    return sound                        if action == "sound"
    # Play Movie 
    return movie                        if action == "movie"
    # Switch
    return switches                     if action == "switch"
    # Variable
    return variable                     if action == "variable"
    # Condition (Switch)
    return nece_1                       if action == "n_1"
    # Condition (Variable)
    return nece_2                       if action == "n_2"
    # Condition (State)
    return nece_3                       if action == "n_3"
    # Condition (Skill)
    return nece_4                       if action == "n_4"
    # Condition (Parameter)
    return nece_5                       if action == "n_5"
    # Condition (Equipment)
    return nece_6                       if action == "n_6"
    # Condition (Script)
    return nece_7                       if action == "n_7"
    # Second Target
    return second_targets_set           if action == "s_t"
    # Call common event
    return call_common_event            if action == "common"
    # Clear battle animation
    return @anime_off = true            if action == "anime_off"
    # End Battle
    return BattleManager.process_abort  if action == "battle_end"
    # Screen Fix
    return Graphics.freeze              if action == "graphics_freeze"
    # Damage animation
    return damage_anime                 if action == "damage_anime"
    # Weapon hide
    return @weapon_visible = false      if action == "weapon_off"
    # Weapon show  
    return @weapon_visible = true       if action == "weapon_on"
    # Disable wait
    return @non_motion = true           if action == "non_motion"
    # Enable wait
    return @non_motion = false          if action == "non_motion_cancel"
    # Change base position
    return change_base_position         if action == "change_base_position"
    # Set base position
    return set_base_position(false)     if action == "set_base_position"
    # Force action  
    return force_act                    if action == "force_action"
    # Force action 2
    return force_act2                   if action == "force_action2"
    # Individual start
    return individual_start             if action == "individual_start"
    # Individual end
    return individual_end               if action == "individual_end"
    # Loop start
    return loop_start                   if action == "loop_start"
    # Loop end
    return loop_end                     if action == "loop_end"
    # Update only battler ON
    return only_action_on               if action == "only_action_on"
    # Update only battler OFF
    return only_action_off              if action == "only_action_off"
    # Start next battler immediately
    return next_battler                 if action == "next_battler"
    # Image change flag
    return set_change                   if action == "set_change"
    # Script   
    return eval(@action_data[0])
  end
  #--------------------------------------------------------------------------
  # ● Mirror Set
  #--------------------------------------------------------------------------
  def mirroring
    @mirror = !@mirror
  end  
  #--------------------------------------------------------------------------
  # ● Mirror Initialization/Reset
  #--------------------------------------------------------------------------
  def mirroring_reset
    @mirror = false
    mirroring if !@battler.actor? && N03::ENEMY_MIRROR
    mirroring if $sv_camera.mirror
  end  
  #--------------------------------------------------------------------------
  # ● Afterimage Set
  #--------------------------------------------------------------------------
  def mirage_set
    @mirage = @action_data.dup
    @mirage_end = @mirage[3]
    @mirage = [] if @mirage[1] == 0
  end  
  #--------------------------------------------------------------------------
  # ● Rotation Set
  #--------------------------------------------------------------------------
  def angling(data = @action_data)
    @angle_data = data.dup
    @oy = @ch / 2
    @oy_adjust = @ch * 50
    @angle_time = data[1]
    start_angle = data[2] * N03.mirror_num(@mirror)
    end_angle = data[3] * N03.mirror_num(@mirror)
    # If time is zero or less, it is set to the last angle immediately. 
    @angle_time = 1 if @angle_time <= 0
    # The angle per frame is taken out from time of rotation. 
    @angling = (end_angle - start_angle) / @angle_time
    # The initial angle of the remainder is not divisible
    @angle = (end_angle - start_angle) % @angle_time + start_angle
  end 
  #--------------------------------------------------------------------------
  # ● Mirror Initialization/Reset
  #--------------------------------------------------------------------------
  def angle_reset
    @oy = @ch
    @angle = @angle_time = @oy_adjust = 0
  end  
  #--------------------------------------------------------------------------
  # ● Zoom / Scale Set
  #--------------------------------------------------------------------------
  def zooming(data = @action_data)
    @zoom_data = data.dup
    @zoom_time = data[1]
    start_zoom_x = data[2][0]
    start_zoom_y = data[2][1]
    end_zoom_x = data[3][0]
    end_zoom_y = data[3][1]
    # If time is zero or less, it is set to the last size immediately. 
    @zoom_time = 1 if @zoom_time <= 0
    # The scaling rate per frame is taken out from scaling time.
    @zooming_x = (end_zoom_x - start_zoom_x) / @zoom_time
    @zooming_y = (end_zoom_y - start_zoom_y) / @zoom_time
    # Start size
    @zoom_x = start_zoom_x
    @zoom_y = start_zoom_y
  end  
  #--------------------------------------------------------------------------
  # ● Zoom / Scale Initialization/Reset
  #--------------------------------------------------------------------------
  def zoom_reset
    @zoom_x = @zoom_y = 1
    @zoom_time = 0
  end  
  #--------------------------------------------------------------------------
  # ● Opacity / Transparency Set
  #--------------------------------------------------------------------------
  def set_opacity
    data = @action_data.dup
    @opacity = data[2]
    opacity_move = (data[3] - data[2])/ data[1]
    @opacity_data = [data[1], data[1], opacity_move, data[4], data[5], data[6]]
    @wait = data[1] if data[7]
    @wait *= 2 if data[6] && data[7]
  end 
  #--------------------------------------------------------------------------
  # ● Opacity / Transparency Initialization/Reset
  #--------------------------------------------------------------------------
  def opacity_reset
    @opacity = 255
    @opacity = 0 if @battler.hidden?
    @opacity_data = []
  end
  #--------------------------------------------------------------------------
  # ● Battler Animation / Anime Set/Execute
  #--------------------------------------------------------------------------
  def battler_anime(anime_data = nil)
    anime_data = @action_data.dup if anime_data == nil
    @graphic_file_index = anime_data[1] if !graphic_fix
    @pattern_h = anime_data[2]
    @pattern_w = anime_data[3]
    @pattern_h = 0 if @max_pattern_w == 1
    @pattern_w = 0 if @max_pattern_h == 1
    @pattern_type = anime_data[4]
    @pattern_time = anime_data[5]
    @pattern_rest_time = anime_data[5]
    @pattern_count = 0
    @pattern_kind = 1
    @pattern_kind = -1 if @pattern_type < 0
    @pattern_kind = 0 if @pattern_type == 0
    @sx = (@graphic_index % 4 * @max_pattern_w + @pattern_w) * @cw
    @sy = (@graphic_index / 4 * @max_pattern_h + @pattern_h) * @ch
    @z_plus = anime_data[6]
    @wait = set_anime_wait if anime_data[7]
    @shadow_visible = anime_data[8]
    weapon_anime(anime_data)
  end
  #--------------------------------------------------------------------------
  # ● Animation / Anime Wait Calculation
  #--------------------------------------------------------------------------
  def set_anime_wait
    if @pattern_type > 0
      pattern_time_a = @max_pattern_w - @pattern_w.abs
    elsif @pattern_type < 0
      pattern_time_a = @pattern_w.abs + 1
    else
      return @pattern_time if @pattern_type == 0
    end
    case @pattern_type
    when 1,-1, 3,-3
      return pattern_time_a * @pattern_time 
    when 2,-2, 4,-4
      return pattern_time_a * @pattern_time + (@max_pattern_w - 2) * @pattern_time
    end
  end  
  #--------------------------------------------------------------------------
  # ● Movement Set/Execute
  #--------------------------------------------------------------------------
  def move
    @move_targets = N03.get_targets(@action_data[1].abs, @battler)
    return if @move_targets == []
    @move_targets = [@battler] if @action_data[1].abs == 7
    @move_x = @action_data[2] * 100 * N03.mirror_num(@mirror)
    @move_y = @action_data[3] * 100
    @move_h = @action_data[4] * 100 if @action_data[4] != nil
    @move_h = nil if @action_data[4] == nil
    battler_anime(N03::ACTION[@action_data[8]].dup) if N03::ACTION[@action_data[8]] != nil
    @horming_move = true
    @horming_move = false if @action_data[1] < 0 or @action_data[1].abs == 7
    target_position_set
    target_position = [@target_x, @target_y, @target_z]
    distanse_move = @action_data[5] > 0
    @move_time = N03.distanse_calculation(@action_data[5].abs, target_position, [@x, @y, @z], distanse_move)
    @wait = @move_time
    curve
    jump
    @move_time = 1 if @move_time == 0
    @horming_move = false if !@move_targets or @move_targets.include?(@battler)
    update_move if @move_time == 1
  end  
  #--------------------------------------------------------------------------
  # ● Curve Set
  #--------------------------------------------------------------------------
  def curve
    @c = 0
    return if @action_data[6] == 0
    @curve = N03.parabola([@action_data[6], -@action_data[6]], @move_time, 100, 4)
  end  
  #--------------------------------------------------------------------------
  # ● Jump Set
  #--------------------------------------------------------------------------
  def jump
    convert_jump
    return if @action_data[7] == [0,0]
    @jump = N03.parabola(@action_data[7].dup, @move_time, 100)
  end  
  #--------------------------------------------------------------------------
  # ● J coordinates (jump altitude) to H coordinates conversion
  #--------------------------------------------------------------------------
  def convert_jump
    @h += @j
    @j = 0
    @jump = []
  end  
  #--------------------------------------------------------------------------
  # ● Database Combat Animation Set/Execute
  #--------------------------------------------------------------------------
  def battle_anime
    data = @action_data.dup
    targets = N03.get_targets(data[2], @battler)
    return if targets == []
    data[8] = !data[8] if @mirror
    @set_damage           = data[5]
    @damage_anime_data[0] = N03.get_attack_anime_id(data[1], @battler)
    @damage_anime_data[1] = data[8]
    @damage_anime_data[2] = data[7]
    @damage_anime_data[3] = data[6]
    @damage_anime_data[4] = data[9]
    @wait = N03.get_anime_time(@damage_anime_data[0]) - 2 if data[4]
    return if @set_damage
    for target in targets do display_anime(targets, target, data) end
  end
  #--------------------------------------------------------------------------
  # ● Weapon Animation Set/Execute
  #--------------------------------------------------------------------------
  def weapon_anime(anime_data)
    @weapon_end = true
    for i in 9...anime_data.size
      set_effect_data(anime_data[i]) if anime_data[i] != ""
    end
  end
  #--------------------------------------------------------------------------
  # ● Start Moving Animation
  #--------------------------------------------------------------------------
  def move_anime
    @m_a_starter = []
    @m_a_targets = []
    starters = N03.get_targets(@action_data[2], @battler)
    targets = N03.get_targets(@action_data[3], @battler)
    return if starters == [] or targets == []
    single_start = true if starters != nil && @action_data[2] < 0
    single_start = true if @action_data[1][0] != 0 && $data_animations[N03.get_attack_anime_id(@action_data[1][0], @battler)].position == 3
    starters = [starters[0]] if single_start
    single_end = true if targets != nil && @action_data[3] < 0
    single_end = true if @action_data[1][1] != 0 && $data_animations[N03.get_attack_anime_id(@action_data[1][1], @battler)].position == 3
    targets = [targets[0]] if single_end
    se_flag = true
    for starter in starters
      for target in targets
        data = @action_data.dup
        data[17] = se_flag
        @effect_data.push(data)
        @m_a_targets.push(target)
        @m_a_starter.push(starter)
        se_flag = false
      end
    end  
  end
  #--------------------------------------------------------------------------
  # ● Spriteset Communication
  #--------------------------------------------------------------------------
  def set_effect_data(data = @action)
    action_data = N03::ACTION[data]
    return if action_data == nil
    @effect_data.push(action_data.dup)
  end
  #--------------------------------------------------------------------------
  # ● Store battle scene communication data
  #--------------------------------------------------------------------------
  def set_play_data(data = @action_data)
    @play_data = data.dup
  end
  #--------------------------------------------------------------------------
  # ● Display Combat Animation
  #--------------------------------------------------------------------------
  def display_anime(targets, target, data)
    return if !N03.first_of_all_screen_anime(data[1], target, targets)
    target.animation_id         = N03.get_attack_anime_id(data[1], @battler)
    target.animation_mirror     = data[8]
    target.sv.anime_horming     = data[3]
    target.sv.anime_camera_zoom = data[6]
    target.sv.anime_no_mirror   = data[7]
    target.sv.anime_plus_z      = data[9]
  end
  #--------------------------------------------------------------------------
  # ● Combat Animation Extension Data Initialization/Reset
  #--------------------------------------------------------------------------
  def reset_anime_data
    @anime_no_mirror = false
    @anime_horming = false
    @anime_camera_zoom = false
    @timing_targets = []
    @anime_plus_z = true
  end  
  #--------------------------------------------------------------------------
  # ● Camera work
  #--------------------------------------------------------------------------
  def camera
    data = @action_data.dup
    N03.camera(@battler, data)
    @wait = data[4] if data[5]
  end  
  #--------------------------------------------------------------------------
  # ● Screen Shake
  #--------------------------------------------------------------------------
  def shake
    data = @action_data.dup
    $sv_camera.shake(data[1], data[2], data[3])
    @wait = data[3] if data[4]
  end 
  #--------------------------------------------------------------------------
  # ● Screen Color Change
  #--------------------------------------------------------------------------
  def color_effect
    case @action_data[1]
    when 0,1,2,3,4,5
      targets = N03.get_targets(@action_data[1], @battler)
    when 6
      screen = true
    when 7
      targets = [@battler] + @target_battler
    when 8
      screen = true
      targets = $game_troop.members + $game_party.battle_members - [@battler]
    when 9
      screen = true
      targets = $game_troop.members + $game_party.battle_members - [@battler] - @target_battler
    when 10
      screen = true
      targets = $game_troop.members + $game_party.battle_members
    end
    return if screen == nil && targets == []
    for target in targets do target.sv.color_set = @action_data[2] end if targets
    @wait = @action_data[2][4] if @action_data[3]
    return if !screen
    $sv_camera.color_set[1] = @action_data[2]
    $sv_camera.color_set[2] = @action_data[2]
  end  
  #--------------------------------------------------------------------------
  # ● Transition
  #--------------------------------------------------------------------------
  def transition
    $sv_camera.perform_transition(@action_data)
  end  
  #--------------------------------------------------------------------------
  # ● Balloon Animation Display
  #--------------------------------------------------------------------------
  def balloon_anime
    @balloon_data = @action_data.dup
  end  
  #--------------------------------------------------------------------------
  # ● Picture Display
  #--------------------------------------------------------------------------
  def picture_set
    @picture = true
    set_effect_data
  end
  #--------------------------------------------------------------------------
  # ● State Operation
  #--------------------------------------------------------------------------
  def state_set
    targets = N03.get_targets(@action_data[1], @battler)
    return if targets == []
    case @action_data[2]
    when 1 ; targets = [targets[rand(targets.size)]]
    when 2 ; targets -= @battler if targets.include?(@battler)
    end
    for target in targets
      for id in @action_data[4]
        target.add_state(id) if @action_data[3] == "+"
        target.remove_state(id) if @action_data[3] == "-"
      end
    end
  end 
  #--------------------------------------------------------------------------
  # ● Change FPS
  #--------------------------------------------------------------------------
  def fps
    Graphics.frame_rate = @action_data[1]
    start_action
  end
  #--------------------------------------------------------------------------
  # ● Change Battler Graphic
  #--------------------------------------------------------------------------
  def graphics_change
    @graphics_change = true
    return @battler.graphics_change(@action_data[3]) if !@battler.actor?
    @pre_change_data = [@battler.character_name, @battler.character_index, @battler.face_name, @battler.face_index] if @pre_change_data == nil && !@action_data[1]
    if @action_data[4] == []
      face_name = @battler.face_name
      face_index = @battler.face_index
    else
      face_name = @action_data[4][1]
      face_index = @action_data[4][0]
    end
    @battler.set_graphic(@action_data[3], @action_data[2], face_name, face_index)
  end 
  #--------------------------------------------------------------------------
  # ● Derive Skill 
  #--------------------------------------------------------------------------
  def derivating_skill
    # If unlearned skill, it cannot be derived
    return if !@action_data[1] && !@battler.skill_learn?($data_skills[@action_data[3]])
    # If the skill cost cannot be fulfilled, it cannot be derived
    return if !@action_data[2] && !@battler.skill_cost_payable?($data_skills[@action_data[3]])
    # Derived
    @derivation_skill_id = @action_data[3]
    # Subsequent actions are canceled
    @full_action = []
  end
  #--------------------------------------------------------------------------
  # ● Play BGM/BGS/SE
  #--------------------------------------------------------------------------
  def sound
    pitch = @action_data[2] 
    vol   = @action_data[3]
    name  = @action_data[4] 
    case @action_data[1]
    when "se"
      Audio.se_play("Audio/SE/" + name, vol, pitch)
    when "bgm"
      # Present BGM is not changed when there is no name specified
      name = RPG::BGM.last.name if @action_data[4] == ""
      Audio.bgm_play("Audio/BGM/" + name, vol, pitch)
    when "bgs"
      name = RPG::BGS.last.name if @action_data[4] == ""
      Audio.bgs_play("Audio/BGS/" + name, vol, pitch)
    end
  end
  #--------------------------------------------------------------------------
  # ● Play Movie
  #--------------------------------------------------------------------------
  def movie
    Graphics.play_movie('Movies/' + @action_data[1])
  end
  #--------------------------------------------------------------------------
  # ● Game switch operation
  #--------------------------------------------------------------------------
  def switches
    for id in @action_data[1]
      $game_switches[id] = true if id > 0
      $sv_camera.switches[id.abs] = true  if id < 0
    end
    for id in @action_data[2]
      $game_switches[id] = false if id > 0
      $sv_camera.switches[id.abs] = false  if id < 0
    end
    $sv_camera.program_check
  end
  #--------------------------------------------------------------------------
  # ● Game variable operation
  #--------------------------------------------------------------------------
  def variable
    # Operand check
    operand = @action_data[3]
    operand = $game_variables[@action_data[3].abs] if @action_data[3] < 0
    # Branch in variable operation
    case @action_data[2]
    when 0 ; $game_variables[@action_data[1]] = operand  # Assign
    when 1 ; $game_variables[@action_data[1]] += operand # Add
    when 2 ; $game_variables[@action_data[1]] -= operand # Subtract
    when 3 ; $game_variables[@action_data[1]] *= operand # Multiply
    when 4 ; $game_variables[@action_data[1]] /= operand # Divide
    when 5 ; $game_variables[@action_data[1]] %= operand # Remainder
    end
  end
  #--------------------------------------------------------------------------
  # ● Conditional branch (game switch)
  #--------------------------------------------------------------------------
  def nece_1
    judgment = $game_switches[@action_data[1]] == @action_data[2] if @action_data[1] > 0
    judgment = $sv_camera.switches[@action_data[1].abs] == @action_data[2] if @action_data[1] < 0
    action_diverging(judgment, @action_data[3])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (game variables)
  #--------------------------------------------------------------------------
  def nece_2
    variable = $game_variables[@action_data[1]]
    num = @action_data[2]
    num = $game_variables[@action_data[2].abs] if num < 0
    case @action_data[3]
    when 0 ; judgment = variable == num
    when 1 ; judgment = variable < num
    when 2 ; judgment = variable > num
    end  
    action_diverging(judgment, @action_data[4])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (state)
  #--------------------------------------------------------------------------
  def nece_3
    targets = N03.get_targets(@action_data[1], @battler)
    return if targets == []
    member_num = @action_data[4]
    member_num = targets.size if @action_data[4] == 0 && targets.size > 1
    hit_count = 0
    miss_count = 0
    for target in targets
      hit_count += 1 if target.state?(@action_data[2])
      miss_count += 1 if !target.state?(@action_data[2])
    end
    case @action_data[3]
    when 0 ; judgment = hit_count >= member_num
    when 1 ; judgment = miss_count >= member_num
    end
    action_diverging(judgment, @action_data[5])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (skills)
  #--------------------------------------------------------------------------
  def nece_4
    targets = N03.get_targets(@action_data[1], @battler)
    return if targets == []
    member_num = @action_data[4]
    member_num = targets.size if @action_data[4] == 0 && targets.size > 1
    hit_count = 0
    miss_count = 0
    for target in targets
      hit_count += 1 if target.skill_learn?($data_skills[@action_data[2]]) && target.skill_conditions_met?($data_skills[@action_data[2]])
      miss_count += 1 if !target.skill_learn?($data_skills[@action_data[2]]) or !target.skill_conditions_met?($data_skills[@action_data[2]])
    end
    case @action_data[3]
    when 0 ; judgment = hit_count >= member_num
    when 1 ; judgment = miss_count >= member_num
    end
    action_diverging(judgment, @action_data[5])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (parameter)
  #--------------------------------------------------------------------------
  def nece_5
    targets = N03.get_targets(@action_data[1], @battler)
    return if targets == []
    member_num = @action_data[5]
    member_num = targets.size if @action_data[5] == 0 && targets.size > 1
    hit_count = 0
    for target in targets
      hit_count += 1 if target.comparison_parameter([@action_data[2],@action_data[3],@action_data[4]])
    end
    judgment = hit_count >= member_num
    action_diverging(judgment, @action_data[6])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (equipment)
  #--------------------------------------------------------------------------
  def nece_6
    targets = N03.get_targets(@action_data[1], @battler)
    return if targets == []
    member_num = @action_data[5]
    member_num = targets.size if @action_data[5] == 0 && targets.size > 1
    hit_count = 0
    miss_count = 0
    for target in targets
      hit_count += 1 if target.comparison_equip([@action_data[2],@action_data[3]])
      miss_count += 1 if !target.comparison_equip([@action_data[2],@action_data[3]])
    end
    case @action_data[4]
    when 0 ; judgment = hit_count >= member_num
    when 1 ; judgment = miss_count >= member_num
    end
    action_diverging(judgment, @action_data[6])
  end  
  #--------------------------------------------------------------------------
  # ● Conditional branch (script)
  #--------------------------------------------------------------------------
  def nece_7
    judgment = eval(@action_data[2])
    action_diverging(judgment, @action_data[1])
  end  
  #--------------------------------------------------------------------------
  # ● Action Branch / Diverge
  #--------------------------------------------------------------------------
  def action_diverging(judgment, kind)
    result = 0
    if judgment
      result = 1 if kind == 1
      result = 2 if kind == 2
    else
      result = 1 if kind == 0
    end
    # End of Full Action
    return @full_action = []  if result == 2
    # The following action is removed
    @full_action.shift if result == 1
    set_action
    # The following action is performed
    @action_data = N03::ACTION[@action]
    next_action
  end
  #--------------------------------------------------------------------------
  # ● Second target operation
  #--------------------------------------------------------------------------
  def second_targets_set
    targets = N03.get_targets(@action_data[1], @battler)
    for target in targets
      targets.delete(target) if @action_data[2][1] == 1 && target.index != @action_data[2][0]
      targets.delete(target) if @action_data[2][1] == 2 && target.index == @action_data[2][0].abs
      targets.delete(target) if @action_data[3] > 0 && target.id != @action_data[3]
      targets.delete(target) if @action_data[3] < 0 && target.id == @action_data[3].abs
      targets.delete(target) if @action_data[4] > 0 && !target.state?(@action_data[4])
      targets.delete(target) if @action_data[4] < 0 && target.state?(@action_data[4].abs)
      targets.delete(target) if @action_data[5] > 0 && !target.skill_conditions_met?($data_skills[@action_data[5]])
      targets.delete(target) if @action_data[5] < 0 && target.skill_conditions_met?($data_skills[@action_data[5].abs])
      targets.delete(target) if !target.comparison_parameter(@action_data[6])
      targets.delete(target) if !@action_data[7][1].include?(0) && !target.comparison_equip(@action_data[7])
    end
    return @second_targets = [] if targets.size == 0
    case @action_data[8]
    when 1 ; targets = [targets[rand(targets.size)]]
    when 2 ; targets.delete(@battler)
    end
    return @second_targets = [] if targets.size == 0
    @second_targets = targets
    case @action_data[9]
    when 0 ; return
    when 1 ; set_play_data(["second_targets_set"])
    when 2 ; set_play_data(["targets_set"])
    end
    @wait += 1
  end
  #--------------------------------------------------------------------------
  # ● Call Common Event
  #--------------------------------------------------------------------------
  def call_common_event
    $game_temp.reserve_common_event(@action_data[1])
    $sv_camera.event = true
    @event_fix = @action_data[2]
  end
  #--------------------------------------------------------------------------
  # ● Damage Animation / Anime
  #--------------------------------------------------------------------------
  def damage_anime(delay_time = 12)
    anime(N03.get_attack_anime_id(-3, @battler), wait = true)
    action_play
    @wait -= delay_time
    @full_action.unshift("eval('@damage_anime_data = []
    @set_damage = true')")
  end
  #--------------------------------------------------------------------------
  # ● Normally Collapse
  #--------------------------------------------------------------------------
  def normal_collapse
    @collapse = true
    return
  end
  #--------------------------------------------------------------------------
  # ● Change Initial/Base Position
  #--------------------------------------------------------------------------
  def change_base_position
    @base_x = @x
    @base_y = @y
    @base_h = @h
  end  
  #--------------------------------------------------------------------------
  # ● Force Action
  #--------------------------------------------------------------------------
  def force_act
    target(@full_action.shift)
  end
  #--------------------------------------------------------------------------
  # ● Force Action (2nd Target)
  #--------------------------------------------------------------------------
  def force_act2
    target2(@full_action.shift)
  end
  #--------------------------------------------------------------------------
  # ● Solo Start
  #--------------------------------------------------------------------------
  def individual_start
    @individual_targets = @target_battler.dup
    @remain_targets = @target_battler.dup
    @target_battler = [@individual_targets[0]]
    # リピート部分のアクションを保持
    @individual_act = @full_action.dup
  end
  #--------------------------------------------------------------------------
  # ● Solo End
  #--------------------------------------------------------------------------
  def individual_end
    @individual_targets.shift
    for target in @individual_targets
      @individual_targets.shift if target.dead?
    end
    # Repeat action if target remains
    return @target_battler = @remain_targets if @individual_targets.size == 0
    @full_action = @individual_act.dup
    @target_battler = [@individual_targets[0]]
  end
  #--------------------------------------------------------------------------
  # ● Loop Start
  #--------------------------------------------------------------------------
  def loop_start
    # Holds the loop action
    @loop_act = @full_action.dup
  end
  #--------------------------------------------------------------------------
  # ● Loop End
  #--------------------------------------------------------------------------
  def loop_end
    # Action repeat
    @full_action = @loop_act.dup if @loop_act != []
  end
  #--------------------------------------------------------------------------
  # ● Next Battler
  #--------------------------------------------------------------------------
  def next_battler
    @action_end = true
    @active = false
  end
  #--------------------------------------------------------------------------
  # ● Picture Change Flag
  #--------------------------------------------------------------------------
  def set_change
    @change_up = true
  end
  #--------------------------------------------------------------------------
  # ● Battle Scene Communication
  #--------------------------------------------------------------------------
  def play_data
    data = @play_data
    @play_data = []
    return data
  end
  #--------------------------------------------------------------------------
  # ● Shortcut Command
  #--------------------------------------------------------------------------
  def anime(anime_id, wait = true)
    @action_data = ["anime",anime_id,1,false,wait,false,true,false]
  end
  def anime_me(anime_id, wait = true)
    @action_data = ["anime",anime_id,0,false,wait,false,true,false]
  end
  def se(file, pitch = 100)
    @action_data = ["sound",  "se", pitch, 100, file]
  end
  def target(act)
    for target in @target_battler do target.sv.force_action = act end
  end
  def target2(act)
    for target in @second_targets do target.sv.force_action = act end
  end
  def delay(time)
    @wait = @battler.index * time
  end
  #--------------------------------------------------------------------------
  # ● Get ID of the Battler
  #--------------------------------------------------------------------------
  def id
    return @battler.id if @battler.actor?
    return -@battler.id
  end
  #--------------------------------------------------------------------------
  # ● Get Critical Flag
  #--------------------------------------------------------------------------
  def critical?
    return @battler.result.critical
  end
  #--------------------------------------------------------------------------
  # ● Get Recovery Flags
  #--------------------------------------------------------------------------
  def recovery?
    recovery = false
    recovery = true if @battler.result.hp_damage < 0
    recovery = true if @battler.result.mp_damage < 0
    recovery = true if @battler.result.tp_damage < 0
    return recovery
  end
  #--------------------------------------------------------------------------
  # ● Get Skill ID Damage
  #--------------------------------------------------------------------------
  def damage_skill_id
    return @damage_skill_id
  end
  #--------------------------------------------------------------------------
  # ● Get Item ID Damage
  #--------------------------------------------------------------------------
  def damage_item_id
    return @damage_item_id
  end
  #--------------------------------------------------------------------------
  # ● Get Weapon ID
  #--------------------------------------------------------------------------
  def weapon_id
    return 0 if !@battler.weapons[0]
    return @battler.weapons[0].id
  end
  #--------------------------------------------------------------------------
  # ● Get Weapon Type
  #--------------------------------------------------------------------------
  def weapon_type
    return 0 if !@battler.weapons[0]
    return @battler.weapons[0].wtype_id
  end
  #--------------------------------------------------------------------------
  # ● Get If Shield Equipped
  #--------------------------------------------------------------------------
  def shield?
    for armor in @battler.armors do return true if armor != nil && armor.etype_id == 1 end
    return false
  end
  #--------------------------------------------------------------------------
  # ● Get if there is damage
  #--------------------------------------------------------------------------
  def damage_zero?
    return @battler.result.hp_damage == 0 && @battler.result.mp_damage == 0 && @battler.result.tp_damage == 0
  end
  #--------------------------------------------------------------------------
  # ● Get Skill ID
  #--------------------------------------------------------------------------
  def skill_id
    return @counter_id if @counter_id != 0
    return 0 if @battler.current_action == nil or @battler.current_action.item == nil
    return 0 if @battler.current_action.item.is_a?(RPG::Item)
    return @battler.current_action.item.id
  end
  #--------------------------------------------------------------------------
  # ● Get Skill Type
  #--------------------------------------------------------------------------
  def skill_type
    return 0 if skill_id == 0
    return $data_skills[skill_id].stype_id
  end
  #--------------------------------------------------------------------------
  # ● Get Skill Name
  #--------------------------------------------------------------------------
  def skill_name
    return "" if skill_id == 0
    return $data_skills[skill_id].name
  end
  #--------------------------------------------------------------------------
  # ● Get Item ID
  #--------------------------------------------------------------------------
  def item_id
    return 0 if @battler.current_action == nil or @battler.current_action.item == nil
    return @battler.current_action.item.id
  end
  #--------------------------------------------------------------------------
  # ● Attack Action
  #--------------------------------------------------------------------------
  def attack_action(item)
    return skill_action if item.is_a?(RPG::Skill)
    return item_action
  end
  #--------------------------------------------------------------------------
  # ● Damage Action Base
  #--------------------------------------------------------------------------
  def damage_action_base(item)
    @damage_skill_id = 0
    @damage_item_id = 0
    @damage_skill_id = item.id if item.is_a?(RPG::Skill)
    @damage_item_id = item.id if item.is_a?(RPG::Item)
  end  
  #--------------------------------------------------------------------------
  # ● Damage Action
  #--------------------------------------------------------------------------
  def damage_action(attacker, item)
    damage_action_base(item)
    act = damage(attacker)
    return if @active
    start_action(act) if act != nil
  end
  #--------------------------------------------------------------------------
  # ● Evade Action
  #--------------------------------------------------------------------------
  def evasion_action(attacker, item)
    damage_action_base(item)
    act = evasion(attacker)
    return if @active
    start_action(act) if act != nil
  end
  #--------------------------------------------------------------------------
  # ● Miss Action
  #--------------------------------------------------------------------------
  def miss_action(attacker, item)
    damage_action_base(item)
    act = miss(attacker)
    return if @active
    start_action(act) if act != nil
  end
  #--------------------------------------------------------------------------
  # ● Flash Action combined with script
  #--------------------------------------------------------------------------
  def flash_action
    return "Flash Self"
  end
  
end

 
#==============================================================================
# ■ module N03
#------------------------------------------------------------------------------
# 　The module for the sideview battle.
#==============================================================================
module N03
  #--------------------------------------------------------------------------
  # ● Get the enemy group of the battler
  #--------------------------------------------------------------------------
  def self.get_enemy_unit(battler)
    return $game_troop if battler.actor?
    return $game_party
  end
  #--------------------------------------------------------------------------
  # ● Get the ally group of the battler
  #--------------------------------------------------------------------------
  def self.get_party_unit(battler)
    return $game_party if battler.actor?
    return $game_troop
  end
  #--------------------------------------------------------------------------
  # ● Get the Combat Animation Time
  #--------------------------------------------------------------------------
  def self.get_anime_time(anime_id)
    return 0 if anime_id <= 0
    return $data_animations[anime_id].frame_max * 4
  end
  #--------------------------------------------------------------------------
  # ● Get the Attack Animation
  #--------------------------------------------------------------------------
  def self.get_attack_anime_id(kind, battler)
    return $data_skills[battler.sv.counter_id].animation_id if kind == -3 && battler.sv.counter_id != 0
    case kind
    when -1 ; anime_id = battler.atk_animation_id1
    when -2 ; anime_id = battler.atk_animation_id2
    when -3
      if battler.current_action != nil
        anime_id = battler.current_action.item.animation_id if battler.current_action.item != nil
      end
    else    ; anime_id = kind
    end
    case anime_id
    when -1 ; anime_id = battler.atk_animation_id1
    when -2 ; anime_id = battler.atk_animation_id2
    end
    return anime_id if anime_id
    return 0
  end  
  #--------------------------------------------------------------------------
  # ● Set Damage Animation Data
  #--------------------------------------------------------------------------
  def self.set_damage_anime_data(targets, target, data)
    return if !first_of_all_screen_anime(data[0], target, targets)
    target.animation_id         = data[0]
    target.animation_mirror     = data[1]
    target.sv.anime_no_mirror   = data[2]
    target.sv.anime_camera_zoom = data[3]
    target.sv.anime_plus_z      = data[4]
  end    
  #--------------------------------------------------------------------------
  # ● Get Targets
  #--------------------------------------------------------------------------
  def self.get_targets(kind, battler)
    case kind.abs
    when 0 ; return [battler].dup
    when 1 ; return battler.sv.target_battler.dup
    when 2 ; return get_enemy_unit(battler).members.dup
    when 3 ; return get_party_unit(battler).members.dup
    when 4 ; return $game_troop.members.dup + $game_party.battle_members.dup
    when 5 ; return battler.sv.second_targets.dup
    end
  end  
  #--------------------------------------------------------------------------
  # ● Gets the coordinates of the target
  #--------------------------------------------------------------------------
  def self.get_targets_position(targets, horming, m_a = nil)
    return [0,0,0] if targets == nil && !$sv_camera.mirror
    return [Graphics.width,0,0] if targets == nil && $sv_camera.mirror
    x = y = h = 0
    for i in 0...targets.size
      x += targets[i].sv.base_x if !horming
      y += targets[i].sv.base_y if !horming
      h += targets[i].sv.base_h if !horming
      x += targets[i].sv.x if horming
      y += targets[i].sv.y if horming
      h += targets[i].sv.h if horming
      y -= targets[i].sv.ch * 100 if m_a == 0
      y -= targets[i].sv.ch * 50 if m_a == 1
    end
    return [x / targets.size, y / targets.size, h / targets.size]
  end
  #--------------------------------------------------------------------------
  # ● Convert Time to Speed (Distance Calculation)
  #--------------------------------------------------------------------------
  def self.distanse_calculation(time, target_position, self_position, distanse_move)
    return time if !distanse_move
    distanse_x = self_position[0] - target_position[0]
    distanse_x = target_position[0] - self_position[0] if target_position[0] > self_position[0]
    distanse_y = self_position[1] - target_position[1]
    distanse_y = target_position[1] - self_position[1] if target_position[1] > self_position[1]
    if self_position[2] != nil && target_position[2] != nil
      distanse_h = self_position[2] - target_position[2]
      distanse_h = target_position[2] - self_position[2] if target_position[2] > self_position[2]
    else
      distanse_h = 0
    end
    distanse = [distanse_x, distanse_y, distanse_h].max
    return distanse / (time * 100) + 1
  end
  #--------------------------------------------------------------------------
  # ● Parabola movement calculation
  #--------------------------------------------------------------------------
  def self.parabola(data, time, size, type = 1)
    move_data = data
    move_data[0] *= size
    move_data[1] *= size
    move = []
    move_d = []
    for i in 0...time / 2
      move[i] = move_data[0]
      move_d[i] = move_data[1]
      move_data[0] = move_data[0] * type / (1 + type)
      move_data[1] = move_data[1] * type / (1 + type)
    end
    move = move + move_d.reverse!
    move.reverse!
    adjust = move.inject(0) {|result, item| result + item }
    move[move.size - 1] += adjust if data[0] == data[1] && adjust != 0
    move.unshift(0) if time % 2 != 0
    return move
  end
  #--------------------------------------------------------------------------
  # ● Reverse/Invert Value
  #--------------------------------------------------------------------------
  def self.mirror_num(mirror)
    return 1 if !mirror
    return -1
  end  
  #--------------------------------------------------------------------------
  # ● Camera Work
  #--------------------------------------------------------------------------
  def self.camera(battler, data)
    battler = $game_party.battle_members[0] if !battler
    cx = data[2][0] * 100
    cy = data[2][1] * 100
    return $sv_camera.move(cx, cy, data[3], data[4], true) if data[1] == 6
    targets = self.get_targets(data[1], battler)
    return if targets == nil or targets == []
    position = self.get_targets_position(targets, true)
    $sv_camera.move(position[0], position[1] - position[2], data[3], data[4], false)
  end
  #--------------------------------------------------------------------------
  # ● Don't Collapse / Collapse Block
  #--------------------------------------------------------------------------
  def self.immortaling
    # Invulnerability granted to all
    for member in $game_party.battle_members + $game_troop.members
      # Set the flag to Disable Cancellation if the invunerability flag is
      # set in an event operation and etc.
      member.sv.immortal = true if member.state?(N03::IMMORTAL_ID)
      member.add_state(N03::IMMORTAL_ID)
    end
    return true
  end  
  #--------------------------------------------------------------------------
  # ● Collapse / Collapse Unblock / Allow Collapse
  #--------------------------------------------------------------------------
  def self.unimmortaling
    # Invulnerability removed to all (unless it was set in an event or etc.)
    for member in $game_party.battle_members + $game_troop.members
      next if member.dead?
      # If the immortal state has been released during an action, remove the
      # Disable Cancellation flag.
      member.sv.immortal = false if !member.state?(N03::IMMORTAL_ID) && member.sv.immortal
      next member.sv.immortal = false if member.sv.immortal
      member.remove_state(N03::IMMORTAL_ID)
      next if member.hp != 0
      member.add_state(1)
      member.perform_collapse_effect
      member.sv.action_terminate
    end
    return false
  end  
  #--------------------------------------------------------------------------
  # ● Derive Skill
  #--------------------------------------------------------------------------
  def self.derived_skill(battler)
    battler.force_action(battler.sv.derivation_skill_id, -2)
    BattleManager.unshift_action_battlers(battler)
  end
  #--------------------------------------------------------------------------
  # ● Create/Set Damage
  #--------------------------------------------------------------------------
  def self.set_damage(battler, hp_damage, mp_damage)
    battler.result.hp_damage = hp_damage
    battler.result.mp_damage = mp_damage
  end
  #--------------------------------------------------------------------------
  # ● Confirm Target Death
  #--------------------------------------------------------------------------
  def self.targets_alive?(targets)
    return false if targets == []
    for target in targets do return true if !target.dead? end
    return false
  end
  #--------------------------------------------------------------------------
  # ● Target Second Target
  #--------------------------------------------------------------------------
  def self.s_targets(battler)
    battler.sv.target_battler = battler.sv.second_targets
    return battler.sv.second_targets
  end  
  #--------------------------------------------------------------------------
  # ● Target the targets of the Second Target
  #--------------------------------------------------------------------------
  def self.targets_set(battler)
    battler.sv.second_targets = battler.current_action.make_targets.compact
    battler.sv.target_battler = battler.sv.second_targets
  end  
  #--------------------------------------------------------------------------
  # ● Combat animation execution detection
  #   (Target: Animation only runs if the screen is the first target)
  #--------------------------------------------------------------------------
  def self.first_of_all_screen_anime(anime_id, target, targets)
    anime = $data_animations[anime_id]
    return false if !anime
    return true if anime.position != 3
    return false if anime.position == 3 && target != targets[0]
    targets.delete(target)
    target.sv.timing_targets = targets
    return true
  end
  #--------------------------------------------------------------------------
  # ● Non-combat additional attack
  #--------------------------------------------------------------------------
  def self.dead_attack?(battler, item)
    for state in battler.atk_states
      return true if state == battler.death_state_id
    end
    for effect in item.effects
      return true if effect.code == 21 && effect.data_id == battler.death_state_id
    end
    return false
  end
end

#==============================================================================
# ■ Sprite_Weapon
#------------------------------------------------------------------------------
# 　Sprite for the weapon display.
#==============================================================================
class Sprite_Weapon < Sprite_Base
  #--------------------------------------------------------------------------
  # ● Public instance variables
  #--------------------------------------------------------------------------
  attr_reader   :index                       # Weapon image array index
  attr_reader   :battler         # The battler whom the image is referring to 
  attr_reader   :move_time       # Time until the image reaches a target 
  attr_reader   :through                     # Through flag
  attr_reader   :action_end                  # Weapon action end flag
  attr_reader   :action_end_cancel           # Weapon action end cancel flag
  attr_reader   :hit_position    # Coordinates when the image reaches a target 
  attr_accessor :hit_anime_id    # Animation ID when the image reaches a target 
  #--------------------------------------------------------------------------
  # ● Object initialization
  #--------------------------------------------------------------------------
  def initialize(viewport, index, battler)
    super(viewport)
    @index = index
    @battler = battler
    @position_x = @position_y = 0
    @o = 0
    @real_x = @real_y = 0
    @mirror = @battler.sv.mirror
    reset
    set_action
  end
  #--------------------------------------------------------------------------
  # ● Initialize/Reset
  #--------------------------------------------------------------------------
  def reset
    @z_plus = 0
    @weapon_data = []
    @move_data = []
    @move_x = 0
    @move_y = 0
    @orbit = []
    @through = false
    @distanse_move = false
    @weapon_width = 0
    @weapon_height = 0
    @anime_time = 0
    @anime_position = 1
    @move_time = 0
    @hit_anime_id = 0
    @move_anime = true
    @action_end = false
    @action_end_cancel = false
    reset_position
  end  
  #--------------------------------------------------------------------------
  # ● Set Action
  #--------------------------------------------------------------------------
  def set_action
    return if @battler.sv.effect_data == []
    weapon_anime if @battler.sv.effect_data[0][0] == "wp"
    move_anime if @battler.sv.effect_data[0][0] == "m_a"
    @battler.sv.effect_data.shift
  end
  #--------------------------------------------------------------------------
  # ● Weapon Animation Set/Execute
  #--------------------------------------------------------------------------
  def weapon_anime
    @weapon_data = @battler.sv.effect_data[0].dup
    set_graphics
    set_ox
    set_weapon_move
  end
  #--------------------------------------------------------------------------
  # ● Animation Move Set/Execute
  #--------------------------------------------------------------------------
  def move_anime
    @move_data = @battler.sv.effect_data[0].dup
    # ターゲットを取得
    @target_battler = [@battler.sv.m_a_targets.shift]
    @target_battler = N03.get_targets(@move_data[3], @battler) if @move_data[3] < 0
    set_move
    return if @move_data[16] == ""
    weapon_data = N03::ACTION[@move_data[16]]
    return if weapon_data == nil
    @weapon_data = weapon_data.dup
    set_graphics
    set_ox
    set_weapon_move
  end
  #--------------------------------------------------------------------------
  # ● Set Weapon Image
  #--------------------------------------------------------------------------  
  def set_graphics
    # If there is an image set, do not depend on weapons
    if @weapon_data[13] != ""
      self.bitmap = Cache.character(@weapon_data[13]).dup
      @weapon_width = self.bitmap.width
      @weapon_height = self.bitmap.height
      return
    end
    # Get weapon
    weapon = @battler.weapons[0]
    # Get other weapon
    if @weapon_data[10]
      weapon = nil
      for armor in @battler.armors do break weapon = armor if armor.is_a?(RPG::Armor) && armor.etype_id == 1 end
      weapon = @battler.weapons[1] if !weapon
    end  
    # Cancel if there is no weapon
    return if weapon == nil
    # Get the index
    file_index = @weapon_data[12]
    # If you use the icons
    if @weapon_data[1] == 0
      icon_index = weapon.icon_index
      self.bitmap = Cache.system("Iconset" + file_index).dup
      self.src_rect.set(icon_index % 16 * 24, icon_index / 16 * 24, 24, 24)
      @weapon_width = @weapon_height = 24
    # If you use your a custom image 
    else
      file_name = @battler.sv.weapon_graphic(weapon.id, weapon.wtype_id) if weapon.is_a?(RPG::Weapon)
      file_name = @battler.sv.shield_graphic(weapon.id, weapon.atype_id) if weapon.is_a?(RPG::Armor)
      self.bitmap = Cache.character(file_name + file_index).dup
      @weapon_width = self.bitmap.width
      @weapon_height = self.bitmap.height
      return if @weapon_data[1] == 1
      # Weapon Animation (2k3 Style)
      @weapon_width /= @battler.sv.max_pattern[0]
    end
  end
  #--------------------------------------------------------------------------
  # ● Set Starting Position of the Picture (Original Coords)
  #--------------------------------------------------------------------------  
  def set_ox
    # When you flip the setting to reverse
    if @mirror
      case @weapon_data[6]
      when 1 ; @weapon_data[6] = 2 # Upper left -> Upper right 
      when 2 ; @weapon_data[6] = 1 # Upper right -> Upper left 
      when 3 ; @weapon_data[6] = 4 # Lower left -> Lower right 
      when 4 ; @weapon_data[6] = 3 # Lower right -> Lower left 
      end
    end
    # Set Origin
    case @weapon_data[6]
    when 0 # Center
      self.ox = @weapon_width / 2
      self.oy = @weapon_height / 2
    when 1 # Upper Left
      self.ox = 0
      self.oy = 0
    when 2 # Upper Right
      self.ox = @weapon_width
      self.oy = 0
    when 3 # Lower Left
      self.ox = 0
      self.oy = @weapon_height
    when 4 # Lower Right
      self.ox = @weapon_width
      self.oy = @weapon_height
    when 5 # Same as Battler
      self.ox = @weapon_width / 2
      self.oy = @weapon_height
    end
  end  
  #--------------------------------------------------------------------------
  # ● Set Battler Coordinates
  #--------------------------------------------------------------------------  
  def set_battler_position
    @position_x = @battler.sv.x + @weapon_data[3][0] * N03.mirror_num(@mirror) * 100
    @position_y = (@battler.sv.y - @battler.sv.h - @battler.sv.j - @battler.sv.c - @battler.sv.oy_adjust) + @weapon_data[3][1] * 100
    reset_position
  end
  #--------------------------------------------------------------------------
  # ● Initialize/Reset Coordinates
  #--------------------------------------------------------------------------  
  def reset_position
    @real_x = @position_x / 100
    @real_y = @position_y / 100
    @real_zoom_x = 1
    @real_zoom_y = 1
  end
  #--------------------------------------------------------------------------
  # ● Combat Animation
  #--------------------------------------------------------------------------  
  def set_animation(anime_id)
    return if $data_animations[anime_id] == nil
    @anime_position = $data_animations[anime_id].position
    @horming = true
    @horming = false if @anime_position == 3
    @anime_camera_zoom = true
    @anime_no_mirror = false
    start_animation($data_animations[anime_id], @mirror)
    timings = $data_animations[anime_id].timings
  end
  #--------------------------------------------------------------------------
  # ● Battle animation execution at the time of the hit 
  #--------------------------------------------------------------------------  
  def set_hit_animation(position_data, hit_anime_id, target)
    return if $data_animations[hit_anime_id] == nil
    @real_x = position_data[0]
    @real_y = position_data[1]
    @position_x = position_data[0] * 100
    @position_y = position_data[1] * 100
    self.z = position_data[2]
    @z_plus = 1000
    @action_end = false
    @horming = true
    set_animation(hit_anime_id)
    @anime_time = $data_animations[hit_anime_id].frame_max * 4
    @timing_targets = [target]
    @move_time = @hit_anime_id = 0
    @weapon_data = []
  end
  #--------------------------------------------------------------------------
  # ● Timing Battler Additional
  #--------------------------------------------------------------------------  
  def timing_battler_set(target)
    @timing_targets.push(target)
  end
  #--------------------------------------------------------------------------
  # ● Set the movement of the weapon
  #--------------------------------------------------------------------------  
  def set_weapon_move
    # Set the start position
    set_battler_position if @move_time == 0
    @z_plus = 50 if @z_plus == 0 && @weapon_data[9]
    self.z = @battler.sv.z + @z_plus
    # Mirror processing
    @mirror = !@mirror if @weapon_data[7]
    self.mirror = @mirror
    # Set refresh patterns
    set_pattern
    @max_pattern = 2 if @max_pattern == 1
    # Calculate movement
    @weapon_move_data = []
    @weapon_angle_data = []
    @weapon_zoom_data = []
    num = N03.mirror_num(@mirror)
    for i in 0...@max_pattern
      move_data_x = @weapon_data[2][0] * num * 100 * i / (@max_pattern - 1)
      move_data_y = @weapon_data[2][1] * 100 * i / (@max_pattern - 1)
      move_angle = @weapon_data[4] * num + (@weapon_data[5] * num - @weapon_data[4] * num) * i / (@max_pattern - 1)
      move_zoom_x = 1 + (@weapon_data[8][0] - 1) * i / (@max_pattern - 1)
      move_zoom_y = 1 + (@weapon_data[8][1] - 1) * i / (@max_pattern - 1)
      @weapon_move_data.push([move_data_x, move_data_y])
      @weapon_angle_data.push(move_angle)
      @weapon_zoom_data.push([move_zoom_x, move_zoom_y])
    end
  end  
  #--------------------------------------------------------------------------
  # ● Update pattern
  #--------------------------------------------------------------------------
  def set_pattern
    if @weapon_data[11] == -1
      return @max_pattern = @battler.sv.max_pattern[0] if @battler.sv.pattern_type != 0
      @count = @battler.sv.pattern_time
      @max_count = @battler.sv.pattern_time
      @max_pattern = @battler.sv.max_pattern[0]
      @repeat = false
    else
      @count = @weapon_data[11][0]
      @max_count = @weapon_data[11][0]
      @max_pattern = @weapon_data[11][1]
      @repeat = @weapon_data[11][2]
    end
    @pattern = 0
  end
  #--------------------------------------------------------------------------
  # ● Set/Execute Movement
  #--------------------------------------------------------------------------
  def set_move
    # Set Combat Animation
    set_animation(@move_data[1][0]) if $data_animations[@move_data[1][0]] != nil && $data_animations[@move_data[1][0]].position != 3
    @anime_camera_zoom = @move_data[13]
    @loop = @move_data[14]
    @loop = false if @move_data[1][0] == 0
    @anime_no_mirror = @move_data[15]
    @se_flag = @move_data[17]
    # Set Start Position
    start_position
    @z_plus = 1000 if @move_data[9]
    # SE of the animation and the timing setup are reflected on the
    # target battler picture. 
    @timing_targets = @target_battler
    # Coordinate Calculation
    @move_x = @move_data[5][0] * 100 * N03.mirror_num(@mirror)
    @move_y = @move_data[5][1] * 100
    # Time calculation or speed calculation 
    @distanse_move = true if @move_data[6] > 0
    @move_time = @move_data[6].abs
    # In the case of the time is equal to 0 and the animation is setup
    # The time will unite at animation display time. 
    if @move_time == 0
      @move_time = $data_animations[@move_data[1][0]].frame_max * 4 if $data_animations[@move_data[1][0]]
      @move_time = 1 if !$data_animations[@move_data[1][0]]
      @distanse_move = false
    end
    # In the case of through type
    @through = true if @move_data[7] == 1
    @auto_through_flag = false
    @auto_through_flag = true if @move_data[7] == 0
    # Target coordinate calculation
    if @target_battler == nil
      @target_x = @move_x * 100
      @target_x = (Graphics.width - @move_x) * 100 if @mirror
      @target_y = @move_y * 100
    else
      move_data_set
    end
    # The calculation of the time to reach the target
    @move_time = distanse_calculation(@move_time, @target_x, @target_y)
    # Circular orbit calculation
    orbit
    # Battler wait set
    @battler.sv.wait = @move_time - 1 if @move_data[10][0]
    @move_horming = @move_data[12]
  end  
  #--------------------------------------------------------------------------
  # ● Convert time to speed (Distance Calculation)
  #--------------------------------------------------------------------------
  def distanse_calculation(time, target_x, target_y)
    return time if !@distanse_move
    distanse_x = @position_x - @target_x
    distanse_x = @target_x - @position_x if @target_x > @position_x
    distanse_y = @position_y - @target_y
    distanse_y = @target_y - @position_y if @target_y > @position_y
    distanse = [distanse_x, distanse_y].max
    return distanse / (time * 100) + 1
  end 
  #--------------------------------------------------------------------------
  # ● Moving target update
  #--------------------------------------------------------------------------
  def move_data_set
    return if @target_battler == nil
    position = N03.get_targets_position(@target_battler, true, @anime_position)
    @target_x = position[0] + @move_x
    @target_y = position[1] - position[2] + @move_y
  end 
  #--------------------------------------------------------------------------
  # ● Calculate start position
  #--------------------------------------------------------------------------
  def start_position
    starter = [@battler.sv.m_a_starter.shift]
    starter = N03.get_targets(@move_data[2], @battler) if @move_data[2] < 0
    position = [0, 0]
    position = N03.get_targets_position(starter, true, @anime_position) if starter != nil
    @position_x = position[0] + @move_data[4][0] * 100
    @position_y = position[1] + position[2] + @move_data[4][1] * 100
    @position_z = @position_y
  end  
  #--------------------------------------------------------------------------
  # ● Circular orbit calculation
  #--------------------------------------------------------------------------
  def orbit
    orbit_data = @move_data[8].dup
    orbit_data[0] *= 100
    orbit_data[1] *= 100
    orbit_d = []
    for i in 0...@move_time / 2
      @orbit[i] = orbit_data[0]
      orbit_data[0] /= 2
      orbit_d[i] = orbit_data[1]
      orbit_data[1] /= 2
    end
    @orbit = @orbit + orbit_d.reverse!
    @orbit.reverse!
  end  
  #--------------------------------------------------------------------------
  # ● Frame update
  #--------------------------------------------------------------------------
  def update
    update_hit_anime if @anime_time != 0
    update_move if @move_time != 0
    update_weapon_move if @weapon_data != []
    update_position
    update_color
    self.visible = @battler.sv.weapon_visible
    super
  end
  #--------------------------------------------------------------------------
  # ● Combat Hit Animation 
  #--------------------------------------------------------------------------
  def update_hit_anime
    @anime_time -= 1
    @action_end = true if @anime_time == 0
  end
  #--------------------------------------------------------------------------
  # ● Movement Update
  #--------------------------------------------------------------------------
  def update_move
    move_data_set if @move_horming && !@hit_position
    through_set(@move_time, @target_x, @target_y) if @move_time == 1 && !@hit_position
    @o += @orbit[@move_time - 1] if @orbit[@move_time - 1] != nil
    @position_x = (@position_x * (@move_time - 1) + @target_x) / @move_time
    @position_y = (@position_y * (@move_time - 1) + @target_y) / @move_time + @o
    reset_position
    set_animation(@move_data[1][0]) if @loop && !animation?
    @move_time -= 1
    return if @move_time != 0
    @action_end = true if !@action_end_cancel
  end
  #--------------------------------------------------------------------------
  # ● Update Weapon Movement
  #--------------------------------------------------------------------------
  def update_weapon_move
    pattern = update_pattern
    set_battler_position if @move_time == 0 && !@action_end_cancel
    @real_x = @position_x / 100 + @weapon_move_data[pattern][0] / 100
    @real_y = @position_y / 100 + @weapon_move_data[pattern][1] / 100
    @real_zoom_x = @weapon_zoom_data[pattern][0]
    @real_zoom_y = @weapon_zoom_data[pattern][1]
    self.angle = @weapon_angle_data[pattern]
    self.src_rect.set(@weapon_width * pattern, 0, @weapon_width, @weapon_height) if @weapon_data[1] == 2
  end
  #--------------------------------------------------------------------------
  # ● Update Pattern
  #--------------------------------------------------------------------------
  def update_pattern
    return @battler.sv.pattern_w if @count == nil
    @count -= 1
    return @pattern if @count != 0
    @count = @max_count
    @pattern += 1
    if !@repeat && @pattern == @max_pattern
      @pattern = @max_pattern - 1
    elsif @pattern == @max_pattern
      @pattern = 0
    end
    return @pattern
  end
  #--------------------------------------------------------------------------
  # ● Update Position
  #--------------------------------------------------------------------------
  def update_position
    self.x = (@real_x - $sv_camera.x) * $sv_camera.convert / 1000
    self.y = (@real_y - $sv_camera.y) * $sv_camera.convert / 1000
    self.x += $sv_camera.sx / 100 unless @battler.sv.h != 0 && @weapon_data != []
    self.y += $sv_camera.sy / 100 unless @battler.sv.h != 0 && @weapon_data != []
    self.z = @battler.sv.z + @z_plus - 10
    self.zoom_x = @real_zoom_x * $sv_camera.zoom
    self.zoom_y = @real_zoom_y * $sv_camera.zoom
    self.opacity = @battler.sv.opacity if @battler.sv.opacity_data[4]
  end
  #--------------------------------------------------------------------------
  # ● Processing of Through
  #--------------------------------------------------------------------------
  def through_set(time, target_x, target_y)
    @hit_anime_id = N03.get_attack_anime_id(@move_data[1][1], @battler)
    @battler.sv.wait = N03.get_anime_time(@hit_anime_id) if @move_data[10][1]
    moving_x = (target_x / 100 - @position_x / 100) / time
    moving_y = (target_y / 100 - @position_y / 100) / time
    goal_x = $sv_camera.max_left - 100 if moving_x < 0
    goal_x = Graphics.width + $sv_camera.max_right + 100 if moving_x > 0
    goal_y = $sv_camera.max_top - 100 if moving_y < 0
    goal_y = Graphics.height + $sv_camera.max_bottom + 100 if moving_y > 0
    if goal_x == nil &&  goal_y == nil
      time = 0 
      reset_position
    else
      time = move_calculation(moving_x, moving_y, goal_x, goal_y)
    end
    target_x = @position_x + moving_x * time * 100
    target_y = @position_y + moving_y * time * 100
    @pre_data = [time, target_x, target_y]
    @battler.sv.m_a_data.push([@move_data[11], @target_battler, @index, @auto_through_flag, []])
    @action_end_cancel = true
    @hit_position = [@real_x, @real_y, self.z]
  end  
  #--------------------------------------------------------------------------
  # ● Arrival time estimation
  #--------------------------------------------------------------------------
  def move_calculation(moving_x, moving_y, goal_x, goal_y)
    move_x = @position_x / 100
    move_y = @position_y / 100
    time = 0
    loop do
      move_x += moving_x
      move_y += moving_y
      time += 1
      return time if moving_x < 0 && move_x < goal_x
      return time if moving_x > 0 && move_x > goal_x
      return time if moving_y < 0 && move_y < goal_y
      return time if moving_y > 0 && move_y > goal_y
    end
  end   
  #--------------------------------------------------------------------------
  # ● Convert through process from disappearing when you miss
  #--------------------------------------------------------------------------
  def through_change
    @action_end_cancel = false
    @through = true
    @move_time = @pre_data[0]
    @target_x = @pre_data[1]
    @target_y = @pre_data[2]
    @pre_data = nil
  end  
  #--------------------------------------------------------------------------
  # ● SE and Flash timing
  #--------------------------------------------------------------------------
  def animation_process_timing(timing)
    return if !@timing_targets
    se_flag = true
    se_flag = @se_flag if @se_flag != nil
    for target in @timing_targets
      target.sv.timing.push([se_flag, timing.dup])
      se_flag = false if @animation.position == 3
    end  
  end
  #--------------------------------------------------------------------------
  # ● Update Color
  #--------------------------------------------------------------------------
  def update_color
    return if @battler.sv.color == []
    self.color.set(@battler.sv.color[0], @battler.sv.color[1], @battler.sv.color[2], @battler.sv.color[3])
  end
  #--------------------------------------------------------------------------
  # ● Dispose / Release
  #--------------------------------------------------------------------------
  def dispose
    super
    self.bitmap.dispose if self.bitmap != nil
  end
end 

#==============================================================================
# ■ Sprite_Battle_Picture
#------------------------------------------------------------------------------
# The sprite for a picture display. 
#==============================================================================
class Sprite_Battle_Picture < Sprite
  #--------------------------------------------------------------------------
  # ● Public instance variables
  #--------------------------------------------------------------------------
  attr_accessor   :action_end           # End Flag
  #--------------------------------------------------------------------------
  # ● Object initialization
  #--------------------------------------------------------------------------
  def initialize(viewport = nil)
    super(viewport)
    @action_end = false
    self.ox = 0
  end
  #--------------------------------------------------------------------------
  # ● Set
  #--------------------------------------------------------------------------
  def set(battler)
    @battler = battler
    @data = @battler.sv.effect_data.shift
    @time = @data[4]
    @mirror = $sv_camera.mirror
    @mirror = false if !@data[8]
    self.opacity = @data[6][0]
    @s_x = @data[2][0] if @data[2] != []
    @s_x = Graphics.width - @data[2][0]  if @data[2] != [] && @mirror
    @s_y = @data[2][1] if @data[2] != []
    @e_x = @data[3][0] if @data[3] != []
    @e_x = Graphics.width - @data[3][0] if @data[3] != [] && @mirror
    @e_y = @data[3][1] if @data[3] != []
    @s_x = self.x if @data[2] == []
    @s_y = self.y if @data[2] == []
    @e_x = self.x if @data[3] == []
    @e_y = self.y if @data[3] == []
    self.x = @s_x
    self.y = @s_y
    return @action_end = true if @time == 0
    @move_x = (@e_x * 1.0 - @s_x) / @time
    @move_y = (@e_y * 1.0 - @s_y) / @time
    self.z = @data[5]
    return set_plane(battler) if @data[7] != []
    self.bitmap = Cache.picture(@data[9]) if !bitmap or @data[9] != ""
    return @action_end = true if !bitmap
    self.mirror = @mirror
    self.ox = self.bitmap.width if @mirror
  end
  #--------------------------------------------------------------------------
  # ● Set / Transition Plane
  #--------------------------------------------------------------------------
  def set_plane(battler)
    @viewport = Viewport.new(@data[2][0],@data[2][1],@data[7][0],@data[7][1]) if !@viewport
    viewport = @viewport
    @plane = Plane.new(viewport) if !@plane
    @plane.bitmap = Cache.picture(@data[9]) if !@plane.bitmap or @data[9] != ""
    return @action_end = true if !@plane.bitmap
    @plane.ox = @data[7][0]
    @plane.oy = @data[7][1]
    @plane.opacity = @data[6][0]
    @move_x = @remain_move[0] if @data[2] == @data[3]
    @move_y = @remain_move[1] if @data[2] == @data[3]
    @remain_move = [@move_x, @move_y]
  end
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------
  def update
    @action_end = true if !@battler.sv.picture
    return if @time == 0
    return if @action_end
    @time -= 1
    return plane_update if @plane
    super
    self.x += @move_x
    self.y += @move_y
    self.opacity += @data[6][1]
    return if @time != 1
    self.x = @e_x
    self.y = @e_y
    @time = 0
  end
  #--------------------------------------------------------------------------
  # ● Plane update
  #--------------------------------------------------------------------------
  def plane_update
    @plane.ox += @move_x
    @plane.oy += @move_y
    @plane.opacity += @data[6][1]
    @time = @data[4] if @time == 0
  end
  #--------------------------------------------------------------------------
  # ● Dispose / Release
  #--------------------------------------------------------------------------
  def dispose
    bitmap.dispose if bitmap
    @plane.dispose if @plane
    @viewport.dispose if @viewport
    super
  end
end

#==============================================================================
# ■ Sprite_Back_Picture
#------------------------------------------------------------------------------
# The sprite for periodic/background pictures. 
#==============================================================================
class Sprite_Back_Picture < Plane
  #--------------------------------------------------------------------------
  # ● Public instance variable
  #--------------------------------------------------------------------------
  attr_accessor   :action_end           # End Flag
  #--------------------------------------------------------------------------
  # ● Object initialization
  #--------------------------------------------------------------------------
  def initialize(viewport = nil, index)
    super(viewport)
    @index = index
    @real_x = 0
    @real_y = 0
    @real_opacity = 0
    @move_x = 0
    @move_y = 0
    @move_opacity = 0
    @time = 0
    @switche = 0
    @action_end = false
  end
  #--------------------------------------------------------------------------
  # ● Setup
  #--------------------------------------------------------------------------
  def setup(data)
    self.bitmap = Cache.picture(data[9])
    self.z = data[6]
    @switche = data[1]
    mirror = $sv_camera.mirror
    mirror = false if !data[8]
    @move_x = data[3][0]
    @move_x *= -1 if mirror
    @move_y = data[3][1]
    @time = data[4]
    @time = -1 if @time == 0
    @real_opacity = (data[5][0] + 1) * 100
    @move_opacity = data[5][1]
    @start_opacity = data[5][0]
    @shake_ok = data[7]
  end
  #--------------------------------------------------------------------------
  # ● Update
  #--------------------------------------------------------------------------
  def update
    update_picture if @time != 0
    self.ox = $sv_camera.x - @real_x
    self.oy = $sv_camera.y - @real_y
    if @shake_ok
      self.ox -= $sv_camera.sx / 100
      self.oy -= $sv_camera.sy / 100
    end
    self.ox *= $sv_camera.zoom
    self.oy *= $sv_camera.zoom
    self.zoom_x = @zoom_x * $sv_camera.zoom
    self.zoom_y = @zoom_y * $sv_camera.zoom
    self.opacity = @real_opacity / 100
    @move_opacity *= -1 if self.opacity == 255 or self.opacity <= @start_opacity
    @switche
    @action_end = true if @switche > 0 && !$game_switches[@switche]
    @action_end = true if @switche < 0 && !$sv_camera.switches[@switche.abs]
  end
  #--------------------------------------------------------------------------
  # ● Update picture
  #--------------------------------------------------------------------------
  def update_picture
    @real_x += @move_x / 100
    @real_y += @move_y / 100
    @real_x = 0 if @real_x >= self.bitmap.width or @real_x <= -self.bitmap.width
    @real_y = 0 if @real_y >= self.bitmap.height or @real_y <= -self.bitmap.height
    @zoom_x = 1
    @zoom_y = 1
    @real_opacity += @move_opacity
    @time -= 1
    @time = -1 if @time < -100
  end
end

#==============================================================================
# ■ Sprite_Damage
#------------------------------------------------------------------------------
# The sprite of the damage display. 
#==============================================================================
class Sprite_Damage < Sprite
  #--------------------------------------------------------------------------
  # ● Public instance variables
  #--------------------------------------------------------------------------
  attr_reader   :action_end                  # Exit POP flag
  #--------------------------------------------------------------------------
  # ● Object initialization
  #--------------------------------------------------------------------------
  def initialize(viewport = nil, battler)
    super(viewport)
    @battler = battler
    @time = 0
    return @action_end = true if !@battler
    @direction = -1
    @direction *= -1 if @battler.actor?
    @direction *= -1 if $sv_camera.mirror
    set_state
    set_damage
    update
  end 
  #--------------------------------------------------------------------------
  # ● Set state
  #--------------------------------------------------------------------------
  def set_state
    return if !N03::STATE_POP
    states = @battler.result.added_state_objects
    states.delete($data_states[@battler.death_state_id]) if @battler.result.hp_damage != 0
    return if states == []
    return if @battler.sv.add_state == @battler.result.added_state_objects
    @battler.sv.add_state = states.dup
    @st = []
    @st_base = []
    for i in 0...states.size
      @st[i] = Sprite.new
      bitmap_state(@st[i], states[i])
      @st_base[i] = []
      @st_base[i][0] = @direction * (-20 + 5 * i) + @battler.sv.x / 100
      @st_base[i][1] = -40 - @state_height * i + (@battler.sv.y - @battler.sv.h - @battler.sv.j - @battler.sv.oy_adjust)/ 100
      @st[i].z = 1000 + i
      @st[i].opacity = 0
    end
    @time = @pop_time = 80
  end   
  #--------------------------------------------------------------------------
  # ● State bitmap/image
  #--------------------------------------------------------------------------
  def bitmap_state(state, state_object)
    name = state_object.name
    state.bitmap = Cache.system("Iconset").dup
    state.src_rect.set(state_object.icon_index % 16 * 24, state_object.icon_index / 16 * 24, 24, 24)
    @state_height = 24
  end
  #--------------------------------------------------------------------------
  # ● Damage Count
  #--------------------------------------------------------------------------
  def hit_count
    for i in 0...@battler.sv.hit.size
      if @battler.sv.hit[i] == nil
        @hit = i
        return @battler.sv.hit[i] = @hit
      end
    end
    @hit = @battler.sv.hit.size
    @battler.sv.hit.push(@hit)
  end  
  #--------------------------------------------------------------------------
  # ● Damage Display
  #--------------------------------------------------------------------------
  def set_damage
    return @action_end = true if !N03::DAMAGE_POP
    damage = @battler.result.hp_damage if @battler.result.hp_damage != 0
    damage = @battler.result.hp_drain  if @battler.result.hp_drain  != 0
    damage = @battler.result.mp_damage if @battler.result.mp_damage != 0
    damage = @battler.result.mp_drain  if @battler.result.mp_drain  != 0
    damage = @battler.result.tp_damage if @battler.result.tp_damage != 0
    if !damage or damage == 0
      @action_end = true if @st == nil
      return # @action_end does not return, considering only State POP settings
    end
    hit_count
    #@hit = @battler.sv.hit
    #@battler.sv.hit += 1 if damage != 0
    file = N03::DAMAGE_PLUS if damage > 0
    file = N03::DAMAGE_MINUS if damage < 0
    add_file = N03::DAMAGE_MP if @battler.result.mp_damage != 0
    add_file = N03::DAMAGE_TP if @battler.result.tp_damage != 0
    adjust_x = N03::DAMAGE_ADJUST
    @num = []
    @num_base = []
    damage = damage.abs
    max_num = damage.to_s.size
    max_num += 1 if add_file != nil
    for i in 0...max_num
      @num[i] = Sprite.new
      if add_file != nil && i == max_num - 1
        @num[i].bitmap = Cache.system(add_file)
        cw = (damage % (10 * 10 ** i))/(10 ** i)
        sw = 0 if sw == nil
      else
        @num[i].bitmap = Cache.system(file)
        cw = (damage % (10 * 10 ** i))/(10 ** i)
        sw = @num[i].bitmap.width / 10
        @num[i].src_rect.set(cw * sw, 0, sw, @num[i].bitmap.height)
      end
      @num_base[i] = []
      @num_base[i][0] = (sw + adjust_x) * i * -1 + (@battler.sv.x / 100)
      @num_base[i][1] =  -(@num[i].bitmap.height / 3) - i * 2 - @hit * 2 + (@battler.sv.y - @battler.sv.h - @battler.sv.j - @battler.sv.oy_adjust)/ 100
      @num_base[i][0] -= @num[i].bitmap.width / 2 - adjust_x if add_file != nil && i == max_num - 1
      @num[i].z = 1000 + i + @hit * 10
    end
    @time = @pop_time = 80
  end
  #--------------------------------------------------------------------------
  # ● Frame update
  #--------------------------------------------------------------------------
  def update
    return if @time == 0
    for i in 0...@st.size do update_state_move(@st[i], i) end if @st != nil
    for i in 0...@num.size do update_num_move(@num[i], i) end if @num != nil
    @time -= 1
    @action_end = true if @time == 0
  end
  #--------------------------------------------------------------------------
  # ● State image update
  #--------------------------------------------------------------------------
  def update_state_move(state, index)
    min = @pop_time - index * 2
    case @time
    when min-15..min
      @st_base[index][0] += @direction
      state.opacity += 25
    when min-80..min-50
      @st_base[index][0] += @direction
      state.opacity -= 25
    end
    state.x = (@st_base[index][0] - $sv_camera.x) * $sv_camera.zoom
    state.y = (@st_base[index][1] - $sv_camera.y) * $sv_camera.zoom
  end
  #--------------------------------------------------------------------------
  # ● Update number
  #--------------------------------------------------------------------------
  def update_num_move(num, index)
    min = @pop_time - index * 2
    case @time
    when min-1..min
      @num_base[index][0] += @direction * @hit
      @num_base[index][1] -= 5 + @hit * 2
    when min-3..min-2
      @num_base[index][0] += @direction * @hit
      @num_base[index][1] -= 4 + @hit * 2
    when min-6..min-4
      @num_base[index][0] += @direction
      @num_base[index][1] -= 3 + @hit * 2
    when min-14..min-7
      @num_base[index][0] += @direction
      @num_base[index][1] += 2
    when min-17..min-15
      @num_base[index][1] -= 2 + @hit * 2
    when min-23..min-18
      @num_base[index][1] += 1
    when min-27..min-24
      @num_base[index][1] -= 1
    when min-30..min-28
      @num_base[index][1] += 1
    when min-33..min-31
      @num_base[index][1] -= 1
    when min-36..min-34
      @num_base[index][1] += 1
    end
    num.x = (@num_base[index][0] - $sv_camera.x) * $sv_camera.zoom
    num.y = (@num_base[index][1] - $sv_camera.y) * $sv_camera.zoom
    num.opacity = 256 - (12 - @time) * 32
    num.visible = false if @time == 0
  end
  #--------------------------------------------------------------------------
  # ● Dispose / Release
  #--------------------------------------------------------------------------
  def dispose
    @battler.sv.hit[@hit] = nil if @hit
    bitmap.dispose if bitmap
    for i in 0...@num.size do @num[i].dispose end if @num != nil
    for i in 0...@st.size do @st[i].dispose end if @st != nil
    super
  end
end

#==============================================================================
# ■ Window_Skill_name
#------------------------------------------------------------------------------
# 　スキル名を表示するウィンドウです。
#==============================================================================
class Window_Skill_name < Window_Base
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(text)
    super(0, 0, Graphics.width, line_height + standard_padding * 2)
    draw_text(4, 0, Graphics.width - 64, line_height,text, 1)
  end
end

#==============================================================================
# ■ Spriteset_Sideview
#------------------------------------------------------------------------------
# 　サイドビュー独自のスプライトをまとめたクラスです。
#==============================================================================
class Spriteset_Sideview
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(viewport)
    @viewport = viewport
    @weapons = []
    @pictures = []
    @back_pic = []
    @damage = []
    $sv_camera.setup
    N03.camera(nil, N03::BATTLE_CAMERA["Before Turn Start"].dup)
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    update_battler_data
    update_damage
    update_pictures
    update_back_pic
    update_weapons
  end  
  #--------------------------------------------------------------------------
  # ● バトラーデータの更新
  #--------------------------------------------------------------------------
  def update_battler_data
    for battler in $game_party.battle_members + $game_troop.members
      weapon_end(battler) if battler.sv.weapon_end
      next if battler.sv.effect_data == []
      for effect_data in battler.sv.effect_data do set_effects(battler, effect_data) end
    end
  end
  #--------------------------------------------------------------------------
  # ● ダメージ画像の更新
  #--------------------------------------------------------------------------
  def update_damage
    for i in 0...@damage.size
      next if @damage[i] == nil
      @damage[i].update if @damage[i] != nil
      next if !@damage[i].action_end
      @damage[i].dispose
      @damage[i] = nil
    end
  end
  #--------------------------------------------------------------------------
  # ● ピクチャアクションの更新
  #--------------------------------------------------------------------------
  def update_pictures
    for i in 0...@pictures.size
      next if @pictures[i] == nil
      @pictures[i].update if @pictures[i] != nil
      next if !@pictures[i].action_end
      @pictures[i].dispose
      @pictures[i] = nil
    end
  end
  #--------------------------------------------------------------------------
  # ● 周期ピクチャの更新
  #--------------------------------------------------------------------------
  def update_back_pic
    set_back_pic if $sv_camera.program_picture != []
    for i in 0...@back_pic.size
      next if @back_pic[i] == nil
      @back_pic[i].update if @back_pic[i] != nil
      next if !@back_pic[i].action_end
      @back_pic[i].dispose
      @back_pic[i] = nil
    end
  end
  #--------------------------------------------------------------------------
  # ● 武器アクションの更新
  #--------------------------------------------------------------------------
  def update_weapons
    for i in 0...@weapons.size
      next if @weapons[i] == nil
      @weapons[i].update if @weapons[i] != nil
      next if !@weapons[i].action_end
      @weapons[i].dispose
      @weapons[i] = nil
    end
  end
  #--------------------------------------------------------------------------
  # ● ダメージ実行
  #--------------------------------------------------------------------------
  def set_damage_pop(target)
    for i in 0...@damage.size
      next if @damage[i] != nil
      return @damage[i] = Sprite_Damage.new(@viewport, target)
    end
    @damage.push(Sprite_Damage.new(@viewport, target))
  end
  #--------------------------------------------------------------------------
  # ● 周期ピクチャ実行
  #--------------------------------------------------------------------------
  def set_back_pic
    for data in $sv_camera.program_picture
      if @back_pic[data[2]] != nil
        @back_pic[data[2]].dispose
        @back_pic[data[2]] = nil
      end
      @back_pic[data[2]] = Sprite_Back_Picture.new(@viewport, data[2])
      @back_pic[data[2]].setup(data)
    end
    $sv_camera.program_picture = []
  end
  #--------------------------------------------------------------------------
  # ● エフェクト開始
  #--------------------------------------------------------------------------
  def set_effects(battler, effect_data)
    case effect_data[0]
    when "pic" ; set_pictures(battler, effect_data)
    when  "wp" ; set_weapons(battler,  true)
    when "m_a" ; set_weapons(battler, false)
    end
  end
  #--------------------------------------------------------------------------
  # ● ピクチャアクション実行
  #--------------------------------------------------------------------------
  def set_pictures(battler, effect_data)
    @pictures[effect_data[1]] = Sprite_Battle_Picture.new if @pictures[effect_data[1]] == nil
    @pictures[effect_data[1]].set(battler)
  end
  #--------------------------------------------------------------------------
  # ● 武器アクション実行
  #--------------------------------------------------------------------------
  def set_weapons(battler, weapon_flag, test = true)
    for i in 0...@weapons.size
      next if @weapons[i] != nil
      @weapons[i] = Sprite_Weapon.new(@viewport, i, battler) 
      battler.sv.weapon_index.push(i) if weapon_flag
      return i
    end
    @weapons.push(Sprite_Weapon.new(@viewport, @weapons.size, battler))
    battler.sv.weapon_index.push(@weapons.size - 1) if weapon_flag
    return @weapons.size - 1
  end
  #--------------------------------------------------------------------------
  # ● バトラーの武器アクション終了
  #--------------------------------------------------------------------------
  def weapon_end(battler)
    battler.sv.weapon_end = false
    for index in battler.sv.weapon_index
      weapon_index = battler.sv.weapon_index.shift
      @weapons[weapon_index].dispose if @weapons[weapon_index] != nil
      @weapons[weapon_index] = nil
    end
    battler.sv.weapon_index.compact!
  end  
  #--------------------------------------------------------------------------
  # ● ヒット時の戦闘アニメ実行
  #--------------------------------------------------------------------------
  def set_hit_animation(battler, weapon_index, hit_targets, miss)
    weapon = @weapons[weapon_index]
    for target in hit_targets
      next @weapons[@hit_index].timing_battler_set(target) if @hit_index != nil
      @hit_index = set_weapons(battler, false, false)
      @weapons[@hit_index].set_hit_animation(weapon.hit_position, weapon.hit_anime_id, target)
    end
    @hit_index = nil
    if !weapon.through && !miss
      @weapons[weapon_index].dispose
      @weapons[weapon_index] = nil
    else
      @weapons[weapon_index].through_change
    end
  end
  #--------------------------------------------------------------------------
  # ● サイドビューデータの初期化
  #--------------------------------------------------------------------------
  def reset_sideview
    $sv_camera.reset
    for member in $game_troop.members + $game_party.battle_members do member.sv.reset end
  end  
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    dispose_effects(@weapons)
    dispose_effects(@pictures)
    dispose_effects(@back_pic)
    dispose_effects(@damage)
    reset_sideview
  end
  #--------------------------------------------------------------------------
  # ● エフェクト画像の解放
  #--------------------------------------------------------------------------
  def dispose_effects(effects)
    for i in 0...effects.size
      effects[i].dispose if effects[i] != nil
      effects[i] = nil
    end
  end
end


#==============================================================================
# ■ Sprite_Battle_Back
#------------------------------------------------------------------------------
# 　戦闘背景用のスプライトです。
#==============================================================================
class Sprite_Battle_Back < Plane
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  def initialize(viewport = nil, index, battleback_name)
    super(viewport)
    @index = index
    if @index == 1
      data = N03::FLOOR1_DATA[battleback_name]
      data = N03::FLOOR1_DATA["Battlebacks1"] if data == nil
    elsif @index == 2
      data = N03::FLOOR2_DATA[battleback_name]
      data = N03::FLOOR2_DATA["Battlebacks2"] if data == nil
    end    
    data = data.dup
    @adjust_position = data[0]
    @zoom_x = data[1][0] / 100.0
    @zoom_y = data[1][1] / 100.0
    @shake_on = data[2]
    $game_switches[data[3]] = true if data[3] > 0
    $sv_camera.switches[data[3].abs] = true if data[3] < 0
    reset_scroll
    reset_back_data(battleback_name)
  end
  #--------------------------------------------------------------------------
  # ● 背景スクロールを初期化
  #--------------------------------------------------------------------------
  def reset_scroll
    @scroll_x = 0
    @scroll_y = 0
    @move_x = 0
    @move_y = 0
  end
  #--------------------------------------------------------------------------
  # ● 背景データを初期化
  #--------------------------------------------------------------------------
  def reset_back_data(battleback_name)
    @back_data = []
    @active_data = ["scroll",0, @move_x, @move_y, false, battleback_name,""]
    start_back_data(@active_data)
  end  
  #--------------------------------------------------------------------------
  # ● 背景画像のセッティング
  #--------------------------------------------------------------------------
  def set_graphics(new_bitmap)
    self.bitmap = new_bitmap
    @base_x = (self.bitmap.width * @zoom_x - Graphics.width) / 2 + @adjust_position[0]
    @base_y = (self.bitmap.height * @zoom_y - Graphics.height) / 2 + @adjust_position[1]
    # 限界座標を取得
    max_top =  0
    max_bottom = self.bitmap.height * @zoom_y - Graphics.height
    max_left = 0
    max_right = self.bitmap.width * @zoom_x - Graphics.width
    exist = true 
    exist = false if self.bitmap.height == 32 && self.bitmap.width == 32
    $sv_camera.setting(@index, [max_top, max_bottom, max_left, max_right, @base_x, @base_y,exist])
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    return if !bitmap
    update_back_data
    update_scroll unless @move_x == 0 && @move_y == 0
    update_color
    update_position
    update_back_adjust if @bt_back != nil
    create_back_adjust if @bt_back == nil && !@active_data[10] && @scroll_x == 0 && @scroll_y == 0
  end
  #--------------------------------------------------------------------------
  # ● 背景データを更新
  #--------------------------------------------------------------------------
  def update_back_data
    delete = true if @active_data[1] > 0 && !$game_switches[@active_data[1]]
    delete = true if @active_data[1] < 0 && !$sv_camera.switches[@active_data[1].abs]
    return if !delete
    for i in 0...@back_data.size
      @back_data[i] = nil if @back_data[i][1] > 0 && !$game_switches[@back_data[i][1]]
      @back_data[i] = nil if @back_data[i][1] < 0 && !$sv_camera.switches[@back_data[i][1].abs]
    end
    @back_data.compact!
    next_back_data
  end
  #--------------------------------------------------------------------------
  # ● 次の背景データをセット
  #--------------------------------------------------------------------------
  def next_back_data
    @back_data.delete(@active_data[11]) if @active_data[11] != nil
    @back_data.push(@active_data[11]) if @active_data[11] != nil
    @active_data = nil
    data = @back_data.pop
    @back_data = [@active_data] if @back_data.size == 0
    start_back_data(data)
  end  
  #--------------------------------------------------------------------------
  # ● 背景データを実行
  #--------------------------------------------------------------------------
  def start_back_data(data)
    return if back_data_remain(data)
    bt_back_dispose
    pre_active_data = @active_data
    @active_data[8] = [@back_name, @move_x, @move_y, @scroll_x, @scroll_y] if @active_data != nil
    @back_data.push(@active_data)     if @active_data != nil
    @active_data = data.dup
    @active_data[5] = @back_name      if @active_data[5] == ""
    @active_data[9] = set_back_adjust if @active_data[9] == nil
    back_data_scroll_on               if @active_data[8] == nil && @active_data[9][0] == false
    set_remain_back_data              if @active_data[8] != nil
    create_back(@active_data[5])      if @active_data[9][0] == false
    create_back_adjust                if @active_data[10]
    @active_data[11] = pre_active_data if pre_active_data && @active_data[7] == false
  end  
  #--------------------------------------------------------------------------
  # ● 背景データの保留
  #--------------------------------------------------------------------------
  def back_data_remain(data)
    remain = false
    remain = true if data[6] != "" && @active_data != nil && @active_data[9] != nil && @active_data[9][0] != false
    remain = true if @active_data != nil && @active_data[7] == false
    return remain if !remain
    @remain = true
    @back_data.push(data)
    return remain
  end  
  #--------------------------------------------------------------------------
  # ● 背景変更補正データをセット
  #--------------------------------------------------------------------------
  def set_back_adjust
    bt_adjust = []
    sign = -1
    if @active_data[6] == ""
      reset_scroll if @active_data[3][0] == 0 &&  @active_data[3][1] == 0
      bt_adjust = [false,false,0,0]
      return bt_adjust
    elsif @move_x != 0 or @active_data[3][0] != 0
      sign = 1 if @move_x < 0
      bt_adjust[0] = [self.bitmap.width * @zoom_x * sign, 0]
      bt_adjust[1] = [self.bitmap.width * @zoom_x * sign * 2, 0]
    elsif @move_y != 0 or @active_data[3][1] != 0
      sign = 1 if @move_y < 0
      bt_adjust[0] = [0, self.bitmap.height * @zoom_y * sign]
      bt_adjust[1] = [0, self.bitmap.height * @zoom_y * sign * 2]
    else
      reset_scroll if @active_data[3][0] == 0 &&  @active_data[3][1] == 0
      bt_adjust = [false,false,0,0]
      return bt_adjust
    end
    bt_adjust[2] = [bt_adjust[0][0], bt_adjust[0][1]]
    return bt_adjust
  end
  #--------------------------------------------------------------------------
  # ● 背景スクロールデータを実行
  #--------------------------------------------------------------------------
  def back_data_scroll_on
    mirror = $sv_camera.mirror
    mirror = false if !@active_data[4]
    @move_x = @active_data[3][0]
    @move_x *= -1 if mirror
    @move_y = @active_data[3][1]
  end
  #--------------------------------------------------------------------------
  # ● 保持している背景データを実行
  #--------------------------------------------------------------------------
  def set_remain_back_data
    return back_data_scroll_on if @move_x != 0 or @move_y != 0
    create_back(@active_data[8][0])
    @move_x    = @active_data[8][1]
    @move_y    = @active_data[8][2]
    @scroll_x  = @active_data[8][3]
    @scroll_y  = @active_data[8][4]
  end  
  #--------------------------------------------------------------------------
  # ● 背景画像の作成
  #--------------------------------------------------------------------------
  def create_back(back_name)
    return if back_name == @back_name or back_name == ""
    self.bitmap = Cache.battleback1(back_name) if @index == 1
    self.bitmap = Cache.battleback2(back_name) if @index == 2
    @back_name = back_name
  end  
  #--------------------------------------------------------------------------
  # ● 背景変更補正画像の作成
  #--------------------------------------------------------------------------
  def create_back_adjust
    return if @active_data[9][0] == false
    @active_data[10] = true
    mirror = $sv_camera.mirror
    mirror = false if !@active_data[4]
    @bt_back = []
    @bt_back[0] = Sprite.new(viewport)
    @bt_back[0].bitmap = Cache.battleback1(@active_data[6]) if @index == 1
    @bt_back[0].bitmap = Cache.battleback2(@active_data[6]) if @index == 2
    @bt_back[0].mirror = mirror
    @bt_back[1] = Sprite.new(viewport)
    @bt_back[1].bitmap = Cache.battleback1(@active_data[5]) if @index == 1
    @bt_back[1].bitmap = Cache.battleback2(@active_data[5]) if @index == 2
    @bt_back[1].mirror = mirror
  end
  #--------------------------------------------------------------------------
  # ● 背景スクロールの更新
  #--------------------------------------------------------------------------
  def update_scroll
    @scroll_x += @move_x
    @scroll_y += @move_y
    @scroll_x = 0 if @scroll_x / 100 >= self.bitmap.width * @zoom_x or @scroll_x / 100 <= -self.bitmap.width * @zoom_x
    @scroll_y = 0 if @scroll_y / 100 >= self.bitmap.height * @zoom_y or @scroll_y / 100 <= -self.bitmap.height * @zoom_y
  end
  #--------------------------------------------------------------------------
  # ● 色調変更の更新
  #--------------------------------------------------------------------------
  def update_color
    color_set if $sv_camera.color_set[@index] != nil
    return if @color_data == nil
    @color_data[4] -= 1
    if @color_data[4] == 0 && @color_data[5] != 0
      @color_data[4] = @color_data[5]
      @color_data[5] = 0
      @color_data[6] = [0,0,0,0]
    elsif @color_data[4] == 0
      @remain_color_data = @color_data
      return @color_data = nil
    end  
    for i in 0..3
      @color_data[i] = (@color_data[i] * (@color_data[4] - 1) + @color_data[6][i]) / @color_data[4]
    end  
    self.color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3])
  end
  #--------------------------------------------------------------------------
  # ● 座標の更新
  #--------------------------------------------------------------------------
  def update_position
    self.ox = $sv_camera.x + @base_x - @scroll_x / 100
    self.oy = $sv_camera.y + @base_y - @scroll_y / 100
    self.ox -= $sv_camera.sx / 100 if @shake_on
    self.oy -= $sv_camera.sy / 100 if @shake_on
    self.zoom_x = @zoom_x * $sv_camera.zoom
    self.zoom_y = @zoom_y * $sv_camera.zoom
    self.ox *= $sv_camera.zoom
    self.oy *= $sv_camera.zoom
    self.z = @index * 10
  end
  #--------------------------------------------------------------------------
  # ● 背景変更補正画像を更新
  #--------------------------------------------------------------------------
  def update_back_adjust
    @active_data[9][0][0] = 0 if @scroll_x == 0
    @active_data[9][0][1] = 0 if @scroll_y == 0
    @active_data[9][1][0] -= @active_data[9][2][0] if @scroll_x == 0
    @active_data[9][1][1] -= @active_data[9][2][1] if @scroll_y == 0
    for i in 0...@bt_back.size
      @bt_back[i].x = -self.ox + @active_data[9][i][0] * $sv_camera.zoom
      @bt_back[i].y = -self.oy + @active_data[9][i][1] * $sv_camera.zoom
      @bt_back[i].zoom_x = self.zoom_x
      @bt_back[i].zoom_y = self.zoom_y
      @bt_back[i].z = self.z + 1
      @bt_back[i].color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3]) if @color_data != nil
    end
    back_data_scroll_on if @active_data[9][0][0] == 0 && @active_data[9][0][1] == 0
    return unless @active_data[9][1][0] == 0 && @active_data[9][1][1] == 0
    bt_back_dispose
    create_back(@active_data[5])
    @active_data[9][0] = false
    next_back_data if @remain && @back_data.size != 1
    @remain = false
  end
  #--------------------------------------------------------------------------
  # ● 色調変更
  #--------------------------------------------------------------------------
  def color_set
    set = $sv_camera.color_set[@index]
    $sv_camera.color_set[@index] = nil
    set[4] = 1 if set[4] == 0
    @remain_color_data = [0,0,0,0] if @remain_color_data == nil
    @color_data = @remain_color_data
    @color_data[4] = set[4]
    @color_data[5] = set[5]
    @color_data[6] = set
  end
  #--------------------------------------------------------------------------
  # ● 背景変更補正画像の解放
  #--------------------------------------------------------------------------
  def bt_back_dispose
    for i in 0...@bt_back.size do @bt_back[i].dispose end if @bt_back != nil
    @bt_back = nil
  end  
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  def dispose
    bitmap.dispose if bitmap
    bt_back_dispose
    super
  end
end  
  
#==============================================================================
# ■ Battle_Camera
#------------------------------------------------------------------------------
# 　戦闘カメラやバトルプログラムを扱うクラスです。 
#==============================================================================
class Battle_Camera
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数　
  #--------------------------------------------------------------------------
  attr_reader   :sx                 # シェイクX座標
  attr_reader   :sy                 # シェイクY座標
  attr_reader   :max_top            # 上限界座標
  attr_reader   :max_bottom         # 下限界座標
  attr_reader   :max_left           # 左限界座標
  attr_reader   :max_right          # 右限界座標
  attr_accessor :switches           # サイドビュー専用スイッチ
  attr_accessor :color_set          # 色調変更データ
  attr_accessor :wait               # 戦闘シーンの強制ウエイト
  attr_accessor :win_wait           # 戦闘勝利前のウエイト
  attr_accessor :mirror             # 画面反転フラグ
  attr_accessor :program_scroll     # バトルプログラム 背景の自動スクロール
  attr_accessor :program_picture    # バトルプログラム 周期ピクチャ
  attr_accessor :event              # コモンイベント呼び出し
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化 
  #--------------------------------------------------------------------------
  def initialize
    @switches = []
    @max_data = []
    @color_set = []
    @wait = 0
    @win_wait = false
    @mirror = false
    @event = false
    setup
  end
  #--------------------------------------------------------------------------
  # ● カメラX座標
  #--------------------------------------------------------------------------
  def x
    return @x / 100
  end
  #--------------------------------------------------------------------------
  # ● カメラY座標
  #--------------------------------------------------------------------------
  def y
    return @y / 100
  end
  #--------------------------------------------------------------------------
  # ● ズーム率 
  #--------------------------------------------------------------------------
  def zoom
    return @zoom * 0.001
  end
  #--------------------------------------------------------------------------
  # ● ズーム率による座標変換
  #--------------------------------------------------------------------------
  def convert
    return @zoom
  end
  #--------------------------------------------------------------------------
  # ● カメラセットアップ
  #--------------------------------------------------------------------------
  def setup
    @x = 0
    @y = 0
    @sx = 0
    @sy = 0
    @zoom = 1000
    @time = 0
    @shake_time = 0
    program_setup
  end
  #--------------------------------------------------------------------------
  # ● カメラ初期化
  #--------------------------------------------------------------------------
  def reset
    @switches = []
    @max_data = []
    @color_set = []
    @wait = 0
    @win_wait = false
    @mirror = false
    program_setup(false)
  end  
  #--------------------------------------------------------------------------
  # ● バトルプログラムのセットアップ
  #--------------------------------------------------------------------------
  def program_setup(check = true)
    @played_program  = []
    @program_switch  = []
    @program_sound   = []
    @program_scroll  = []
    @program_se      = []
    @program_shake   = []
    @program_color   = []
    @program_picture = []
    @program_base = N03::BATTLE_PROGRAM.values.dup
    program_check if check
  end  
  #--------------------------------------------------------------------------
  # ● バトルプログラムのチェック
  #--------------------------------------------------------------------------
  def program_check
    for data in @program_base
      if program_start?(data) && !@played_program.include?(data)
        @played_program.push(data.dup)
        @program_scroll.push(data.dup)  if data[0] == "scroll"
        @program_picture.push(data.dup) if data[0] == "kpic"
        start_sound(data.dup)           if data[0] == "sound"
        start_program_switch(data.dup)  if data[0] == "switch"
        start_program_se(data.dup)      if data[0] == "keep_se"
        start_program_shake(data.dup)   if data[0] == "keep_sk"
        start_program_color(data.dup)   if data[0] == "keep_c"
      else
        @played_program.delete(data)  if !program_start?(data)
        @program_scroll.delete(data)  if data[0] == "scroll"
        @program_picture.delete(data) if data[0] == "kpic"
        @program_switch.delete(data)  if data[0] == "switch"
        @program_sound.delete(data)   if data[0] == "sound"
        @program_se.delete(data)      if data[0] == "keep_se"
        @program_shake.delete(data)   if data[0] == "keep_sk"
        @program_color.delete(data)   if data[0] == "keep_c"
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● バトルプログラムの開始
  #--------------------------------------------------------------------------
  def program_start?(data)
    start = false
    start = true if $game_switches[data[1].abs] && data[1] > 0
    start = true if @switches[data[1].abs] && data[1] < 0
    return start
  end  
  #--------------------------------------------------------------------------
  # ● バトルプログラム スイッチ操作の開始
  #--------------------------------------------------------------------------
  def start_program_switch(data)
    data[4] = data[4] + rand(data[5] + 1)
    data[4] = 1 if data[4] <= 0
    @program_switch.push(data)
  end
  #--------------------------------------------------------------------------
  # ● スイッチ操作の更新
  #--------------------------------------------------------------------------
  def update_program_switch
    for data in @program_switch
      data[4] -= 1
      next @program_switch.delete(data) if data[1] > 0 && !$game_switches[data[1]]
      next @program_switch.delete(data) if data[1] < 0 && !@switches[data[1].abs]
      next if data[4] != 0
      for id in data[2]
        $game_switches[id] = true if id > 0
        @switches[id.abs] = true  if id < 0
      end
      for id in data[3]
        $game_switches[id] = false if id > 0
        @switches[id.abs] = false  if id < 0
      end
      @program_switch.delete(data)
      program_check
    end  
  end
  #--------------------------------------------------------------------------
  # ● バトルプログラム BGM/BGSの開始
  #--------------------------------------------------------------------------
  def start_sound(data)
    @program_sound.push(data)
    name = data[5]
    case data[2]
    when "se"
      Audio.se_play("Audio/SE/" + name, data[4], data[3])
    when "bgm"
      name = RPG::BGM.last.name if data[5] == ""
      Audio.bgm_play("Audio/BGM/" + name, data[4], data[3])
    when "bgs"
      name = RPG::BGS.last.name if data[5] == ""
      Audio.bgs_play("Audio/BGS/" + name, data[4], data[3])
    end
  end
  #--------------------------------------------------------------------------
  # ● バトルプログラム 周期SEの開始
  #--------------------------------------------------------------------------
  def start_program_se(data)
    data[3] = [data[2], data[3]]
    data[2] = data[3][0] + rand(data[3][1] + 1)
    @program_se.push(data)
    Audio.se_play("Audio/SE/" + data[7], data[5], data[4]) if data[6]
  end
  #--------------------------------------------------------------------------
  # ● 周期SEの更新
  #--------------------------------------------------------------------------
  def update_program_se
    for data in @program_se
      data[2] -= 1
      next @program_se.delete(data) if data[1] > 0 && !$game_switches[data[1]]
      next @program_se.delete(data) if data[1] < 0 && !@switches[data[1].abs]
      next if data[2] != 0
      Audio.se_play("Audio/SE/" + data[7], data[5], data[4])
      data[2] = data[3][0] + rand(data[3][1] + 1)
    end  
  end
  #--------------------------------------------------------------------------
  # ● バトルプログラム 周期シェイクの開始
  #--------------------------------------------------------------------------
  def start_program_shake(data)
    data[3] = [data[2], data[3]]
    data[2] = data[3][0] + rand(data[3][1] + 1)
    @program_shake.push(data)
    shake(data[4], data[5], data[6]) if data[7]
  end
  #--------------------------------------------------------------------------
  # ● 周期シェイクの更新
  #--------------------------------------------------------------------------
  def update_program_shake
    for data in @program_shake
      data[2] -= 1
      next @program_shake.delete(data) if data[1] > 0 && !$game_switches[data[1]]
      next @program_shake.delete(data) if data[1] < 0 && !@switches[data[1].abs]
      next if data[2] != 0
      shake(data[4], data[5], data[6])
      data[2] = data[3][0] + rand(data[3][1] + 1)
    end  
  end
  #--------------------------------------------------------------------------
  # ● バトルプログラム 周期色調変更の開始
  #--------------------------------------------------------------------------
  def start_program_color(data)
    data[3] = [data[2], data[3]]
    data[2] = data[3][0] + rand(data[3][1] + 1)
    data[7] = true if data[4] == 0 or data[4] == 4
    case data[4]
    when 1   ;data[4] = $game_troop.members
    when 2   ;data[4] = $game_party.battle_members
    when 3,4 ;data[4] = $game_troop.members + $game_party.battle_members
    else ;data[4] = []
    end
    @program_color.push(data)
    return if !data[6]
    for target in data[4] do target.sv.color_set = data[5] end if data[4] != []
    @color_set[1] = data[5] if data[7]
    @color_set[2] = data[5] if data[7]
  end
  #--------------------------------------------------------------------------
  # ● 周期色調変更の更新
  #--------------------------------------------------------------------------
  def update_program_color
    for data in @program_color
      data[2] -= 1
      next @program_color.delete(data) if data[1] > 0 && !$game_switches[data[1]]
      next @program_color.delete(data) if data[1] < 0 && !@switches[data[1].abs]
      next if data[2] != 0
      for target in data[4] do target.sv.color_set = data[5] end if data[4] != []
      @color_set[1] = data[5] if data[7]
      @color_set[2] = data[5] if data[7]
      data[2] = data[3][0] + rand(data[3][1] + 1)
    end 
  end
  #--------------------------------------------------------------------------
  # ● トランジション実行
  #--------------------------------------------------------------------------
  def perform_transition(data)
    Graphics.transition(data[2], "Graphics/Pictures/" + data[3], data[1])
  end  
  #--------------------------------------------------------------------------
  # ● 背景からカメラの限界値を取得  data = [max_top, max_bottom, max_left, max_right]
  #--------------------------------------------------------------------------
  def setting(index, data)
    @max_data[index - 1] = data
    return if index != 2
    setup
    # カメラの中心座標
    @center_x     = (Graphics.width / 2 + N03::CAMERA_POSITION[0]) * 100
    @center_y     = (Graphics.height / 2 + N03::CAMERA_POSITION[1]) * 100
    # 上下左右の移動限界距離
    @max_top    = [@max_data[0][5], @max_data[1][5]].min * -1
    @max_bottom = [@max_data[0][1], @max_data[1][1]].min + @max_top
    @max_left   = [@max_data[0][4], @max_data[1][4]].min  * -1
    @max_right  = [@max_data[0][3], @max_data[1][3]].min + @max_left
    exist_data = @max_data[0] if !@max_data[1][6]
    exist_data = @max_data[1] if !@max_data[0][6]
    @max_top    = exist_data[5] * -1        if exist_data != nil
    @max_bottom = exist_data[1] + @max_top  if exist_data != nil
    @max_left   = exist_data[4] * -1        if exist_data != nil
    @max_right  = exist_data[3] + @max_left if exist_data != nil
    @max_top = @max_bottom = @max_left = @max_right = 0 if !@max_data[1][6] && !@max_data[0][6]
    @max_width    = @max_right - @max_left + Graphics.width
    @max_height   = @max_bottom - @max_top + Graphics.height
    # ズームアウト限界値
    max_zoom_x    = 100 * Graphics.width / @max_width
    max_zoom_y    = 100 * Graphics.height / @max_height
    @max_zoom_out = [max_zoom_x, max_zoom_y].max
  end
  #--------------------------------------------------------------------------
  # ● カメラ移動
  #--------------------------------------------------------------------------
  def move(target_x, target_y, zoom, time, screen = true)
    # 戦闘背景以上のサイズまでズームアウトしないよう調整
    @target_zoom = [zoom * 0.01, @max_zoom_out * 0.01].max
    target_x *= -1 if screen && @mirror
    # ズーム分の中心座標補正
    if screen && @target_zoom != 1
      target_x = target_x + @center_x
      target_y = target_y + @center_y
    end
    adjust_x = @center_x * (@target_zoom - 1) / (@target_zoom ** 2 - @target_zoom)
    adjust_y = @center_y * (@target_zoom - 1) / (@target_zoom ** 2 - @target_zoom)
    adjust_x = 0 if adjust_x.nan?
    adjust_y = 0 if adjust_y.nan?
    adjust_x = @center_x if !screen && adjust_x == 0
    adjust_y = @center_y if !screen && adjust_y == 0
    @target_x = target_x - adjust_x.to_i
    @target_y = target_y - adjust_y.to_i
    @target_zoom = (@target_zoom * 1000).to_i
    @zoom = @zoom.to_i
    limit_test
    # 時間0の場合は即実行
    return @time = time.abs if time != 0
    @time = 1
    update
  end
  #--------------------------------------------------------------------------
  # ● 限界座標の試算
  #--------------------------------------------------------------------------
  def limit_test
    new_width = @max_width * @target_zoom / 1000
    new_height = @max_height * @target_zoom / 1000
    new_max_right = @max_right - (@max_width - new_width)
    new_max_bottom = @max_bottom - (@max_height - new_height)
    # 画面の移動先が限界の場合、限界座標をセット
    if @target_x < @max_left * 100
      @target_x = @max_left * 100
    end 
    if @target_x > new_max_right * 100
      @target_x = new_max_right * 100
    end
    if @target_y < @max_top * 100
      @target_y = @max_top * 100
    end
    if @target_y > new_max_bottom * 100
      @target_y = new_max_bottom * 100
    end
  end
  #--------------------------------------------------------------------------
  # ● 画面のシェイク
  #--------------------------------------------------------------------------
  def shake(power, speed, time)
    @shake_x = power[0] * 100
    @shake_y = power[1] * 100
    @power_time_base = @power_time = speed
    @shake_time = time
    update_shake
  end
  #--------------------------------------------------------------------------
  # ● シェイクの更新
  #--------------------------------------------------------------------------
  def update_shake
    @sx = (@sx * (@power_time - 1) + @shake_x) / @power_time
    @sy = (@sy * (@power_time - 1) + @shake_y) / @power_time
    @power_time -= 1
    @shake_time -= 1
    return @sx = @sy = 0 if @shake_time == 0
    return if @power_time != 0
    @power_time = @power_time_base
    @shake_x = @shake_x * -4 / 5
    @shake_y = @shake_y * -4 / 5
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update
    update_shake if @shake_time != 0
    update_program
    return if @time == 0
    @x = (@x * (@time - 1) + @target_x) / @time
    @y = (@y * (@time - 1) + @target_y) / @time
    @zoom = (@zoom * (@time - 1) + @target_zoom) / @time
    @time -= 1
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  def update_program
    update_program_switch if @program_switch != []
    update_program_se     if @program_se != []
    update_program_shake  if @program_shake != []
    update_program_color  if @program_color != []
  end
end

#==============================================================================
# ■ Scene_Battle
#------------------------------------------------------------------------------
# 　バトル画面の処理を行うクラスです。
#==============================================================================
class Scene_Battle < Scene_Base
  #--------------------------------------------------------------------------
  # ● フレーム更新（基本）
  #--------------------------------------------------------------------------
  alias update_basic_scene_battle_n03 update_basic
  def update_basic
    update_basic_scene_battle_n03
    $sv_camera.update
    $sv_camera.wait = N03::TURN_END_WAIT + 1 if $sv_camera.win_wait
    camera_wait
  end
  #--------------------------------------------------------------------------
  # ● カメラウェイト
  #--------------------------------------------------------------------------
  def camera_wait
    process_event if $sv_camera.event
    $sv_camera.event = false if $sv_camera.event
    while $sv_camera.wait != 0
      Graphics.update
      Input.update
      update_all_windows
      $game_timer.update
      $game_troop.update
      $sv_camera.update
      @spriteset.update
      update_info_viewport
      update_message_open
      $sv_camera.wait -= 1 if $sv_camera.wait > 0
      $sv_camera.wait = 1 if $sv_camera.wait == 0 && @spriteset.effect?
      BattleManager.victory if $sv_camera.win_wait && $sv_camera.wait == 0
    end
  end
  #--------------------------------------------------------------------------
  # ● カメラウェイトのセット
  #--------------------------------------------------------------------------
  def set_camera_wait(time)
    $sv_camera.wait = time
    camera_wait
  end  
  #--------------------------------------------------------------------------
  # ● エフェクト実行が終わるまでウェイト ★再定義
  #--------------------------------------------------------------------------
  def wait_for_effect
  end
  #--------------------------------------------------------------------------
  # ● ターン開始
  #--------------------------------------------------------------------------
  alias turn_start_scene_battle_n03 turn_start
  def turn_start
    turn_start_scene_battle_n03
    N03.camera(nil, N03::BATTLE_CAMERA["After Turn Start"].dup)
  end
  #--------------------------------------------------------------------------
  # ● ターン終了
  #--------------------------------------------------------------------------
  alias turn_end_scene_battle_n03 turn_end
  def turn_end
    turn_end_scene_battle_n03
    for member in $game_troop.members + $game_party.members
      N03.set_damage(member, member.sv.result_damage[0],member.sv.result_damage[1])
      member.sv.result_damage = [0,0]
      @spriteset.set_damage_pop(member) if member.result.hp_damage != 0 or member.result.mp_damage != 0
    end
    set_camera_wait(N03::TURN_END_WAIT)
    N03.camera(nil, N03::BATTLE_CAMERA["Before Turn Start"].dup) if $game_party.inputable?
    @log_window.clear
  end
  #--------------------------------------------------------------------------
  # ● スキル／アイテムの使用 ★再定義
  #--------------------------------------------------------------------------
  def use_item
    item = @subject.current_action.item
    display_item(item)
    @subject.use_item(item)
    refresh_status
    @targets = @subject.current_action.make_targets.compact
    @targets = [@subject] if @targets.size == 0
    set_substitute(item)
    for time in item.repeats.times do play_sideview(@targets, item) end
    end_reaction(item)
    display_end_item
  end
  #--------------------------------------------------------------------------
  # ● スキル／アイテム名の表示
  #--------------------------------------------------------------------------
  def display_item(item)
    return @log_window.display_use_item(@subject, item) if N03::BATTLE_LOG
    @log_window.off
    @skill_name_window = Window_Skill_name.new(item.name) unless N03::NO_DISPLAY_SKILL_ID.include?(item.id) && item.is_a?(RPG::Skill)
  end  
  #--------------------------------------------------------------------------
  # ● スキル／アイテム名の表示終了
  #--------------------------------------------------------------------------
  def display_end_item
    @skill_name_window.dispose if @skill_name_window != nil
    @skill_name_window = nil
    set_camera_wait(N03::ACTION_END_WAIT) if @subject.sv.derivation_skill_id == 0
    @log_window.clear if N03::BATTLE_LOG
  end  
  #--------------------------------------------------------------------------
  # ● 反撃／魔法反射／身代わり処理
  #--------------------------------------------------------------------------
  def end_reaction(item)
    end_substitute if @substitute != nil
    set_reflection(item) if @reflection_data != nil
    set_counter_attack if @counter_attacker != nil
  end  
  #--------------------------------------------------------------------------
  # ● 反撃の発動 ★再定義
  #--------------------------------------------------------------------------
  def invoke_counter_attack(target, item)
    return if @subject.sv.counter_id != 0
    @counter_attacker = [] if @counter_attacker == nil
    return apply_item_effects(apply_substitute(target, item), item) if !target.movable?
    @log_window.add_text(sprintf(Vocab::CounterAttack, target.name)) if N03::BATTLE_LOG
    target.sv.counter_id = target.sv.counter_skill_id
    @counter_attacker.push(target)
  end
  #--------------------------------------------------------------------------
  # ● 魔法反射の発動 ★再定義
  #--------------------------------------------------------------------------
  def invoke_magic_reflection(target, item)
    return if @subject.sv.reflection_id != 0
    @log_window.add_text(sprintf(Vocab::MagicReflection, target.name)) if N03::BATTLE_LOG
    target.sv.reflection_id = target.sv.reflection_anime_id
  end
  #--------------------------------------------------------------------------
  # ● 身代わりの適用 ★再定義
  #--------------------------------------------------------------------------
  def apply_substitute(target, item)
    return target if @substitute == nil
    return target if !check_substitute(target, item)
    return @substitute
  end
  #--------------------------------------------------------------------------
  # ● 身代わりセット
  #--------------------------------------------------------------------------
  def set_substitute(item)
    @substitute = N03.get_enemy_unit(@subject).substitute_battler
    return if @substitute == nil
    s_targets = []
    for i in 0...@targets.size
      next if @targets[i] == @substitute
      next if !check_substitute(@targets[i], item)
      @log_window.add_text(sprintf(Vocab::Substitute, @substitute.name, @targets[i].name))
      @targets[i].sv.start_action(@targets[i].sv.substitute_receiver_start_action)
      s_targets.push(@targets[i])
      @targets[i] = @substitute
    end
    return @substitute = nil if s_targets == []
    @substitute.sv.set_target(s_targets)
    @substitute.sv.start_action(@substitute.sv.substitute_start_action)
  end  
  #--------------------------------------------------------------------------
  # ● 身代わり終了
  #--------------------------------------------------------------------------
  def end_substitute
    for member in @substitute.sv.target_battler
      member.sv.start_action(member.sv.substitute_receiver_end_action)
    end  
    @substitute.sv.start_action(@substitute.sv.substitute_end_action)
    @substitute = nil
  end
  #--------------------------------------------------------------------------
  # ● 反撃
  #--------------------------------------------------------------------------
  def set_counter_attack
    pre_subject = @subject
    for attacker in @counter_attacker
      @subject = attacker
      item = $data_skills[attacker.sv.counter_skill_id]
      play_sideview([pre_subject], item) 
    end
    # 同一カウンター者を考慮してカウンターIDの初期化はアクション後に実行
    for attacker in @counter_attacker do attacker.sv.counter_id = 0 end
    @subject = pre_subject
    @counter_attacker = nil
  end
  #--------------------------------------------------------------------------
  # ● 魔法反射
  #--------------------------------------------------------------------------
  def set_reflection(item)
    @log_window.back_to(1)
    for data in @reflection_data
      @subject.sv.damage_action(@subject, item)
      N03.set_damage_anime_data([@subject], @subject, data)
      apply_item_effects(@subject, item)
      @spriteset.set_damage_pop(@subject)
    end
    set_camera_wait(N03.get_anime_time(@reflection_data[0][0]))
    @reflection_data = nil
  end
  #--------------------------------------------------------------------------
  # ● サイドビューアクション実行
  #--------------------------------------------------------------------------
  def play_sideview(targets, item)
    @subject.sv.set_target(targets)
    return if @subject.sv.attack_action(item) == nil
    return if !@subject.movable?
    return if item.scope != 9 && item.scope != 10 && !N03.targets_alive?(targets)
    @subject.sv.start_action(@subject.sv.attack_action(item))
    @subject.sv.unshift_action(@subject.sv.flash_action) if @subject.flash_flg
    @subject.sv.active = true
    @subject.sv.command_action = false
    loop do
      update_basic
      data = @subject.sv.play_data
      @targets = N03.s_targets(@subject) if data[0] == "second_targets_set"
      N03.targets_set(@subject)          if data[0] == "targets_set"
      @immortal = N03.immortaling        if data[0] == "no_collapse" && !N03.dead_attack?(@subject, item)
      @immortal = N03.unimmortaling      if data[0] == "collapse"
      next set_move_anime(item)          if @subject.sv.m_a_data != []
      set_damage(item)                   if @subject.sv.set_damage
      break N03.derived_skill(@subject)  if @subject.sv.derivation_skill_id != 0
      break                              if @subject.sv.action_end or @subject.hidden?
    end
    @immortal = N03.unimmortaling        if @immortal
  end
  #--------------------------------------------------------------------------
  # ● ダメージの実行
  #--------------------------------------------------------------------------
  def set_damage(item)
    targets = @targets
    targets = [@subject.sv.individual_targets[0]] if @subject.sv.individual_targets.size != 0
    for target in targets do damage_anime(targets.dup, target, item) end
    @subject.sv.set_damage = false
    @subject.sv.damage_anime_data = []
  end
  #--------------------------------------------------------------------------
  # ● ダメージ戦闘アニメ処理
  #--------------------------------------------------------------------------
  def damage_anime(targets, target, item)
    @log_window.back_to(1) if @log_window.line_number == 5
    return if item.scope != 9 && item.scope != 10 && target.dead?
    @miss = false
    invoke_item(target,item)
    if target.result.missed
      target.sv.miss_action(@subject, item)
      return @miss = true
    elsif target.result.evaded or target.sv.counter_id != 0
      target.sv.evasion_action(@subject, item)
      return @miss = true
    elsif target.sv.reflection_id != 0
      N03.set_damage_anime_data(targets, target, [target.sv.reflection_id, false, false, true])
      target.sv.reflection_id = 0
      @reflection_data = [] if @reflection_data == nil
      return @reflection_data.push([N03.get_attack_anime_id(-3, @subject), false, false, true])
    end
    target.sv.damage_action(@subject, item)
    N03.set_damage(@subject, -target.result.hp_drain, -target.result.mp_drain) if target != @subject
    @spriteset.set_damage_pop(target)
    @spriteset.set_damage_pop(@subject) if target != @subject && @subject.result.hp_damage != 0 or @subject.result.mp_damage != 0
    N03.set_damage_anime_data(targets, target, @subject.sv.damage_anime_data) if @subject.sv.damage_anime_data != []
  end
  #--------------------------------------------------------------------------
  # ● 飛ばしアニメ処理
  #--------------------------------------------------------------------------
  def set_move_anime(item)
    for data in @subject.sv.m_a_data
      @subject.sv.damage_anime_data = data[4]
      hit_targets = []
      for target in data[1]
        damage_anime(data[1], target, item) if data[0]
        hit_targets.push(target) if !@miss
      end
      @miss = false if !data[3]
      @spriteset.set_hit_animation(@subject, data[2], hit_targets, @miss)
    end
    @subject.sv.set_damage = false
    @subject.sv.m_a_data = []
  end
end

#==============================================================================
# ■ DataManager
#------------------------------------------------------------------------------
# 　データベースとゲームオブジェクトを管理するモジュールです。
#==============================================================================
module DataManager
  #--------------------------------------------------------------------------
  # ● 各種ゲームオブジェクトの作成 ★再定義
  #--------------------------------------------------------------------------
  def self.create_game_objects
    $game_temp          = Game_Temp.new
    $game_system        = Game_System.new
    $game_timer         = Game_Timer.new
    $game_message       = Game_Message.new
    $game_switches      = Game_Switches.new
    $game_variables     = Game_Variables.new
    $game_self_switches = Game_SelfSwitches.new
    $game_actors        = Game_Actors.new
    $game_party         = Game_Party.new
    $game_troop         = Game_Troop.new
    $game_map           = Game_Map.new
    $game_player        = Game_Player.new
    $sv_camera          = Battle_Camera.new
  end
end

#==============================================================================
# ■ BattleManager
#------------------------------------------------------------------------------
# 　戦闘の進行を管理するモジュールです。
#==============================================================================
module BattleManager
  #--------------------------------------------------------------------------
  # ● エンカウント時の処理 ★再定義
  #--------------------------------------------------------------------------
  def self.on_encounter
    @preemptive = (rand < rate_preemptive)
    @surprise = (rand < rate_surprise && !@preemptive)
    $sv_camera.mirror = @surprise if N03::BACK_ATTACK
  end
  #--------------------------------------------------------------------------
  # ● 勝利の処理 ★再定義
  #--------------------------------------------------------------------------
  def self.process_victory
    $sv_camera.win_wait = true
  end  
  #--------------------------------------------------------------------------
  # ● 勝利
  #--------------------------------------------------------------------------
  def self.victory
    $sv_camera.win_wait = false 
    N03.camera(nil, N03::BATTLE_CAMERA["End of Battle"].dup)
    for member in $game_party.members do member.sv.start_action(member.sv.win) if member.movable? end
    play_battle_end_me
    replay_bgm_and_bgs
    $game_message.add(sprintf(Vocab::Victory, $game_party.name))
    display_exp
    gain_gold
    gain_drop_items
    gain_exp
    SceneManager.return
    battle_end(0)
    return true
  end
  #--------------------------------------------------------------------------
  # ● 逃走の処理 ★再定義
  #--------------------------------------------------------------------------
  def self.process_escape
    $game_message.add(sprintf(Vocab::EscapeStart, $game_party.name))
    success = @preemptive ? true : (rand < @escape_ratio)
    Sound.play_escape
    if success
      process_abort
      for member in $game_party.members do member.sv.start_action(member.sv.escape) if member.movable? end
    else
      @escape_ratio += 0.1
      $game_message.add('\.' + Vocab::EscapeFailure)
      $game_party.clear_actions
      for member in $game_party.members do member.sv.start_action(member.sv.escape_ng) if member.movable? end
    end
    wait_for_message
    return success
  end
  #--------------------------------------------------------------------------
  # ● 次のコマンド入力へ ★再定義
  #--------------------------------------------------------------------------
  def self.next_command
    begin
      if !actor || !actor.next_command
        $game_party.battle_members[@actor_index].sv.command_action = true
        @actor_index += 1
        if @actor_index >= $game_party.members.size
          for member in $game_party.battle_members.reverse
            break member.sv.start_action(member.sv.command_a) if member.inputable?
          end
          return false 
        end
      end
    end until actor.inputable?
    actor.sv.start_action(actor.sv.command_b) if actor != nil && actor.inputable?
    if pre_actor
      pre_actor.sv.start_action(pre_actor.sv.command_a) if pre_actor != nil && pre_actor.inputable?
    end
    return true
  end
  #--------------------------------------------------------------------------
  # ● 前のコマンド入力へ ★再定義
  #--------------------------------------------------------------------------
  def self.prior_command
    begin
      if !actor || !actor.prior_command
        $game_party.battle_members[@actor_index].sv.command_action = false
        @actor_index -= 1
        if @actor_index < 0
          for member in $game_party.battle_members
            break member.sv.start_action(member.sv.command_a) if member.inputable?
          end
          return false 
        end
      end
    end until actor.inputable?
    actor.make_actions if actor.inputable?
    actor.sv.start_action(actor.sv.command_b) if actor.inputable?
    after_actor.sv.start_action(after_actor.sv.command_a) if after_actor != nil && after_actor.inputable?
    return true
  end
  #--------------------------------------------------------------------------
  # ● コマンド入力前のアクターを取得
  #--------------------------------------------------------------------------
  def self.pre_actor
    return if @actor_index == 0
    $game_party.members[@actor_index - 1]
  end
  #--------------------------------------------------------------------------
  # ● コマンド入力後のアクターを取得
  #--------------------------------------------------------------------------
  def self.after_actor
    $game_party.members[@actor_index + 1]
  end
  #--------------------------------------------------------------------------
  # ● 戦闘行動者を前に追加
  #--------------------------------------------------------------------------
  def self.unshift_action_battlers(battler)
    @action_battlers.unshift(battler)
  end
end  

#==============================================================================
# ■ Game_Battler
#------------------------------------------------------------------------------
# 　スプライトや行動に関するメソッドを追加したバトラーのクラスです。
#==============================================================================
class Game_Battler < Game_BattlerBase
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader   :sv                     # サイドビューデータ
  attr_accessor :flash_flg              # 閃きフラグ
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias initialize_game_battler_n03 initialize
  def initialize
    initialize_game_battler_n03
    @sv = SideView.new(self)
  end
  #--------------------------------------------------------------------------
  # ● 現在の戦闘行動を除去
  #--------------------------------------------------------------------------
  alias remove_current_action_game_battler_n03 remove_current_action
  def remove_current_action
    return @sv.derivation_skill_id = 0 if @sv.derivation_skill_id != 0
    remove_current_action_game_battler_n03
  end
  #--------------------------------------------------------------------------
  # ● ターン終了処理
  #--------------------------------------------------------------------------
  alias on_turn_end_game_battler_n03 on_turn_end
  def on_turn_end
    on_turn_end_game_battler_n03
    @sv.add_state = []
    @sv.result_damage = [@result.hp_damage, @result.mp_damage]
  end
  #--------------------------------------------------------------------------
  # ● パラメータ条件比較 data = [種別, 数値, 判別]
  #--------------------------------------------------------------------------
  def comparison_parameter(data)
    return true if data[0][0] == 0
    kind = data[0]
    num = data[1]
    select = data[2]
    case kind
    when  1 ; par = level
    when  2 ; par = mhp
    when  3 ; par = mmp
    when  4 ; par = hp
    when  5 ; par = mp
    when  6 ; par = tp
    when  7 ; par = atk
    when  8 ; par = self.def
    when  9 ; par = mat
    when 10 ; par = mdf
    when 11 ; par = agi
    when 12 ; par = luk
    end
    if num < 0
      case kind
      when  4 ; num = mhp * num / 100
      when  5 ; num = mmp * num / 100
      when  6 ; num = max_tp * num / 100
      end
      num = num.abs
    end  
    case select
    when  0 ; return par == num
    when  1 ; return par < num
    when  2 ; return par > num
    end
  end
  #--------------------------------------------------------------------------
  # ● 装備条件比較 data = [装備種別, タイプID]
  #--------------------------------------------------------------------------
  def comparison_equip(data)
    kind = data[0]
    items = weapons if kind == 0
    items = armors  if kind == 1
    for item in items
      for id in data[1]
        return true if id > 0 && item.is_a?(RPG::Weapon) && item == $data_weapons[id.abs]
        return true if id > 0 && item.is_a?(RPG::Armor) && item == $data_armors[id.abs]
        return true if id < 0 && item.is_a?(RPG::Weapon) && item.wtype_id == id.abs
        return true if id < 0 && item.is_a?(RPG::Armor) && item.stype_id == id.abs
      end
    end
    return false
  end
  
end  
#==============================================================================
# ■ Game_Actor
#------------------------------------------------------------------------------
# 　アクターを扱うクラスです。
#==============================================================================
class Game_Actor < Game_Battler
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader :actor_id                    # ID
  #--------------------------------------------------------------------------
  # ● ID
  #--------------------------------------------------------------------------
  def id
    return @actor_id
  end
  #--------------------------------------------------------------------------
  # ● スプライトを使うか？ ★再定義
  #--------------------------------------------------------------------------
  def use_sprite?
    return true
  end
  #--------------------------------------------------------------------------
  # ● ダメージ効果の実行 ★再定義
  #--------------------------------------------------------------------------
  def perform_damage_effect
    return if !N03::ACTOR_DAMAGE
    $game_troop.screen.start_shake(5, 5, 10)
    @sprite_effect_type = :blink
    Sound.play_actor_damage
  end
  
end

#==============================================================================
# ■ Game_Enemy
#------------------------------------------------------------------------------
# 　敵キャラを扱うクラスです。
#==============================================================================
class Game_Enemy < Game_Battler
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数
  #--------------------------------------------------------------------------
  attr_reader :enemy_id                    # ID
  #--------------------------------------------------------------------------
  # ● ID
  #--------------------------------------------------------------------------
  def id
    return @enemy_id
  end
  #--------------------------------------------------------------------------
  # ● レベル
  #--------------------------------------------------------------------------
  def level
    return @sv.level
  end
  #--------------------------------------------------------------------------
  # ● ダメージ効果の実行 ★再定義
  #--------------------------------------------------------------------------
  def perform_damage_effect
    return if !N03::ENEMY_DAMAGE
    @sprite_effect_type = :blink
    Sound.play_enemy_damage
  end
  #--------------------------------------------------------------------------
  # ● 武器
  #--------------------------------------------------------------------------
  def weapons
    weapon1 = $data_weapons[@sv.enemy_weapon1_id]
    weapon2 = $data_weapons[@sv.enemy_weapon2_id]
    return [weapon1, weapon2]
  end
  #--------------------------------------------------------------------------
  # ● 防具
  #--------------------------------------------------------------------------
  def armors
    return [$data_armors[@sv.enemy_shield_id]]
  end
  #--------------------------------------------------------------------------
  # ● 二刀流の判定
  #--------------------------------------------------------------------------
  def dual_wield?
    return $data_weapons[@sv.enemy_weapon2_id] != nil
  end
  #--------------------------------------------------------------------------
  # ● バトラー画像変更
  #--------------------------------------------------------------------------
  def graphics_change(battler_name)
    @battler_name = battler_name
  end
  #--------------------------------------------------------------------------
  # ● 通常攻撃 アニメーション ID の取得
  #--------------------------------------------------------------------------
  def atk_animation_id1
    return weapons[0].animation_id if weapons[0]
    return weapons[1] ? 0 : 1
  end
  #--------------------------------------------------------------------------
  # ● 通常攻撃 アニメーション ID の取得（二刀流：武器２）
  #--------------------------------------------------------------------------
  def atk_animation_id2
    return weapons[1] ? weapons[1].animation_id : 0
  end
end

#==============================================================================
# ■ Sprite_Base
#------------------------------------------------------------------------------
# 　アニメーションの表示処理を追加したスプライトのクラスです。
#==============================================================================
class Sprite_Base < Sprite
  #--------------------------------------------------------------------------
  # ● アニメーションの座標更新 (ホーミングあり)
  #--------------------------------------------------------------------------
  def update_animation_position_horming
    return if @action_end_cancel
    ani_ox_set if @horming
    camera_zoom = $sv_camera.zoom
    camera_zoom = 1 if @move_anime
    kind = 1
    kind = -1 if @ani_mirror && !@anime_no_mirror
    cell_data = @animation.frames[@animation.frame_max - (@ani_duration + @ani_rate - 1) / @ani_rate].cell_data
    for i in 0..15
      @ani_sprites[i].x = (@ani_ox + cell_data[i, 1] * kind - $sv_camera.x) * camera_zoom if @ani_sprites[i] != nil && cell_data[i, 1] != nil
      @ani_sprites[i].y = (@ani_oy + cell_data[i, 2] - $sv_camera.y) * camera_zoom if @ani_sprites[i] != nil && cell_data[i, 2] != nil
    end
  end
  #--------------------------------------------------------------------------
  # ● アニメーション元の座標をセット
  #--------------------------------------------------------------------------
  def ani_ox_set
    if !SceneManager.scene_is?(Scene_Battle)
      @real_x = x
      @real_y = y
    end
    @ani_ox = @real_x - ox + width / 2
    @ani_oy = @real_y - oy + height / 2
    @ani_oy -= height / 2 if @animation.position == 0
    @ani_oy += height / 2 if @animation.position == 2
  end
  #--------------------------------------------------------------------------
  # ● アニメーションの更新
  #--------------------------------------------------------------------------
  alias update_animation_sprite_base_n03 update_animation
  def update_animation
    update_animation_position_horming if animation? && SceneManager.scene_is?(Scene_Battle) && @animation.position != 3
    update_animation_sprite_base_n03
  end
  #--------------------------------------------------------------------------
  # ● アニメーションの原点設定 ★再定義
  #--------------------------------------------------------------------------
  def set_animation_origin
    return ani_ox_set if @animation.position != 3
    if viewport == nil
      @ani_ox = Graphics.width / 2
      @ani_oy = Graphics.height / 2
    else
      @ani_ox = viewport.rect.width / 2
      @ani_oy = viewport.rect.height / 2
    end
  end
  #--------------------------------------------------------------------------
  # ● アニメーションスプライトの設定 ★再定義
  #--------------------------------------------------------------------------
  def animation_set_sprites(frame)
    camera_zoom = 1
    camera_zoom = $sv_camera.zoom if @anime_camera_zoom && @animation.position != 3 && SceneManager.scene_is?(Scene_Battle)
    camera_x = $sv_camera.x
    camera_y = $sv_camera.y
    camera_x = camera_y = 0 if @animation.position == 3 or !SceneManager.scene_is?(Scene_Battle)
    plus_z = 5
    plus_z = 1000 if @animation.position == 3
    plus_z = -17 if @plus_z != nil && @plus_z == false
    plus_z = -self.z + 10 if @plus_z != nil && @plus_z == false && @animation.position == 3
    cell_data = frame.cell_data
    @ani_sprites.each_with_index do |sprite, i|
      next unless sprite
      pattern = cell_data[i, 0]
      if !pattern || pattern < 0
        sprite.visible = false
        next
      end
      sprite.bitmap = pattern < 100 ? @ani_bitmap1 : @ani_bitmap2
      sprite.visible = true
      sprite.src_rect.set(pattern % 5 * 192,
        pattern % 100 / 5 * 192, 192, 192)
      if @ani_mirror && !@anime_no_mirror
        sprite.x = (@ani_ox - cell_data[i, 1] - camera_x) * camera_zoom
        sprite.y = (@ani_oy + cell_data[i, 2] - camera_y) * camera_zoom
        sprite.angle = (360 - cell_data[i, 4])
        sprite.mirror = (cell_data[i, 5] == 0)
      else
        sprite.x = (@ani_ox + cell_data[i, 1] - camera_x) * camera_zoom
        sprite.y = (@ani_oy + cell_data[i, 2] - camera_y) * camera_zoom
        sprite.angle = cell_data[i, 4]
        sprite.mirror = (cell_data[i, 5] == 1)
      end
      sprite.z = self.z + plus_z + i
      sprite.ox = 96
      sprite.oy = 96
      sprite.zoom_x = cell_data[i, 3] * camera_zoom / 100.0
      sprite.zoom_y = cell_data[i, 3] * camera_zoom/ 100.0
      sprite.opacity = cell_data[i, 6] * self.opacity / 255.0
      sprite.blend_type = cell_data[i, 7]
    end
  end
  #--------------------------------------------------------------------------
  # ● 子スプライトフラグ
  #--------------------------------------------------------------------------
  def set(battler, horming, camera_zoom, no_mirror)
    @battler = battler
    @next = true
    self.bitmap = Bitmap.new(@battler.sv.cw, @battler.sv.ch)
    self.ox = bitmap.width / 2
    self.oy = bitmap.height
    @horming = horming
    @anime_camera_zoom = camera_zoom
    @anime_no_mirror = no_mirror
    @battler.sv.reset_anime_data
  end  
  #--------------------------------------------------------------------------
  # ● 子スプライト座標セット
  #--------------------------------------------------------------------------
  def set_position(z, zoom_x, zoom_y, real_x, real_y)
    self.z = z
    self.zoom_x = zoom_x
    self.zoom_y = zoom_y
    @real_x = real_x
    @real_y = real_y
  end
  #--------------------------------------------------------------------------
  # ● 他スプライトへのタイミング処理
  #--------------------------------------------------------------------------
  def other_process_timing(timing)
    se_flag = true
    se_flag = @se_flag if @se_flag != nil
    @battler.sv.timing.push([se_flag, timing.dup])
  end
  #--------------------------------------------------------------------------
  # ● 他バトラーへのタイミング処理
  #--------------------------------------------------------------------------
  def target_battler_process_timing(timing)
    for target in @timing_targets
      target.sv.timing.push([false, timing.dup])
    end  
  end
  #--------------------------------------------------------------------------
  # ● SE とフラッシュのタイミング処理
  #--------------------------------------------------------------------------
  alias animation_process_timing_sprite_base_n03 animation_process_timing
  def animation_process_timing(timing)
    target_battler_process_timing(timing) if @timing_targets && @timing_targets != []
    return other_process_timing(timing) if @next != nil
    animation_process_timing_sprite_base_n03(timing)
  end
  #--------------------------------------------------------------------------
  # ● アニメーションの解放
  #--------------------------------------------------------------------------
  alias dispose_animation_sprite_base_n03 dispose_animation
  def dispose_animation
    dispose_animation_sprite_base_n03
  end
end


#==============================================================================
# ■ Sprite_Battler
#------------------------------------------------------------------------------
# 　バトラー表示用のスプライトです。
#==============================================================================
class Sprite_Battler < Sprite_Base
  #--------------------------------------------------------------------------
  # ● 公開インスタンス変数　
  #--------------------------------------------------------------------------
  attr_accessor   :removing             # パーティ離脱中
  #--------------------------------------------------------------------------
  # ● オブジェクト初期化
  #--------------------------------------------------------------------------
  alias initialize_sprite_battler_n03 initialize
  def initialize(viewport, battler = nil)
    initialize_sprite_battler_n03(viewport, battler)
    @real_x = @real_y = 0
    update_bitmap if @battler != nil
  end
  #--------------------------------------------------------------------------
  # ● アニメーションの開始 ★再定義
  #--------------------------------------------------------------------------
  def start_animation(animation, mirror = false)
    return next_animation(animation, mirror) if animation?
    @animation = animation
    if @animation
      @horming = @battler.sv.anime_horming
      @anime_camera_zoom = @battler.sv.anime_camera_zoom
      @anime_no_mirror = @battler.sv.anime_no_mirror
      @timing_targets = @battler.sv.timing_targets
      @plus_z = @battler.sv.anime_plus_z
      @battler.sv.reset_anime_data
      @ani_mirror = mirror
      set_animation_rate
      @ani_duration = @animation.frame_max * @ani_rate + 1
      load_animation_bitmap
      make_animation_sprites
      set_animation_origin
    end
  end
  #--------------------------------------------------------------------------
  # ● 次のアニメを開始
  #--------------------------------------------------------------------------
  def next_animation(animation, mirror)
    @next_anime = [] if @next_anime == nil
    @next_anime.push(Sprite_Base.new(viewport))
    @next_anime[@next_anime.size - 1].set(battler, @battler.sv.anime_horming, @battler.sv.anime_camera_zoom, @battler.sv.anime_no_mirror)
    @next_anime[@next_anime.size - 1].set_position(self.z, self.zoom_x, self.zoom_y, @real_x, @real_y)
    @next_anime[@next_anime.size - 1].start_animation(animation, mirror)
  end
  #--------------------------------------------------------------------------
  # ● 影グラフィック作成
  #--------------------------------------------------------------------------
  def create_shadow
    reset_shadow
    return if @battler.sv.shadow == false
    @shadow = Sprite.new(viewport) if @shadow == nil
    @shadow.bitmap = Cache.character(@battler.sv.shadow)
    @shadow.ox = @shadow.bitmap.width / 2
    @shadow.oy = @shadow.bitmap.height / 2
  end
  #--------------------------------------------------------------------------
  # ● 影グラフィック初期化
  #--------------------------------------------------------------------------
  def reset_shadow
    return if @shadow == nil
    @shadow.dispose
    @shadow = nil
  end  
  #--------------------------------------------------------------------------
  # ● 転送元ビットマップの更新 ★再定義
  #--------------------------------------------------------------------------
  def update_bitmap
    update_bitmap_enemy if !@battler.actor?
    update_bitmap_actor if @battler.actor?
    update_src_rect if @battler != nil
    update_color if @battler != nil
  end
  #--------------------------------------------------------------------------
  # ● 転送元ビットマップ:エネミー
  #--------------------------------------------------------------------------
  def update_bitmap_enemy
    if @battler.battler_name != @battler_name or @battler.battler_hue != @battler_hue
      @battler_name = @battler.battler_name
      @battler_hue = @battler.battler_hue
      @battler_graphic_file_index = @battler.sv.graphic_file_index
      @graphic_mirror_flag = @battler.sv.graphic_mirror_flag
      self.bitmap = Cache.battler(@battler_name + @battler_graphic_file_index, @battler_hue)
      @battler.sv.setup(self.bitmap.width, self.bitmap.height, @battler_id != @battler.id)
      create_shadow
      init_visibility
      @battler_id = @battler.id
    end
  end  
  #--------------------------------------------------------------------------
  # ● 転送元ビットマップ:アクター
  #--------------------------------------------------------------------------
  def update_bitmap_actor
    if @battler.character_name != @battler_name or @battler.character_index != @battler_index
      @battler_name = @battler.character_name
      @battler_index = @battler.character_index
      @battler_graphic_file_index = @battler.sv.graphic_file_index
      @graphic_mirror_flag = @battler.sv.graphic_mirror_flag
      self.bitmap = Cache.character(@battler_name + @battler_graphic_file_index)
      @battler.sv.setup(self.bitmap.width, self.bitmap.height, @battler_id != @battler.id)
      create_shadow
      init_visibility
      @battler_id = @battler.id
    end
  end
  #--------------------------------------------------------------------------
  # ● 可視状態の初期化 ★再定義
  #--------------------------------------------------------------------------
  def init_visibility
    @battler_visible = @battler.alive?
    @battler_visible = true if @battler.sv.state(1) != "Collapse Enemy"
    @battler_visible = false if @battler.hidden?
    @battler.sv.opacity = 0 unless @battler_visible
    self.opacity = 0 unless @battler_visible
    self.opacity = 255 if @battler_visible
    @battler.sv.weapon_visible = @battler_visible
  end
  #--------------------------------------------------------------------------
  # ● 転送元矩形の更新
  #--------------------------------------------------------------------------
  def update_src_rect
    return if @battler.sv.collapse
    if @battler_graphic_file_index != @battler.sv.graphic_file_index
      @battler_graphic_file_index = @battler.sv.graphic_file_index
      self.bitmap = Cache.character(@battler_name + @battler_graphic_file_index) if @battler.actor?
      self.bitmap = Cache.battler(@battler_name + @battler_graphic_file_index, @battler_hue) if !@battler.actor?
      @battler.sv.set_graphics(self.bitmap.width, self.bitmap.height)
    end
    anime_off if @battler.sv.anime_off
    self.src_rect.set(@battler.sv.sx, @battler.sv.sy, @battler.sv.cw, @battler.sv.ch)
    self.opacity = @battler.sv.opacity if @battler_visible
    set_process_timing(@battler.sv.timing) if @battler && @battler.sv.timing != []
  end
  #--------------------------------------------------------------------------
  # ● 位置の更新 ★再定義
  #--------------------------------------------------------------------------
  def update_position
    @real_x = @battler.sv.x / 100
    @real_y = (@battler.sv.y - @battler.sv.h - @battler.sv.j - @battler.sv.c - @battler.sv.oy_adjust)/ 100
    self.x = @real_x - $sv_camera.x
    self.y = @real_y - $sv_camera.y
    self.z = @battler.sv.z - @battler.sv.c / 100
    if @battler.sv.h <= 0
      self.x += $sv_camera.sx / 100
      self.y += $sv_camera.sy / 100
    end  
    self.x *= $sv_camera.zoom
    self.y *= $sv_camera.zoom
  end
  #--------------------------------------------------------------------------
  # ● 原点の更新 ★再定義
  #--------------------------------------------------------------------------
  def update_origin
    return if !bitmap or @battler.sv.collapse
    self.ox = @battler.sv.ox
    self.oy = @battler.sv.oy
    self.angle = @battler.sv.angle
    self.zoom_x = @battler.sv.zoom_x * $sv_camera.zoom
    self.zoom_y = @battler.sv.zoom_y * $sv_camera.zoom
    self.mirror = @battler.sv.mirror if !@graphic_mirror_flag
    self.mirror = !@battler.sv.mirror if @graphic_mirror_flag
  end
  #--------------------------------------------------------------------------
  # ● 影グラフィックの更新
  #--------------------------------------------------------------------------
  def update_shadow
    @shadow.visible = @battler.sv.shadow_visible
    @shadow.opacity = @battler.sv.opacity if @battler.sv.opacity_data[3]
    @shadow.opacity = self.opacity if !@battler.sv.opacity_data[3]
    @shadow.x = @real_x - $sv_camera.x
    @shadow.y = (@battler.sv.y - @battler.sv.c)/ 100 - $sv_camera.y
    @shadow.z = @battler.sv.z - 10
    @shadow.zoom_x = $sv_camera.zoom
    @shadow.zoom_y = $sv_camera.zoom
    @shadow.x += $sv_camera.sx / 100
    @shadow.y += $sv_camera.sy / 100
    @shadow.x *= $sv_camera.zoom
    @shadow.y *= $sv_camera.zoom
    @shadow.color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3]) if @color_data != nil
  end
  #--------------------------------------------------------------------------
  # ● ふきだしの更新
  #--------------------------------------------------------------------------
  def update_balloon
    if @battler.sv.balloon_data == [] && @balloon
      @balloon_data = []
      @balloon.dispose
      return @balloon = nil
    elsif @battler.sv.balloon_data != [] && @battler.sv.balloon_data != @balloon_data
      @balloon_data = @battler.sv.balloon_data
      @balloon = Sprite.new(self.viewport)
      @balloon.bitmap = Cache.system("Balloon")
      @balloon.zoom_x = @balloon_data[3]
      @balloon.zoom_y = @balloon_data[3]
      @balloon.ox = 32 if @battler.sv.mirror
      @balloon.oy = 16
      @balloon_count = 0
    end
    return if !@balloon
    @balloon.opacity = self.opacity
    @balloon.x = self.x
    @balloon.y = self.y - @battler.sv.ch * $sv_camera.zoom
    @balloon.z = self.z + 20
    @balloon.src_rect.set(32 + @balloon_count / @balloon_data[2] * 32, @balloon_data[1] * 32, 32, 32) if @balloon_count % @balloon_data[2] == 0
    @balloon.color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3]) if @color_data != nil
    @balloon_count += 1
    @balloon_count = 0 if @balloon_count == @balloon_data[2] * 7
  end
  #--------------------------------------------------------------------------
  # ● 色調変更の更新
  #--------------------------------------------------------------------------
  def update_color
    color_set if @battler.sv.color_set != []
    return if @color_data == nil
    @color_data[4] -= 1
    if @color_data[4] == 0 && @color_data[5] != 0
      @color_data[4] = @color_data[5]
      @color_data[5] = 0
      @color_data[6] = [0,0,0,0]
    elsif @color_data[4] == 0
      @remain_color_data = @color_data
      @battler.sv.color = @color_data.dup
      return @color_data = nil
    end  
    for i in 0..3
      @color_data[i] = (@color_data[i] * (@color_data[4] - 1) + @color_data[6][i]) / @color_data[4]
    end  
    @battler.sv.color = @color_data.dup
    self.color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3])
  end
  #--------------------------------------------------------------------------
  # ● 残像の更新
  #--------------------------------------------------------------------------
  def update_mirage
    if @battler.sv.mirage == [] && @mirages
      @mirage_data = []
      for mirage in @mirages do mirage.dispose end
      return @mirages = nil
    elsif @battler.sv.mirage != [] && @battler.sv.mirage != @mirage_data
      @mirage_data = @battler.sv.mirage
      @mirages = []
      for i in 0...@mirage_data[1] do @mirages[i] = Sprite.new(self.viewport) end
      @mirage_count = 0
    end
    return if !@mirages
    @mirage_count += 1
    @mirage_count = 0 if @mirage_count == @mirage_data[2] * @mirages.size
    for i in 0...@mirages.size
      mirage_body(@mirages[i], @mirage_data[4]) if @mirage_count == 1 + i * @mirage_data[2]
    end
  end
  #--------------------------------------------------------------------------
  # ● 残像本体
  #--------------------------------------------------------------------------
  def mirage_body(body, opacity)
    body.bitmap = self.bitmap.dup
    body.x = self.x
    body.y = self.y
    body.ox = self.ox
    body.oy = self.oy
    body.z = self.z - 20
    body.mirror = self.mirror
    body.angle = self.angle
    body.opacity = opacity * self.opacity / 255
    body.zoom_x = self.zoom_x
    body.zoom_y = self.zoom_y   
    body.src_rect.set(@battler.sv.sx, @battler.sv.sy, @battler.sv.cw, @battler.sv.ch)
    body.color.set(@color_data[0], @color_data[1], @color_data[2], @color_data[3]) if @color_data != nil
  end   
  #--------------------------------------------------------------------------
  # ● 次のアニメを更新
  #--------------------------------------------------------------------------
  def update_next_anime
    return if !@next_anime
    for anime in @next_anime
      anime.update
      anime.set_position(self.z, self.zoom_x, self.zoom_y, @real_x, @real_y) if @horming
      anime.dispose if !anime.animation?
      @next_anime.delete(anime) if !anime.animation?
    end  
  end
  #--------------------------------------------------------------------------
  # ● フレーム更新
  #--------------------------------------------------------------------------
  alias update_sprite_battler_n03 update
  def update
    @battler.sv.update if @battler
    update_sprite_battler_n03
    update_next_anime
    update_shadow  if @battler && @shadow
    update_mirage  if @battler
    update_balloon if @battler
    update_remove if @battler && @removing && @battler.sv.change_up
  end
  #--------------------------------------------------------------------------
  # ● 戦闘アニメ消去
  #--------------------------------------------------------------------------
  def anime_off
    @battler.sv.anime_off = false
    dispose_animation
    for anime in @next_anime do anime.dispose_animation end if @next_anime
  end
  #--------------------------------------------------------------------------
  # ● バトラー入れ替え
  #--------------------------------------------------------------------------
  def remove
    @battler.sv.start_action(@battler.sv.remove_action)
    $sv_camera.wait = 40
    @battler.sv.add_action("eval('set_change')")
    @removing = true
  end
  #--------------------------------------------------------------------------
  # ● バトラー入れ替えの更新
  #--------------------------------------------------------------------------
  def update_remove
    @battler.sv.change_up = false
    @removing = false
    @battler = nil
  end  
  #--------------------------------------------------------------------------
  # ● バトラー加入
  #--------------------------------------------------------------------------
  def join(join_battler)
    $sv_camera.wait = 30
    @battler = join_battler
    @battler_name = @battler.character_name
    @battler_index = @battler.character_index
    @battler_graphic_file_index = @battler.sv.graphic_file_index
    self.bitmap = Cache.character(@battler_name)
    @battler.sv.setup(self.bitmap.width, self.bitmap.height, true)
    create_shadow
    init_visibility
  end
  #--------------------------------------------------------------------------
  # ● 通常の設定に戻す ★再定義
  #--------------------------------------------------------------------------
  def revert_to_normal
    self.blend_type = 0
    self.opacity = 255
  end
  #--------------------------------------------------------------------------
  # ● 崩壊エフェクトの更新
  #--------------------------------------------------------------------------
  alias update_collapse_sprite_battler_n03 update_collapse
  def update_collapse
    return if @battler.sv.state(1) != "Collapse Enemy"
    update_collapse_sprite_battler_n03
    @battler.sv.weapon_visible = false
  end
  #--------------------------------------------------------------------------
  # ● ボス崩壊エフェクトの更新 ★再定義
  #--------------------------------------------------------------------------
  def update_boss_collapse
    @effect_duration = @battler.sv.ch if @effect_duration >= @battler.sv.ch
    alpha = @effect_duration * 120 / @battler.sv.ch
    self.ox = @battler.sv.cw / 2 + @effect_duration % 2 * 4 - 2
    self.blend_type = 1
    self.color.set(255, 255, 255, 255 - alpha)
    self.opacity = alpha
    self.src_rect.y -= 1
    Sound.play_boss_collapse2 if @effect_duration % 20 == 19
  end
  #--------------------------------------------------------------------------
  # ● 別スプライトからのタイミング処理
  #--------------------------------------------------------------------------
  def set_process_timing(timing_data)
    for data in timing_data
      set_timing(data[0],data[1])
    end
    @battler.sv.timing = []
  end
  #--------------------------------------------------------------------------
  # ● タイミング処理
  #--------------------------------------------------------------------------
  def set_timing(se_flag, data)
    @ani_rate = 4
    data.se.play if se_flag
    case data.flash_scope
    when 1 ;self.flash(data.flash_color, data.flash_duration * @ani_rate)
    when 2 ;viewport.flash(data.flash_color, data.flash_duration * @ani_rate) if viewport
    when 3 ;self.flash(nil, data.flash_duration * @ani_rate)
    end
  end
  #--------------------------------------------------------------------------
  # ● 色調変更
  #--------------------------------------------------------------------------
  def color_set
    set = @battler.sv.color_set
    @battler.sv.color_set= []
    set[4] = 1 if set[4] == 0
    @remain_color_data = [0,0,0,0] if @remain_color_data == nil
    @color_data = @remain_color_data
    @color_data[4] = set[4]
    @color_data[5] = set[5]
    @color_data[6] = set
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  alias dispose_sprite_battler_n03 dispose
  def dispose
    dispose_sprite_battler_n03
    @shadow.dispose if @shadow != nil
    @balloon.dispose if @balloon != nil
    for mirage in @mirages do mirage.dispose end if @mirages != nil
    for anime in @next_anime do anime.dispose end if @next_anime
  end
end


#==============================================================================
# ■ Spriteset_Battle
#------------------------------------------------------------------------------
# 　バトル画面のスプライトをまとめたクラスです。
#==============================================================================
class Spriteset_Battle
  #--------------------------------------------------------------------------
  # ● 戦闘背景（床）スプライトの作成 ★再定義
  #--------------------------------------------------------------------------
  def create_battleback1
    @back1_sprite = Sprite_Battle_Back.new(@viewport1, 1, battleback1_name)
    @back1_sprite.set_graphics(battleback1_bitmap) if battleback1_name != nil
    @back1_sprite.z = 0
  end
  #--------------------------------------------------------------------------
  # ● 戦闘背景（壁）スプライトの作成 ★再定義
  #--------------------------------------------------------------------------
  def create_battleback2
    @back2_sprite = Sprite_Battle_Back.new(@viewport1, 2, battleback2_name)
    @back2_sprite.set_graphics(battleback2_bitmap) if battleback2_name != nil
    @back2_sprite.z = 1
  end
  #--------------------------------------------------------------------------
  # ● アクタースプライトの作成 ★再定義
  #--------------------------------------------------------------------------
  def create_actors
    @actor_sprites = []
    for i in 0...$game_party.max_battle_members
      @actor_sprites[i] = Sprite_Battler.new(@viewport1, $game_party.members[i])
    end
    @effect_sprites = Spriteset_Sideview.new(@viewport1)
  end
  #--------------------------------------------------------------------------
  # ● アクタースプライトの更新 ★再定義
  #--------------------------------------------------------------------------
  def update_actors
    @actor_sprites.each_with_index do |sprite, i|
      sprite_join($game_party.members[i], sprite) if sprite.battler == nil && sprite.battler != $game_party.members[i]
      sprite.remove if sprite.battler != nil && !sprite.removing && sprite.battler != $game_party.members[i]
      sprite.update
    end
    @effect_sprites.update
    update_program
  end
  #--------------------------------------------------------------------------
  # ● メンバーを加える
  #--------------------------------------------------------------------------
  def sprite_join(member, sprite)
    for sp in @actor_sprites
      sp.update_remove if member == sp.battler && !sp.battler.sv.change_up
    end
    sprite.join(member)
  end 
  #--------------------------------------------------------------------------
  # ● バトルプログラムの更新
  #--------------------------------------------------------------------------
  def update_program
    return if $sv_camera.program_scroll == []
    for data in  $sv_camera.program_scroll
      @back1_sprite.start_back_data(data) if data[2] == 1
      @back2_sprite.start_back_data(data) if data[2] == 2
    end
    $sv_camera.program_scroll = []
  end
  #--------------------------------------------------------------------------
  # ● ヒット時の戦闘アニメ実行
  #--------------------------------------------------------------------------
  def set_hit_animation(battler, weapon_index, hit_targets, miss)
    @effect_sprites.set_hit_animation(battler, weapon_index, hit_targets, miss)
  end
  #--------------------------------------------------------------------------
  # ● ダメージPOP
  #--------------------------------------------------------------------------
  def set_damage_pop(target)
    @effect_sprites.set_damage_pop(target)
  end
  #--------------------------------------------------------------------------
  # ● 解放
  #--------------------------------------------------------------------------
  alias dispose_spriteset_battle_n03 dispose
  def dispose
    dispose_spriteset_battle_n03
    @effect_sprites.dispose
  end
  
  
  
end


#==============================================================================
# ■ Window_BattleLog
#------------------------------------------------------------------------------
# 　戦闘の進行を実況表示するウィンドウです。
#==============================================================================
class Window_BattleLog < Window_Selectable
  #--------------------------------------------------------------------------
  # ● ウェイト ★再定義
  #--------------------------------------------------------------------------
  def wait
  end
  #--------------------------------------------------------------------------
  # ● ウェイトとクリア ★再定義
  #--------------------------------------------------------------------------
  def wait_and_clear
    $sv_camera.wait = 10
  end
  #--------------------------------------------------------------------------
  # ● 行動結果の表示 ★再定義
  #--------------------------------------------------------------------------
  def display_action_results(target, item)
    if target.result.used
      last_line_number = line_number
      display_critical(target, item)
      display_damage(target, item)
      display_affected_status(target, item)
      display_failure(target, item)
    end
    off if !N03::BATTLE_LOG
  end
  #--------------------------------------------------------------------------
  # ● ウインドウ非表示
  #--------------------------------------------------------------------------
  def off
    @back_sprite.visible = self.visible = false
  end
end
#==============================================================================
# ■ Game_Interpreter
#------------------------------------------------------------------------------
# 　イベントコマンドを実行するインタプリタです。
#==============================================================================
class Game_Interpreter
  #--------------------------------------------------------------------------
  # ● スイッチの操作
  #--------------------------------------------------------------------------
  alias command_121_game_interpreter_n03 command_121
  def command_121
    command_121_game_interpreter_n03
    $sv_camera.program_check
  end
end