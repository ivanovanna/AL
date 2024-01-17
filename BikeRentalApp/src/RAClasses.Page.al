page 50102 "RA Classes"
{
    ApplicationArea = All;
    Caption = 'RA Classes';
    PageType = List;
    SourceTable = "RA Class";
    UsageCategory = Administration;

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
                    ToolTip = 'Specifies a code for the class that the rental asset belongs to.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the rental asset class.';
                }
                field("Default RA Location Code"; Rec."Default RA Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location of the rental asset.';
                }
            }
        }
        // area(factboxes)
        // {
        //     systempart(Control1900383207; Links)
        //     {
        //         ApplicationArea = RecordLinks;
        //         Visible = false;
        //     }
        //     systempart(Control1905767507; Notes)
        //     {
        //         ApplicationArea = Notes;
        //         Visible = false;
        //     }
        // }
    }

    actions
    {
    }
}

