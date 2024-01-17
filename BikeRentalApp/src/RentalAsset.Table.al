table 50103 "Rental Asset"
{
    Caption = 'Rental Asset';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "Rental Asset List";
    LookupPageID = "Rental Asset List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    RentalSetup.Get();
                    NoSeriesMgt.TestManual(RentalSetup."Rental Asset Nos.");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                if ("Search Description" = UpperCase(xRec.Description)) or ("Search Description" = '') then
                    "Search Description" := Description;
            end;
        }
        field(3; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
        }
        field(4; "RA Class Code"; Code[10])
        {
            Caption = 'RA Class Code';
            TableRelation = "RA Class";

            trigger OnValidate()
            var 
            _RAClass: Record "RA Class";
            begin
                if  "RA Class Code" = '' then begin
                    Clear("RA Class Id");
                exit;
                end;
                if not _RAClass.Get("RA Class Code") then
                exit;
                "RA Class Id" := _RAClass.SystemId;
            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(7; "Responsible Employee"; Code[20])
        {
            Caption = 'Responsible Employee';
            TableRelation = Employee;
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }

          field(10; "RA Class Id"; Guid)
        {
            Caption = 'RA Class Id';
            TableRelation = "RA Class".SystemId;

             trigger OnValidate()
            var 
            _RAClass: Record "RA Class";
            begin
                if not IsNullGuid("RA Class Id") then
                _RAClass.GetBySystemId("RA Class Id");
                "RA Class Code":= _RAClass.Code;
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Description")
        {
        }
        key(Key3; "RA Class Code")
        {
        }
        key(Key4; "Global Dimension 1 Code")
        {
        }
        key(Key5; "Global Dimension 2 Code")
        {
        }
        key(Key6; Description)
        {
        }
    }

    var
        RentalSetup: Record "Rental Setup";
        RentalAsset: Record "Rental Asset";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        InitRANo();
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        if not IsTemporary then begin
            DimMgt.SaveDefaultDim(DATABASE::"Rental Asset", "No.", FieldNumber, ShortcutDimCode);
            Modify(true);
        end;
    end;

    procedure AssistEdit(OldRA: Record "Rental Asset") Result: Boolean
    begin
        RentalAsset := Rec;
        RentalSetup.Get();
        RentalSetup.TestField("Rental Asset Nos.");
        if NoSeriesMgt.SelectSeries(RentalSetup."Rental Asset Nos.", OldRA."No. Series", RentalAsset."No. Series") then begin
            NoSeriesMgt.SetSeries(RentalAsset."No.");
            Rec := RentalAsset;
            exit(true);
        end;
    end;

    local procedure InitRANo()
    begin
        if "No." = '' then begin
            RentalSetup.Get();
            RentalSetup.TestField("Rental Asset Nos.");
            NoSeriesMgt.InitSeries(RentalSetup."Rental Asset Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;


}