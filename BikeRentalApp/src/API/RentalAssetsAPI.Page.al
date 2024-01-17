
page 50113 "Rental Assets API"
{
    PageType = API;
    Caption = 'Rental Assets';
    APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'rentalAsset';
    EntitySetName = 'rentalAssets';
    SourceTable = "Rental Asset";
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
                    Caption = 'systemId', Locked = true;
                }
                field(no; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(searchDescription; Rec."Search Description")
                {
                }
                field(raClassId; Rec."RA Class Id")
                {
                }
                field(raClassCode; Rec."RA Class Code")
                {
                }
                field(responsibleEmployee; Rec."Responsible Employee")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(blocked; Rec.Blocked)
                {
                }
                part(rentalAssetUnits; "Rental Asset Units API")
                {
                    ApplicationArea = All;
                    Caption = 'Rental Asset Units';
                    EntityName = 'rentalAssetUnit';
                    EntitySetName = 'rentalAssetUnits';
                    SubPageLink = "Rental Asset Id" = FIELD(SystemId);
                }
            }
        }
    }
}