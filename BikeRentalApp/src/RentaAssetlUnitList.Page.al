page 50106 "Rental Asset Unit List"
{
    Caption = 'Rental Asset Units';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rental Asset Unit";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Rental Asset No."; Rec."Rental Asset No.")
                {
                }
                field("RA Unit No."; Rec."RA Unit No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("RA Location Code"; Rec."RA Location Code")
                {
                }
                field("Serial No."; Rec."Serial No.")
                {
                }
                field(Blocked; Rec.Blocked)
                {
                }
            }
        }
        area(Factboxes)
        {

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