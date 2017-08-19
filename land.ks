set MY_VESS to SHIP.
lock trueradar to 6.9545.
local KSCLaunchPad is latlng(-0.0972080884740584, -74.5576970966038).
until alt:radar < 75000 {
print "waiting".
}
set section to 1.
sas off.
rcs on.
brakes on.
clearscreen.
SET SHIP:CONTROL:FORE to 0.
lock fore to ship:facing:vector. //fore and aft point to the nose and tail
if section = 1	{
    print"sec 1".
	until section = 2 {
		set ratio to mass / ship:availablethrust.
		set BoostBackVector to (KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT + ship:altitude *1.05)).
		lock steering to (KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT + ship:altitude *1.05)).
		
		if VANG( BoostBackVector, fore) < 25 {
			lock throttle to 1 / ratio * 3.
											 }
		else {
			lock throttle to 1.
			 }
	    set SurfaceVelocityV to VELOCITY:SURFACE.
		if SurfaceVelocityV:MAG  > BoostBackVector:MAG / 55 and VANG( BoostBackVector, VELOCITY:SURFACE) < 18{ 
			print "bb stop".
			lock throttle to 0. 
			set section to 3.
			break.
			}
			}
	until section = 3 { //Coast to the boost back complete target
		print "sec2".
		lock throttle to 0.
		lock steering to (VELOCITY:SURFACE * -1).
		if KSCLAUNCHPAD:DISTANCE < 30000{ //30000 is the most tested value {
			set section to 3.
        }
    }  
					
if section = 3 {
	print "sec3".
	until 0 {
		SET vKSCLAUNCHPAD TO VECDRAWARGS(
					  KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT+500),
					  KSCLAUNCHPAD:POSITION - KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT+500),
					  red, "LANDING TARGET", 1, true).
		
		SET vLANDINGPATH TO VECDRAWARGS(
					  V(0,0,0),
					  KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT+10),
					  yellow, 
					  "GO THIS WAY", 1, true).
		
		SET vSURFACEV TO VECDRAWARGS(
					  V(0,0,0),
					  VELOCITY:SURFACE,
					  blue, 
					  "SURFACE VELOCITY", 1, true).
		
		lock steering to (KSCLAUNCHPAD:ALTITUDEPOSITION(KSCLAUNCHPAD:TERRAINHEIGHT+10)).
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
				}
				}
