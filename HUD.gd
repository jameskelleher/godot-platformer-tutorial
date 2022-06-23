extends CanvasLayer

var coins = 0

func update_coin_count():
	$Coins.text = String(coins)


func _ready():
	update_coin_count()


func _on_coin_collected():
	coins += 1
	update_coin_count()
	
	if coins == 3:
		var _new_scene = get_tree().change_scene("res://Level1.tscn")

