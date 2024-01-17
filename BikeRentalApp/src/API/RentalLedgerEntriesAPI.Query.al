query 50100 "Rental Ledger Entries API"
{
    QueryType = API;
     APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'rentalLedgerEntry';
    EntitySetName = 'rentalLedgerEntries';
    
    elements
    {
        dataitem(rentalLedgerEntry; "Rental Ledger Entry")
        {
          
                column(entryNo; "Entry No.")
                {
                }
                column(entryType; "Entry Type")
                {
                }
                column (documentNo; "Document No.")
                {
                }
                column(postingDate; "Posting Date")
                {
                }
                column(rentalOrderNo; "Rental Order No.")
                {
                }
                column(customerNo; "Customer No.")
                {
                }
                column(rentalAssetNo; "Rental Asset No.")
                {
                }
                column(rentalAssetUnitNo; "Rental Asset Unit No.")
                {
                }
                column(rentalStart; "Rental Start")
                {
                }
                column(rentalEnd; "Rental End")
                {
                }
                column(rentalDays; "Rental Days")
                {
                }
                column(daysExpected; "Days (Expected)")
                {
                }
                column(daysActual; "Days (Actual)")
                {
                }
                column(daysInvoiced; "Days (Invoiced)")
                {
                }
                column(shortcutDimension1Code; "Shortcut Dimension 1 Code")
                {
                }
                column(shortcutDimension2Code; "Shortcut Dimension 2 Code")
                {
                }
                column(dimensionSetID; "Dimension Set ID")
                {
                }
         
        }
    }
    
    // var
    //     myInt: Integer;
    
    trigger OnBeforeOpen()
    begin
        
    end;
}