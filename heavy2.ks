stage.
sas off.
rcs off.
lock throttle to 0.
set Ap to 400000.
set Pe to 400000.
set section to 3.

until section = 0 {
	
	if section = 3 {
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
		