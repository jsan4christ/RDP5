VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form7 
   Caption         =   "Merge Events"
   ClientHeight    =   1110
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4815
   LinkTopic       =   "Form7"
   ScaleHeight     =   1110
   ScaleWidth      =   4815
   StartUpPosition =   3  'Windows Default
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   4320
      Top             =   240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   840
      TabIndex        =   6
      Text            =   "Combo1"
      Top             =   600
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Cancel"
      Height          =   375
      Index           =   1
      Left            =   3600
      TabIndex        =   5
      Top             =   480
      Width           =   615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Index           =   0
      Left            =   2880
      TabIndex        =   4
      Top             =   480
      Width           =   615
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   1
      Left            =   3360
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   240
      Width           =   735
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   0
      Left            =   1200
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   240
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   255
      Index           =   1
      Left            =   2160
      TabIndex        =   2
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Label1"
      Height          =   195
      Index           =   0
      Left            =   240
      TabIndex        =   1
      Top             =   240
      Width           =   480
   End
End
Attribute VB_Name = "Form7"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Combo1_Click()
If NoTypeSeqFlag = 0 Then

    TypeSeqNumber = Form7.Combo1.ListIndex
Else
    SelectedSeqNumber = Form7.Combo1.ListIndex
End If
End Sub

Private Sub Combo1_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
    
    For x = 0 To NextNo
        Pos = InStr(1, StraiName(x), Combo1.Text, vbTextCompare)
        If Pos > 0 Then
            x = x
            SelectedSeqNumber = x
            Combo1.ListIndex = x
            Exit For
        End If
    Next x
    If x = NextNo + 1 Then
        MsgBox ("There is no sequence in the alignment with this string of characters in its name")
    Else
        If NoTypeSeqFlag = 0 Then
            TypeSeqNumber = x
        Else
            SelectedSeqNumber = x
        End If
    End If

Else
    
End If

End Sub

Private Sub Command1_Click(Index As Integer)

Dim TargetE As Long, Replace As Long



Form7.Visible = False
Form1.Refresh
If Index = 0 Then
    If F7Flag = 10 Then
        Dim OFWS As Long
        OFWS = FullWindowSize
        If Form7.Text1(0).Text <> "" Then
            If DebuggingFlag < 2 Then On Error Resume Next
            Dim TestVal As Long
            TestVal = -1
            TestVal = CLng(val(Form7.Text1(0).Text))
            On Error GoTo 0
            If TestVal > 0 And TestVal < Len(StrainSeq(0)) * 0.9 Then
                FullWindowSize = TestVal
            End If
            Form7.Text1(0).ToolTipText = ""
        End If
        If OFWS <> FullWindowSize Then
             DoneBKgFlag = 0
             DoneTajDflag = 0
             DonGCContentFlag = 0
             F1MDF = 1
'             SS = abs(gettickcount)
'             For X = 1 To 100
            Call CalcIdentity3(1)
'            Next X
'            EE = abs(gettickcount)
'            TT = EE - SS
            Form1.Picture11.Refresh
            Form1.Picture4.Refresh
        End If
    ElseIf F7Flag = 0 Then
        If DontSaveUndo = 0 Then
            Call SaveUndo
        End If
        Call UnModNextno
    
    
        If val(Text1(0)) > 0 And val(Text1(1)) > 0 Then
            
            
            
            If val(Text1(0)) > val(Text1(1)) Then
                TargetE = val(Text1(0))
                Replace = val(Text1(1))
            ElseIf val(Text1(1)) > val(Text1(0)) Then
                TargetE = val(Text1(1))
                Replace = val(Text1(0))
            End If
        'For X = 0 To NextNo
        '    For Y = 0 To CurrentXover(X)
        '        If SuperEventlist(XOverList(X, Y).Eventnumber) = TargetE Then
        Dim UBD As Long
        UBD = UBound(uDaught, 2)
        
        
                    For Z = 0 To NextNo
                        If Daught(TargetE, Z) > 0 Then
                            If Daught(Replace, Z) = 0 Or (Daught(TargetE, Z) > 0 And Daught(Replace, Z) > Daught(TargetE, Z)) Then
                                Daught(Replace, Z) = Daught(TargetE, Z)
                                If Z <= UBD Then
                                    uDaught(Replace, Z) = Daught(TargetE, Z)
                                End If
                            End If
                        End If
                        
                        If MinorPar(TargetE, Z) > 0 Then
                            If MinorPar(Replace, Z) = 0 Or (MinorPar(TargetE, Z) > 0 And MinorPar(Replace, Z) > MinorPar(TargetE, Z)) Then
                                MinorPar(Replace, Z) = MinorPar(TargetE, Z)
                            End If
                        End If
                        If MajorPar(TargetE, Z) > 0 Then
                            If MajorPar(Replace, Z) = 0 Or (MajorPar(TargetE, Z) > 0 And MajorPar(Replace, Z) > MajorPar(TargetE, Z)) Then
                                MajorPar(Replace, Z) = MajorPar(TargetE, Z)
                            End If
                        End If
                    Next Z
                    
                    For x = 0 To NextNo
                        For Y = 0 To CurrentXOver(x)
                            If SuperEventList(XoverList(x, Y).Eventnumber) = TargetE Then
                               SuperEventList(XoverList(x, Y).Eventnumber) = Replace
                            End If
                        Next Y
                    Next x
                    If XOMiMaInFileFlag = 1 Then
                    'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
                        oDirX = CurDir
                        ChDrive App.Path
                        ChDir App.Path
                        FF = FreeFile
                        ReDim BestXOListMi(PermNextno, UBXOMi)
                        ReDim BestXOListMa(PermNextno, UBXoMa)
                        UBXoMa = UBound(BestXOListMa, 2)
                        If MiRec < 1 Then
                            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
                            Get #FF, , BestXOListMi()
                            Close #FF
                            MiRec = 1
                        End If
                        If MaRec < 1 Then
                            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
                            Get #FF, , BestXOListMa()
                            Close #FF
                            MaRec = 1
                        End If
                        ChDrive oDirX
                        ChDir oDirX
                        
                    End If
                    For x = 0 To NextNo
                        For Y = 0 To BCurrentXoverMi(x)
                            If SuperEventList(BestXOListMi(x, Y).Eventnumber) = TargetE Then
                               SuperEventList(BestXOListMi(x, Y).Eventnumber) = Replace
                            End If
                        Next Y
                    Next x
                    
                    For x = 0 To NextNo
                        For Y = 0 To BCurrentXoverMa(x)
                            If SuperEventList(BestXOListMa(x, Y).Eventnumber) = TargetE Then
                               SuperEventList(BestXOListMa(x, Y).Eventnumber) = Replace
                            End If
                        Next Y
                    Next x
                    If XOMiMaInFileFlag = 1 Then
                            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
                        
                        Erase BestXOListMa
                        MaRec = MaRec - 1
                        Erase BestXOListMi
                        
                        
                    End If
                    'Dim TP(6) As Double, TN(6) As Long
                    For x = 0 To 6
                        If Confirm(TargetE, x) + Confirm(Replace, x) > 0 Then
                            ConfirmP(Replace, x) = (-Log10(ConfirmP(Replace, x)) * Confirm(Replace, x) + -Log10(ConfirmP(TargetE, x)) * Confirm(TargetE, x)) / (Confirm(TargetE, x) + Confirm(Replace, x))
                            ConfirmP(Replace, x) = 10 ^ -ConfirmP(Replace, x)
                            Confirm(Replace, x) = Confirm(TargetE, x) + Confirm(Replace, x)
                        End If
                        If ConfirmMa(TargetE, x) + ConfirmMa(Replace, x) > 0 Then
                            ConfirmPMa(Replace, x) = (-Log10(ConfirmPMa(Replace, x)) * ConfirmMa(Replace, x) + -Log10(ConfirmPMa(TargetE, x)) * ConfirmMa(TargetE, x)) / (ConfirmMa(TargetE, x) + ConfirmMa(Replace, x))
                            ConfirmPMa(Replace, x) = 10 ^ -ConfirmPMa(Replace, x)
                            ConfirmMa(Replace, x) = ConfirmMa(TargetE, x) + ConfirmMa(Replace, x)
                        End If
                        If ConfirmMi(TargetE, x) + ConfirmMi(Replace, x) > 0 Then
                            ConfirmPMi(Replace, x) = (-Log10(ConfirmPMi(Replace, x)) * Confirm(miReplace, x) + -Log10(ConfirmPMi(TargetE, x)) * ConfirmMi(TargetE, x)) / (ConfirmMi(TargetE, x) + ConfirmMi(Replace, x))
                            ConfirmPMi(Replace, x) = 10 ^ -ConfirmPMi(Replace, x)
                            ConfirmMi(Replace, x) = ConfirmMi(TargetE, x) + ConfirmMi(Replace, x)
                        End If
                    Next x
                    If DebuggingFlag < 2 Then On Error Resume Next
                    UB = 0
                    UB = UBound(BigTreeTraceEvent, 1)
                    For x = 0 To UB
                        If BigTreeTraceEvent(x) = TargetE Then BigTreeTraceEvent(x) = Replace
                    Next x
                    If CurTree(3) = 2 Then
                        Call DrawML5(Form2.Picture2(3), 5)
                    ElseIf CurTree(3) = 3 Then
                        Call DrawML5(Form2.Picture2(3), 5)
                    ElseIf CurTree(3) = 4 Then
                        Call DrawML5(Form2.Picture2(3), 4)
                    End If
                    UB = 0
                    UB = UBound(BigTreeTraceEventU, 1)
                    For x = 0 To UB
                        If BigTreeTraceEventU(x) = TargetE Then BigTreeTraceEventU(x) = Replace
                    Next x
                    If CurTree(3) = 1 Then Call DrawML7(Form2.Picture2(3)) 'DrawFastNJ5(Form2.Picture2(3))
                    On Error GoTo 0
                    
        End If
        
        
        If RIMode = 1 Then
            BestEvent(TargetE, 0) = 0
            BestEvent(TargetE, 1) = 0
            Call MakeSummary
        End If
        x = x
    ElseIf F7Flag = 1 Then
        
        MenuUpFlag = 0
        Dim HiProb As Double, LoProb As Double, XP As Long, YP As Long
        Dim AcProg() As Byte
        ReDim AcProg(AddNum * 2)
        For x = 0 To AddNum - 1
            If DoScans(0, x) = 1 Then AcProg(x) = 1: AcProg(x + AddNum) = 1
            
        Next x
        
        
        Form1.Timer1.Enabled = False
        SEN = CLng(val(Form7.Text1(0)))
        SEN = SEN - 1
        If SEN < 0 Then SEN = 0
        Cycle = 0
RedoFind:
        
        Do
            SEN = SEN + 1
            
            If SEventNumber < SEN Then
                SEN = 1
                Cycle = Cycle + 1
                If Cycle = 2 Then
                    Form1.Timer1.Enabled = True
                    Exit Sub
                End If
            End If
            
            If DebuggingFlag < 2 Then On Error Resume Next
            UB = 0
            UB = UBound(BestEvent, 1)
            If UB < SEN Then Exit Sub
            
            On Error GoTo 0
            
            XP = BestEvent(SEN, 0)
            YP = BestEvent(SEN, 1)
            If YP < 0 Or (XP = 0 And YP = 0) Then GoTo RedoFind
            
            PN = 0
            For x = 0 To AddNum - 1
                If Confirm(SEN, x) > 0 Then PN = PN + 1
                
            Next x
            If PN > ConsensusProg Then
                
                Exit Do
            End If
            
            
        Loop
        
        
        
        
        'Find position of the region on the screen (in picture6)
        XPicAddjust = (Form1.Picture5.ScaleWidth - 10) / Len(StrainSeq(0))
        Dim XS As Long
        If XoverList(XP, YP).Beginning < XoverList(XP, YP).Ending Then
            XS = CLng((XoverList(XP, YP).Beginning + (XoverList(XP, YP).Ending - XoverList(XP, YP).Beginning) / 2) * AdjArrayPos)
        Else
            'XS = CInt((1 + (XOverList(XP, YP).Ending - 1) / 2) * AdjArrayPos)
            XS = 1 'CInt((XOverList(XP, YP).Beginning + (Len(StrainSeq(0)) - XOverList(XP, YP).Beginning) / 2) * AdjArrayPos)
            'If XOverList(XP, YP).Ending > (12 * XPicAddjust) Then
            '    XS = (1 + (XOverList(XP, YP).Ending - 1) / 2) * AdjArrayPos
            'Else
            '    XS = (XOverList(XP, YP).Beginning + (Len(StrainSeq(0)) - XOverList(XP, YP).Beginning) / 2) * AdjArrayPos
            'End If
        End If
        
        If XS = UBound(PermArray, 1) Then XS = XS - 1
        
        GoOn = 0
        For Y = 0 To UBound(PermArray, 2)
        
            If PermArray(0, Y) = XP Then
                '275
                For Z = Y + 2 To UBound(PermArray, 2)
                    If PermArray(0, Z) = -(XP + 1) Then
                        If XS = 1 Then
                            XS = 2
                            For A = Y + 2 To UBound(PermArray, 2)
                                If PermArray(0, A) = -(XP + 1) Then
                                    Exit For
                                End If
                                If PermArray(XS, A) = YP Then ' Or PermArray(XS + 1, A) = YP Then
                                    GoOn = 1
                                    Exit For
                                End If
                            Next A
                        End If
                        If GoOn = 0 Then
                            XoverList(XP, YP).Probability = XoverList(XP, YP).Probability * 0.99999999
                            LoProb = XoverList(XP, YP).Probability
                            HiProb = 1
                            'Exit Sub
                            GoTo RedoFind
                        End If
                        
                    End If
                    
                    If PermArray(XS, Z) = YP Or PermArray(XS + 1, Z) = YP Then
                        PermYVal = (Z * 12 + 3) * SpaceAdjust
                        GoOn = 1
                        Exit For
                    End If
                    'Exit Sub
                    
                Next Z
                'GoOn = 1
                Exit For
            End If
        Next Y
        
        If GoOn = 0 Then
            XoverList(XP, YP).Probability = XoverList(XP, YP).Probability * 0.99999999
            LoProb = XoverList(XP, YP).Probability
            HiProb = 1
            'XOverList(XP, YP).Accept = 2
            GoTo RedoFind
            
            
        End If
        
        exRelX = RelX
        exRely = RelY
        RelX = XP
        RelY = YP
        RecSeq = XP
        PAVal = YP
        
        If XP > 0 Or YP > 0 Then
            
            
            Call GoToThis2(1, XP, YP, PermXVal, PermYVal)

            'Form1.Enabled = True
            'PermXP = XP
            'PermYP = YP
            'Form1.Timer5.Enabled = True
            'DoEvents
            'Form1.Timer5.Enabled = False
        End If
    End If
End If



Form7.Visible = False
Form1.Enabled = True
If Form2.Visible = True Then
    Form2.Enabled = True
End If
Form1.ZOrder
If SEventNumber > 0 Then
    If UBound(BestEvent, 1) >= TargetE Then
        BestEvent(TargetE, 0) = 0
        BestEvent(TargetE, 1) = 0
    End If
End If
End Sub

Private Sub Form_Load()
Form7.Icon = Form1.Icon
End Sub

Private Sub Form_Terminate()
Form1.Enabled = True
Form2.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
Form1.Enabled = True
Form2.Enabled = True
End Sub

Private Sub Text1_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
    Call Command1_Click(0)
End If

End Sub

Private Sub Text1_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyReturn Then
    Call Command1_Click(0)
End If
End Sub
