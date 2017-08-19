set MY_VESS to SHIP.
lock trueradar to 6.814.
until alt:radar < 75000 {
print "waiting".
}
clearscreen.
until 0 {
	sas off.
	rcs on.
	brakes on.
    LOCK STEERING TO -velocity:surface.
	set grava to ship:body:mu / ship:body:position:mag ^ 2.
	set mass to ship:mass * grava.
	set ratio to mass / ship:availablethrust.
	set truer to alt:radar - trueradar.
	set impacttime to truer / ship:verticalspeed.
	set acc to ship:verticalspeed / impacttime.
	set force to mass * acc.
	set ft to force / ship:availablethrust.
	print ft at (5,0).
	print grava at (5, 10).
	print mass at (5, 30).
	set gear to truer<100.
	if ft > 0.98 {
		print "Landing Burn Has Started" at (5,20).
			lock throttle to ft.
						}
							
	if truer < 0.1 { 
		clearscreen.
		print "The Falcon Has Landed" at (5,20).
		lock throttle to 0.
		brakes off.
		rcs off.
		break.
			     }
		}
