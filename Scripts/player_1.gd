extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("down") and is_on_floor():
		animated_sprite_2d.play("Sit")
	#Gets the input direction: -1 0 1
	
	var direction := Input.get_axis("move_left", "move_right")
	#here if direction positive i.e +1 then direction is same(right facing)
	if direction>0:
		animated_sprite_2d.flip_h=false
	#if direction is -1 or <0  then direction is flipped(left facing)
	elif direction<0:
		animated_sprite_2d.flip_h=true 
	#animations
	if is_on_floor():	
		if direction==0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("Run")		
	else:
		animated_sprite_2d.play("jump")			
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
