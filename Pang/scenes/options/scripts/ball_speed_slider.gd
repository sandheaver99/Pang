extends HSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Ball_Speed_Slider_value_changed(value):
	var ball = get_tree().get_root().get_node("Screen/Ball")
	ball.MAXBALLSPEED = ball.MAXBALLSPEEDS[value-1]
	ball.ballspeed = ball.MAXBALLSPEED/2
