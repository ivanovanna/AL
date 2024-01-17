page 50108 "Rental Order"
{
    Caption = 'Rental Order';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Rental Order";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Status; Rec.Status)
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ShowMandatory = true;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }

            group(RentalAsset)
            {
                Caption = 'Rental Asset';

                field("Rental Asset No."; Rec."Rental Asset No.")
                {
                    ShowMandatory = true;

                }
                field("Rental Asset Description"; Rec."Rental Asset Description")
                {
                }
                field("Rental Asset Unit No."; Rec."Rental Asset Unit No.")
                {
                    ShowMandatory = true;

                }
                field("Rental Asset Unit Description"; Rec."Rental Asset Unit Description")
                {
                }
            }
            group(RentalPeriod)
            {
                Caption = 'Rental Period';
                field("Rental Start"; Rec."Rental Start")
                {
                    ShowMandatory = true;
                }
                field("Rental End"; Rec."Rental End")
                {
                    ShowMandatory = true;
                }
                field("Rental Days"; Rec."Rental Days")
                {
                    ShowMandatory = true;
                }
            }
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
            group("Posting")
            {
                Caption = 'Posting';
                Image = Post;
                action("Post")
                {
                    Caption = 'Post';
                    Ellipsis = true;
                    Image = PostOrder;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related ledgers in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Rental-Post (Yes/No)", Rec);
                    end;
                }
            }
        }
        area(Reporting)
        {
            action(PrintOrder)
            {
                Caption = 'Print Order';

                trigger OnAction()
                begin
                    Rec.PrintOrder();
                end;
            }
        }
    }

    var
    // myInt: Integer;
}