table 50106 "Rental Journal Line"
{
    Caption = 'Rental Journal Line';

    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
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

            trigger OnValidate()
            var
                RentalOrder: Record "Rental Order";
            begin
                if "Rental Order No." <> '' then begin
                    RentalOrder.Get("Rental Order No.");

                    "Customer No." := RentalOrder."Customer No.";
                    "Rental Asset No." := RentalOrder."Rental Asset No.";
                    "Rental Asset Unit No." := RentalOrder."Rental Asset Unit No.";

                    "Shortcut Dimension 1 Code" := RentalOrder."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := RentalOrder."Shortcut Dimension 2 Code";
                    "Dimension Set ID" := RentalOrder."Dimension Set ID";

                    "Rental Start" := RentalOrder."Rental Start";
                    "Rental End" := RentalOrder."Rental End";
                    "Rental Days" := RentalOrder."Rental Days";
                end;
            end;
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

            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";
            end;
        }

        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';

            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";
            end;
        }

        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental Days" <> 0) then
                    "Rental End" := "Rental Start" + "Rental Days";
            end;
        }
        field(34; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(35; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
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

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
            Clustered = true;
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin

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

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            Rec, "Dimension Set ID", StrSubstNo('Rental Journal Line %1', "Line No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure EmptyLine(): Boolean
    begin
        exit(("Rental Order No." = '') and ("Rental Start" = 0D) and ("Rental End" = 0D) and ("Rental Days" = 0));
    end;

}