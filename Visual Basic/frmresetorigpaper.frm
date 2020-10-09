VERSION 5.00
Begin VB.Form frmResetOrigPaper 
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
Attribute VB_Name = "frmResetOrigPaper"
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
'This program is used to change the paper size back
'to it's original setting.  KDS 08/06/2001

Dim PrinterName As String
Dim RetValue As String

'Retrieve the default printer name.
PrinterName = Printer.DeviceName

'If the default printer is set to legal paper then
'call the function SetPaperToOrig.
If (Printer.PaperSize = vbPRPSLegal) Then
'** P03-335 ** 06/03/03 ** KDS ** START ***********************************
  RetValue = SetPaperToOrig("HKEY_CURRENT_USER\PRINTERS\CONNECTIONS\" _
                            & Replace(PrinterName, "\", ","), "DevMode")
'** P03-335 ** 06/03/03 ** KDS **  END  ***********************************
End If

'Close the form.
Unload frmResetOrigPaper
End Sub


