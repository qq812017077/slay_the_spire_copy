class_name CampfireSleepEffect
extends AbstractGameEffect


static var ui_string: UIString = null
static var TEXT: Array = []

var has_healed: bool = false
var room: AbstractRoom = null
var screen_color: Color = Color(0, 0, 0, 0)
var black_screen: TextureRect = null
func _init(cur_room: AbstractRoom) -> void:
    if ui_string == null:
        ui_string = CardGame.languagePack.get_ui_string("CampfireSleepEffect")
        TEXT = ui_string.TEXT
    
    if Settings.FAST_MODE:
        duration = 1.5
    else:
        duration = 3.0

    starting_duration = duration
    has_healed = false
    room = cur_room
    screen_color = CardGame.dungeon_main_screen.dungeon.fade_color

func _ready() -> void:
    position = Vector2.ZERO

    black_screen = TextureRect.new()
    add_child(black_screen)
    black_screen.texture = CanvasTexture.new()
    black_screen.size = Vector2(1920, 1080)
    black_screen.position = Vector2.ZERO
    black_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
    black_screen.modulate = screen_color


func _process(delta: float) -> void:
    duration -= delta
    update_black_screen_color()
    
    if duration < (starting_duration - 0.5) and not has_healed:
        play_sleep_sound()
        has_healed = true
    
    if duration <= starting_duration / 4:
        is_done = true
        if CardGame.dungeon_main_screen.dungeon.id != TheEnding.ID:
            CardGame.music.unsilence_bgm()
        room.phase = AbstractRoom.RoomPhase.COMPLETE

func update_black_screen_color() -> void:
    if duration > (starting_duration - 0.5):
        screen_color.a = CardGame.interpolation.apply_fade(1.0, 0.0, (duration - (starting_duration - 0.5)) * 2)
    elif duration < 1.0:
        screen_color.a = CardGame.interpolation.apply_fade(0.0, 1.0, duration)
    else:
        screen_color.a = 1.0
    
    black_screen.modulate = screen_color

func play_sleep_sound() -> void:
    var roll = randi() % 3
    var sound_name = ""
    match CardGame.dungeon_main_screen.dungeon.id:
        Exordium.ID:
            if roll == 0:
                sound_name = "SLEEP_1-1"
            elif roll == 1:
                sound_name = "SLEEP_1-2"
            else:
                sound_name = "SLEEP_1-3"
        TheCity.ID:
            if roll == 0:
                sound_name = "SLEEP_2-1"
            elif roll == 1:
                sound_name = "SLEEP_2-2"
            else:
                sound_name = "SLEEP_2-3"
        TheBeyond.ID:
            if roll == 0:
                sound_name = "SLEEP_3-1"
            elif roll == 1:
                sound_name = "SLEEP_3-2"
            else:
                sound_name = "SLEEP_3-3"
    if sound_name != "":
        CardGame.sound.single_play(sound_name)