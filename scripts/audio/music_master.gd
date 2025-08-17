class_name MusicMaster
extends Node

const BGM_DIR: String = "res://arts/slay_the_spire/audios/musics/"


var bgm_map: Dictionary = {}

var main_tracks: Dictionary = {}
var tmp_tracks: Dictionary = {}


func _init() -> void:
	bgm_map.set("MENU", load_stream("STS_MenuTheme_NewMix_v1.ogg"))
	bgm_map.set(Exordium.ID, [load_stream("STS_Level1_NewMix_v1.ogg"), load_stream("STS_Level1-2_v2.ogg")])
	bgm_map.set(TheCity.ID, [load_stream("STS_Level2_NewMix_v1.ogg"), load_stream("STS_Level2-2_v2.ogg")])
	bgm_map.set(TheBeyond.ID, [load_stream("STS_Level3_v2.ogg"), load_stream("STS_Level3-2_v2.ogg")])
	bgm_map.set(TheEnding.ID, load_stream("STS_Act4_BGM_v2.ogg"))


	bgm_map.set("SHOP", load_stream("STS_Merchant_NewMix_v1.ogg"))
	bgm_map.set("SHRINE", load_stream("STS_Shrine_NewMix_v1.ogg"))
	bgm_map.set("MINDBLOOM", load_stream("STS_Boss1MindBloom_v1.ogg"))
	bgm_map.set("BOSS_BOTTOM", load_stream("STS_Boss1_NewMix_v1.ogg"))
	bgm_map.set("BOSS_CITY", load_stream("STS_Boss2_NewMix_v1.ogg"))
	bgm_map.set("BOSS_BEYOND", load_stream("STS_Boss3_NewMix_v1.ogg"))
	bgm_map.set("BOSS_ENDING", load_stream("STS_Boss4_v6.ogg"))
	bgm_map.set("ELITE", load_stream("STS_EliteBoss_NewMix_v1.ogg"))
	bgm_map.set("CREDITS", load_stream("STS_Credits_v5.ogg"))
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	update_bgm(delta)
	update_temp_bgm(delta)

func update_bgm(_delta: float) -> void:
	for key in main_tracks.keys():
		var track: MusicPlayer = main_tracks[key]
		if track.is_done:
			main_tracks.erase(key)
			track.queue_free()


func update_temp_bgm(_delta: float) -> void:
	for key in tmp_tracks.keys():
		var track: MusicPlayer = tmp_tracks[key]
		if track.is_done:
			tmp_tracks.erase(key)
			track.queue_free()


func change_bgm(key: String) -> void:
	var audio_stream: AudioStream = get_music(key)
	if audio_stream:
		var music_player = MusicPlayer.new(audio_stream)
		add_child(music_player)
		if main_tracks.has(key):
			main_tracks[key].queue_free()
		main_tracks.set(key, music_player)
		music_player.play()

func play_temp_bgm(key: String) -> void:
	var audio_stream: AudioStream = get_music(key)
	if audio_stream:
		var music_player = MusicPlayer.new(audio_stream)
		add_child(music_player)
		if tmp_tracks.has(key):
			tmp_tracks[key].queue_free()
		tmp_tracks.set(key, music_player)
		music_player.play()
	silence_bgm()

func fade_out_temp_bgm() -> void:
	for key in tmp_tracks.keys():
		var track: MusicPlayer = tmp_tracks[key]
		if not track.is_fading_out:
			track.fade_out()
	unsilence_bgm()

func fade_out_bgm() -> void:
	for key in main_tracks.keys():
		var track: MusicPlayer = main_tracks[key]
		if not track.is_fading_out:
			track.fade_out()

func get_music(key: String) -> AudioStream:
	if bgm_map.has(key):
		var data = bgm_map[key]
		if data is Array:
			var music_list = data as Array
			var random_index = randi() % music_list.size()
			return music_list[random_index]
		else:
			return data as AudioStream

	return null

func load_stream(file_name: String) -> AudioStream:
	return load(BGM_DIR + file_name)


func silence_bgm() -> void:
	# push_error(("silence_bgm() is invoked."))
	for key in main_tracks.keys():
		var track: MusicPlayer = main_tracks[key]
		if not track.is_slienced:
			track.silence()
			
func unsilence_bgm() -> void:
	for key in main_tracks.keys():
		var track: MusicPlayer = main_tracks[key]
		track.unsilence()
