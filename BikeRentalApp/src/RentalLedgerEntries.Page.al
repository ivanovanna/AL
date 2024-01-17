page 50110 "Rental Ledger Entries"
{
    PageType = List;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Rental Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Entry Type"; Rec."Entry Type")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
                field("Rental Order No."; Rec."Rental Order No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Rental Asset No."; Rec."Rental Asset No.")
                {
                }
                field("Rental Asset Unit No."; Rec."Rental Asset Unit No.")
                {
                }
                field("Rental Start"; Rec."Rental Start")
                {
                }
                field("Rental End"; Rec."Rental End")
                {
                }
                field("Rental Days"; Rec."Rental Days")
                {
                }
                field("Days (Expected)"; Rec."Days (Expected)")
                {
                }
                field("Days (Actual)"; Rec."Days (Actual)")
                {
                }
                field("Days (Invoiced)"; Rec."Days (Invoiced)")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
            }
        }

        // area(Factboxes)
        // {

        // }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction();
    //             begin

    //             end;
    //         }
    //     }
    // }
}