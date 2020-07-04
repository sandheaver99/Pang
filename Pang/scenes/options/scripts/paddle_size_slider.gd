extends HSlider



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Paddle_Size_Slider_value_changed(value):
	var paddle_left = get_tree().get_root().get_node("Screen/PaddleLeft")
	var paddle_right = get_tree().get_root().get_node("Screen/PaddleRight")
	var paddles = [paddle_left, paddle_right]
	for paddle in paddles:
		paddle.y_height = paddle.paddle_sizes[value-1]
		paddle.resize(paddle.x_width, paddle.y_height)
	
