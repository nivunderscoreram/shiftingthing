extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -400.0
@export var health = 100
@export var attackable = false


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	move_and_slide()

func attack():
	$AnimatedSprite2D.play("staffslamattack")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if attackable == true:
		if health > 0:
			$AnimatedSprite2D.play("hurt")
			health -= 34
			%hurttimer.start()
			if health <= 0:
				health = 0
				$AnimatedSprite2D.play("death")

func _on_hurttimer_timeout() -> void:
		$AnimatedSprite2D.play("idle")
		%hurttimer.stop()


func _on_jumptimer_timeout() -> void:
	if is_on_floor():
		velocity.y = jump_velocity
		var direction := randf_range(-1.0, 1.0)
		if direction:
			velocity.x = direction * speed
			if is_on_floor():
				attack()
				$attacktimer.start()
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			


func _on_attacktimer_timeout() -> void:
	attack()
