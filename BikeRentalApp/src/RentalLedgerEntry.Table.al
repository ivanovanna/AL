table 50107 "Rental Ledger Entry"
{
    Caption = 'Rental Ledger Entry';
    DrillDownPageID = "Rental Ledger Entries";
    LookupPageID = "Rental Ledger Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Entry Type"; Enum "Rental Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(4; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(10; "Rental Order No."; Code[20])
        {
            Caption = 'Rental Order No.';
            TableRelation = "Rental Order"."No.";
        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
        field(12; "Rental Asset No."; Code[20])
        {
            Caption = 'Rental Asset No.';
            TableRelation = "Rental Asset"."No.";
        }
        field(13; "Rental Asset Unit No."; Code[20])
        {
            Caption = 'Rental Asset Unit No.';
            TableRelation = "Rental Asset Unit"."RA Unit No." where("Rental Asset No." = field("Rental Asset No."));
        }
        field(15; "Rental Start"; Date)
        {
            Caption = 'Rental Start';
        }

        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';
        }

        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';
        }
        field(20; "Days (Expected)"; Integer)
        {
            Caption = 'Days (Expected)';
        }
        field(21; "Days (Actual)"; Integer)
        {
            Caption = 'Days (Actual)';
        }
        field(22; "Days (Invoiced)"; Integer)
        {
            Caption = 'Days (Invoiced)';
        }

        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            // Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Entry Type", "Rental Order No.")
        {
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    var
        _RentalLedgerEntry: Record "Rental Ledger Entry";
    begin
        if "Entry No." = 0 then begin
            _RentalLedgerEntry.Reset();
            if _RentalLedgerEntry.FindLast() then
                "Entry No." := _RentalLedgerEntry."Entry No." + 1
            else
                "Entry No." := 1;
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure ShowDimensions()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption(), "Entry No."));
    end;

    procedure CopyFromRentalJnlLine(RentalJnlLine: Record "Rental Journal Line")
    begin
        "Entry Type" := RentalJnlLine."Entry Type";
        "Document No." := RentalJnlLine."Document No.";
        "Posting Date" := RentalJnlLine."Posting Date";

        "Rental Order No." := RentalJnlLine."Rental Order No.";
        "Customer No." := RentalJnlLine."Customer No.";
        "Rental Asset No." := RentalJnlLine."Rental Asset No.";
        "Rental Asset Unit No." := RentalJnlLine."Rental Asset Unit No.";

        "Rental Start" := RentalJnlLine."Rental Start";
        "Rental End" := RentalJnlLine."Rental End";
        "Rental Days" := RentalJnlLine."Rental Days";

        "Shortcut Dimension 1 Code" := RentalJnlLine."Shortcut Dimension 1 Code";
        "Shortcut Dimension 2 Code" := RentalJnlLine."Shortcut Dimension 2 Code";
        "Dimension Set ID" := RentalJnlLine."Dimension Set ID";
    end;

}