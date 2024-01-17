page 50103 "Rental Asset Card"
{
    Caption = 'Rental Asset Card';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Rental Asset";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies a description of the rental asset.';
                }
                field("Search Description"; Rec."Search Description")
                {
                    ToolTip = 'Specifies a search description for the rental asset.';
                }
                field("RA Class Code"; Rec."RA Class Code")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies the class that the rental asset belongs to.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies which employee is responsible for the rental asset.';
                }
                field(Blocked; Rec.Blocked)
                {
                    Importance = Promoted;
                    ToolTip = 'Specifies that the related record is blocked from being posted in transactions, for example a customer that is declared insolvent or an item that is placed in quarantine.';
                }
                field("No. Series"; Rec."No. Series")
                {
                }
            }

            part(RentalAssetUnits; "Rental Asset Units Subpage")
            {
                ApplicationArea = All;
                Caption = 'Rental Asset Units';
                SubPageLink = "Rental Asset No." = FIELD("No.");
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

        //         trigger OnAction()
        //         begin

        //         end;
        //     }
        // }
    }

    var
    // myInt: Integer;
}