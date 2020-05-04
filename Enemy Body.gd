extends KinematicBody2D

# Declare member variables here. Examples:
var spotDistance
export (int) var speed = 150
var detection
var target
var movement
# Called when the node enters the scene tree for the first time.
func _ready():
	spotDistance = (randi() % 250) + 100
	detection = get_node("Detection Area/CollisionShape2D")
	detection.get_shape().radius = spotDistance
	movement = Vector2(0,0)

func _physics_process(delta):
	if ( target != null && has_line_of_sight(target) ):
		movement = (target.global_position - self.global_position).normalized() * speed
	else:
		movement = Vector2(0,0)
	move_and_slide(movement)

func _on_Detection_Area_body_entered(body):
	
	if (body.is_in_group("players")): 
		target = body

func _on_Detection_Area_body_exited(body):
	if ( body == target ):
		target = null;
		
		
func has_line_of_sight(targetBody):
	var space = get_world_2d().direct_space_state
	if (targetBody != null):
		var obstacle = space.intersect_ray(global_position, targetBody.global_position, 
			[self], collision_mask)
		if (obstacle.collider == targetBody):
			return true
		else:
			return false
	
	
	
	
	
