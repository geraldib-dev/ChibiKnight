extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var hurt_sfx = $HurtSFX
@onready var jump_sfx = $JumpSFX
@onready var game_manager = %GameManager

var isAlive = true
var playDeathAnimation = true

func die():
	isAlive = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
			
	if isAlive:
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_sfx.play()

		# Handle movement:
		var direction = Input.get_axis("ui_left", "ui_right")
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		#Animations
		if direction == 1:
			animated_sprite_2d.flip_h = false
		if direction == -1:
			animated_sprite_2d.flip_h = true
			
		if !is_on_floor():
			animated_sprite_2d.play("roll")
		elif direction and is_on_floor():
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")	
	elif(!isAlive and playDeathAnimation and is_on_floor()): 
		hurt_sfx.play()
		animated_sprite_2d.play("death")
		playDeathAnimation = false

	move_and_slide()

