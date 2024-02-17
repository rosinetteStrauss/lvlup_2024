extends CharacterBody2D

@export var active_at_start = true
var currently_active
var current_velocity
var current_gravity
@export var speed = 20
@export var gravity = 1
@export var friction = 0.9

var trap_own_template

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
	position += current_velocity
	current_velocity.x = (current_velocity.x * (1-friction))
	current_velocity.y += current_gravity
	if is_on_floor():
		current_gravity = 0
	else:
		current_gravity = gravity
	move_and_slide()
	

func move(left, right, jump):
	if left == 1:
		current_velocity.x -= speed
	if right == 1:
		current_velocity.x += speed
	if jump == 1 and is_on_floor():
		current_velocity.y -= speed

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
