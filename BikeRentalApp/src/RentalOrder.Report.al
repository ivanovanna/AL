report 50100 "Rental Order"
{
    Caption = 'Rental Order';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = WordLayout;
    PreviewMode = PrintLayout;
    WordMergeDataItem = RentalOrder;

    dataset
    {
        dataitem(RentalOrder; "Rental Order")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Customer No.", "Rental Asset No.", "Rental Asset Unit No.";

            column(No; "No.")
            {
            }
            column(Status; Status)
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(DimensionSetID; "Dimension Set ID")
            {
            }
            column(ShortcutDimension1Code; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Shortcut Dimension 2 Code")
            {
            }
            column(RentalAssetNo; "Rental Asset No.")
            {
            }
            column(RentalAssetDescription; "Rental Asset Description")
            {
            }
            column(RentalAssetUnitNo; "Rental Asset Unit No.")
            {
            }
            column(RentalAssetUnitDescription; "Rental Asset Unit Description")
            {
            }
            column(RentalStart; "Rental Start")
            {
            }
            column(RentalEnd; "Rental End")
            {
            }
            column(RentalDays; "Rental Days")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
        }
    }

    // requestpage
    // {
    //     SaveValues = true;
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 column(Name; SourceExpression)
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
    // }

    rendering
    {
        layout(WordLayout)
        {
            Type = Word;
            LayoutFile = './src/Layout/RentalOrder.docx';
        }
    }

    // var
    //     myInt: Integer;
}