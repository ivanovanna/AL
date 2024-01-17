report 50101 "Update RA Location Weather"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update RA Location Weather';

    dataset
    {
        dataitem(RALocation; "RA Location")
        {
            RequestFilterFields = Code;
         trigger OnAfterGetRecord()
         begin
            RALocation.RequestWeather(true);
            Commit();
         end;

         trigger OnPostDataItem()
         begin
            Message('Done!');
         end;
        }
    }
    
    requestpage
    {

        SaveValues = true;
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;
                        
    //                 }
    //             }
    //         }
    //     }
    
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;
                    
    //             }
    //         }
    //     }
    }
    

    
    // var
    //     myInt: Integer;
}