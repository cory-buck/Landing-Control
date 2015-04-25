--The MIT License (MIT)
--
--Copyright (c) 2015 Cory Buck
--
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





