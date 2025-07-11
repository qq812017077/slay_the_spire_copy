class_name AbstractDungeons
extends Object


# random
var monsterRng: RandomNumberGenerator
var mapRng: RandomNumberGenerator
var eventRng: RandomNumberGenerator
var merchantRng: RandomNumberGenerator
var cardRng: RandomNumberGenerator
var treasureRng: RandomNumberGenerator
var relicRng: RandomNumberGenerator
var potionRng: RandomNumberGenerator
var monsterHpRng: RandomNumberGenerator
var aiRng: RandomNumberGenerator
var shuffleRng: RandomNumberGenerator
var cardRandomRng: RandomNumberGenerator
var miscRng: RandomNumberGenerator

var name: String
var level_num: String
var id: String
var player: AbstractPlayer
var transformedCard: AbstractCard
var eventBackgroundImg: TextureRect


var bossKey: String

# chance
var cardUpgradedChance: float
var colorlessRareChance: float
var shopRoomChance: float
var restRoomChance: float
var eventRoomChance: float
var eliteRoomChance: float
var treasureRoomChance: float
var smallChestChance: float
var mediumChestChance: float
var largeChestChance: float
var commonRelicChance: float
var uncommonRelicChance: float
var rareRelicChance: float
