enum 50100 "Rental Order Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; Open) { Caption = 'Open'; }
    value(1; Released) { Caption = 'Released'; }
    value(2; "Closed") { Caption = 'Closed'; }
}