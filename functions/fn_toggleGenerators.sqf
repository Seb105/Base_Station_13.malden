_this addAction
[
    "Turn Generator On",    // title
    {
        params ["_target", "_caller", "_actionId", "_arguments"]; // script
      if (fuel _target > 0) then {
         [_target,true] remoteExec ["engineOn"];
      } else {
         hint "Generator has no fuel"
      };
    },
    nil,        // arguments
    1.5,        // priority
    true,        // showWindow
    false,        // hideOnUse
    "",            // shortcut
    "!isEngineOn _target",     // condition
    15,            // radius
    false,        // unconscious
    "",            // selection
    ""            // memoryPoint
];
_this addAction
[
    "Turn Generator Off",    // title
    {
        params ["_target", "_caller", "_actionId", "_arguments"]; // script
      [_target,false] remoteExec ["engineOn"];
    },
    nil,        // arguments
    1.5,        // priority
    true,        // showWindow
    false,        // hideOnUse
    "",            // shortcut
    "isEngineOn _target",     // condition
    15,            // radius
    false,        // unconscious
    "",            // selection
    ""            // memoryPoint
];
