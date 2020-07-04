extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect/AnimationPlayer.play("Fade")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(_anim_name):
	self.queue_free()
