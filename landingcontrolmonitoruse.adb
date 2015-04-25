WITH Ada.Text_IO, ada.Integer_Text_IO;
USE Ada.Text_io, ada.Integer_Text_IO;

WITH Spacecrafts_Monitor; Use Spacecrafts_Monitor;

PROCEDURE LandingControlMonitorUse IS
   NumShuttles: Integer;
   NumOfficers: Integer;

   OfficerNames : OfficerNameArray(0..3) := (HAN_SOLO, JARJAR_BINKS, DARTH_MAUL, VADER);
   ShuttleNames : ShuttleNameArray(0..9) := (STAR_DESTROYER, TROOP_TRANSPORT, X_WING, A_WING, ARC_170_STARFIGHTER, B_WING, VULTURE_DROID, DROID_TRI_FIGHTER, E_WING, HORNET_INTERCEPTOR);

BEGIN
   Put("Starting up lab2");New_Line(2);
   Put("How many shuttles would you like? ");Get(NumShuttles);New_Line;
   Put("How many officers would you like? ");Get(NumOfficers);New_Line;
   Put("Loading ");Put(NumShuttles);Put(" shuttles and ");
   Put(NumOfficers);Put(" officers");New_Line;
   Declare
      Shuttles: Array(0..NumShuttles-1) of ShuttleAccess;
   BEGIN
      FOR I IN Integer RANGE 0..NumOfficers-1 LOOP
         LandingControl.NewOfficer(NEW Officer(OfficerNames(I), I));
      END LOOP;

      FOR I IN Integer RANGE 0..NumShuttles-1 LOOP
         Shuttles(I) := NEW Shuttle(ShuttleNames(I), I);
      END LOOP;
   END;

END LandingControlMonitorUse;

