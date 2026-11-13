extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if %player.character == "dagger":
		%boss.attackable = true
	else:
		%boss.attackable = false
		
	if %player.character == "frog":
		%mantilemap.hide()
		%manskytile.hide()
		%frogtilemap.show()
		%frogskytile.show()
	else:
		%mantilemap.show()
		%manskytile.show()
		%frogtilemap.hide()
		%frogskytile.hide()
