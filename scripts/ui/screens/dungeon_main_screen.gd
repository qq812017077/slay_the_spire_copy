class_name DungeonMainScreen
extends Control


static var ui_string: UIString = null
static var TEXT: Array = []

enum ScreenType {NONE, ROOM, MASTER_DECK_VIEW, SMITH_DECK_VIEW, PURGE_DECK_VIEW, SETTINGS, INPUT_SETTINGS, GRID, MAP,
	FTUE, CHOOSE_ONE, HAND_SELECT, SHOP, COMBAT_REWARD, CARD_SELECT_REWARD, BOSS_REWARD,
	DISCARD_VIEW, EXHAUST_VIEW, GAME_DECK_VIEW, DEATH,
	TRANSFORM, VICTORY, UNLOCK, DOOR_UNLOCK, CREDITS, NO_INTERACT, NEOW_UNLOCK}

const MAP_HEIGHT = 15
const MAP_WIDTH = 7
const MAP_DENSITY = 6
const FINAL_ACT_MAP_HEIGHT = 3
var dungeon: AbstractDungeons
var player: AbstractPlayer
var is_ascension_mode: bool = false
var ascension_level: int = 0
var floor_num: int = 0
var play_time: float = 0.0

var cur_screen: ScreenType = ScreenType.NONE
var pre_screen: ScreenType = ScreenType.NONE
var pre_room_phase: AbstractRoom.RoomPhase = AbstractRoom.RoomPhase.INCOMPLETE
var pre_black_mask_state: BlackMask.FadeState = BlackMask.FadeState.IDLE

@export_group("Screen")
@export var dungeon_room_screen: DungeonRoomScreen = null
@export var combat_reward_screen: CombatRewardScreen = null
@export var card_select_reward_screen: CardSelectRewardScreen = null
@export var boss_relic_reward_screen: BossRelicSelectScreen = null
@export var dungeon_map_screen: DungeonMapScreen = null
@export var dungeon_transition_screen: DungeonTransitionScreen = null
@export var dungeon_shop_screen: ShopScreen = null
@export var dungeon_deck_screen: DeckViewScreen = null
@export_group("")
@export var top_panel: TopPanel = null
@export var overlay_menu: OverlayMenu = null
@export var game_effect_container: Control = null
@export var particle_effect_container: Control = null

var game_effect_list: Array[AbstractGameEffect] = []
var particle_effect_list: Array[AbstractParticleEffect] = []

var scroll_anim: bool = false

# card pool
var colorless_card_pool: CardGroup = CardGroup.new(CardGroup.CardGroupType.CARD_POOL)
var common_card_pool: CardGroup = CardGroup.new(CardGroup.CardGroupType.CARD_POOL)
var uncommon_card_pool: CardGroup = CardGroup.new(CardGroup.CardGroupType.CARD_POOL)
var rare_card_pool: CardGroup = CardGroup.new(CardGroup.CardGroupType.CARD_POOL)
var curse_card_pool: CardGroup = CardGroup.new(CardGroup.CardGroupType.CARD_POOL)

var card_blizz_start_offset: int = 5
var card_blizz_randomizer: int = card_blizz_start_offset
var card_blizz_growth: int = 1
var card_blizz_max_offset: int = -40


static func initialize():
	ui_string = CardGame.languagePack.get_ui_string("AbstractDungeon")
	TEXT = ui_string.TEXT
	
	DungeonMapScreen.initialize()
	DungeonTransitionScreen.initialize()
	DungeonRoomScreen.initialize()
	ShopScreen.initialize()
	Legend.initialize()
	CombatRewardScreen.initialize()
	CardSelectRewardScreen.initialize()
	BossRelicSelectScreen.initialize()
	RewardItemWidget.initialize()
	DeckViewScreen.initialize()

func _ready() -> void:
	set_z_order()
	CardGame.dungeon_main_screen = self
	# load_new_dungeon(Exordium.ID, IronClad.ID)
	pre_black_mask_state = CardGame.black_mask.state
	
	overlay_menu.cancel_button.button.pressed.connect(on_cancel_button_click)
	overlay_menu.confirm_button.button.pressed.connect(on_confirm_button_click)
	overlay_menu.proceed_button.button.pressed.connect(on_proceed_click)
	overlay_menu.proceed_button.button.mouse_entered.connect(_on_proceed_button_mouse_entered)

func _process(_delta: float) -> void:
	_update_fading()
	_update_room_state()
	_update_effects()

	play_time += _delta

func _update_fading() -> void:
	if pre_black_mask_state != CardGame.black_mask.state:
		match CardGame.black_mask.state:
			BlackMask.FadeState.IDLE:
				# get into idle state
				CardGame.enable_button_input()
			BlackMask.FadeState.FADING_IN:
				# get into fading in state
				CardGame.disable_button_input()
			BlackMask.FadeState.FADING_OUT:
				pass
			BlackMask.FadeState.BLACK:
				pass

	pre_black_mask_state = CardGame.black_mask.state

func _update_room_state() -> void:
	if dungeon == null:
		return
	var cur_room_node: MapRoomNode = dungeon.cur_room_node
	if pre_room_phase != cur_room_node.room.phase:
		match cur_room_node.room.phase:
			AbstractRoom.RoomPhase.COMBAT:
				print("in combat...")
				# CardGame.dungeon_main_screen.open_screen(DungeonMainScreen.ScreenType.COMBAT)
			AbstractRoom.RoomPhase.EVENT:
				print("in event...")
			AbstractRoom.RoomPhase.INCOMPLETE:
				print("in incomplete...")
			AbstractRoom.RoomPhase.COMPLETE:
				print("in complete...")
				dungeon_map_screen.finish_cur_room_node()
	pre_room_phase = cur_room_node.room.phase
	# if cur_room_node.room.phase != AbstractRoom.RoomPhase.COMPLETE:
	# 	cur_room_node.room.phase = AbstractRoom.RoomPhase.COMPLETE

func _update_effects() -> void:
	var i = game_effect_list.size() - 1
	while i >= 0:
		var effect: AbstractGameEffect = game_effect_list[i]
		if effect.is_done:
			game_effect_list.remove_at(i)
			if not effect.can_recycle:
				effect.queue_free()
		i -= 1

	i = particle_effect_list.size() - 1
	while i >= 0:
		var effect: AbstractParticleEffect = particle_effect_list[i]
		if effect.is_done:
			particle_effect_list.remove_at(i)
			effect.queue_free()
		i -= 1

func load_new_dungeon(dungeon_id: String, player_id: String, _ascension_level: int = 0) -> void:
	if dungeon_id == Exordium.ID:
		dungeon = Exordium.new()
	elif dungeon_id == TheCity.ID:
		dungeon = TheCity.new()
	elif dungeon_id == TheBeyond.ID:
		dungeon = TheBeyond.new()
	elif dungeon_id == TheEnding.ID:
		dungeon = TheEnding.new()

	if player_id == IronClad.ID:
		player = IronClad.new()
	elif player_id == TheSilent.ID:
		player = TheSilent.new()
	elif player_id == Defect.ID:
		player = Defect.new()
	elif player_id == Watcher.ID:
		player = Watcher.new()
	
	set_ascension_level(_ascension_level)
	player.initialize_starting_deck()
	top_panel.load_data(self, player)
	CardGame.cur_dungeon = dungeon

	if CardGame.black_mask.is_idle():
		print("fade in instant")
		CardGame.black_mask.fade_in_instant()
	
	# initialize
	initialize_card_pool()
	dungeon_room_screen.load_dungeon(dungeon, player)
	dungeon_map_screen.load_map(dungeon)
	CardGame.music.change_bgm(dungeon.id)
	await get_tree().create_timer(1).timeout
	
	while CardGame.black_mask.is_fading():
		await get_tree().create_timer(0.5).timeout
	
	if CardGame.black_mask.is_black():
		CardGame.black_mask.fade_out()
	scroll_anim = dungeon.cur_room_node.room.type == AbstractRoom.RoomType.EMPTY
	
	dungeon_transition_screen.open(CardGame.cur_dungeon.id)
	
	if dungeon.cur_room_node.room is NeowRoom:
		open_screen(ScreenType.MAP, true)
		dungeon_map_screen.close(true)
		overlay_menu.cancel_button.hide_button()
		open_screen(ScreenType.ROOM)
	else:
		open_screen(ScreenType.ROOM)
		open_screen(ScreenType.MAP, true)
	play_time = 0.0
	pre_room_phase = AbstractRoom.RoomPhase.INCOMPLETE

func load_next_dungeon(dungeon_id: String) -> void:
	if dungeon_id == Exordium.ID:
		dungeon = Exordium.new()
	elif dungeon_id == TheCity.ID:
		dungeon = TheCity.new()
	elif dungeon_id == TheBeyond.ID:
		dungeon = TheBeyond.new()
	elif dungeon_id == TheEnding.ID:
		dungeon = TheEnding.new()

	CardGame.cur_dungeon = dungeon
	dungeon_room_screen.load_dungeon(dungeon, player)
	dungeon_map_screen.load_map(dungeon)
	CardGame.music.unsilence_bgm()
	CardGame.music.change_bgm(dungeon.id)
	await get_tree().create_timer(1).timeout
	
	while CardGame.black_mask.is_fading():
		await get_tree().create_timer(0.5).timeout
	
	if CardGame.black_mask.is_black():
		CardGame.black_mask.fade_out()
	scroll_anim = dungeon.cur_room_node.room.type == AbstractRoom.RoomType.EMPTY
	open_screen(ScreenType.MAP, true)
	open_screen(ScreenType.ROOM)
	dungeon_transition_screen.open(CardGame.cur_dungeon.id)
	pre_room_phase = AbstractRoom.RoomPhase.INCOMPLETE

func set_ascension_level(level: int) -> void:
	ascension_level = level
	is_ascension_mode = level > 0

func open_screen(screen_type: ScreenType, instant: bool = true) -> void:
	match screen_type:
		ScreenType.ROOM:
			overlay_menu.proceed_button.set_label(TEXT[0])
			# dungeon.cur_room_node = dungeon.boss_room_node
			dungeon_room_screen.load_room(dungeon.cur_room_node.room)

			match dungeon.cur_room_node.room.type:
				AbstractRoom.RoomType.REST:
					pass
				AbstractRoom.RoomType.SHOP:
					pass
				AbstractRoom.RoomType.MONSTER:
					pass
				AbstractRoom.RoomType.SHRINE:
					pass
		ScreenType.MAP:
			dungeon_map_screen.open(instant, scroll_anim)
			if scroll_anim:
				scroll_anim = false
			# print("dungeon.cur_room_node.room.type:", AbstractRoom.RoomType.find_key(dungeon.cur_room_node.room.type))
			if dungeon.cur_room_node.room.type == AbstractRoom.RoomType.EMPTY:
				overlay_menu.cancel_button.hide_button(true)
			else:
				overlay_menu.cancel_button.show_button_with_name(DungeonMapScreen.TEXT[1])

		ScreenType.SHOP:
			dungeon_shop_screen.open()
			overlay_menu.show_black()
			overlay_menu.cancel_button.show_button_with_name(ShopScreen.SHOP_NAMES[12])
			overlay_menu.proceed_button.hide_button()
		
		ScreenType.COMBAT_REWARD:
			combat_reward_screen.open()
			overlay_menu.proceed_button.show_button()
		ScreenType.CARD_SELECT_REWARD:
			pass
		ScreenType.BOSS_REWARD:
			boss_relic_reward_screen.open()
		ScreenType.SMITH_DECK_VIEW:
			dungeon_deck_screen.open(player.get_upgradeable_cards(), DeckViewScreen.DeckViewMode.UPGRADE_DECK_VIEW)
			overlay_menu.cancel_button.hide_button(true)
			overlay_menu.cancel_button.show_button_with_name(DeckViewScreen.TEXT[1])
			overlay_menu.proceed_button.hide_button()
		ScreenType.PURGE_DECK_VIEW:
			dungeon_deck_screen.open(player.get_purgeable_cards(), DeckViewScreen.DeckViewMode.PURGE_DECK_VIEW)
			overlay_menu.cancel_button.hide_button(true)
			overlay_menu.cancel_button.show_button_with_name(DeckViewScreen.TEXT[1])
			overlay_menu.proceed_button.hide_button()
		ScreenType.MASTER_DECK_VIEW:
			if cur_screen == ScreenType.COMBAT_REWARD:
				combat_reward_screen.close()
				overlay_menu.proceed_button.hide_button()
			elif cur_screen == ScreenType.BOSS_REWARD:
				boss_relic_reward_screen.close(true)
			elif cur_screen == ScreenType.MAP:
				dungeon_map_screen.close(true)
			elif cur_screen == ScreenType.CARD_SELECT_REWARD:
				card_select_reward_screen.close()
			dungeon_deck_screen.open(player.master_decks.group, DeckViewScreen.DeckViewMode.MASTER_DECK_VIEW)
			overlay_menu.cancel_button.hide_button(true)
			overlay_menu.cancel_button.show_button_with_name(DeckViewScreen.TEXT[1])
			overlay_menu.proceed_button.hide_button()
	pre_screen = cur_screen
	cur_screen = screen_type
	# print("cur_screen:", ScreenType.find_key(cur_screen))

	# print_pre_screen()
	print_current_screen()

func open_card_reward_screen(reward_widget: RewardItemWidget, header: String) -> void:
	combat_reward_screen.close(true)
	overlay_menu.show_black(true)
	card_select_reward_screen.open(reward_widget, header)
	open_screen(ScreenType.CARD_SELECT_REWARD)

func print_current_screen() -> void:
	print("cur_screen:", ScreenType.find_key(cur_screen))

func print_pre_screen() -> void:
	print("pre_screen:", ScreenType.find_key(pre_screen))

func close_screen(screen_type: ScreenType, instant: bool = true) -> void:
	match screen_type:
		ScreenType.ROOM:
			pass
		ScreenType.MAP:
			dungeon_map_screen.close(instant)
			overlay_menu.cancel_button.hide_button()
		ScreenType.SHOP:
			pre_screen = ScreenType.ROOM
			dungeon_shop_screen.close()
			overlay_menu.hide_black()
			overlay_menu.cancel_button.hide_button()
		ScreenType.COMBAT_REWARD:
			cur_screen = ScreenType.ROOM
			combat_reward_screen.close()
			overlay_menu.proceed_button.hide_button()
		ScreenType.CARD_SELECT_REWARD:
			card_select_reward_screen.close()
			if dungeon.cur_room_node.room.phase == AbstractRoom.RoomPhase.COMPLETE:
				cur_screen = ScreenType.COMBAT_REWARD
				combat_reward_screen.reopen()
		ScreenType.BOSS_REWARD:
			pre_screen = ScreenType.ROOM
			boss_relic_reward_screen.close()
		ScreenType.SMITH_DECK_VIEW:
			dungeon_deck_screen.close()
			overlay_menu.cancel_button.hide_button()
		ScreenType.PURGE_DECK_VIEW:
			dungeon_deck_screen.close()
			overlay_menu.reshow_cancel_button()
			overlay_menu.proceed_button.hide_button()
		ScreenType.MASTER_DECK_VIEW:
			if pre_screen == ScreenType.PURGE_DECK_VIEW:
				dungeon_deck_screen.close(true)
				dungeon_deck_screen.open(player.get_purgeable_cards(), DeckViewScreen.DeckViewMode.PURGE_DECK_VIEW)
				overlay_menu.cancel_button.hide_button(true)
				overlay_menu.cancel_button.show_button_with_name(DeckViewScreen.TEXT[1])
			elif pre_screen == ScreenType.SHOP:
				dungeon_deck_screen.close()
				overlay_menu.reshow_cancel_button()
			else:
				if pre_screen == ScreenType.MAP and dungeon.cur_room_node.room.type != AbstractRoom.RoomType.EMPTY:
					pre_screen = ScreenType.ROOM
				dungeon_deck_screen.close()
				overlay_menu.cancel_button.hide_button()
		ScreenType.NONE:
			open_screen(ScreenType.MAP, true)
	
	print_pre_screen()
	print_current_screen()
	if pre_screen != ScreenType.NONE:
		cur_screen = pre_screen
		pre_screen = ScreenType.NONE
	else:
		match cur_screen:
			ScreenType.ROOM:
				cur_screen = ScreenType.MAP
			ScreenType.SHOP:
				cur_screen = ScreenType.ROOM
			# ScreenType.COMBAT_REWARD:
			# 	pass
			ScreenType.CARD_SELECT_REWARD:
				cur_screen = ScreenType.COMBAT_REWARD
			# ScreenType.BOSS_REWARD:
			# 	pass
			# ScreenType.SMITH_DECK_VIEW:
			# 	pass
			ScreenType.PURGE_DECK_VIEW:
				cur_screen = ScreenType.SHOP
			ScreenType.MASTER_DECK_VIEW:
				dungeon_deck_screen.close()
				overlay_menu.cancel_button.hide_button()
			_:
				cur_screen = ScreenType.NONE
	
	if cur_screen == ScreenType.COMBAT_REWARD:
		# print("open combat_reward_screen")
		combat_reward_screen.reopen()
	elif cur_screen == ScreenType.BOSS_REWARD:
		boss_relic_reward_screen.open()
	elif cur_screen == ScreenType.CARD_SELECT_REWARD:
		card_select_reward_screen.reopen()
		overlay_menu.show_black(true)
func close_current_screen() -> void:
	close_screen(cur_screen, false)

func next_room_transition_start() -> void:
	CardGame.music.fade_out_temp_bgm()
	await get_tree().create_timer(0.3).timeout
	CardGame.black_mask.fade_in(0.3, next_room_transition)

func next_room_transition() -> void:
	if CardGame.black_mask.is_black():
		CardGame.black_mask.fade_out(0.3)
	floor_num += 1
	dungeon.refresh_rng(floor_num)
	dungeon_map_screen.close(true)
	overlay_menu.cancel_button.hide_button()
	overlay_menu.hide_black(true)
	open_screen(ScreenType.ROOM)


func set_z_order() -> void:
	$BlackBG.z_index = Global.BLACKBG_Z_INDEX

func add_game_effect(game_effect: AbstractGameEffect, edit_z_index: bool = true) -> void:
	game_effect_list.append(game_effect)
	if edit_z_index:
		game_effect.z_index = Global.EFFECT_Z_INDEX
	if game_effect.get_parent() == null:
		var orig_transform: Transform2D = game_effect.get_transform()
		game_effect_container.add_child(game_effect)
		game_effect.global_position = orig_transform.get_origin()
		game_effect.scale = orig_transform.get_scale() / game_effect.get_transform().get_scale()

func add_particle_effect(particle_effect: AbstractParticleEffect, edit_z_index: bool = true, play: bool = true) -> void:
	particle_effect_list.append(particle_effect)
	if edit_z_index:
		particle_effect.z_index = Global.PARTICLE_EFFECT_Z_INDEX
	if particle_effect.get_parent() == null:
		particle_effect_container.add_child(particle_effect)

	if play:
		particle_effect.play()

func on_top_panel_map_button_click() -> void:
	if cur_screen == ScreenType.MAP:
		return
	else:
		on_proceed_click()

func on_top_panel_deck_button_click() -> void:
	if cur_screen == ScreenType.MASTER_DECK_VIEW:
		on_cancel_button_click()
	else:
		open_screen(ScreenType.MASTER_DECK_VIEW)

func on_cancel_button_click() -> void:
	if cur_screen == ScreenType.MASTER_DECK_VIEW:
		close_current_screen()
		if cur_screen != ScreenType.BOSS_REWARD and dungeon_room_screen.cur_room:
			if dungeon_room_screen.cur_room.type == AbstractRoom.RoomType.EMPTY:
				show_map()
			elif dungeon_room_screen.is_event_room() or dungeon_room_screen.is_shop_room() or dungeon_room_screen.is_campfire_room():
				print("event room or shop room or campfire room")
			elif dungeon_room_screen.is_treasure_room() and not dungeon_room_screen.treasure_ui.is_opened:
				pass
			elif dungeon_room_screen.cur_room.phase == AbstractRoom.RoomPhase.COMPLETE:
				if cur_screen != ScreenType.CARD_SELECT_REWARD:
					combat_reward_screen.reopen()
					cur_screen = ScreenType.COMBAT_REWARD
	elif cur_screen == ScreenType.SMITH_DECK_VIEW:
		if dungeon_deck_screen.upgrade_card_popup.visible:
			dungeon_deck_screen.close_upgraded_popup()
		else:
			close_current_screen()
	elif cur_screen == ScreenType.PURGE_DECK_VIEW:
		if dungeon_deck_screen.purge_card_popup.visible:
			dungeon_deck_screen.close_purged_popup()
		else:
			close_current_screen()
	else:
		close_current_screen()
	
	show_proceed_button_if_needed()

func on_confirm_button_click() -> void:
	if cur_screen == ScreenType.SMITH_DECK_VIEW:
		if dungeon_deck_screen.upgrade_card_popup.visible:
			CardGame.dungeon_main_screen.close_current_screen()
			dungeon_deck_screen.upgrade_select_card()
			overlay_menu.confirm_button.hide_button(true)
			overlay_menu.cancel_button.hide_button()
			dungeon_room_screen.end_room()
			overlay_menu.show_black(true, 0.8)
			await get_tree().create_timer(0.5).timeout
			overlay_menu.hide_black_during(1.0)
	elif cur_screen == ScreenType.PURGE_DECK_VIEW:
		if dungeon_deck_screen.purge_card_popup.visible:
			dungeon_shop_screen.purge_card()
			CardGame.dungeon_main_screen.close_current_screen()
			dungeon_deck_screen.purge_select_card()
			overlay_menu.confirm_button.hide_button(true)
			overlay_menu.reshow_cancel_button()

func on_proceed_click() -> void:
	if combat_reward_screen.is_show:
		combat_reward_screen.close()
	
	if not overlay_menu.proceed_button.is_hidden:
		overlay_menu.proceed_button.hide_button()
	if cur_screen == ScreenType.MASTER_DECK_VIEW:
		close_current_screen()
	
	if dungeon.is_boss_room():
		if cur_screen == ScreenType.COMBAT_REWARD:
			close_current_screen()
			dungeon_room_screen.load_room(dungeon.boss_room_node.room.boss_treasure_room)
		elif cur_screen == ScreenType.ROOM:
			CardGame.music.fade_out_bgm()
			CardGame.black_mask.fade_in(1.0, CardGame.load_next_dungeon)
	else:
		show_map()

func show_map() -> void:
	open_screen(ScreenType.MAP, true)

func show_proceed_button_if_needed() -> void:
	if card_select_reward_screen.visible:
		return
	if cur_screen == ScreenType.SHOP or cur_screen == ScreenType.PURGE_DECK_VIEW or cur_screen == ScreenType.SMITH_DECK_VIEW:
		return
	if cur_screen == ScreenType.BOSS_REWARD:
		return
	if dungeon_room_screen.cur_room and dungeon_room_screen.cur_room.phase == AbstractRoom.RoomPhase.COMPLETE:
		if dungeon_room_screen.is_combat_room:
			combat_reward_screen.reopen()
			cur_screen = ScreenType.COMBAT_REWARD
		if not dungeon_room_screen.is_event_room():
			overlay_menu.proceed_button.show_button()
	elif cur_screen == ScreenType.MAP:
		if dungeon_room_screen.cur_room and dungeon_room_screen.cur_room.type != AbstractRoom.RoomType.EMPTY:
			overlay_menu.cancel_button.show_button()
	elif cur_screen == ScreenType.SHOP:
		return

func _on_proceed_button_mouse_entered() -> void:
	if combat_reward_screen.is_show:
		combat_reward_screen.flash()

func get_reward_cards() -> Array[AbstractCard]:
	var cards: Array[AbstractCard] = []
	var num_cards: int = 3
	for i in range(num_cards):
		var rarity: AbstractCard.CardRarity = roll_rarity()
		# print("rarity:", AbstractCard.CardRarity.find_key(rarity))
		match rarity:
			AbstractCard.CardRarity.COMMON:
				card_blizz_randomizer = max(card_blizz_randomizer - card_blizz_growth, card_blizz_max_offset)
			AbstractCard.CardRarity.UNCOMMON:
				pass
			AbstractCard.CardRarity.RARE:
				card_blizz_randomizer = card_blizz_start_offset

		var contain_dupe: bool = true
		var card: AbstractCard = null
		while contain_dupe:
			contain_dupe = false
			card = get_card_by_rarity(rarity)
			for c in cards:
				if c.card_id == card.card_id:
					contain_dupe = true
					break
		if card != null:
			cards.append(card)
		
	
	for card in cards:
		if card.rarity == AbstractCard.CardRarity.RARE or not dungeon.random_upgrade():
			pass
		else:
			card.upgrade()
			print("card upgraded:", card.name)
	return cards


func roll_rarity() -> AbstractCard.CardRarity:
	var roll: int = dungeon.cardRng.randi_range(0, 99) + card_blizz_randomizer
	if dungeon.cur_room_node == null:
		if roll < 3:
			return AbstractCard.CardRarity.RARE
		if roll < 40:
			return AbstractCard.CardRarity.UNCOMMON;
		return AbstractCard.CardRarity.COMMON;

	return dungeon.cur_room_node.room.get_card_rarity(roll)

func get_card_by_rarity(rarity: AbstractCard.CardRarity) -> AbstractCard:
	match rarity:
		AbstractCard.CardRarity.COMMON:
			return common_card_pool.get_random_card(true).make_copy()
		AbstractCard.CardRarity.UNCOMMON:
			return uncommon_card_pool.get_random_card(true).make_copy()
		AbstractCard.CardRarity.RARE:
			return rare_card_pool.get_random_card(true).make_copy()
		AbstractCard.CardRarity.CURSE:
			return curse_card_pool.get_random_card(true).make_copy()
	return null

func get_card_from_pool(rarity: AbstractCard.CardRarity, card_type: AbstractCard.CardType, use_rng: bool) -> AbstractCard:
	var card: AbstractCard = null
	if card_type == AbstractCard.CardType.POWER:
		if rarity == AbstractCard.CardRarity.UNCOMMON:
			rarity = AbstractCard.CardRarity.RARE
		elif rarity == AbstractCard.CardRarity.COMMON:
			rarity = AbstractCard.CardRarity.UNCOMMON
	
	match rarity:
		AbstractCard.CardRarity.RARE:
			card = rare_card_pool.get_random_card_by_type(use_rng, card_type).make_copy()
		AbstractCard.CardRarity.UNCOMMON:
			card = uncommon_card_pool.get_random_card_by_type(use_rng, card_type).make_copy()
		AbstractCard.CardRarity.COMMON:
			card = common_card_pool.get_random_card_by_type(use_rng, card_type).make_copy()
		AbstractCard.CardRarity.CURSE:
			card = curse_card_pool.get_random_card_by_type(use_rng, card_type).make_copy()
	# print("card:", card)
	return card

func get_colorless_card_from_pool(rarity: AbstractCard.CardRarity) -> AbstractCard:
	var card: AbstractCard = null
	match rarity:
		AbstractCard.CardRarity.RARE:
			card = colorless_card_pool.get_random_card_by_rarity(true, rarity).make_copy()
		AbstractCard.CardRarity.UNCOMMON:
			card = colorless_card_pool.get_random_card_by_rarity(true, rarity).make_copy()
		AbstractCard.CardRarity.COMMON:
			card = colorless_card_pool.get_random_card_by_rarity(true, rarity).make_copy()
	return card

func initialize_card_pool() -> void:
	common_card_pool.clear()
	uncommon_card_pool.clear()
	rare_card_pool.clear()
	colorless_card_pool.clear()
	curse_card_pool.clear()
	
	var tmp_cards: Array[AbstractCard] = []
	CardLibrary.add_player_card_to_pool(tmp_cards, player.type)
	
	for card in tmp_cards:
		match card.rarity:
			AbstractCard.CardRarity.COMMON:
				common_card_pool.add_to_top(card)
			AbstractCard.CardRarity.UNCOMMON:
				uncommon_card_pool.add_to_top(card)
			AbstractCard.CardRarity.RARE:
				rare_card_pool.add_to_top(card)
			AbstractCard.CardRarity.CURSE:
				common_card_pool.add_to_top(card)
	
	var colorless_cards: Array[AbstractCard] = []
	colorless_cards.assign(CardLibrary.get_card_list(CardLibrary.LibraryType.COLORLESS))
	for card: AbstractCard in colorless_cards:
		if card != null and card.rarity != AbstractCard.CardRarity.BASIC and card.rarity != AbstractCard.CardRarity.SPECIAL and card.type != AbstractCard.CardType.STATUS:
			colorless_card_pool.add_to_top(card)
	
	var curse_cards: Array[AbstractCard] = []
	curse_cards.assign(CardLibrary.get_card_list(CardLibrary.LibraryType.CURSE))
	for card: AbstractCard in curse_cards:
		if card != null and card.card_id != Necronomicurse.ID and card.card_id != AscendersBane.ID and card.card_id != CurseOfTheBell.ID and card.card_id != Pride.ID:
			curse_card_pool.add_to_top(card)
