VERSION 5.00
Begin VB.Form frmSplash 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   2970
   ClientLeft      =   1050
   ClientTop       =   1050
   ClientWidth     =   5100
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   699.646
   ScaleMode       =   0  'User
   ScaleWidth      =   552.845
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   120
      Top             =   2760
   End
   Begin VB.Frame Frame1 
      Height          =   2880
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   4980
      Begin VB.Label lblCompanyProduct 
         AutoSize        =   -1  'True
         Caption         =   "Recombination Detection Program"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   120
         TabIndex        =   3
         Top             =   180
         Width           =   4770
      End
      Begin VB.Label lblCopyright 
         Caption         =   "By Darren Martin"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3480
         TabIndex        =   1
         Top             =   2490
         Width           =   1335
      End
      Begin VB.Label lblProductName 
         AutoSize        =   -1  'True
         Caption         =   "RDP3 Beta 11"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   32.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   765
         Left            =   360
         TabIndex        =   2
         Top             =   960
         Width           =   4200
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Form_KeyPress(KeyAscii As Integer)

    'Call BenchMark

    Unload Me
End Sub

Private Sub Form_Load()

Dim oDir As String
ReDim TreeDraw(3, 4, 1, 4, 0)
ReDim TreeDrawColBak(0, 3), TreeDrawColBakFlag(3)
Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
ReDim TreeTrace(0), TreeTraceSeqs(1, 0)
SelectedSeqNumber = -1
ReDim BCurrentXoverMi(0), Flashnt(5, 100)
ReDim NOPINI(2, 0), Steps(4, 0), ConfirmPMa(0, 0), ConfirmMa(0, 0), ConfirmPMi(0, 0), ConfirmMi(0, 0), ConfirmMi(0, 0), BCurrentXoverMi(0), BestXOListMi(0, 0), BestXOListMa(0, 0), BestEvent(0, 0), Confirm(0, 0), ConfirmP(0, 0)
ReDim DScores(25, 2, 0), SuperEventList(0), Daught(0, 0), MinorPar(0, 0), MajorPar(0, 0)
ReDim SchemBlocks(3, 4, 100), SchemString(3, 3, 100)
ReDim GeneList(10000), ColBump(10000)
ReDim Excludetrace(1000)
ReDim FSSRDP(3, 2, 2, 2)
ReDim CompressSeq(0, 0)
ReDim StatsDump(2, 40, 100)
ConsensusStrat = 0 ' 0 = old way, 1=use logistic regression method
InteractListLen = -1
MemPoc = 2000
PermMemPoc = MemPoc
MaxAnalNo = 10000000 '20000000
LowMemThreshold = MemPoc
ExcludedEventNumThresh = 1000000
DebuggingFlag = 2

    DontSaveUndo = 0
    LastP1X = -1
    LastP1Y = -1
    LastntNum = -1
    P1MDStart = -1
    FirstAddSome = 0
    UFTag = Trim(Str(Abs(GetTickCount)))
    UndoSlot = 0: UndoCycle = 0: MaxUndos = 40
    Dim XX As Variant
    oDir = CurDir
    ChDir App.Path
    ChDrive App.Path
    'XX = CurDir
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    KillFile "testx.bat"
    If Dir("testx.bat") <> "" Then
        FLen = FileLen("testx.bat")
    
    Else
        FLen = -1
    End If
    'FLen = FileLen("testx.bat")
    ReDim mtP(100)
    ReDim ntCompareMatD(90 * 2)
    ReDim ntCompareMatV(90 * 2)
    '66,68,72,85,46
    ntCompareMatD(66 + 66) = 0
    ntCompareMatD(66 + 68) = 1
    ntCompareMatD(66 + 72) = 1
    ntCompareMatD(66 + 85) = 1
    
    ntCompareMatV(66 + 66) = 1
    ntCompareMatV(66 + 68) = 1
    ntCompareMatV(66 + 72) = 1
    ntCompareMatV(66 + 85) = 1
    
    ntCompareMatD(68 + 68) = 0
    ntCompareMatD(68 + 72) = 1
    ntCompareMatD(68 + 85) = 1
    
    ntCompareMatV(68 + 68) = 1
    ntCompareMatV(68 + 72) = 1
    ntCompareMatV(68 + 85) = 1
    
   
    ntCompareMatD(72 + 72) = 0
    ntCompareMatD(72 + 85) = 1
    
    ntCompareMatV(72 + 72) = 1
    ntCompareMatV(72 + 85) = 1
   
    ntCompareMatD(85 + 85) = 0
    
    ntCompareMatV(85 + 85) = 1
    
    ntCompareMatD(46 + 46) = 0
    ntCompareMatD(46 + 66) = 0
    ntCompareMatD(46 + 68) = 0
    ntCompareMatD(46 + 72) = 0
    ntCompareMatD(46 + 85) = 0
    
    ntCompareMatV(46 + 46) = 0
    ntCompareMatV(46 + 66) = 0
    ntCompareMatV(46 + 68) = 0
    ntCompareMatV(46 + 72) = 0
    ntCompareMatV(46 + 85) = 0
    
    
    If App.PrevInstance = False Then
        KillFile "RDP5Distance*"
        KillFile "RDP5uDistance*"
        KillFile "RDP5PermValid*"
        KillFile "RDP5PermDiffs*"
        KillFile "RDP5TreeDistance*"
        KillFile "RDP5uTreeDistance*"
        KillFile "RDP5tTreeDistance*"
        KillFile "RDP5FVFile*"
        KillFile "RDP5PSNFile*"
        KillFile "RDP5PPermDiffs*"
        KillFile "RDP5PermDistance*"
        KillFile "RDP5PermTreeDistance*"
        KillFile "RDP5PPermValid*"
        KillFile "RDP5SCRFile*"
        KillFile "RDP5CDFile*"
        KillFile "RDP5SSFile*"
        KillFile "RDP5TreeSeqnum*"
        KillFile "RDP5uSeqnum*"
        KillFile "RDP5TreeSMat*"
        KillFile "RDP5TreeFMat*"
        KillFile "RDP5TreeMatrix*"
        KillFile "RDP5uMissingData*"
        KillFile "SequencesForSaving*"
        KillFile "RDP5BestXOListMi*"
        KillFile "RDP5BestXOListMa*"
        KillFile "RDP5BS2*"
        KillFile "RDP5treefile2*"
        KillFile "RDP5Longseq*"
        KillFile "NF*"
        KillFile "RDP5Analysislist*"
        KillFile "RDP5SubValid*"
        KillFile "RDP5Strainseq*"
        KillFile "RDP5VRandTemplate*"
        KillFile "RDP5TreeX*"
        KillFile "RDP5uDuTD*"
        KillFile "IF*.fasta"
        KillFile "IF*.dnd"
        KillFile "IF*.seq"
        KillFile "RDP5bsfile*"
        KillFile "RDP5SeqNumFile*"
        KillFile "UndoSlot*"
    End If
    
    
    
    If FLen <> -1 Then
    
        MsgBox ("RDP will only work properly on Windows VISTA/7/8/10, if it is run with administrator rights. When you press the 'OK' button the program will shut down. You should then restart it by right clicking on the program icon and selecting the 'Run as administrator' option.")
        End
    
    End If
    FF = FreeFile
    Open "testx.bat" For Output As #FF
    Print #FF, "test"
    Close #FF
    FLen = 0
    FLen = FileLen("testx.bat")
    If FLen = 0 And Command = "" Then
        MsgBox ("RDP will only work properly on Windows VISTA/7/8/10, if it is run with administrator rights. When you press the 'OK' button the program will shut down. You should then restart it by right clicking on the program icon and selecting the 'Run as administrator' option.")
        End
    End If
    KillFile "testx.bat"
    On Error GoTo 0
    
    If DebuggingFlag < 2 Then On Error Resume Next
    ChDir oDir
    ChDrive oDir
    On Error GoTo 0
    
    
    'lblVersion.Caption = "Version " & App.Major & "." & App.Minor & "." & App.Revision
    'lblProductName.Caption = App.Title
    
     ReDim BPCIs(9, 0)
     ReDim OriginalPos(0)
     ReDim ELLite(5, 0)
     ExcludedEventNum = 0
     ExcludedEventBPNum = 0
     ReDim EventsInExcludeds(5, 1000)
     ReDim ISInvolved(0)
     ReDim FullOName(0)
     ReDim WhereIsExclude(0)
     ReDim EventsInExcludedsBP(1, 0)
     
     ReDim ChiInt(3, 3)
     'seq1 = seq2
     ChiInt(1, 0) = 1
     ChiInt(1, 1) = 1
     
     'seq1=seq3
     ChiInt(2, 0) = 1
     ChiInt(2, 2) = 1
     
     'seq2=seq3
     ChiInt(3, 1) = 1
     ChiInt(3, 2) = 1
     
     Dim m_hMod As Long
      
        'm_hMod = LoadLibraryExa("threed32.ocx", 0, 0)
        'If (m_hMod = 0) Then
        '   Err.Raise vbObjectError + 1048 + 1, App.EXEName & ".cLibrary", WinError(Err.LastDllError)
        'End If
        '
        'FreeLibrary m_hMod
    
    
    
    frmSplash.lblProductName = "RDP" & Trim(Str(App.Major)) & " Beta " & Trim(Str(App.Minor))
    
    Load Form1
    Form1.Visible = False
    'XX = Form1.Picture1.FontSize
    DoEvents
    
    FullSCreenWidth = Form1.Width
    Form1.Picture1.Width = FullSCreenWidth * 0.85  '/ Screen.TwipsPerPixelX
    Form1.Picture1.Height = Form1.Height * 0.8 '/ Screen.TwipsPerPixelY
    
    Call ResizeForm1 '1
    'XX = Screen.Width / Screen.TwipsPerPixelX
    
    
   
    
    'XX = Form1.Picture1.FontSize
    
    NoF3Check2 = 0
    Load Form5
    
    
    
    
    
    DoEvents
    
    
    Form2.Visible = False
    
    Load Form2
    
    
    Form2.Top = 0
    Form2.Height = Screen.Height - TaskBarHeight * Screen.TwipsPerPixelY
    Form2OHeight = Form1OHeight
    
    
    'Call ResizeForm2

    Form3.Visible = False
    Load Form3

    

    Form5.Visible = False
    
    Form1.Picture1.BackColor = Form1.BackColor
    Form1.Frame5.Visible = False
    Timer1.Enabled = True
    
    
    MainSeed = 54
    
    Call ResizeForm2
    Call ResizeForm3
    
    Form1.Visible = True
    
    If LoadFileOnStartUpFlag > 0 Then
        Form1.Timer6.Enabled = True
    End If
    Form1.Command3.SetFocus
    
    FullSCreenWidth = Form1.Width
    Form1.Picture1.Width = FullSCreenWidth * 0.85  '/ Screen.TwipsPerPixelX
    Form1.Picture1.Height = Form1.Height * 0.8 '/ Screen.TwipsPerPixelY
    Set Form1.Picture1.Picture = Form1.Picture1.Image
    Set sPic = Form1.Picture1.Picture
    cDib.CreateFromPicture sPic
    
    P6OSize = Form1.Picture5.Width
    'Call ResizeForm1
    Call ResizeForm2
    
    
    
    Set Form2.Picture2(0).Picture = Form2.Picture2(0).Image
    Set tPic = Form2.Picture2(0).Picture
    tDib.CreateFromPicture tPic
    
    Form2.Picture5.Width = Form2.Picture3(0).Width '* Screen.TwipsPerPixelX
    Form2.Picture5.Height = Form2.Picture3(0).Height * 7 '* Screen.TwipsPerPixelY

    Set Form2.Picture5.Picture = Form2.Picture5.Image
    Set gPic = Form2.Picture5.Picture
    gDib.CreateFromPicture gPic
    
    
    
    
End Sub

Private Sub Frame1_Click()

    'Call BenchMark

    Unload Me
End Sub

Private Sub Timer1_Timer()
If LoadBusy = 1 Then Exit Sub
    'Call BenchMark

    Unload Me
End Sub
