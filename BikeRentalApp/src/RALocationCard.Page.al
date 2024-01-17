page 50116 "RA Location Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "RA Location";
    Caption = 'RA Location Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                 field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a location code for the rental asset.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the rental asset location.';
                }
            }
            group(Maps)
            {
                Caption = 'Maps';
                    field("Maps Country Region"; Rec."Maps Country Region")
                     {
                     }
                     field("Maps Admin Disrtict"; Rec."Maps Admin District")
                     {
                     }
                     field("Maps Locality"; Rec."Maps Locality")
                     {
                     }
                      field("Maps Coordinates Latitude"; Rec."Maps Coordinates Latitude")
                      {
                      }
                      field("Maps Coordinates Longitude";Rec."Maps Coordinates Longitude" )
                      {
                      }
        
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RequestCoordinates)
            {
                Caption = 'Request Coordinates';
                Image = ImportCodes;

                trigger OnAction()
                begin
                    Rec.RequestCoordinates();
                end;
            }

                       action(RequestWeather)
            {
                Caption = 'Request Weather';
                Image = ImportCodes;

                trigger OnAction()
                begin
                    Rec.RequestWeather();
                end;
            }

               action(RequestRentalForecast)
            {
                Caption = 'Request Rental Forecast';
                Image = ImportCodes;

                trigger OnAction()
                begin
                    Rec.RequestRentalForecast();
                end;
            }
        }
        area (Navigation){
            action(LocationWeather)
            {
                Caption = 'Location Weather';
                Image = Entries;

                RunObject= page "RA Location Weather";
                RunPageLink = "RA Location Code" = field(Code);

            }

                   action(RentalForecast)
            {
                Caption = 'RentalForecast';
                Image = Entries;

                RunObject= page "Rental Forecast";
                RunPageLink = "RA Location Code" = field(Code);
                
            }
        }
    }
    
//     var
//         myInt: Integer;
}