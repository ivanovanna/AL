
page 50111 "RA Locations API"
{
    PageType = API;
    Caption = 'RA Locations';
    APIPublisher = 'student';
    APIGroup = 'bikeRentals';
    APIVersion = 'v2.0';
    EntityName = 'raLocation';
    EntitySetName = 'raLocations';
    SourceTable = "RA Location";
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
                    Caption = 'systemId', Locked = true;
                }
                field(code;Rec.Code){

                }
                field(name; Rec.Name)
                {

                }
            }
        }
    }
}