codeunit 50101 "Rental Jnl.-Post Line"
{
    Permissions = TableData "Rental Ledger Entry" = imd;
    TableNo = "Rental Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;

    var
        RentalJnlLine: Record "Rental Journal Line";
        RentalJnlCheckLine: Codeunit "Rental Jnl.-Check Line";
        RentalAsset: Record "Rental Asset";
        RentalAssetUnit: Record "Rental Asset Unit";
        RentalLedgEntry: Record "Rental Ledger Entry";
        RentalLedgEntryHist: Record "Rental Ledger Entry";
        EntryAlreadyExistsErr: Label '%1 entry for Rental Order %2 already exists.';



    procedure RunWithCheck(var p_RentalJnlLine: Record "Rental Journal Line")
    begin
        RentalJnlLine.Copy(p_RentalJnlLine);
        Code();
        p_RentalJnlLine := RentalJnlLine;
    end;

    local procedure "Code"()
    var
        _intDays: Integer;
    begin
        with RentalJnlLine do begin
            if EmptyLine() then
                exit;

            RentalJnlCheckLine.RunCheck(RentalJnlLine);

            // if NextEntryNo = 0 then begin
            //     ResLedgEntry.LockTable();
            //     NextEntryNo := ResLedgEntry.GetLastEntryNo() + 1;
            // end;


            RentalAsset.Get("Rental Asset No.");
            RentalAssetUnit.Get("Rental Asset No.", "Rental Asset Unit No.");

            RentalAsset.TestField(Blocked, false);
            RentalAssetUnit.TestField(Blocked, false);

            Clear(RentalLedgEntry);
            RentalLedgEntry.Init();
            RentalLedgEntry.CopyFromRentalJnlLine(RentalJnlLine);

            case "Entry Type" of
                "Entry Type"::"Hand Over":
                    begin
                        RentalLedgEntryHist.Reset();
                        RentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        RentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::"Hand Over");
                        RentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if not RentalLedgEntryHist.IsEmpty then
                            Error(EntryAlreadyExistsErr, "Entry Type", "Rental Order No.");

                        RentalLedgEntry."Days (Expected)" := "Rental Days";
                    end;
                "Entry Type"::Extend:
                    begin
                        RentalLedgEntryHist.Reset();
                        RentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        RentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::"Hand Over");
                        RentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        RentalLedgEntryHist.FindFirst();

                        _intDays := RentalLedgEntryHist."Days (Expected)";

                        RentalLedgEntryHist.Reset();
                        RentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        RentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::Extend);
                        RentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if RentalLedgEntryHist.FindSet() then
                            repeat
                                _intDays += RentalLedgEntryHist."Days (Expected)";
                            until RentalLedgEntryHist.Next() = 0;

                        RentalLedgEntry."Days (Expected)" := "Rental Days" - _intDays;
                    end;
                "Entry Type"::Return:
                    begin
                        RentalLedgEntryHist.Reset();
                        RentalLedgEntryHist.SetCurrentKey("Entry Type", "Rental Order No.");
                        RentalLedgEntryHist.SetRange("Entry Type", "Rental Ledger Entry Type"::Return);
                        RentalLedgEntryHist.SetRange("Rental Order No.", "Rental Order No.");
                        if not RentalLedgEntryHist.IsEmpty then
                            Error(EntryAlreadyExistsErr, "Entry Type", "Rental Order No.");

                        RentalLedgEntry."Days (Actual)" := "Rental Days";
                    end;
                "Entry Type"::Lost:
                    begin
                        //ToDo
                    end;
                "Entry Type"::"Rental Invoice":
                    begin
                        //ToDo
                    end;
                "Entry Type"::"Penalty Invoice":
                    begin
                        //ToDo
                    end;
            end;

            // RentalLedgEntry."Entry No." := NextEntryNo;
            RentalLedgEntry.Insert(true);
            // NextEntryNo := NextEntryNo + 1;
        end;

    end;

}