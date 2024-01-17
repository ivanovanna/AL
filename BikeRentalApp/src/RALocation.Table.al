table 50101 "RA Location"
{
    Caption = 'RA Location';
    LookupPageID = "RA Locations";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(10;"Maps Country Region"; Text [50])
        {
            Caption = 'Maps Country Region';
        }
         field(11;"Maps Admin District"; Text [50])
        {
            Caption = 'Maps Admin District';
        }
         field(12;"Maps Locality"; Text [50])
        {
            Caption = 'Maps Locality';
        }
         field(20;"Maps Coordinates Latitude"; Text [30])
        {
            Caption = 'Maps Coordinates Latitude';
        }
           field(21;"Maps Coordinates Longitude"; Text [30])
        {
            Caption = 'Maps Coordinates Longitude';
        }
        field(30; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
    procedure RequestCoordinates()
    var
    _RentalSetup : Record "Rental Setup";
    _EntryNo: Integer;
    _MapsResponseBuffer: Record "Maps Response Buffer" temporary;
    _HttpClient: HttpClient;
    _HttpResponseMessage: HttpResponseMessage;
    _ResponseText: Text;
    _JsonMessage: JsonObject;
    _JsonToken: JsonToken;
    _JsonResourceSets: JsonArray;
    _JsonResourceSet: JsonObject;
    _JsonResources: JsonArray;
    _JsonResource : JsonObject;
    _JsonAddress: JsonObject;
    _JsonCoordinates: JsonArray;

    begin
        _RentalSetup.Get();
        _RentalSetup.TestField("Bing Maps Locations API URL");
        _RentalSetup.TestField("Bing Maps API Key");

        if not _HttpClient.Get(
            StrSubstNo(_RentalSetup."Bing Maps Locations API URL",
            "Maps Country Region",
            "Maps Admin District",
            "Maps Locality",
            _RentalSetup."Bing Maps API Key"),
            _HttpResponseMessage)
            then
            Error('GET request failed : %1' , _HttpResponseMessage.ReasonPhrase);
            if not _HttpResponseMessage.IsSuccessStatusCode then
            Error(_HttpResponseMessage.ReasonPhrase);
            _HttpResponseMessage.Content.ReadAs(_ResponseText);

            _JsonMessage.ReadFrom(_ResponseText);
            _JsonMessage.Get('resourceSets', _JsonToken);
            _JsonResourceSets := _JsonToken.AsArray();

            _JsonResourceSets.Get(0, _JsonToken);
            _JsonResourceSet := _JsonToken.AsObject();

            _JsonResourceSet.Get('resources', _JsonToken);
            _JsonResources := _JsonToken.AsArray();

            for _EntryNo := 1 to _JsonResources.Count() do begin
                _JsonResources.Get(_EntryNo - 1, _JsonToken);
                _JsonResource := _JsonToken.AsObject();

                Clear(_MapsResponseBuffer);
                _MapsResponseBuffer.Init();
                _MapsResponseBuffer."Entry No." := _EntryNo;

                _JsonResource.Get('name', _JsonToken);
                _MapsResponseBuffer. Name := _JsonToken.AsValue().AsText();

                _JsonResource.Get('confidence', _JsonToken);
                _MapsResponseBuffer. Confidence := _JsonToken.AsValue().AsText();

                _JsonResource.Get('entityType', _JsonToken);
                _MapsResponseBuffer. "Entity Type":= _JsonToken.AsValue().AsText();


                //address
                _JsonResource.Get('address', _JsonToken);
                _JsonAddress := _JsonToken.AsObject();

                if _JsonAddress.Get('countryRegion', _JsonToken) then
                _MapsResponseBuffer."Country Region" := _JsonToken.AsValue().AsText();

                if _JsonAddress.Get('adminDistrict', _JsonToken) then
                _MapsResponseBuffer."Admin District" := _JsonToken.AsValue().AsText();

                if _JsonAddress.Get('locality', _JsonToken) then
                _MapsResponseBuffer.Locality := _JsonToken.AsValue().AsText();

                //coordinates

                _JsonResource.Get('point', _JsonToken);
                _JsonToken.AsObject().Get('coordinates', _JsonToken);
                _JsonCoordinates := _JsonToken.AsArray();

                _JsonCoordinates.Get(0,_JsonToken);
                _MapsResponseBuffer."Coordinates Latitude" := _JsonToken.AsValue().AsText();

                 _JsonCoordinates.Get(1,_JsonToken);
                _MapsResponseBuffer."Coordinates Longitude" := _JsonToken.AsValue().AsText();

                _MapsResponseBuffer.Insert();
                
            end;

            Commit();

           _MapsResponseBuffer.FindFirst();
            if PAGE.RunModal(Page::"Maps Responses", _MapsResponseBuffer)= Action:: LookupOK then begin
                "Maps Country Region" := _MapsResponseBuffer."Country Region";
                "Maps Admin District" := _MapsResponseBuffer."Admin District";
                "Maps Locality" := _MapsResponseBuffer.Locality;

                "Maps Coordinates Latitude" := _MapsResponseBuffer."Coordinates Latitude";
                "Maps Coordinates Longitude" := _MapsResponseBuffer."Coordinates Longitude";

                Modify(true);

                Message('Maps data modified.');
            end;

    end;

   procedure RequestWeather()
   begin
    RequestWeather(false);

   end;


    procedure RequestWeather(p_Silent:Boolean)
    var
    _RentalSetup : Record "Rental Setup";
    _RALocationWeather : Record "RA Location Weather";
    _HttpClient: HttpClient;
    _HttpResponseMessage: HttpResponseMessage;
    _ResponseText: Text;
    _JsonMessage: JsonObject;
    _JsonToken: JsonToken;
    _JsonTimeseries: JsonArray;
    _JsonTimeseriesEntry: JsonToken;
    _UpdateAt: DateTime;
    _ForecastDateTime: DateTime;
    _ForecastDate: Date;
    _ForecastTime: Time;
    _EntriesCount: Integer;

    begin
        _RentalSetup.Get();
        _RentalSetup.TestField("yr.no Weather API URL");

        TestField("Maps Coordinates Latitude");
        TestField("Maps Coordinates Longitude");

        _HttpClient.DefaultRequestHeaders().Add('User-Agent', 'TalTech ITB2204  Course');
     

        if not _HttpClient.Get(
            StrSubstNo(_RentalSetup."yr.no Weather API URL",
            "Maps Coordinates Latitude",
            "Maps Coordinates Longitude"),
            _HttpResponseMessage)
            then
            Error('GET request failed :%1', _HttpResponseMessage.ReasonPhrase);

            if not _HttpResponseMessage.IsSuccessStatusCode then
            Error(_HttpResponseMessage.ReasonPhrase);
            _HttpResponseMessage.Content.ReadAs(_ResponseText);

            _JsonMessage.ReadFrom(_ResponseText);

            _JsonMessage.SelectToken('$.properties.meta.update_at',_JsonToken);
            _UpdateAt := _JsonToken.AsValue().AsDateTime();

      

              _JsonMessage.SelectToken('$.properties.timeseries', _JsonToken);
            _JsonTimeseries := _JsonToken.AsArray();

            _EntriesCount := 0;

            foreach  _JsonTimeseriesEntry in _JsonTimeseries do begin
            _JsonTimeseriesEntry.AsObject().Get('time', _JsonToken);
            _ForecastDateTime := _JsonToken.AsValue().AsDateTime();

            _ForecastDate := DT2Date(_ForecastDateTime);
            _ForecastTime := DT2Time(_ForecastDateTime);

            if not  _RALocationWeather.Get(Code, _ForecastDate, _ForecastTime) then begin
                clear(_RALocationWeather);
                _RALocationWeather.Init();
                _RALocationWeather."RA Location Code" := Code;
                _RALocationWeather."Forecast Date" := _ForecastDate;
                _RALocationWeather."Forecast Time" := _ForecastTime;
                _RALocationWeather.Insert(true);

            end;

            _RALocationWeather."Update At" := _UpdateAt;

            _JsonTimeseriesEntry.SelectToken('$.data.instant.details.air_temperature', _JsonToken);
            _RALocationWeather.Temperature := _JsonToken.AsValue().AsDecimal();

            
            _JsonTimeseriesEntry.SelectToken('$.data.instant.details.relative_humidity', _JsonToken);
            _RALocationWeather.Humidity := _JsonToken.AsValue().AsDecimal();

            
            _JsonTimeseriesEntry.SelectToken('$.data.instant.details.wind_speed', _JsonToken);
            _RALocationWeather.Wind := _JsonToken.AsValue().AsDecimal();

            _RALocationWeather.Modify(true);

            _EntriesCount += 1;
            end;

            if not p_Silent then 
            Message('Weather data modified, %1 entries', _EntriesCount);

    end;
procedure  RequestRentalForecast()
begin
    RequestRentalForecast(false);
end;
 procedure RequestRentalForecast(p_Silent: Boolean)
var
    // myInt: Integer;
    _FromDate: Date;
    _ToDate: Date;
    _Date: Record Date;
    _JsonObject: JsonObject;
    _JsonArray: JsonArray;
    _JsonMessage:JsonObject;
    _JsonToken:JsonToken;
    _HttpClient : HttpClient;
    _HttpContent: HttpContent;
    _HttpContentHeaders: HttpHeaders;
    _HttpResponseMessage : HttpResponseMessage;
    _ResquestText: Text;
    _ResponseText: Text;
    _Weekday:Integer;
    _Workingday:Integer;
    _LocationWeather: Record "RA Location Weather";
    _RentalSetup:Record "Rental Setup";
    _RentalForecast: Record "Rental Forecast";
    _EntriesCount:Integer;

begin
    _RentalSetup.Get();
    _RentalSetup.TestField("Rental Forecast API URL");
    _RentalSetup.TestField("Rental Forecast API Key");
      _RentalSetup.TestField("Forecast Temperature Factor");
      _RentalSetup.TestField("Forecast Humidity Factor");
      _RentalSetup.TestField("Forecast Wind Factor");

      if GetFilter("Date Filter")<> '' then begin

    _FromDate:= GetRangeMin("Date Filter"); 
    _ToDate:= GetRangeMax("Date Filter"); 
    end;

    if _FromDate = 0D then 
    _FromDate := Today;

    if _ToDate = 0D then
    _ToDate := CalcDate('<+10D>',_FromDate);

    _Date.Reset();
    _Date.SetRange("Period Type", _Date."Period Type"::Date);
    _Date.SetRange("Period Start", _FromDate,_ToDate);

    
            _EntriesCount := 0;
    
    if _Date.FindFirst() then 
    repeat

    _LocationWeather.Reset();
    _LocationWeather.SetRange("RA Location Code", Code);
    _LocationWeather.SetRange("Forecast Date", _Date."Period Start");
    _LocationWeather.SetFilter("Forecast Time", '21:00');

    if _LocationWeather.FindFirst() then begin




    _Weekday := Date2DWY(_Date."Period Start", 1);

    if _Weekday <= 5 then 
    _Workingday:=1
    else
    _Workingday :=0;

    if _Weekday = 7 then
    _Weekday := 0;

    Clear(_JsonObject);
    _JsonObject.Add('day',Date2DMY(_Date."Period Start",1));
    _JsonObject.Add('month',Date2DMY(_Date."Period Start",2));
    _JsonObject.Add('year',Date2DMY(_Date."Period Start",3));
    _JsonObject.Add('holiday',0);
    _JsonObject.Add('weekday', _Weekday);
    _JsonObject.Add('workingday', _Workingday);
    _JsonObject.Add('temp',round(_LocationWeather.Temperature/_RentalSetup."Forecast Temperature Factor" ));
     _JsonObject.Add('hum',round(_LocationWeather.Humidity/_RentalSetup."Forecast Humidity Factor" ));
      _JsonObject.Add('windspeed',round(_LocationWeather.Wind/_RentalSetup."Forecast Wind Factor" ));


      Clear(_JsonArray);
      _JsonArray.Add(_JsonObject);

      Clear(_JsonObject);
      _JsonObject.Add('data', _JsonArray);

      Clear(_JsonMessage);
      _JsonMessage.Add('Inputs',_JsonObject);
      _JsonMessage.Add('GlobalParameters', 0.0);

      _JsonMessage.WriteTo(_ResquestText);

    //   Message(_ResquestText);
    Clear(_HttpContent);
    Clear(_HttpContentHeaders);
    _HttpContent.WriteFrom(_ResquestText);

    _HttpContent.GetHeaders(_HttpContentHeaders);
    _HttpContentHeaders.Remove('Content-Type');
    _HttpContentHeaders.Add('Content-Type', 'application/json');

    Clear(_HttpClient);
    Clear(_HttpResponseMessage);



    _HttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Bearer %1', _RentalSetup."Rental Forecast API Key"));
    if not _HttpClient.Post(_RentalSetup."Rental Forecast API URL",_HttpContent, _HttpResponseMessage) then
     Error(' PPST request failed :%1', _HttpResponseMessage.ReasonPhrase);

            if not _HttpResponseMessage.IsSuccessStatusCode then
            Error(_HttpResponseMessage.ReasonPhrase);
            _HttpResponseMessage.Content.ReadAs(_ResponseText );

            // Message(_ResponseText);
            Clear(_JsonMessage);
            Clear(_JsonArray);
            Clear(_JsonToken);


            _JsonMessage.ReadFrom(_ResponseText);
            _JsonMessage.Get('resourceSets', _JsonToken);
            _JsonArray := _JsonToken.AsArray();

            _JsonArray.Get(0, _JsonToken);


                  if not  _RentalForecast.Get(Code, _Date."Period Start") then begin
                clear(_RentalForecast);
                _RentalForecast.Init();
                _RentalForecast."RA Location Code" := Code;
                _RentalForecast."Forecast Date" := _Date."Period Start";
                _RentalForecast.Insert(true);

            end;

            _RentalForecast."Update At" := CurrentDateTime();
            _RentalForecast.Amount := _JsonToken.AsValue().AsDecimal();
            _RentalForecast.Modify(true);

            _EntriesCount += 1;

        end;

    
    until _Date.Next()= 0;
     if not p_Silent then 
            Message('Rental Forecast modified, %1 entries', _EntriesCount);
     
end;

           
}