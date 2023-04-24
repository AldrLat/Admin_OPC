unit UnitDataModule;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TFormDataModule = class(TDataModule)
    ADOConnectionAccessMDB: TADOConnection;
    ADOQueryAccessMDB: TADOQuery;
    ADOConnectionDataMDB: TADOConnection;
    ADOQueryDataMDB: TADOQuery;
    ADOConnectionServerMDB: TADOConnection;
    ADOQueryServerMDB: TADOQuery;
    ADOConnectionWorkStationMDB: TADOConnection;
    ADOQueryWorkStationMDB: TADOQuery;
    DataSourceAccessMDB: TDataSource;
    DataSourceDataMDB: TDataSource;
    DataSourceServerMDB: TDataSource;
    DataSourceWorkStationMDB: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDataModule: TFormDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
