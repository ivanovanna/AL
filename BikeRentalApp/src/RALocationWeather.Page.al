page 50118 "RA Location Weather"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RA Location Weather";
    Caption = 'RA Location Weather';

    
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
                field("Forecast Time"; Rec."Forecast Time")
                {   
                }
                 field("Update At"; Rec."Update At")
                {   
                }
                 field(Temperature; Rec.Temperature)
                {   
                }
                 field(Humidity; Rec.Humidity)
                {   
                }
                 field(Wind; Rec.Wind)
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