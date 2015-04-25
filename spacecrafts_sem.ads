WITH Ada.Text_IO; USE Ada.Text_Io;

PACKAGE Spacecrafts_Sem IS

   TYPE RequestType IS (LAND, DESCEND, LOCK);
   TYPE ShuttleNameType IS (STAR_DESTROYER, TROOP_TRANSPORT, X_WING, A_WING, ARC_170_STARFIGHTER, B_WING, VULTURE_DROID, DROID_TRI_FIGHTER, E_WING, HORNET_INTERCEPTOR);
   TYPE OfficerNameType IS (HAN_SOLO, JARJAR_BINKS, DARTH_MAUL, YODA, VADER);

   PACKAGE Duration_IO IS NEW Ada.Text_IO.Fixed_IO(Duration);
   PACKAGE Integer_IO IS NEW Ada.Text_IO.Integer_IO(Integer);
   PACKAGE Shuttle_Name_IO IS NEW Ada.Text_IO.Enumeration_IO(ShuttleNameType);
   PACKAGE Officer_Name_IO IS NEW Ada.Text_IO.Enumeration_IO(OfficerNameType);
   USE Duration_IO, Integer_IO, Shuttle_Name_IO, Officer_Name_IO;

   TASK TYPE Shuttle(ShuttleName: ShuttleNameType; ShuttleID: Integer);
   TASK TYPE Officer(OfficerName: OfficerNameType; OfficerID: Integer) IS
      ENTRY Request(R: IN RequestType; Shuttle: IN ShuttleNameType);
      ENTRY GetName(N: Out OfficerNameType);
   END Officer;

   TYPE ShuttleAccess IS ACCESS Shuttle;
   TYPE OfficerAccess IS ACCESS Officer;

   TYPE OfficerAccessArray IS ARRAY(Integer RANGE <>) OF OfficerAccess;
   TYPE OfficerNameArray IS Array(Integer RANGE<>) OF OfficerNameType;

   TYPE ShuttleAccessArray is Array(Integer RANGE <>) OF ShuttleAccess;
   TYPE ShuttleNameArray IS ARRAY(Integer RANGE <>) OF ShuttleNameType;

   PROTECTED LandingControl IS
      ENTRY Secure(Shuttle: IN ShuttleNameType);
      PROCEDURE Release(Shuttle: IN ShuttleNameType);
      PROCEDURE AddResource;
      Function Count return Natural;
      PRIVATE
         NumOfficers:Natural:=0;
   END LandingControl;

   PROCEDURE InitializeOfficers(OfficerMax:Natural);


END Spacecrafts_Sem;

