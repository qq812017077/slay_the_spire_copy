class_name TitleCloud
extends Object

var region: AtlasRegion = null
var texture_rect: TextureRect = null
var x: float
var y: float

var vX: float
var vY: float

var slide_jiggle: float
func _init(_region: AtlasRegion, _vX: float):
    region = _region
    texture_rect = TextureRect.new()
    texture_rect.texture = TextureHelper.get_cached_texture(region)
    texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
    texture_rect.stretch_mode = TextureRect.STRETCH_SCALE
    texture_rect.size = Vector2(region.size.x, region.size.y)

    x = get_random_x_offset()
    vX = _vX
    y = -20 + randf_range(-50, 50)
    vY = randf_range(-vX / 10 , vX / 10)
    slide_jiggle = randf_range(-4.0, 4.0)


func render(delta: float, slider: float) -> void:
    x += vX * delta
    y += vY * delta

    if vX > 0.0 and x > 1920:
        x = -1920.0
        vX = get_postive_speed()
        y = -20 + randf_range(-50, 50)
        vY = randf_range(-vX / 5 , vX / 5)
    elif x < -1920:
        x = 1920
        vX = get_negative_speed()
        y = -20 + randf_range(-50, 50)
        vY = randf_range(-vX / 5 , vX / 5)
    
    texture_rect.position = Vector2(x + region.offset.x, (-55 + slide_jiggle) * slider + y + region.offset.y)



static func get_postive_speed() -> float:
    return randf_range(10.0, 50.0)

static func get_negative_speed() -> float:
    return randf_range(-50.0, -10.0)

static func get_random_x_offset() -> float:
    return randf_range(-1920, 1920)