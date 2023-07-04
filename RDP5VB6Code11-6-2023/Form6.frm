VERSION 5.00
Begin VB.Form Form6 
   Caption         =   "Form6"
   ClientHeight    =   5385
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7950
   LinkTopic       =   "Form6"
   ScaleHeight     =   5385
   ScaleWidth      =   7950
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   255
      Left            =   2040
      TabIndex        =   2
      Top             =   0
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   255
      Left            =   840
      TabIndex        =   1
      Top             =   0
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      Height          =   4215
      Left            =   840
      ScaleHeight     =   4155
      ScaleWidth      =   6675
      TabIndex        =   0
      Top             =   240
      Width           =   6735
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
 
 
 
 
 
 
 
 
 
 
 Form6.Picture1.Picture = LoadPicture()
 Dim MaxMem As Double

APhys = Abs(MemSit.dwTotalPhys)
If APhys > 1000000000 Or APhys < 1000000 Then APhys = 1000000000
MaxMem = Sqr(APhys) / 8
Dim SF As Double
Dim MAxD As Double
SF = MaxMem / Len(StrainSeq(0))
If SF > 1 Then
    SF = 1
    MaxMem = Len(StrainSeq(0))
End If
matxfact = Form6.Picture1.ScaleHeight / CLng(MaxMem)
If 1 / matxfact < 1 Then matxfact = 1
For x = 1 To CLng(MaxMem) Step Int(1 / matxfact)
        For y = 1 To CLng(MaxMem) Step Int(1 / matxfact)
            If RecombMatrix(x, y) > MAxD Then MAxD = RecombMatrix(x, y)
            'Exit Sub
        Next y
Next x
    
    
    For x = 1 To CLng(MaxMem) Step Int(1 / matxfact)
        For y = 1 To CLng(MaxMem) Step Int(1 / matxfact)
            SC = (255 * 3) * (RecombMatrix(x, y) / MAxD)
            RC = SC - 510
            If RC < 0 Then RC = 0
            GC = SC - RC - 255
            If GC < 0 Then GC = 0
            BC = SC - RC - GC
            
            SetPixelV Form6.Picture1.hdc, x * matxfact, y * matxfact, RGB(RC, GC, BC)
            'Exit Sub
        Next y
        Form6.Picture1.Refresh
    Next x

    
   
    

End Sub

Private Sub Command2_Click()

SavePicture Picture1.Image, "test.bmp"
Exit Sub
Dim MaxMem As Double

Dim SF As Double, TStr As String, TStr2 As String
Dim MAxD As Double

APhys = Abs(MemSit.dwTotalPhys)
If APhys > 1000000000 Or APhys < 1000000 Then APhys = 1000000000
MaxMem = Sqr(APhys) / 8
SF = MaxMem / Len(StrainSeq(0))

If SF > 1 Then
    SF = 1
    MaxMem = Len(StrainSeq(0))
End If

Open "temp.txt" For Output As #1
Dim DoThisOne() As Byte
ReDim DoThisOne(MaxMem)

DoThisOne(350 * SF) = 1
DoThisOne(700 * SF) = 1
DoThisOne(1550 * SF) = 1
DoThisOne(2200 * SF) = 1
DoThisOne(3100 * SF) = 1
For y = 0 To MaxMem
    TStr = CStr(CLng(y / SF))
    For x = 0 To MaxMem
        If DoThisOne(x) = 1 Then
            'Print #1, CLng(X / SF)
            'TStr = CStr(CLng(X / SF))
            
                TStr2 = CStr(RecombMatrix(x, y))
                Pos = InStr(1, TStr2, ",", vbBinaryCompare)
                Do While Pos > 0
                    Mid(TStr2, Pos, 1) = "."
                    Pos = InStr(1, TStr2, ",", vbBinaryCompare)
                Loop
                TStr = TStr & "," & TStr2
                
            
        End If
        
        
    Next x
    Print #1, TStr
    Form1.ProgressBar1 = (y / MaxMem) * 100
    Call UpdateF2Prog
Next y
Close #1
End Sub

