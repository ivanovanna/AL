codeunit 50104 "Rental-Post"
{
    TableNo = "Rental Order";

    trigger OnRun()
    var
        RentalOrder: Record "Rental Order";
    begin
        ClearAll();
        RentalOrder := Rec;

        InitPost(RentalOrder);
        Post(RentalOrder, RentalJnlPostLine);
        FinalizePost(RentalOrder);

        Rec := RentalOrder;
    end;

    var
        RentalJnlPostLine: Codeunit "Rental Jnl.-Post Line";
        PostingDate: Date;

    local procedure InitPost(var RentalOrder: Record "Rental Order")
    begin
        RentalOrder.TestField("No.");
        RentalOrder.TestField("Customer No.");
        RentalOrder.TestField("Rental Asset No.");
        RentalOrder.TestField("Rental Asset Unit No.");
        RentalOrder.TestField("Rental Start");
        RentalOrder.TestField("Rental End");
        RentalOrder.TestField("Rental Days");

        PostingDate := WorkDate();
    end;

    local procedure Post(var RentalOrder: Record "Rental Order"; var RentalJnlPostLine: Codeunit "Rental Jnl.-Post Line")
    var
        RentalJnlLine: Record "Rental Journal Line" temporary;
    begin
        RentalJnlLine.Init();
        //RentalJnlLine."Entry Type" := 
        RentalJnlLine."Document No." := RentalOrder."No.";
        RentalJnlLine."Posting Date" := PostingDate;
        RentalJnlLine."Rental Order No." := RentalOrder."No.";
        RentalJnlLine."Customer No." := RentalOrder."Customer No.";
        RentalJnlLine."Rental Asset No." := RentalOrder."Rental Asset No.";
        RentalJnlLine."Rental Asset Unit No." := RentalOrder."Rental Asset Unit No.";

        RentalJnlLine."Rental Start" := RentalOrder."Rental Start";
        RentalJnlLine."Rental End" := RentalOrder."Rental End";
        RentalJnlLine."Rental Days" := RentalOrder."Rental Days";

        RentalJnlLine."Shortcut Dimension 1 Code" := RentalOrder."Shortcut Dimension 1 Code";
        RentalJnlLine."Shortcut Dimension 2 Code" := RentalOrder."Shortcut Dimension 2 Code";
        RentalJnlLine."Dimension Set ID" := RentalOrder."Dimension Set ID";

        RentalJnlPostLine.RunWithCheck(RentalJnlLine);
    end;

    local procedure FinalizePost(RentalOrder: Record "Rental Order")
    begin
        // ToDo CHange Rental Order Status
    end;

}