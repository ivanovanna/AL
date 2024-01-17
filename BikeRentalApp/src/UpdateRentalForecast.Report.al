report 50102 "Update Rental Forecast"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Rental Forecast';

    dataset
    {
        dataitem(RALocation; "RA Location")
        {
            RequestFilterFields = Code, "Date Filter";
         trigger OnAfterGetRecord()
         begin
            RALocation.RequestRentalForecast(true);
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