page 50105 "Rental Asset List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rental Asset";
    Editable = false;
    CardPageId = "Rental Asset Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the rental asset.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description for the rental asset.';
                }
                field("RA Class Code"; Rec."RA Class Code")
                {
                    ToolTip = 'Specifies the class that the rental asset belongs to';
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(Factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin

        //         end;
        //     }
        // }
    }
}