extends CharacterBody2D


@export var speed = 0
@export var jump_velocity = 0
@export_enum("frog", "man", "dagger") var character: String
var jump_dict = {"frog": -400, "man": -300, "dagger": -300}
var speed_dict = {"frog": 140, "man": 200, "dagger": 300}
var if_dagger = true
@onready var playetr: CollisionShape2D = $playercollison
@onready var knifte: CollisionShape2D = $knifecollison



func _ready() -> void:
	
	character = "man"
	jump_velocity = jump_dict["man"]
	speed = speed_dict["man"]
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, false)
	
	
func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
#	handle switching
	if Input.is_action_just_pressed("switch") and character != "man":
		character = "man"
		jump_velocity = jump_dict["man"]
		speed = speed_dict["man"]
		$AnimatedSprite2D.play("man_idle")
		set_collision_mask_value(2, false)
		set_collision_mask_value(1, true)
		knifte.set_deferred("disabled", true)
		playetr.set_deferred("disabled", false)
	elif Input.is_action_just_pressed("switch") and character == "man":
		character = "frog"
		$AnimatedSprite2D.play("frog_idle")
		jump_velocity = jump_dict["frog"]
		speed = speed_dict["frog"]
		set_collision_mask_value(1, false)
		set_collision_mask_value(2, true)
		knifte.set_deferred("disabled", true)
		playetr.set_deferred("disabled", false)
	# dagger switching
	if Input.is_action_just_pressed("dagger_switch") and character != "dagger" and if_dagger == true:
		character = "dagger"
		$AnimatedSprite2D.play("dagger")
		jump_velocity = jump_dict["dagger"]
		speed = speed_dict["dagger"]
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, true)
		knifte.set_deferred("disabled", false)
		playetr.set_deferred("disabled", true)
		
	# gravity	
	if not is_on_floor() and character != "dagger":
		velocity += get_gravity() * delta
		if character == "frog":
			$AnimatedSprite2D.play("frog_jump")
		else:
			$AnimatedSprite2D.play("man_jump")
	
	# handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
	elif Input.is_action_just_pressed("jump") and character == "dagger":
		velocity.y = jump_velocity
		await get_tree().create_timer(0.2).timeout
		velocity.y = 0
		
	if Input.is_action_just_pressed("down"):
		velocity.y = -jump_velocity
		await get_tree().create_timer(0.2).timeout
		velocity.y = 0
		
	# handle movement
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		
		
		if direction != 0 and is_on_floor() and character == "man":
			$AnimatedSprite2D.play("man_move")
		elif direction != 0 and is_on_floor() and character == "frog":
			$AnimatedSprite2D.play("frog_move")
			
			
		if direction > 0 and character != "dagger":
			$AnimatedSprite2D.flip_h = true
		elif direction > 0 and character == "dagger":
			$AnimatedSprite2D.flip_h = false
		
		if direction < 0 and character != "dagger":
			$AnimatedSprite2D.flip_h = false
		elif direction < 0 and character == "dagger":
			$AnimatedSprite2D.flip_h = true
			
	elif not direction:
		velocity.x = move_toward(velocity.x, 0, speed)
	
		if is_on_floor() and character == "man":
			$AnimatedSprite2D.play("man_idle")
		elif is_on_floor() and character == "frog":
			$AnimatedSprite2D.play("frog_idle")
	

	move_and_slide()
