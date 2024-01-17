
page 50114 "Rental Asset Units API"
{
    PageType = API;
    Caption = 'Rental Asset Units';
    APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'rentalAssetUnit';
    EntitySetName = 'rentalAssetUnits';
    SourceTable = "Rental Asset Unit";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System Id', Locked = true;
                }

                field(rentalAssetNo; Rec."Rental Asset No.")
                {
                }
                field(raUnitNo; Rec."RA Unit No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(raLocationId; Rec."RA Location Id")
                {
                }
                field(raLocationCode; Rec."RA Location Code")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }

            }
        }
    }
}