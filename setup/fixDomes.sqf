// fixes ruined malden base

params ["_centre","_distance"];
private _types = [
["dome_01_big_green_ruins_v1_F.p3d","Land_Dome_Big_F"],
["dome_01_big_green_ruins_v2_F.p3d","Land_Dome_Big_F"],
["dome_01_small_green_ruins_F.p3d","Land_Dome_Small_F"]
];
{
    private _object = _x;
    private _objectStr = typeOf _object;

    if ("V2" in _objectStr OR "ruins" in _objectStr OR "derelict" in _objectStr OR "broken" in _objectStr) then {
        private _strArray = (_objectStr splitString "_") apply {
            if (_x == "V2") then {
                _x = "V3";
            };

            if (_x in ["ruins","derelict","Broken"]) then {
                _x = "";
            };
            _x;
        };
        _objectStr = (_strArray select {_x != ""}) joinString "_";
        private _dir  = getDir _object;
        private _pos = getPos _object;
        hideObjectGlobal _object;
        private _newObject = _objectStr createVehicle _pos;
        _newObject setDir _dir;
    };

    private _modelInfo = (getModelInfo _x) select 0;
    {
        _x params ["_originalModel","_replaceClass"];
        if (_modelInfo == _originalModel) then {
            private _dir  = getDir _object;
            private _pos = getPos _object;
            _object hideObjectGlobal true;
            private _newObject = _replaceClass createVehicle _pos;
            _newObject setDir _dir;
        };
    } forEach _types;

} forEach (nearestTerrainObjects [_centre,[],_distance]);
