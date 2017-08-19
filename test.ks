sas off.
rcs off.
lock throttle to 0.
set Ap to 400000.
set Pe to 400000.
set section to 1.

until section = 0 {

	if section = 1 {
		print "Lift off!".
		lock steering to up.
		lock throttle to 1.
		stage.
		set section to 2.
				   }
	else if section = 2 {
		print "Falcon has cleared the pad".
		lock steering to heading (90,90).
		wait until ship:altitude > 7000.
			set section to 3.
						}
	
	else if section = 3 {
		print "MAX-Q".
		set targetPitch to max( 5, 90 * (1 - ALT:RADAR / 50000)). 
            //Pitch over gradually until levelling out to 5 degrees at 50km
        lock steering to heading ( 90, targetPitch). //Heading 90' (East), then target pitch           
						}
    
	LIST ENGINES in engines.							
	if SHIP:AVAILABLETHRUST = 0
	{
		break.
	}
	
	}
	
run stage2.
		