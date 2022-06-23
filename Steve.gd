extends KinematicBody2D

var velocity = Vector2(0, 0)

const SPEED = 250
const GRAVITY = 35
const JUMPFORCE = -1100


func _physics_process(_delta):
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = true
	elif Input.is_action_pressed("crouch"):
		$Sprite.play("crouch")
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			position.y += 1
	else:
		$Sprite.play("idle")
	
	if not is_on_floor():
		$Sprite.play("air")
		
	velocity.y = velocity.y + GRAVITY
	
	if Input.is_action_just_pressed("jump") and not Input.is_action_pressed("crouch") and is_on_floor():
		velocity.y = JUMPFORCE
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.2)
	

func _on_Fallzone_body_entered(_body):
	return get_tree().change_scene("res://Level1.tscn")
