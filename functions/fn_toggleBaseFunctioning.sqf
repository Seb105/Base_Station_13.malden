/*
THIS SCRIPT TURNS ALL BASE FUNCTIONS ON OR OFF. USED IF GENERATORS ARE BROKEN
*/

BS_BASEFUNCTIONLOOP = [] spawn {
   private _baseLights = (getMissionLayerEntities "baseLights") select 0;
   while {true} do {
      // power on
      waitUntil {sleep 5; BS_GENERATORS_ON};
      {
         _x setDamage 0
      } forEach _baseLights;
      
      // power off
      waitUntil {sleep 5; !BS_GENERATORS_ON};
      {
         _x setDamage 0.97
      } forEach _baseLights;
   };
};
