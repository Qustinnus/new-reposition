//This file was auto-corrected by findeclaration.exe on 25.5.2012 20:42:32

/obj/item/weapon/implantcase
	name = "glass case"
	desc = "A case containing an implant."
	icon = 'icons/obj/items.dmi'
	icon_state = "implantcase-0"
	item_state = "implantcase"
	throw_speed = 1
	throw_range = 5
	w_class = 1.0
	var/obj/item/weapon/implant/implant = null

/obj/item/weapon/implantcase/New()
	..()
	if(ispath(implant))
		implant = new implant(src)
		update_icon()

/obj/item/weapon/implantcase/update_icon()
	if(implant)
		src.icon_state = "implantcase-[implant.implant_color]"
	else
		src.icon_state = "implantcase-0"
	..()

/obj/item/weapon/implantcase/attackby(obj/item/weapon/I as obj, mob/user as mob)
	..()
	if (istype(I, /obj/item/weapon/pen))
		var/t = input(user, "What would you like the label to be?", text("[]", src.name), null)  as text
		if (user.get_active_hand() != I)
			return
		if((!in_range(src, usr) && src.loc != user))
			return
		t = sanitizeSafe(t, MAX_NAME_LEN)
		if(t)
			src.name = "Glass Case - '[t]'"
		else
			src.name = "Glass Case"
	else if(istype(I, /obj/item/weapon/reagent_containers/syringe))
		if(!implant)
			return
		if(!implant.allow_reagents)
			return
		if(implant.reagents.total_volume >= implant.reagents.maximum_volume)
			user << "<span class='warning'>\The [src] is full.</span>"
		else
			spawn(5)
				I.reagents.trans_to_obj(implant, 5)
				user << "<span class='notice'>You inject 5 units of the solution. The syringe now contains [I.reagents.total_volume] units.</span>"
	else if (istype(I, /obj/item/weapon/implanter))
		var/obj/item/weapon/implanter/M = I
		if(implant.is_external())
			return
		if(M.implant)
			if (implant || M.implant.implanted)
				return
			M.implant.forceMove(src)
			src.implant = M.implant
			M.implant = null
			update_icon()
			M.update_icon()
		else
			if(implant && !M.implant)
				implant.forceMove(M)
				M.implant = implant
				implant = null
				update_icon()
				M.update_icon()
