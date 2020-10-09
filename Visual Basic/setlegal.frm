VERSION 5.00
Begin VB.Form frmSetLegal 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "frmSetLegal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
'***************************************************************************
'*           MODIFICATION HISTORY                                         *
'*           ====================                                         *
'* PROJ #        DATE      BY         REASON FOR CHANGE                   *
'* =======     ========    ===     ====================================== *
'* P03-335     06/03/03    KDS      The domain server uses different      *
'*                                  register keys than the Novell print   *
'*                                  server for the printer specifications.*
'*                                  Modified the program to fix this      *
'*                                  problem.                              *
'                                                                         *
'**************************************************************************
'This program is used to change the paper size to legal
'on the default printer.  KDS 08/06/2001

Dim PrinterName As String
Dim PrinterPort As String
Dim revPrinterName As String
Dim revPrinterName2 As String
Dim RetValue As String

'Retrieve the default printer name and port.
PrinterName = Printer.DeviceName
PrinterPort = Printer.Port

'** P03-335 ** 06/03/03 ** KDS ** START ***********************************
'If the default printer supports legal paper and it is not
'already set to legal paper then create 2 printer names: one with
'"\\occprint\" removed from the beginning of the name and one with
'all the "\" replaced with ",".  Call the function SetPaperToLegal.
If (LegalSupAndNeeded(PrinterName, PrinterPort)) Then
  revPrinterName = Replace(PrinterName, "\\occprint\", "")
  revPrinterName2 = Replace(PrinterName, "\", ",")
  RetValue = SetPaperToLegal("HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\WINDOWS NT\" _
                             & "CURRENTVERSION\PRINT\PROVIDERS\LANMAN PRINT SERVICES\" _
                             & "SERVERS\OCCPRINT1\PRINTERS\" & revPrinterName, _
                             "Default DevMode", _
                             "HKEY_CURRENT_USER\PRINTERS\CONNECTIONS\" _
                             & revPrinterName2, "DevMode", "OrigPrinterSetting")
'** P03-335 ** 06/03/03 ** KDS **  END  ***********************************
End If

'Close the form.
Unload frmSetLegal
End Sub
