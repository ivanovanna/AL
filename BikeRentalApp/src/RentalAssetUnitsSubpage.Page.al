page 50104 "Rental Asset Units Subpage"
{
    Caption = 'Rental Asset Units Subpage';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Rental Asset Unit";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Rental Asset No."; Rec."Rental Asset No.")
                {
                    Visible = False;
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
        // area(Factboxes)
        // {

        // }
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