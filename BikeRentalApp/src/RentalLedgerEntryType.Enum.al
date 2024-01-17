enum 50101 "Rental Ledger Entry Type"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "Hand Over") { Caption = 'Hand Over'; }
    value(1; "Extend") { Caption = 'Extend'; }
    value(2; "Return") { Caption = 'Return'; }
    value(3; "Lost") { Caption = 'Lost'; }
    value(4; "Rental Invoice") { Caption = 'Rental Invoice'; }
    value(5; "Penalty Invoice") { Caption = 'Penalty Invoice'; }
}