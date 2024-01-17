page 50109 "Rental Journal"
{
    Caption = 'Rental Journal';
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Rental Journal Line";

    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Line No.")
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

    actions
    {
        area(Processing)
        {
            group("Posting")
            {
                Caption = 'Posting';
                Image = Post;

                action(Post)
                {
                    Caption = 'Post';
                    Image = PostBatch;
                    ShortCutKey = 'F9';
                    ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related ledgers in your company books.';

                    trigger OnAction()
                    begin
                        CODEUNIT.Run(CODEUNIT::"Rental Jnl.-Post", Rec);
                        CurrPage.Update(false);
                    end;
                }

            }
        }
    }
}