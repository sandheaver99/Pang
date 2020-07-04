extends Node

var power_up = preload("res://scenes/powerup/PowerUp.tscn")
var slow_process_time = 5
var time_elapsed = 0
var game_running = false
var power_ups = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("start"):
		#$Labels.visible = false
		game_running = true
		get_parent().get_node("PangLogo/AnimationPlayer").play("Fade")
		get_parent().get_node("Manager/Labels/F1Start/AnimationPlayer2").play("Fade")
		get_parent().get_node("Manager/Labels/F2Options/AnimationPlayer3").play("Fade")
		get_parent().get_node("Ball").start()
	if Input.is_action_pressed("options"):
		$Labels/F2Options/Options.popup()
	
	time_elapsed += delta
	if time_elapsed > slow_process_time:
		time_elapsed = 0
		slow_process()

func slow_process():
	if(power_ups):
		var power_up_count = get_tree().get_nodes_in_group("powerups").size()
		if Global.scores[1] > Global.scores[0]:
			if randf() < 0.75 and power_up_count == 0 and game_running:
				var new_power_up = power_up.instance()
				var x = rand_range(140,700)
				var y = rand_range(140,620)
				new_power_up.position= Vector2(x, y)
				add_child(new_power_up)
	
