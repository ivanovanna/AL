table 50105 "Rental Order"
{
    Caption = 'Rental Order';
    DataCaptionFields = "No.";
    DrillDownPageID = "Rental Orders";
    LookupPageID = "Rental Orders";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then begin
                    RentalSetup.Get();
                    NoSeriesMgt.TestManual(RentalSetup."Rental Order Nos.");
                    Rec."No. Series" := '';
                end;
            end;
        }
        field(2; Status; Enum "Rental Order Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                TestStatusOpen();
                CreateDimFromDefaultDim(Rec.FieldNo("Customer No."));

                if "Customer No." <> '' then begin
                    Customer.Get("Customer No.");
                    Customer.TestField(Blocked, 0);

                    Validate("Customer Name", Customer.Name);
                    Validate("Customer E-Mail", Customer."E-Mail");
                    Validate("Customer Phone No.", Customer."Phone No.");
                end;
            end;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
        }
        field(6; "Customer Phone No."; Text[30])
        {
            Caption = 'Customer Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(7; "Customer E-Mail"; Text[80])
        {
            Caption = 'Customer E-Mail';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Customer E-Mail");
            end;
        }
        field(8; "Rental Asset No."; Code[20])
        {
            Caption = 'Rental Asset No.';
            TableRelation = "Rental Asset"."No.";


 trigger OnValidate()
            var 
            _RentalAsset: Record "Rental Asset";
            begin
                if  "Rental Asset No." = '' then begin
                    Clear("Rental Asset Id");
                exit;
                end;
                if not _RentalAsset.Get("Rental Asset No.") then
                exit;

                "Rental Asset Id" := _RentalAsset.SystemId;
                UpdateRentalAsset();
            end;

 
        }
        field(9; "Rental Asset Description"; Text[100])
        {
            Caption = 'Rental Asset Description';
        }
        field(10; "Rental Asset Unit No."; Code[20])
        {
            Caption = 'Rental Asset Unit No.';
            TableRelation = "Rental Asset Unit"."RA Unit No." where("Rental Asset No." = field("Rental Asset No."));

     trigger OnValidate()
            var 
            _RentalAssetUnit: Record "Rental Asset Unit";
            begin
                if  "Rental Asset No." = '' then begin
                    Clear("Rental Asset Unit Id");
                exit;
                end;
                if not _RentalAssetUnit.Get("Rental Asset No.","Rental Asset Unit No.") then
                exit;

                "Rental Asset Unit Id" := _RentalAssetUnit.SystemId;
        UpdateRentalAssetUnit();
     end;
        }
        field(11; "Rental Asset Unit Description"; Text[100])
        {
            Caption = 'Rental Asset Description';
        }
        field(12; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            // Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions();
            end;

            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(14; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(15; "Rental Start"; Date)
        {
            Caption = 'Rental Start';

            trigger OnValidate()
            begin
                TestStatusOpen();

                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";
            end;
        }

        field(16; "Rental End"; Date)
        {
            Caption = 'Rental End';

            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental End" <> 0D) then
                    "Rental Days" := "Rental End" - "Rental Start";
            end;
        }

        field(17; "Rental Days"; Integer)
        {
            Caption = 'Rental Days';

            trigger OnValidate()
            begin
                if ("Rental Start" <> 0D) and ("Rental Days" <> 0) then
                    "Rental End" := "Rental Start" + "Rental Days";
            end;
        }

         field(18; "Rental Asset Id"; Guid)
        {
            Caption = 'Rental Asset Id';
            TableRelation = "Rental Asset".SystemId;

            trigger OnValidate()
            var 
            _RentalAsset: Record "Rental Asset";
            begin
                if not IsNullGuid("Rental Asset Id") then
                _RentalAsset.GetBySystemId("Rental Asset Id");
                "Rental Asset No.":= _RentalAsset."No.";
                UpdateRentalAsset();
            end;
        }
        field(19; "Rental Asset Unit Id"; Guid)
        {
            Caption = 'Rental Asset Unit Id';
            TableRelation = "Rental Asset Unit".SystemId;

     trigger OnValidate()
      var 
            _RentalAssetUnit: Record "Rental Asset Unit";
            begin
                if not IsNullGuid("Rental Asset Unit Id") then
                _RentalAssetUnit.GetBySystemId("Rental Asset Unit Id");

                "Rental Asset No." := _RentalAssetUnit."Rental Asset No.";
                "Rental Asset Unit No.":= _RentalAssetUnit."RA Unit No.";

                UpdateRentalAsset();
        UpdateRentalAssetUnit();
     end;
        }

        field(28; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        RentalOrder: Record "Rental Order";
        RentalSetup: Record "Rental Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        StatusCheckSuspended: Boolean;

    trigger OnInsert()
    begin
        InitOrderNo();
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;



    procedure TestStatusOpen()
    begin
        if StatusCheckSuspended then
            exit;

        TestField(Status, Status::Open);
    end;

    procedure SuspendStatusCheck(Suspend: Boolean)
    begin
        StatusCheckSuspended := Suspend;
    end;

    procedure AssistEdit(OldOrder: Record "Rental Order") Result: Boolean
    begin
        RentalOrder := Rec;
        RentalSetup.Get();
        RentalSetup.TestField("Rental Order Nos.");
        if NoSeriesMgt.SelectSeries(RentalSetup."Rental Order Nos.", OldOrder."No. Series", RentalOrder."No. Series") then begin
            NoSeriesMgt.SetSeries(RentalOrder."No.");
            Rec := RentalOrder;
            exit(true);
        end;
    end;

    local procedure InitOrderNo()
    begin
        if "No." = '' then begin
            RentalSetup.Get();
            RentalSetup.TestField("Rental Order Nos.");
            NoSeriesMgt.InitSeries(RentalSetup."Rental Order Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    procedure ShowDimensions() IsChanged: Boolean
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('Rental Order %1', "No.")); //ToDo Text Label
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IsChanged := OldDimSetID <> "Dimension Set ID";
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure CreateDimFromDefaultDim(FieldNo: Integer)
    var
        DefaultDimSource: List of [Dictionary of [Integer, Code[20]]];
    begin
        if not DimMgt.IsDefaultDimDefinedForTable(GetTableValuePair(FieldNo)) then exit;
        InitDefaultDimensionSources(DefaultDimSource, FieldNo);
        CreateDim(DefaultDimSource);
    end;

    local procedure GetTableValuePair(FieldNo: Integer) TableValuePair: Dictionary of [Integer, Code[20]]
    begin
        case true of
            FieldNo = Rec.FieldNo("Customer No."):
                TableValuePair.Add(Database::Customer, Rec."Customer No.");
            FieldNo = Rec.FieldNo("Rental Asset No."):
                TableValuePair.Add(Database::"Rental Asset", Rec."Rental Asset No.");
        end;
    end;

    local procedure InitDefaultDimensionSources(var DefaultDimSource: List of [Dictionary of [Integer, Code[20]]]; FieldNo: Integer)
    begin
        DimMgt.AddDimSource(DefaultDimSource, Database::Customer, Rec."Customer No.", FieldNo = Rec.FieldNo("Customer No."));
        DimMgt.AddDimSource(DefaultDimSource, Database::"Rental Asset", Rec."Rental Asset No.", FieldNo = Rec.FieldNo("Rental Asset No."));
    end;

    procedure CreateDim(DefaultDimSource: List of [Dictionary of [Integer, Code[20]]])
    var
        SourceCodeSetup: Record "Source Code Setup";
    begin
        SourceCodeSetup.Get();
#if not CLEAN20
        // RunEventOnAfterCreateDimTableIDs(DefaultDimSource);
#endif

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" :=
          DimMgt.GetRecDefaultDimID(
            Rec, CurrFieldNo, DefaultDimSource, SourceCodeSetup.Sales,
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);

        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure ReleaseOrder()
    begin
        Rec.TestField(Status, "Rental Order Status"::Open);

        Rec.TestField("No.");
        Rec.TestField("Customer No.");
        Rec.TestField("Rental Asset No.");
        Rec.TestField("Rental Asset Unit No.");
        Rec.TestField("Rental Start");
        Rec.TestField("Rental End");
        Rec.TestField("Rental Days");

        Rec.Status := "Rental Order Status"::Released;
        Rec.Modify(true);
    end;

    procedure ReOpenOrder()
    begin
        Rec.TestField(Status, "Rental Order Status"::Released);

        Rec.Status := "Rental Order Status"::Open;
        Rec.Modify(true);
    end;


    procedure PrintOrder()
    var
        _recRentalOrder: Record "Rental Order";
        _repRentalOrder: Report "Rental Order";
    begin
        _recRentalOrder.SetRange("No.", Rec."No.");
        //report.Run(report::"Rental Order", true, true, _recRentalOrder);
        _repRentalOrder.SetTableView(_recRentalOrder);
        _repRentalOrder.Run();
    end;

 procedure UpdateRentalAsset()
            var
                RentalAsset: Record "Rental Asset";
            begin
                TestStatusOpen();
                CreateDimFromDefaultDim(Rec.FieldNo("Rental Asset No."));

                if "Rental Asset No." <> '' then begin
                    RentalAsset.Get("Rental Asset No.");
                    RentalAsset.TestField(Blocked, false);

                    Validate("Rental Asset Description", RentalAsset.Description);
                end;
            end;

       procedure UpdateRentalAssetUnit()
            var
                RentalAssetUnit: Record "Rental Asset Unit";
            begin
                TestStatusOpen();

                if "Rental Asset Unit No." <> '' then begin
                    RentalAssetUnit.Get("Rental Asset No.", "Rental Asset Unit No.");
                    RentalAssetUnit.TestField(Blocked, false);

                    Validate("Rental Asset Unit Description", RentalAssetUnit.Description);
                end;
            end;



}