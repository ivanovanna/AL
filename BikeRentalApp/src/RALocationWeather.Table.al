table 50109 "RA Location Weather"
{

    Caption = 'RA Location Weather';
    LookupPageId ="RA Location Weather";
    DrillDownPageId = "RA Location Weather";
    
    fields
    {
        field(1;"RA Location Code"; Code[10])
        {
           Caption = 'RA Location Code';
           TableRelation = "RA Location";
            
        }
        field(2; "Forecast Date"; Date)
        {
            Caption= 'Forecast Date';
        }
        field(3; "Forecast Time"; Time){
            Caption = 'Forecast Time';
        }
        field (5; "Update At"; DateTime){
            Caption = 'Forecast Update At';
        }
        field (10;Temperature; Decimal)
        {
            Caption = 'Temperature';
        }
        field(11; Humidity; Decimal){
            Caption = 'Humidity';
        }
        field(12;Wind; Decimal){
            Caption ='Wind';
        }
    }
    
    keys
    {
        key(Key1; "RA Location Code","Forecast Date", "Forecast Time")
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