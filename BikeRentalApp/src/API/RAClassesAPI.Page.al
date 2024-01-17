 page 50112 "RA Classes API"
 {
    PageType = API;
    Caption = 'RA Classes';
    APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'raClass';
    EntitySetName = 'raClasses';
    SourceTable = "RA Class";
    DelayedInsert = true;
    ODataKeyFields= SystemId;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                  field(systemId; Rec.SystemId)
                {   
                    Caption = 'systemId', Locked = true;
                }
                field(code; Rec.Code)
                {  
                }

                field(name; Rec.Name)
                {  
                }

                field(defRALocationId; Rec."Default RA Location Id")
                {  
                }

                field(defRALocationCode; Rec."Default RA Location Code")
                {  
                }
            }
        }
    }
 }