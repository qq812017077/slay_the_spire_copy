class_name NeowReward
extends Object

enum NeowRewardDrawback {
		NONE,
		TEN_PERCENT_HP_LOSS,
		NO_GOLD,
		CURSE,
		PERCENT_DAMAGE
	}
enum NeowRewardType {
		RANDOM_COLORLESS_2,
		THREE_CARDS,
		ONE_RANDOM_RARE_CARD,
		REMOVE_CARD,
		UPGRADE_CARD,
		RANDOM_COLORLESS,
		TRANSFORM_CARD,
		THREE_SMALL_POTIONS,
		RANDOM_COMMON_RELIC,
		TEN_PERCENT_HP_BONUS,
		HUNDRED_GOLD,
		THREE_ENEMY_KILL,
		REMOVE_TWO,
		TRANSFORM_TWO_CARDS,
		ONE_RARE_RELIC,
		THREE_RARE_CARDS,
		TWO_FIFTY_GOLD,
		TWENTY_PERCENT_HP_BONUS,
		BOSS_RELIC
}

static var character_string: CharacterString = null
static var NAME: Array
static var TEXT: Array
static var OPTIONS: Array
static var UNIQUE_REWARDS: Array

static var ID: String = "Neow Reward"

var hp_bonus: int = 0
var option_label: String = ""
var type: NeowRewardType = NeowRewardType.RANDOM_COLORLESS
var draw_back_type: NeowRewardDrawback = NeowRewardDrawback.NONE

var activated: bool = false
func _init() -> void:
	if character_string == null:
		character_string = CardGame.languagePack.get_character_string(ID)
		NAME = character_string.NAMES
		TEXT = character_string.TEXT
		OPTIONS.assign(character_string.OPTIONS)
		UNIQUE_REWARDS = character_string.UNIQUE_REWARDS

	activated = false
func activate() -> void:
	activated = true

	match draw_back_type:
		NeowRewardDrawback.TEN_PERCENT_HP_LOSS:
			pass
		NeowRewardDrawback.NO_GOLD:
			pass
		NeowRewardDrawback.CURSE:
			pass
		NeowRewardDrawback.PERCENT_DAMAGE:
			pass
		
	match type:
		NeowRewardType.RANDOM_COLORLESS_2:
			pass
		NeowRewardType.THREE_CARDS:
			pass
		NeowRewardType.ONE_RANDOM_RARE_CARD:
			pass
		NeowRewardType.REMOVE_CARD:
			pass
		NeowRewardType.UPGRADE_CARD:
			pass
		NeowRewardType.RANDOM_COLORLESS:
			pass
		NeowRewardType.TRANSFORM_CARD:
			pass
		NeowRewardType.THREE_SMALL_POTIONS:
			pass
		NeowRewardType.RANDOM_COMMON_RELIC:
			pass
		NeowRewardType.TEN_PERCENT_HP_BONUS:
			pass
		NeowRewardType.HUNDRED_GOLD:
			pass
		NeowRewardType.THREE_ENEMY_KILL:
			pass
		NeowRewardType.REMOVE_TWO:
			pass
		NeowRewardType.TRANSFORM_TWO_CARDS:
			pass
		NeowRewardType.ONE_RARE_RELIC:
			pass
		NeowRewardType.THREE_RARE_CARDS:
			pass
		NeowRewardType.TWO_FIFTY_GOLD:
			pass
		NeowRewardType.TWENTY_PERCENT_HP_BONUS:
			pass
		NeowRewardType.BOSS_RELIC:
			pass
	

func set_type(_type: NeowRewardType) -> void:
	self.type = _type
	self.option_label = self.update_desc()


func update_desc() -> String:
	match self.type:
		NeowRewardType.BOSS_RELIC:
			return UNIQUE_REWARDS[0]
		NeowRewardType.THREE_CARDS:
			return TEXT[0]
		NeowRewardType.ONE_RANDOM_RARE_CARD:
			return TEXT[1]
		NeowRewardType.REMOVE_CARD:
			return TEXT[2]
		NeowRewardType.UPGRADE_CARD:
			return TEXT[3]
		NeowRewardType.TRANSFORM_CARD:
			return TEXT[4]
		
		NeowRewardType.THREE_SMALL_POTIONS:
			return TEXT[5]
		NeowRewardType.RANDOM_COMMON_RELIC:
			return TEXT[6]
		NeowRewardType.TEN_PERCENT_HP_BONUS:
			return TEXT[7] + str(self.hp_bonus) + " ]"
		NeowRewardType.HUNDRED_GOLD:
			return TEXT[8] + str(100) + TEXT[9]
		NeowRewardType.REMOVE_TWO:
			return TEXT[9]
		NeowRewardType.TRANSFORM_TWO_CARDS:
			return TEXT[10]

		NeowRewardType.ONE_RARE_RELIC:
			return TEXT[11]
		NeowRewardType.THREE_RARE_CARDS:
			return TEXT[12]
		NeowRewardType.TWO_FIFTY_GOLD:
			return TEXT[13] + str(250) + TEXT[14]
		NeowRewardType.TRANSFORM_TWO_CARDS:
			return TEXT[15]
		NeowRewardType.TWENTY_PERCENT_HP_BONUS:
			return TEXT[16] + str(self.hp_bonus * 2) + " ]"
		

		NeowRewardType.THREE_ENEMY_KILL:
			return TEXT[28]
		NeowRewardType.RANDOM_COLORLESS:
			return TEXT[30]
		NeowRewardType.RANDOM_COLORLESS_2:
			return TEXT[31]
	return TEXT[0]

func get_reward_by_category(_category: int) -> Array[NeowRewardType]:
	match _category:
		0:
			return [NeowRewardType.THREE_CARDS, NeowRewardType.ONE_RANDOM_RARE_CARD, NeowRewardType.REMOVE_CARD,
			NeowRewardType.UPGRADE_CARD, NeowRewardType.TRANSFORM_CARD, NeowRewardType.RANDOM_COLORLESS]
		
		1:
			return [NeowRewardType.THREE_SMALL_POTIONS, NeowRewardType.RANDOM_COMMON_RELIC, NeowRewardType.TEN_PERCENT_HP_BONUS,
			NeowRewardType.THREE_ENEMY_KILL, NeowRewardType.HUNDRED_GOLD]
		2:
			var draw_back_options: Array[NeowRewardDrawback] = get_draw_back_options()
			self.draw_back_type = draw_back_options[randi_range(0, draw_back_options.size() - 1)]

			var options: Array[NeowRewardType] = [NeowRewardType.RANDOM_COLORLESS_2]
			if self.draw_back_type != NeowRewardDrawback.CURSE:
				options.append(NeowRewardType.REMOVE_TWO)
			options.append(NeowRewardType.ONE_RARE_RELIC)
			options.append(NeowRewardType.THREE_RARE_CARDS)

			if self.draw_back_type != NeowRewardDrawback.NO_GOLD:
				options.append(NeowRewardType.TWO_FIFTY_GOLD)
			options.append(NeowRewardType.TRANSFORM_TWO_CARDS)

			if self.draw_back_type != NeowRewardDrawback.TEN_PERCENT_HP_LOSS:
				options.append(NeowRewardType.TWENTY_PERCENT_HP_BONUS)

			return options
		3:
			return [NeowRewardType.BOSS_RELIC]
	return []

static func create_by_category(_category: int) -> NeowReward:
	var reward: NeowReward = NeowReward.new()
	reward.hp_bonus = (int)(CardGame.dungeon_main_screen.player.max_health * 0.1)
	var possible_options: Array[NeowRewardType] = reward.get_reward_by_category(_category)
	reward.set_type(possible_options[randi_range(0, possible_options.size() - 1)])
	return reward

static func create_by_mini(_first_mini: bool) -> NeowReward:
	var reward: NeowReward = NeowReward.new()
	reward.hp_bonus = (int)(CardGame.dungeon_main_screen.player.max_health * 0.1)
	if _first_mini:
		reward.type = NeowRewardType.THREE_ENEMY_KILL
	else:
		reward.type = NeowRewardType.TEN_PERCENT_HP_BONUS
	
	reward.option_label = reward.update_desc()

	return reward

static func get_draw_back_options() -> Array[NeowRewardDrawback]:
	return [NeowRewardDrawback.TEN_PERCENT_HP_LOSS, NeowRewardDrawback.NO_GOLD, NeowRewardDrawback.CURSE, NeowRewardDrawback.PERCENT_DAMAGE]
