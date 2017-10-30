/obj/travellocation
  name = "travel spot"
  density = FALSE
  opacity = FALSE
  anchored = TRUE
  icon = 'icons/obj/travel.dmi'
  icon_state = "travelpoint"
  var/id //Set this to the same

/obj/travellocation/New()
  travel_point_list += src

/obj/travellocation/Destroy()
  travel_point_list -= src

/obj/travellocation/Crossed(mob/M)
  var/obj/travellocation/target
  for(var/i in travel_point_list)
    var/obj/travellocation/T = i
    if(T.z != z)
      if(T.id == id)
        target = T
        break
  if(target)
    src << "<span class='notice'>You start travelling in this direction</span>"
    if(do_after(M,200))
      src << "<span class='notice'>You succesfuly travel to the area</span>"
      M.forceMove(get_turf(target))
