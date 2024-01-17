table 50102 "RA Class"
{
    Caption = 'RA Class';
    LookupPageID = "RA Classes";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "Default RA Location Code"; Code[10])
        {
            Caption = 'Default RA Location Code';
            TableRelation = "RA Location".Code;

            trigger OnValidate()
            var 
            _RALocation: Record "RA Location";
            begin
                if  "Default RA Location Code" = '' then begin
                    Clear("Default RA Location Id");
                exit;
                end;
                if not _RALocation.Get("Default RA Location Code") then
                exit;
                "Default RA Location Id" := _RALocation.SystemId;
            end;
            
        }
        field(4;"Default RA Location Id";  Guid)
        {
            Caption = 'Default RA Location Id';
            TableRelation = "RA Location".SystemId;

            trigger OnValidate()
            var 
            _RALocation: Record "RA Location";
            begin
                if not IsNullGuid("Default RA Location Id") then
                _RALocation.GetBySystemId("Default RA Location Id");
                "Default RA Location Code":= _RALocation.Code;
            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

