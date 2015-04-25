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

WITH Ada.Text_Io, Ada.Calendar, Ada.Numerics.Float_Random;
USE Ada.Text_IO, Ada.Calendar, ada.Numerics.Float_Random;


PACKAGE BODY Spacecrafts_Sem IS

   Rand:Generator;
   OfficerArray: OfficerAccessArray(0..3);
   NameArray:OfficerNameArray(0..4):=(HAN_SOLO, JARJAR_BINKS, DARTH_MAUL, YODA, VADER);

   --====================================================================

   TASK BODY Shuttle IS
      Name:ShuttleNameType:=ShuttleName;
      ID:Natural:=ShuttleID;
      Distance:Integer:=0;
      Officer:OfficerAccess;
      OfficerName:OfficerNameType;

      StartMission:Duration;
      StartMissions:Duration;
      EndMission:Duration;
      EndMIssions:Duration;
   BEGIN
      StartMissions:=Seconds(clock);
      FOR I IN 1..5 LOOP
         StartMission:=Seconds(clock);
         Put("Shuttle ");Put(Name);Put(" -> Starting Mission.....");New_line;
         Distance:=Integer(Random(Rand) * 10.0);
         DELAY Duration(Random(Rand) * 15.0);
         Put("Shuttle ");Put(Name);Put(" -> ");PUt("....Returning from mission");New_Line;


         Put("Shuttle ");Put(Name);Put(" -> Landing Control, Requesting access to Landing Officer ");New_Line;
         LandingControl.Secure(Name);
         Officer := OfficerArray(LandingControl.count);
         Officer.GetName(OfficerName);
         Put("Shuttle ");Put(Name);Put(" -> ");Put("Gained access to Officer ");Put(OfficerName);New_Line;


            -- CRITICAL
         Put("Shuttle ");Put(Name);Put(" -> Officer ");Put(OfficerName);Put(", requesting permission to land");New_line;
         Officer.Request(Land,Name);
         FOR I IN 0..Distance LOOP
            Officer.Request(DESCEND, Name);
         END LOOP;
         Officer.Request(Lock,Name);
         Put("Shuttle ");Put(Name);Put(", thanks Officer ");Put(OfficerName);new_line;


         -- END CRITICAL


         Put("Shuttle ");Put(Name);Put(" -> Landing Control, Returning access to Officer "); Put(OfficerName);New_Line;
         OfficerArray(LandingControl.count) := Officer;
         LandingControl.Release(Name);

         EndMission:=Seconds(Clock);

         Put("Shuttle ");Put(Name);Put(" -> Completed Mission in ");Put(EndMission - StartMission);Put(" seconds");New_line;
      END LOOP;
      EndMissions :=Seconds(Clock);
      Put("Shuttle ");Put(name);Put(" -> Completed ALL Missions in ");Put(EndMissions - StartMissions);Put(" seconds");New_line;
   END Shuttle;


   --=================================================================

   TASK BODY Officer IS
      Name:OfficerNameType:=OfficerName;
      ID:Natural:=OfficerID;
   BEGIN
      LandingControl.AddResource;
      Put("Officer ");Put(Name);Put(" -> Available For Assistance");New_line;
      LOOP
         SELECT
            ACCEPT GetName(N: OUT OfficerNameType) DO
               N:= Name;
            END GetName;

            OR

            ACCEPT Request(R: IN RequestType; Shuttle: IN ShuttleNameType) DO
               CASE R IS
                  WHEN LAND =>
                     DELAY Duration(Random(Rand) * 5.0);
                     Put("Officer ");Put(Name);Put(" -> ");Put(" Shuttle ");Put(Shuttle);
                     Put(", you have permission to land. Please begin descent.");new_line;
                  WHEN DESCEND =>
                     DELAY 0.25;
                     Put("Officer ");Put(Name);Put(" -> ");Put(" Shuttle ");Put(Shuttle);
                     Put(", continue descent.");new_line;
                  WHEN LOCK =>
                     DELAY 0.1;
                     Put("Officer ");Put(Name);Put(" -> ");Put(" Shuttle ");Put(Shuttle);
                     Put(", you are locked in. Welcome aboard!");new_line;
               END CASE;
            END Request;


         END SELECT;
      END LOOP;
   END Officer;


   --======================================================================

   PROTECTED BODY LandingControl IS
      ENTRY Secure(Shuttle: IN ShuttleNameType)
          WHEN NumOfficers > 0 IS
      BEGIN
         NumOfficers := NumOfficers - 1;
         Put("Landing Control -> Shuttle ");Put(Shuttle);put(",Officer access granted!");New_Line;
      END Secure;

      PROCEDURE Release(Shuttle: IN ShuttleNameType) IS
      BEGIN
         NumOfficers := NumOfficers + 1;
         Put("Landing Control -> Shuttle ");Put(Shuttle);Put(", officer return accepted");
      END Release;

      PROCEDURE AddResource IS      BEGIN
         NumOfficers := NumOfficers + 1;
      END AddResource;

      FUNCTION Count RETURN Natural IS
      BEGIN

         RETURN NumOfficers;

      END Count;



   END LandingControl;

   --=======================================================================

   PROCEDURE InitializeOfficers(OfficerMax:IN Natural) IS
   BEGIN
      FOR I IN 0..OfficerMax - 1 LOOP
         OfficerArray(I) := NEW Officer(NameArray(I),I);
      END LOOP;
   END InitializeOfficers;



END Spacecrafts_Sem;




