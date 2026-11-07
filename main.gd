extends Node

func _process(delta: float) -> void:
	if %player.character == "frog":
		%mantilemap.hide()
		%frogtilemap.show()
	else:
		%mantilemap.show()
		%frogtilemap.hide()
