extends KinematicBody2D
class_name player
signal hit

# Declare member variables here. Examples:
var dir = Vector2()
var velocity = Vector2()
export (int) var speed = 200
var screenSize
var collisionObject

var UP = 0
var DOWN = 0
var LEFT = 0
var RIGHT = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	add_to_group( "players", true)
	connect("hit",self,"_on_Enemy_hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	UP = 0
	DOWN = 0
	LEFT = 0
	RIGHT = 0
	
	if Input.is_key_pressed(KEY_W):
		UP = 1
	if Input.is_key_pressed(KEY_S):
		DOWN = 1
	if Input.is_key_pressed(KEY_A):
		LEFT = 1
	if Input.is_key_pressed(KEY_D):
		RIGHT = 1
	
	dir.x = (RIGHT - LEFT)
	dir.y = (DOWN - UP)
	
	velocity = dir.normalized() * speed
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	#position += velocity * delta;
	collisionObject = move_and_slide(velocity)
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	
	#Animation State Machine	
	if dir == Vector2(0,-1):
		$AnimatedSprite.animation = "up"
	if dir == Vector2(0,1):
		$AnimatedSprite.animation = "down"
	if dir == Vector2(-1,0):
		$AnimatedSprite.animation = "left"
	if dir == Vector2(1,0):
		$AnimatedSprite.animation = "right"
	
	if dir == Vector2(1,-1):
		$AnimatedSprite.animation = "up-right"
	if dir == Vector2(1,1):
		$AnimatedSprite.animation = "down-right"
	if dir == Vector2(-1,1):
		$AnimatedSprite.animation = "down-left"
	if dir == Vector2(-1,-1):
		$AnimatedSprite.animation = "up-left"
	
#func _on_Enemy_hit():
	#if collisionObject is get_node("Game/Enemy"):
		
	