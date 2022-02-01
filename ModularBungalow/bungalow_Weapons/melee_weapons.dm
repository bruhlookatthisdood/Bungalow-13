/obj/item/melee/baseball_bat/toolbox
	name = "toolbox bat"
	desc = "There ain't a skull in the league that can withstand a toolbox."
	icon = 'ModularBungalow/zbungalowicons/weapons/melee.dmi'
	icon_state = "baseball_toolbox"
	inhand_icon_state = "baseball_toolbox"
	lefthand_file = 'ModularBungalow/zbungalowicons/weapons/melee_lefthand.dmi'
	righthand_file = 'ModularBungalow/zbungalowicons/weapons/melee_righthand.dmi'
	force = 11
	wound_bonus = -12
	hitsound = 'sound/weapons/smash.ogg'
	attack_verb_continuous = list("beats", "smacks", "robusts")
	attack_verb_simple = list("beat", "smack", "robust")
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 2.5)
	can_be_cricket = FALSE

/obj/item/melee/baseball_bat/toolbox/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=11, force_wielded=17)

//BATONS//
/obj/item/melee/classic_baton/telescopic/svet_baton
	name = "Brass Stinger"
	desc = "A compact and foldable electrical baton. Applies light electrical shocks to targets. It has been customized with a vernished and painted food stock, next to a brass frame and silver trim. "
	icon = 'ModularBungalow/zbungalowicons/weapons/melee.dmi'
	icon_state = "svetbaton_0"
	lefthand_file = 'ModularBungalow/zbungalowicons/weapons/melee_lefthand.dmi'
	righthand_file = 'ModularBungalow/zbungalowicons/weapons/melee_righthand.dmi'
	inhand_icon_state = null
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 5
	cooldown = 25
	stamina_damage = 85
	affect_silicon = TRUE
	on_sound = 'sound/weapons/contractorbatonextend.ogg'
	on_stun_sound = 'sound/effects/contractorbatonhit.ogg'
	on_icon_state = "svetbaton_1"
	off_icon_state = "svetbaton_0"
	on_inhand_icon_state = "svetbaton"
	force_on = 16
	force_off = 5
	block_chance = 10
	weight_class_on = WEIGHT_CLASS_NORMAL

/obj/item/melee/classic_baton/telescopic/contractor_baton/get_wait_description()
	return "<span class='danger'>The baton is still charging!</span>"

/obj/item/melee/classic_baton/telescopic/contractor_baton/additional_effects_carbon(mob/living/target, mob/living/user)
	target.Jitter(20)
	target.stuttering += 20

// LETTER OPENER FROM https://github.com/Whitesands13/Whitesands/pull/544
/obj/item/kitchen/knife/letter_opener
    name = "letter opener"
    icon = 'ModularTegustation/Teguicons/kirie_stuff/kirieweapons.dmi'
    icon_state = "letter_opener"
    desc = "A utility used to open letters at great speeds."
    embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
    force = 15
    throwforce = 15

//Captain's katana
/obj/item/katana/captain
	name = "captain's katana"
	desc = "This Captain has some sort of 'class'"
	icon_state = "katana"
	inhand_icon_state = "katana"
	worn_icon_state = "katana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 21
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_chance = 15
	bare_wound_bonus = 5
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF

//Captain's Spear
/obj/item/nullrod/spear/captain
	name = "lance of longinus"
	desc = "The weapon of an angelic captain."
	icon = 'ModularTegustation/Teguicons/kirie_stuff/kirieweapons.dmi'
	icon_state = "longinus"
	inhand_icon_state = "longinus"
	lefthand_file = 'ModularTegustation/Teguicons/kirie_stuff/left.dmi'
	righthand_file = 'ModularTegustation/Teguicons/kirie_stuff/right.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 16
	throwforce = 43
	armour_penetration = 10
	throw_speed = 5
	throw_range = 7
	bare_wound_bonus = 7
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("stabs", "pierces", "slashes")
	attack_verb_simple = list("stab", "pierces", "slash")
	hitsound = 'sound/weapons/bladeslice.ogg'
	embedding = list("embed_chance" = 100, "fall_chance" = 0)
	max_integrity = 200

//Rapier
/obj/item/melee/rapier
	name = "officer's rapier"
	desc = "Somehow even more elegant than the officer's sabre.... you're not too sure if this is any stronger than it"
	icon_state = "rapier"
	inhand_icon_state = "sabre"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	force = 12
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	block_chance = 60
	armour_penetration = 90
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("stabs", "slashes")
	attack_verb_simple = list("stabs", "slashes")
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)
	wound_bonus = 10
	bare_wound_bonus = 32

/obj/item/melee/rapier/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 95, 5) //fast and effective, but as a sword, it might damage the results.

/obj/item/melee/rapier/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

//Rapier Sheath

/obj/item/storage/belt/rapier
	name = "rapier sheath"
	desc = "An ornate sheath designed to hold an officer's blade."
	icon_state = "rsheath"
	inhand_icon_state = "rsheath"
	worn_icon_state = "rsheath"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/rapier/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/rapier
		))

/obj/item/storage/belt/rapier/examine(mob/user)
	. = ..()
	if(length(contents))
		. += "<span class='notice'>Alt-click it to quickly draw the blade.</span>"

/obj/item/storage/belt/rapier/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message("<span class='notice'>[user] takes [I] out of [src].</span>", "<span class='notice'>You take [I] out of [src].</span>")
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/rapier/update_icon_state()
	icon_state = initial(inhand_icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-rapier"
		inhand_icon_state += "-rapier"
		worn_icon_state += "-rapier"

/obj/item/storage/belt/rapier/PopulateContents()
	new /obj/item/melee/rapier(src)
	update_icon()

/obj/item/melee/nano_blade
	name = "nanoforged blade"
	desc = "Glorious nippon steel, folded 1000 times."
	icon = 'ModularTegustation/Teguicons/teguitems.dmi'
	icon_state = "weeb_blade"
	lefthand_file = 'ModularTegustation/Teguicons/teguitems_hold_left.dmi'
	righthand_file = 'ModularTegustation/Teguicons/teguitems_hold_right.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	sharpness = SHARP_EDGED
	force = 25
	throw_speed = 4
	throw_range = 5
	throwforce = 12
	block_chance = 40
	armour_penetration = 50
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "dice", "cut")
	var/primed = FALSE
	var/dash_cooldown // Current cooldown to compare to world.time
	var/dash_cooldown_time = 5 SECONDS // Cooldown time after dash
	var/dash_sound = 'ModularTegustation/Tegusounds/weapons/unsheathed_blade.ogg'
	var/beam_effect = "blood_beam"
	var/phasein = /obj/effect/temp_visual/dir_setting/cult/phase
	var/phaseout = /obj/effect/temp_visual/dir_setting/cult/phase

/obj/item/melee/nano_blade/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 90, 5) //Not made for scalping victims, but will work nonetheless

/obj/item/melee/nano_blade/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = block_chance / 2 //Pretty good...
	return ..()

/obj/item/melee/nano_blade/on_exit_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/nano_blade/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, TRUE)

/obj/item/melee/nano_blade/on_enter_storage(datum/component/storage/concrete/S)
	var/obj/item/storage/belt/nano_blade/B = S.real_location()
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, TRUE)

/obj/item/melee/nano_blade/suicide_act(mob/user)
	if(prob(70))
		user.visible_message("<span class='suicide'>[user] carves deep into [user.p_their()] torso! It looks like [user.p_theyre()] trying to commit seppuku...</span>")
	else
		user.visible_message("<span class='suicide'>[user] carves a grid into [user.p_their()] chest! It looks like [user.p_theyre()] trying to commit sudoku...</span>")
	return (BRUTELOSS)

/obj/item/melee/nano_blade/examine(mob/user)
	. = ..()
	. += "<span class='info'>Use [src] in your hand to prime for a swift dash.</span>"

/obj/item/melee/nano_blade/attack_self(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(primed)
		to_chat(user, "<span class='notice'>You return your stance.</span>")
		primed = FALSE
	else
		if(dash_cooldown > world.time)
			to_chat(user, "<span class='notice'>The [src] isn't ready for another dash attack yet.</span>")
			return
		user.visible_message("<span class='warning'>[user] grips the blade within [src] and primes to attack.</span>", "<span class='warning'>You take an opening stance...</span>", "<span class='warning'>You hear a weapon being drawn...</span>")
		primed = TRUE

/obj/item/melee/nano_blade/afterattack(atom/A, mob/living/user, proximity_flag, params)
	. = ..()
	var/turf/T = get_turf(A)
	if(!T)
		return
	if(primed && dash_cooldown < world.time)
		if(!(T in view(user.client.view, user)))
			return
		primed = FALSE
		dash_cooldown = world.time + dash_cooldown_time
		primed_attack(T, user)

/obj/item/melee/nano_blade/proc/primed_attack(turf/target, mob/living/user)
	var/turf/end = get_turf(user)
	var/turf/start = get_turf(user)
	var/obj/spot1 = new phaseout(start, user.dir)
	// Stolen dash code
	for(var/turf/T in getline(start, get_turf(target)))
		for(var/mob/living/victim in T)
			if(victim != user)
				playsound(victim, 'ModularTegustation/Tegusounds/weapons/anime_slash.ogg', 30, TRUE)
				victim.take_bodypart_damage(15)
		// Unlike actual ninjas, we stop noclip-dashing here.
		if(isclosedturf(T))
			break
		else
			end = T
	user.forceMove(end) // YEET
	playsound(start, dash_sound, 35, TRUE)
	var/obj/spot2 = new phasein(end, user.dir)
	spot1.Beam(spot2, beam_effect, time=20)
	user.visible_message("<span class='warning'>In a flash of red, [user] dashes forward with [user.p_their()] blade!</span>", "<span class='notice'>You dash forward with [src]!</span>", "<span class='warning'>You hear a blade slice through the air at impossible speeds!</span>")


// Sheath
/obj/item/storage/belt/nano_blade
	name = "nanoforged blade sheath"
	desc = "It yearns to bath in the blood of your enemies... but you hold it back!"
	icon = 'ModularTegustation/Teguicons/teguitems.dmi'
	icon_state = "weeb_sheath"
	worn_icon_state = "sheath"
	w_class = WEIGHT_CLASS_BULKY
	force = 3

/obj/item/storage/belt/nano_blade/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/nano_blade
		))

/obj/item/storage/belt/nano_blade/examine(mob/user)
	. = ..()
	if(length(contents))
		. += "<span class='info'>Alt-click it to quickly draw the blade.</span>"

/obj/item/storage/belt/nano_blade/AltClick(mob/user)
	if(!iscarbon(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		playsound(user, 'ModularTegustation/Tegusounds/weapons/unsheathed_blade.ogg', 25, TRUE)
		user.visible_message("<span class='notice'>[user] swiftly draws \the [I].</span>", "<span class='notice'>You draw \the [I].</span>")
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/nano_blade/update_icon_state()
	icon_state = "weeb_sheath"
	worn_icon_state = "sheath"
	if(contents.len)
		icon_state += "-blade"
		worn_icon_state += "-sabre"
		inhand_icon_state = initial(inhand_icon_state)

/obj/item/storage/belt/nano_blade/PopulateContents()
	new /obj/item/melee/nano_blade(src)
	update_icon()

/* 	Add this back later, fuck it
//Katana
/obj/item/melee/ckatana
	name = "captain's katana"
	desc = "This Captain has some sort of 'class'"
	icon_state = "ckatana"
	inhand_icon_state = "ckatana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 21
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")
	block_chance = 15
	sharpness = SHARP_EDGED
	max_integrity = 200
	bare_wound_bonus = 5
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF

/obj/item/melee/sabre/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		final_block_chance = 0 //Don't bring a sword to a gunfight
	return ..()

//Katana Sheath

/obj/item/storage/belt/katana
	name = "katana sheath"
	desc = "A plain, but still menacing purple sheath. Moon runes are written on the side."
	icon_state = "ksheath"
	inhand_icon_state = "ksheath"
	worn_icon_state = "ksheath"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/belt/katana/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1
	STR.rustle_sound = FALSE
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.set_holdable(list(
		/obj/item/melee/ckatana
		))

/obj/item/storage/belt/katana/examine(mob/user)
	. = ..()
	if(length(contents))
		. += "<span class='notice'>Alt-click it to quickly draw the blade.</span>"

/obj/item/storage/belt/rapier/AltClick(mob/user)
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return
	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message("<span class='notice'>[user] takes [I] out of [src].</span>", "<span class='notice'>You take [I] out of [src].</span>")
		user.put_in_hands(I)
		update_icon()
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/storage/belt/katana/update_icon_state()
	icon_state = initial(inhand_icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-katana"
		inhand_icon_state += "-katana"
		worn_icon_state += "-katana"

/obj/item/storage/belt/katana/PopulateContents()
	new /obj/item/melee/ckatana(src)
	update_icon()

	*/
