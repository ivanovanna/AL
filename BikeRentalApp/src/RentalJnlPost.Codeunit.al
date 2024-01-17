codeunit 50103 "Rental Jnl.-Post"
{
    TableNo = "Rental Journal Line";

    trigger OnRun()
    begin
        RentalJnlLine.Copy(Rec);
        Code();
        Rec.Copy(RentalJnlLine);
    end;

    var
        RentalJnlLine: Record "Rental Journal Line";
        Text001: Label 'Do you want to post the journal lines?';
        Text003: Label 'The journal lines were successfully posted.';

    local procedure "Code"()
    begin
        if not Confirm(Text001) then
            exit;

        CODEUNIT.Run(CODEUNIT::"Rental Jnl.-Post Batch", RentalJnlLine);

        Message(Text003);

    end;

}