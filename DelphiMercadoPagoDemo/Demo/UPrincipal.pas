unit UPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.EditBox, FMX.SpinBox, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts,
  FMX.TabControl, FMX.Objects, MercadoPagoDelphi, System.Messaging;

type
  TFrmPrincipal = class(TForm)
    LtTopo: TLayout;
    LtRodape: TLayout;
    LtDadosPagamento: TLayout;
    Label1: TLabel;
    BtnPagamento: TButton;
    Label2: TLabel;
    EdtValor: TEdit;
    Label3: TLabel;
    RbDebito: TRadioButton;
    RbCredito: TRadioButton;
    LtTipoCartao: TLayout;
    Label4: TLabel;
    LtParcelas: TLayout;
    SbParcelas: TSpinBox;
    TCBase: TTabControl;
    TiBasePagamento: TTabItem;
    TiConfiguracoes: TTabItem;
    Layout1: TLayout;
    StyleBook1: TStyleBook;
    TCPagamento: TTabControl;
    TiPagamento: TTabItem;
    TiOkPagamento: TTabItem;
    TiFalhaPagamento: TTabItem;
    Layout2: TLayout;
    BtNovoPagamento: TButton;
    Layout3: TLayout;
    BtTentarNovamente: TButton;
    Layout4: TLayout;
    Label8: TLabel;
    Image1: TImage;
    LbMotivoFalha: TLabel;
    Layout5: TLayout;
    Label9: TLabel;
    Image2: TImage;
    LbAddRealizado: TLabel;
    MercadoPagoLocal1: TMercadoPagoLocal;
    EdtDescricao: TEdit;
    Label10: TLabel;
    procedure RbDebitoChange(Sender: TObject);
    procedure BtNovoPagamentoClick(Sender: TObject);
    procedure BtnPagamentoClick(Sender: TObject);
    procedure MercadoPagoLocal1ResultadoVenda(Sender: TObject;
      Resultado: TResultadoMercadoPagoDelphi);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

procedure TFrmPrincipal.BtNovoPagamentoClick(Sender: TObject);
begin
TCPagamento.GotoVisibleTab(TiPagamento.Index);
end;

procedure TFrmPrincipal.BtnPagamentoClick(Sender: TObject);
begin
  MercadoPagoLocal1.ProcessarPagamento(StrToFloat(EdtValor.Text.Replace('.', ',')), RbCredito.IsChecked, Trunc(SbParcelas.Value), EdtDescricao.Text);
end;

procedure TFrmPrincipal.MercadoPagoLocal1ResultadoVenda(Sender: TObject;
  Resultado: TResultadoMercadoPagoDelphi);
begin
  if Resultado.VendaEfetuada = true then
  begin
    LbAddRealizado.Text:= 'Id da Venda: ' + Resultado.IdPagamento + sLineBreak +
                          'Valor pago: R$' + FormatFloat('######0.00', Resultado.ValorPago).Replace('.', ',') + sLineBreak +
                          'Tipo de cartão: ' + Resultado.TipoCartao + sLineBreak +
                          'Parcelas: ' + IntToStr(Resultado.Parcelas) + sLineBreak +
                          'Titular Cartão: ' + Resultado.TitularCartao;
    TCPagamento.GotoVisibleTab(TiOkPagamento.Index);
    end
    else
    begin
    TCPagamento.GotoVisibleTab(TiFalhaPagamento.Index);
    LbMotivoFalha.Text:= 'Erro: ' + Resultado.DescricaoErro;
  end;
end;

procedure TFrmPrincipal.RbDebitoChange(Sender: TObject);
begin
if RbCredito.IsChecked then
begin
  Label4.Visible:= true;
  LtParcelas.Visible:= true;
  end
  else
  begin
  LtParcelas.Visible:= False;
  Label4.Visible:= False;
end;
end;

end.
