extends CharacterBody2D

var screen_size

@export var active_at_start = true
var currently_active
var current_velocity
var current_gravity
var jumping = false
@export var speed = 20
@export var gravity = 1
@export var friction = 0.7

var trap_own_template
@export var max_trap_own = 3
var available_trap_own

var is_in_objective_zone = false
var is_player_active = false
@export var is_jec = true

@export var time_to_validate_objective = 10.0
var countdown_timeout = 1
var timer = Timer.new()

signal objective_complete
var current_objective

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = false
	timer.one_shot = false
	timer.wait_time = time_to_validate_objective
	timer.connect("timeout", self.objective_validated)
	timer.stop()
	add_child(timer)
	available_trap_own = max_trap_own
	trap_own_template = get_node("trap_own")
	trap_own_template.visible = false
	current_velocity = Vector2.ZERO
	current_gravity = 0
	currently_active = active_at_start
	screen_size = get_viewport_rect().size
	$trap_own.is_eco_player(true)
	manage_visibility(currently_active)

func manage_visibility(is_active):
	if is_active:
		show()
		position = Vector2(115,250)
		is_player_active = true
		$CollisionShape2D.disabled = false
	else:
		hide()
		is_player_active = false
		$CollisionShape2D.disabled = true

func _process(delta):
	if is_player_active:
		if jumping:
			jumping = false
		elif is_on_floor():
			$AnimatedSprite2D.animation = "eco_walk"
			current_gravity = 0.1
			current_velocity.y = 0
		else:
			current_gravity = gravity
			$AnimatedSprite2D.animation = "eco_jump"
		current_velocity.x = (current_velocity.x * (1-friction))
		current_velocity.y += current_gravity
		position += current_velocity
			
		if abs(current_velocity.x) > 0.001 || abs(current_velocity.y) > 0.2:
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
		
		# prevent movement exceed screen    
		position = position.clamp(Vector2.ZERO, screen_size)
		   
		move_and_slide()

func move(left, right, jump):
	if left == 1:
		$AnimatedSprite2D.flip_h = true
		current_velocity.x -= speed
	if right == 1:
		$AnimatedSprite2D.flip_h = false
		current_velocity.x += speed
	if jump == 1 and is_on_floor():
		current_velocity.y -= speed
		jumping = true

func deploy_trap():
	if available_trap_own > 0:
		available_trap_own -= 1
		var t = trap_own_template.duplicate()
		t.set_global_position(global_position)
		get_tree().root.add_child(t)
		t.scale = Vector2(1,1)
		t.visible = true

func _on_input_manager_move_jec(left, right, jump):
	move(left, right, jump)

func _on_input_manager_move_jin(left, right, jump):
	move(left, right, jump)

func _on_input_manager_land_trap_jec():
	deploy_trap()

#signal body_entered Objective_zone
func _on_objective_zone_body_entered(body):
	is_in_objective_zone = true
	current_objective = body
	start_timer()

#signal body_exited Objective_zone
func _on_objective_zone_body_exited(body):
	is_in_objective_zone = false
	current_objective = null
	reset_timer()

func start_timer():
	timer.start()

func reset_timer():
	timer.stop()

func objective_validated():
	timer.stop()
	emit_signal("objective_complete")
