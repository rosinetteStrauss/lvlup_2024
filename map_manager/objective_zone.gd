extends Area2D

var associated_player_is_eco

var eco
var on_me = false
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = false
	timer.wait_time = 2
	timer.connect("timeout", self.go_to_trash)
	timer.stop()
	add_child(timer)
	pass # Replace with function body.

func is_eco():
	return eco

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func objectiv_for_eco():
	return associated_player_is_eco


func _on_body_entered(body):
	if body.name == "Jec" and is_eco():
		on_me = true
		body.start_timer()
		timer.start()
	if body.name == "Jin" and not(is_eco()):
		on_me = true
		body.start_timer()
		timer.start()


func _on_body_exited(body):
	if body.name == "Jec" and is_eco():
		on_me = false
		body.reset_timer()
		timer.stop()
	if body.name == "Jin" and not(is_eco()):
		on_me = false
		body.reset_timer()
		timer.stop()


func _on_jec_objective_complete(target):
	pass


func _on_jin_objective_complete(target):
	pass

func go_to_trash():
	$Sprite2D.visible = false
	$CollisionShape2D.disabled = true
	queue_free()
