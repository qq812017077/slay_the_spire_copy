class_name AbstractEvent
extends Object

enum EventType {TEXT, IMAGE, ROOM, NEOW}

var type: EventType
var img: Texture2D
var title: String
var body: String

var options: Array[String] = []

func _init(_type: EventType, _title: String, _body: String, _img: Texture2D) -> void:
	self.type = _type
	self.title = _title
	self.body = _body
	self.img = _img

func is_finished() -> bool:
	return false

func clear() -> void:
	pass

func init_room_event(_room_event_dialog: RoomEventDialog) -> void:
	pass

func on_option_selected(_option_slot: int) -> OptionResult:
	return null

func open_map() -> void:
	pass

func setup_to_room_event_dialog(_room_event_dialog: RoomEventDialog) -> void:
	pass