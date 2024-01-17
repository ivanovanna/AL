codeunit 50100 "Rental Jnl.-Check Line"
{
    TableNo = "Rental Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        Text000: Label 'cannot be a closing date';

    procedure RunCheck(var RentalJnlLine: Record "Rental Journal Line")
    begin
        with RentalJnlLine do begin
            if EmptyLine() then
                exit;

            TestField("Document No.", ErrorInfo.Create());
            TestField("Posting Date", ErrorInfo.Create());
            TestField("Rental Order No.", ErrorInfo.Create());
            TestField("Customer No.", ErrorInfo.Create());
            TestField("Rental Asset No.", ErrorInfo.Create());
            TestField("Rental Asset Unit No.", ErrorInfo.Create());
            TestField("Rental Start", ErrorInfo.Create());
            TestField("Rental End", ErrorInfo.Create());
            TestField("Rental Days", ErrorInfo.Create());

            CheckPostingDate(RentalJnlLine);

            // CheckDimensions(RentalJnlLine);
        end;
    end;

    local procedure CheckPostingDate(RentalJnlLine: Record "Rental Journal Line")
    var
        UserSetupManagement: Codeunit "User Setup Management";
    begin
        with RentalJnlLine do begin
            if "Posting Date" <> NormalDate("Posting Date") then
                FieldError("Posting Date", ErrorInfo.Create(Text000, true));

            UserSetupManagement.CheckAllowedPostingDate("Posting Date");
        end;
    end;

}