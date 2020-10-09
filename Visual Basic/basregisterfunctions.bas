Attribute VB_Name = "basRegisterFunctions"
Public Function GetSKHnd(sKeyPath As String, lKeyOption As Long) As Long

Dim iSKCnt As Integer
Dim lHnd(1 To 32) As Long
Dim lLastHnd As Long
Dim lErrCheck As Long
Dim sCleanKeyPath As String
Dim sSubKeys(1 To 32) As String
Dim sTempKeys() As String

'Remove any spaces from the left and right side of sKeyPath.
sCleanKeyPath = Trim$(sKeyPath)

'Split sCleanKeyPath and load into sTempKeys.
sTempKeys = Split(sCleanKeyPath, "\")

'Copy the items from sTempKeys to sSubKeys excluding blank items.
For i = 0 To UBound(sTempKeys)
  'If position i <> to "" then increment iSKCnt by 1 and
  'If iSKCnt <= 32 then
  'set positon iSKCnt of sSubKeys = position i of sTempKeys
  'else set the return value of the function = -1 and Exit the function
  'because the path contained too many subkeys.
  If sTempKeys(i) <> "" Then
    iSKCnt = iSKCnt + 1
    If iSKCnt <= 32 Then
      sSubKeys(iSKCnt) = sTempKeys(i)
    Else
      GetSKHnd = -1
      Exit Function
    End If
  End If
Next i
'Loop thru the items of sSubKeys to retrieve the handle for the last subkey.
For i = 1 To iSKCnt - 1
  'The first loop sets the handle for the root key.
  If i = 1 Then
    Select Case UCase$(sSubKeys(1))
      Case "HKEY_CURRENT_USER":
        lLastHnd = &H80000001
      Case "HKEY_LOCAL_MACHINE":
        lLastHnd = &H80000002
      Case Else:
        GetSKHnd = -1
        Exit Function
    End Select
  End If
  'Open the next key specified in the position of sSubKeys(i+1) and store the
  'handle in lHnd(i).
  lErrCheck = RegOpenKey(lLastHnd, sSubKeys(i + 1), 0, lKeyOption, lHnd(i))

  'If the next key was opened successfully then
  'set lLastHnd = to the handle stored in lHnd(i).
  If (lErrCheck = ERROR_SUCCESS) Then
    lLastHnd = lHnd(i)
  Else
    'Close all previously opened subkeys.
    'Set the function return value = -1  and Exit the function.
    For j = 1 To (i - 1)
      lErrCheck = RegCloseKey(lHnd(j))
    Next j
    
    GetSKHnd = -1
    Exit Function
  End If
Next i

'Set the return value of the function to the last handle retrieved.
GetSKHnd = lLastHnd

'Close all of the subkeys except the last one.
For i = 1 To (iSKCnt - 2)
  lErrCheck = RegCloseKey(lHnd(i))
Next i
End Function
