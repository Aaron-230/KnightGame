extends CharacterBody2D

@export var SPEED: float = 200.0
@export var JUMP_VELOCITY: float = -200.0
@export var HEALTH_POINTS: float = 100.0
@export var DAMAGE: float = 10.0
@export var CoolTime: float = 1.5
@export var KnockbackRecovery: float = 10.0

@onready var WallDetectionLeft: RayCast2D = $Raycasts/WallDetectionLeft
@onready var WallDetectionRight: RayCast2D = $Raycasts/WallDetectionRight
@onready var CliffDetectionLeft: RayCast2D = $Raycasts/CliffDetectionLeft
@onready var CliffDetectionRight: RayCast2D = $Raycasts/CliffDetectionRight

@onready var Sprite: AnimatedSprite2D = $Sprite

var Knockback = Vector2.ZERO
var Target = null
var canAttack = false
var attackTimer = 0.0
var isAlive = true

func _physics_process(delta: float) -> void:
	if isAlive:
		if attackTimer > 0.0:
			attackTimer -= delta
		
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		if Target != null:
			Sprite.play("Run")
			var direction = (Target.global_position - global_position).normalized()
			velocity.x = direction.x * SPEED
			
			if direction.x <= 0:
				Sprite.flip_h = true
			else:
				Sprite.flip_h = false
			
			if canAttack and attackTimer <= 0.0:
				Target.takeDamage(DAMAGE)
				attackTimer = CoolTime
			
			if WallDetectionLeft.is_colliding() || WallDetectionRight.is_colliding():
				velocity.y = JUMP_VELOCITY
			
			if not CliffDetectionLeft.is_colliding() || not CliffDetectionRight.is_colliding():
				Sprite.play("Idle")
				velocity = Vector2.ZERO
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			Sprite.play("Idle")
		
		move_and_slide()

func takeDamage(value):
	if HEALTH_POINTS > 0.0:
		HEALTH_POINTS -= value
		Sprite.play("Hit")
		await Sprite.animation_looped
	else:
		isAlive = false
		canAttack = false
		Target = null
		Sprite.play("Death")
		await Sprite.animation_finished
		await get_tree().create_timer(1).timeout
		queue_free()

func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Target = body

func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		Target = null

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player" && body.has_method("takeDamage"):
		canAttack = true

func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "Player" && body.has_method("takeDamage"):
		canAttack = false
