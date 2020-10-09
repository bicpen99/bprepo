Attribute VB_Name = "basDeclarations"
'Constant Declarations
Public Const DC_PAPERS = 2
Public Const DMPAPER_LEGAL = 5  ' Legal 8 1/2 x 14 inches
Public Const REG_BINARY = 3
Public Const UserSource = "USER"
Public Const DefaultSource = "DEFAULT"
Public Const FunctionSuccess = "Succeeded"
Public Const FunctionFailure = "Failed"
Public Const STANDARD_RIGHTS_ALL = &H1F0000
Public Const KEY_QUERY_VALUE = &H1
Public Const KEY_SET_VALUE = &H2
Public Const KEY_CREATE_SUB_KEY = &H4
Public Const KEY_ENUMERATE_SUB_KEYS = &H8
Public Const KEY_NOTIFY = &H10
Public Const KEY_CREATE_LINK = &H20
Public Const SYNCHRONIZE = &H100000
Public Const KEY_ALL_ACCESS = ((STANDARD_RIGHTS_ALL Or KEY_QUERY_VALUE Or _
                               KEY_SET_VALUE Or KEY_CREATE_SUB_KEY Or _
                               KEY_ENUMERATE_SUB_KEYS Or KEY_NOTIFY Or _
                               KEY_CREATE_LINK) And (Not SYNCHRONIZE))

'Functions --------------------------------------------------------------------
Public Declare Function DevCap Lib "winspool.drv" Alias "DeviceCapabilitiesA" _
       (ByVal DevName As String, ByVal Port As String, ByVal iCap As Long, _
        Output As Any, ByVal DevBuff As Long) As Long
      
Public Declare Function RegOpenKey Lib "advapi32" _
       Alias "RegOpenKeyExA" (ByVal hKey As Long, _
       ByVal SubKey As String, ByVal Options As Long, _
       ByVal SecRights As Long, hOpenKey As Long) As Long
       
Public Declare Function RegCloseKey Lib "advapi32" _
       (ByVal hKey As Long) As Long
      
Public Declare Function RegQryNULLKey Lib "advapi32" Alias _
       "RegQueryValueExA" (ByVal hKey As Long, ByVal QryKey As String, _
       ByVal Reserved As Long, BuffType As Long, ByVal BuffData As Long, _
       SizeBuffData As Long) As Long
       
Public Declare Function RegQryBinaryKey Lib "advapi32" Alias _
       "RegQueryValueExA" (ByVal hKey As Long, ByVal QryKey As String, _
       ByVal Reserved As Long, BuffType As Long, BuffData As Byte, _
       SizeBuffData As Long) As Long
    
Public Declare Function RegSetBinaryKey Lib "advapi32" Alias "RegSetValueExA" _
       (ByVal hKey As Long, ByVal SetKey As String, ByVal Reserved As Long, _
       ByVal BuffType As Long, BuffData As Byte, _
       ByVal SizeBuffData As Long) As Long
