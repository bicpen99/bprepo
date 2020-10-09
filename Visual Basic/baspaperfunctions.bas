Attribute VB_Name = "basPaperFunctions"
Dim lUserSKHnd As Long
Dim lDefSKHnd As Long
Dim lUserBuffSize As Long
Dim lDefBuffSize As Long
Dim lOrigBuffSize As Long
Dim bUserBuff() As Byte
Dim bDefBuff() As Byte
Dim bOrigBuff() As Byte
Dim lErrCheck As Long
Dim sSettingSource As String

Public Function LegalSupAndNeeded(PrnName As String, PrnPort As String) As Boolean

Dim lPaperCount As Long
Dim iPaperSizes() As Integer
Dim bLegalSup As Boolean

'Set function return value to FALSE.
LegalSupAndNeeded = False
'If the printer paper is already set to legal then exit the function.
If (Printer.PaperSize = vbPRPSLegal) Then
  Exit Function
Else
  'Retrieve the number of paper sizes supported.
  'Re-initialize the iPaperSizes array to the number of paper sizes supported.
  lPaperCount = DevCap(PrnName, PrnPort, DC_PAPERS, _
                       ByVal vbNullString, 0)
  ReDim iPaperSizes(1 To lPaperCount)

  'Retrieve the paper sizes.
  lPaperCount = DevCap(PrnName, PrnPort, DC_PAPERS, iPaperSizes(1), 0)

  'Determine if legal size paper is supported.
  bLegalSup = False
  For i = 1 To lPaperCount
    If (iPaperSizes(i) = DMPAPER_LEGAL) Then  'Legal 8 1/2 x 14 inches
      bLegalSup = True
      Exit For
    End If
  Next i

  'If legal is supported then
  'set function return value to TRUE
  If (bLegalSup) Then
    LegalSupAndNeeded = True
  End If
   
End If
End Function

Public Function SetPaperToLegal(DefKeyPath As String, DefKeyName As String, _
                                UserKeyPath As String, UserKeyName As String, _
                                OrigKeyName As String)
Dim RetValue As String

'Make back up copy of register setting.
RetValue = CopyOrigPrinterSetting(DefKeyPath, DefKeyName, UserKeyPath, _
                                  UserKeyName, OrigKeyName)

'If back up was created successfully then
'change the paper size to legal.
If (RetValue = FunctionSuccess) Then
  RetValue = ModifyPaperSize(UserKeyName)
  
  'If the change to legal paper fails then
  'copy the back up to the DevModePerUser\"printername" register key.
  If (RetValue = FunctionFailure) Then
    RetValue = ResetKeyToOrig(UserKeyName, OrigKeyName)
  End If
End If

'Closes the subkey handles.
lErrCheck = RegCloseKey(lUserSKHnd)
lErrCheck = RegCloseKey(lDefSKHnd)

End Function

Public Function CopyOrigPrinterSetting(DefKeyPath As String, DefKeyName As String, _
                                       UserKeyPath As String, UserKeyName As String, _
                                       OrigKeyName As String) As String
' Attempt to get the user subkey handle using the GetSKHnd function.
lUserSKHnd = GetSKHnd(UserKeyPath, KEY_ALL_ACCESS)

'If the user subkey handle is not found then set function return
'value = FunctionFailure and Exit the function.
If (lUserSKHnd = -1) Then
  CopyOrigPrinterSetting = FunctionFailure
  Exit Function
End If

'Retrieve the size of the user key.
lErrCheck = RegQryNULLKey(lUserSKHnd, UserKeyName, 0&, REG_BINARY, 0&, lUserBuffSize)

'If the size of the user key was retrieved successfully then
're-intialize the bUserbuff array to the size of the user key.
'Query the register key to retrieve the printer settings.
If (lErrCheck = ERROR_SUCCESS) Then
  ReDim bUserBuff(lUserBuffSize)
  lErrCheck = RegQryBinaryKey(lUserSKHnd, Trim$(UserKeyName), 0, REG_BINARY, _
                            bUserBuff(0), lUserBuffSize)
  
  'If the user register key was read successfully then set sSettingSource =
  'UserSource and copy the previously retrieved key for either back up
  'purposes or to set the register key back to the original value after
  'the report is done.
  If (lErrCheck = ERROR_SUCCESS) Then
    sSettingSource = UserSource
    lErrCheck = RegSetBinaryKey(lUserSKHnd, OrigKeyName, 0&, REG_BINARY, _
                              bUserBuff(0), lUserBuffSize)
    
    'If copying the register key failed then set the function return value =
    'FunctionFailure and Exit the function.
    If (lErrCheck <> ERROR_SUCCESS) Then
      CopyOrigPrinterSetting = FunctionFailure
      Exit Function
    End If
  Else
    'If the user register key was not read successfully then set the
    'function return value = FunctionFailure and Exit the function.
    CopyOrigPrinterSetting = FunctionFailure
    Exit Function
  End If
Else
  'If the size of the user key was NOT retrieved successfully then attempt
  'to get the default subkey handle using the GETSKHnd function.
  lDefSKHnd = GetSKHnd(DefKeyPath, KEY_QUERY_VALUE)
  
  'If the default subkey handle is not found then set the
  'function return value = FunctionFailure and Exit the function.
  If (lDefSKHnd = -1) Then
    CopyOrigPrinterSetting = FunctionFailure
    Exit Function
  End If
  
  'Retrieve the size of the default key.
  lErrCheck = RegQryNULLKey(lDefSKHnd, DefKeyName, 0&, REG_BINARY, 0&, lDefBuffSize)
  
  'If the size of the default key was retrieved successfully then
  're-intialize the bDefbuff array to the size of the default key.
  'Query the register key to retrieve the printer settings.
  If (lErrCheck = ERROR_SUCCESS) Then
    ReDim bDefBuff(lDefBuffSize)
    lErrCheck = RegQryBinaryKey(lDefSKHnd, Trim$(DefKeyName), 0, REG_BINARY, _
                              bDefBuff(0), lDefBuffSize)
     
    'If the default register key was read successfully then set sSettingSource =
    'DefaultSource and set the paper size to the current default papersize and
    'copy the previously retrieved key for either back up purposes or to set
    'the register key back to the original value after the report is done.
    If (lErrCheck = ERROR_SUCCESS) Then
      sSettingSource = DefaultSource
      bDefBuff(78) = Printer.PaperSize
      lErrCheck = RegSetBinaryKey(lUserSKHnd, OrigKeyName, 0&, REG_BINARY, _
                            bDefBuff(0), lDefBuffSize)
       
      'If copying the register key failed then set the function return value =
      'FunctionFailure and Exit the function.
      If (lErrCheck <> ERROR_SUCCESS) Then
        CopyOrigPrinterSetting = FunctionFailure
        Exit Function
      End If
    Else
      'If the default register key was NOT read successfully then set the
      'function return value = FunctionFailure and Exit the function.
      CopyOrigPrinterSetting = FunctionFailure
      Exit Function
    End If
  Else
    'If the size of the default key was NOT retrieved successfully then
    'set the function return value = FunctionFailure and
    'Exit the function.
    CopyOrigPrinterSetting = FunctionFailure
    Exit Function
  End If
End If

'If the register key has been copied successfully then set
'the function return value = FunctionSuccess.
CopyOrigPrinterSetting = FunctionSuccess

End Function

Public Function ModifyPaperSize(UserKeyName As String)

'Dependent upon which register setting is read either
'HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS\"printername"\DEFAULT DEVMODE OR
'HKEY_CURRENT_USER\PRINTERS\DEVMODEPERUSER\"printername"
'modify the appropriate array and write the change back
'to HKEY_CURRENT_USER\PRINTERS\DEVMODEPERUSER\"printername".
If (sSettingSource = DefaultSource) Then
  bDefBuff(78) = vbPRPSLegal
  lErrCheck = RegSetBinaryKey(lUserSKHnd, UserKeyName, 0&, REG_BINARY, _
                            bDefBuff(0), lDefBuffSize)
ElseIf (sSettingSource = UserSource) Then
  bUserBuff(78) = vbPRPSLegal
  lErrCheck = RegSetBinaryKey(lUserSKHnd, UserKeyName, 0&, REG_BINARY, _
                            bUserBuff(0), lUserBuffSize)
End If

'Dependent upon the success/failure of the write to the
'register key, sets the return value for the function.
If (lErrCheck = ERROR_SUCCESS) Then
  ModifyPaperSize = FunctionSuccess
Else
  ModifyPaperSize = FunctionFailure
End If
End Function

Public Function ResetKeyToOrig(UserKeyName As String, OrigKeyName As String)

'Retrieve the size of the original key.
lErrCheck = RegQryNULLKey(lUserSKHnd, OrigKeyName, 0&, REG_BINARY, 0&, lOrigBuffSize)

'If the size was retrieved successfully then re-initialize bOrigbuff array
'to the size of the original key.
'Retrieve the printer information from the original key.
If (lErrCheck = ERROR_SUCCESS) Then
  ReDim bOrigBuff(lOrigBuffSize)
  lErrCheck = RegQryBinaryKey(lUserSKHnd, Trim$(OrigKeyName), 0, REG_BINARY, _
                            bOrigBuff(0), lOrigBuffSize)
                            
  'If the register key was read successfully then replace the user key with
  'the original key.
  If (lErrCheck = ERROR_SUCCESS) Then
    lErrCheck = RegSetBinaryKey(lUserSKHnd, UserKeyName, 0&, REG_BINARY, _
                              bOrigBuff(0), lOrigBuffSize)
                              
    'If replacing the register key failed then set function return value =
    'FunctionFailure and Exit the function.
    If (lErrCheck <> ERROR_SUCCESS) Then
      ResetKeyToOrig = FunctionFailure
      Exit Function
    End If
    
  'If the register key was NOT read successfully then set the function
  'return value = FunctionFailure.
  Else
    ResetKeyToOrig = FunctionFailure
  End If
End If
End Function


Public Function SetPaperToOrig(UserKeyPath As String, UserKeyName As String) As String

Dim RetValue As String

' Attempt to get the user subkey handle using the GetSKHnd function.
lUserSKHnd = GetSKHnd(UserKeyPath, KEY_ALL_ACCESS)

'If the user subkey handle is not found then set function return
'value = FunctionFailure and Exit the function.
If (lUserSKHnd = -1) Then
  SetPaperToOrig = FunctionFailure
  Exit Function
Else
  'Call ResetKeyToOrig to set the printer back to it's original
  'setting.
  RetValue = ResetKeyToOrig(UserKeyName, "OrigPrinterSetting")
End If
End Function
