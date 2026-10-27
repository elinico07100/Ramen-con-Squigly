extends Area2D

@export var suelo_y: float = 600.0
@export var tipo = "huevo"
@export var orden = 0

const GRAVEDAD = 1500.0

var velo = Vector2.ZERO 
var arrastrando = false
var cayendo = false
var offset = Vector2.ZERO
var es_original = true          
var pos_inicial = Vector2.ZERO  


func _ready():      
	pos_inicial = global_position
	$AnimatedSprite2D.visible = false
	$PixelArtChickenNestAndEggsPng.visible = true
	

func _ya_esta():
	var olla = get_tree().get_first_node_in_group("olla")
	if olla == null:
		return false
	for ing in olla.ingredientes:
		if ing == tipo:
			return true
	return false


func _crear_copia():           
	var copia = load(scene_file_path).instantiate()
	get_parent().add_child(copia)
	copia.global_position = pos_inicial
	copia.pos_inicial = pos_inicial


func _input_event(_viewport, event, _shape_idx):
	var squigly = get_tree().get_first_node_in_group("squigly")
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed\
			and _ya_esta() == false:
		arrastrando = true
		$PixelArtChickenNestAndEggsPng.visible = false
		$AnimatedSprite2D.visible = true
		 
		if es_original:
			es_original = false
			_crear_copia.call_deferred()
		cayendo = false
		velo = Vector2.ZERO # Reseteamos el vector de velocidad al agarrarlo
		offset = global_position - get_global_mouse_position()
		z_index = 10
	var olla = get_tree().get_first_node_in_group("olla")
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		if _ya_esta()== true or olla.contador != orden:
			squigly.golpear()
			await squigly.anim.animation_finished 
			squigly.anim.play("squigly")
	
		
	
		
	
	
			

func _input(event):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and not event.pressed\
			and arrastrando:
		arrastrando = false
		cayendo = true
		z_index = 0


func _process(delta):
	
			
	if arrastrando:
		global_position = get_global_mouse_position() + offset
	elif cayendo:
		input_pickable = false
		
		
		velo.y += GRAVEDAD * delta
		global_position += velo * delta 
		
		if global_position.y > 800:
			queue_free()
			

func saltito():
	velo = Vector2(400, -1000) 
