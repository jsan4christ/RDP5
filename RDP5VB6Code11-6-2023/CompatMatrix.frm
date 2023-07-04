VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Form4 
   Caption         =   "Compatibility Matrix"
   ClientHeight    =   6180
   ClientLeft      =   45
   ClientTop       =   -15
   ClientWidth     =   7245
   Icon            =   "CompatMatrix.frx":0000
   LinkTopic       =   "Form4"
   ScaleHeight     =   6180
   ScaleWidth      =   7245
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture3 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ClipControls    =   0   'False
      ForeColor       =   &H80000008&
      Height          =   1236
      Left            =   150
      ScaleHeight     =   1230
      ScaleWidth      =   4890
      TabIndex        =   7
      Top             =   1620
      Visible         =   0   'False
      Width           =   4884
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   465
      Left            =   240
      TabIndex        =   4
      Top             =   60
      Visible         =   0   'False
      Width           =   7095
      _Version        =   65536
      _ExtentX        =   12515
      _ExtentY        =   820
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSPanel SSPanel3 
         Height          =   405
         Left            =   2430
         TabIndex        =   6
         Top             =   60
         Width           =   3285
         _Version        =   65536
         _ExtentX        =   5794
         _ExtentY        =   714
         _StockProps     =   15
         Caption         =   "SSPanel3"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSPanel SSPanel2 
         Height          =   375
         Left            =   150
         TabIndex        =   5
         Top             =   60
         Width           =   2115
         _Version        =   65536
         _ExtentX        =   3731
         _ExtentY        =   661
         _StockProps     =   15
         Caption         =   "SSPanel2"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Command1"
         Height          =   195
         Left            =   1800
         TabIndex        =   8
         Top             =   1320
         Width           =   135
      End
   End
   Begin VB.PictureBox Picture1 
      ClipControls    =   0   'False
      Height          =   5145
      Left            =   90
      ScaleHeight     =   5085
      ScaleWidth      =   10125
      TabIndex        =   2
      Top             =   600
      Visible         =   0   'False
      Width           =   10185
      Begin VB.PictureBox Picture2 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ClipControls    =   0   'False
         ForeColor       =   &H80000008&
         Height          =   4965
         Left            =   480
         ScaleHeight     =   4965
         ScaleWidth      =   5415
         TabIndex        =   3
         Top             =   510
         Width           =   5415
      End
   End
   Begin VB.HScrollBar HScroll1 
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   5820
      Visible         =   0   'False
      Width           =   6765
   End
   Begin VB.VScrollBar VScroll1 
      Height          =   5805
      Left            =   10380
      TabIndex        =   0
      Top             =   0
      Width           =   255
   End
End
Attribute VB_Name = "Form4"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Resize()
    If DebuggingFlag < 2 Then On Error Resume Next

    If Form4.WindowState = 0 Then
        Form4.Width = Form4OWidth
        Form4.Height = Form4OHeight
    End If

    On Error GoTo 0
End Sub

Private Sub HScroll1_Change()

    Dim OScaleMode As Integer

    OScaleMode = Form4.ScaleMode

    If RepaintFlag = 0 Then
        Form4.ScaleMode = 3
        Picture2.Left = -HScroll1.Value
        Form4.ScaleMode = OScaleMode
    End If

End Sub

Private Sub HScroll1_GotFocus()
    Command1.SetFocus
End Sub

Private Sub HScroll1_Scroll()

    Dim OScaleMode As Integer

    OScaleMode = Form4.ScaleMode

    If RepaintFlag = 0 Then
        RepaintFlag = 0
        Form4.ScaleMode = 3
        Picture2.Left = -HScroll1.Value
        Form4.ScaleMode = OScaleMode
    End If

End Sub



Private Sub Picture2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    'ZoomFlag = 0
    RecSeq = 0
    PAVal = 0: PermXVal = 0: PermYVal = 0
    Dim OScaleMode As Integer

    OScaleMode = Form1.ScaleMode
    Form1.ScaleMode = 3

    Dim Mag As Double

    Mag = ((Picture2.Width) / Square) '/ 1.0136

    Dim CenterPixelX As Long
    Dim CenterPixelY As Long

    CenterPixelX = Int((X / Mag)) + 1
    CenterPixelY = Int((Y / Mag)) + 1
    If DebuggingFlag < 2 Then On Error Resume Next

    If CenterPixelX <= Square And CenterPixelY <= Square And CenterPixelX >= 0 And CenterPixelY >= 0 Then
        SSPanel3.Caption = RetXPos(CenterPixelX + 1) & "," & RetXPos(CenterPixelY + 1)
    End If

    On Error GoTo 0
    Form1.ScaleMode = OScaleMode
End Sub

Private Sub Picture2_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    'RepaintFlag = 0
    'Picture2.Refresh
    ZoomFlag = 0
End Sub

Private Sub VScroll1_Change()

    Dim OScaleMode As Integer

    OScaleMode = Form4.ScaleMode

    If RepaintFlag = 0 Then
        Form4.ScaleMode = 3
        'VScroll1.Max = Picture2.Height - Picture1.Height
        Picture2.Top = -VScroll1.Value
        Form4.ScaleMode = OScaleMode
    End If

End Sub

Private Sub VScroll1_GotFocus()
    If DebuggingFlag < 2 Then On Error Resume Next
    Command1.SetFocus
    On Error GoTo 0
End Sub

Private Sub VScroll1_Scroll()

    Dim OScaleMode As Integer

    OScaleMode = Form4.ScaleMode

    If RepaintFlag = 0 Then
        RepaintFlag = 0
        Form4.ScaleMode = 3
        Picture2.Top = -VScroll1.Value
        Form4.ScaleMode = OScaleMode
    End If

End Sub
