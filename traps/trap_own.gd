extends RigidBody2D

signal hit_own 

var is_in_area = false
var key_pressed = false
var trap_owner = "Jec"
var key_binding

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_eco_player(is_eco):
	if is_eco:
		$Sprite2D.texture = load("res://sprites/Piege-eco-poser.png")
	else:
		$Sprite2D.texture = load("res://sprites/Piege_indu-poser.png")

func check_if_trapped():
	if is_in_area:
		hit_own.emit()
		print(is_in_area)
		#queue_free()

func _on_area_2d_body_entered(body):
	if (body.name == "Jec" || body.name == "Jin"):
			if trap_owner != body.name && key_pressed:
				is_in_area = true
				check_if_trapped()

func _on_area_2d_body_exited(body):
	if (body.name == "Jec" || body.name == "Jin"):
			if trap_owner != body.name && key_pressed:
				is_in_area = false
				check_if_trapped()

func set_trap_owner(is_jec):
	if is_jec:
		trap_owner = "Jec"
	else: 
		trap_owner = "Jin"
		
func set_keybinding(key):
	key_binding = key

func _input(event):
	if event is InputEventKey and event.pressed:
		key_pressed = event.keycode == key_binding
		wait(0.5)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
