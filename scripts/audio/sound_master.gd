class_name SoundMaster
extends Node

const playersN: int = 10
const SFX_DIR: String = "res://arts/slay_the_spire/audios/sounds/"

var idle_player_pool: Array = []

var sfx_map: Dictionary = {}
var running_players_by_name: Dictionary = {}

func _init() -> void:
	# menu
	sfx_map.set("WIND", load_stream("SOTE_SFX_WindAmb_v1.ogg"))
	
	# neow
	sfx_map.set("VO_NEOW_1A", load_stream("neow/STS_VO_Neow_1a.ogg"))
	sfx_map.set("VO_NEOW_1B", load_stream("neow/STS_VO_Neow_1b.ogg"))
	sfx_map.set("VO_NEOW_2A", load_stream("neow/STS_VO_Neow_2a.ogg"))
	sfx_map.set("VO_NEOW_2B", load_stream("neow/STS_VO_Neow_2b.ogg"))
	sfx_map.set("VO_NEOW_3A", load_stream("neow/STS_VO_Neow_3a.ogg"))
	sfx_map.set("VO_NEOW_3B", load_stream("neow/STS_VO_Neow_3b.ogg"))

	# merchant
	sfx_map.set("VO_MERCENARY_1A", load_stream("npc/merchant/STS_VO_Mercenary_1a.ogg"))
	sfx_map.set("VO_MERCENARY_1B", load_stream("npc/merchant/STS_VO_Mercenary_1b.ogg"))
	sfx_map.set("VO_MERCENARY_2A", load_stream("npc/merchant/STS_VO_Mercenary_2a.ogg"))
	sfx_map.set("VO_MERCENARY_3A", load_stream("npc/merchant/STS_VO_Mercenary_3a.ogg"))
	sfx_map.set("VO_MERCENARY_3B", load_stream("npc/merchant/STS_VO_Mercenary_3b.ogg"))
	sfx_map.set("VO_MERCHANT_2A", load_stream("npc/merchant/STS_VO_Merchant_2a.ogg"))
	sfx_map.set("VO_MERCHANT_2B", load_stream("npc/merchant/STS_VO_Merchant_2b.ogg"))
	sfx_map.set("VO_MERCHANT_2C", load_stream("npc/merchant/STS_VO_Merchant_2c.ogg"))
	sfx_map.set("VO_MERCHANT_3A", load_stream("npc/merchant/STS_VO_Merchant_3a.ogg"))
	sfx_map.set("VO_MERCHANT_3B", load_stream("npc/merchant/STS_VO_Merchant_3b.ogg"))
	sfx_map.set("VO_MERCHANT_3C", load_stream("npc/merchant/STS_VO_Merchant_3c.ogg"))
	sfx_map.set("VO_MERCHANT_KA", load_stream("npc/merchant/STS_VO_Merchant_Kekeke_a.ogg"))
	sfx_map.set("VO_MERCHANT_KB", load_stream("npc/merchant/STS_VO_Merchant_Kekeke_b.ogg"))
	sfx_map.set("VO_MERCHANT_KC", load_stream("npc/merchant/STS_VO_Merchant_Kekeke_c.ogg"))
	sfx_map.set("VO_MERCHANT_MA", load_stream("npc/merchant/STS_VO_Merchant_Mlyah_a.ogg"))
	sfx_map.set("VO_MERCHANT_MB", load_stream("npc/merchant/STS_VO_Merchant_Mlyah_b.ogg"))
	sfx_map.set("VO_MERCHANT_MC", load_stream("npc/merchant/STS_VO_Merchant_Mlyah_c.ogg"))

	# ui
	sfx_map.set("UI_CLICK_1", load_stream("ui/SOTE_SFX_UIClick_1_v2.wav"))
	sfx_map.set("UI_CLICK_2", load_stream("ui/SOTE_SFX_UIClick_2_v2.wav"))
	sfx_map.set("UI_HOVER", load_stream("ui/SOTE_SFX_UIHover_v2.wav"))
	
	sfx_map.set("DECK_CLOSE", load_stream("ui/SOTE_SFX_UI_Parchment_2_v1.ogg"));
	sfx_map.set("DECK_OPEN", load_stream("ui/SOTE_SFX_UI_Parchment_3_v1.ogg"));
	

	sfx_map.set("ATTACK_HEAVY", load_stream("attack/SOTE_SFX_HeavyAtk_v2.ogg"))
	sfx_map.set("ATTACK_DAGGER_2", load_stream("attack/STS_SFX_DaggerThrow_2.ogg"))
	sfx_map.set("ATTACK_MAGIC_BEAM_SHORT", load_stream("attack/SOTE_SFX_SlowMagic_BeamShort_v1.ogg"))

	sfx_map.set("SELECT_WATCHER", load_stream("watcher/STS_SFX_Watcher-Select_v2.ogg"))


	# map
	sfx_map.set("MAP_CLOSE", load_stream("map/SOTE_SFX_UI_Parchment_1_v2.ogg"))
	sfx_map.set("MAP_HOVER_1", load_stream("map/SOTE_SFX_MapHover_1_v1.ogg"))
	sfx_map.set("MAP_HOVER_2", load_stream("map/SOTE_SFX_MapHover_2_v1.ogg"))
	sfx_map.set("MAP_HOVER_3", load_stream("map/SOTE_SFX_MapHover_3_v1.ogg"))
	sfx_map.set("MAP_HOVER_4", load_stream("map/SOTE_SFX_MapHover_4_v1.ogg"))
	sfx_map.set("MAP_OPEN", load_stream("map/SOTE_SFX_Map_1_v3.ogg"))
	sfx_map.set("MAP_OPEN_2", load_stream("map/SOTE_SFX_Map_2_v3.ogg"))
	sfx_map.set("MAP_SELECT_1", load_stream("map/SOTE_SFX_MapSelect_1_v1.ogg"))
	sfx_map.set("MAP_SELECT_2", load_stream("map/SOTE_SFX_MapSelect_2_v1.ogg"))
	sfx_map.set("MAP_SELECT_3", load_stream("map/SOTE_SFX_MapSelect_3_v1.ogg"))
	sfx_map.set("MAP_SELECT_4", load_stream("map/SOTE_SFX_MapSelect_4_v1.ogg"))

	# room
	sfx_map.set("REST_FIRE_DRY", load_stream("room/SOTE_SFX_RestFireDry_v2.ogg"))
	sfx_map.set("REST_FIRE_WET", load_stream("room/SOTE_SFX_RestFireWet_v2.ogg"))

	sfx_map.set("SHOP_OPEN", load_stream("room/SOTE_SFX_ShopRugOpen_v1.ogg"))
	sfx_map.set("SHOP_CLOSE", load_stream("room/SOTE_SFX_ShopRugClose_v1.ogg"))
	sfx_map.set("SHOP_BUY", load_stream("room/SOTE_SFX_CashRegister.ogg"))

	sfx_map.set("SLEEP_1-1", load_stream("room/STS_SleepJingle_1a_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_1-2", load_stream("room/STS_SleepJingle_1b_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_1-3", load_stream("room/STS_SleepJingle_1c_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_2-1", load_stream("room/STS_SleepJingle_2a_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_2-2", load_stream("room/STS_SleepJingle_2b_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_2-3", load_stream("room/STS_SleepJingle_2c_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_3-1", load_stream("room/STS_SleepJingle_3a_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_3-2", load_stream("room/STS_SleepJingle_3b_NewMix_v1.ogg"))
	sfx_map.set("SLEEP_3-3", load_stream("room/STS_SleepJingle_3c_NewMix_v1.ogg"))

	sfx_map.set("CHEST_OPEN", load_stream("room/SOTE_SFX_ChestOpen_v2.ogg"))


	# gold
	sfx_map.set("GOLD_GAIN", load_stream("gold/SOTE_SFX_Gold_RR1_v3.ogg"))
	sfx_map.set("GOLD_GAIN_2", load_stream("gold/SOTE_SFX_Gold_RR2_v3.ogg"))
	sfx_map.set("GOLD_GAIN_3", load_stream("gold/SOTE_SFX_Gold_RR3_v3.ogg"))
	sfx_map.set("GOLD_GAIN_4", load_stream("gold/SOTE_SFX_Gold_RR4_v3.ogg"))
	sfx_map.set("GOLD_GAIN_5", load_stream("gold/SOTE_SFX_Gold_RR5_v3.ogg"))
	sfx_map.set("GOLD_JINGLE", load_stream("gold/SOTE_SFX_Gold_v1.ogg"))
	# card
	sfx_map.set("CARD_BURN", load_stream("card/STS_SFX_BurnCard_v1.ogg"))
	sfx_map.set("CARD_EXHAUST", load_stream("card/SOTE_SFX_ExhaustCard.ogg"))
	sfx_map.set("CARD_REJECT", load_stream("card/SOTE_SFX_CardReject_v1.ogg"))
	sfx_map.set("CARD_SELECT", load_stream("card/SOTE_SFX_CardSelect_v2.ogg"))
	sfx_map.set("CARD_OBTAIN", load_stream("card/SOTE_SFX_ObtainCard_v2.ogg"))
	sfx_map.set("CARD_UPGRADE", load_stream("card/SOTE_SFX_UpgradeCard_v1.ogg"))
func _ready() -> void:
	for _i in range(playersN):
		var player: SoundPlayer = SoundPlayer.new()
		idle_player_pool.append(player)

func _process(_delta: float) -> void:
	for sound_name in running_players_by_name.keys():
		var sound_player: SoundPlayer = running_players_by_name[sound_name]
		if sound_player.is_done:
			stop_sound(sound_player)

func play(sound_name: String, loop: bool) -> SoundPlayer:
	if Settings.is_backgrounded and CardGame.MUTE_IF_BG:
		return null
	if sfx_map.has(sound_name):
		var sound: AudioStream
		if sfx_map[sound_name] is AudioStreamOggVorbis:
			(sfx_map[sound_name] as AudioStreamOggVorbis).loop = loop
			sound = sfx_map[sound_name]
		elif sfx_map[sound_name] is AudioStreamWAV:
			(sfx_map[sound_name] as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD if loop else AudioStreamWAV.LOOP_DISABLED
			sound = sfx_map[sound_name]
		var player: SoundPlayer = null
		if running_players_by_name.has(sound_name):
			recycle_player(running_players_by_name[sound_name])
		player = get_idle_player()
		player.stream = sound
		player.name = sound_name
		player.is_loop = loop
		running_players_by_name.set(player.name, player)
		player.play()
		# print("play:", sound_name)
		return player
	else:
		push_error("missing sound", sound_name)
		return null

func loop_play(sound_name: String, volume_adjust: float = 0) -> SoundPlayer:
	var player = play(sound_name, true)
	if player != null:
		player.adjust_volume(volume_adjust)
	return player

func single_play(sound_name: String, volume_adjust: float = 0) -> SoundPlayer:
	var player = play(sound_name, false)
	if player != null:
		player.adjust_volume(volume_adjust)
	return player

func fade_out(sound_name: String) -> void:
	if running_players_by_name.has(sound_name):
		running_players_by_name[sound_name].fade_out()


func stop_sound(sound_player: SoundPlayer) -> void:
	var key = sound_player.name
	recycle_player(sound_player)
	# print("recycle:", key)
	if running_players_by_name.has(key):
		running_players_by_name.erase(key)
	else:
		push_error("missing running sound", key)


func get_idle_player() -> SoundPlayer:
	var player: SoundPlayer
	if idle_player_pool.size() > 0:
		player = idle_player_pool.pop_front()
	player = SoundPlayer.new()

	add_child(player)
	return player

func recycle_player(player: SoundPlayer) -> void:
	if player == null:
		return
	player.kill()
	player.stream = null
	remove_child(player)
	
	if not idle_player_pool.has(player):
		idle_player_pool.push_back(player)


func load_stream(file_name: String) -> AudioStream:
	return load(SFX_DIR + file_name)


# func _on_player_finished(player: SoundPlayer) -> void:
#	 recycle_player(player)
#	 running_players_by_name.erase(player.name)
#	 player.finished.disconnect(_on_player_finished.bind(player))
