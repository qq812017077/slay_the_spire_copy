class_name TextureHelper
extends Object
static var cache_textures_by_region: Dictionary = {}


static func get_cached_texture(atlas_region: AtlasRegion) -> AtlasTexture:
	if cache_textures_by_region.has(atlas_region):
		return cache_textures_by_region[atlas_region]

	# generate atlas texture
	var atlas_texture: AtlasTexture = AtlasTexture.new()
	atlas_texture.atlas = atlas_region.texture
	atlas_texture.region = Rect2(atlas_region.xy, atlas_region.size)
	atlas_texture.filter_clip = true
	cache_textures_by_region.set(atlas_region, atlas_texture)
	return atlas_texture

static func set_texture(sprite: Sprite2D, region: AtlasRegion) -> void:
	sprite.texture = TextureHelper.get_cached_texture(region)
	sprite.centered = false
	sprite.offset = Vector2(region.offset.x, 1080 - region.offset.y - region.size.y)
	sprite.position = Vector2(0, 0)

	
