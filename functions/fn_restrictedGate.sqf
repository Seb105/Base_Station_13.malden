params ["_gate","_accessLevel"];
_gate setVariable ["BIS_disabled_door_1",1];
[
	_gate,											// Object the action is attached to
	"Unlock Gate",										// Title of the action
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Idle icon shown on screen
	"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_secure_ca.paa",	// Progress icon shown on screen
	"_this distance _target < 5",						// Condition for the action to be shown
	"_caller distance _target < 5 AND (uniform player in [])",						// Condition for the action to progress
	{},													// Code executed when action starts
	{},													// Code executed on every progress tick
	{_target spawn {
		_this setVariable ["BIS_disabled_door_1",0];
		[_this,1,1] call BIS_fnc_Door;
		sleep 5;
		[_this,1,0] call BIS_fnc_Door;
		_this setVariable ["BIS_disabled_door_1",1];
	}},				// Code executed on completion
	{hint "I need to proper uniform to enter."},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	2,													// Action duration [s]
	0,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state
] call BIS_fnc_holdActionAdd;
