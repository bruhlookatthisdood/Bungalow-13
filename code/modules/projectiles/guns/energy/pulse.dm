/obj/item/gun/energy/pulse
	name = "P-04 Pulse Rifle"
	desc = "A heavy-duty, multifaceted energy rifle with three modes. Preferred by front-line combat personnel."
	icon_state = "pulse"
	inhand_icon_state = null
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	force = 10
	modifystate = TRUE
	flags_1 =  CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse, /obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	cell_type = "/obj/item/stock_parts/cell/pulse"

/obj/item/gun/energy/pulse/emp_act(severity)
	return

/obj/item/gun/energy/pulse/prize
	pin = /obj/item/firing_pin

/obj/item/gun/energy/pulse/prize/Initialize()
	. = ..()
	AddElement(/datum/element/point_of_interest)
	var/turf/T = get_turf(src)

	message_admins("A pulse rifle prize has been created at [ADMIN_VERBOSEJMP(T)]")
	log_game("A pulse rifle prize has been created at [AREACOORD(T)]")

	notify_ghosts("Someone won a pulse rifle as a prize!", source = src, action = NOTIFY_ORBIT, header = "Pulse rifle prize")

/obj/item/gun/energy/pulse/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/carbine
	name = "P-05 Pulse Rifle"
	desc = "A compact variant of the pulse rifle with less firepower but easier storage."
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "pulse_carbine"
	worn_icon_state = "gun"
	inhand_icon_state = null
	cell_type = "/obj/item/stock_parts/cell/pulse/carbine"
	can_flashlight = TRUE
	flight_x_offset = 18
	flight_y_offset = 12

/obj/item/gun/energy/pulse/carbine/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/destroyer
	name = "P-06 Pulse Destroyer"
	desc = "A heavy-duty energy rifle built for pure destruction."
	worn_icon_state = "pulse"
	cell_type = "/obj/item/stock_parts/cell/infinite"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pulse)

/obj/item/gun/energy/pulse/destroyer/attack_self(mob/living/user)
	to_chat(user, "<span class='danger'>[src.name] has three settings, and they are all DESTROY.</span>")

/obj/item/gun/energy/pulse/pistol
	name = "P-24 Pulse Pistol"
	desc = "A pulse rifle in an easily concealed handgun package with low capacity."
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	icon_state = "pulse_pistol"
	worn_icon_state = "gun"
	inhand_icon_state = "gun"
	cell_type = "/obj/item/stock_parts/cell/pulse/pistol"

/obj/item/gun/energy/pulse/pistol/loyalpin
	pin = /obj/item/firing_pin/implant/mindshield

/obj/item/gun/energy/pulse/pistol/m1911
	name = "P-25 Pulse M1911"
	desc = "A compact pulse core in a classic handgun frame for Nanotrasen officers. It's not the size of the gun, it's the size of the hole it puts through people."
	icon_state = "m1911"
	inhand_icon_state = "gun"
