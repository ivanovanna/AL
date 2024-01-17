codeunit 50105 "Rental-Post (Yes/No)"
{
    TableNo = "Rental Order";

    trigger OnRun()
    begin
        RentalOrder.Copy(Rec);
        Code();
        Rec := RentalOrder;
    end;

    var
        RentalOrder: Record "Rental Order";
        Text000: Label 'Do you want to post the %1?';
        Text003: Label 'The order was successfully posted.';

    local procedure "Code"()
    begin
        if not Confirm(Text000, false, RentalOrder."No.") then
            exit;

        CODEUNIT.Run(CODEUNIT::"Rental-Post", RentalOrder);

        Message(Text003);
    end;
}

