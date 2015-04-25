--The MIT License (MIT)

--Copyright (c) 2015 Cory Buck

--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:

--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.

--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.

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

