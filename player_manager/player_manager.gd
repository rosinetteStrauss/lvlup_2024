extends CharacterBody2D

@export var active_at_start = true
var currently_active
var current_velocity
var current_gravity
var jumping = false
@export var speed = 20
@export var gravity = 1
@export var friction = 0.7

var trap_own_template

var is_in_objective_zone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	trap_own_template = get_node("trap_own")
	trap_own_template.visible = false
	current_velocity = Vector2.ZERO
	current_gravity = gravity
	currently_active = active_at_start
	manage_visibility()

func manage_visibility():
	if currently_active:
		show()
		$CollisionShape2D.disabled = false
	else:
		hide()
		$CollisionShape2D.disabled = true

func _process(delta):
	if jumping:
		jumping = false
	elif is_on_floor():
		current_gravity = 0.1
		current_velocity.y = 0
	else:
		current_gravity = gravity
	current_velocity.x = (current_velocity.x * (1-friction))
	current_velocity.y += current_gravity
	position += current_velocity
	move_and_slide()
	

func move(left, right, jump):
	if left == 1:
		current_velocity.x -= speed
	if right == 1:
		current_velocity.x += speed
	if jump == 1 and is_on_floor():
		current_velocity.y -= speed
		jumping = true

func deploy_trap():
	var t = trap_own_template.duplicate()
	t.set_global_position(global_position)
	get_tree().root.add_child(t)
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
	print(is_in_objective_zone)

#signal body_exited Objective_zone
func _on_objective_zone_body_exited(body):
	is_in_objective_zone = false
	print(is_in_objective_zone)
