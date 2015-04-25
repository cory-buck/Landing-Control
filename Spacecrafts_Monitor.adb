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

WITH Ada.Text_IO, Ada.Numerics.Float_Random, ada.Calendar;
USE Ada.Text_IO, ada.numerics.Float_Random, ada.Calendar;

PACKAGE BODY Spacecrafts_Monitor IS

   rand: Generator;

   TASK BODY Shuttle IS
      Name: ShuttleNameType := ShuttleName;
      Id: Integer := ShuttleId;
      CurrOfficer:OfficerAccess;
      OfficerName: OfficerNameType;
      Distance: Integer;

      StartMission:Duration;
      EndMission:Duration;
      StartAllMissions:Duration;
      EndAllMissions:Duration;
   BEGIN
      StartAllMissions := Seconds(clock);
      FOR I IN Integer RANGE 1..5 LOOP
         StartMission := seconds(clock);
         Put("Shuttle ");Put(Name);Put(" -> Starting Mission");New_Line;
         Distance := Integer(Random(Rand) * 10.0);
         DELAY Duration(Random(Rand) * 5.0);
         Put("Shuttle ");Put(Name);Put(" -> End of Mission");New_Line;

         Put("Shuttle ");Put(Name);Put("  -> Landing Control, requesting access to officer");New_Line;
         LandingControl.AccessOfficer(CurrOfficer, Name);
         CurrOfficer.GetName(OfficerName);
         Put("Shuttle ");Put(Name);Put(" -> Landing Control, accessed ");Put(OfficerName);New_Line;

         Put("Shuttle "); Put(Name);Put(" -> Officer ");Put(OfficerName);Put(", requesting permission to land");New_Line;
         CurrOfficer.Request(Land,Name);

         Put("Shuttle "); Put(Name);Put(" -> Officer ");Put(OfficerName);Put(", beginning descent");New_Line;
         FOR D IN Integer RANGE 0..Distance LOOP
            CurrOfficer.Request(Descend,Name);
         END LOOP;

         CurrOfficer.Request(Lock,Name);

         Put("Shuttle ");Put(Name);Put("  -> Landing Control, returning access to officer ");Put(OfficerName);New_Line;
         LandingControl.ReturnOfficer(CurrOfficer, Name);

         EndMission := Seconds(Clock);
         Put("Shuttle ");Put(Name);Put(" -> MISION AND LANDING COMPLETE IN ");Put(EndMission - StartMission);Put(" seconds");New_Line;
      END LOOP;
      EndAllMissions := Seconds(clock);
      Put("Shuttle ");Put(Name);Put(" -> ALL MISSIONS COMPLETE ");Put(EndAllMissions - StartAllMissions);Put(" seconds");New_Line;
   END Shuttle;

   --===============================================================================

   TASK BODY Officer IS
      Name: OfficerNameType := OfficerName;
      Id: Integer := OfficerId;
   BEGIN
      Put("Officer ");Put(Name);Put(" -> Available for assistance");new_line;
      LOOP
         SELECT
            ACCEPT GetName(Offname: OUT OfficerNameType) DO
               Offname := name;
            END GetName;
         OR
            ACCEPT Request(R: IN RequestType; Shuttle: IN ShuttleNameType) DO
               CASE R IS
                  WHEN Land =>
                     DELAY Duration(Random(Rand) * 2.0);
                     Put("Officer ");Put(Name);Put(" -> Shuttle ");Put(Shuttle);Put(", permission to land accepted, begin descent");New_Line;
                  WHEN Descend =>
                     DELAY 0.25;
                     Put("Officer ");Put(Name);Put(" -> Shuttle ");Put(Shuttle);Put(", continue descent");New_Line;
                  WHEN Lock =>
                     Put("Officer ");Put(Name);Put(" -> Shuttle ");Put(Shuttle);Put(", locked in. Welcome aboard!");New_Line;
               END CASE;
            END Request;
         END SELECT;

      END LOOP;
   END Officer;

   --==================================================================================

   PROTECTED BODY LandingControl IS

      ENTRY NewOfficer(Off: IN OfficerAccess)
         WHEN PoolSize < OfficerPool'Length IS
      BEGIN
         OfficerPool(PoolSize) := Off;
         PoolSize := PoolSize + 1;
      END NewOfficer;

      ENTRY ReturnOfficer(Off: IN OfficerAccess; Shuttle: IN ShuttleNameType)
         WHEN PoolSize < OfficerPool'Length IS
      BEGIN
         Put("Landing Control -> Shuttle ");Put(Shuttle);Put(", Officer Return is accepted");New_Line;
         OfficerPool(PoolSize) := Off;
         PoolSize := PoolSize + 1;
      END ReturnOfficer;

      ENTRY AccessOfficer(Off: OUT OfficerAccess; Shuttle: IN ShuttleNameType)
            WHEN PoolSize /= 0 IS
      BEGIN
         Put("Landing Control -> Shuttle ");Put(Shuttle);Put(", Officer Access is Authorized");New_Line;
         PoolSize := PoolSize - 1;
         Off := OfficerPool(PoolSize);

      END AccessOfficer;

   END LandingControl;

end Spacecrafts_Monitor;
