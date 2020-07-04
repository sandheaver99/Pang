extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSlider_value_changed(value):
	text = str("Level: ", value)
	Global.ai_level = value
	#get_parent().get_parent().get_node("Ball_Speed_Slider").value = value
	#get_parent().get_parent().get_node("Paddle_Size_Slider").value = 11 - value
