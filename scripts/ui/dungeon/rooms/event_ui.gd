class_name EventUI
extends Control

@export var dialog_option_button_prefab: PackedScene = null
# @export var room_event_dialog: RoomEventDialog = null
@export var generic_event_dialog: GenericEventDialog = null
@export var room_event_dialog: RoomEventDialog = null

var cur_event: AbstractEvent = null
func _ready() -> void:
	# open(BigFish.new())
	pass


func open(event: AbstractEvent) -> void:
	visible = true
	cur_event = event
	generic_event_dialog.visible = false
	room_event_dialog.visible = false
	generic_event_dialog.clear_dialog()
	room_event_dialog.clear_dialog()
	if cur_event.type == AbstractEvent.EventType.IMAGE:
		generic_event_dialog.visible = true
		generic_event_dialog.load_image(cur_event.img)
		add_options(generic_event_dialog, cur_event.options)
		
		generic_event_dialog.show_dialog(cur_event.title, cur_event.body)
	elif cur_event.type == AbstractEvent.EventType.ROOM:
		room_event_dialog.visible = true
		cur_event.setup_to_room_event_dialog(room_event_dialog)
		add_options(room_event_dialog, cur_event.options)
		pass
	
func close() -> void:
	visible = false

func _on_option_button_click(option_button: DialogOptionButton) -> void:
	var result: OptionResult = cur_event.on_option_selected(option_button.slot)

	if result == null:
		push_error("No result for option: " + str(option_button.slot))
	else:
		if result.return_map:
			# room_event_dialog.close()
			CardGame.dungeon_main_screen.show_map()
		else:
			if cur_event.type == AbstractEvent.EventType.IMAGE:
				if result.img != null:
					generic_event_dialog.load_image(result.img)
				generic_event_dialog.update_body_text(result.body)
				generic_event_dialog.clear_dialog_options()
				add_options(generic_event_dialog, result.options)
			elif cur_event.type == AbstractEvent.EventType.ROOM:
				room_event_dialog.clear_dialog_options()
				add_options(room_event_dialog, result.options)
			else:
				push_error("Invalid event type: " + str(cur_event.type))
		if cur_event.is_finished():
			CardGame.dungeon_main_screen.dungeon_room_screen.cur_room.phase = AbstractRoom.RoomPhase.COMPLETE


func add_options(event_dialog: EventDialog, options: Array) -> void:
	print(" options,", options)
	for option: String in options:
		var option_button: DialogOptionButton = dialog_option_button_prefab.instantiate()
		event_dialog.add_dialog_option(option_button)
		option_button.init_button(option)
		option_button.btn.pressed.connect(_on_option_button_click.bind(option_button))
	
	event_dialog.refresh_dialog_options_positions()
