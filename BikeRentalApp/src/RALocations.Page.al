page 50101 "RA Locations"
{
    AdditionalSearchTerms = 'rental asset locations departments sites offices';
    ApplicationArea = All;
    Caption = 'RA Locations';
    PageType = List;
    SourceTable = "RA Location";
    UsageCategory = Administration;
    Editable= false;
    CardPageId = "RA Location Card";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a location code for the rental asset.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the rental asset location.';
                }
                field("Maps Coordinates Latitude"; Rec."Maps Coordinates Latitude")
                {

                }
                field("Maps Coordinates Longitude"; Rec."Maps Coordinates Longitude")
                {

                }

            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

