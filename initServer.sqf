BS_INIT_DONE = false;
publicVariable "INIT_DONE";

["Initialize"] call BIS_fnc_dynamicGroups;
BS_MISSION_LENGTH = 3600;

//var is from 0 to 1.
BS_FUEL_START = 0.35;
BS_GENERATORS_WORKING = true;

// randomises weather
/*
0 setOvercast random(1);
0 setRain random(1);
0 setFog [random(1), 0.01, 0];
forceWeatherChange;
BS_MISSION_LENGTH setOvercast random(1);
BS_MISSION_LENGTH setFog [random(1), 0.01, 0];
BS_MISSION_LENGTH setRain random(1);
*/


// turns all lights on island off
[false, [6400, 6400, 0], 6400] call BS13_fnc_lightsOut;

// turns the base on
private _initHandle1 = execVM "setup\base_systems.sqf";
private _initHandle2 = [getMarkerPos "marker_base",750] execVM "setup\fixDomes.sqf";
call BS13_fnc_toggleBaseFunctioning;
waitUntil {scriptDone _initHandle1 && scriptDone _initHandle2};
["INIT COMPLETED"] remoteExec ["systemChat"];
