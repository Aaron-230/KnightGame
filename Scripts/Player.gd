extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var AttackDamage = 50.0
@export var KnockbackRecovery = 100.0

var isAlive = true
var swordDirection = "Swing-Forward"
var Target = null

@onready var Sprite: AnimatedSprite2D = $Sprite
@onready var Sword: AnimationPlayer = $AttackArea/Animation

func _physics_process(delta: float):
	if isAlive:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("Jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("Attack"):
			if Target != null:
				Target.takeDamage(AttackDamage)
			Sword.play(swordDirection)
			await Sword.animation_finished
			await get_tree().create_timer(0.1).timeout
			Sword.stop()

		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
			Sprite.flip_h = false if direction >= 0 else true
			$AttackArea/Sword.flip_h = false if direction >= 0 else true
			swordDirection = "Swing-Forward" if direction >= 0 else "Swing-Reverse"
			$AttackArea/CollisionShape.position.x = abs($AttackArea/CollisionShape.position.x) if direction == 1 else -abs($AttackArea/CollisionShape.position.x)
			Sprite.play("Run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			Sprite.play("Idle")

		move_and_slide()

func takeDamage(value):
	if isAlive:
		Game.Health -= value
		Game.Health = clamp(Game.Health, 0, 100)
		Sprite.play("Hit")
	
	if Game.Health <= 0.0:
		isAlive = false
		Sprite.play("Death")
		await Sprite.animation_finished
		await get_tree().create_timer(1).timeout
		Game.resetGame()
		get_tree().reload_current_scene()

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.has_method("takeDamage") and body.name != "Player":
		Target = body

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.has_method("takeDamage") and body.name != "Player":
		Target = body
