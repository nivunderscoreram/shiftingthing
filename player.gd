extends CharacterBody2D


@export var speed = 0
@export var jump_velocity = 0
@export_enum("frog", "man") var character: String
var jump_dict = {"frog": -900, "man": -800 }
var speed_dict = {"frog": 350, "man": 450}


func _ready() -> void:
	
	character = "man"
	jump_velocity = jump_dict["man"]
	speed = speed_dict["man"]
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, false)
	
	
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
#	handle switching .
	if Input.is_action_just_pressed("switch") and character == "frog":
		character = "man"
		jump_velocity = jump_dict["man"]
		speed = speed_dict["man"]
		$AnimatedSprite2D.play("man_idle")
		set_collision_mask_value(2, false)
		set_collision_mask_value(1, true)
	elif Input.is_action_just_pressed("switch") and character == "man":
		character = "frog"
		$AnimatedSprite2D.play("frog_idle")
		jump_velocity = jump_dict["frog"]
		speed = speed_dict["frog"]
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
	
	#falling.		
	if not is_on_floor():
		velocity += get_gravity() * delta
		if character == "frog":
			$AnimatedSprite2D.play("frog_jump")
		else:
			$AnimatedSprite2D.play("man_jump")
	
	#handle jump.	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		
	# handle movement.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		
		if direction != 0 and is_on_floor() and character == "man":	
			$AnimatedSprite2D.play("man_move")
			
		elif direction != 0 and is_on_floor() and character == "frog":
			$AnimatedSprite2D.play("frog_move")
			
		if direction > 0:
			$AnimatedSprite2D.flip_h = true
		if direction < 0:
			$AnimatedSprite2D.flip_h = false
			
				
	elif not direction:
		velocity.x = move_toward(velocity.x, 0, speed)
	
		if is_on_floor() and character == "man":
			$AnimatedSprite2D.play("man_idle")
		elif is_on_floor() and character == "frog":
			$AnimatedSprite2D.play("frog_idle")
	

	move_and_slide()
