page 50107 "Rental Orders"
{
    Caption = 'Rental Orders';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rental Order";
    Editable = false;
    CardPageId = "Rental Order";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("Customer No."; Rec."Customer No.")
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
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Release Order';

                trigger OnAction()
                begin
                    Rec.ReleaseOrder();
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen Order';

                trigger OnAction()
                begin
                    Rec.ReOpenOrder()
                end;
            }
            action(Print)
            {
                Caption = 'Print Order';

                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }
        }
    }
}