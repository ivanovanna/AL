
page 50115 "Rental Orders API"
{
    PageType = API;
    Caption = 'Rental Orders';
    APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'rentalOrder';
    EntitySetName = 'rentalOrders';
    SourceTable = "Rental Order";
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(systemId; Rec.SystemId)
                {   
                    Caption = 'System Id', Locked = true;
                }
                
                 field(no; Rec."No.")
                {
                    
                }
                field(status; Rec.Status)
                {
                }
                field(customerNo; Rec."Customer No.")
                {
                    
                }
                field(customerName; Rec."Customer Name")
                {
                }
                 field(customerPhoneNo; Rec."Customer Phone No.")
                {
                }
                 field(customerEMail; Rec."Customer E-Mail")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                field(shortcutDimension1Code; Rec."Shortcut Dimension 1 Code")
                {
                }
                field(shortcutDimension2Code; Rec."Shortcut Dimension 2 Code")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }

                field(rentalAssetId; Rec."Rental Asset Id")
                {
                    
                }
                 field(rentalAssetNo; Rec."Rental Asset No.")
                {
                    
                }
                field(rentalAssetDescription; Rec."Rental Asset Description")
                {
                }
                field(rentalAssetUnitId; Rec."Rental Asset Unit Id")
                {
            
                }
                field(rentalAssetUnitNo; Rec."Rental Asset Unit No.")
                {
            
                }
                field(rentalAssetUnitDescription; Rec."Rental Asset Unit Description")
                {
                }
            
                field(rentalStart; Rec."Rental Start")
                {
                  
                }
                field(rentalEnd; Rec."Rental End")
                {
                    
                }
                field(rentalDays; Rec."Rental Days")
                {
                   
                }
            }
        }
    }
}