class_name CardLibrary
extends Node

enum LibraryType {RED, GREEN, BLUE, PURPLE, CURSE, COLORLESS}

static var cards_by_id: Dictionary = {}
static var red_cards_by_id: Dictionary = {}
static var green_cards_by_id: Dictionary = {}
static var blue_cards_by_id: Dictionary = {}
static var purple_cards_by_id: Dictionary = {}
static var curses_cards_by_id: Dictionary = {}
static var colorless_cards_by_id: Dictionary = {}

static var red_cards: int = 0
static var green_cards: int = 0
static var blue_cards: int = 0
static var purple_cards: int = 0
static var colorless_cards: int = 0
static var curse_cards: int = 0

static var total_cards_count: int = 0



static func initialize() -> void:

	add_red_cards()
	add_green_cards()
	add_blue_cards()
	add_purple_cards()
	add_colorless_cards()
	add_curse_cards()


static func get_card_list(library_type: LibraryType) -> Array:
	match library_type:
		LibraryType.RED:
			return red_cards_by_id.values()
		LibraryType.GREEN:
			return green_cards_by_id.values()
		LibraryType.BLUE:
			return blue_cards_by_id.values()
		LibraryType.PURPLE:
			return purple_cards_by_id.values()
		LibraryType.COLORLESS:
			return colorless_cards_by_id.values()
		LibraryType.CURSE:
			return curses_cards_by_id.values()
	
	return []

static func add_red_cards() -> void:
	add_card(StrikeRed.new())
	add_card(Bash.new())
	add_card(DefendRed.new())
	add_card(Clash.new())
	add_card(BodySlam.new())

	add_card(PommelStrike.new())
	add_card(TwinStrike.new())
	add_card(TrueGrit.new())
	add_card(Headbutt.new())
	add_card(PerfectedStrike.new())

	add_card(Anger.new())
	add_card(Warcry.new())
	add_card(Armaments.new())
	add_card(Flex.new())
	add_card(WildStrike.new())

	add_card(Havoc.new())
	add_card(ShrugItOff.new())
	add_card(HeavyBlade.new())
	add_card(Clothesline.new())
	add_card(IronWave.new())

	add_card(ThunderClap.new())
	add_card(Cleave.new())
	add_card(SwordBoomerang.new())
	add_card(Uppercut.new())
	add_card(BloodForBlood.new())

	add_card(DualWield.new())
	add_card(Sentinel.new())
	add_card(InfernalBlade.new())
	add_card(Intimidate.new())
	add_card(Entrench.new())

	add_card(GhostlyArmor.new())
	add_card(Hemokinesis.new())
	add_card(BattleTrance.new())
	add_card(Rupture.new())
	add_card(Bloodletting.new())

	add_card(SeverSoul.new())
	add_card(Whirlwind.new())
	add_card(FeelNoPain.new())
	add_card(RecklessCharge.new())
	add_card(Rampage.new())

	add_card(Carnage.new())
	add_card(FireBreathing.new())
	add_card(FlameBarrier.new())
	add_card(SearingBlow.new())
	add_card(Inflame.new())

	add_card(BurningPact.new())
	add_card(Rage.new())
	add_card(SeeingRed.new())
	add_card(PowerThrough.new())
	add_card(Disarm.new())



	add_card(Combust.new())
	add_card(SpotWeakness.new())
	add_card(Evolve.new())
	add_card(Pummel.new())
	add_card(SecondWind.new())

	add_card(Metallicize.new())
	add_card(Shockwave.new())
	add_card(DropKick.new())
	add_card(DarkEmbrace.new())
	add_card(Juggernaut.new())

	add_card(DoubleTap.new())
	add_card(Exhume.new())
	add_card(Barricade.new())
	add_card(Impervious.new())
	add_card(FiendFire.new())

	add_card(DemonForm.new())
	add_card(Reaper.new())
	add_card(Brutality.new())
	add_card(Immolate.new())
	add_card(Feed.new())
	
	add_card(Berserk.new())
	add_card(Offering.new())
	add_card(LimitBreak.new())
	add_card(Corruption.new())
	add_card(Bludgeon.new())
	
static func add_green_cards() -> void:
	add_card(Accuracy.new())
	add_card(Acrobatics.new())
	add_card(Adrenaline.new())
	add_card(AfterImage.new())
	add_card(Alchemize.new())
	add_card(AllOutAttack.new())
	add_card(AThousandCuts.new())
	add_card(Backflip.new())
	add_card(Backstab.new())
	add_card(Bane.new())
	add_card(BladeDance.new())
	add_card(Blur.new())
	add_card(BouncingFlask.new())
	add_card(BulletTime.new())
	add_card(Burst.new())
	add_card(CalculatedGamble.new())
	add_card(Caltrops.new())
	add_card(Catalyst.new())
	add_card(Choke.new())
	add_card(CloakAndDagger.new())
	add_card(Concentrate.new())
	add_card(CorpseExplosion.new())
	add_card(CripplingPoison.new())
	add_card(DaggerSpray.new())
	add_card(DaggerThrow.new())
	add_card(Dash.new())
	add_card(DeadlyPoison.new())
	add_card(DefendGreen.new())
	add_card(Deflect.new())
	add_card(DieDieDie.new())
	add_card(Distraction.new())
	add_card(DodgeAndRoll.new())
	add_card(Doppelganger.new())
	add_card(EndlessAgony.new())
	add_card(Envenom.new())
	add_card(EscapePlan.new())
	add_card(Eviscerate.new())
	add_card(Expertise.new())
	add_card(Finisher.new())
	add_card(Flechettes.new())
	add_card(FlyingKnee.new())
	add_card(Footwork.new())
	add_card(GlassKnife.new())
	add_card(GrandFinale.new())
	add_card(HeelHook.new())
	add_card(InfiniteBlades.new())
	add_card(LegSweep.new())
	add_card(Malaise.new())
	add_card(MasterfulStab.new())
	add_card(Neutralize.new())
	add_card(Nightmare.new())
	add_card(NoxiousFumes.new())
	add_card(Outmaneuver.new())
	add_card(PhantasmalKiller.new())
	add_card(PiercingWail.new())
	add_card(PoisonedStab.new())
	add_card(Predator.new())
	add_card(Prepared.new())
	add_card(QuickSlash.new())
	add_card(Reflex.new())
	add_card(RiddleWithHoles.new())
	add_card(Setup.new())
	add_card(Skewer.new())
	add_card(Slice.new())
	add_card(StormOfSteel.new())
	add_card(StrikeGreen.new())
	add_card(SuckerPunch.new())
	add_card(Survivor.new())
	add_card(Tactician.new())
	add_card(Terror.new())
	add_card(ToolsOfTheTrade.new())
	add_card(SneakyStrike.new())
	add_card(Unload.new())
	add_card(WellLaidPlans.new())
	add_card(WraithForm.new())

static func add_blue_cards() -> void:
	add_card(Aggregate.new())
	add_card(AllForOne.new())
	add_card(Amplify.new())
	add_card(AutoShields.new())
	add_card(BallLightning.new())
	add_card(Barrage.new())
	add_card(BeamCell.new())
	add_card(BiasedCognition.new())
	add_card(Blizzard.new())
	add_card(BootSequence.new())
	add_card(Buffer.new())
	add_card(Capacitor.new())
	add_card(Chaos.new())
	add_card(Chill.new())
	add_card(Claw.new())
	add_card(ColdSnap.new())
	add_card(CompileDriver.new())
	add_card(ConserveBattery.new())
	add_card(Consume.new())
	add_card(Coolheaded.new())
	add_card(CoreSurge.new())
	add_card(CreativeAI.new())
	add_card(Darkness.new())
	add_card(DefendBlue.new())
	add_card(Defragment.new())
	add_card(DoomAndGloom.new())
	add_card(DoubleEnergy.new())
	add_card(Dualcast.new())
	add_card(EchoForm.new())
	add_card(Electrodynamics.new())
	add_card(Fission.new())
	add_card(ForceField.new())
	add_card(FTL.new())
	add_card(Fusion.new())
	add_card(GeneticAlgorithm.new())
	add_card(Glacier.new())
	add_card(GoForTheEyes.new())
	add_card(Heatsinks.new())
	add_card(HelloWorld.new())
	add_card(Hologram.new())
	add_card(HyperBeam.new())
	add_card(Leap.new())
	add_card(LockOn.new())
	add_card(Loop.new())
	add_card(MachineLearning.new())
	add_card(Melter.new())
	add_card(MeteorStrike.new())
	add_card(MultiCast.new())
	add_card(Overclock.new())
	add_card(Rainbow.new())
	add_card(Reboot.new())
	add_card(Rebound.new())
	add_card(Recursion.new())
	add_card(Recycle.new())
	add_card(ReinforcedBody.new())
	add_card(Reprogram.new())
	add_card(RipAndTear.new())
	add_card(Scrape.new())
	add_card(Seek.new())
	add_card(SelfRepair.new())
	add_card(Skim.new())
	add_card(Stack.new())
	add_card(StaticDischarge.new())
	add_card(SteamBarrier.new())
	add_card(Storm.new())
	add_card(Streamline.new())
	add_card(StrikeBlue.new())
	add_card(Sunder.new())
	add_card(SweepingBeam.new())
	add_card(Tempest.new())
	add_card(ThunderStrike.new())
	add_card(Turbo.new())
	add_card(Equilibrium.new())
	add_card(WhiteNoise.new())
	add_card(Zap.new())

static func add_purple_cards() -> void:
	add_card(Alpha.new())
	add_card(BattleHymn.new())
	add_card(Blasphemy.new())
	add_card(BowlingBash.new())
	add_card(Brilliance.new())
	add_card(CarveReality.new())
	add_card(Collect.new())
	add_card(Conclude.new())
	add_card(ConjureBlade.new())
	add_card(Consecrate.new())
	add_card(Crescendo.new())
	add_card(CrushJoints.new())
	add_card(CutThroughFate.new())
	add_card(DeceiveReality.new())
	add_card(DefendWatcher.new())
	add_card(DeusExMachina.new())
	add_card(DevaForm.new())
	add_card(Devotion.new())
	add_card(EmptyBody.new())
	add_card(EmptyFist.new())
	add_card(EmptyMind.new())
	add_card(Eruption.new())
	add_card(Establishment.new())
	add_card(Evaluate.new())
	add_card(Fasting.new())
	add_card(FearNoEvil.new())
	add_card(FlurryOfBlows.new())
	add_card(FlyingSleeves.new())
	add_card(FollowUp.new())
	add_card(ForeignInfluence.new())
	add_card(Foresight.new())
	add_card(Halt.new())
	add_card(Indignation.new())
	add_card(InnerPeace.new())
	add_card(Judgment.new())
	add_card(JustLucky.new())
	add_card(LessonsLearned.new())
	add_card(LikeWater.new())
	add_card(MasterReality.new())
	add_card(Meditate.new())
	add_card(MentalFortress.new())
	add_card(Nirvana.new())
	add_card(Omniscience.new())
	add_card(Perseverance.new())
	add_card(Pray.new())
	add_card(PressurePoints.new())
	add_card(Prostrate.new())
	add_card(Protect.new())
	add_card(Ragnarok.new())
	add_card(ReachHeaven.new())
	add_card(Rushdown.new())
	add_card(Sanctity.new())
	add_card(SandsOfTime.new())
	add_card(SashWhip.new())
	add_card(Scrawl.new())
	add_card(SignatureMove.new())
	add_card(SimmeringFury.new())
	add_card(SpiritShield.new())
	add_card(StrikePurple.new())
	add_card(Study.new())
	add_card(Swivel.new())
	add_card(TalkToTheHand.new())
	add_card(Tantrum.new())
	add_card(ThirdEye.new())
	add_card(Tranquility.new())
	add_card(Vault.new())
	add_card(Vigilance.new())
	add_card(Wallop.new())
	add_card(WaveOfTheHand.new())
	add_card(Weave.new())
	add_card(WheelKick.new())
	add_card(WindmillStrike.new())
	add_card(Wish.new())
	add_card(Worship.new())
	add_card(WreathOfFlame.new())

static func add_colorless_cards() -> void:
	add_card(Apotheosis.new())
	add_card(BandageUp.new())
	add_card(Blind.new())
	add_card(Chrysalis.new())
	add_card(DarkShackles.new())
	add_card(DeepBreath.new())
	add_card(Discovery.new())
	add_card(DramaticEntrance.new())
	add_card(Enlightenment.new())
	add_card(Finesse.new())
	add_card(FlashOfSteel.new())
	add_card(Forethought.new())
	add_card(GoodInstincts.new())
	add_card(HandOfGreed.new())
	add_card(Impatience.new())
	add_card(JackOfAllTrades.new())
	add_card(Madness.new())
	add_card(Magnetism.new())
	add_card(MasterOfStrategy.new())
	add_card(Mayhem.new())
	add_card(Metamorphosis.new())
	add_card(MindBlast.new())
	add_card(Panacea.new())
	add_card(Panache.new())
	add_card(PanicButton.new())
	add_card(Purity.new())
	add_card(SadisticNature.new())
	add_card(SecretTechnique.new())
	add_card(SecretWeapon.new())
	add_card(SwiftStrike.new())
	add_card(TheBomb.new())
	add_card(ThinkingAhead.new())
	add_card(Transmutation.new())
	add_card(Trip.new())
	add_card(Violence.new())
	
	add_card(Burn.new())
	add_card(Dazed.new())
	add_card(Slimed.new())
	add_card(VoidCard.new())
	add_card(Wound.new())
	
	add_card(Apparition.new())
	add_card(Beta.new())
	add_card(Bite.new())
	add_card(JAX.new())
	add_card(Insight.new())
	add_card(Miracle.new())
	add_card(Omega.new())
	add_card(RitualDagger.new())
	add_card(Safety.new())
	add_card(Shiv.new())
	add_card(Smite.new())
	add_card(ThroughViolence.new())
	add_card(BecomeAlmighty.new())
	add_card(FameAndFortune.new())
	add_card(LiveForever.new())
	add_card(Expunger.new())

static func add_curse_cards() -> void:
	add_card(AscendersBane.new())
	add_card(CurseOfTheBell.new())
	add_card(Clumsy.new())
	add_card(Decay.new())
	add_card(Doubt.new())
	add_card(Injury.new())
	add_card(Necronomicurse.new())
	add_card(Normality.new())
	add_card(Pain.new())
	add_card(Parasite.new())
	add_card(Pride.new())
	add_card(Regret.new())
	add_card(Shame.new())
	add_card(Writhe.new())


static func add_card(card: AbstractCard) -> void:
	match card.color:
		AbstractCard.CardColor.RED:
			red_cards += 1
			red_cards_by_id.set(card.card_id, card)
		AbstractCard.CardColor.GREEN:
			green_cards += 1
			green_cards_by_id.set(card.card_id, card)
		AbstractCard.CardColor.BLUE:
			blue_cards += 1
			blue_cards_by_id.set(card.card_id, card)
		AbstractCard.CardColor.PURPLE:
			purple_cards += 1
			purple_cards_by_id.set(card.card_id, card)
		AbstractCard.CardColor.COLORLESS:
			colorless_cards += 1
			colorless_cards_by_id.set(card.card_id, card)
		AbstractCard.CardColor.CURSE:
			curse_cards += 1
			curses_cards_by_id.set(card.card_id, card)
	
	cards_by_id.set(card.card_id, card)
	total_cards_count += 1
	return


static func generate_cards() -> void:
	# print AbstractCard.card_atlas.regions_by_name
	var card_scripts_path = "res://scripts/cards/"
	for key: String in AbstractCard.card_atlas.regions_by_name.keys():
		var splits = key.split('/')
		var color: String = ""
		var type: String = ""
		var card_name: String = ""
		if splits.size() == 3:
			color = splits[0]
			type = splits[1]
			card_name = splits[2]
		elif splits.size() == 2:
			type = splits[0]
			color = "colorless" if color == "status" else "curse"
			card_name = splits[1]
		else:
			continue
		var file_path = card_scripts_path + color + "/" + card_name + ".gd"

		if ResourceLoader.exists(file_path):
			print("Card script found: " + file_path)
			continue
		
		var file = FileAccess.open(file_path, FileAccess.WRITE)
		if file == null:
			print("Failed to open file: " + file_path)
			continue
		
		var card_class_name = card_name.capitalize().replace(" ", "")
		file.store_line("class_name " + card_class_name)
		file.store_line("extends AbstractCard")
		file.store_line("")
		file.store_line("static var card_string: CardString = null")
		file.store_line("static var ID :String = \"" + card_class_name + "\"")
		file.store_line("")
		file.store_line("")
		file.store_line("")
		file.store_line("func _init() -> void:")
		file.store_line("	if card_string == null:")
		file.store_line("		card_string = CardGame.languagePack.get_card_string(ID)")
		if splits.size() == 2:
			if color == "colorless":
				file.store_line("	super(\"" + card_class_name + "\", card_string.name, \"" + type + "/" + card_name + "\", -2, card_string.description, CardType." + type.to_upper() + ", CardColor." + color.to_upper() + ", CardRarity.COMMON, CardTarget.NONE)")
			else:
				file.store_line("	super(\"" + card_class_name + "\", card_string.name, \"" + type + "/" + card_name + "\", -2, card_string.description, CardType." + type.to_upper() + ", CardColor." + color.to_upper() + ", CardRarity." + type.to_upper() + ", CardTarget.NONE)")
		else:
			file.store_line("	super(\"" + card_class_name + "\", card_string.name, \"" + color + "/" + type + "/" + card_name + "\", 0, card_string.description, CardType." + type.to_upper() + ", CardColor." + color.to_upper() + ", CardRarity.COMMON, CardTarget.NONE)")

		# end	
		file.close()
		print("Generated card script: " + file_path)


