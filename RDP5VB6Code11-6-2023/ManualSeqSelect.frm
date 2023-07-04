VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Form5 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form5"
   ClientHeight    =   5190
   ClientLeft      =   90
   ClientTop       =   840
   ClientWidth     =   6915
   ControlBox      =   0   'False
   Icon            =   "ManualSeqSelect.frx":0000
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5190
   ScaleWidth      =   6915
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.Timer Timer3 
      Interval        =   50
      Left            =   2520
      Top             =   720
   End
   Begin VB.Timer Timer4 
      Interval        =   50
      Left            =   5400
      Top             =   360
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Cancel"
      Height          =   345
      Left            =   3720
      MouseIcon       =   "ManualSeqSelect.frx":030A
      MousePointer    =   99  'Custom
      TabIndex        =   2
      Top             =   4470
      Width           =   1005
   End
   Begin VB.CommandButton Command3 
      Caption         =   "OK"
      Height          =   405
      Left            =   2040
      MouseIcon       =   "ManualSeqSelect.frx":045C
      MousePointer    =   99  'Custom
      TabIndex        =   1
      Top             =   4470
      Width           =   855
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Options"
      Height          =   375
      Left            =   3000
      TabIndex        =   18
      Top             =   4440
      Width           =   735
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3585
      Left            =   105
      TabIndex        =   4
      Top             =   795
      Width           =   6735
      _Version        =   65536
      _ExtentX        =   11880
      _ExtentY        =   6324
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
      Begin VB.CheckBox Check1 
         Caption         =   "Closest relative scan"
         Height          =   285
         Left            =   4710
         TabIndex        =   17
         Top             =   150
         Visible         =   0   'False
         Width           =   1875
      End
      Begin VB.ComboBox Combo1 
         Height          =   315
         Left            =   3000
         MouseIcon       =   "ManualSeqSelect.frx":05AE
         MousePointer    =   99  'Custom
         Sorted          =   -1  'True
         Style           =   2  'Dropdown List
         TabIndex        =   13
         Top             =   100
         Width           =   1245
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   2175
         Left            =   2190
         TabIndex        =   12
         Top             =   810
         Width           =   200
      End
      Begin VB.VScrollBar VScroll2 
         Height          =   2145
         Left            =   5430
         TabIndex        =   11
         Top             =   1020
         Width           =   200
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Select All"
         Height          =   345
         Left            =   2310
         MouseIcon       =   "ManualSeqSelect.frx":0700
         MousePointer    =   99  'Custom
         TabIndex        =   10
         Top             =   960
         Width           =   915
      End
      Begin VB.CommandButton Command6 
         Caption         =   "Unselect All"
         Height          =   285
         Left            =   2280
         MouseIcon       =   "ManualSeqSelect.frx":0852
         MousePointer    =   99  'Custom
         TabIndex        =   9
         Top             =   1360
         Width           =   1035
      End
      Begin VB.PictureBox Picture3 
         BackColor       =   &H80000005&
         Height          =   2500
         Left            =   100
         ScaleHeight     =   2445
         ScaleWidth      =   1935
         TabIndex        =   7
         Top             =   850
         Width           =   2000
         Begin VB.PictureBox Picture1 
            AutoRedraw      =   -1  'True
            BackColor       =   &H80000005&
            BorderStyle     =   0  'None
            Height          =   2205
            Left            =   0
            MouseIcon       =   "ManualSeqSelect.frx":09A4
            ScaleHeight     =   2205
            ScaleWidth      =   1995
            TabIndex        =   8
            Top             =   0
            Width           =   2000
         End
      End
      Begin VB.PictureBox Picture4 
         BackColor       =   &H80000005&
         Height          =   2295
         Left            =   3450
         ScaleHeight     =   2235
         ScaleWidth      =   1815
         TabIndex        =   5
         Top             =   870
         Width           =   1875
         Begin VB.PictureBox Picture2 
            AutoRedraw      =   -1  'True
            BackColor       =   &H80000005&
            BorderStyle     =   0  'None
            Height          =   2175
            Left            =   0
            MouseIcon       =   "ManualSeqSelect.frx":0AF6
            ScaleHeight     =   2175
            ScaleWidth      =   1875
            TabIndex        =   6
            Top             =   0
            Width           =   1875
         End
      End
      Begin VB.Label Label1 
         Caption         =   "Potential Recombinant Sequence:"
         Height          =   315
         Left            =   100
         TabIndex        =   16
         Top             =   130
         Width           =   2475
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         Caption         =   "Unselected"
         Height          =   435
         Left            =   60
         TabIndex        =   15
         Top             =   450
         Width           =   1665
      End
      Begin VB.Label Label3 
         Alignment       =   2  'Center
         Caption         =   "Potential Parental Sequences"
         Height          =   315
         Left            =   3330
         TabIndex        =   14
         Top             =   570
         Width           =   2175
      End
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Command2"
      Height          =   315
      Left            =   1320
      TabIndex        =   0
      Top             =   1620
      Width           =   315
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      Caption         =   "Label4"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   630
      Left            =   270
      TabIndex        =   3
      Top             =   100
      Width           =   6225
   End
   Begin VB.Menu GroupMnu 
      Caption         =   "Group Sequences"
      Visible         =   0   'False
      Begin VB.Menu KomMnu 
         Caption         =   "Group with Kom"
      End
   End
   Begin VB.Menu ChangListMnu 
      Caption         =   "Change this list"
      Visible         =   0   'False
      Begin VB.Menu QvRShowOnlyMnu 
         Caption         =   "Show only sequences that are not in any of the reference groups"
      End
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Check1_Click()
    Command2.SetFocus
End Sub

Private Sub Combo1_Click()
If QvRSelectFlag = 1 Then
    If DontDoComboFlag = 0 Then
'        If RedoRefNamesFlag = 1 Then
'            Call MakeRefGroupNames
'        End If
        Call DoSelectInterface
        
    End If
Else
    
    Call DoSelectInterface
    
End If
End Sub

Private Sub Command1_Click()
    Command2.SetFocus
    If QvRSelectFlag = 1 Then
        If QvRShowOnlyFlag = 1 Then
            For x = 0 To PermNextno
                If ReferenceList(x) = 0 Then
                    ReferenceList(x) = Form5.Combo1.ListIndex
                End If
            Next x
        Else
            For x = 0 To PermNextno
                If ReferenceList(x) <> Form5.Combo1.ListIndex Then
                    ReferenceList(x) = Form5.Combo1.ListIndex
                End If
            Next x
        End If
        Call PrintNames
    Else
        For x = 0 To NextNo
            Selected(x) = 1
        Next 'X
    End If
    TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    'Form5.Picture1.Height = Current1
    Form5.Picture2.Height = (NextNo + 2) * Screen.TwipsPerPixelY * TextHi

    Call DoSelectInterface

End Sub

Private Sub Command2_Click()
    Command2.SetFocus
End Sub

Private Sub Command3_Click()
    If QvRSelectFlag = 1 Then
        
        If RefNum > 1 Then
            QvRSelectFlag = 0
            QvRScanGoonFlag = 1
            If RedoRefNamesFlag = 1 Then
                Call MakeRefGroupNames
            End If
            Command5.Enabled = True
            Command2.SetFocus
            Form5.Visible = False
            Form1.Enabled = True
            Form1.Command6(0).Enabled = False
            
            Screen.MousePointer = 0
            Form1.Frame7.Enabled = True
            Form1.Picture23(1).Enabled = True
            Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
            Form1.Command25.Enabled = False
            Form1.Command25.ToolTipText = ""
            Form1.Combo1.Enabled = False
            OptionsFlag = 0
            Form1.ZOrder
        Else
            Form5.ZOrder
            Response = MsgBox("You need to have at least one reference sequence in at least two different reference groups", 48)
            Screen.MousePointer = 0
            Exit Sub
        End If
    Else
        Dim NSel As Integer, NumberOfSeqs As Long, Seqs() As String
        Form5.Command5.Enabled = True
        Command2.SetFocus
        
        
        Form1.Picture10.ScaleMode = 3
        Form1.Picture7.ScaleMode = 3
        Screen.MousePointer = 11
        OldAbort = 0
        NSel = 0
        
        
        
        
        If Combo1.ListIndex > 0 Then NSel = NSel + 1
    
        For x = 0 To NextNo
    
            If x <> Combo1.ListIndex - 1 And Selected(x) = 1 Then NSel = NSel + 1
        Next 'X
    
        If ManPFlag = 1 And Combo1.ListIndex < 1 Then
            
            Form5.ZOrder
            Response = MsgBox("Please select a potential recombinant sequence", 48)
            Screen.MousePointer = 0
            Exit Sub
        ElseIf NSel > ManMaxSeqNo Then
    
            If NSel - ManMaxSeqNo = 1 Then
                Response = MsgBox("This method can only be used with " + Trim$(CStr(ManMaxSeqNo)) + " sequences. Please unselect one sequence", 48)
            Else
                Response = MsgBox("This method can only be used with " + Trim$(CStr(ManMaxSeqNo)) + " sequences. Please unselect " + CStr(NSel - ManMaxSeqNo) + " sequences", 48)
            End If
    
            Screen.MousePointer = 0
            Exit Sub
        ElseIf NSel < ManMinSeqNo Then
    
            If ManMinSeqNo - NSel = 1 Then
                Response = MsgBox("Please select at least one additional sequence", 48)
            Else
                Response = MsgBox("Please select at least " + CStr(ManMinSeqNo - NSel) + " additional sequences", 48)
            End If
    
            Screen.MousePointer = 0
            Exit Sub
        Else
            
            
            If RefNum > 0 Then
                Dim RefCounter() As Long
                ReDim RefCounter(RefNum)
                For x = 0 To PermNextno
                    If Selected(x) = 1 Then
                        RefCounter(ReferenceList(x)) = RefCounter(ReferenceList(x)) + 1
                        If RefCounter(ReferenceList(x)) > 1 Then
                            Response = MsgBox("In some cases multiple sequences from an individual reference group have been selected as potential references/parents.  For each of these reference groups would you like me to use a consensus sequence as the potential parent/outgroup rather than using all of the individual sequences (which could otherwise yield confusing results)?", vbYesNo)
                            If Response = 6 Then
                                MakeConsFlag = 1
                                Dim BackUpSelected()
                                UB = UBound(Selected, 1)
                                ReDim BackUpSelected(UB)
                                For Z = 0 To UB
                                    BackUpSelected(Z) = Selected(Z)
                                    
                                Next Z
                                Dim FirstC() As Long, TempSeq() As Integer, TNum As Long, NucCount() As Long, ReplacementNum As Long, Replacements() As Long, ReplacementBak() As Long
                                ReDim FirstC(RefNum), TempSeq(Len(StrainSeq(0)), NextNo)
                                ReplacementNum = -1
                                ReDim Replacements(Len(StrainSeq(0)), RefNum), ReplacementBak(RefNum)
                                For Y = 1 To RefNum
                                    For Z = 0 To PermNextno
                                       If ReferenceList(Z) = Y And Selected(Z) = 1 Then
                                            FirstC(Y) = Z
                                            For b = 0 To Len(StrainSeq(0))
                                                TempSeq(b, 0) = SeqNum(b, Z)
                                            Next b
                                            Dim CG() As Long, CGNum()
                                            TNum = 0
                                            For A = Z + 1 To PermNextno
                                                If ReferenceList(A) = ReferenceList(Z) Then
                                                    Selected(A) = 0
                                                    TNum = TNum + 1
                                                    For b = 0 To Len(StrainSeq(0))
                                                        TempSeq(b, TNum) = SeqNum(b, A)
                                                    Next b
                                                End If
                                            Next A
                                            'make the consensus (in slot zero)
                                            If TNum > 0 Then
                                                For b = 0 To Len(StrainSeq(0))
                                                    ReDim NucCount(255)
                                                    For C = 0 To TNum
                                                        NucCount(TempSeq(b, C)) = NucCount(TempSeq(b, C)) + 1
                                                    Next C
                                                    If NucCount(0) = TNum + 1 Then
                                                        TempSeq(b, 0) = 0
                                                    ElseIf NucCount(0) + NucCount(46) = TNum + 1 Then
                                                        TempSeq(b, 0) = 46
                                                    ElseIf NucCount(66) >= NucCount(68) And NucCount(66) >= NucCount(72) And NucCount(66) >= NucCount(85) Then
                                                        TempSeq(b, 0) = 66
                                                    
                                                    ElseIf NucCount(68) >= NucCount(66) And NucCount(68) >= NucCount(72) And NucCount(68) >= NucCount(85) Then
                                                        TempSeq(b, 0) = 68
                                                    ElseIf NucCount(72) >= NucCount(68) And NucCount(72) >= NucCount(66) And NucCount(72) >= NucCount(85) Then
                                                        TempSeq(b, 0) = 72
                                                    ElseIf NucCount(85) >= NucCount(68) And NucCount(85) >= NucCount(72) And NucCount(85) >= NucCount(66) Then
                                                        TempSeq(b, 0) = 85
                                                    Else
                                                        TempSeq(b, 0) = 46
                                                    End If
                                                Next b
                                                ReplacementNum = ReplacementNum + 1
                                                ReplacementBak(ReplacementNum) = Z
                                                For b = 0 To Len(StrainSeq(0))
                                                    Replacements(b, ReplacementNum) = SeqNum(b, Z)
                                                    SeqNum(b, Z) = TempSeq(b, 0)
                                                Next b
                                            End If
                                            
                                       End If
                                    Next Z
                                Next Y
                            Else
                                MakeConsFlag = 0
                            End If
                            Exit For
                        End If
                    End If
                Next x
            
            End If
            
            
            If Form2.Visible = True Then
    
                For Z = 1 To 3
                    Form2.Picture2(Z).Visible = False
                Next 'Z
    
            End If
    
            Form3.Frame5.Caption = "Automated Bootscan"
            'Form3.Frame17.Visible = True
            Form3.Label1(13).Visible = True
            Form3.Command28(13).Visible = True
            
            Form5.Visible = False
            NoF3Check2 = 0
            Form1.Enabled = True
            
            If F2ontop = 0 Then
                Form1.ZOrder
            End If
            Form1.Refresh: If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            Form1.Picture10.Enabled = False
            Form1.Picture2.Picture = LoadPicture()
            Form1.SSPanel16.Caption = ""
            Form1.SSPanel16.BackColor = HalfColour
            Form1.SSPanel16.FontSize = 12
            Form1.SSPanel16.Font.Bold = True
            Form1.Command6(3).Enabled = False
            Form1.Command17.Enabled = False
            Form1.Frame17.Visible = False
            Form1.Frame7.Enabled = False
            Form1.Picture23(1).Enabled = False
            Form2.Picture2(1) = LoadPicture()
            Form2.Picture2(2) = LoadPicture()
            Form2.Picture2(3) = LoadPicture()
    
            If Form2.Visible = True Then
                Form2.WindowState = 1
            End If
    
            If TreeImage(0) = 1 Then
                
                Form1.Label14.Caption = "UPGMA ignoring recombination"
            Else
                Form1.Label14.Caption = ""
                Form1.Picture16.Picture = LoadPicture()
            End If
    
            If TManFlag = 1 Then
    
                Call GCManXOver
    
            ElseIf TManFlag = 3 Then
    
                If Check1.Value = 0 Then
                    TopDistFlag = 1
                Else
                    TopDistFlag = 0
                End If
    
                Form1.Frame7.Enabled = True
                Form1.Picture23(1).Enabled = True
                Form1.Command25.Enabled = True
                Form1.Command25.ToolTipText = "Stop the bootscan"
                Call BSXoverN
    
            ElseIf TManFlag = 4 Then
    
                Call MCXoverJ
            ElseIf TManFlag = 20 Then
                ReDim Seqs(NextNo)
                For x = 0 To NextNo
    
                    If Selected(x) = 1 Then
                        Seqs(NumberOfSeqs) = StrainSeq(x)
                        NumberOfSeqs = NumberOfSeqs + 1
                    End If
                    
                Next 'X
                NumberOfSeqs = NumberOfSeqs - 1
                ReDim Preserve Seqs(NumberOfSeqs)
                
                'This gets rid of gap only columns
                
                'For Y = 1 To Len(StrainSeq(0))
                '    For X = 0 To NumberOfSeqs
                '        If Mid$(Seqs(X), Y, 1) <> "-" Then Exit For
                '    Next X
                '    If X = NumberOfSeqs + 1 Then
                '        For X = 0 To NumberOfSeqs
                '            Mid$(Seqs(X), Y, 1) = "A"
                '        Next X
                '    End If
                'Next Y
                    
                
                
                Call VarRecRates(NumberOfSeqs, Seqs(), GCFlag, GCTractLen, BlockPen, StartRho, MCMCUpdates, FreqCo, FreqCoMD)
            ElseIf TManFlag = 5 Then
                tSeq1 = Seq1
                tSeq2 = Seq2
                tSeq3 = Seq3
    
                For x = 0 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq1 = x
                        Exit For
                    End If
    
                Next 'X
    
                For x = Seq1 + 1 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq2 = x
                        Exit For
                    End If
    
                Next 'X
    
                For x = Seq2 + 1 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq3 = x
                        Exit For
                    End If
    
                Next 'X
    
                ReDim RevSeq(2)
                RevSeq(0) = Seq1
                RevSeq(1) = Seq2
                RevSeq(2) = Seq3
                Screen.MousePointer = 11
                Form1.Frame7.Enabled = True
                Form1.Picture23(1).Enabled = True
                Form1.Command25.Enabled = True
                Form1.Command25.ToolTipText = "Stop the LARD scan"
                Call LXoverB(0, 1)
    
                If AbortFlag = 1 Then AbortFlag = 0
                Seq1 = tSeq1
                Seq2 = tSeq2
                Seq3 = tSeq3
            ElseIf TManFlag = 22 Then
                tSeq1 = Seq1
                tSeq2 = Seq2
                tSeq3 = Seq3
    
                For x = 0 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq1 = x
                        Exit For
                    End If
    
                Next 'X
    
                For x = Seq1 + 1 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq2 = x
                        Exit For
                    End If
    
                Next 'X
    
                Seq3 = Combo1.ListIndex - 1
    
                ReDim RevSeq(2)
                RevSeq(0) = Seq1
                RevSeq(1) = Seq2
                RevSeq(2) = Seq3
                Screen.MousePointer = 11
                Form1.Frame7.Enabled = True
                Form1.Picture23(1).Enabled = True
                Form1.Command25.Enabled = True
                Form1.Command25.ToolTipText = "Stop the 3SEQ scan"
                Call UnModNextno
                Call UnModSeqNum(0)
                ReDim MissingData(Len(StrainSeq(0)), NextNo)
                Call TSXOverB
    
                If AbortFlag = 1 Then AbortFlag = 0
                Seq1 = tSeq1
                Seq2 = tSeq2
                Seq3 = tSeq3
            ElseIf TManFlag = 7 Then
    
                Call DXoverF
    
            ElseIf TManFlag = 8 Then
                Form1.Frame7.Enabled = True
                Form1.Picture23(1).Enabled = True
                Form1.Command25.Enabled = True
                Form1.Command25.ToolTipText = "Stop the 3SEQ scan"
                Call TXover3
    
                If AbortFlag = 1 Then AbortFlag = 0
            ElseIf TManFlag = 9 Then
                
                For x = 0 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq1 = x
                        Exit For
                    End If
    
                Next 'X
    
                For x = Seq1 + 1 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq2 = x
                        Exit For
                    End If
    
                Next 'X
    
                For x = Seq2 + 1 To NextNo
    
                    If Selected(x) = 1 Then
                        Seq3 = x
                        Exit For
                    End If
    
                Next 'X
                oolf = SSOutlyerFlag
                If Combo1.ListIndex > 0 Then
                    SSOutlyerFlag = 3
                    ManSSOLSeq = Combo1.ListIndex - 1
                Else
                    SSOutlyerFlag = 0
                End If
                Call SSXoverB(0)
                SSOutlyerFlag = oolf
            ElseIf TManFlag = 10 Then
                Call PXover
            End If
    
            Form1.Picture10.Enabled = True
            
            
            If ReplacementNum > 0 Then
                For x = 0 To ReplacementNum
                    Z = ReplacementBak(x)
                    For b = 0 To Len(StrainSeq(0))
                        SeqNum(b, Z) = Replacements(b, x)
                       
                    Next b
                Next x
            
            End If
            
        End If
    
        If OldAbort = 0 And AbortFlag = 0 Then
            ManFlag = TManFlag
    
            Call DoLegend
    
            ShowSeqFlag = 0
            Form1.HScroll1.SmallChange = 1
            Form1.Picture3.Enabled = True
            Form1.Label21 = "Show All Sequences"
            Form1.Picture3.AutoRedraw = True
            Form1.Picture3.Picture = LoadPicture()
            Form1.Picture3.CurrentX = 0
            Form1.Picture3.CurrentY = 0
            Form1.Command6(0).Enabled = False
            TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
            Call PrintNames
            
    
            If Form1.HScroll1.Value <> Form1.HScroll1.Min Then
                Form1.HScroll1.Value = Form1.HScroll1.Min
            Else
                If Form1.HScroll1.Min < Form1.HScroll1.Max Then
                    Form1.HScroll1.Value = Form1.HScroll1.Min + 1
                Else
                    Form1.HScroll1.Min = Form1.HScroll1.Max
                End If
            End If
    
        Else
            AbortFlag = 0
            OldAbort = 0
            TManFlag = -1
            ManFlag = -1
            Form1.ProgressBar1.Value = 0
            Screen.MousePointer = 0
            Form1.SSPanel1.Caption = ""
            Call UpdateF2Prog
        End If
    End If
    Form1.Command6(0).Enabled = False
    
    Screen.MousePointer = 0
    Form1.Frame7.Enabled = True
    Form1.Picture23(1).Enabled = True
     Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
    Form1.Command25.Enabled = False
    Form1.Command25.ToolTipText = ""
    Form1.Combo1.Enabled = False
    Form5.Command5.Caption = "Options"
    OptionsFlag = 0
End Sub

Private Sub Command4_Click()
    
    Command2.SetFocus
    
    
    If QvRSelectFlag = 1 Then
        QvRSelectFlag = 0
        QvRScanGoonFlag = 0
        Command5.Enabled = True
        
        For x = 0 To PermNextno
            MaskSeq(x) = TempMaskseq(x)
            
        Next x
            
    Else
        ManFlag = OManFlag
    
        If Combo1.Visible = True Then
            Combo1.ListIndex = OIndex
        End If
    End If
    OptionsFlag = 0
    Form5.Visible = False
    NoF3Check2 = 0
    Form1.Enabled = True
    Form3.Frame5.Caption = "Automated Bootscan"
    'Form3.Frame17.Visible = True
    Form3.Label1(13).Visible = True
    Form3.Command28(13).Visible = True
    Form5.Command5.Enabled = True
    Form5.Command5.Caption = "Options"
    If F2ontop = 0 Then
        Form1.ZOrder
    End If
    Form1.Refresh
End Sub

Private Sub Command5_Click()
    
    Command2.SetFocus
    
    If QvRSelectFlag = 1 Then
        Call CheckQueryReference
        Call UpdateSelectRefs
        Call PrintNames
    Else
        Dim VisFrame As Integer
    
        Form3.TabStrip1.Visible = False
        
        If TManFlag = 0 Then
            VisFrame = 1
            Form3.TabStrip2.Tabs(1).Caption = "RDP Options"
        ElseIf TManFlag = 20 Then
            VisFrame = 13
            Form3.TabStrip2.Tabs(1).Caption = "LDHAT Options"
        ElseIf TManFlag = 1 Then
            VisFrame = 2
            Form3.TabStrip2.Tabs(1).Caption = "GENECONV Options"
        ElseIf TManFlag = 3 Or TManFlag = 2 Then
            VisFrame = 3
            Form3.Frame5.Caption = "Manual Bootscan"
            Form3.Frame17.Visible = False
            Form3.TabStrip2.Tabs(1).Caption = "Bootscan Options"
        ElseIf TManFlag = 4 Then
            Form3.Label1(13).Visible = False
            Form3.Command28(13).Visible = False
            
            'Form3.Frame23.Height = Form3.Frame23.Height + 400
            VisFrame = 4
            Form3.TabStrip2.Tabs(1).Caption = "MaxChi Options"
        ElseIf TManFlag = 5 Then
            VisFrame = 7
            Form3.TabStrip2.Tabs(1).Caption = "LARD Options"
        ElseIf TManFlag = 6 Then
            VisFrame = 8
            Form3.TabStrip2.Tabs(1).Caption = "Reticulate Options"
        ElseIf TManFlag = 7 Then
            VisFrame = 9
            Form3.TabStrip2.Tabs(1).Caption = "Distance Plot Options"
        ElseIf TManFlag = 8 Then
            VisFrame = 10
            Form3.TabStrip2.Tabs(1).Caption = "TOPAL Options"
        ElseIf TManFlag = 9 Then
            VisFrame = 6
            Form3.TabStrip2.Tabs(1).Caption = "SiScan Options"
        End If
    
        For x = 0 To 13
    
            If x = VisFrame Then
                Form3.Frame2(x).Visible = True
            Else
                Form3.Frame2(x).Visible = False
            End If
    
        Next 'X
        
        OptionsFlag = 1
    
        Call SetF3Vals(0)
        Form3.Visible = True
        Form3.Command1.SetFocus
    End If
    
End Sub

Private Sub Command6_Click()
    Command2.SetFocus
    If QvRSelectFlag = 1 Then
        'If QvRShowOnlyFlag = 1 Then
            For x = 0 To PermNextno
                If ReferenceList(x) = Form5.Combo1.ListIndex Then
                    ReferenceList(x) = 0
                End If
            Next x
            Call PrintNames
        'Else
'            For X = 0 To PermNextno
'                If ReferenceList(X) <> Form5.Combo1.ListIndex Then
'                    ReferenceList(X) = Form5.Combo1.ListIndex
'                End If
'            Next X
'        End If
    Else
        For x = 0 To NextNo
            Selected(x) = 0
        Next 'X
    End If
    TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    Form5.Picture1.Height = (NextNo + 2) * Screen.TwipsPerPixelY * TextHi

    Call DoSelectInterface

End Sub

Private Sub Form_Load()
    Form5.Width = 9000 'Screen.Width * 0.75
    Form5.Height = 6000 'Screen.Height * 0.75
    'Heading label
    Label4.Width = Form5.ScaleWidth - 200
    Label4.Left = 100
    Label4.Height = 630
    SSPanel1.Top = 800
    SSPanel1.Width = Form5.ScaleWidth - 200
    SSPanel1.Left = 100
    SSPanel1.Height = Form5.Height - 800 - 1000
    Label1.Left = 100
    Label1.Top = 130
    'Combo1.Left = 3000
    Combo1.Top = 100
    'Unselected outer picture box
    Picture3.Left = 100
    Picture3.Top = 1000
    Picture3.Width = ((SSPanel1.Width - 700) / 6) * 2.5
    Picture3.Height = SSPanel1.Height - 1200
    'Uselected label
    Label2.Top = 600
    Label2.Left = Picture3.Left
    Label2.Width = Picture3.Width
    Label2.Height = 500
    'Unselected inner picture box
    Picture1.Left = 0
    Picture1.Top = 0
    'Picture1.Width = Picture3.Width
    Picture1.Height = 2500
    'Unselected scrollbar
    VScroll1.Left = Picture3.Left + Picture3.Width + 50
    VScroll1.Top = Picture3.Top
    VScroll1.Height = Picture3.Height
    VScroll1.Width = 200
    'Selected outer picture box
    Picture4.Left = Picture3.Width + Picture3.Left + 250 + (SSPanel1.Width - 700) / 6
    Picture4.Top = Picture3.Top
    Picture4.Width = Picture3.Width
    Picture4.Height = Picture3.Height
    'Selected label
    Label3.Top = 600
    Label3.Left = Picture4.Left
    Label3.Width = Picture4.Width
    Label3.Height = 500
    'Selected inner picture box
    Picture2.Left = 0
    Picture2.Top = 0
    Picture2.Width = Picture3.Width
    Picture2.Height = 2500
    'Selected scrollbar
    VScroll2.Left = Picture4.Left + Picture4.Width + 50
    VScroll2.Top = Picture3.Top
    VScroll2.Height = Picture3.Height
    VScroll2.Width = 200
    Command1.Width = 1200
    Command1.Height = 350
    'Command1.Left = (Picture1.Left + Picture1.Width + 50 + VScroll1.Width + 50) + (Picture4.Left - (Picture1.Left + Picture1.Width + 50 + VScroll1.Width) - Command1.Width) / 2
    Command1.Left = VScroll1.Left + VScroll1.Width + 50 ' + (Picture4.Left - (Picture1.Left + Picture1.Width + 50 + VScroll1.Width) - Command1.Width) / 2

    Command1.Top = Picture3.Top + Picture3.Height / 2 - 400
    Command6.Top = Command1.Top + 700
    Command6.Left = Command1.Left
    Command6.Width = Command1.Width
    Command6.Height = Command1.Height
    
    Form5.Check1.Value = 0
    Command3.Top = SSPanel1.Top + SSPanel1.Height + 100
    Command3.Height = Command1.Height
    Command3.Width = Command1.Width
    Command3.Left = SSPanel1.Left + Command1.Left - (Command1.Width * 1.5) / 1.45 '(Form5.ScaleWidth - Command3.Width * 2.5) / 2
    Command5.Top = Command3.Top
    Command5.Height = Command1.Height
    Command5.Width = Command1.Width
    Command5.Left = SSPanel1.Left + Command1.Left '(Form5.ScaleWidth - Command3.Width * 2.5) / 2
    Command4.Top = Command3.Top
    Command4.Height = Command1.Height
    Command4.Width = Command1.Width
    Command4.Left = SSPanel1.Left + Command1.Left + (Command1.Width * 1.5) / 1.45 '(Form5.ScaleWidth - Command3.Width * 2.5) / 2
    Combo1.Left = Command3.Left
    Combo1.Width = (Command4.Left + Command4.Width) - Command3.Left 'Command1.Width
    Check1.Left = Combo1.Left + Combo1.Width + 300
    Check1.Top = Label1.Top
    
    'Command2.SetFocus
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = True
End Sub

Private Sub Inet1_StateChanged(ByVal State As Integer)

If State = 1 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Looking up the IP address for the remote server"
ElseIf State = 2 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Found the IP address for the remote server"
ElseIf State = 3 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Connecting to the remote server"
ElseIf State = 4 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Connected to the remote server"
ElseIf State = 5 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Requesting information from the remote server"
ElseIf State = 6 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":The request was sent successfully to the remote server"
ElseIf State = 7 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Receiving a response from the remote server"
ElseIf State = 8 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":The response was received successfully from the remote server"
ElseIf State = 9 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Disconnecting from the remote server"
ElseIf State = 10 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":Disconnected from the remote server"
ElseIf State = 11 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":An error was detected when communicating with the remote computer"
ElseIf State = 12 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep) + ":The request was completed; all data has been received"
End If

Inet1State = State
If State = 12 Then
    If GenBankFetchStep <> 7 Then
        Call Timer1_Timer
    End If
End If
End Sub

Private Sub Inet2_StateChanged(ByVal State As Integer)

 If State = 1 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Looking up the IP address for the remote server"
ElseIf State = 2 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Found the IP address for the remote server"
ElseIf State = 3 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Connecting to the remote server"
ElseIf State = 4 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Connected to the remote server"
ElseIf State = 5 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Requesting information from the remote server"
ElseIf State = 6 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":The request was sent successfully to the remote server"
ElseIf State = 7 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Receiving a response from the remote server"
ElseIf State = 8 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":The response was received successfully from the remote server"
ElseIf State = 9 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Disconnecting from the remote server"
ElseIf State = 10 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":Disconnected from the remote server"
ElseIf State = 11 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":An error was detected when communicating with the remote computer"
    Timer2.Interval = 3000
ElseIf State = 12 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep2) + ":The request was completed; all data has been received"
End If

Inet1State = State
If State = 12 Then
    'If GenBankFetchStep2 <> 7 Then
        Call Timer2_Timer
    'End If
End If


End Sub

Private Sub Inet3_StateChanged(ByVal State As Integer)
If State = 1 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Looking up the IP address for the remote server"
ElseIf State = 2 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Found the IP address for the remote server"
ElseIf State = 3 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Connecting to the remote server"
ElseIf State = 4 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Connected to the remote server"
ElseIf State = 5 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Requesting information from the remote server"
ElseIf State = 6 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":The request was sent successfully to the remote server"
ElseIf State = 7 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Receiving a response from the remote server"
ElseIf State = 8 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":The response was received successfully from the remote server"
ElseIf State = 9 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Disconnecting from the remote server"
ElseIf State = 10 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":Disconnected from the remote server"
ElseIf State = 11 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":An error was detected when communicating with the remote computer"
    Timer3.Interval = 3000
ElseIf State = 12 Then
    Form1.SSPanel1.Caption = Str(GenBankFetchStep3) + ":The request was completed; all data has been received"
End If

Inet1State = State
If State = 12 Then
    'If GenBankFetchStep3 <> 7 Then
        Call Timer3_Timer
    'End If
End If
End Sub

Private Sub Label2_Click()
If QvRSelectFlag = 1 Then
    If QvRShowOnlyFlag = 1 Then
        QvRShowOnlyMnu.Caption = "Show all sequences that are not in reference group " + Trim(Str(Form5.Combo1.ListIndex))
    Else
        
        QvRShowOnlyMnu.Caption = "Show only sequences that are not in any of the reference groups"
    End If
    Call QvRShowOnlyMnu_Click
End If
End Sub

Private Sub Label2_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
If QvRSelectFlag = 1 Then
    Label2.ToolTipText = "Click to change which sequences are displayed"
    Label2.MouseIcon = Form1.Command1.MouseIcon
    Label2.MousePointer = 99
End If
End Sub

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Dim Spos As Integer, Z As Long, Xpos As Long, YPos As Long
    
    Xpos = x
    YPos = Y

    Y = Y / Screen.TwipsPerPixelY
    TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    Spos = Int(Y / TextHi)
    
    If Spos <= NextNo Then
        If Button = 1 Then
            If QvRSelectFlag = 1 Then
                If Form5.Combo1.ListIndex <> ReferenceList(UYPos(Spos)) Then
                    QvRFlag = 1
                    ReferenceList(UYPos(Spos)) = Form5.Combo1.ListIndex
                    VRFlag = 0
                    Dim OLI As Long
                    OLI = Form5.Combo1.ListIndex
                    RefNum = 0
                    For x = 0 To PermNextno
                        If RefNum < ReferenceList(x) Then RefNum = ReferenceList(x)
                    Next x
                    Call UpdateSelectRefs
                    Form5.Combo1.ListIndex = OLI
                    
                    Call UpdateRefCols
                    Call PrintNames
                    RedoRefNamesFlag = 1
                End If
            Else
                If Shift = 0 Or TManFlag <> 7 Then
                    
                    If TManFlag = 7 Then
                        CSelect = 0
                        ReDim DSeqs(NextNo)
                    End If
                    If UYPos(Spos) <> -1 Then
                        Selected(UYPos(Spos)) = 1
                        VRFlag = 0
                    End If
            
                    Call DoSelectInterface
                Else
                    If DSeqs(UYPos(Spos)) = 0 Then
                        'Picture1.AutoRedraw = False
                        DSeqs(UYPos(Spos)) = 1
                        SelectGroups(CSelect) = UYPos(Spos)
                        CSelect = CSelect + 1
                        Picture1.Line (0, (Spos * TextHi) * Screen.TwipsPerPixelY)-(Picture1.Width, (Spos * TextHi + TextHi) * Screen.TwipsPerPixelY), &H8000000D, BF
                        Picture1.DrawMode = 6
                        Picture1.CurrentX = 0
                        Picture1.CurrentY = (Spos * TextHi) * Screen.TwipsPerPixelY
                        Picture1.Print OriginalName(UYPos(Spos))
                        Picture1.DrawMode = 13
                        'Picture1.AutoRedraw = True
                        '&H8000000D&
                    Else
                        DSeqs(UYPos(Spos)) = 0
                        For Z = 0 To CSelect - 1
                            If SelectGroups(Z) = UYPos(Spos) Then
                                If Z = CSelect - 1 Then
                                    CSelect = CSelect - 1
                                Else
                                    SelectGroups(Z) = SelectGroups(CSelect - 1)
                                    CSelect = CSelect - 1
                                End If
                                Exit For
                            End If
                        Next Z
                        
                        Picture1.Line (0, (Spos * TextHi) * Screen.TwipsPerPixelY)-(Picture1.Width, (Spos * TextHi + TextHi) * Screen.TwipsPerPixelY), Picture1.BackColor, BF
                        'Picture1.DrawMode = 6
                        Picture1.CurrentX = 0
                        Picture1.CurrentY = (Spos * TextHi) * Screen.TwipsPerPixelY
                        Picture1.Print OriginalName(UYPos(Spos))
                        'Picture1.DrawMode = 13
                    End If
                End If
            End If
        Else
            If CSelect > 0 Then
                KomMnu.Caption = "Group with " & OriginalName(SelectGroups(0))
                Form5.PopupMenu GroupMnu
            End If
            If QvRSelectFlag = 1 Then
                If QvRShowOnlyFlag = 1 Then
                    QvRShowOnlyMnu.Caption = "Show all sequences that are not in reference group " + Trim(Str(Form5.Combo1.ListIndex))
                Else
                    
                    QvRShowOnlyMnu.Caption = "Show only sequences that are not in any of the reference groups"
                End If
                Form5.PopupMenu ChangListMnu ', 0, XPos, YPos
                'Form5.ChangListMnu.Visible = True
            End If
        End If
    End If

End Sub

Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Form5.ChangListMnu.Visible = True Then Exit Sub
    Dim Spos As Integer
    Dim TextHi As Double

    TextHi = Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    Picture1.Refresh
    Picture1.AutoRedraw = False
    'Y = (Y / Screen.TwipsPerPixelY)
    Picture1.ForeColor = RGB(255, 0, 0)
    Spos = Int((Y / Screen.TwipsPerPixelY) / TextHi)

    If Spos <= NextNo And Spos >= 0 Then

        If UYPos(Spos) <> -1 Then
            P = Picture1.TextHeight(OriginalName(UYPos(Spos))) / Screen.TwipsPerPixelY
            Picture1.CurrentY = Spos * Screen.TwipsPerPixelY * Picture1.TextHeight(OriginalName(UYPos(Spos))) / Screen.TwipsPerPixelY
            Picture1.Print OriginalName(UYPos(Spos))
            Picture1.MousePointer = 99
        Else
            Picture1.MousePointer = 0
        End If

    End If

    Picture1.ForeColor = RGB(0, 0, 0)
    Picture1.AutoRedraw = True
End Sub

Private Sub Picture2_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Dim Spos As Integer

    Y = Y / Screen.TwipsPerPixelY
    TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    Spos = Int(Y / TextHi)
    'SPos = SPos - 1

    If Spos <= NextNo And Spos >= 0 Then
        If Button = 1 Then
            If QvRSelectFlag = 1 Then
                'If Form5.Combo1.ListIndex <> ReferenceList(UYPos(SPos)) Then
                    ReferenceList(SYPos(Spos)) = 0
                    VRFlag = 0
                    Dim OLI As Long
                    OLI = Form5.Combo1.ListIndex
                    RefNum = 0
                    For x = 0 To PermNextno
                        If RefNum < ReferenceList(x) Then RefNum = ReferenceList(x)
                    Next x
                    'Call UpdateSelectRefs
                    Call DoSelectInterface
                    Form5.Combo1.ListIndex = OLI
                    RedoRefNamesFlag = 1
                    Call UpdateRefCols
                    Call PrintNames
                'End If
            Else
                If SYPos(Spos) <> -1 Then
                    Selected(SYPos(Spos)) = 0
                    VRFlag = 0
                End If
    
                Call DoSelectInterface
            End If
        End If
    End If

End Sub

Private Sub Picture2_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)

    Dim Spos As Integer

    Picture2.Refresh
    Picture2.AutoRedraw = False
    'Y = (Y / Screen.TwipsPerPixelY)
    Picture2.ForeColor = RGB(255, 0, 0)
    TextHi = Form5.Picture1.TextHeight(OriginalName(0)) / Screen.TwipsPerPixelY
    Spos = Int((Y / Screen.TwipsPerPixelY) / TextHi)

    If Spos < NextNo And Spos >= 0 Then

        If SYPos(Spos) <> -1 Then
            Picture2.MousePointer = 99
            Picture2.CurrentY = Spos * Screen.TwipsPerPixelY * TextHi
            Picture2.Print OriginalName(SYPos(Spos))
        Else
            Picture2.MousePointer = 0
        End If

    Else
    End If

    Picture2.ForeColor = RGB(0, 0, 0)
    Picture2.AutoRedraw = True
End Sub

Private Sub QvRShowOnlyMnu_Click()
    QvRShowOnlyFlag = QvRShowOnlyFlag + 1
    If QvRShowOnlyFlag > 1 Then
        QvRShowOnlyMnu.Caption = "Show only sequences that are not in any reference group"
        QvRShowOnlyFlag = 0
    Else
        QvRShowOnlyMnu.Caption = "Show all sequences that are not in reference group " + Trim(Str(Form5.Combo1.ListIndex))
    End If
    Call DoSelectInterface
End Sub

Private Sub SSPanel1_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
Picture1.Refresh
Picture2.Refresh
End Sub

Private Sub Timer1_Timer()
'    Exit Sub
'    If DoingShellFlag > 0 Then Exit Sub
'    If CurrentlyRunningFlag = 1 Then Exit Sub
'    If SchemDownFlag = 1 Then Exit Sub
'    If F5T1Executing = 1 Then Exit Sub
'    F5T1Executing = 1
'   ' Exit Sub
'    Dim ServerBFlag As Long, ServerS As String
'    Dim ServerB As String, NumGBs As Long, AddName As String, URLS As String, SearchS As String, WebString As String, Pos1 As Long, Pos2 As Long, RTOE As String, Target As String, LenRange As String
'    Dim ChunkS As String, TestS As String
'    If Form5.Inet1.StillExecuting = True Then
'        F5T1Executing = 0
'        Exit Sub
'    ElseIf GenBankFetchStep = 1000 Then
'        Form5.Timer1.Enabled = False
'    End If
'    Form5.Inet1.AccessType = icUseDefault
'    If GenBankFetchStep = 0 Then
'        GenBankFetchStep = 3
'    End If
'
'
'    ServerBFlag = 1
'
'    ServerS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?"
'    ServerB = "http://bio.chpc.ac.za/blast/blast.cgi?"
'    'alternative servers
'    'ServerS = "http://bio.chpc.ac.za/blast/blast_cs.cgi?"
'    'ServerS = "https://137.158.204.6/blast/blast.cgi?" 'ebiokit-01.cbio.uct.ac.za
'    'ServerS = "http://129.85.245.250/Blast_cs.cgi?"
'    If GenBankFetchStep = 0 Then
'
'        'First flush all previous RIDs
'        If RID <> "" Then
'            Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'            RID = ""
'            GenBankFetchStep = 0
'       Else
'            Form5.Inet1.Execute (ServerS + "CMD=DisplayRIDs")
'            GenBankFetchStep = 3
'       End If
''        ChunkS = String(1024, " ")
''        TestS = ChunkS
''        ChunkS = Form5.Inet1.GetChunk(1024, icString)
''        WebString = ""
''        WebString = WebString + ChunkS
''        If ChunkS <> TestS And Len(ChunkS) > 0 Then
''            Do While Len(ChunkS) > 0
''                ChunkS = TestS
''                ChunkS = Form5.Inet1.GetChunk(1024, icString)
''                WebString = WebString + ChunkS
''            Loop
''
''        End If
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
''        X = X
'    ElseIf GenBankFetchStep = 1 Then
'        If Form5.Inet1.StillExecuting = False Then
'            GenBankFetchStep = 2
'        End If
''    ElseIf GenBankFetchStep = 2 Then
''        ChunkS = String(1024, " ")
''        TestS = ChunkS
''        ChunkS = Form5.Inet1.GetChunk(1024, icString)
''        WebString = ""
''        WebString = WebString + ChunkS
''        If ChunkS <> TestS And Len(ChunkS) > 0 Then
''            Do While Len(ChunkS) > 0
''                ChunkS = TestS
''                ChunkS = Form5.Inet1.GetChunk(1024, icString)
''                WebString = WebString + ChunkS
''            Loop
''
''        End If
'''        Open "output.html" For Output As #1
'''        Print #1, WebString
'''        Close #1
''        X = X
''        GenBankFetchStep = 3
'    ElseIf GenBankFetchStep = 3 Then
'        'SearchS = Left(StrainSeq(0), 200)
'        Dim MaxQL As Long
'        If ReassortmentFlag = 0 Then
'            If ORFRefNum > 5 Then ORFRefNum = 5
'            SearchS = String(200 * (ORFRefNum + 1), " ")
'        Else
'            ORFRefNum = RBPNum - 1
'            MaxQL = 1400 / (RBPNum)
'            SearchS = String(MaxQL * (ORFRefNum + 1), " ")
'        End If
'        Y = 0
'
'        'find most conserved 100nts
'
'        Dim MaxBkg As Single, MaxBkgPos As Long, PosXWin As Long
'
''        MaxBkg = -100
''        For X = 1 To Len(StrainSeq(0))
''            If BkgIdentity(X) > MaxBkg Then
''                MaxBkg = BkgIdentity(X)
''                MaxBkgPos = X
''            End If
''        Next X
''
''        MaxBkgPos = MaxBkgPos - 100
''        If MaxBkgPos < 1 Then MaxBkgPos = 1
''
''        If LSeq > 100 Then
''            If MaxBkgPos + 100 > LSeq Then
''                MaxBkgPos = LSeq - 100
''            End If
''
''        End If
'
'        'Mid$(SearchS, 1, 3) = ">A" + Chr(10)
'        MaxBkgPos = 1
'        Dim ReadSize As Long
'        If ReassortmentFlag = 0 Then
'            If Len(StrainSeq(0)) > (ORFRefNum + 1) * 200 Then
'                ReadSize = 200
'            Else
'                ReadSize = CLng(Len(StrainSeq(0)) / (ORFRefNum + 1))
'            End If
'            For Z = 0 To ORFRefNum
'                For X = MaxBkgPos To Len(StrainSeq(0))
'                    If Mid(StrainSeq(ORFRefList(Z)), X, 1) <> "-" Then '576,0,767,787,26
'                        Y = Y + 1
'                        Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(Z)), X, 1)
'                        If Y = 200 * (Z + 1) Then
'                            MaxBkgPos = MaxBkgPos + 200
'                            Exit For
'                        End If
'                    End If
'                Next X
'            Next Z
'        Else
'            For Z = 1 To RBPNum
'                'XX = UBound(RBPPos, 1)
'                For X = RBPPos(Z) To RBPPos(Z + 1)
'                    If Mid(StrainSeq(ORFRefList(0)), X, 1) <> "-" Then '576,0,767,787,26
'                        Y = Y + 1
'                        Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(0)), X, 1)
'                        If Y = MaxQL * (Z + 1) Then
'                            MaxBkgPos = MaxBkgPos + 200
'                            Exit For
'                        End If
'                    End If
'                Next X
'            Next Z
'        End If
'        'XX = Mid$(SearchS, 395, 20)
'        SearchS = Trim(SearchS) ': XX = Len(SearchS)
'        '1000:2000[slen]
'        'find the umber of gaps
'        Dim NumGaps As Long
'        NumGaps = 0
'        For X = 0 To Len(StrainSeq(0))
'            If SeqNum(X, 0) = 46 Then NumGaps = NumGaps + 1
'        Next X
'        'XX = Len(SearchS)
'        LenRange = "&ENTREZ_QUERY="
'        If ReassortmentFlag = 0 Then
'
'            LenRange = LenRange + Trim(Str(CLng((Len(StrainSeq(0)) - NumGaps) * 0.9))) + ":100000[slen]"
'
'
'            LenRange = LenRange + " AND txid10239[ORGN]"
'        Else
'            LenRange = LenRange + "txid10239[ORGN]"
'        End If
'
'        'LenRange = "srcdb_refseq[prop] "
'        'This is the best one yet
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'        'This is the next best one
'        'LenRange = LenRange + "txid10239[ORGN]"
'       ' URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=txid10239[ORGN]&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without length restrict: 43844, fail, 54047, fail
'        X = X
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without taxon restrict: 43187,995436, 434000, 150781, 250797
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without taxon or length restrict: 644984, 368891
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'Best time = 64781, 184938, 132203, 66968, 28812, 49329, 175688, 23094, 23531, 33688
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00000001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'Best time = 197500, 31156
'        If ReassortmentFlag = 0 Then
'            URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        Else
'            URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        End If
'        '(megablast) Best time = 19953(EXPECT=0.00000001), 19797, 21500(EXPECT=0.01)
'        '47406
'
'        'CHPC seqrch
''        URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=Representative_Genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
''
''
'
''        XX = CurDir
''
''        Open "testurl.txt" For Output As #1
''            Print #1, URLS
''        Close #1
'        'URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=EU628620.1&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'
'
'        'Normal blast
'
'
''        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
'X = X
''        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
'
'        'alternative servers
'
'
'
'
'        Open "url.txt" For Output As #1
'        Print #1, URLS
'        Close #1
'        XX = CurDir
'        Form5.Inet1.UserName = "darrenpatrickmartin@gmail.com"
'        Form5.Inet1.Execute URLS ', "GET"
'
'        GenBankFetchStep = 5
'     ElseIf GenBankFetchStep = 4 Then
'        If Form5.Inet1.StillExecuting = False Then
'            GenBankFetchStep = 5
'        End If
'     ElseIf GenBankFetchStep = 5 Then
'
'
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        WebString = ""
'        'On Error GoTo 0
'        WebString = WebString + ChunkS
'        If ChunkS = String(1024, " ") Or ChunkS = "" Then
'            GenBankFetchStep = 3
'        Else
'
'        'XX = Form5.Inet1.ResponseInfo
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    'If DebuggingFlag < 2 Then On Error Resume Next
'                    ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                    'On Error GoTo 0
'                    WebString = WebString + ChunkS
'                    If GenBankFetchStep = 1000 Then
'
'                        Form5.Timer1.Enabled = False
'                        Exit Sub
'                    End If
'                Loop
'
'            End If
''            Open "output.html" For Output As #1
''            Print #1, WebString
''            Close #1
'    'XX = CurDir
'            Pos1 = InStr(1, WebString, "RID", vbTextCompare)
'
'            If Pos1 > 0 Then
'                If RID <> "" Then
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                RID = Trim(Mid(WebString, Pos1 + 6, 11))
'                If Left(RID, 9) <> "equest ID" Then
''                    Open "outputurl.txt" For Output As #1
''                    Print #1, ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get"
''                    Close #1
'
'                    On Error Resume Next
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
'                    On Error GoTo 0
'                    GenBankFetchStep = 7
'                Else
'
''                    Open "output.html" For Output As #1
''                    Print #1, WebString
''                    Close #1
'                    RID = ""
'                    If RID <> "" Then
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                    GenBankFetchStep = 3
'                End If
'            Else
'                If RID <> "" Then
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                GenBankFetchStep = 3
'            End If
'        End If
'    ElseIf GenBankFetchStep = 6 Then
'        If Form5.Inet1.StillExecuting = False Then
'            GenBankFetchStep = 7
'        End If
'    ElseIf GenBankFetchStep = 7 Then
'
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        'On Error GoTo 0
'        If ChunkS = "" Then
'            Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
'            GenBankFetchStep = 7
'        Else
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'                If GenBankFetchStep = 1000 Then
'
'                    Form5.Timer1.Enabled = False
'                    Exit Sub
'                End If
'            Loop
'
'        End If
'
'        Pos1 = 0
'        Pos1 = InStr(1, WebString, "ALIGNMENTS", vbBinaryCompare)
'        'Pos1 = InStr(1, WebString, "READY", vbBinaryCompare)
''        XX = CurDir
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
'        If Pos1 = 0 Then
'
'
'            'XX = CurDir
''            Open "output.html" For Output As #1
''            Print #1, WebString
''            Close #1
'            Pos1 = InStr(1, WebString, "Error: Results for RID", vbBinaryCompare)
'            If Pos1 > 0 Then
'                GenBankFetchStep = 3
'                Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                RID = ""
'                Timer1.Interval = 100
'            Else
'                'GenBankFetchStep = 0
'                Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
'
'                'Sleep 2000
'                GenBankFetchStep = 7
'                Timer1.Interval = Timer1.Interval * 2
'            End If
'            If Timer1.Interval > 5000 Then
'                Timer1.Interval = 5000
'            End If
'        Else
'                GenBankFetchStep2 = 1000
'                GenBankFetchStep3 = 1000
'                Form5.Timer2.Enabled = False
'                Form5.Timer3.Enabled = False
'                'get list of accession numbers
''                Open "output.html" For Output As #1
''                Print #1, WebString
''                Close #1
'
'                Pos2 = InStr(Pos1 + 3, WebString, ">", vbBinaryCompare)
'                If Pos2 = 0 Then
''                    GenBankFetchStep = 1000
''                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                    RID = ""
'                    DoEvents
'                    Sleep 200
'                    F5T1Executing = 0
'                    Call Timer1_Timer 'GenBankFetchStep2 = 1000
'                    Exit Sub
'                Else
'                    SearchS = ""
'                    NumGBs = 0
'                    If ReassortmentFlag = 0 Then
'                        Do While Pos2 > 0
'                            Pos1 = InStr(Pos2 + 3, WebString, " ", vbBinaryCompare)
'                            If Pos1 = 0 Then
'                                DoEvents
'                                Sleep 200
'                                F5T1Executing = 0
'                                Call Timer1_Timer 'GenBankFetchStep2 = 1000
'                                Exit Sub
'                            Else
'                                AddName = Mid$(WebString, Pos2 + 1, Pos1 - Pos2 - 1)
'                                Pos = InStr(4, AddName, "|", vbBinaryCompare)
'                                If Pos > 0 Then
'                                    AddName = Right(AddName, Len(AddName) - Pos)
'                                End If
'                                If Left(AddName, 4) = "ref|" Then
'                                    AddName = Mid$(AddName, 5, Len(AddName))
'                                End If
'
'                                If Right(AddName, 1) = "|" Then
'                                    AddName = Mid$(AddName, 1, Len(AddName) - 1)
'                                End If
'                                If SearchS = "" Then
'                                    SearchS = AddName
'                                    NumGBs = 1
'                                    X = X
'                                Else
'                                    SearchS = SearchS + "," + AddName
'                                    NumGBs = NumGBs + 1
'                                    X = X
'                                End If
'
'
'                            End If
'                            Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
'                            If Pos2 = 0 Then
'                                Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
'                            End If
'                        Loop
'                        URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
'                        RefetchGB = URLS
'
'                        XX = App.Path
'                        Open "testURL.txt" For Output As #1
'                        Print #1, URLS
'                        Close #1
'
'                        Form5.Inet1.Execute URLS, "GET"
'                        Form5.Timer1.Interval = 100
'                        GenBankFetchStep = 9
'                    Else
'                        'find the virus name
'                        Pos1 = InStr(1, WebString, ">NC_", vbBinaryCompare)
'                        If Pos1 > 0 Then
'                            Pos2 = InStr(Pos1 + 1, WebString, " ", vbBinaryCompare)
'                            If Pos2 > 0 Then
'                                Pos1 = InStr(Pos2 + 1, WebString, "virus", vbTextCompare)
'                                If Pos1 = 0 Then
'                                    Pos1 = InStr(Pos2 + 1, WebString, "phage", vbTextCompare)
'                                End If
'                                If Pos1 > 0 Then
'                                    SearchS = Mid$(WebString, Pos2 + 1, Pos1 + 6 - (Pos2 + 1))
'                                Else
'                                    GenBankFetchStep = 1000
'                                    Exit Sub
'                                End If
'                                SearchS = Trim(SearchS)
'                                For X = 1 To Len(SearchS)
'                                    If Mid$(SearchS, X, 1) = " " Then
'                                        Mid$(SearchS, X, 1) = "+"
'                                    End If
'                                Next X
'                                URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=" + SearchS + "+AND+refseq+AND+txid10239[ORGN]"
'                                'RefetchGB = URLS
''                                Open "url.txt" For Output As #1
''                                Print #1, URLS
''                                Close #1
'                                Form5.Inet1.Execute URLS, "GET"
'                                Form5.Timer1.Interval = 100
'                                GenBankFetchStep = 8
'                            Else
'                                DoEvents
'                                Sleep 200
'                                F5T1Executing = 0
'                                Call Timer1_Timer 'GenBankFetchStep = 1000
'                                Exit Sub
'                            End If
'                        Else
'                            DoEvents
'                            Sleep 200
'                            F5T1Executing = 0
'                            Call Timer1_Timer 'GenBankFetchStep = 1000
'                            Exit Sub
'                        End If
'
'
'                    End If
'                End If
'
'
'
'        End If
'        End If
'    ElseIf GenBankFetchStep = 8 Then
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        DoEvents
'        Sleep 500
'        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        'On Error GoTo 0
'        If ChunkS = "" Then
'            DoEvents
'            Sleep 200
'            F5T1Executing = 0
'            Call Timer1_Timer 'GenBankFetchStep = 1000
'            Exit Sub
'        Else
'            WebString = ""
'            WebString = WebString + ChunkS
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    DoEvents
'                    Sleep 200
'                    ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                    WebString = WebString + ChunkS
'                Loop
'
'            End If
'        End If
'
'
'
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
'
'        SearchS = ""
'        Pos1 = 1
'        Do
'            Pos1 = InStr(Pos1, WebString, "<Id>", vbTextCompare)
'            If Pos1 > 0 Then
'                Pos2 = InStr(Pos1 + 1, WebString, "</Id>", vbTextCompare)
'                SearchS = SearchS + Mid$(WebString, Pos1 + 4, Pos2 - (Pos1 + 4)) + ","
'                X = X
'                Pos1 = Pos1 + 1
'            Else
'                If SearchS <> "" Then
'                    SearchS = Left(SearchS, Len(SearchS) - 1)
'                End If
'                Exit Do
'            End If
'        Loop
'        'XX = Right(SearchS, 20)
'        If SearchS <> "" Then
'            URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
'            RefetchGB = URLS
'            Form5.Inet1.Execute URLS, "GET"
'            Form5.Timer1.Interval = 100
'            GenBankFetchStep = 9
'        Else
'            GenBankFetchStep = 1000
'            Exit Sub
'        End If
'    ElseIf GenBankFetchStep = 9 Then
'        'form5.inet2.
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        DoEvents
'        Sleep 500
'        If Form5.Inet2.ResponseCode = 0 Then
'            'If DebuggingFlag < 2 Then On Error Resume Next
'            On Error Resume Next
'            Do
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                If ChunkS <> String(1024, " ") Then
'                    Exit Do
'                End If
'                DoEvents
'                Sleep 250
'
'            Loop
'            On Error GoTo 0
'            WebString = ""
'
'            WebString = WebString + ChunkS
'            If ChunkS > "" Then
'                XX = Len(WebString)
'                If Len(ChunkS) > 0 Then
'                    Do While Len(ChunkS) > 0
'                        ChunkS = TestS
'                        DoEvents
'                        Sleep 200
'                        'XX = Form1.Enabled
'                        'XX = Form1.SSPanel6(0).Enabled
'                        If DebuggingFlag < 2 Then On Error Resume Next
'                        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                        On Error GoTo 0
'                        WebString = WebString + ChunkS
'                    Loop
'                End If
'                DownloadedGBFiles = WebString
''                Form5.inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                RID = ""
''
'
'                GenBankFetchStep = 10
'        '        If X = 12345 Then
'        '            Open "Output2.html" For Binary As #1
'        '            XX = LOF(1)
'        '            WebString = String(LOF(1), " ")
'        '            Get #1, , WebString
'        '            Close #1
'        '        End If
'
'            End If
'        End If
'        'Form1.SSPanel1.Caption = ""
'        'Form1.ProgressBar1 = 0
'
'
'    End If
'
'    If GenBankFetchStep = 10 And ModSeqNumFlag = 0 Then
'        OV = SilentGBFlag
'        SilentGBFlag = 1
'        WebString = DownloadedGBFiles
'        'split the returned file up into individual genbank files and extract gene coords etc
'        Pos1 = 1
'        Pos2 = 0
'        Dim tGeneList() As GenomeFeatureDefine, tGeneNumber As Long, UBGN As Long, NumberHits As Long
'        ReDim tGeneList(100)
'        tGeneNumber = 0
'        UBGN = 100
'        NumberHits = 0
''                        XX = CurDir
''                Open "output.html" For Output As #1
''                Print #1, WebString
''                Close #1
''        SS = abs(gettickcount)
'        CurSegment = 0
'        ReDim GeneLabel(100)
'        AllowDoEvensFlag = 1
'        Do
'            Pos2 = InStr(Pos1, WebString, "//", vbBinaryCompare)
'            Dim tWebString As String
'            If Pos2 > 0 Then
'                tWebString = Mid$(WebString, Pos1, Pos2 - (Pos1 - 2))
'               ' XX = Right$(tWebString, 20)
'                NumberHits = NumberHits + 1
''                        If NumberHits = 5 Then
''                            X = X
''                        End If
'                CurSegment = CurSegment + 1
'                Call LoadGenBank(tWebString)
'                If AbortflagGB = 1 Then
'                    If ReassortmentFlag = 1 Then
'                        GenBankFetchStep = 8
'                    Else
'                        GenBankFetchStep = 9
'                    End If
'                    AbortflagGB = 0
'                    URLS = RefetchGB
'                   ' XX = App.Path
''                    Open "testURL.txt" For Output As #1
''                    Print #1, URLS
''                    Close #1
'                    Timer1.Enabled = False
'                    Timer1.Interval = 100
'                    Form5.Inet1.Execute URLS, "GET"
'                    Form5.Timer1.Enabled = True
'                    F5T1Executing = 0
'                    Exit Sub
'
'                Else
'                    For X = 1 To GeneNumber
'                        tGeneNumber = tGeneNumber + 1
'                        If tGeneNumber > UBGN Then
'                            UBGN = UBGN + 100
'                            ReDim Preserve tGeneList(UBGN)
'                        End If
'                        tGeneList(tGeneNumber) = GeneList(X)
'                        If tGeneNumber > UBound(GeneLabel, 1) Then
'                            ReDim Preserve GeneLabel(UBound(GeneLabel, 1) + 100)
'                        End If
'                        GeneLabel(tGeneNumber) = CurSegment
'                    Next X
'
'                End If
'
''                 XX = GeneList(28).StartInAlign
''                 XX = GeneList(28).EndInAlign
''                 XX = tGeneList(28).StartInAlign
''                 XX = tGeneList(28).EndInAlign
'
'
''                XX = GeneNUmber
''                XX = GeneList(GeneNUmber).StartInAlign '1
''                XX = GeneList(GeneNUmber).EndInAlign '9292
'                'xx=GeneList(GeneNUmber).
'                'save all the ORFs etc extracted
'            Else
'                Exit Do
'            End If
'            Pos1 = Pos2 + 1
'            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'            'This forces a singlee loop
'            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'            'NumberHits = 1
'            If ReassortmentFlag = 0 Then
'                Exit Do
'            Else
'                Form1.SSPanel1.Caption = "Loaded gene data for " + Trim(Str(NumberHits)) + " segments"
'            End If
'        Loop
'        AllowDoEvensFlag = 0
'
'        If X = X Then
'            If ReassortmentFlag = 1 Then
'                Dim MatchNum() As Long
'                ReDim MatchNum(tGeneNumber)
'                X = 0
'                For X = 1 To tGeneNumber
'
'                    If RemoveSegment(GeneLabel(X)) = 1 Then
'                        MatchNum(X) = -1
'                    End If
'
'                Next X
'                GeneNumber = 0
'                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'                For X = 1 To tGeneNumber
'                    If MatchNum(X) > -1 Then
'                        GeneNumber = GeneNumber + 1
'                        GeneList(GeneNumber) = tGeneList(X)
'                    End If
'                Next X
'                tGeneNumber = GeneNumber
'                For X = 1 To tGeneNumber
'                    tGeneList(X) = GeneList(X)
'                Next X
'                ReDim MatchNum(tGeneNumber)
'            End If
'            GeneNumber = 0
'            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'            For X = 1 To tGeneNumber
'                If tGeneList(X).StartInAlign > 0 Or tGeneList(X).EndInAlign > 0 Then
'                    GeneNumber = GeneNumber + 1
'                    GeneList(GeneNumber) = tGeneList(X)
'                End If
'            Next X
'
'
'            'this gets rid of duplicate segments in segemnted genomes
'            'that have multiple associated genbank files
'
'        Else
'
'            If ReassortmentFlag = 1 Then NumberHits = 1
'
'            Call CheckGenes(tGeneList(), tGeneNumber)
'
'
'            Dim MatchMatrix() As Integer
'
'            ReDim MatchMatrix(tGeneNumber, tGeneNumber), MatchNum(tGeneNumber)
'
'            'this gets rid of duplicate segments in segemnted genomes
'            'that have multiple associated genbank files
'            If ReassortmentFlag = 1 Then
'                X = 0
'                For X = 1 To tGeneNumber
'
'                    If RemoveSegment(GeneLabel(X)) = 1 Then
'                        MatchNum(X) = -1
'                    End If
'
'                Next X
'                GeneNumber = 0
'                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'                For X = 1 To tGeneNumber
'                    If MatchNum(X) > -1 Then
'                        GeneNumber = GeneNumber + 1
'                        GeneList(GeneNumber) = tGeneList(X)
'                    End If
'                Next X
'                tGeneNumber = GeneNumber
'                For X = 1 To tGeneNumber
'                    tGeneList(X) = GeneList(X)
'                Next X
'                ReDim MatchNum(tGeneNumber)
'            End If
'
'            'Find consensus ORFS, Features and Names
'
'    '        For X = 0 To tGeneNumber
'    '            MatchNum(X) = 0
'    '        Next X
'            Dim TotE As Long, TotS As Long, LenFrag As Long, TotF As Long, GoOn As Long
'
'            SSS = abs(gettickcount)
'
'            For X = 1 To tGeneNumber - 1
'                'XX = tGeneList(X).Orientation
'    '             If X = 42 Then
'    '                    X = X
'    '                End If
'                If tGeneList(X).Orientation = 1 Then
'                    If tGeneList(X).StartInAlign > tGeneList(X).EndInAlign Then
'
'                        tGeneList(X).EndInAlign = tGeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'    '                XX = tGeneList(X).Name
'    '                XX = tGeneList(X).Product
'                    LenFrag = tGeneList(X).EndInAlign - tGeneList(X).StartInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        XX = Right(tGeneList(Y).Product, 10)
'                        GoOn = 0
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If tGeneList(X).IntronFlag = tGeneList(Y).IntronFlag Then
'                                If tGeneList(X).ExonNumber = tGeneList(Y).ExonNumber Then
'                                    If (Right(tGeneList(X).Product, 1) <> "*" And Right(tGeneList(Y).Product, 1) <> "*") Then
'                                        GoOn = 1
'                                    ElseIf (Right(tGeneList(X).Product, 1) = "*" And Right(tGeneList(Y).Product, 1) = "*") Then
'                                        GoOn = 1
'                                    End If
'                                End If
'                            End If
'                        End If
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation And GoOn = 1 Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).StartInAlign > tGeneList(Y).EndInAlign Then
'                                    tGeneList(Y).EndInAlign = tGeneList(Y).EndInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                ElseIf tGeneList(X).Orientation = 2 Then
'
'                    If tGeneList(X).EndInAlign > tGeneList(X).StartInAlign Then
'
'                        tGeneList(X).StartInAlign = tGeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'
'                    LenFrag = tGeneList(X).StartInAlign - tGeneList(X).EndInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).EndInAlign > tGeneList(Y).StartInAlign Then
'                                    tGeneList(Y).StartInAlign = tGeneList(Y).StartInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                End If
'            Next X
'
'            'get rid on non-matchers (less that 2 matches) that overlap matchers
'            If NumberHits < 5 Then
'                threshold = 0
'            Else
'                threshold = 1
'            End If
'            X = 1
'
'            Do While X <= tGeneNumber
'                If MatchNum(X) < threshold Then
'                   MatchNum(X) = -1
'
'
'                End If
'                X = X + 1
'            Loop
'
'
'            'Find median start and end positions for repeats and get rid of repeats (but store data on names if necessary)
'            If NumberHits > 1 Then
'                For X = 1 To tGeneNumber - 1
'
'                    If MatchNum(X) >= threshold Then
'                        TotS = tGeneList(X).StartInAlign
'                        TotE = tGeneList(X).EndInAlign
'                        TotF = tGeneList(X).Frame
'                        For Y = X + 1 To tGeneNumber
'                            If MatchNum(Y) >= threshold Then
'                                If MatchMatrix(X, Y) = 1 Then
'                                    TotS = TotS + tGeneList(Y).StartInAlign
'                                    TotE = TotE + tGeneList(Y).EndInAlign
'                                    TotF = TotF + tGeneList(Y).Frame
'                                    If Len(tGeneList(X).Name) < Len(tGeneList(Y).Name) Then tGeneList(X).Name = tGeneList(Y).Name
'                                    If Len(tGeneList(X).Product) < Len(tGeneList(Y).Product) Then tGeneList(X).Product = tGeneList(Y).Product
'                                    'At some point I may have to deal with conflicts in introns and orientation here
'                                    MatchNum(Y) = -1
'                                End If
'                            End If
'                        Next Y
'                        tGeneList(X).StartInAlign = (CLng(TotS / (MatchNum(X) + 1)))
'                        tGeneList(X).EndInAlign = (CLng(TotE / (MatchNum(X) + 1)))
'                        If tGeneList(X).Orientation = 1 Then
'                            If tGeneList(X).EndInAlign > Len(StrainSeq(0)) Then tGeneList(X).EndInAlign = tGeneList(X).EndInAlign - Len(StrainSeq(0))
'
'                        ElseIf tGeneList(X).Orientation = 2 Then
'                            If tGeneList(X).StartInAlign > Len(StrainSeq(0)) Then tGeneList(X).StartInAlign = tGeneList(X).StartInAlign - Len(StrainSeq(0))
'                        End If
'                        tGeneList(X).Frame = CLng(TotF / (MatchNum(X) + 1))
'                        X = X
'                    Else
'                        X = X
'                    End If
'                Next X
'            End If
'
'
'
'
'            'copy over ones with matchnums>0 to genelist
'            GeneNumber = 0
'            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'            For X = 1 To tGeneNumber
'                If MatchNum(X) >= threshold Then
'                    GeneNumber = GeneNumber + 1
'                    GeneList(GeneNumber) = tGeneList(X)
'                Else
'                    X = X
'                End If
'            Next X
'            'GeneNUmber = 0
'
'
'            SilentGBFlag = OV
'
'            For X = 0 To GeneNumber
'                If GeneList(X).Orientation = 1 Then
'                    If GeneList(X).StartInAlign > GeneList(X).EndInAlign Then
'                        GeneList(X).EndInAlign = GeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    If GeneList(X).EndInAlign > GeneList(X).StartInAlign Then
'                        GeneList(X).StartInAlign = GeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'                End If
'            Next X
'
'            For X = 1 To GeneNumber
'    '            If X = 28 Then
'    '                X = X
'    '            End If
'    '            If GeneList(X).Start = 6919 Or GeneList(X).End = 6919 Then
'    '                X = X
'    '            End If
'                If GeneList(X).Orientation = 1 Then
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign >= GeneList(Y).EndInAlign And GeneList(X).StartInAlign <= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then ' genelist(y).orientation must be 2
'                                If GeneList(X).StartInAlign <= GeneList(Y).EndInAlign Then
'                                    If GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    ElseIf GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                 ElseIf (GeneList(X).EndInAlign >= GeneList(Y).StartInAlign And GeneList(X).StartInAlign <= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                    If GeneList(Y).Frame = GeneList(X).Frame Then
'                                        GeneList(Y).Frame = GeneList(X).Frame + 1
'                                        If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                    End If
'                                End If
'                            End If
'                        Next Y
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    'XX = Right(GeneList(X).Product, 10)
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).EndInAlign And GeneList(X).StartInAlign >= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then
'                                'XX = GeneList(Y).Orientation - should always be 1
'                                    If GeneList(X).StartInAlign >= GeneList(Y).EndInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).StartInAlign And GeneList(X).StartInAlign >= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'    '                            Else
'    '
'    '                            End If
'                            End If
'                        Next Y
'                    End If
'                End If
'            Next X
'
'        End If
'
'        'restore the ends
'        For X = 1 To GeneNumber
'            If GeneList(X).Orientation = 1 Then
'                If GeneList(X).EndInAlign > Len(StrainSeq(0)) Then
'                    GeneList(X).EndInAlign = GeneList(X).EndInAlign - Len(StrainSeq(0))
'                End If
'            ElseIf GeneList(X).Orientation = 2 Then
'                If GeneList(X).StartInAlign > Len(StrainSeq(0)) Then
'                    GeneList(X).StartInAlign = GeneList(X).StartInAlign - Len(StrainSeq(0))
'                End If
'
'            End If
'        Next X
'
'
'
'
'        'make sure genes besides/overlapping one another are in different "Frames"
'
'        'XX = GeneNumber
'       ' Call CheckGenes(GeneList(), GeneNumber)
'        If GeneNumber > 0 Then
'            ORFFlag = 1
'
'            Call DrawORFs
'            Form1.Picture20.Height = Form1.Picture4.ScaleHeight + 3
'            Form1.Picture20.BackColor = Form1.Picture7.BackColor
'
'            'If RunFlag = 1 Then
'            If RelX > 0 Or RelY > 0 Then
'                If XOverlist(RelX, RelY).ProgramFlag = 0 Or XOverlist(RelX, RelY).ProgramFlag = 0 + AddNum Then
''                            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
''                            Form1.Picture7.Height = Form1.Picture7.Height - (Form1.Picture20.ScaleHeight + 5)
'                    Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
'                    Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'
'
'                End If
'
'                'End If
'
'                Form1.Picture20.Visible = True
'            End If
'            Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
'            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'            'Call ResizeForm1
'
'        End If
'
'        Call FillGeneSEPos
'
'        'X = X
'
'        EEE = abs(gettickcount)
'        TT = EEE - SSS '1219 for ~2000 sequences
'
'
'        Form1.Picture4.ScaleMode = 3
'        Form1.Picture4.DrawMode = 13
'        Form1.Picture11.ScaleMode = 3
'        Form1.Picture19.DrawMode = 13
'        DontDoH1Inc = 1
'        OnlyDoPositionIndicator = 1
'        OnlyDoPosBar = 1
'
'        If Form1.HScroll1.MaX > 0 Then
'            If Form1.HScroll1.Value > Form1.HScroll1.Min Then
'                DontDoH1Inc = 1
'                H1C = 1
'                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
'                DontDoH1Inc = 0
'                H1C = 0
'                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
'            Else
'                DontDoH1Inc = 1
'                H1C = 1
'                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
'                DontDoH1Inc = 0
'                H1C = 0
'                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
'            End If
'        Else
'            Dim OI As Long, OD As Long
'            OI = Form1.Timer3.Interval
'            OD = Form1.Timer3.Enabled
'            Form1.Timer3.Enabled = False
'            Form1.Timer3.Interval = 27
'            Form1.Timer3.Enabled = True
'            DoEvents
'            Sleep 30
'            DoEvents
'            Form1.Timer3.Enabled = OD
'            Form1.Timer3.Interval = OI
'        End If
'        OnlyDoPositionIndicator = 0
'        OnlyDoPosBar = 0
'        DontDoH1Inc = 0
'
'        GenBankFetchStep = 1000
'        EE = abs(gettickcount)
'        TT = EE - StartFetch '468360 - 1 million nts restriction'25875,fail, 44563, 52578; 100000 nt restriction'50000 fail,342859,fail,40313
'        '1000000 no virus restriction
'        '559657
'        '0.00001 - 197500
'        X = X
'
'    End If
'    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
'    'If Left(Form1.SSPanel1.Caption, 16) = "Loaded gene data" Then
'        Form1.SSPanel1.Caption = ""
'    'End If
'    F5T1Executing = 0

End Sub

Private Sub Timer2_Timer()
'Exit Sub ' not working on 30-11-2018
'    If DoingShellFlag > 0 Then Exit Sub
'    If CurrentlyRunningFlag = 1 Then Exit Sub
'    If SchemDownFlag = 1 Then Exit Sub
'    If F5T2Executing = 1 Then Exit Sub
'    F5T2Executing = 1
'   ' Exit Sub
'    Dim ServerBFlag As Long, ServerS As String
'    Dim ServerB As String, NumGBs As Long, AddName As String, URLS As String, SearchS As String, WebString As String, Pos1 As Long, Pos2 As Long, RTOE As String, Target As String, LenRange As String
'    Dim ChunkS As String, TestS As String
'    If Form5.Inet2.StillExecuting = True Then
'        F5T2Executing = 0
'        Exit Sub
'    ElseIf GenBankFetchStep2 = 1000 Then
'        Form5.Timer2.Enabled = False
'    End If
'    Form5.Inet2.AccessType = icUseDefault
'    If GenBankFetchStep2 = 0 Then
'        GenBankFetchStep2 = 3
'    End If
'
'
'
'
'    ServerS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?"
'    ServerB = "http://bio.chpc.ac.za/blast/blast.cgi?"
'   'ServerB = "https://blast.h3abionet.org/blast/blast.cgi?"
'    'alternative servers
'    'ServerS = "http://bio.chpc.ac.za/blast/blast_cs.cgi?"
'    'ServerS = "https://137.158.204.6/blast/blast.cgi?" 'ebiokit-01.cbio.uct.ac.za
'    'ServerS = "http://129.85.245.250/Blast_cs.cgi?"
'    If GenBankFetchStep2 = 0 Then
'
'        'First flush all previous RIDs
'        If RID <> "" Then
'            Form5.Inet2.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'            RID = ""
'            GenBankFetchStep2 = 0
'       Else
'            Form5.Inet2.Execute (ServerS + "CMD=DisplayRIDs")
'            GenBankFetchStep2 = 3
'       End If
''        ChunkS = String(1024, " ")
''        TestS = ChunkS
''        ChunkS = Form5.inet2.GetChunk(1024, icString)
''        WebString = ""
''        WebString = WebString + ChunkS
''        If ChunkS <> TestS And Len(ChunkS) > 0 Then
''            Do While Len(ChunkS) > 0
''                ChunkS = TestS
''                ChunkS = Form5.inet2.GetChunk(1024, icString)
''                WebString = WebString + ChunkS
''            Loop
''
''        End If
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
''        X = X
'    ElseIf GenBankFetchStep2 = 1 Then
'        If Form5.Inet2.StillExecuting = False Then
'            GenBankFetchStep2 = 2
'        End If
''    ElseIf GenBankFetchStep2 = 2 Then
''        ChunkS = String(1024, " ")
''        TestS = ChunkS
''        ChunkS = Form5.inet2.GetChunk(1024, icString)
''        WebString = ""
''        WebString = WebString + ChunkS
''        If ChunkS <> TestS And Len(ChunkS) > 0 Then
''            Do While Len(ChunkS) > 0
''                ChunkS = TestS
''                ChunkS = Form5.inet2.GetChunk(1024, icString)
''                WebString = WebString + ChunkS
''            Loop
''
''        End If
'''        Open "output.html" For Output As #1
'''        Print #1, WebString
'''        Close #1
''        X = X
''        GenBankFetchStep2 = 3
'    ElseIf GenBankFetchStep2 = 3 Then
'        'SearchS = Left(StrainSeq(0), 200)
'        Dim MaxQL As Long
'        If ReassortmentFlag = 0 Then
'            If ORFRefNum > 5 Then ORFRefNum = 5
'            SearchS = String(200 * (ORFRefNum + 1), " ")
'        Else
'            ORFRefNum = RBPNum - 1
'            MaxQL = 1400 / (RBPNum)
'            SearchS = String(MaxQL * (ORFRefNum + 1), " ")
'        End If
'        Y = 0
'
'        'find most conserved 100nts
'
'        Dim MaxBkg As Single, MaxBkgPos As Long, PosXWin As Long
'
''        MaxBkg = -100
''        For X = 1 To Len(StrainSeq(0))
''            If BkgIdentity(X) > MaxBkg Then
''                MaxBkg = BkgIdentity(X)
''                MaxBkgPos = X
''            End If
''        Next X
''
''        MaxBkgPos = MaxBkgPos - 100
''        If MaxBkgPos < 1 Then MaxBkgPos = 1
''
''        If LSeq > 100 Then
''            If MaxBkgPos + 100 > LSeq Then
''                MaxBkgPos = LSeq - 100
''            End If
''
''        End If
'
'        'Mid$(SearchS, 1, 3) = ">A" + Chr(10)
'        MaxBkgPos = 1
'        Dim ReadSize As Long
'        If ReassortmentFlag = 0 Then
'            If Len(StrainSeq(0)) > (ORFRefNum + 1) * 200 Then
'                ReadSize = 200
'            Else
'                ReadSize = CLng(Len(StrainSeq(0)) / (ORFRefNum + 1))
'            End If
'            For Z = 0 To ORFRefNum
'                For X = MaxBkgPos To Len(StrainSeq(0))
'                    If Mid(StrainSeq(ORFRefList(Z)), X, 1) <> "-" Then '576,0,767,787,26
'                        Y = Y + 1
'                        Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(Z)), X, 1)
'                        If Y = 200 * (Z + 1) Then
'                            MaxBkgPos = MaxBkgPos + 200
'                            Exit For
'                        End If
'                    End If
'                Next X
'            Next Z
'        Else
'            For Z = 1 To RBPNum
'                'XX = UBound(RBPPos, 1)
'                For X = RBPPos(Z) To RBPPos(Z + 1)
'                    If Mid(StrainSeq(ORFRefList(0)), X, 1) <> "-" Then '576,0,767,787,26
'                        Y = Y + 1
'                        Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(0)), X, 1)
'                        If Y = MaxQL * (Z + 1) Then
'                            MaxBkgPos = MaxBkgPos + 200
'                            Exit For
'                        End If
'                    End If
'                Next X
'            Next Z
'        End If
'        'XX = Mid$(SearchS, 395, 20)
'        SearchS = Trim(SearchS) ': XX = Len(SearchS)
'        '1000:2000[slen]
'        'find the umber of gaps
'        Dim NumGaps As Long
'        NumGaps = 0
'        For X = 0 To Len(StrainSeq(0))
'            If SeqNum(X, 0) = 46 Then NumGaps = NumGaps + 1
'        Next X
'        'XX = Len(SearchS)
'        LenRange = "&ENTREZ_QUERY="
'        If ReassortmentFlag = 0 Then
'
'            LenRange = LenRange + Trim(Str(CLng((Len(StrainSeq(0)) - NumGaps) * 0.9))) + ":100000[slen]"
'
'
'            LenRange = LenRange + " AND txid10239[ORGN]"
'        Else
'            LenRange = LenRange + "txid10239[ORGN]"
'        End If
'        'LenRange = "srcdb_refseq[prop] "
'        'This is the best one yet
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'        'This is the next best one
'        'LenRange = LenRange + "txid10239[ORGN]"
'       ' URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=txid10239[ORGN]&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without length restrict: 43844, fail, 54047, fail
'        X = X
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without taxon restrict: 43187,995436, 434000, 150781, 250797
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'without taxon or length restrict: 644984, 368891
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'Best time = 64781, 184938, 132203, 66968, 28812, 49329, 175688, 23094, 23531, 33688
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00000001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        'Best time = 197500, 31156
'
'        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        '(megablast) Best time = 19953(EXPECT=0.00000001), 19797, 21500(EXPECT=0.01)
'        '47406
'
'        'CHPC seqrch
''        URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ncbi.viral.genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        If ReassortmentFlag = 0 Then
'
'            URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ncbi.refseq.viral.genomes&PROGRAM=blastn&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        Else
'            URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ncbi.refseq.viral.genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'        End If
'
''ncbi.refseq.viral.genomes
'
''       '3531 using chpc
''
'
''        XX = CurDir
''
''        Open "testurl.txt" For Output As #1
''            Print #1, URLS
''        Close #1
'        'URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=EU628620.1&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'        X = X
'
'
'        'Normal blast
'
'
''        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
'X = X
''        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
'
'        'alternative servers
'
'
'
'
''        Open "url.txt" For Output As #1
''        Print #1, URLS
''        Close #1
'
'        Form5.Inet2.UserName = "darrenpatrickmartin@gmail.com"
'        Form5.Inet2.Execute URLS ', "GET"
'        GenBankFetchStep2 = 7
'     ElseIf GenBankFetchStep2 = 4 Then
''        If Form5.Inet2.StillExecuting = False Then
''            GenBankFetchStep2 = 5
''        End If
''     ElseIf GenBankFetchStep2 = 5 Then
''
''
''        ChunkS = String(1024, " ")
''        TestS = ChunkS
''        'If DebuggingFlag < 2 Then On Error Resume Next
''        ChunkS = Form5.Inet2.GetChunk(1024, icString)
''        WebString = ""
''        'On Error GoTo 0
''        WebString = WebString + ChunkS
''        If ChunkS = String(1024, " ") Or ChunkS = "" Then
''            GenBankFetchStep2 = 3
''        Else
''
''        'XX = Form5.inet2.ResponseInfo
''            If ChunkS <> TestS And Len(ChunkS) > 0 Then
''                Do While Len(ChunkS) > 0
''                    ChunkS = TestS
''                    'If DebuggingFlag < 2 Then On Error Resume Next
''                    ChunkS = Form5.Inet2.GetChunk(1024, icString)
''                    'On Error GoTo 0
''                    WebString = WebString + ChunkS
''                Loop
''
''            End If
''            Open "output.html" For Output As #1
''            Print #1, WebString
''            Close #1
''    'XX = CurDir
''            Pos1 = InStr(1, WebString, "RID", vbTextCompare)
''
''            If Pos1 > 0 Then
''                If RID <> "" Then
''                    Form5.Inet2.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                    RID = ""
''                End If
''                RID = Trim(Mid(WebString, Pos1 + 6, 11))
''                If Left(RID, 9) <> "equest ID" Then
''
''
''                    Form5.Inet2.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
''                    GenBankFetchStep2 = 7
''                Else
''
''                    Open "output.html" For Output As #1
''                    Print #1, WebString
''                    Close #1
''                    RID = ""
''                    If RID <> "" Then
''                    Form5.Inet2.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                    RID = ""
''                End If
''                    GenBankFetchStep2 = 3
''                End If
''            Else
''                If RID <> "" Then
''                    Form5.Inet2.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                    RID = ""
''                End If
''                GenBankFetchStep2 = 3
''            End If
''        End If
''    ElseIf GenBankFetchStep2 = 6 Then
''        If Form5.Inet2.StillExecuting = False Then
''            GenBankFetchStep2 = 7
''        End If
'    ElseIf GenBankFetchStep2 = 7 Then
'
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        If DebuggingFlag < 2 Then On Error Resume Next
'        If Form5.Inet2.StillExecuting = False Then
'        DoEvents
'        Sleep 500
'        ChunkS = Form5.Inet2.GetChunk(1024, icString)
'        On Error GoTo 0
'        If ChunkS = "" Then
''            Form5.Inet2.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
''            GenBankFetchStep2 = 7
'            Exit Sub
'        Else
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                DoEvents
'                Sleep 200
'                If DebuggingFlag < 2 Then On Error Resume Next
'                ChunkS = Form5.Inet2.GetChunk(1024, icString)
'                On Error GoTo 0
'                WebString = WebString + ChunkS
'                If GenBankFetchStep2 = 1000 Then
'
'                    Form5.Timer2.Enabled = False
'                    Exit Sub
'                End If
'            Loop
'
'        End If
'
'        Pos1 = 0
'        Pos1 = InStr(1, WebString, "ALIGNMENTS", vbTextCompare)
'        'Pos1 = InStr(1, WebString, "READY", vbBinaryCompare)
''        XX = CurDir
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
''        If Pos1 = 0 Then
''            Pos1 = InStr(1, WebString, ">NC_", vbTextCompare)
''        End If
''        Open "output2.html" For Output As #1
''        Print #1, WebString
''        Close #1
'
'
'        If Pos1 = 0 Then
''            XX = CurDir
''            Open "output.html" For Output As #1
''            Print #1, WebString
''            Close #1
'            DoEvents
'            Sleep 200
'            F5T2Executing = 0
'            Call Timer2_Timer 'GenBankFetchStep2 = 1000
'            Exit Sub
'
'        Else
'            GenBankFetchStep = 1000
'            GenBankFetchStep3 = 1000
'            Form5.Timer1.Enabled = False
'            Form5.Timer3.Enabled = False
'                'get list of accession numbers
''                Open "output.html" For Output As #1
''                Print #1, WebString
''                Close #1
''                XX = CurDir
'                Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
'                '>NC_
'                If Pos2 = 0 Then
'                    Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
'                End If
'
'                If Pos2 = 0 Then
'
'                    DoEvents
'                    Sleep 200
'                    F5T2Executing = 0
'                    Call Timer2_Timer 'GenBankFetchStep2 = 1000
'                    Exit Sub
'                Else
'                    SearchS = ""
'                    NumGBs = 0
'                    If ReassortmentFlag = 0 Then
'                        Do While Pos2 > 0
'                            Pos1 = InStr(Pos2 + 3, WebString, " ", vbBinaryCompare)
'                            If Pos1 = 0 Then
'                                DoEvents
'                                Sleep 200
'                                F5T2Executing = 0
'                                Call Timer2_Timer 'GenBankFetchStep2 = 1000
'                                Exit Sub
'                            Else
'                                AddName = Mid$(WebString, Pos2 + 1, Pos1 - Pos2 - 1)
'                                Pos = InStr(4, AddName, "|", vbBinaryCompare)
'                                If Pos > 0 Then
'                                    AddName = Right(AddName, Len(AddName) - Pos)
'                                End If
'                                If Left(AddName, 4) = "ref|" Then
'                                    AddName = Mid$(AddName, 5, Len(AddName))
'                                End If
'
'                                If Right(AddName, 1) = "|" Then
'                                    AddName = Mid$(AddName, 1, Len(AddName) - 1)
'                                End If
'                                If SearchS = "" Then
'                                    SearchS = AddName
'                                    NumGBs = 1
'                                    X = X
'                                Else
'                                    SearchS = SearchS + "," + AddName
'                                    NumGBs = NumGBs + 1
'                                    X = X
'                                End If
'
'
'                            End If
'                            Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
'                            If Pos2 = 0 Then
'                                Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
'                            End If
'                        Loop
'                        URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
'                        RefetchGB = URLS
'
''                        XX = App.Path
''                        Open "testURL.txt" For Output As #1
''                        Print #1, URLS
''                        Close #1
'
'                        Form5.Inet2.Execute URLS, "GET"
'                        Form5.Timer2.Interval = 100
'                        GenBankFetchStep2 = 9
'                    Else
'                        'find the virus name
'                        Pos1 = InStr(1, WebString, ">NC_", vbBinaryCompare)
'                        If Pos1 > 0 Then
'                            Pos2 = InStr(Pos1 + 1, WebString, " ", vbBinaryCompare)
'                            If Pos2 > 0 Then
'                                Pos1 = InStr(Pos2 + 1, WebString, "virus", vbTextCompare)
'                                If Pos1 = 0 Then
'                                    Pos1 = InStr(Pos2 + 1, WebString, "phage", vbTextCompare)
'                                End If
'                                If Pos1 > 0 Then
'                                    SearchS = Mid$(WebString, Pos2 + 1, Pos1 + 6 - (Pos2 + 1))
'                                Else
'                                    GenBankFetchStep2 = 1000
'                                    Exit Sub
'                                End If
'                                SearchS = Trim(SearchS)
'                                For X = 1 To Len(SearchS)
'                                    If Mid$(SearchS, X, 1) = " " Then
'                                        Mid$(SearchS, X, 1) = "+"
'                                    End If
'                                Next X
'                                URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=" + SearchS + "+AND+refseq+AND+txid10239[ORGN]"
'                                'RefetchGB = URLS
''                                Open "url.txt" For Output As #1
''                                Print #1, URLS
''                                Close #1
'                                Form5.Inet2.Execute URLS, "GET"
'                                Form5.Timer2.Interval = 100
'                                GenBankFetchStep2 = 8
'                            Else
'                                DoEvents
'                                Sleep 200
'                                F5T2Executing = 0
'                                Call Timer2_Timer 'GenBankFetchStep2 = 1000
'                                Exit Sub
'                            End If
'                        Else
'                            DoEvents
'                            Sleep 200
'                            F5T2Executing = 0
'                            Call Timer2_Timer 'GenBankFetchStep2 = 1000
'                            Exit Sub
'                        End If
'
'
'                    End If
'
'                End If
'
'
'
'        End If
'        End If
'        End If
'    ElseIf GenBankFetchStep2 = 8 Then
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        DoEvents
'        Sleep 500
'        ChunkS = Form5.Inet2.GetChunk(1024, icString)
'        'On Error GoTo 0
'        If ChunkS = "" Then
'            DoEvents
'            Sleep 200
'            F5T2Executing = 0
'            Call Timer2_Timer 'GenBankFetchStep2 = 1000
'            Exit Sub
'        Else
'            WebString = ""
'            WebString = WebString + ChunkS
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    DoEvents
'                    Sleep 200
'                    ChunkS = Form5.Inet2.GetChunk(1024, icString)
'                    WebString = WebString + ChunkS
'                Loop
'
'            End If
'        End If
'
'
'
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
'
'        SearchS = ""
'        Pos1 = 1
'        Do
'            Pos1 = InStr(Pos1, WebString, "<Id>", vbTextCompare)
'            If Pos1 > 0 Then
'                Pos2 = InStr(Pos1 + 1, WebString, "</Id>", vbTextCompare)
'                SearchS = SearchS + Mid$(WebString, Pos1 + 4, Pos2 - (Pos1 + 4)) + ","
'                X = X
'                Pos1 = Pos1 + 1
'            Else
'                If SearchS <> "" Then
'                    SearchS = Left(SearchS, Len(SearchS) - 1)
'                End If
'                Exit Do
'            End If
'        Loop
'        'XX = Right(SearchS, 20)
'        If SearchS <> "" Then
'            URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
'            RefetchGB = URLS
'            Set HTTPRequest2 = New WinHttp.WinHttpRequest
'            HTTPRequest2.Open "GET", URLS, True
'            HTTPRequest2.SEnd
'            On Error Resume Next
'
'            HTTPRequest2.WaitForResponse
'            ErrorText = ""
'            ErrorText = HTTPRequest2.StatusText
'
'            On Error GoTo 0
'            If ErrorText <> "OK" Then
'                Timer3.Interval = 5000
'                F5T3Executing = 0
'                Exit Sub
'            End If
'            'Form5.Inet2.Execute URLS, "GET"
'            Form5.Timer2.Interval = 100
'            GenBankFetchStep2 = 9
'        Else
'            GenBankFetchStep2 = 1000
'            Exit Sub
'        End If
'    ElseIf GenBankFetchStep2 = 9 Then
'        'form5.inet2.
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        DoEvents
'        Sleep 500
'        If Form5.Inet2.ResponseCode = 0 Then
'            'If DebuggingFlag < 2 Then On Error Resume Next
'            On Error Resume Next
'            Do
'                ChunkS = Form5.Inet2.GetChunk(1024, icString)
'                If ChunkS <> String(1024, " ") Then
'                    Exit Do
'                End If
'                DoEvents
'                Sleep 250
'
'            Loop
'            On Error GoTo 0
'            WebString = ""
'
'            WebString = WebString + ChunkS
'            If ChunkS > "" Then
'                XX = Len(WebString)
'                If Len(ChunkS) > 0 Then
'                    Do While Len(ChunkS) > 0
'                        ChunkS = TestS
'                        DoEvents
'                        Sleep 200
'                        'XX = Form1.Enabled
'                        'XX = Form1.SSPanel6(0).Enabled
'                        If DebuggingFlag < 2 Then On Error Resume Next
'                        ChunkS = Form5.Inet2.GetChunk(1024, icString)
'                        On Error GoTo 0
'                        WebString = WebString + ChunkS
'                    Loop
'                End If
'                DownloadedGBFiles = WebString
''                Form5.Inet2.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
''                RID = ""
''
'
'                GenBankFetchStep2 = 10
'        '        If X = 12345 Then
'        '            Open "Output2.html" For Binary As #1
'        '            XX = LOF(1)
'        '            WebString = String(LOF(1), " ")
'        '            Get #1, , WebString
'        '            Close #1
'        '        End If
'
'            End If
'        End If
'        'Form1.SSPanel1.Caption = ""
'        'Form1.ProgressBar1 = 0
'
'
'    End If
'
'    If GenBankFetchStep2 = 10 And ModSeqNumFlag = 0 Then
'        OV = SilentGBFlag
'        SilentGBFlag = 1
'        WebString = DownloadedGBFiles
'        'split the returned file up into individual genbank files and extract gene coords etc
'        Pos1 = 1
'        Pos2 = 0
'        Dim tGeneList() As GenomeFeatureDefine, tGeneNumber As Long, UBGN As Long, NumberHits As Long
'        ReDim tGeneList(100)
'        tGeneNumber = 0
'        UBGN = 100
'        NumberHits = 0
''                        XX = CurDir
''                Open "output.html" For Output As #1
''                Print #1, WebString
''                Close #1
''        SS = abs(gettickcount)
'        CurSegment = 0
'        ReDim GeneLabel(100)
'        AllowDoEvensFlag = 1
'        Do
'            Pos2 = InStr(Pos1, WebString, "//", vbBinaryCompare)
'            Dim tWebString As String
'            If Pos2 > 0 Then
'                tWebString = Mid$(WebString, Pos1, Pos2 - (Pos1 - 2))
'               ' XX = Right$(tWebString, 20)
'                NumberHits = NumberHits + 1
''                        If NumberHits = 5 Then
''                            X = X
''                        End If
'                CurSegment = CurSegment + 1
'                Call LoadGenBank(tWebString)
'                If AbortflagGB = 1 Then
'                    If ReassortmentFlag = 1 Then
'                        GenBankFetchStep2 = 8
'                    Else
'                        GenBankFetchStep2 = 9
'                    End If
'                    AbortflagGB = 0
'                    URLS = RefetchGB
'                   ' XX = App.Path
''                    Open "testURL.txt" For Output As #1
''                    Print #1, URLS
''                    Close #1
'                    Timer2.Enabled = False
'                    Timer2.Interval = 100
'                    Form5.Inet2.Execute URLS, "GET"
'                    Form5.Timer2.Enabled = True
'                    F5T2Executing = 0
'                    Exit Sub
'
'                Else
'                    For X = 1 To GeneNumber
'                        tGeneNumber = tGeneNumber + 1
'                        If tGeneNumber > UBGN Then
'                            UBGN = UBGN + 100
'                            ReDim Preserve tGeneList(UBGN)
'                        End If
'                        tGeneList(tGeneNumber) = GeneList(X)
'                        If tGeneNumber > UBound(GeneLabel, 1) Then
'                            ReDim Preserve GeneLabel(UBound(GeneLabel, 1) + 100)
'                        End If
'                        GeneLabel(tGeneNumber) = CurSegment
'                    Next X
'
'                End If
'
''                 XX = GeneList(28).StartInAlign
''                 XX = GeneList(28).EndInAlign
''                 XX = tGeneList(28).StartInAlign
''                 XX = tGeneList(28).EndInAlign
'
'
''                XX = GeneNUmber
''                XX = GeneList(GeneNUmber).StartInAlign '1
''                XX = GeneList(GeneNUmber).EndInAlign '9292
'                'xx=GeneList(GeneNUmber).
'                'save all the ORFs etc extracted
'            Else
'                Exit Do
'            End If
'            Pos1 = Pos2 + 1
'            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'            'This forces a singlee loop
'            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'            'NumberHits = 1
'            If ReassortmentFlag = 0 Then
'                Exit Do
'            Else
'                Form1.SSPanel1.Caption = "Loaded gene data for " + Trim(Str(NumberHits)) + " segments"
'            End If
'        Loop
'        AllowDoEvensFlag = 0
'
'        If X = X Then
'            If ReassortmentFlag = 1 Then
'                Dim MatchNum() As Long
'                ReDim MatchNum(tGeneNumber)
'                X = 0
'                For X = 1 To tGeneNumber
'
'                    If RemoveSegment(GeneLabel(X)) = 1 Then
'                        MatchNum(X) = -1
'                    End If
'
'                Next X
'                GeneNumber = 0
'                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'                For X = 1 To tGeneNumber
'                    If MatchNum(X) > -1 Then
'                        GeneNumber = GeneNumber + 1
'                        GeneList(GeneNumber) = tGeneList(X)
'                    End If
'                Next X
'                tGeneNumber = GeneNumber
'                For X = 1 To tGeneNumber
'                    tGeneList(X) = GeneList(X)
'                Next X
'                ReDim MatchNum(tGeneNumber)
'            End If
'            GeneNumber = 0
'            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'            For X = 1 To tGeneNumber
'                If tGeneList(X).StartInAlign > 0 Or tGeneList(X).EndInAlign > 0 Then
'                    GeneNumber = GeneNumber + 1
'                    GeneList(GeneNumber) = tGeneList(X)
'                End If
'            Next X
'
'
'            'this gets rid of duplicate segments in segemnted genomes
'            'that have multiple associated genbank files
'
'        Else
'
'            If ReassortmentFlag = 1 Then NumberHits = 1
'
'            Call CheckGenes(tGeneList(), tGeneNumber)
'
'
'            Dim MatchMatrix() As Integer
'
'            ReDim MatchMatrix(tGeneNumber, tGeneNumber), MatchNum(tGeneNumber)
'
'            'this gets rid of duplicate segments in segemnted genomes
'            'that have multiple associated genbank files
'            If ReassortmentFlag = 1 Then
'                X = 0
'                For X = 1 To tGeneNumber
'
'                    If RemoveSegment(GeneLabel(X)) = 1 Then
'                        MatchNum(X) = -1
'                    End If
'
'                Next X
'                GeneNumber = 0
'                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'                For X = 1 To tGeneNumber
'                    If MatchNum(X) > -1 Then
'                        GeneNumber = GeneNumber + 1
'                        GeneList(GeneNumber) = tGeneList(X)
'                    End If
'                Next X
'                tGeneNumber = GeneNumber
'                For X = 1 To tGeneNumber
'                    tGeneList(X) = GeneList(X)
'                Next X
'                ReDim MatchNum(tGeneNumber)
'            End If
'
'            'Find consensus ORFS, Features and Names
'
'    '        For X = 0 To tGeneNumber
'    '            MatchNum(X) = 0
'    '        Next X
'            Dim TotE As Long, TotS As Long, LenFrag As Long, TotF As Long, GoOn As Long
'
'            SSS = abs(gettickcount)
'
'            For X = 1 To tGeneNumber - 1
'                'XX = tGeneList(X).Orientation
'    '             If X = 42 Then
'    '                    X = X
'    '                End If
'                If tGeneList(X).Orientation = 1 Then
'                    If tGeneList(X).StartInAlign > tGeneList(X).EndInAlign Then
'
'                        tGeneList(X).EndInAlign = tGeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'    '                XX = tGeneList(X).Name
'    '                XX = tGeneList(X).Product
'                    LenFrag = tGeneList(X).EndInAlign - tGeneList(X).StartInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        XX = Right(tGeneList(Y).Product, 10)
'                        GoOn = 0
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If tGeneList(X).IntronFlag = tGeneList(Y).IntronFlag Then
'                                If tGeneList(X).ExonNumber = tGeneList(Y).ExonNumber Then
'                                    If (Right(tGeneList(X).Product, 1) <> "*" And Right(tGeneList(Y).Product, 1) <> "*") Then
'                                        GoOn = 1
'                                    ElseIf (Right(tGeneList(X).Product, 1) = "*" And Right(tGeneList(Y).Product, 1) = "*") Then
'                                        GoOn = 1
'                                    End If
'                                End If
'                            End If
'                        End If
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation And GoOn = 1 Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).StartInAlign > tGeneList(Y).EndInAlign Then
'                                    tGeneList(Y).EndInAlign = tGeneList(Y).EndInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                ElseIf tGeneList(X).Orientation = 2 Then
'
'                    If tGeneList(X).EndInAlign > tGeneList(X).StartInAlign Then
'
'                        tGeneList(X).StartInAlign = tGeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'
'                    LenFrag = tGeneList(X).StartInAlign - tGeneList(X).EndInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).EndInAlign > tGeneList(Y).StartInAlign Then
'                                    tGeneList(Y).StartInAlign = tGeneList(Y).StartInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                End If
'            Next X
'
'            'get rid on non-matchers (less that 2 matches) that overlap matchers
'            If NumberHits < 5 Then
'                threshold = 0
'            Else
'                threshold = 1
'            End If
'            X = 1
'
'            Do While X <= tGeneNumber
'                If MatchNum(X) < threshold Then
'                   MatchNum(X) = -1
'
'
'                End If
'                X = X + 1
'            Loop
'
'
'            'Find median start and end positions for repeats and get rid of repeats (but store data on names if necessary)
'            If NumberHits > 1 Then
'                For X = 1 To tGeneNumber - 1
'
'                    If MatchNum(X) >= threshold Then
'                        TotS = tGeneList(X).StartInAlign
'                        TotE = tGeneList(X).EndInAlign
'                        TotF = tGeneList(X).Frame
'                        For Y = X + 1 To tGeneNumber
'                            If MatchNum(Y) >= threshold Then
'                                If MatchMatrix(X, Y) = 1 Then
'                                    TotS = TotS + tGeneList(Y).StartInAlign
'                                    TotE = TotE + tGeneList(Y).EndInAlign
'                                    TotF = TotF + tGeneList(Y).Frame
'                                    If Len(tGeneList(X).Name) < Len(tGeneList(Y).Name) Then tGeneList(X).Name = tGeneList(Y).Name
'                                    If Len(tGeneList(X).Product) < Len(tGeneList(Y).Product) Then tGeneList(X).Product = tGeneList(Y).Product
'                                    'At some point I may have to deal with conflicts in introns and orientation here
'                                    MatchNum(Y) = -1
'                                End If
'                            End If
'                        Next Y
'                        tGeneList(X).StartInAlign = (CLng(TotS / (MatchNum(X) + 1)))
'                        tGeneList(X).EndInAlign = (CLng(TotE / (MatchNum(X) + 1)))
'                        If tGeneList(X).Orientation = 1 Then
'                            If tGeneList(X).EndInAlign > Len(StrainSeq(0)) Then tGeneList(X).EndInAlign = tGeneList(X).EndInAlign - Len(StrainSeq(0))
'
'                        ElseIf tGeneList(X).Orientation = 2 Then
'                            If tGeneList(X).StartInAlign > Len(StrainSeq(0)) Then tGeneList(X).StartInAlign = tGeneList(X).StartInAlign - Len(StrainSeq(0))
'                        End If
'                        tGeneList(X).Frame = CLng(TotF / (MatchNum(X) + 1))
'                        X = X
'                    Else
'                        X = X
'                    End If
'                Next X
'            End If
'
'
'
'
'            'copy over ones with matchnums>0 to genelist
'            GeneNumber = 0
'            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'            For X = 1 To tGeneNumber
'                If MatchNum(X) >= threshold Then
'                    GeneNumber = GeneNumber + 1
'                    GeneList(GeneNumber) = tGeneList(X)
'                Else
'                    X = X
'                End If
'            Next X
'            'GeneNUmber = 0
'
'
'            SilentGBFlag = OV
'
'            For X = 0 To GeneNumber
'                If GeneList(X).Orientation = 1 Then
'                    If GeneList(X).StartInAlign > GeneList(X).EndInAlign Then
'                        GeneList(X).EndInAlign = GeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    If GeneList(X).EndInAlign > GeneList(X).StartInAlign Then
'                        GeneList(X).StartInAlign = GeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'                End If
'            Next X
'
'            For X = 1 To GeneNumber
'    '            If X = 28 Then
'    '                X = X
'    '            End If
'    '            If GeneList(X).Start = 6919 Or GeneList(X).End = 6919 Then
'    '                X = X
'    '            End If
'                If GeneList(X).Orientation = 1 Then
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign >= GeneList(Y).EndInAlign And GeneList(X).StartInAlign <= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then ' genelist(y).orientation must be 2
'                                If GeneList(X).StartInAlign <= GeneList(Y).EndInAlign Then
'                                    If GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    ElseIf GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                 ElseIf (GeneList(X).EndInAlign >= GeneList(Y).StartInAlign And GeneList(X).StartInAlign <= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                    If GeneList(Y).Frame = GeneList(X).Frame Then
'                                        GeneList(Y).Frame = GeneList(X).Frame + 1
'                                        If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                    End If
'                                End If
'                            End If
'                        Next Y
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    'XX = Right(GeneList(X).Product, 10)
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).EndInAlign And GeneList(X).StartInAlign >= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then
'                                'XX = GeneList(Y).Orientation - should always be 1
'                                    If GeneList(X).StartInAlign >= GeneList(Y).EndInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).StartInAlign And GeneList(X).StartInAlign >= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'    '                            Else
'    '
'    '                            End If
'                            End If
'                        Next Y
'                    End If
'                End If
'            Next X
'
'        End If
'
'        'restore the ends
'        For X = 1 To GeneNumber
'            If GeneList(X).Orientation = 1 Then
'                If GeneList(X).EndInAlign > Len(StrainSeq(0)) Then
'                    GeneList(X).EndInAlign = GeneList(X).EndInAlign - Len(StrainSeq(0))
'                End If
'            ElseIf GeneList(X).Orientation = 2 Then
'                If GeneList(X).StartInAlign > Len(StrainSeq(0)) Then
'                    GeneList(X).StartInAlign = GeneList(X).StartInAlign - Len(StrainSeq(0))
'                End If
'
'            End If
'        Next X
'
'
'
'
'        'make sure genes besides/overlapping one another are in different "Frames"
'
'        'XX = GeneNumber
'       ' Call CheckGenes(GeneList(), GeneNumber)
'        If GeneNumber > 0 Then
'            ORFFlag = 1
'
'            Call DrawORFs
'            Form1.Picture20.Height = Form1.Picture4.ScaleHeight + 3
'            Form1.Picture20.BackColor = Form1.Picture7.BackColor
'
'            'If RunFlag = 1 Then
'            If RelX > 0 Or RelY > 0 Then
'                If XOverlist(RelX, RelY).ProgramFlag = 0 Or XOverlist(RelX, RelY).ProgramFlag = 0 + AddNum Then
''                            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
''                            Form1.Picture7.Height = Form1.Picture7.Height - (Form1.Picture20.ScaleHeight + 5)
'                    Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
'                    Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'
'
'                End If
'
'                'End If
'
'                Form1.Picture20.Visible = True
'            End If
'            Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
'            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'            'Call ResizeForm1
'
'        End If
'
'        Call FillGeneSEPos
'
'        'X = X
'
'        EEE = abs(gettickcount)
'        TT = EEE - SSS '1219 for ~2000 sequences
'
'
'        Form1.Picture4.ScaleMode = 3
'        Form1.Picture4.DrawMode = 13
'        Form1.Picture11.ScaleMode = 3
'        Form1.Picture19.DrawMode = 13
'        DontDoH1Inc = 1
'        OnlyDoPositionIndicator = 1
'        OnlyDoPosBar = 1
'
'        If Form1.HScroll1.MaX > 0 Then
'            If Form1.HScroll1.Value > Form1.HScroll1.Min Then
'                DontDoH1Inc = 1
'                H1C = 1
'                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
'                DontDoH1Inc = 0
'                H1C = 0
'                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
'            Else
'                DontDoH1Inc = 1
'                H1C = 1
'                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
'                DontDoH1Inc = 0
'                H1C = 0
'                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
'            End If
'        Else
'            Dim OI As Long, OD As Long
'            OI = Form1.Timer3.Interval
'            OD = Form1.Timer3.Enabled
'            Form1.Timer3.Enabled = False
'            Form1.Timer3.Interval = 27
'            Form1.Timer3.Enabled = True
'            DoEvents
'            Sleep 30
'            DoEvents
'            Form1.Timer3.Enabled = OD
'            Form1.Timer3.Interval = OI
'        End If
'        OnlyDoPositionIndicator = 0
'        OnlyDoPosBar = 0
'        DontDoH1Inc = 0
'
'        GenBankFetchStep2 = 1000
'        EE = abs(gettickcount)
'        TT = EE - StartFetch '468360 - 1 million nts restriction'25875,fail, 44563, 52578; 100000 nt restriction'50000 fail,342859,fail,40313
'        '1000000 no virus restriction
'        '559657
'        '0.00001 - 197500
'        X = X
'
'    End If
'    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
'    'If Left(Form1.SSPanel1.Caption, 16) = "Loaded gene data" Then
'        Form1.SSPanel1.Caption = ""
'    'End If
'    F5T2Executing = 0

End Sub

Private Sub Timer3_Timer()
'x = x
'Exit Sub

    If GenBankFetchStep3 = 1000 Then
        Timer3.Enabled = False
        Exit Sub
    End If
    'If ORFFlag > 0 Then Exit Sub
    If NextNo <= 0 Then Exit Sub
    If LoadBusy = 1 Then Exit Sub
    If Len(StrainSeq(0)) <> Decompress(Len(StrainSeq(0))) Then Exit Sub
    If (CLine <> "" And CLine <> " ") Then Exit Sub
    If AutoMultFlag > 0 Then Exit Sub
    
    If NextNo = 0 Then Exit Sub
    If DoingShellFlag > 0 Then Exit Sub
    If CurrentlyRunningFlag <> 0 Then Exit Sub
    If SchemDownFlag <> 0 Then Exit Sub
    If F5T3Executing <> 0 Then Exit Sub
    F5T3Executing = 1
   ' Exit Sub
    Dim ServerBFlag As Long, ServerS As String
    Dim ServerB As String, NumGBs As Long, AddName As String, URLS As String, SearchS As String, WebString As String, Pos1 As Long, Pos2 As Long, RTOE As String, Target As String, LenRange As String
    Dim ChunkS As String, TestS As String
'    If Form5.Inet3.StillExecuting = True Then
'        F5T3Executing = 0
'        Exit Sub
'    ElseIf GenBankFetchStep3 = 1000 Then
'        Form5.Timer3.Enabled = False
'    Else
'
'    End If
    'Form5.Inet3.AccessType = icUseDefault
    If GenBankFetchStep3 = 0 Then
        GenBankFetchStep3 = 3
    End If




    ServerS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?"
    
   
    If BlastTS = 4 Or BlastTS = 5 Then
        ServerB = "http://bio.chpc.ac.za/blast/blast.cgi?"
    ElseIf BlastTS = 2 Or BlastTS = 3 Then
        ServerB = "https://blast.h3abionet.org/blast/blast.cgi?"
    Else
        ServerB = "https://blast.southgreen.fr/blast.cgi?"
    End If
    
    
    
    'alternative servers
    'ServerS = "http://bio.chpc.ac.za/blast/blast.cgi?"
    'ServerS = "http://bio.chpc.ac.za/blast/blast_cs.cgi?"
    'ServerS = "https://137.158.204.6/blast/blast.cgi?" 'ebiokit-01.cbio.uct.ac.za
    'ServerS = "http://129.85.245.250/Blast_cs.cgi?"
    If GenBankFetchStep3 = 0 Then

        'First flush all previous RIDs
        If RID <> "" Then
'            Form5.Inet3.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
            RID = ""
            GenBankFetchStep3 = 0
       Else
'            Form5.Inet3.Execute (ServerS + "CMD=DisplayRIDs")
            GenBankFetchStep3 = 3
       End If
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        ChunkS = Form5.Inet3.GetChunk(1024, icString)
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'            Loop
'
'        End If
'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1
'        X = X
    ElseIf GenBankFetchStep3 = 1 Then
        'If Form5.Inet3.StillExecuting = False Then
            GenBankFetchStep3 = 2
       ' End If
'    ElseIf GenBankFetchStep3 = 2 Then
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        ChunkS = Form5.Inet3.GetChunk(1024, icString)
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'            Loop
'
'        End If
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
'        X = X
'        GenBankFetchStep3 = 3
    ElseIf GenBankFetchStep3 = 3 Then
        'SearchS = Left(StrainSeq(0), 200)
        Dim MaxQL As Long
        If ReassortmentFlag = 0 Then
            If ORFRefNum > 5 Then ORFRefNum = 5
            SearchS = String(200 * (ORFRefNum + 1), " ")
        Else
            ORFRefNum = RBPNum - 1
            MaxQL = 1400 / (RBPNum)
            SearchS = String(MaxQL * (ORFRefNum + 1), " ")
        End If
        Y = 0

        'find most conserved 100nts

        Dim MaxBkg As Single, MaxBkgPos As Long, PosXWin As Long

'        XX = BkgIdentity(7000)
'        XX = BkgIdentity(8000)
'        XX = BkgIdentity(9000)
'        XX = BkgIdentity(10000)
'        XX = BkgIdentity(11000)
'        XX = BkgIdentity(12000)
'        XX = BkgIdentity(13000)
'        MaxBkg = -100
'        For X = 1 To Len(StrainSeq(0))
'            If BkgIdentity(X) > MaxBkg Then
'                MaxBkg = BkgIdentity(X)
'                MaxBkgPos = X
'            End If
'        Next X
'
'        MaxBkgPos = MaxBkgPos - 100
'        If MaxBkgPos < 1 Then MaxBkgPos = 1
'
'        If LSeq > 100 Then
'            If MaxBkgPos + 100 > LSeq Then
'                MaxBkgPos = LSeq - 100
'            End If
'
'        End If

        'Mid$(SearchS, 1, 3) = ">A" + Chr(10)
        MaxBkgPos = 1
        Dim ReadSize As Long
        If ReassortmentFlag = 0 Then
            If Len(StrainSeq(0)) > (ORFRefNum + 1) * 200 Then
                ReadSize = 200
            Else
                ReadSize = CLng(Len(StrainSeq(0)) / (ORFRefNum + 1))
            End If
            
            On Error Resume Next
            ubol = -1
            ubol = UBound(ORFRefList)
            
            On Error GoTo 0
            If ubol = -1 Then Exit Sub
            For Z = 0 To ORFRefNum
                For x = MaxBkgPos To Len(StrainSeq(0))
                    If Mid(StrainSeq(ORFRefList(Z)), x, 1) <> "-" Then '576,0,767,787,26
                        Y = Y + 1
                        Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(Z)), x, 1)
                        If Y = 200 * (Z + 1) Then
                            MaxBkgPos = MaxBkgPos + 200
                            Exit For
                        End If
                    End If
                Next x
            Next Z
        Else
            For Z = 1 To RBPNum - 1
                'XX = UBound(RBPPos, 1)
                For x = RBPPos(Z) To RBPPos(Z + 1)
                    If Mid(StrainSeq(ORFRefList(0)), x, 1) <> "-" Then '576,0,767,787,26
                        Y = Y + 1
                        If Y <= Len(SearchS) Then
                            Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(0)), x, 1)
                        End If
                        If Y = MaxQL * (Z + 1) Then
                            MaxBkgPos = MaxBkgPos + 200
                            Exit For
                        End If
                    End If
                Next x
            Next Z
        End If
        'XX = Mid$(SearchS, 395, 20)
        SearchS = Trim(SearchS) ': XX = Len(SearchS)
        '1000:2000[slen]
        'find the umber of gaps
        Dim NumGaps As Long
        NumGaps = 0
        For x = 0 To Len(StrainSeq(0))
            If SeqNum(x, 0) = 46 Then NumGaps = NumGaps + 1
        Next x
        'XX = Len(SearchS)
        LenRange = "&ENTREZ_QUERY="
        If ReassortmentFlag = 0 Then

            LenRange = LenRange + Trim(Str(CLng((Len(StrainSeq(0)) - NumGaps) * 0.9))) + ":100000[slen]"


            LenRange = LenRange + " AND txid10239[ORGN]"
        Else
            LenRange = LenRange + "txid10239[ORGN]"
        End If
        'LenRange = "srcdb_refseq[prop] "
        'This is the best one yet

        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"



        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"

        'This is the next best one
        'LenRange = LenRange + "txid10239[ORGN]"
       ' URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=txid10239[ORGN]&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without length restrict: 43844, fail, 54047, fail
        x = x
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without taxon restrict: 43187,995436, 434000, 150781, 250797

        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without taxon or length restrict: 644984, 368891

        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'Best time = 64781, 184938, 132203, 66968, 28812, 49329, 175688, 23094, 23531, 33688

        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00000001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'Best time = 197500, 31156

        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        '(megablast) Best time = 19953(EXPECT=0.00000001), 19797, 21500(EXPECT=0.01)
        '47406

        'CHPC seqrch
'        URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ncbi.viral.genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        If ReassortmentFlag = 0 Then
            If BlastTS = 0 Or BlastTS = 2 Or BlastTS = 4 Or BlastTS = 6 Then                                           'ncbi.refseq.viral.genomes
                URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ref_viruses_rep_genomes&PROGRAM=blastn&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
            Else
                URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ref_viruses_rep_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
            End If
        Else
            If BlastTS = 0 Or BlastTS = 2 Or BlastTS = 4 Or BlastTS = 6 Then
                URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ref_viruses_rep_genomes&PROGRAM=blastn&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
            Else
                URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=ref_viruses_rep_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
            End If
        End If

'ncbi.refseq.viral.genomes

'       '3531 using chpc
'

'       XX = CurDir
'''
'        Open "testurl.txt" For Output As #1
'            Print #1, URLS
'        Close #1
        'URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=EU628620.1&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        x = x


        'Normal blast


'        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
x = x
'        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"

        'alternative servers




'        Open "url.txt" For Output As #1
'        Print #1, URLS
'        Close #1
'        XX = CurDir
        Set HTTPRequest2 = New WinHttp.WinHttpRequest
        HTTPRequest2.Open "GET", URLS, True
        'HTTPRequest2.SetClientCertificate
        HTTPRequest2.SEnd
        On Error GoTo CrashExit
        HTTPRequest2.WaitForResponse
        
        
        ErrorText = ""
        ErrorText = HTTPRequest2.StatusText
        If ErrorText <> "OK" Then
            If ErrorText = "Forbidden" Then
                BlastTS = BlastTS + 2
                F5T3Executing = 0
                Exit Sub
            Else
                BlastTS = BlastTS + 2
                Timer3.Interval = 1000
                F5T3Executing = 0
                Exit Sub
            End If
        End If
        'On Error Resume Next
        XX = HTTPRequest2.StatusText
        XX = HTTPRequest2.GetAllResponseHeaders
        Yy = HTTPRequest2.ResponseText
        'ZZ = HTTPRequest2.
'        Open "resepneheaders.txt" For Output As #1
'        Print #1, XX
'        Print #1, ""
'         Print #1, YY

        Close #1
        On Error GoTo 0
'        Form5.Inet3.UserName = "darrenpatrickmartin@gmail.com"
'        Form5.Inet3.Execute URLS ', "GET"
        GenBankFetchStep3 = 7
     ElseIf GenBankFetchStep3 = 4 Then
'        If Form5.Inet3.StillExecuting = False Then
'            GenBankFetchStep3 = 5
'        End If
'     ElseIf GenBankFetchStep3 = 5 Then
'
'
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        ChunkS = Form5.Inet3.GetChunk(1024, icString)
'        WebString = ""
'        'On Error GoTo 0
'        WebString = WebString + ChunkS
'        If ChunkS = String(1024, " ") Or ChunkS = "" Then
'            GenBankFetchStep3 = 3
'        Else
'
'        'XX = Form5.Inet3.ResponseInfo
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    'If DebuggingFlag < 2 Then On Error Resume Next
'                    ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                    'On Error GoTo 0
'                    WebString = WebString + ChunkS
'                Loop
'
'            End If
'            Open "output.html" For Output As #1
'            Print #1, WebString
'            Close #1
'    'XX = CurDir
'            Pos1 = InStr(1, WebString, "RID", vbTextCompare)
'
'            If Pos1 > 0 Then
'                If RID <> "" Then
'                    Form5.Inet3.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                RID = Trim(Mid(WebString, Pos1 + 6, 11))
'                If Left(RID, 9) <> "equest ID" Then
'
'
'                    Form5.Inet3.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
'                    GenBankFetchStep3 = 7
'                Else
'
'                    Open "output.html" For Output As #1
'                    Print #1, WebString
'                    Close #1
'                    RID = ""
'                    If RID <> "" Then
'                    Form5.Inet3.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                    GenBankFetchStep3 = 3
'                End If
'            Else
'                If RID <> "" Then
'                    Form5.Inet3.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
'                GenBankFetchStep3 = 3
'            End If
'        End If
'    ElseIf GenBankFetchStep3 = 6 Then
'        If Form5.Inet3.StillExecuting = False Then
'            GenBankFetchStep3 = 7
'        End If
    ElseIf GenBankFetchStep3 = 7 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 7"
        Form1.SSPanel1.Caption = "Comparing sequences to known virus genomes"
        On Error Resume Next
        TestS2 = HTTPRequest2.StatusText
        
        On Error GoTo 0
        If TestS2 <> "OK" Then
            F5T3Executing = 0
            Exit Sub
        End If
        ChunkS = ""
        On Error Resume Next
        ChunkS = HTTPRequest2.ResponseText
        On Error GoTo 0

        WebString = ""
        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                DoEvents
'                Sleep 200
'                If DebuggingFlag < 2 Then On Error Resume Next
'                'ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                On Error GoTo 0
'                WebString = WebString + ChunkS
'                If GenBankFetchStep3 = 1000 Then
'
'                    Form5.Timer3.Enabled = False
'                    F5T3Executing = 0
'                    Exit Sub
'                End If
'            Loop
'
'        End If

        Pos1 = 0
        Pos1 = InStr(1, WebString, "ALIGNMENTS", vbTextCompare)
        'Pos1 = InStr(1, WebString, "READY", vbBinaryCompare)
'        XX = CurDir
'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1
'        If Pos1 = 0 Then
'            Pos1 = InStr(1, WebString, ">NC_", vbTextCompare)
'        End If
'        Open "output2.html" For Output As #1
'        Print #1, WebString
'        Close #1


        If Pos1 = 0 Then
'            XX = CurDir
'            Open "output.html" For Output As #1
'            Print #1, WebString
'            Close #1
            Pos1 = InStr(1, WebString, "Number of sequences better than 1.0e-02: 0", vbBinaryCompare)
            If Pos1 > 0 Then 'let the other process try to search the whole database
                BlastTS = BlastTS + 1
                If BlastTS > 7 Then
                    GenBankFetchStep3 = 1000
                    Timer3.Enabled = False
                    Form1.SSPanel1.Caption = ""
                    Exit Sub
                Else
                    GenBankFetchStep3 = 3
                    
                End If
            End If
            Pos1 = InStr(1, WebString, "Error", vbBinaryCompare)
            If Pos1 > 0 Then 'let the other process try to search the whole database
                
                BlastTS = BlastTS + 1
                If BlastTS > 7 Then
                    GenBankFetchStep3 = 1000
                    Timer3.Enabled = False
                    Form1.SSPanel1.Caption = ""
                    Exit Sub
                Else
                    GenBankFetchStep3 = 3
                    
                End If
               
            End If

            DoEvents
            Sleep 200
            F5T3Executing = 0

            Call Timer3_Timer 'GenBankFetchStep3 = 1000
            Exit Sub

        Else

                GenBankFetchStep = 1000
                GenBankFetchStep2 = 1000
                Form5.Timer4.Enabled = False
                'Form5.Timer2.Enabled = False
                'get list of accession numbers
'                Open "output.html" For Output As #1
'                Print #1, WebString
'                Close #1
                XX = CurDir
                Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
                '>NC_
                If Pos2 = 0 Then
                    Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
                End If

                If Pos2 = 0 Then

                    DoEvents
                    Sleep 200
                    F5T3Executing = 0
                    'Call Timer3_Timer 'GenBankFetchStep3 = 1000
                    Exit Sub
                Else
                    SearchS = ""
                    NumGBs = 0
                    If ReassortmentFlag = 0 Then
                        Do While Pos2 > 0
                            Pos1 = InStr(Pos2 + 3, WebString, " ", vbBinaryCompare)
                            If Pos1 = 0 Then
                                DoEvents
                                Sleep 200
                                F5T3Executing = 0

                                Call Timer3_Timer 'GenBankFetchStep3 = 1000
                                Exit Sub
                            Else
'                                Open "test.txt" For Output As #1
'                                Print #1, WebString
'                                Close #1
                                'DatasetName = Right(AddName, 20)
                                AddName = Mid$(WebString, Pos2 + 1, Pos1 - Pos2 - 1)
'                                Pos = InStr(1, AddName, "</a>", vbBinaryCompare)
'                                If Pos > 0 Then
'                                    Pos2 = InStr(Pos + 1, AddName, ", complete", vbBinaryCompare)
'                                    If Pos2 > 0 Then
'                                        DatasetName = Mid$(AddName, Pos + 5, Pos1 - Pos2 - 5)
'                                    End If
'                                End If
'
                                Pos = InStr(4, AddName, "|", vbBinaryCompare)
                                If Pos > 0 Then
                                    AddName = Right(AddName, Len(AddName) - Pos)
                                End If
                                If Left(AddName, 4) = "ref|" Then
                                    AddName = Mid$(AddName, 5, Len(AddName))
                                End If
                                Pos = 0
                                Pos = InStr(4, AddName, "|", vbBinaryCompare)
                                If Pos > 0 Then
                                    AddName = Left(AddName, Pos - 1)
                                End If
                                If Right(AddName, 1) = "|" Then
                                    AddName = Mid$(AddName, 1, Len(AddName) - 1)
                                End If
                                If SearchS = "" Then
                                    SearchS = AddName
                                    NumGBs = 1
                                    x = x
                                Else
                                    SearchS = SearchS + "," + AddName
                                    NumGBs = NumGBs + 1
                                    x = x
                                End If


                            End If
                            If SearchS <> "" Then
                                Exit Do
                            End If
                            Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
                            If Pos2 = 0 Then
                                Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
                            End If
                        Loop
                        URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
                        RefetchGB = URLS
                        
                        
                        Set HTTPRequest2 = New WinHttp.WinHttpRequest
                        HTTPRequest2.Open "GET", URLS, True
                        HTTPRequest2.SEnd
                        On Error Resume Next
        
                        HTTPRequest2.WaitForResponse
                        ErrorText = ""
                        ErrorText = HTTPRequest2.StatusText
                        
                        On Error GoTo 0
                        If ErrorText <> "OK" Then
                            Timer3.Interval = 5000
                            F5T3Executing = 0
                            Exit Sub
                        End If
                        
                        'Form5.Inet1.Execute URLS, "GET"
                        
                        
                        
'                        XX = App.Path
'                        Open "testURL.txt" For Output As #1
'                        Print #1, URLS
'                        Close #1

                        'Form5.Inet3.Execute URLS, "GET"
                        Form5.Timer3.Interval = 100
                        GenBankFetchStep3 = 9
                    Else
                        'find the virus name
                        Pos1 = InStr(1, WebString, ">NC_", vbBinaryCompare)
                        
'                        XX = CurDir
'                        Open "result.txt" For Output As #3
'                        Print #3, WebString
'                        Close #3
                        If Pos1 = 0 Then '|
                            Pos1 = InStr(1, WebString, "|NC_", vbBinaryCompare)
                        
                        End If
                        
                        If Pos1 > 0 Then
                            Pos2 = InStr(Pos1 + 1, WebString, " ", vbBinaryCompare)
                            If Pos2 > 0 Then
                                Pos1 = InStr(Pos2 + 1, WebString, "virus", vbTextCompare)
                                If Pos1 = 0 Then
                                    Pos1 = InStr(Pos2 + 1, WebString, "phage", vbTextCompare)
                                End If
                                If Pos1 > 0 Then
                                    SearchS = Mid$(WebString, Pos2 + 1, Pos1 + 6 - (Pos2 + 1))
                                Else
                                    GenBankFetchStep3 = 1000
                                    Exit Sub
                                End If
                                SearchS = Trim(SearchS)
                                For x = 1 To Len(SearchS)
                                    If Mid$(SearchS, x, 1) = " " Then
                                        Mid$(SearchS, x, 1) = "+"
                                    End If
                                Next x
                                URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=" + SearchS + "+AND+refseq+AND+txid10239[ORGN]"
                                'RefetchGB = URLS
'                                Open "url.txt" For Output As #1
'                                Print #1, URLS
'                                Close #1
                                'Form5.Inet3.Execute URLS, "GET"
                                
                                
                                
                                
'                                Set HTTPRequest2 = New WinHttp.WinHttpRequest
'                                HTTPRequest2.Open "GET", URLS, True
'                                HTTPRequest2.SEnd
'                                On Error Resume Next
'
'                                HTTPRequest2.WaitForResponse
'                                ErrorText = ""
'                                ErrorText = HTTPRequest2.StatusText
'
'                                On Error GoTo 0
'                                If ErrorText <> "OK" Then
'                                    Timer3.Interval = 5000
'                                    F5T3Executing = 0
'                                    Exit Sub
'                                End If
                                
                                
                                
                                Set HTTPRequest2 = New WinHttp.WinHttpRequest
                                HTTPRequest2.Open "GET", URLS, True
                                HTTPRequest2.SEnd
                                On Error Resume Next

                                HTTPRequest2.WaitForResponse
                                ErrorText = ""
                                ErrorText = HTTPRequest2.StatusText

                                On Error GoTo 0
                                If ErrorText <> "OK" Then
                                    Timer3.Interval = 5000
                                    F5T3Executing = 0
                                    Exit Sub
                                End If

                                Form5.Timer3.Interval = 100
                                GenBankFetchStep3 = 8
                            Else
                                DoEvents
                                Sleep 200
                                F5T3Executing = 0
                                'Call Timer3_Timer 'GenBankFetchStep3 = 1000
                                Exit Sub
                            End If
                        Else
                            DoEvents
                            Sleep 200
                            F5T3Executing = 0
                            'Call Timer3_Timer 'GenBankFetchStep3 = 1000
                            Exit Sub
                        End If


                    End If

                End If



        End If
        'End If
        'End If
    ElseIf GenBankFetchStep3 = 8 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 8"
        Form1.SSPanel1.Caption = "Obtaining a reference genome"
        
        On Error Resume Next
        ErrorText = ""
        ErrorText = HTTPRequest2.StatusText
        
        On Error GoTo 0
        If ErrorText <> "OK" Then
        
            F5T3Executing = 0
            Exit Sub
        End If
        ChunkS = HTTPRequest2.ResponseText
        WebString = ""

        WebString = WebString + ChunkS
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        DoEvents
'        Sleep 500
'        'ChunkS = Form5.Inet3.GetChunk(1024, icString)
'        'On Error GoTo 0
'        If ChunkS = "" Then
'            DoEvents
'            Sleep 200
'            F5T3Executing = 0
'            'Call Timer3_Timer 'GenBankFetchStep3 = 1000
'            Exit Sub
'        Else
'            WebString = ""
'            WebString = WebString + ChunkS
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    DoEvents
'                    Sleep 200
'                    'ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                    WebString = WebString + ChunkS
'                Loop
'
'            End If
'        End If



'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1

        SearchS = ""
        Pos1 = 1
        Do
            Pos1 = InStr(Pos1, WebString, "<Id>", vbTextCompare)
            If Pos1 > 0 Then
                Pos2 = InStr(Pos1 + 1, WebString, "</Id>", vbTextCompare)
                SearchS = SearchS + Mid$(WebString, Pos1 + 4, Pos2 - (Pos1 + 4)) + ","
                x = x
                Pos1 = Pos1 + 1
            Else
                If SearchS <> "" Then
                    SearchS = Left(SearchS, Len(SearchS) - 1)
                End If
                Exit Do
            End If
        Loop
        'XX = Right(SearchS, 20)
        If SearchS <> "" Then
            URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
            RefetchGB = URLS
'            Form5.Inet3.Execute URLS, "GET"

            Set HTTPRequest2 = New WinHttp.WinHttpRequest
            HTTPRequest2.Open "GET", URLS, True
            HTTPRequest2.SEnd
            On Error Resume Next

            HTTPRequest2.WaitForResponse
            ErrorText = ""
            ErrorText = HTTPRequest2.StatusText

            On Error GoTo 0
            If ErrorText <> "OK" Then
                Timer3.Interval = 5000
                F5T3Executing = 0
                Exit Sub
            End If

            'Form5.Inet1.Execute URLS, "GET"
'            Form5.Timer4.Interval = 100
'            GenBankFetchStep = 9

            Form5.Timer3.Interval = 100
            GenBankFetchStep3 = 9
        Else
            GenBankFetchStep3 = 1000
            Exit Sub
        End If
    ElseIf GenBankFetchStep3 = 9 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 9"
        Form1.SSPanel1.Caption = "Identifying gene boundaries"
        'form5.Inet3.
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        DoEvents
'        Sleep 500
        'If Form5.Inet3.ResponseCode = 0 Then
            'If DebuggingFlag < 2 Then On Error Resume Next
            On Error Resume Next
            ErrorText = ""
            ErrorText = HTTPRequest2.StatusText
            
            On Error GoTo 0
            If ErrorText <> "OK" Then
            
                F5T3Executing = 0
                Exit Sub
            End If
            ChunkS = HTTPRequest2.ResponseText
'            Do
'                ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                If ChunkS <> String(1024, " ") Then
'                    Exit Do
'                End If
'                DoEvents
'                Sleep 250
'
'            Loop
'            On Error GoTo 0
            WebString = ""

            WebString = WebString + ChunkS
            If ChunkS > "" Then
                'XX = Len(WebString)
'                If Len(ChunkS) > 0 Then
'                    Do While Len(ChunkS) > 0
'                        ChunkS = TestS
'                        DoEvents
'                        Sleep 200
'                        'XX = Form1.Enabled
'                        'XX = Form1.SSPanel6(0).Enabled
'                        If DebuggingFlag < 2 Then On Error Resume Next
'                        ChunkS = Form5.Inet3.GetChunk(1024, icString)
'                        On Error GoTo 0
'                        WebString = WebString + ChunkS
'                    Loop
'                End If
                DownloadedGBFiles = WebString
'                Form5.Inet3.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                RID = ""
'

                GenBankFetchStep3 = 10
        '        If X = 12345 Then
        '            Open "Output2.html" For Binary As #1
        '            XX = LOF(1)
        '            WebString = String(LOF(1), " ")
        '            Get #1, , WebString
        '            Close #1
        '        End If

            End If
        'End If
        'Form1.SSPanel1.Caption = ""
        'Form1.ProgressBar1 = 0


    End If

    If GenBankFetchStep3 = 10 And ModSeqNumFlag = 0 Then
        OV = SilentGBFlag
        SilentGBFlag = 1
        WebString = DownloadedGBFiles
        'split the returned file up into individual genbank files and extract gene coords etc
        Pos1 = 1
        Pos2 = 0
        Dim tGeneList() As GenomeFeatureDefine, tGeneNumber As Long, UBGN As Long, NumberHits As Long
        ReDim tGeneList(100)
        tGeneNumber = 0
        UBGN = 100
        NumberHits = 0
'                        XX = CurDir
'                Open "output.html" For Output As #1
'                Print #1, WebString
'                Close #1
'        SS = abs(gettickcount)
        CurSegment = 0
        ReDim GeneLabel(100)
        AllowDoEvensFlag = 1
        Do
            Pos2 = InStr(Pos1, WebString, "//" + Trim(Chr(10)), vbBinaryCompare)
            If Pos2 = 0 Then
                Pos2 = InStr(Pos1, WebString, "//" + Trim(Chr(13)), vbBinaryCompare)
                If Pos2 = 0 Then
                    Pos2 = Len(WebString) - 2
                End If
            End If
            Dim tWebString As String
            If Pos2 > 0 Then
                tWebString = Mid$(WebString, Pos1, Pos2 - (Pos1 - 2))
               ' XX = Right$(tWebString, 20)
                NumberHits = NumberHits + 1
'                        If NumberHits = 5 Then
'                            X = X
'                        End If
                CurSegment = CurSegment + 1

                If Resetload = 1 Then
                    Exit Sub
                End If
                Call LoadGenBank(tWebString)
                

                If AbortflagGB = 1 Then
                    If ReassortmentFlag = 1 Then
                        GenBankFetchStep3 = 8
                    Else
                        GenBankFetchStep3 = 9
                    End If
                    AbortflagGB = 0
                    URLS = RefetchGB
                   ' XX = App.Path
'                    Open "testURL.txt" For Output As #1
'                    Print #1, URLS
'                    Close #1
                    Timer3.Enabled = False
                    Timer3.Interval = 100
                    'Form5.Inet3.Execute URLS, "GET"
                    Form5.Timer3.Enabled = True
                    F5T3Executing = 0
                    Exit Sub

                Else
                    For x = 1 To GeneNumber
                        tGeneNumber = tGeneNumber + 1
                        If tGeneNumber > UBGN Then
                            UBGN = UBGN + 100
                            ReDim Preserve tGeneList(UBGN)
                        End If
                        tGeneList(tGeneNumber) = GeneList(x)
                        If tGeneNumber > UBound(GeneLabel, 1) Then
                            ReDim Preserve GeneLabel(UBound(GeneLabel, 1) + 100)
                        End If
                        GeneLabel(tGeneNumber) = CurSegment
                    Next x

                End If

'                 XX = GeneList(28).StartInAlign
'                 XX = GeneList(28).EndInAlign
'                 XX = tGeneList(28).StartInAlign
'                 XX = tGeneList(28).EndInAlign


'                XX = GeneNUmber
'                XX = GeneList(GeneNUmber).StartInAlign '1
'                XX = GeneList(GeneNUmber).EndInAlign '9292
                'xx=GeneList(GeneNUmber).
                'save all the ORFs etc extracted
            Else
                Exit Do
            End If
            Pos1 = Pos2 + 1
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'This forces a singlee loop
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'NumberHits = 1
            If ReassortmentFlag = 0 Then
                Exit Do
            Else
                Form1.SSPanel1.Caption = "Loaded gene data for " + Trim(Str(NumberHits)) + " segments"
            End If
        Loop
        AllowDoEvensFlag = 0

'        If X = X Then
            If ReassortmentFlag = 1 Then
                Dim MatchNum() As Long
                ReDim MatchNum(tGeneNumber)
                x = 0
                For x = 1 To tGeneNumber

                    If RemoveSegment(GeneLabel(x)) = 1 Then
                        MatchNum(x) = -1
                    End If

                Next x
                GeneNumber = 0
                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
                For x = 1 To tGeneNumber
                    If MatchNum(x) > -1 Then
                        GeneNumber = GeneNumber + 1
                        GeneList(GeneNumber) = tGeneList(x)
                    End If
                Next x
                tGeneNumber = GeneNumber
                For x = 1 To tGeneNumber
                    tGeneList(x) = GeneList(x)
                Next x
                ReDim MatchNum(tGeneNumber)
            End If
            GeneNumber = 0
            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
            For x = 1 To tGeneNumber
                If tGeneList(x).StartInAlign > 0 Or tGeneList(x).EndInAlign > 0 Then
                    GeneNumber = GeneNumber + 1
                    GeneList(GeneNumber) = tGeneList(x)
                End If
            Next x


            'this gets rid of duplicate segments in segemnted genomes
            'that have multiple associated genbank files

'        Else
'
'            If ReassortmentFlag = 1 Then NumberHits = 1
'
'            Call CheckGenes(tGeneList(), tGeneNumber)
'
'
'            Dim MatchMatrix() As Integer
'
'            ReDim MatchMatrix(tGeneNumber, tGeneNumber), MatchNum(tGeneNumber)
'
'            'this gets rid of duplicate segments in segemnted genomes
'            'that have multiple associated genbank files
'            If ReassortmentFlag = 1 Then
'                X = 0
'                For X = 1 To tGeneNumber
'
'                    If RemoveSegment(GeneLabel(X)) = 1 Then
'                        MatchNum(X) = -1
'                    End If
'
'                Next X
'                GeneNumber = 0
'                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'                For X = 1 To tGeneNumber
'                    If MatchNum(X) > -1 Then
'                        GeneNumber = GeneNumber + 1
'                        GeneList(GeneNumber) = tGeneList(X)
'                    End If
'                Next X
'                tGeneNumber = GeneNumber
'                For X = 1 To tGeneNumber
'                    tGeneList(X) = GeneList(X)
'                Next X
'                ReDim MatchNum(tGeneNumber)
'            End If
'
'            'Find consensus ORFS, Features and Names
'
'    '        For X = 0 To tGeneNumber
'    '            MatchNum(X) = 0
'    '        Next X
'            Dim TotE As Long, TotS As Long, LenFrag As Long, TotF As Long, GoOn As Long
'
'            SSS = abs(gettickcount)
'
'            For X = 1 To tGeneNumber - 1
'                'XX = tGeneList(X).Orientation
'    '             If X = 42 Then
'    '                    X = X
'    '                End If
'                If tGeneList(X).Orientation = 1 Then
'                    If tGeneList(X).StartInAlign > tGeneList(X).EndInAlign Then
'
'                        tGeneList(X).EndInAlign = tGeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'    '                XX = tGeneList(X).Name
'    '                XX = tGeneList(X).Product
'                    LenFrag = tGeneList(X).EndInAlign - tGeneList(X).StartInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        XX = Right(tGeneList(Y).Product, 10)
'                        GoOn = 0
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If tGeneList(X).IntronFlag = tGeneList(Y).IntronFlag Then
'                                If tGeneList(X).ExonNumber = tGeneList(Y).ExonNumber Then
'                                    If (Right(tGeneList(X).Product, 1) <> "*" And Right(tGeneList(Y).Product, 1) <> "*") Then
'                                        GoOn = 1
'                                    ElseIf (Right(tGeneList(X).Product, 1) = "*" And Right(tGeneList(Y).Product, 1) = "*") Then
'                                        GoOn = 1
'                                    End If
'                                End If
'                            End If
'                        End If
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation And GoOn = 1 Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).StartInAlign > tGeneList(Y).EndInAlign Then
'                                    tGeneList(Y).EndInAlign = tGeneList(Y).EndInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                ElseIf tGeneList(X).Orientation = 2 Then
'
'                    If tGeneList(X).EndInAlign > tGeneList(X).StartInAlign Then
'
'                        tGeneList(X).StartInAlign = tGeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'
'                    LenFrag = tGeneList(X).StartInAlign - tGeneList(X).EndInAlign
'                    LenFrag = CLng(LenFrag * 0.1)
'
'                    For Y = X + 1 To tGeneNumber
'                        If tGeneList(X).Orientation = tGeneList(Y).Orientation Then
'                            If Abs(tGeneList(X).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
'                                If tGeneList(Y).EndInAlign > tGeneList(Y).StartInAlign Then
'                                    tGeneList(Y).StartInAlign = tGeneList(Y).StartInAlign + Len(StrainSeq(0))
'                                End If
'                                If Abs(tGeneList(X).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
'                                    MatchMatrix(X, Y) = 1
'                                    MatchMatrix(Y, X) = 1
'                                    MatchNum(X) = MatchNum(X) + 1
'                                    MatchNum(Y) = MatchNum(Y) + 1
'                                End If
'                            End If
'                        End If
'                    Next Y
'                End If
'            Next X
'
'            'get rid on non-matchers (less that 2 matches) that overlap matchers
'            If NumberHits < 5 Then
'                threshold = 0
'            Else
'                threshold = 1
'            End If
'            X = 1
'
'            Do While X <= tGeneNumber
'                If MatchNum(X) < threshold Then
'                   MatchNum(X) = -1
'
'
'                End If
'                X = X + 1
'            Loop
'
'
'            'Find median start and end positions for repeats and get rid of repeats (but store data on names if necessary)
'            If NumberHits > 1 Then
'                For X = 1 To tGeneNumber - 1
'
'                    If MatchNum(X) >= threshold Then
'                        TotS = tGeneList(X).StartInAlign
'                        TotE = tGeneList(X).EndInAlign
'                        TotF = tGeneList(X).Frame
'                        For Y = X + 1 To tGeneNumber
'                            If MatchNum(Y) >= threshold Then
'                                If MatchMatrix(X, Y) = 1 Then
'                                    TotS = TotS + tGeneList(Y).StartInAlign
'                                    TotE = TotE + tGeneList(Y).EndInAlign
'                                    TotF = TotF + tGeneList(Y).Frame
'                                    If Len(tGeneList(X).Name) < Len(tGeneList(Y).Name) Then tGeneList(X).Name = tGeneList(Y).Name
'                                    If Len(tGeneList(X).Product) < Len(tGeneList(Y).Product) Then tGeneList(X).Product = tGeneList(Y).Product
'                                    'At some point I may have to deal with conflicts in introns and orientation here
'                                    MatchNum(Y) = -1
'                                End If
'                            End If
'                        Next Y
'                        tGeneList(X).StartInAlign = (CLng(TotS / (MatchNum(X) + 1)))
'                        tGeneList(X).EndInAlign = (CLng(TotE / (MatchNum(X) + 1)))
'                        If tGeneList(X).Orientation = 1 Then
'                            If tGeneList(X).EndInAlign > Len(StrainSeq(0)) Then tGeneList(X).EndInAlign = tGeneList(X).EndInAlign - Len(StrainSeq(0))
'
'                        ElseIf tGeneList(X).Orientation = 2 Then
'                            If tGeneList(X).StartInAlign > Len(StrainSeq(0)) Then tGeneList(X).StartInAlign = tGeneList(X).StartInAlign - Len(StrainSeq(0))
'                        End If
'                        tGeneList(X).Frame = CLng(TotF / (MatchNum(X) + 1))
'                        X = X
'                    Else
'                        X = X
'                    End If
'                Next X
'            End If
'
'
'
'
'            'copy over ones with matchnums>0 to genelist
'            GeneNumber = 0
'            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
'            For X = 1 To tGeneNumber
'                If MatchNum(X) >= threshold Then
'                    GeneNumber = GeneNumber + 1
'                    GeneList(GeneNumber) = tGeneList(X)
'                Else
'                    X = X
'                End If
'            Next X
'            'GeneNUmber = 0
'
'
'            SilentGBFlag = OV
'
'            For X = 0 To GeneNumber
'                If GeneList(X).Orientation = 1 Then
'                    If GeneList(X).StartInAlign > GeneList(X).EndInAlign Then
'                        GeneList(X).EndInAlign = GeneList(X).EndInAlign + Len(StrainSeq(0))
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    If GeneList(X).EndInAlign > GeneList(X).StartInAlign Then
'                        GeneList(X).StartInAlign = GeneList(X).StartInAlign + Len(StrainSeq(0))
'                    End If
'                End If
'            Next X
'
'            For X = 1 To GeneNumber
'    '            If X = 28 Then
'    '                X = X
'    '            End If
'    '            If GeneList(X).Start = 6919 Or GeneList(X).End = 6919 Then
'    '                X = X
'    '            End If
'                If GeneList(X).Orientation = 1 Then
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign <= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign >= GeneList(Y).EndInAlign And GeneList(X).StartInAlign <= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then ' genelist(y).orientation must be 2
'                                If GeneList(X).StartInAlign <= GeneList(Y).EndInAlign Then
'                                    If GeneList(X).EndInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    ElseIf GeneList(X).EndInAlign >= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                 ElseIf (GeneList(X).EndInAlign >= GeneList(Y).StartInAlign And GeneList(X).StartInAlign <= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                    If GeneList(Y).Frame = GeneList(X).Frame Then
'                                        GeneList(Y).Frame = GeneList(X).Frame + 1
'                                        If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                    End If
'                                End If
'                            End If
'                        Next Y
'                    End If
'                ElseIf GeneList(X).Orientation = 2 Then
'                    'XX = Right(GeneList(X).Product, 10)
'                    If Right(GeneList(X).Product, 1) <> "*" Then
'                        For Y = 1 To GeneNumber
'
'                            If X <> Y And GeneList(X).Orientation = GeneList(Y).Orientation Then
'                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            GeneList(Y).Frame = GeneList(X).Frame
'                                        End If
'                                    End If
'                                Else
'                                    If GeneList(X).StartInAlign >= GeneList(Y).StartInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).EndInAlign And GeneList(X).StartInAlign >= GeneList(Y).EndInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'                                End If
'                            ElseIf X <> Y Then
'                                'XX = GeneList(Y).Orientation - should always be 1
'                                    If GeneList(X).StartInAlign >= GeneList(Y).EndInAlign Then
'                                        If GeneList(X).EndInAlign <= GeneList(Y).StartInAlign Then
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        ElseIf GeneList(X).EndInAlign <= GeneList(Y).EndInAlign Then ' i.e partial overlap
'                                            If GeneList(Y).Frame = GeneList(X).Frame Then
'                                                GeneList(Y).Frame = GeneList(X).Frame + 1
'                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                            End If
'                                        End If
'                                     ElseIf (GeneList(X).EndInAlign <= GeneList(Y).StartInAlign And GeneList(X).StartInAlign >= GeneList(Y).StartInAlign) Then 'partial overlaps
'                                        If GeneList(Y).Frame = GeneList(X).Frame Then
'                                            GeneList(Y).Frame = GeneList(X).Frame + 1
'                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
'                                        End If
'                                    End If
'    '                            Else
'    '
'    '                            End If
'                            End If
'                        Next Y
'                    End If
'                End If
'            Next X
'
'        End If

        'restore the ends
        For x = 1 To GeneNumber
            If GeneList(x).Orientation = 1 Then
                If GeneList(x).EndInAlign > Len(StrainSeq(0)) Then
                    GeneList(x).EndInAlign = GeneList(x).EndInAlign - Len(StrainSeq(0))
                End If
            ElseIf GeneList(x).Orientation = 2 Then
                If GeneList(x).StartInAlign > Len(StrainSeq(0)) Then
                    GeneList(x).StartInAlign = GeneList(x).StartInAlign - Len(StrainSeq(0))
                End If

            End If
        Next x




        'make sure genes besides/overlapping one another are in different "Frames"

        'XX = GeneNumber
       ' Call CheckGenes(GeneList(), GeneNumber)
        If GeneNumber > 0 Then

            ORFFlag = 1

            Call DrawORFs
            Form1.Picture20.Height = Form1.Picture4.ScaleHeight + 3
            Form1.Picture20.BackColor = Form1.Picture7.BackColor

            'If RunFlag = 1 Then
            If RelX > 0 Or RelY > 0 Then
                If XoverList(RelX, RelY).ProgramFlag = 0 Or XoverList(RelX, RelY).ProgramFlag = 0 + AddNum Then
'                            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'                            Form1.Picture7.Height = Form1.Picture7.Height - (Form1.Picture20.ScaleHeight + 5)
                    Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
                    Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5


                End If

                'End If

                Form1.Picture20.Visible = True
            End If
            Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
            'Call ResizeForm1
        End If
        
        Call FillGeneSEPos

        'X = X

        EEE = Abs(GetTickCount)
        TT = EEE - SSS '1219 for ~2000 sequences


        Form1.Picture4.ScaleMode = 3
        Form1.Picture4.DrawMode = 13
        Form1.Picture11.ScaleMode = 3
        Form1.Picture19.DrawMode = 13
        DontDoH1Inc = 1
        OnlyDoPositionIndicator = 1
        OnlyDoPosBar = 1

        If Form1.HScroll1.Max > 0 Then
            If Form1.HScroll1.Value > Form1.HScroll1.Min Then
                DontDoH1Inc = 1
                H1C = 1
                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
                DontDoH1Inc = 0
                H1C = 0
                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
            Else
                If Form1.HScroll1.Value < Form1.HScroll1.Max Then
                    DontDoH1Inc = 1
                    H1C = 1
                    Form1.HScroll1.Value = Form1.HScroll1.Value + 1
                    DontDoH1Inc = 0
                    H1C = 0
                    Form1.HScroll1.Value = Form1.HScroll1.Value - 1
                End If
            End If
        Else
            Dim OI As Long, oD As Long
            OI = Form1.Timer3.Interval
            oD = Form1.Timer3.Enabled
            Form1.Timer3.Enabled = False
            Form1.Timer3.Interval = 27
            Form1.Timer3.Enabled = True
            DoEvents
            Sleep 30
            DoEvents
            Form1.Timer3.Enabled = oD
            Form1.Timer3.Interval = OI
        End If
        OnlyDoPositionIndicator = 0
        OnlyDoPosBar = 0
        DontDoH1Inc = 0

        GenBankFetchStep3 = 1000
        EE = Abs(GetTickCount)
        TT = EE - StartFetch '468360 - 1 million nts restriction'25875,fail, 44563, 52578; 100000 nt restriction'50000 fail,342859,fail,40313
        '1000000 no virus restriction
        '559657
        '0.00001 - 197500
        x = x

    End If
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    'If Left(Form1.SSPanel1.Caption, 16) = "Loaded gene data" Then
        Form1.SSPanel1.Caption = ""
    'End If
    F5T3Executing = 0
    
    Exit Sub
CrashExit:

Form1.SSPanel1.Caption = ""
Exit Sub

End Sub

Private Sub Timer4_Timer()
'Exit Sub
    
    If NextNo <= 0 Then Exit Sub
    If GenBankFetchStep = 1000 Then Exit Sub
    If LoadBusy <> 0 Then Exit Sub
    If Len(StrainSeq(0)) <> Decompress(Len(StrainSeq(0))) Then Exit Sub
    If (CLine <> "" And CLine <> " ") Then Exit Sub
    If AutoMultFlag > 0 Then Exit Sub
    
    If NextNo = 0 Then Exit Sub
    If DoingShellFlag > 0 Then Exit Sub
    If CurrentlyRunningFlag <> 0 Then Exit Sub
    If SchemDownFlag <> 0 Then Exit Sub
    If F5T1Executing = 1 Then Exit Sub
    F5T1Executing = 1
   ' Exit Sub
    Dim ServerBFlag As Long, ServerS As String
    Dim ServerB As String, NumGBs As Long, AddName As String, URLS As String, SearchS As String, WebString As String, Pos1 As Long, Pos2 As Long, RTOE As String, Target As String, LenRange As String
    Dim ChunkS As String, TestS As String
    If GenBankFetchStep = 1000 Then
        Form5.Timer4.Enabled = False
    End If
    'Form5.Inet1.AccessType = icUseDefault
    If GenBankFetchStep = 0 Then
        GenBankFetchStep = 3
        
    End If
    
'    Dim HTTPRequest As WinHttp.WinHttpRequest
'
'    Set HTTPRequest = New WinHttp.WinHttpRequest
'    With HTTPRequest
'        .Open "GET", "http://tycho.usno.navy.mil/cgi-bin/timer.pl", True
'        .SEnd
'        If .WaitForResponse(3) Then
'            MsgBox .ResponseText
'        Else
'            MsgBox "Timed out after 3 seconds."
'        End If
'    End With
'    Set HTTPRequest = Nothing
    ServerBFlag = 1
    'https://blast.ncbi.nlm.nih.gov/Blast.cgi?
    ServerS = "https://blast.ncbi.nlm.nih.gov/Blast.cgi?"
    ServerB = "http://bio.chpc.ac.za/blast/blast.cgi?"
    'alternative servers
    'ServerS = "http://bio.chpc.ac.za/blast/blast_cs.cgi?"
    'ServerS = "https://137.158.204.6/blast/blast.cgi?" 'ebiokit-01.cbio.uct.ac.za
    'ServerS = "http://129.85.245.250/Blast_cs.cgi?"
    If GenBankFetchStep = 0 Then
        
        'First flush all previous RIDs
        If RID <> "" Then
            'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
            RID = ""
            GenBankFetchStep = 0
       Else
            'Form5.Inet1.Execute (ServerS + "CMD=DisplayRIDs")
            GenBankFetchStep = 3
       End If
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'            Loop
'
'        End If
'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1
'        X = X
    ElseIf GenBankFetchStep = 1 Then
        'If Form5.Inet1.StillExecuting = False Then
            GenBankFetchStep = 2
        'End If
'    ElseIf GenBankFetchStep = 2 Then
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        WebString = ""
'        WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'            Loop
'
'        End If
''        Open "output.html" For Output As #1
''        Print #1, WebString
''        Close #1
'        X = X
'        GenBankFetchStep = 3
    ElseIf GenBankFetchStep = 3 Then
        Form1.SSPanel1.Caption = "GenBankFetchStep = 3"
        Form1.SSPanel1.Caption = "Checking for internet connection"
        'SearchS = Left(StrainSeq(0), 200)
        Dim MaxQL As Long
        
        If ReassortmentFlag = 0 Then
            If SearchWholeDBFlag = 0 Then
                If ORFRefNum > 5 Then ORFRefNum = 5
                SearchS = String(200 * (ORFRefNum + 1), " ")
            Else
                SearchS = String(1200, " ")
            End If
        Else
        
            ORFRefNum = RBPNum - 1
            MaxQL = 1400 / (RBPNum)
            SearchS = String(MaxQL * (ORFRefNum + 1), " ")
        End If
        
        Y = 0
        
        'find most conserved 100nts
        
        Dim MaxBkg As Single, MaxBkgPos As Long, PosXWin As Long
        
'        MaxBkg = -100
'        For X = 1 To Len(StrainSeq(0))
'            If BkgIdentity(X) > MaxBkg Then
'                MaxBkg = BkgIdentity(X)
'                MaxBkgPos = X
'            End If
'        Next X
'
'        MaxBkgPos = MaxBkgPos - 100
'        If MaxBkgPos < 1 Then MaxBkgPos = 1
'
'        If LSeq > 100 Then
'            If MaxBkgPos + 100 > LSeq Then
'                MaxBkgPos = LSeq - 100
'            End If
'
'        End If
        
        'Mid$(SearchS, 1, 3) = ">A" + Chr(10)
        MaxBkgPos = 1
        Dim ReadSize As Long
        If SearchWholeDBFlag = 1 Then
            ORFRefNum = 0
            rxl = 1200
        Else
            rxl = 1200
        End If
        
        If ReassortmentFlag = 0 Then
            If Len(StrainSeq(0)) > (ORFRefNum + 1) * 200 Then
                If SearchWholeDBFlag = 0 Then
                    ReadSize = 200
                Else
                    ReadSize = 1200
                End If
            Else
                If SearchWholeDBFlag = 0 Then
                    ReadSize = CLng(Len(StrainSeq(0)) / (ORFRefNum + 1))
                Else
                    ReadSize = 1200
                End If
            End If
            If ReadSize > Len(StrainSeq(0)) Then
                ReadSize = Len(StrainSeq(0))
            End If
            On Error Resume Next
            ubol = -1
            ubol = UBound(ORFRefList)
            
            On Error GoTo 0
            'If ReadSize > CLng(Len(StrainSeq(0))) Then ReadSize = Len(StrainSeq(0)) - 1
            If ubol > -1 Then
                For Z = 0 To ORFRefNum
                    For x = MaxBkgPos To Len(StrainSeq(0))
                        If Mid(StrainSeq(ORFRefList(Z)), x, 1) <> "-" Then '576,0,767,787,26
                            Y = Y + 1
                            Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(Z)), x, 1)
                            If Y = ReadSize * (Z + 1) Then
                                MaxBkgPos = MaxBkgPos + 200
                                Exit For
                            End If
                        End If
                    Next x
                Next Z
            End If
            
        Else
            For Z = 1 To RBPNum - 1
                'XX = UBound(RBPPos, 1)
                For x = RBPPos(Z) To RBPPos(Z + 1)
                    If Mid(StrainSeq(ORFRefList(0)), x, 1) <> "-" Then '576,0,767,787,26
                        Y = Y + 1
                        If Y <= Len(SearchS) Then
                        
                            Mid(SearchS, Y, 1) = Mid(StrainSeq(ORFRefList(0)), x, 1)
                        End If
                        If Y = (MaxQL * (Z + 1)) Then
                            MaxBkgPos = MaxBkgPos + 200
                            Exit For
                        End If
                    End If
                Next x
            Next Z
        End If
        XX = Len(SearchS)
        Dim DBSpec As String
        If SearchWholeDBFlag = 0 Then
            
            'older version that stopped working
            'DBSpec = "&DATABASE=ref_viruses_rep_genomes"
            'newer version
            'DBSpec = "&DATABASE=ncbi.refseq.viral.genomes"
            'ref_viruses_rep_genomes
            'newest version
            DBSpec = "&DATABASE=ref_viruses_rep_genomes"
        ElseIf SearchWholeDBFlag = 1 Then
            DBSpec = "&DATABASE=refseq_representative_genomes"
            'DBSpec = "&DATABASE=ref_viruses_rep_genomes"
            'ref_viruses_rep_genomes
        End If
        XX = Len(SearchS)
        'XX = Mid$(SearchS, 395, 20)
        SearchS = Trim(SearchS) ': XX = Len(SearchS)
        '1000:2000[slen]
        'find the umber of gaps
        Dim NumGaps As Long
        NumGaps = 0
        On Error Resume Next
        UBSN = -1
        UBSN = UBound(SeqNum)
        On Error GoTo 0
        If UBSN = -1 Then Exit Sub
        For x = 0 To Len(StrainSeq(0))
            If SeqNum(x, 0) = 46 Then NumGaps = NumGaps + 1
        Next x
        'XX = Len(SearchS)
        If x = x Then ' new syntax
        LenRange = "&EQ_MENU=viruses+(taxid:10239)"
        Else 'old syntax
            LenRange = "&ENTREZ_QUERY="
            If ReassortmentFlag = 0 Then
                
                LenRange = LenRange + Trim(Str(CLng((Len(StrainSeq(0)) - NumGaps) * 0.9))) + ":100000[slen]"
                
                
                LenRange = LenRange + " AND txid10239[ORGN]"
            Else
                LenRange = LenRange + "txid10239[ORGN]"
            End If
        End If
        'LenRange = "srcdb_refseq[prop] "
        'This is the best one yet
        
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        
        
        
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        
        'This is the next best one
        'LenRange = LenRange + "txid10239[ORGN]"
       ' URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=txid10239[ORGN]&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without length restrict: 43844, fail, 54047, fail
        x = x
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without taxon restrict: 43187,995436, 434000, 150781, 250797
        
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'without taxon or length restrict: 644984, 368891
        
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'Best time = 64781, 184938, 132203, 66968, 28812, 49329, 175688, 23094, 23531, 33688
        
        'URLS = ServerS + "QUERY=" + SearchS + "&DATABASE=refseq_representative_genomes&PROGRAM=blastn&FILTER=L&EXPECT=0.00000001" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        'Best time = 197500, 31156
        'XX = Len(SearchS)
        If ReassortmentFlag = 0 Then
            URLS = ServerS + "QUERY=" + SearchS + DBSpec + "&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        Else
            URLS = ServerS + "QUERY=" + SearchS + DBSpec + "&PROGRAM=blastn&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        End If
        '(megablast) Best time = 19953(EXPECT=0.00000001), 19797, 21500(EXPECT=0.01)
        '47406
        
        'CHPC seqrch
'        URLS = ServerB + "QUERY=" + SearchS + "&DATABASE=Representative_Genomes&PROGRAM=blastn&&MEGABLAST=true&FILTER=L&EXPECT=0.01" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
'
'
        
'        XX = CurDir
'''
'        Open "testurl.txt" For Output As #1
'            Print #1, URLS
'        Close #1
        'URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=EU628620.1&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=5&CMD=Put"
        x = x
        

        'Normal blast
        

'        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"
x = x
'        URLS = "https://www.ncbi.nlm.nih.gov/blast/Blast.cgi?QUERY=" + SearchS + "&DATABASE=nr&PROGRAM=blastn&FILTER=L&EXPECT=0.01&ENTREZ_QUERY=" + LenRange + "&FORMAT_TYPE=Text&NCBI_GI=on&HITLIST_SIZE=20&CMD=Put"

        'alternative servers
       



'        Open "url.txt" For Output As #1
'        Print #1, URLS
'        Close #1
'        XX = CurDir




        Dim ErrorText As String
        Set HTTPRequest = New WinHttp.WinHttpRequest
        HTTPRequest.Open "GET", URLS, True
        HTTPRequest.SEnd
        On Error GoTo CrashExit
        
        HTTPRequest.WaitForResponse
        ErrorText = ""
        ErrorText = HTTPRequest.StatusText
        
        On Error GoTo 0
        If ErrorText <> "OK" Then
            Timer4.Interval = 5000
            F5T1Executing = 0
            Form1.SSPanel1.Caption = ""
            Exit Sub
        End If
        
       ' X = X
        
'                Open "response.txt" For Output As #1
'        Print #1, XX
'        Close #1
       ' XX = CurDir
        
       ' X = X
'        Form5.Inet1.UserName = "darrenpatrickmartin@gmail.com"
'        Form5.Inet1.Execute URLS ', "GET"
        
        GenBankFetchStep = 5
     ElseIf GenBankFetchStep = 4 Then
        'If Form5.Inet1.StillExecuting = False Then
            GenBankFetchStep = 5
        'End If
     ElseIf GenBankFetchStep = 5 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 5"
        Form1.SSPanel1.Caption = "Comparing sequences to known virus genomes"
        On Error Resume Next
        Dim TestS2 As String
        'DoEvents
        TestS2 = HTTPRequest.StatusText
        On Error GoTo 0
        If TestS2 <> "OK" Then
            GenBankFetchStep = 0
            F5T1Executing = 0
            Exit Sub
        Else
            Timer4.Interval = 100
        End If
        
        ChunkS = String(1024, " ")
        TestS = ChunkS
        If DebuggingFlag < 2 Then On Error Resume Next
        ChunkS = HTTPRequest.ResponseText
        'ChunkS = Form5.Inet1.GetChunk(1024, icString)
        WebString = ""
        On Error GoTo 0
        WebString = WebString + ChunkS
        If ChunkS = String(1024, " ") Or ChunkS = "" Then
            F5T1Executing = 0
            GenBankFetchStep = 5
            Exit Sub
        Else
        
        'XX = Form5.Inet1.ResponseInfo
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    'If DebuggingFlag < 2 Then On Error Resume Next
'                    ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                    'On Error GoTo 0
'                    WebString = WebString + ChunkS
'                    If GenBankFetchStep = 1000 Then
'
'                        Form5.Timer4.Enabled = False
'                        Exit Sub
'                    End If
'                Loop
'
'            End If
'            Open "output.html" For Output As #1
'            Print #1, WebString
'            Close #1
    'XX = CurDir
            Pos1 = InStr(1, WebString, "RID", vbTextCompare)
            
            If Pos1 > 0 Then
'                If RID <> "" Then
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
'                End If
                RID = Trim(Mid(WebString, Pos1 + 6, 11))
                If Left(RID, 9) <> "equest ID" Then
'                    Open "outputurl.txt" For Output As #1
'                    Print #1, ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get"
'                    Close #1
                    
                    'On Error Resume Next
                    Set HTTPRequest = New WinHttp.WinHttpRequest
                    HTTPRequest.Open "GET", ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get", True
                    HTTPRequest.SEnd
                    On Error Resume Next
        
                    HTTPRequest.WaitForResponse
                    ErrorText = ""
                    ErrorText = HTTPRequest.StatusText
                    
                    On Error GoTo 0
                    If ErrorText <> "OK" Then
                        Timer4.Interval = 5000
                        F5T1Executing = 0
                        Exit Sub
                    End If
                    'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
                    'On Error GoTo 0
                    GenBankFetchStep = 7
                Else
                    
'                    Open "output.html" For Output As #1
'                    Print #1, WebString
'                    Close #1
                    RID = ""
                    If RID <> "" Then
                        'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
                        RID = ""
                    End If
                    GenBankFetchStep = 3
                End If
            Else
                If RID <> "" Then
                    'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
                    RID = ""
                End If
                GenBankFetchStep = 3
            End If
        End If
    ElseIf GenBankFetchStep = 6 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 6"
        Form1.SSPanel1.Caption = "Comparing sequences to known virus genomes"
    
        'If Form5.Inet1.StillExecuting = False Then
            GenBankFetchStep = 7
        'End If
    ElseIf GenBankFetchStep = 7 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 7"
        Form1.SSPanel1.Caption = "Comparing sequences to known virus genomes"
        'If DebuggingFlag < 2 Then On Error Resume Next
        'ChunkS = Form5.Inet1.GetChunk(1024, icString)
        DoEvents
        On Error Resume Next
        TestS2 = HTTPRequest.StatusText
        On Error GoTo 0
        If TestS2 <> "OK" Then
            GenBankFetchStep = 0
            F5T1Executing = 0
            Exit Sub
        End If
        
        'DoEvents
        ChunkS = ""
        On Error Resume Next
        ChunkS = HTTPRequest.ResponseText
        On Error GoTo 0
        If ChunkS = "" Then
            'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
            GenBankFetchStep = 7
            F5T1Executing = 0
            Exit Sub
        Else
            WebString = ""
            WebString = WebString + ChunkS
'        If ChunkS <> TestS And Len(ChunkS) > 0 Then
'            Do While Len(ChunkS) > 0
'                ChunkS = TestS
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                WebString = WebString + ChunkS
'                If GenBankFetchStep = 1000 Then
'
'                    Form5.Timer4.Enabled = False
'                    Exit Sub
'                End If
'            Loop
'
'        End If
            
        Pos1 = 0
        Pos1 = InStr(1, WebString, "ALIGNMENTS", vbBinaryCompare)
        'Pos1 = InStr(1, WebString, "READY", vbBinaryCompare)
        'XX = CurDir
'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1
        
        If Pos1 = 0 Then
            Pos1 = InStr(1, WebString, "transitional", vbBinaryCompare)
            If Pos1 > 0 Then
                Set HTTPRequest = New WinHttp.WinHttpRequest
                HTTPRequest.Open "GET", ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get", True
                HTTPRequest.SEnd
                
                On Error Resume Next
        
                HTTPRequest.WaitForResponse
                ErrorText = ""
                ErrorText = HTTPRequest.StatusText
                
                On Error GoTo 0
                If ErrorText <> "OK" Then
                    Timer4.Interval = 5000
                    
                Else
                    Timer4.Interval = 2000
                End If
                T4TransCount = T4TransCount + 1
                If T4TransCount > 30 Then
                    If SearchWholeDBFlag = 0 Then
                        GenBankFetchStep = 3
                        SearchWholeDBFlag = 1
                        F5T1Executing = 0
                        T4TransCount = 0
                        Exit Sub
                    Else
                        GenBankFetchStep = 1000
                        Timer4.Enabled = False
                        Form1.SSPanel1.Caption = ""
                        Exit Sub
                    End If
                End If
                GenBankFetchStep = 7
                F5T1Executing = 0
                If ORFFlag = 1 And GenBankFetchStep3 = 1000 Then
                    GenBankFetchStep = 1000
                    Timer4.Enabled = False
                End If
                Exit Sub
            Else
                Pos1 = InStr(1, WebString, "No significant similarity found", vbBinaryCompare)
                If Pos1 > 0 Then 'go back and search the whole database
                    If SearchWholeDBFlag = 0 Then
                        GenBankFetchStep = 3
                        SearchWholeDBFlag = 1
                        F5T1Executing = 0
                        T4TransCount = 0
                        Exit Sub
                    Else
                        GenBankFetchStep = 1000
                        Timer4.Enabled = False
                        Form1.SSPanel1.Caption = ""
                        Exit Sub
                    End If
                Else
                    Pos1 = InStr(1, WebString, "An error has occurred", vbBinaryCompare)
                    If Pos1 > 0 Then 'go back and search the whole database
                        GenBankFetchStep = 1000
                        Timer4.Enabled = False
                        Form1.SSPanel1.Caption = ""
                        Exit Sub
                    End If
                End If
                
            End If
        End If
        If Pos1 = 0 Then
            
            
            'XX = CurDir
'            Open "output.html" For Output As #1
'            Print #1, WebString
'            Close #1
            Pos1 = InStr(1, WebString, "Error: Results for RID", vbBinaryCompare)
            If Pos1 > 0 Then
                GenBankFetchStep = 3
                'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
                RID = ""
                Timer4.Interval = 100
            Else
                'GenBankFetchStep = 0
                
                Set HTTPRequest = New WinHttp.WinHttpRequest
                HTTPRequest.Open "GET", ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get", True
                HTTPRequest.SEnd
                On Error Resume Next
        
                HTTPRequest.WaitForResponse
                ErrorText = ""
                ErrorText = HTTPRequest.StatusText
                
                On Error GoTo 0
                If ErrorText <> "OK" Then
                    Timer4.Interval = 5000
                    
                End If
                
                
                'Form5.Inet1.Execute (ServerS + "RID=" + RID + "&FORMAT_TYPE=Text&CMD=Get")
                
                'Sleep 2000
                GenBankFetchStep = 7
                F5T1Executing = 0
                If Timer4.Interval < 25000 Then
                    Timer4.Interval = Timer4.Interval * 2
                End If
                Exit Sub
            End If
            If Timer4.Interval > 5000 Then
                Timer4.Interval = 5000
            End If
        Else
                GenBankFetchStep2 = 1000
                GenBankFetchStep3 = 1000
                'Form5.Timer2.Enabled = False
                Form5.Timer3.Enabled = False
                'get list of accession numbers
'                Open "output.html" For Output As #1
'                Print #1, WebString
'                Close #1
                
                Pos2 = InStr(Pos1 + 3, WebString, ">", vbBinaryCompare)
                If Pos2 = 0 Then
'                    GenBankFetchStep = 1000
'                    Form5.Inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                    RID = ""
                    DoEvents
                    Sleep 200
                    F5T1Executing = 0
                    'Call Timer4_Timer 'GenBankFetchStep2 = 1000
                    Exit Sub
                Else
                    SearchS = ""
                    NumGBs = 0
                    If ReassortmentFlag = 0 Then
                        Do While Pos2 > 0
                            Pos1 = InStr(Pos2 + 3, WebString, " ", vbBinaryCompare)
                            If Pos1 = 0 Then
                                DoEvents
                                Sleep 200
                                F5T1Executing = 0
                                'Call Timer4_Timer 'GenBankFetchStep2 = 1000
                                Exit Sub
                            Else
                                AddName = Mid$(WebString, Pos2 + 1, Pos1 - Pos2 - 1)
                                Pos = InStr(4, AddName, "|", vbBinaryCompare)
                                If Pos > 0 Then
                                    AddName = Right(AddName, Len(AddName) - Pos)
                                End If
                                If Left(AddName, 4) = "ref|" Then
                                    AddName = Mid$(AddName, 5, Len(AddName))
                                End If
                                
                                If Right(AddName, 1) = "|" Then
                                    AddName = Mid$(AddName, 1, Len(AddName) - 1)
                                End If
                                If SearchS = "" Then
                                    SearchS = AddName
                                    NumGBs = 1
                                    x = x
                                Else
                                    SearchS = SearchS + "," + AddName
                                    NumGBs = NumGBs + 1
                                    x = x
                                End If
                                    
                                
                            End If
                            Pos2 = InStr(Pos1 + 3, WebString, ">gi", vbBinaryCompare)
                            If Pos2 = 0 Then
                                Pos2 = InStr(Pos1 + 3, WebString, ">NC_", vbBinaryCompare)
                            End If
                        Loop
                        URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
                        RefetchGB = URLS
                        
'                        XX = App.Path
'                        Open "testURL.txt" For Output As #1
'                        Print #1, URLS
'                        Close #1
                        
                        Set HTTPRequest = New WinHttp.WinHttpRequest
                        HTTPRequest.Open "GET", URLS, True
                        HTTPRequest.SEnd
                        On Error Resume Next
        
                        HTTPRequest.WaitForResponse
                        ErrorText = ""
                        ErrorText = HTTPRequest.StatusText
                        
                        On Error GoTo 0
                        If ErrorText <> "OK" Then
                            Timer4.Interval = 5000
                            F5T1Executing = 0
                            Exit Sub
                        End If
                        
                        'Form5.Inet1.Execute URLS, "GET"
                        Form5.Timer4.Interval = 100
                        GenBankFetchStep = 9
                    Else
                        'find the virus name
                        Pos1 = InStr(1, WebString, ">NC_", vbBinaryCompare)
                        
                        If Pos1 = 0 Then '|
                            Pos1 = InStr(1, WebString, "|NC_", vbBinaryCompare)
                        End If
                        
                        If Pos1 > 0 Then
                            Pos2 = InStr(Pos1 + 1, WebString, " ", vbBinaryCompare)
                            If Pos2 > 0 Then
                                Pos1 = InStr(Pos2 + 1, WebString, "virus", vbTextCompare)
                                If Pos1 = 0 Then
                                    Pos1 = InStr(Pos2 + 1, WebString, "phage", vbTextCompare)
                                End If
                                If Pos1 > 0 Then
                                    SearchS = Mid$(WebString, Pos2 + 1, Pos1 + 6 - (Pos2 + 1))
                                Else
                                    GenBankFetchStep = 1000
                                    Exit Sub
                                End If
                                SearchS = Trim(SearchS)
                                For x = 1 To Len(SearchS)
                                    If Mid$(SearchS, x, 1) = " " Then
                                        Mid$(SearchS, x, 1) = "+"
                                    End If
                                Next x
                                URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=nucleotide&term=" + SearchS + "+AND+refseq+AND+txid10239[ORGN]"
                                'RefetchGB = URLS
'                                Open "url.txt" For Output As #1
'                                Print #1, URLS
'                                Close #1
                                'Form5.Inet1.Execute URLS, "GET"
                                Set HTTPRequest = New WinHttp.WinHttpRequest
                                HTTPRequest.Open "GET", URLS, True
                                HTTPRequest.SEnd
                                On Error Resume Next

                                HTTPRequest.WaitForResponse
                                ErrorText = ""
                                ErrorText = HTTPRequest.StatusText

                                On Error GoTo 0
                                If ErrorText <> "OK" Then
                                    Timer3.Interval = 5000
                                    F5T3Executing = 0
                                    Exit Sub
                                End If
                                Form5.Timer4.Interval = 100
                                GenBankFetchStep = 8
                            Else
                                DoEvents
                                Sleep 200
                                F5T1Executing = 0
                                'Call Timer4_Timer 'GenBankFetchStep = 1000
                                Exit Sub
                            End If
                        Else
                            DoEvents
                            Sleep 200
                            F5T1Executing = 0
                            'Call Timer4_Timer 'GenBankFetchStep = 1000
                            Exit Sub
                        End If
                        
                        
                    End If
                End If
           
            
            
        End If
        End If
    ElseIf GenBankFetchStep = 8 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 8"
        Form1.SSPanel1.Caption = "Obtaining a reference genome"
        
        On Error Resume Next
        ErrorText = ""
        ErrorText = HTTPRequest.StatusText
        
        On Error GoTo 0
        If ErrorText <> "OK" Then
        
            F5T1Executing = 0
            Exit Sub
        End If
        ChunkS = HTTPRequest.ResponseText
        WebString = ""

        WebString = WebString + ChunkS
        
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        'If DebuggingFlag < 2 Then On Error Resume Next
'        DoEvents
'        Sleep 500
'        'ChunkS = Form5.Inet1.GetChunk(1024, icString)
'        'On Error GoTo 0
'        If ChunkS = "" Then
'            DoEvents
'            Sleep 200
'            F5T1Executing = 0
'            'Call Timer4_Timer 'GenBankFetchStep = 1000
'            Exit Sub
'        Else
'            WebString = ""
'            WebString = WebString + ChunkS
'            If ChunkS <> TestS And Len(ChunkS) > 0 Then
'                Do While Len(ChunkS) > 0
'                    ChunkS = TestS
'                    DoEvents
'                    Sleep 200
'                    'ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                    WebString = WebString + ChunkS
'                Loop
'
'            End If
'        End If
'
        
        
'        Open "output.html" For Output As #1
'        Print #1, WebString
'        Close #1
        
        SearchS = ""
        Pos1 = 1
        Do
            Pos1 = InStr(Pos1, WebString, "<Id>", vbTextCompare)
            If Pos1 > 0 Then
                Pos2 = InStr(Pos1 + 1, WebString, "</Id>", vbTextCompare)
                SearchS = SearchS + Mid$(WebString, Pos1 + 4, Pos2 - (Pos1 + 4)) + ","
                x = x
                Pos1 = Pos1 + 1
            Else
                If SearchS <> "" Then
                    SearchS = Left(SearchS, Len(SearchS) - 1)
                End If
                Exit Do
            End If
        Loop
        'XX = Right(SearchS, 20)
        If SearchS <> "" Then
            URLS = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=" + SearchS + "&rettype=gb"
            RefetchGB = URLS
            
            Set HTTPRequest = New WinHttp.WinHttpRequest
            HTTPRequest.Open "GET", URLS, True
            HTTPRequest.SEnd
            On Error Resume Next

            HTTPRequest.WaitForResponse
            ErrorText = ""
            ErrorText = HTTPRequest.StatusText

            On Error GoTo 0
            If ErrorText <> "OK" Then
                Timer4.Interval = 5000
                F5T1Executing = 0
                Exit Sub
            End If

            Form5.Timer4.Interval = 100
            GenBankFetchStep = 9
        Else
            GenBankFetchStep = 1000
            Exit Sub
        End If
    ElseIf GenBankFetchStep = 9 Then
        'Form1.SSPanel1.Caption = "GenBankFetchStep = 9"
        Form1.SSPanel1.Caption = "Identifying gene boundaries"
        'form5.inet2.
'        ChunkS = String(1024, " ")
'        TestS = ChunkS
'        DoEvents
'        Sleep 500
        On Error Resume Next
        TestS2 = HTTPRequest.StatusText
        On Error GoTo 0
        If TestS2 <> "OK" Then
            
            F5T1Executing = 0
            Exit Sub
        End If
        
        
        'If Form5.Inet2.ResponseCode = 0 Then
            'If DebuggingFlag < 2 Then On Error Resume Next
            'On Error Resume Next
            ChunkS = HTTPRequest.ResponseText
'            Do
'                ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                If ChunkS <> String(1024, " ") Then
'                    Exit Do
'                End If
'                DoEvents
'                Sleep 250
'
'            Loop
            'On Error GoTo 0
            WebString = ""
            
            WebString = WebString + ChunkS
            If ChunkS > "" Then
'                XX = Len(WebString)
'                If Len(ChunkS) > 0 Then
'                    Do While Len(ChunkS) > 0
'                        ChunkS = TestS
'                        DoEvents
'                        Sleep 200
'                        'XX = Form1.Enabled
'                        'XX = Form1.SSPanel6(0).Enabled
'                        If DebuggingFlag < 2 Then On Error Resume Next
'                        ChunkS = Form5.Inet1.GetChunk(1024, icString)
'                        On Error GoTo 0
'                        WebString = WebString + ChunkS
'                    Loop
'                End If
                DownloadedGBFiles = WebString
'                Form5.inet1.Execute (ServerS + "RID=" + RID + "&CMD=Delete")
'                RID = ""
'

                GenBankFetchStep = 10
        '        If X = 12345 Then
        '            Open "Output2.html" For Binary As #1
        '            XX = LOF(1)
        '            WebString = String(LOF(1), " ")
        '            Get #1, , WebString
        '            Close #1
        '        End If
                
            End If
        'End If
        'Form1.SSPanel1.Caption = ""
        'Form1.ProgressBar1 = 0
    
    
    End If
    
    If GenBankFetchStep = 10 And ModSeqNumFlag = 0 Then
        OV = SilentGBFlag
        SilentGBFlag = 1
        WebString = DownloadedGBFiles
        'split the returned file up into individual genbank files and extract gene coords etc
        Pos1 = 1
        Pos2 = 0
        Dim tGeneList() As GenomeFeatureDefine, tGeneNumber As Long, UBGN As Long, NumberHits As Long
        ReDim tGeneList(100)
        tGeneNumber = 0
        UBGN = 100
        NumberHits = 0
'                        XX = CurDir
'                Open "output.html" For Output As #1
'                Print #1, WebString
'                Close #1
'        SS = abs(gettickcount)
        CurSegment = 0
        ReDim GeneLabel(100)
        AllowDoEvensFlag = 1
        Do
            'Pos2 = InStr(Pos1, WebString, "//", vbBinaryCompare)
            Pos2 = InStr(Pos1, WebString, "//" + Trim(Chr(10)), vbBinaryCompare)
            If Pos2 = 0 Then
                Pos2 = InStr(Pos1, WebString, "//" + Trim(Chr(13)), vbBinaryCompare)
                If Pos2 = 0 Then
                    Pos2 = Len(WebString) - 2
                End If
            End If
            Dim tWebString As String
            If Pos2 > 0 Then
                tWebString = Mid$(WebString, Pos1, Pos2 - (Pos1 - 2))
               ' XX = Right$(tWebString, 20)
                NumberHits = NumberHits + 1
'                        If NumberHits = 5 Then
'                            X = X
'                        End If
                CurSegment = CurSegment + 1
                If Resetload = 1 Then
                    Exit Sub
                End If
                Call LoadGenBank(tWebString)
                
                If AbortflagGB = 1 Then
                    If ReassortmentFlag = 1 Then
                        GenBankFetchStep = 8
                    Else
                        GenBankFetchStep = 9
                    End If
                    AbortflagGB = 0
                    URLS = RefetchGB
                   ' XX = App.Path
'                    Open "testURL.txt" For Output As #1
'                    Print #1, URLS
'                    Close #1
                    Timer4.Enabled = False
                    Timer4.Interval = 100
                    'Form5.Inet1.Execute URLS, "GET"
                    Form5.Timer4.Enabled = True
                    F5T1Executing = 0
                    Exit Sub
                    
                Else
                    For x = 1 To GeneNumber
                        tGeneNumber = tGeneNumber + 1
                        If tGeneNumber > UBGN Then
                            UBGN = UBGN + 100
                            ReDim Preserve tGeneList(UBGN)
                        End If
                        tGeneList(tGeneNumber) = GeneList(x)
                        If tGeneNumber > UBound(GeneLabel, 1) Then
                            ReDim Preserve GeneLabel(UBound(GeneLabel, 1) + 100)
                        End If
                        GeneLabel(tGeneNumber) = CurSegment
                    Next x
                
                End If
                
'                 XX = GeneList(28).StartInAlign
'                 XX = GeneList(28).EndInAlign
'                 XX = tGeneList(28).StartInAlign
'                 XX = tGeneList(28).EndInAlign
                
                
'                XX = GeneNUmber
'                XX = GeneList(GeneNUmber).StartInAlign '1
'                XX = GeneList(GeneNUmber).EndInAlign '9292
                'xx=GeneList(GeneNUmber).
                'save all the ORFs etc extracted
            Else
                Exit Do
            End If
            Pos1 = Pos2 + 1
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'This forces a singlee loop
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'NumberHits = 1
            If ReassortmentFlag = 0 Then
                Exit Do
            Else
                Form1.SSPanel1.Caption = "Loaded gene data for " + Trim(Str(NumberHits)) + " segments"
            End If
            
        Loop
        AllowDoEvensFlag = 0
        
        If x = x Then
            If ReassortmentFlag = 1 Then
                Dim MatchNum() As Long
                ReDim MatchNum(tGeneNumber)
                x = 0
                For x = 1 To tGeneNumber
                   
                    If RemoveSegment(GeneLabel(x)) = 1 Then
                        MatchNum(x) = -1
                    End If
                    
                Next x
                GeneNumber = 0
                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
                For x = 1 To tGeneNumber
                    If MatchNum(x) > -1 Then
                        GeneNumber = GeneNumber + 1
                        GeneList(GeneNumber) = tGeneList(x)
                    End If
                Next x
                tGeneNumber = GeneNumber
                For x = 1 To tGeneNumber
                    tGeneList(x) = GeneList(x)
                Next x
                ReDim MatchNum(tGeneNumber)
            End If
            GeneNumber = 0
            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
            For x = 1 To tGeneNumber
                If tGeneList(x).StartInAlign > 0 Or tGeneList(x).EndInAlign > 0 Then
                    GeneNumber = GeneNumber + 1
                    GeneList(GeneNumber) = tGeneList(x)
                End If
            Next x
            
            
            'this gets rid of duplicate segments in segemnted genomes
            'that have multiple associated genbank files
            
        Else
        
            If ReassortmentFlag = 1 Then NumberHits = 1
            
            Call CheckGenes(tGeneList(), tGeneNumber)
            
            
            
            Dim MatchMatrix() As Integer
            
            ReDim MatchMatrix(tGeneNumber, tGeneNumber), MatchNum(tGeneNumber)
            
            'this gets rid of duplicate segments in segemnted genomes
            'that have multiple associated genbank files
            If ReassortmentFlag = 1 Then
                x = 0
                For x = 1 To tGeneNumber
                   
                    If RemoveSegment(GeneLabel(x)) = 1 Then
                        MatchNum(x) = -1
                    End If
                    
                Next x
                GeneNumber = 0
                ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
                For x = 1 To tGeneNumber
                    If MatchNum(x) > -1 Then
                        GeneNumber = GeneNumber + 1
                        GeneList(GeneNumber) = tGeneList(x)
                    End If
                Next x
                tGeneNumber = GeneNumber
                For x = 1 To tGeneNumber
                    tGeneList(x) = GeneList(x)
                Next x
                ReDim MatchNum(tGeneNumber)
            End If
            
            'Find consensus ORFS, Features and Names
            
    '        For X = 0 To tGeneNumber
    '            MatchNum(X) = 0
    '        Next X
            Dim TotE As Long, TotS As Long, LenFrag As Long, TotF As Long, GoOn As Long
            
            SSS = Abs(GetTickCount)
            
            For x = 1 To tGeneNumber - 1
                'XX = tGeneList(X).Orientation
    '             If X = 42 Then
    '                    X = X
    '                End If
                If tGeneList(x).Orientation = 1 Then
                    If tGeneList(x).StartInAlign > tGeneList(x).EndInAlign Then
                        
                        tGeneList(x).EndInAlign = tGeneList(x).EndInAlign + Len(StrainSeq(0))
                    End If
    '                XX = tGeneList(X).Name
    '                XX = tGeneList(X).Product
                    LenFrag = tGeneList(x).EndInAlign - tGeneList(x).StartInAlign
                    LenFrag = CLng(LenFrag * 0.1)
                    
                    For Y = x + 1 To tGeneNumber
                        XX = Right(tGeneList(Y).Product, 10)
                        GoOn = 0
                        If tGeneList(x).Orientation = tGeneList(Y).Orientation Then
                            If tGeneList(x).IntronFlag = tGeneList(Y).IntronFlag Then
                                If tGeneList(x).ExonNumber = tGeneList(Y).ExonNumber Then
                                    If (Right(tGeneList(x).Product, 1) <> "*" And Right(tGeneList(Y).Product, 1) <> "*") Then
                                        GoOn = 1
                                    ElseIf (Right(tGeneList(x).Product, 1) = "*" And Right(tGeneList(Y).Product, 1) = "*") Then
                                        GoOn = 1
                                    End If
                                End If
                            End If
                        End If
                        If tGeneList(x).Orientation = tGeneList(Y).Orientation And GoOn = 1 Then
                            If Abs(tGeneList(x).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
                                If tGeneList(Y).StartInAlign > tGeneList(Y).EndInAlign Then
                                    tGeneList(Y).EndInAlign = tGeneList(Y).EndInAlign + Len(StrainSeq(0))
                                End If
                                If Abs(tGeneList(x).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
                                    MatchMatrix(x, Y) = 1
                                    MatchMatrix(Y, x) = 1
                                    MatchNum(x) = MatchNum(x) + 1
                                    MatchNum(Y) = MatchNum(Y) + 1
                                End If
                            End If
                        End If
                    Next Y
                ElseIf tGeneList(x).Orientation = 2 Then
                   
                    If tGeneList(x).EndInAlign > tGeneList(x).StartInAlign Then
                        
                        tGeneList(x).StartInAlign = tGeneList(x).StartInAlign + Len(StrainSeq(0))
                    End If
                    
                    LenFrag = tGeneList(x).StartInAlign - tGeneList(x).EndInAlign
                    LenFrag = CLng(LenFrag * 0.1)
                    
                    For Y = x + 1 To tGeneNumber
                        If tGeneList(x).Orientation = tGeneList(Y).Orientation Then
                            If Abs(tGeneList(x).StartInAlign - tGeneList(Y).StartInAlign) < LenFrag Then
                                If tGeneList(Y).EndInAlign > tGeneList(Y).StartInAlign Then
                                    tGeneList(Y).StartInAlign = tGeneList(Y).StartInAlign + Len(StrainSeq(0))
                                End If
                                If Abs(tGeneList(x).EndInAlign - tGeneList(Y).EndInAlign) < LenFrag Then
                                    MatchMatrix(x, Y) = 1
                                    MatchMatrix(Y, x) = 1
                                    MatchNum(x) = MatchNum(x) + 1
                                    MatchNum(Y) = MatchNum(Y) + 1
                                End If
                            End If
                        End If
                    Next Y
                End If
            Next x
            
            'get rid on non-matchers (less that 2 matches) that overlap matchers
            If NumberHits < 5 Then
                threshold = 0
            Else
                threshold = 1
            End If
            x = 1
            
            Do While x <= tGeneNumber
                If MatchNum(x) < threshold Then
                   MatchNum(x) = -1
                
                    
                End If
                x = x + 1
            Loop
            
            
            'Find median start and end positions for repeats and get rid of repeats (but store data on names if necessary)
            If NumberHits > 1 Then
                For x = 1 To tGeneNumber - 1
                    
                    If MatchNum(x) >= threshold Then
                        TotS = tGeneList(x).StartInAlign
                        TotE = tGeneList(x).EndInAlign
                        TotF = tGeneList(x).Frame
                        For Y = x + 1 To tGeneNumber
                            If MatchNum(Y) >= threshold Then
                                If MatchMatrix(x, Y) = 1 Then
                                    TotS = TotS + tGeneList(Y).StartInAlign
                                    TotE = TotE + tGeneList(Y).EndInAlign
                                    TotF = TotF + tGeneList(Y).Frame
                                    If Len(tGeneList(x).Name) < Len(tGeneList(Y).Name) Then tGeneList(x).Name = tGeneList(Y).Name
                                    If Len(tGeneList(x).Product) < Len(tGeneList(Y).Product) Then tGeneList(x).Product = tGeneList(Y).Product
                                    'At some point I may have to deal with conflicts in introns and orientation here
                                    MatchNum(Y) = -1
                                End If
                            End If
                        Next Y
                        tGeneList(x).StartInAlign = (CLng(TotS / (MatchNum(x) + 1)))
                        tGeneList(x).EndInAlign = (CLng(TotE / (MatchNum(x) + 1)))
                        If tGeneList(x).Orientation = 1 Then
                            If tGeneList(x).EndInAlign > Len(StrainSeq(0)) Then tGeneList(x).EndInAlign = tGeneList(x).EndInAlign - Len(StrainSeq(0))
                        
                        ElseIf tGeneList(x).Orientation = 2 Then
                            If tGeneList(x).StartInAlign > Len(StrainSeq(0)) Then tGeneList(x).StartInAlign = tGeneList(x).StartInAlign - Len(StrainSeq(0))
                        End If
                        tGeneList(x).Frame = CLng(TotF / (MatchNum(x) + 1))
                        x = x
                    Else
                        x = x
                    End If
                Next x
            End If
            
            
            
            
            'copy over ones with matchnums>0 to genelist
            GeneNumber = 0
            ReDim GeneList(tGeneNumber), ColBump(tGeneNumber)
            For x = 1 To tGeneNumber
                If MatchNum(x) >= threshold Then
                    GeneNumber = GeneNumber + 1
                    GeneList(GeneNumber) = tGeneList(x)
                Else
                    x = x
                End If
            Next x
            'GeneNUmber = 0
            
            
            SilentGBFlag = OV
            
            For x = 0 To GeneNumber
                If GeneList(x).Orientation = 1 Then
                    If GeneList(x).StartInAlign > GeneList(x).EndInAlign Then
                        GeneList(x).EndInAlign = GeneList(x).EndInAlign + Len(StrainSeq(0))
                    End If
                ElseIf GeneList(x).Orientation = 2 Then
                    If GeneList(x).EndInAlign > GeneList(x).StartInAlign Then
                        GeneList(x).StartInAlign = GeneList(x).StartInAlign + Len(StrainSeq(0))
                    End If
                End If
            Next x
          
            For x = 1 To GeneNumber
    '            If X = 28 Then
    '                X = X
    '            End If
    '            If GeneList(X).Start = 6919 Or GeneList(X).End = 6919 Then
    '                X = X
    '            End If
                If GeneList(x).Orientation = 1 Then
                    If Right(GeneList(x).Product, 1) <> "*" Then
                        For Y = 1 To GeneNumber
                            
                            If x <> Y And GeneList(x).Orientation = GeneList(Y).Orientation Then
                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
                                    If GeneList(x).StartInAlign <= GeneList(Y).StartInAlign Then
                                        If GeneList(x).EndInAlign >= GeneList(Y).EndInAlign Then
                                            GeneList(Y).Frame = GeneList(x).Frame
                                        End If
                                    End If
                                Else
                                    If GeneList(x).StartInAlign <= GeneList(Y).StartInAlign Then
                                        If GeneList(x).EndInAlign >= GeneList(Y).EndInAlign Then
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        ElseIf GeneList(x).EndInAlign >= GeneList(Y).StartInAlign Then ' i.e partial overlap
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        End If
                                     ElseIf (GeneList(x).EndInAlign >= GeneList(Y).EndInAlign And GeneList(x).StartInAlign <= GeneList(Y).EndInAlign) Then 'partial overlaps
                                        If GeneList(Y).Frame = GeneList(x).Frame Then
                                            GeneList(Y).Frame = GeneList(x).Frame + 1
                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                        End If
                                    End If
                                End If
                            ElseIf x <> Y Then ' genelist(y).orientation must be 2
                                If GeneList(x).StartInAlign <= GeneList(Y).EndInAlign Then
                                    If GeneList(x).EndInAlign >= GeneList(Y).StartInAlign Then
                                        If GeneList(Y).Frame = GeneList(x).Frame Then
                                            GeneList(Y).Frame = GeneList(x).Frame + 1
                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                        End If
                                    ElseIf GeneList(x).EndInAlign >= GeneList(Y).EndInAlign Then ' i.e partial overlap
                                        If GeneList(Y).Frame = GeneList(x).Frame Then
                                            GeneList(Y).Frame = GeneList(x).Frame + 1
                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                        End If
                                    End If
                                 ElseIf (GeneList(x).EndInAlign >= GeneList(Y).StartInAlign And GeneList(x).StartInAlign <= GeneList(Y).StartInAlign) Then 'partial overlaps
                                    If GeneList(Y).Frame = GeneList(x).Frame Then
                                        GeneList(Y).Frame = GeneList(x).Frame + 1
                                        If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                    End If
                                End If
                            End If
                        Next Y
                    End If
                ElseIf GeneList(x).Orientation = 2 Then
                    'XX = Right(GeneList(X).Product, 10)
                    If Right(GeneList(x).Product, 1) <> "*" Then
                        For Y = 1 To GeneNumber
                            
                            If x <> Y And GeneList(x).Orientation = GeneList(Y).Orientation Then
                                If Right(GeneList(Y).Product, 1) = "*" Or Right(GeneList(Y).Name, 1) = "*" Then
                                    If GeneList(x).StartInAlign >= GeneList(Y).StartInAlign Then
                                        If GeneList(x).EndInAlign <= GeneList(Y).EndInAlign Then
                                            GeneList(Y).Frame = GeneList(x).Frame
                                        End If
                                    End If
                                Else
                                    If GeneList(x).StartInAlign >= GeneList(Y).StartInAlign Then
                                        If GeneList(x).EndInAlign <= GeneList(Y).EndInAlign Then
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        ElseIf GeneList(x).EndInAlign <= GeneList(Y).StartInAlign Then ' i.e partial overlap
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        End If
                                     ElseIf (GeneList(x).EndInAlign <= GeneList(Y).EndInAlign And GeneList(x).StartInAlign >= GeneList(Y).EndInAlign) Then 'partial overlaps
                                        If GeneList(Y).Frame = GeneList(x).Frame Then
                                            GeneList(Y).Frame = GeneList(x).Frame + 1
                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                        End If
                                    End If
                                End If
                            ElseIf x <> Y Then
                                'XX = GeneList(Y).Orientation - should always be 1
                                    If GeneList(x).StartInAlign >= GeneList(Y).EndInAlign Then
                                        If GeneList(x).EndInAlign <= GeneList(Y).StartInAlign Then
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        ElseIf GeneList(x).EndInAlign <= GeneList(Y).EndInAlign Then ' i.e partial overlap
                                            If GeneList(Y).Frame = GeneList(x).Frame Then
                                                GeneList(Y).Frame = GeneList(x).Frame + 1
                                                If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                            End If
                                        End If
                                     ElseIf (GeneList(x).EndInAlign <= GeneList(Y).StartInAlign And GeneList(x).StartInAlign >= GeneList(Y).StartInAlign) Then 'partial overlaps
                                        If GeneList(Y).Frame = GeneList(x).Frame Then
                                            GeneList(Y).Frame = GeneList(x).Frame + 1
                                            If GeneList(Y).Frame > 3 Then GeneList(Y).Frame = 1
                                        End If
                                    End If
    '                            Else
    '
    '                            End If
                            End If
                        Next Y
                    End If
                End If
            Next x
            
        End If
        
     
        'restore the ends
        For x = 1 To GeneNumber
            If GeneList(x).Orientation = 1 Then
                If GeneList(x).EndInAlign > Len(StrainSeq(0)) Then
                    GeneList(x).EndInAlign = GeneList(x).EndInAlign - Len(StrainSeq(0))
                End If
            ElseIf GeneList(x).Orientation = 2 Then
                If GeneList(x).StartInAlign > Len(StrainSeq(0)) Then
                    GeneList(x).StartInAlign = GeneList(x).StartInAlign - Len(StrainSeq(0))
                End If
            
            End If
        Next x
        

        
        
        'make sure genes besides/overlapping one another are in different "Frames"
        
        'XX = GeneNumber
       ' Call CheckGenes(GeneList(), GeneNumber)
        If GeneNumber > 0 Then
            ORFFlag = 1

            Call DrawORFs
            Form1.Picture20.Height = Form1.Picture4.ScaleHeight + 3
            Form1.Picture20.BackColor = Form1.Picture7.BackColor
            
            'If RunFlag = 1 Then
            If RelX > 0 Or RelY > 0 Then
                If XoverList(RelX, RelY).ProgramFlag = 0 Or XoverList(RelX, RelY).ProgramFlag = 0 + AddNum Then
'                            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
'                            Form1.Picture7.Height = Form1.Picture7.Height - (Form1.Picture20.ScaleHeight + 5)
                    Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
                    Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
                    
                    
                End If
            
                'End If
                
                Form1.Picture20.Visible = True
            
            End If
            Form1.Picture7.Height = Form1.Picture10.ScaleHeight - Form1.Picture20.Height + 5
            Form1.Picture7.Top = Form1.Picture20.ScaleHeight - 5
            'Call ResizeForm1
            
        End If

        Call FillGeneSEPos
        
        'X = X
        
        EEE = Abs(GetTickCount)
        TT = EEE - SSS '1219 for ~2000 sequences
        
        
        Form1.Picture4.ScaleMode = 3
        Form1.Picture4.DrawMode = 13
        Form1.Picture11.ScaleMode = 3
        Form1.Picture19.DrawMode = 13
        DontDoH1Inc = 1
        OnlyDoPositionIndicator = 1
        OnlyDoPosBar = 1
        
        If Form1.HScroll1.Max > 0 Then
            If Form1.HScroll1.Value > Form1.HScroll1.Min Then
                DontDoH1Inc = 1
                H1C = 1
                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
                DontDoH1Inc = 0
                H1C = 0
                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
            Else
                If Form1.HScroll1.Value < Form1.HScroll1.Max Then
                    DontDoH1Inc = 1
                    H1C = 1
                    Form1.HScroll1.Value = Form1.HScroll1.Value + 1
                    DontDoH1Inc = 0
                    H1C = 0
                    Form1.HScroll1.Value = Form1.HScroll1.Value - 1
                End If
            End If
        Else
            Dim OI As Long, oD As Long
            OI = Form1.Timer3.Interval
            oD = Form1.Timer3.Enabled
            Form1.Timer3.Enabled = False
            Form1.Timer3.Interval = 27
            Form1.Timer3.Enabled = True
            DoEvents
            Sleep 30
            DoEvents
            Form1.Timer3.Enabled = oD
            Form1.Timer3.Interval = OI
        End If
        OnlyDoPositionIndicator = 0
        OnlyDoPosBar = 0
        DontDoH1Inc = 0
        
        GenBankFetchStep = 1000
        EE = Abs(GetTickCount)
        TT = EE - StartFetch '468360 - 1 million nts restriction'25875,fail, 44563, 52578; 100000 nt restriction'50000 fail,342859,fail,40313
        '1000000 no virus restriction
        '559657
        '0.00001 - 197500
        
        x = x
    
    End If
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    'If Left(Form1.SSPanel1.Caption, 16) = "Loaded gene data" Then
        Form1.SSPanel1.Caption = ""
    'End If
    F5T1Executing = 0
CrashExit:

Form1.SSPanel1.Caption = ""
Exit Sub
End Sub

Private Sub VScroll1_Change()
    Picture1.Top = -VScroll1.Value * Screen.TwipsPerPixelY
End Sub

Private Sub VScroll1_Scroll()
    Picture1.Top = -VScroll1.Value * Screen.TwipsPerPixelY
End Sub

Private Sub VScroll2_Change()
    Picture2.Top = -VScroll2.Value * Screen.TwipsPerPixelY
End Sub

Private Sub VScroll2_Scroll()
    Picture2.Top = -VScroll2.Value * Screen.TwipsPerPixelY
End Sub
