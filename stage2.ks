stage.
sas off.
rcs on.
lock throttle to 0.
set Ap to 100000.
set Pe to 100000.
set section to 1.
set fairing to 0.
until section = 0 {

	if section = 1 {
		lock throttle to 1.
		set targetPitch to max( 5, 90 * (1 - ALT:RADAR / 50000)). 
            //Pitch over gradually until levelling out to 5 degrees at 50km
        lock steering to heading ( 90, targetPitch).
		if (SHIP:ALTITUDE > 70000) and (fairing = 0) {
			print "Fairing Seperation".
			stage.
			set fairing to 1.
			}
		if SHIP:APOAPSIS > Ap {
            set section to 2.
										  }
				   }
				   
	else if section = 2 {
		lock steering to heading ( 90, 3). //Stay pointing 3 degrees above horizon
        lock throttle to 0. //Engines off.
        if (SHIP:ALTITUDE > 70000) and (ETA:APOAPSIS > 30) and (VERTICALSPEED > 0) {
            if WARP = 0 {        // If we are not time warping
                wait 1.         //Wait to make sure the ship is stable
                SET WARP TO 3. //Be really careful about warping
										
						}
						}
						
		else if ETA:APOAPSIS < 30 {
            SET WARP to 0.
            set section to 3.
            }
						}
	
	else if section = 3 {
		set warp to 0.
		wait 1.
		set orbitBody to body("Kerbin").
		set deltaA to maxthrust/mass.
		set orbitalVelocity to orbitBody:radius * sqrt(9.8/(orbitBody:radius + Pe)).
		set deltaV to (orbitalVelocity - velocity:orbit:mag).
		set timeToBurn to deltaV/deltaA.
		set circNode to node(time:seconds + eta:apoapsis,0,0,deltaV).
		add circNode.
		lock steering to burnTo.
		set burnTo to circNode:burnvector.
		when circNode:eta < timeToBurn/2 then {
		set statusMsg to "Circularizing. V=" + round(orbitalVelocity) + "m/s, T=" + timeToBurn + "s.".
		lock throttle to 1.
		when velocity:orbit:mag > orbitalVelocity then {
		  lock throttle to 0.
		  unlock steering.
		  print "Payload Seperation".
		  stage.
		  }
		  }
							
								}
						}
					
