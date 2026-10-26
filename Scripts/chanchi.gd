extends Area2D

@export var suelo_y: float = 600.0
@export var tipo = "chanchi"
@export var orden = 3

const GRAVEDAD = 1500.0

var arrastrando = false
var cayendo = false
var velocidad = 0.0
var offset = Vector2.ZERO
var es_original = true          
var pos_inicial = Vector2.ZERO  

func _ready():              
	pos_inicial = global_position
	$Chanchi.visible = true
	$Baconnn.visible = false

	
func _ya_esta():
	var olla = get_tree().get_first_node_in_group("olla")
	if olla == null:
		return
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
	# Se ejecuta cuando hay un evento de mouse SOBRE este nodo
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed\
			and _ya_esta() == false:
		arrastrando = true
		$Chanchi.visible = false
		$Baconnn.visible = true
		
		if es_original:
			es_original = false
			_crear_copia.call_deferred()
		cayendo = false
		velocidad = 0.0
		offset = global_position - get_global_mouse_position()
		z_index = 10


func _input(event):
	# Se ejecuta con CUALQUIER evento, esté el mouse donde esté
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and not event.pressed \
			and arrastrando:
		arrastrando = false
		cayendo = true
		z_index = 0


func _process(delta):
	var olla = get_tree().get_first_node_in_group("olla")
	if olla.contador != orden:
		input_pickable = false
	else:
		input_pickable = true
	if arrastrando:
		global_position = get_global_mouse_position() + offset
	elif cayendo:
		input_pickable = false
		velocidad += GRAVEDAD * delta
		global_position.y += velocidad * delta
		if global_position.y > 800:   # un poco más abajo del borde de la pantalla
			queue_free()
