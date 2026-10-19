extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var isAlive = true

@onready var Sprite: AnimatedSprite2D = $Sprite

func _physics_process(delta: float):
	if isAlive:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			Sprite.flip_h = false if direction >= 0 else true
			Sprite.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			Sprite.play("Idle")

		move_and_slide()

func takeDamage(value):
	Game.Health -= value
	Game.Health = clamp(Game.Health, 0, 100)
	Sprite.play("Hit")
	
	if Game.Health <= 0.0:
		isAlive = false
		Sprite.play("Death")
		await Sprite.animation_finished
		Game.resetGame()
		get_tree().reload_current_scene()
