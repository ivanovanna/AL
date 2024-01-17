page 50117 "Maps Responses"
{
    PageType = List;
    Caption = 'Maps Responses';
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Maps Response Buffer";
    Editable = false;
    SourceTableTemporary = true;
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                ShowCaption = false;


              field("Entry No."; Rec."Entry No.")
              {

              }
              field( Name; Rec.Name)
              {

              }
              field(Confidence;Rec.Confidence)
              {

              }
              field("Entity Type"; Rec."Entity Type")
              {

              }
              field("Country Region";Rec."Country Region")
              {

              }
              field("Admin District";Rec."Admin District")
              {

              }
              field("Locality"; Rec."Locality")
              {
                
              }
              field("Coordinates Latitude"; Rec."Coordinates Latitude")
              {

              }
              field("Coordinates Longitude"; Rec."Coordinates Longitude")
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