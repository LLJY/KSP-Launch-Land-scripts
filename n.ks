clearscreen.
lock radarOffset to 6.9223.	 				// The value of alt:radar when landed (on gear)
lock trueRadar to alt:radar - radarOffset.			// Offset radar to get distance from gear to ground
lock g to constant:g * body:mass / body:radius^2.		// Gravity (m/s^2)
set maxDecel to (ship:availablethrust / ship:mass) - g.	// Maximum deceleration possible (m/s^2)
set stopDist to ship:verticalspeed^2 / (2 * maxDecel).		// The distance the burn will require
set idealThrottle to stopDist / trueRadar.			// Throttle required for perfect hoverslam
set impactTime to trueRadar / abs(ship:verticalspeed).		// Time until impact, used for landing gear

WAIT UNTIL ship:verticalspeed < -1.
	set maxDecel to (ship:availablethrust / ship:mass) - g.	// Maximum deceleration possible (m/s^2)
	set stopDist to ship:verticalspeed^2 / (2 * maxDecel).		// The distance the burn will require
	set idealThrottle to stopDist / trueRadar.			// Throttle required for perfect hoverslam
	print "Preparing for hoverslam...".
	rcs on.
	brakes on.
	lock steering to srfretrograde.
	when impactTime < 3 then {gear on.}

WAIT UNTIL trueRadar < stopDist.
	set maxDecel to (ship:availablethrust / ship:mass) - g.	// Maximum deceleration possible (m/s^2)
	set stopDist to ship:verticalspeed^2 / (2 * maxDecel).		// The distance the burn will require
	set idealThrottle to stopDist / trueRadar.			// Throttle required for perfect hoverslam
	print "Performing hoverslam".
	lock throttle to idealThrottle.

WAIT UNTIL ship:verticalspeed > -0.01.
	print "Hoverslam completed".
	set ship:control:pilotmainthrottle to 0.
	rcs off.