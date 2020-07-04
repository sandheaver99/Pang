extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Win_Score_Slider_value_changed(value):
	text = str(value)
	get_tree().get_root().get_node("Screen/Ball").winning_score = value
