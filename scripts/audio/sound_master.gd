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
	
	# ui
	sfx_map.set("UI_CLICK_1", load_stream("ui/SOTE_SFX_UIClick_1_v2.wav"))
	sfx_map.set("UI_CLICK_2", load_stream("ui/SOTE_SFX_UIClick_2_v2.wav"))
	sfx_map.set("UI_HOVER", load_stream("ui/SOTE_SFX_UIClick_2_v2.wav"))
	
	sfx_map.set("DECK_CLOSE", load_stream("ui/SOTE_SFX_UI_Parchment_2_v1.ogg"));
	sfx_map.set("DECK_OPEN", load_stream("ui/SOTE_SFX_UI_Parchment_3_v1.ogg"));
	

	sfx_map.set("ATTACK_HEAVY", load_stream("attack/SOTE_SFX_HeavyAtk_v2.ogg"))
	sfx_map.set("ATTACK_DAGGER_2", load_stream("attack/STS_SFX_DaggerThrow_2.ogg"))
	sfx_map.set("ATTACK_MAGIC_BEAM_SHORT", load_stream("attack/SOTE_SFX_SlowMagic_BeamShort_v1.ogg"))

	sfx_map.set("SELECT_WATCHER", load_stream("watcher/STS_SFX_Watcher-Select_v2.ogg"))


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
		var player: SoundPlayer = get_idle_player()
		player.stream = sound
		player.name = sound_name
		player.is_loop = loop
		running_players_by_name.set(player.name, player)
		player.play()
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
