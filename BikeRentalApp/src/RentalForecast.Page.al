page 50119 "Rental Forecast"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rental Forecast";
    Caption = 'Rental Forecast';

    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("RA Location Code"; Rec."RA Location Code")
                {   
                }
                field("Forecast Date"; Rec."Forecast Date")
                {   
                }
                
                 field("Update At"; Rec."Update At")
                {   
                }
                 field(Amount; Rec.Amount)
                {   
                }
               
            }
        }
        // area(Factboxes)
        // {
            
        // }
    }
    
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;
                
    //             trigger OnAction();
    //             begin
                    
    //             end;
    //         }
    //     }
    // }
}