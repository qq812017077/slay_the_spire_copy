class_name DungeonRoomScreen
extends Control

static func initialize():
	ShopUI.initialize()
	TreasureUI.initialize()
	CombatUI.initialize()

@export_group("Scene Prefabs")
@export var bottom_scene_prefab: PackedScene = null
@export var city_scene_prefab: PackedScene = null
@export var beyond_scene_prefab: PackedScene = null
@export var ending_scene_prefab: PackedScene = null
@export var monster_prefab: PackedScene = null
@export_group("")
@export var player_widget: PlayerWidget = null
@export var scene_container: Control = null
@export var cur_scene: AbstractScene = null
@export var monster_container: Control = null
@export var monster_widgets: Array[MonsterWidget] = []

@export_group("Campfire UI")
@export var campfire_ui: CampfireUI = null
@export_group("")
@export_group("Event")
@export var event_ui: EventUI = null
@export_group("")
@export_group("Shop UI")
@export var shop_ui: ShopUI = null
@export_group("")
@export_group("Treasure UI")
@export var treasure_ui: TreasureUI = null
@export_group("")

@export_group("Combat UI")
@export var combat_ui: CombatUI = null
@export_group("")

var dungeon: AbstractDungeons = null
var cur_room: AbstractRoom = null
var sprite_by_region: Dictionary = {}

# combat 
var is_combat_room: bool = false
var is_battle_over: bool = false
var skip_monster_turn: bool = false
var wait_timer: float = 0.0
var end_battle_timer: float = 0.0

func _ready() -> void:
	if scene_container == null:
		scene_container = self
	campfire_ui.hide_campfire_ui.connect(_on_campfire_finish)

	player_widget.visible = true
	
	# load_dungeon(Exordium.new(), IronClad.new())
	# load_room(TreasureRoom.new())

func _process(_delta: float) -> void:
	if cur_room == null:
		return
	match cur_room.phase:
		AbstractRoom.RoomPhase.COMBAT:
			update_combat(_delta)
		AbstractRoom.RoomPhase.EVENT:
			pass
		AbstractRoom.RoomPhase.INCOMPLETE:
			pass
		AbstractRoom.RoomPhase.COMPLETE:
			pass

func is_event_room() -> bool:
	return cur_room != null and (cur_room.type == AbstractRoom.RoomType.EVENT or cur_room.type == AbstractRoom.RoomType.NEOW)

func is_shop_room() -> bool:
	return cur_room != null and cur_room.type == AbstractRoom.RoomType.SHOP

func is_treasure_room() -> bool:
	return cur_room != null and cur_room.type == AbstractRoom.RoomType.TREASURE

func is_campfire_room() -> bool:
	return cur_room != null and cur_room.type == AbstractRoom.RoomType.REST

func is_boss_room() -> bool:
	return cur_room != null and cur_room.type == AbstractRoom.RoomType.BOSS

func is_elite_room() -> bool:
	return cur_room != null and cur_room.type == AbstractRoom.RoomType.ELITE

func load_dungeon(_dungeon: AbstractDungeons, _player: AbstractPlayer) -> void:
	if cur_scene != null:
		cur_scene.queue_free()
	
	dungeon = _dungeon
	player_widget.load(_player)
	combat_ui.load_player(_player)
	if dungeon.id == Exordium.ID:
		cur_scene = bottom_scene_prefab.instantiate()
	elif dungeon.id == TheCity.ID:
		cur_scene = city_scene_prefab.instantiate()
	elif dungeon.id == TheBeyond.ID:
		cur_scene = beyond_scene_prefab.instantiate()
	elif dungeon.id == TheEnding.ID:
		cur_scene = ending_scene_prefab.instantiate()

	# cur_scene.open_combat_room()
	scene_container.add_child(cur_scene)
	campfire_ui.initialize_buttons()

func load_room(_room: AbstractRoom) -> void:
	cur_room = _room
	is_combat_room = false
	combat_ui.close()
	campfire_ui.close()
	event_ui.close()
	shop_ui.close()
	treasure_ui.close()
	player_widget.reset()
	# cur_room = TreasureRoom.new()
	cur_room.on_player_entry()
	recycle_monsters()
	# print("cur_room.type:", AbstractRoom.RoomType.find_key(cur_room.type))
	# cur_room.type = AbstractRoom.RoomType.SHOP
	if cur_room.type == AbstractRoom.RoomType.NEOW:
		cur_scene.open_campfire_room()
		cur_scene.open_combat_room()
		player_widget.get_into_combat()
		cur_room.event = NeowEvent.new()
		event_ui.open(cur_room.event)
	elif cur_room.type == AbstractRoom.RoomType.REST:
		cur_scene.open_campfire_room()
		campfire_ui.open()
		if dungeon.id != TheEnding.ID:
			CardGame.music.silence_bgm()
		CardGame.sound.loop_play("REST_FIRE_WET")
		player_widget.get_into_campfire()
	elif cur_room.type == AbstractRoom.RoomType.EVENT:
		print("is event room")
		cur_room.event = dungeon.generate_event()
		event_ui.open(cur_room.event)
		cur_scene.open_event_room()
		player_widget.get_into_event()
	elif cur_room.type == AbstractRoom.RoomType.SHOP:
		cur_scene.refresh_scene()
		cur_scene.open_combat_room()
		player_widget.get_into_combat()
		shop_ui.open()
		var timer = get_tree().create_timer(2.0)
		timer.timeout.connect(end_room)
	elif cur_room.type == AbstractRoom.RoomType.TREASURE:
		cur_scene.refresh_scene()
		cur_scene.open_combat_room()
		player_widget.get_into_combat()
		treasure_ui.open(cur_room)
		var timer = get_tree().create_timer(2.0)
		timer.timeout.connect(end_room)
	elif cur_room.type == AbstractRoom.RoomType.EMPTY:
		cur_scene.refresh_scene()
		cur_scene.open_combat_room()
		player_widget.get_into_combat()
		cur_scene.close_effects()
	else:
		# combat room
		build_monsters(cur_room.monsters)
		wait_timer = 0.1
		cur_scene.refresh_scene()
		cur_scene.open_combat_room()
		apply_start_of_combat_logic()
		is_combat_room = true
		end_battle_timer = 0.25
		is_battle_over = false

	# if is_combat_room:
	# 	var combat_end_timer = get_tree().create_timer(1.0)
	# 	combat_end_timer.timeout.connect(end_battle)


func close_effects():
	# process_mode = Node.PROCESS_MODE_DISABLED
	if cur_room and cur_room.phase != AbstractRoom.RoomPhase.COMPLETE:
		cur_scene.hide_effects()

func open_effects():
	if cur_room and cur_room.phase != AbstractRoom.RoomPhase.COMPLETE:
		cur_scene.show_effects()

func _on_campfire_finish(delay_time: float = 2.0) -> void:
	CardGame.sound.fade_out("REST_FIRE_WET")

	cur_room.phase = AbstractRoom.RoomPhase.COMPLETE
	player_widget.shoulder.texture = player_widget.player.shoulder2_img
	CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button_delay(delay_time)
	if dungeon.id != TheEnding.ID:
		get_tree().create_timer(delay_time).connect("timeout", CardGame.music.unsilence_bgm)


func move_player_and_treasure_to_front() -> void:
	player_widget.z_index = Global.REWARD_FRONT_Z_INDEX
	treasure_ui.z_index = Global.REWARD_FRONT_Z_INDEX


func move_player_and_treasure_to_back() -> void:
	player_widget.z_index = Global.DEFAULT_Z_INDEX
	treasure_ui.z_index = Global.DEFAULT_Z_INDEX


func update_combat(delta: float) -> void:
	if Input.is_action_just_pressed("enter", true):
		print("enter pressed")
		is_battle_over = true
	if Input.is_action_just_pressed("space", true):
		print(("space pressed"))
		CardGame.dungeon_main_screen.add_game_effect(CombatStartEffect.create_player_turn_effect())
	
	if Input.is_action_just_pressed("dev_combat_ui_show", true):
		print("show combat ui")
		combat_ui.open()
	if Input.is_action_just_pressed("dev_combat_ui_close", true):
		print("close combat ui")
		combat_ui.close()

	for monster_widget: MonsterWidget in monster_widgets:
		monster_widget.monster.update_combat()
	
	if wait_timer > 0.0:
		if CardGame.action_manager.cur_action != null or not CardGame.action_manager.is_empty():
			CardGame.action_manager.update(delta)
		else:
			wait_timer -= delta
		
		if wait_timer <= 0.0:
			# CardGame.action_manager.turn_has_ended = true
			CardGame.dungeon_main_screen.add_game_effect(CombatStartEffect.create_player_turn_effect())
			show_health_bar()
			# CardGame.action_manager.add_to_bottom(GainEnergyAndEnableControlsAction.new(player_widget.player.energy_manager))
			CardGame.action_manager.add_to_bottom(DrawCardAction.new(player_widget.player, player_widget.player.master_hand_size))
			CardGame.action_manager.add_to_bottom(EnableEndTurnButtonAction.new())
			combat_ui.open()
			player_widget.player.apply_start_of_turn_logic()
	else:
		if Settings.is_debug and Input.is_action_just_pressed("draw_single_card", true):
			CardGame.action_manager.add_to_top(DrawCardAction.new(player_widget.player, 1))

		CardGame.action_manager.update(delta)
	
	if is_battle_over and CardGame.action_manager.is_empty():
		skip_monster_turn = false
		end_battle_timer -= delta
		if end_battle_timer <= 0:
			end_battle()

		 

func end_turn() -> void:
	# 结束回合
	pass


func end_battle() -> void:
	cur_scene.close_effects()
	cur_room.phase = AbstractRoom.RoomPhase.COMPLETE
	# add rewards
	var gold_reward: int = 0
	if is_boss_room():
		gold_reward = 100 + dungeon.miscRng.randi_range(-5, 5)
		if CardGame.dungeon_main_screen.ascension_level >= 13:
			gold_reward = int(gold_reward * 0.75)
	elif is_elite_room():
		gold_reward = CardGame.dungeon_main_screen.dungeon.treasureRng.randi_range(25,35)
	else:
		gold_reward = CardGame.dungeon_main_screen.dungeon.treasureRng.randi_range(10,20)
	
	CardGame.action_manager.clear()
	
	combat_ui.close()
	CardGame.dungeon_main_screen.combat_reward_screen.clear_rewards()
	CardGame.dungeon_main_screen.combat_reward_screen.add_gold_reward(gold_reward)
	var cards: Array[AbstractCard] = CardGame.dungeon_main_screen.get_reward_cards()
	CardGame.dungeon_main_screen.combat_reward_screen.add_card_reward(cards)
	CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.COMBAT_REWARD)
	CardGame.save_game()
	
func end_room() -> void:
	if cur_room.phase == AbstractRoom.RoomPhase.COMPLETE:
		return
	cur_scene.close_effects()
	cur_room.phase = AbstractRoom.RoomPhase.COMPLETE
	if cur_room.type == AbstractRoom.RoomType.SHOP:
		if CardGame.dungeon_main_screen.cur_screen == DungeonMainScreen.ScreenType.ROOM:
			CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button()
	elif cur_room.type == AbstractRoom.RoomType.TREASURE:
		if CardGame.dungeon_main_screen.cur_screen == DungeonMainScreen.ScreenType.ROOM:
			CardGame.dungeon_main_screen.overlay_menu.proceed_button.show_button()
	elif cur_room.type == AbstractRoom.RoomType.REST:
		campfire_ui._on_campfire_end(0.5)

func show_health_bar() -> void:
	print("show health bar")
	player_widget.health_bar.show_health_bar()

func show_monster_intent() -> void:
	print("show monster intent")

func apply_start_of_combat_logic() -> void:
	player_widget.get_into_combat()
	combat_ui.on_combat_start()


func build_monsters(monster_group: MonsterGroup) -> void:
	for monster: AbstractMonster in monster_group.monsters:
		print("monster name:" , monster.name)
		var monster_widget: MonsterWidget = MonsterWidget.allocate()

		monster_widget.load_monster(monster)


func recycle_monsters() -> void:
	for widget: MonsterWidget in monster_widgets:
		MonsterWidget.recycle(widget)
	monster_widgets.clear()
	

