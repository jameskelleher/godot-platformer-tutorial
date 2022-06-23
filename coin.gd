extends Area2D

signal coin_collected

func _on_coin_body_entered(_body):
	set_deferred("monitoring", false)
	$CollisionShape2D.disabled = true
	$AnimationPlayer.play("bounce")
	emit_signal("coin_collected")


func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
