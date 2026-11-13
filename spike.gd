extends Node2D

@export var speed = 100
var direction = 0
@onready var right: RayCast2D = $raycastright
@onready var left: RayCast2D = $raycastleft



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if right.is_colliding():
		queue_free()
	
	if left.is_colliding():
		queue_free()
