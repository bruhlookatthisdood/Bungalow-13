// ==You need to add the icons in "icons/obj/drinks.dmi" or you will have problems with the broken bottles==
//Bottles
/obj/item/reagent_containers/food/drinks/bottle/terremoto
	name = "Terremoto"
	desc = "Drink until you feel like in a earthquake"
	icon_state = "terremotobottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/terremoto = 100)

/obj/item/reagent_containers/food/drinks/bottle/pisco
	name = "Pisco"
	desc = "The chilean blood"
	icon_state = "piscobottle"
	list_reagents = list(/datum/reagent/consumable/ethanol/pisco = 100)

//SODA CANS
/obj/item/reagent_containers/food/drinks/soda_cans/tula
	name = "Tula"
	desc = "What does the name matters?"
	icon_state = "tula_can"
	list_reagents = list(/datum/reagent/consumable/tula = 20)
	foodtype = SUGAR | JUNKFOOD
