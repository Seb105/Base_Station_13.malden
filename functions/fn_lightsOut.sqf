/*
 * Author: CNTO
 * Toggles lights on and off around position. Run only on server. Compile it before use by putting this in init.sqf:
 * fnc_toggleLights = compile preprocessFileLineNumbers "lights.sqf";
 *
 * Arguments:
 * 0: Use true for lights on, false for lights off. <BOOLEAN>
 * 1: Position around which lights will be toggled. <POSITION>
 * 2: Radius around position where lights will be toggled. Defaults to 500m. <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, getMarkerPos "LightsMarker2", 1000] spawn fnc_toggleLights;
 * Turns lights on 1000m around the position of marker "LightsMarker2".
 *
 * Public: Yes
 */
params ["_onoff", "_position", ["_distance", 250]];
private _types = ["lamps_base_f", "powerlines_base_f", "land_powerpolewooden_f", "land_lampharbour_f", "land_lampshabby_f", "land_powerpolewooden_l_f", "land_powerpolewooden_small_f", "land_lampdecor_f", "land_lamphalogen_f", "land_lampsolar_f", "land_lampstreet_small_f", "land_lampstreet_f", "land_lampairport_f", "land_powerpolewooden_l_f"];
private _catEyes = ["Land_Flush_Light_green_F","Land_Flush_Light_red_F","Land_Flush_Light_yellow_F","Land_runway_edgelight","Land_runway_edgelight_blue_F"];

private _damage_value = 0;

if (_onoff) then {
    _damage_value = 0;
} else {
    _damage_value = 0.97;
};
{
    private _type = _x;
    private _lamps = _position nearObjects [_type, _distance];
    {
        _x setDamage _damage_value;
    } forEach _lamps;
    sleep 0.1;
} forEach _types;


{
    private _catEye = _position nearObjects [_x, _distance];
    {
       _x hideObjectGlobal !_onoff;
    } forEach _catEye;
    sleep 0.1;
} forEach _catEyes;
