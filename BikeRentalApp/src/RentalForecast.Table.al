table 50110 "Rental Forecast"
{

    Caption = 'Rental Forecast';
    LookupPageId ="Rental Forecast";
    DrillDownPageId = "Rental Forecast";
    
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
     
        field (5; "Update At"; DateTime){
            Caption = 'Forecast Update At';
        }
        field (10;Amount; Decimal)
        {
            Caption = 'Amount';
        }
     
    }
    
    keys
    {
        key(Key1; "RA Location Code","Forecast Date")
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