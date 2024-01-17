table 50108 "Maps Response Buffer"
{
    Caption = 'Maps Response Buffer';
    TableType = Temporary;
    LookupPageId = "Maps Responses";
    DrillDownPageId = "Maps Responses";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; Confidence; Text[20])
        {
            Caption = 'Confidence';
        }
        field(4; "Entity Type"; Text[20])
        {
            Caption = 'Entity Type';

        }
        field(10; "Country Region"; Text[50])
        {
            Caption = 'Country Region';
        }
        field(11; "Admin District"; Text[50])
        {
            Caption = 'Admin District';
        }
        field(12; "Locality"; Text[50])
        {
            Caption = 'Locality';
        }
        field(20; "Coordinates Latitude"; Text[30])
        {
            Caption = 'Coordinates Latitude';
        }
        field(21; "Coordinates Longitude"; Text[30])
        {
            Caption = 'Coordinates Longitude';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    // var
    //     myInt: Integer;

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

}