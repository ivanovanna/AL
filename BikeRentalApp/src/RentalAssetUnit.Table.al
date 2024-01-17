table 50104 "Rental Asset Unit"
{
    Caption = 'Rental Asset Unit';
    DrillDownPageID = "Rental Asset Unit List";
    LookupPageID = "Rental Asset Unit List";

    fields
    {
        field(1; "Rental Asset No."; Code[20])
        {
            Caption = 'Rental Asset No.';
            NotBlank = true;
            TableRelation = "Rental Asset";
        }
        field(2; "RA Unit No."; Code[20])
        {
            Caption = 'Rental Asset Unit No.';
            NotBlank = true;

            trigger OnValidate()
            var
                RentalAsset: Record "Rental Asset";
                RAClass: Record "RA Class";
            begin
                if Rec."Rental Asset No." = '' then
                    exit;

                RentalAsset.Get(Rec."Rental Asset No.");
                RentalAsset.TestField("RA Class Code");
                RAClass.Get(RentalAsset."RA Class Code");
                RAClass.TestField("Default RA Location Code");

                // Rec."RA Location Code" := RAClass."Default RA Location Code";
                Rec.Validate("RA Location Code", RAClass."Default RA Location Code");
            end;
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "RA Location Code"; Code[10])
        {
            Caption = 'RA Location Code';
            DataClassification = CustomerContent;
            TableRelation = "RA Location";

            trigger OnValidate()
            var 
            _RALocation: Record "RA Location";
            begin
                if  "RA Location Code" = '' then begin
                    Clear("RA Location Id");
                exit;
                end;
                if not _RALocation.Get("RA Location Code") then
                exit;
                "RA Location Id" := _RALocation.SystemId;
            end;
        }
        field(5; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
        }
        field(6; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
          field(7;"RA Location Id";  Guid)
        {
            Caption = 'RA Location Id';
            TableRelation = "RA Location".SystemId;

            trigger OnValidate()
            var 
            _RALocation: Record "RA Location";
            begin
                if not IsNullGuid("RA Location Id") then
                _RALocation.GetBySystemId("RA Location Id");
                "RA Location Code":= _RALocation.Code;
            end;
        }
        field(8; "Rental Asset Id"; Guid)
        {
            Caption = 'Rental Asset Id';
            TableRelation = "Rental Asset".SystemId;

        }
    }

    keys
    {
        key(Key1; "Rental Asset No.", "RA Unit No.")
        {
            Clustered = true;
        }
    }

    var
    // myInt: Integer;

    trigger OnInsert()
    var
    _RentalAsset:Record "Rental Asset";
    begin
        if "Rental Asset No." <> '' then begin
            _RentalAsset.Get("Rental Asset No.");
            "Rental Asset Id" := _RentalAsset.SystemId;
        
        end else begin
            TestField("Rental Asset Id");
            _RentalAsset.GetBySystemId("Rental Asset Id");
            "Rental Asset No." := _RentalAsset."No.";
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
Error('Rename is not allowed');
    end;

}