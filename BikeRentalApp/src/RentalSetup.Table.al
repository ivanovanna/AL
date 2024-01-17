table 50100 "Rental Setup"
{
    Caption = 'Rental Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(9; "Rental Asset Nos."; Code[20])
        {
            Caption = 'Rental Asset Nos.';
            TableRelation = "No. Series";
        }
        field(10; "Rental Order Nos."; Code[20])
        {
            Caption = 'Rental Order Nos.';
            TableRelation = "No. Series";
        }
        field(20;"Bing Maps Locations API URL"; Text[250]){
            Caption = 'Bing Maps Locations API URL';
        }
        field(21;"Bing Maps API Key"; Text[100]){
            Caption = 'Bing Maps API Key';
        }
         field(30;"yr.no Weather API URL"; Text[250]){
            Caption = 'yr.no Weather API URL';
        }

           field(40;"Rental Forecast API URL"; Text[250]){
            Caption = 'Rental Forecast API URL';
        }
        field(41;"Rental Forecast API Key"; Text[100]){
            Caption = 'Rental Forecast API Key';
        }
        field(42; "Forecast Temperature Factor"; Decimal)
        {
            Caption= 'Forecast Temperature Factor';
        }
        field(43; "Forecast Humidity Factor"; Decimal)
        {
            Caption= 'Forecast Humidity Factor';
        }
        field(44; "Forecast Wind Factor"; Decimal)
        {
            Caption= 'Forecast Wind Factor';
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
    // myInt: Integer;

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