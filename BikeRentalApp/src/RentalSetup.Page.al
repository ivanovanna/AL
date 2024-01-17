page 50100 "Rental Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Rental Setup";
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Rental Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Rental Asset Nos."; Rec."Rental Asset Nos.")
                {
                    ToolTip = 'Specifies the code for the number series that will be used to assign numbers to rental assets.';
                }
                field("Rental Order Nos."; Rec."Rental Order Nos.")
                {
                    ToolTip = 'Specifies the code for the number series that will be used to assign numbers to rental orders.';
                }
            }
              group (Connector)
              {
                Caption =  'Connector';
            group (MapsAPI)
            {
                Caption = 'Maps API';
                field ("Bing Maps Locations API URL"; Rec."Bing Maps Locations API URL")
                {
                }
                 field ("Bing Maps API Key"; Rec."Bing Maps API Key")
                {
                }
            }
            group(WeatherAPI)
            {
                Caption = 'Weather API';
                 field ("yr.no Weather API URL"; Rec."yr.no Weather API URL")
                {
                }
            }
             group (ForecastAPI)
            {
                Caption = 'Forecast API';
                field ("Rental Forecast API URL"; Rec."Rental Forecast API URL")
                {
                }
                 field ("Rental Forecast API Key"; Rec."Rental Forecast API Key")
                {
                }
                field ("Forecast Temperature Factor";Rec."Forecast Temperature Factor")
                {

                }
                field("Forecast Humidity Factor";Rec."Forecast Humidity Factor")
                {

                }
                field("Forecast Wind Factor";Rec."Forecast Wind Factor")
                {
                    
                }
            }
              }
        }
    }
    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction()
        //         begin

        //         end;
        //     }
        // }
    }

    var
    // myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}