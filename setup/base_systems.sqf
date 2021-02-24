BS_GENERATORS_ON = (isEngineOn generator_0 OR isEngineOn generator_1);

BS_FUEL_HANDLE_LOOP = [] spawn {
    BS_FUEL_AMOUNT = BS_FUEL_START;
    BS_FUEL_HASFUEL = true;
    // each tank provides fuel storage. As these are destroyed fuel is used quicker.
    private _fuelUsagePerTick = 1/(BS_MISSION_LENGTH/3);
    private _currentFuelUsage = _fuelUsagePerTick;

    private _generators = [generator_0,generator_1];

    while {true} do {
        /*

        FUEL SECTION

        */
        private _time = time;
        // checks if generator engines are on, this is how it is decided if base has power.
        BS_GENERATORS_ON = (isEngineOn generator_0 OR isEngineOn generator_1);
        publicVariable "BS_GENERATORS_ON";

        // keep generator fuel equalling total fuel available.
        {
            [_x,BS_FUEL_AMOUNT] remoteExec ["setFuel"];
        } forEach [generator_0,generator_1];

        // only do all this if generators are working.
        if (BS_GENERATORS_ON) then {
            private _oldFuelAmount = CEIL(BS_FUEL_AMOUNT*10);

            // as fuel tanks are destroyed, use fuel quicker
            private _workingFuelTanksRatio = 3/(count ([fuel_tank_0,fuel_tank_1,fuel_tank_2] select {alive _x}));
            _currentFuelUsage = _fuelUsagePerTick*_workingFuelTanksRatio;

            // update fuel amount
            BS_FUEL_AMOUNT = BS_FUEL_AMOUNT - _currentFuelUsage;
            if (BS_FUEL_AMOUNT <= 0) then {BS_FUEL_AMOUNT = 0};

            // base announcement for fuel levels
            private _newFuelAmount = CEIL(BS_FUEL_AMOUNT*10);
            if (_newFuelAmount != _oldFuelAmount) then {
                private _fuelUpdateString = format ["<t color='#ff0000'>BASE BROADCAST: FUEL IS BELOW %1 PERCENT</t>",_newFuelAmount*10];
                _fuelUpdateString remoteExec ["systemChat"];
            };

            // if base power reaches 0 lights out my dude
            if (BS_FUEL_HASFUEL && BS_FUEL_AMOUNT == 0) then {
                BS_FUEL_HASFUEL = false;
                // [false] call BS13_fnc_toggleBaseFunctioning;
                private _basePowerOffString = "<t color=''#ff0000'>BASE BROADCAST: BASE POWER IS OFFLINE DUE TO FUEL SCHORTAGE</t>";
                _basePowerOffString remoteExec ["systemChat"];
            };
        };
        // systemchat amount of fuel left in steps of 10%
        private _fuelLeftSeconds = BS_FUEL_AMOUNT/_currentFuelUsage;
        "marker_fuelTanks" setMarkerText str format ["Fuel Storage (%1:%2 stored)",floor(_fuelLeftSeconds/60),ceil(_fuelLeftSeconds%60)];
        "marker_generators" setMarkerText str format ["Generators (%1 of 2 online)",count (_generators select {isEngineOn _x})];
        /*

        END OF FUEL SECTION

        */
        waitUntil {time >= _time + 1};
    };
};
