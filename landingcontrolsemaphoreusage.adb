WITH Ada.Text_IO, ada.Integer_Text_IO, spacecrafts_sem;
USE Ada.Text_IO, ada.Integer_Text_IO, Spacecrafts_Sem;


PROCEDURE LandingControlSemaphoreUsage IS
   Num_Shuttles:Natural:=0;
   Num_Officers:Natural:=0;
   NameArray:ShuttleNameArray(1..10):=(STAR_DESTROYER, TROOP_TRANSPORT, X_WING, A_WING, ARC_170_STARFIGHTER, B_WING, VULTURE_DROID, DROID_TRI_FIGHTER, E_WING, HORNET_INTERCEPTOR);
   Shuttles:ShuttleAccessArray(1..10);
BEGIN
   Put("How Many Shuttles?");Get(Num_Shuttles);New_Line;
   Put("How many Officers?");Get(Num_Officers);New_Line;
   Put("....Initializing ");Put(Num_Shuttles);Put(" shuttles");New_Line;
   Put(".....Initializing ");Put(Num_Officers);Put(" officers");New_Line(2);

   InitializeOfficers(Num_Officers);

   FOR I IN 1..Num_Shuttles LOOP
      Shuttles(I):= NEW Shuttle(NameArray(I),I);
   END LOOP;


end LandingControlSemaphoreUsage;





