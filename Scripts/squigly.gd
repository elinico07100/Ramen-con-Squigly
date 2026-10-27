extends RigidBody2D

@export var tipo = "squigly"
@onready var anim = $AnimatedSprite2D
var mouse_anchor: StaticBody2D
var joint: PinJoint2D

var arrastrando = false


func _ready() -> void:
	anim.play("squigly")
	
	mouse_anchor = StaticBody2D.new()
	
	get_parent().call_deferred("add_child", mouse_anchor)
	
	joint = PinJoint2D.new()
	mouse_anchor.add_child(joint)
	
	joint.disable_collision = true
	
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			arrastrar()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed and arrastrando:
			detener_arrastre()
		
func arrastrar():
	arrastrando = true
	mouse_anchor.global_position = get_global_mouse_position()
	joint.node_a = mouse_anchor.get_path()
	joint.node_b = get_path()
	
func _process(delta: float) -> void:
	if arrastrando:
		mouse_anchor.global_position = get_global_mouse_position()
		
func detener_arrastre() -> void:
	arrastrando = false
	
	joint.node_a = NodePath("")
	joint.node_b = NodePath("")

func golpear():
	anim.play("Golpe")
	
func quemao():
	linear_velocity = Vector2(300, -800)
