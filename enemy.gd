extends KinematicBody2D

export(int, "left", "right") var initial_direction
export var detects_cliffs = true

var velocity = Vector2()
var direction = 0


func set_floor_checker():
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs


func turn_around():
	direction *= -1
	$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	set_floor_checker()


func should_turn_around():
	return (
		is_on_wall()
		or not $floor_checker.is_colliding()
			and is_on_floor()
			and detects_cliffs
	)


func _ready():
	if initial_direction:
		direction = 1
		$AnimatedSprite.flip_h = true
	else:
		direction = -1
		
#	Engine.time_scale = 1.0/20
	
	set_floor_checker()


func _physics_process(_delta):
	
	if should_turn_around():
		turn_around()
	
	velocity.y += 20
	velocity.x = 50 * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("squashed")
	print(name + " squashed by:")
	print(body.name)
	print()
