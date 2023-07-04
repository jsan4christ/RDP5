Attribute VB_Name = "Module8"
'option explicit

' Store WndProcs
Private Declare Function GetProp Lib "user32.dll" Alias "GetPropA" ( _
                ByVal hwnd As Long, _
                ByVal lpString As String) As Long

Private Declare Function SetProp Lib "user32.dll" Alias "SetPropA" ( _
                ByVal hwnd As Long, _
                ByVal lpString As String, _
                ByVal hData As Long) As Long

Private Declare Function RemoveProp Lib "user32.dll" Alias "RemovePropA" ( _
                ByVal hwnd As Long, _
                ByVal lpString As String) As Long

' Hooking
Private Declare Function CallWindowProc Lib "user32.dll" Alias "CallWindowProcA" ( _
                ByVal lpPrevWndFunc As Long, _
                ByVal hwnd As Long, _
                ByVal Msg As Long, _
                ByVal wParam As Long, _
                ByVal lParam As Long) As Long

Private Declare Function SetWindowLong Lib "user32.dll" Alias "SetWindowLongA" ( _
                ByVal hwnd As Long, _
                ByVal nIndex As Long, _
                ByVal dwNewLong As Long) As Long

Private Declare Function SendMessage Lib "user32.dll" Alias "SendMessageA" ( _
                ByVal hwnd As Long, _
                ByVal Msg As Long, _
                wParam As Any, _
                lParam As Any) As Long

' Position Checking
Private Declare Function GetWindowRect Lib "user32" ( _
                ByVal hwnd As Long, _
                lpRect As RECT) As Long
                
Private Declare Function GetParent Lib "user32" ( _
                ByVal hwnd As Long) As Long

Private Const GWL_WNDPROC = -4
Private Const WM_MOUSEWHEEL = &H20A
Private Const CB_GETDROPPEDSTATE = &H157

Private Type RECT
  Left As Long
  Top As Long
  Right As Long
  Bottom As Long
End Type



Private Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
Private Declare Sub SafeArrayAccessData Lib "oleaut32.dll" (ByVal psa As Long, ByRef ppvData As Any)
Private Declare Sub SafeArrayUnaccessData Lib "oleaut32.dll" (ByVal psa As Long)
Private Declare Function SafeArrayGetDim Lib "oleaut32.dll" (ByVal psa As Long) As Long
Private Declare Function SafeArrayGetElemsize Lib "oleaut32.dll" (ByVal psa As Long) As Long

Sub HammingDistance(NucSeq() As String, HammingDistances() As Long)
    Dim i As Long, j As Long, k As Long
    Dim seqLength As Long
    Dim numTrigrams As Long
    Dim trigrams() As String
    Dim iSeq As String, jSeq As String, kSeq As String
    Dim iTrigrams() As String, jTrigrams() As String, kTrigrams() As String
    Dim tempDistances() As Long
    Dim tempDistance As Long
    
    seqLength = Len(NucSeq(0))
    numTrigrams = seqLength - 2
    ReDim HammingDistances(UBound(NucSeq), UBound(NucSeq))
    ReDim tempDistances(UBound(NucSeq))
    
    ' Generate all possible trigrams
    ReDim trigrams(numTrigrams - 1)
    For i = 1 To numTrigrams
        trigrams(i - 1) = Mid(NucSeq(0), i, 3)
    Next i
    
    For i = 0 To UBound(NucSeq)
        iSeq = NucSeq(i)
        ReDim iTrigrams(numTrigrams - 1)
        For j = 1 To numTrigrams
            iTrigrams(j - 1) = Mid(iSeq, j, 3)
        Next j
        
        For j = i To UBound(NucSeq)
            jSeq = NucSeq(j)
            ReDim jTrigrams(numTrigrams - 1)
            For k = 1 To numTrigrams
                jTrigrams(k - 1) = Mid(jSeq, k, 3)
            Next k
            
            tempDistance = 0
            For k = 0 To UBound(NucSeq)
                kSeq = NucSeq(k)
                ReDim kTrigrams(numTrigrams - 1)
                For L = 1 To numTrigrams
                    kTrigrams(L - 1) = Mid(kSeq, L, 3)
                Next L
                
                ' Compare the three trigrams
                tempDistance = 0
                For L = 0 To numTrigrams - 1
                    If iTrigrams(L) <> jTrigrams(L) And iTrigrams(L) <> kTrigrams(L) And jTrigrams(L) <> kTrigrams(L) Then
                        tempDistance = tempDistance + 1
                    End If
                Next L
                tempDistances(k) = tempDistance
            Next k
            
            ' Compute the Hamming distance and store it in the output array
            tempDistance = 0
            For k = 0 To UBound(NucSeq)
                tempDistance = tempDistance + tempDistances(k)
            Next k
            HammingDistances(i, j) = tempDistance
            HammingDistances(j, i) = tempDistance
        Next j
    Next i
End Sub

Public Function Sigmoid(InputV As Double)
Dim Output As Double, eval As Double
eval = 2.71828182845905
Output = 1 / (1 + eval ^ -InputV)

Sigmoid = Output

End Function
Public Sub LogReg()




End Sub



Public Sub InnerScan2(MCCorrectX As Double, STime As Long, SAll As Long, WinPP As Long, SLookup() As Long, ISeqs() As Long, RNum() As Long, RList() As Long, TraceSub() As Long, ActualSeqSize() As Long, SLookupNum() As Long, DoPairs() As Byte, FindallFlag As Long, WinNum As Long, SeqMap() As Byte, ZPScoreHolder() As Double, ZSScoreHolder() As Double, CorrectP As Double, oSeq As Long, PermSScores() As Long, PermPScores() As Long, SScoreHolder() As Long, PScoreHolder() As Long, SeqScore3() As Integer, MeanPScore() As Double, SDPScore() As Double, Seq34Conv() As Byte, VRandConv() As Byte, VRandTemplate() As Byte, HRandTemplate() As Long, TakenPos() As Byte, DG1() As Byte, DG2() As Byte, DoGroupS() As Byte, DoGroupP() As Byte, BackUpNextno As Long, MissingData() As Byte)
Dim oSeq1 As Long, oSeq2 As Long, oSeq3 As Long, b As Long, FF As Long, oDirX As String, LT As Long, GoOn As Byte, IsIn() As Byte
Dim ZZZ As Long, Dummy As Long, TT As Long, xNextno As Long, PBV As Single, oTotRecs As Long, ELT As Long, ETx As Long, x As Long, g As Long, H As Long, WinPPY As Long, A As Long, Y As Long, tSeq1 As Long, tSeq2 As Long, tSeq3 As Long
'XX = BusyWithExcludes
Dim FindAllFlagX As Byte
Dim NumInList As Long
ReDim GPVTFont(5, 100), GPVText(100)
GPVTNum = -1
'XXX = 0
'yyy = 0
'For x = 0 To NextNo
'    XXX = XXX + CurrentXOver(x)
'    For Y = 0 To AddNum - 1
'        yyy = yyy + MaxXOP(Y, x)
'    Next Y
'Next x
'If XXX > 0 Or yyy > 0 Then
'
'End If
'x = x
LT = Abs(GetTickCount)


If PermNextno > MemPoc And (TempTreeDistanceDumpFlag = 1 Or UBound(TreeDistance, 1) = 0) Then
    oDirX = CurDir
    ChDrive App.Path
    ChDir App.Path
    FF = FreeFile
    ReDim TreeDistance(UBTD1, UBTD1)
    Open "RDP5TreeDistance" + UFTag For Binary As #FF
    Get #FF, , TreeDistance
    Close #FF
    ChDrive oDirX
    ChDir oDirX
End If

If UBound(Distance, 1) = 0 And PermNextno > MemPoc And x = 1234567 Then
    
    oDir = CurDir
    ChDir App.Path
    ChDrive App.Path
    
    FF = FreeFile
    'UBDistance = UBound(Distance, 1)
    XX = UBound(SCMat, 1)
    ReDim Distance(UBDistance, UBDistance)
    Open "RDP5Distance" + UFTag For Binary As #FF
    Get #FF, , Distance()
    Close #FF
    'Erase Distance
    ChDir oDir
    ChDrive oDir

End If


If PermNextno > MemPoc Then
    oDirX = CurDir
    ChDrive App.Path
    ChDir App.Path
    FF = FreeFile
    
    ReDim PermValid(UBPermValid, UBPermValid)
    Open "RDP5PermValid" + UFTag For Binary As #FF
    '&
    Get #FF, , PermValid()
    Close #FF
    
    
    ReDim PermDIffs(UBPermDiffs, UBPermDiffs)
    Open "RDP5PermDiffs" + UFTag For Binary As #FF
    Get #FF, , PermDIffs()
    Close #FF
    
    ChDrive oDirX
    ChDir oDirX
End If



LowestProb = pLowestProb
'Form1.Frame17.Visible = True
ReDim SubSeq(Len(StrainSeq(0)), 6)


ReDim XoverList(NextNo, 10)
ReDim CurrentXOver(NextNo)
ReDim MaxXOP(AddNum - 1, NextNo)
Call ResetMaxPVCO(NextNo)

If UseALFlag = 1 And BusyWithExcludes = 0 Then
    'is it necessery to redim this here?
    'XX = UBound(AnalysisList, 2)
    Dim FMatInFileFlag As Byte, UBF1 As Long, UBS1 As Long
    
    
    If TripListLen > 1000000 Then
    
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        UBF1 = 0: UBS1 = 0
        If DebuggingFlag < 2 Then On Error Resume Next
        UBF1 = UBound(FMat, 1)
        UBS1 = UBound(SMat, 1)
        On Error GoTo 0
        If UBS1 > 0 Then
            Open "RDP5SMat" + UFTag For Binary As #FF
            Put #FF, , SMat()
            Close #FF
            ReDim SMat(0, 0)
        End If
        If UBF1 > -1 Then
            Open "RDP5FMat" + UFTag For Binary As #FF
            Put #FF, , FMat()
            Close #FF
            ReDim FMat(0, 0)
        End If
        FMatInFileFlag = 1
        
        'XX = UBound(Analysislist, 2)
        On Error Resume Next
        Do
        
        ReDim Analysislist(2, TripListLen)
        If UBound(Analysislist, 2) < TripListLen Then
            TripListLen = CLng(TripListLen * 0.95)
        Else
            
            
            Exit Do
        End If
        
        Loop
        On Error GoTo 0
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        
        FF = FreeFile
        
        
        
        
        Open "RDP5AnalysisList" + UFTag For Binary As #FF
        Get #FF, , Analysislist
        Close #FF
        
        ChDrive oDirX
        ChDir oDirX
        'Erase AnalysisList
    Else
        '@
        ReDim Preserve Analysislist(2, TripListLen)
        x = x
    End If
    ''
    
    
'    XXX = 0
'            For x = 0 To NextNo
'                XXX = XXX + CurrentXOver(x) '586,225,9411,1210,365
'                '585,350,
'            Next x
'            x = x
    Dim RestartPos() As Long
    ReDim RestartPos(2)
    
    FindAllFlagX = 0
    If DoScans(0, 0) = 1 Or DoScans(0, 1) = 1 Or DoScans(0, 4) = 1 Or DoScans(0, 3) = 1 Then
        
        Dim AList() As Integer
        Dim BAL As Variant, ALC As Long
        Dim RedoL3() As Byte, StepsX As Long, EPX As Long
        Call MakeScanCompressArrays(NextNo, SeqNum())
        Dim UCThresh As Double
        If MCFlag = 0 Then
            UCThresh = LowestProb / MCCorrection
        Else
            UCThresh = LowestProb
        End If
        If DoScans(0, 0) = 1 Then
            ReDim RestartPos(2)
            ReDim XoverSeqNum(Len(StrainSeq(0)), 2)
            ReDim XoverSeqNumW(Len(StrainSeq(0)) + Int(XOverWindowX / 2) * 2, 2)
            'BAL = TripListLen
            BAL = NextNo - (RNum(WinPP) + 1)
            BAL = (BAL + 1) * BAL
            BAL = BAL * (RNum(WinPP) + 1)
            If BAL > TripListLen Then
                BAL = TripListLen
            End If
            If BAL > 10000000 Then
                BAL = 10000000
            End If
            ReDim AList(2, BAL + 3 * RNum(WinPP))
            ALC = -1
            '@'$
            ALC = MakeAListISP2(0, RestartPos(0), UBound(ProgBinRead, 1), ProgBinRead(0, 0), TraceSub(0), WinPP, RNum(0), UBound(RList, 1), RList(0, 0), UBound(Analysislist, 1), Analysislist(0, 0), TripListLen, Worthwhilescan(0), ActualSeqSize(0), PermNextno, NextNo, MinSeqSize, UBound(AList, 1), UBound(AList, 2), AList(0, 0), UBound(DoPairs, 1), DoPairs(0, 0))
            
            If ALC > -1 Then
                ReDim RedoL3(ALC)
                StepsX = CLng(100000000 / Len(StrainSeq(0)))
                UseCompress = 1
                For Y = 0 To ALC Step StepsX
                    If Y + StepsX - 1 > ALC Then
                        EPX = ALC
                    Else
                        EPX = Y + StepsX - 1
                    End If
                    '@'@'@'@'@
                    NumRedos = AlistRDP3(AList(0, 0), ALC, Y, EPX, NextNo, UCThresh, RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(Distance, 1), Distance(0, 0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(FSSRDP, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), SeqNum(0, 0), XoverWindow, XOverWindowX, FSSRDP(0, 0, 0, 0), ProbEstimateInFileFlag, UBound(ProbEstimate, 1), UBound(ProbEstimate, 2), ProbEstimate(0, 0, 0), UBound(Fact3X3, 1), Fact3X3(0, 0, 0), Fact(0))
                    'If NumRedos > 0 Then
                        
                    For x = Y To EPX
    '                    If x = 475 Then
    '                        x = x
    '                    End If
                        If RedoL3(x) > 0 Then
                            Seq1 = AList(0, x)
                            Seq2 = AList(1, x)
                            Seq3 = AList(2, x)
                            
                            ' Print #1, Str(Seq1) + "," + Str(Seq2) + "," + Str(Seq3)
                            ''22,245,285
                            CurrentTripListNum = x
                            Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
                        Else
                            x = x
                        End If
                        x = x
                    Next x
                    'End If
                    
                    
                    ET = Abs(GetTickCount)
                    ET = Abs(ET)
                    If Abs(ET - LT) > 500 Then
                        GlobalTimer = ET
                        LT = ET
                        'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                        Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                        Form1.SSPanel1.Refresh
                        Form1.Refresh
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        
                        If Abs(ET - ELT) > 2000 Then
                            ELT = ET
                            If oTotRecs > 0 Then
                                PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                If PBV > Form1.ProgressBar1 Then
                                    Form1.ProgressBar1 = PBV
                                    Call UpdateF2Prog
                                End If
                            End If
                                    
                        End If
                        xNextno = NextNo
                        
                        DoEvents 'covered by currentlyrunningflag
                        NextNo = xNextno
                        If AbortFlag = 1 Then
                            WinPPY = NextNo
                            g = NextNo
                            H = NextNo
                        End If
                        UpdateRecNums (SEventNumber)
                        
                        Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                        Call UpdateTimeCaps(ET, SAll)
                        
                        
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        If AbortFlag = 1 Then
                            Exit For
                        End If
    
                    End If
                Next Y
                UseCompress = 0
                'End If
            End If
        End If
        
        If DoScans(0, 1) = 1 Then
            GCIndelFlag = 0
            
            ReDim FragMaxScore(GCDimSize, 5)
            ReDim MaxScorePos(GCDimSize, 5)
            ReDim PVals(GCDimSize, 5)
            ReDim FragSt(GCDimSize, 6)
            ReDim FragEn(GCDimSize, 6)
            ReDim FragScore(GCDimSize, 6)
            ReDim DeleteArray(Len(StrainSeq(0)) + 1)
            'BAL = TripListLen
            
            BAL = NextNo - (RNum(WinPP) + 1)
            BAL = (BAL + 1) * BAL
            BAL = BAL * (RNum(WinPP) + 1)
            If BAL > TripListLen Then
                BAL = TripListLen
            End If
            If BAL > 10000000 Then
                BAL = 10000000
            End If
            ReDim AList(2, BAL + 3 * RNum(WinPP))
            ALC = -1
            ReDim RestartPos(2)
            '$'$'$
            ALC = MakeAListISP2(1, RestartPos(0), UBound(ProgBinRead, 1), ProgBinRead(0, 0), TraceSub(0), WinPP, RNum(0), UBound(RList, 1), RList(0, 0), UBound(Analysislist, 1), Analysislist(0, 0), TripListLen, Worthwhilescan(0), ActualSeqSize(0), PermNextno, NextNo, MinSeqSize, UBound(AList, 1), UBound(AList, 2), AList(0, 0), UBound(DoPairs, 1), DoPairs(0, 0))
            If ALC > -1 Then
                ReDim RedoL3(ALC)
                StepsX = CLng(100000000 / Len(StrainSeq(0)))
                UseCompress = 1
                For Y = 0 To ALC Step StepsX
                    If Y + StepsX - 1 > ALC Then
                        EPX = ALC
                    Else
                        EPX = Y + StepsX - 1
                    End If
                    '@'@'@'@'$'$'$'$'$'$'$'$'$'$'$'$'$
                    ' NumRedos = AlistGC(GCIndelFlag, GCMissmatchPen, GCDimSize, AList(0, 0), ALC, Y, EPX, NextNo, CDbl(LowestProb / MCCorrection), RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    'NumRedos = AlistGC(GCIndelFlag, GCMissmatchPen, GCDimSize, Analysislist(0, 0), ALC, Y, EPX, NextNo, UCTHresh,                 RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    NumRedos = AlistGC2(UBound(StoreLPV, 1), StoreLPV(0, 0), GCIndelFlag, GCMissmatchPen, GCDimSize, AList(0, 0), ALC, Y, EPX, NextNo, UCThresh, RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    
                    'If NumRedos > 0 Then
                    '@'@
                    For x = Y To EPX
                        If RedoL3(x) = 1 Then
                            Seq1 = AList(0, x)
                            Seq2 = AList(1, x)
                            Seq3 = AList(2, x)
                            'ZZZ = ZZZ + 1
                            CurrentTripListNum = x
                            ''22,245,285
                             NewOneFound = 0
                            Call GCXoverD(0)
'                            If RedoL3(x) = 2 And NewOneFound = 1 Then
'                                x = x
'                            End If
'                            If NewOneFound = 0 Then
'                                x = x
'                            End If
                        ElseIf RedoL3(x) = 2 Then
                            Call AddToRedoList(1, AList(0, x), AList(1, x), AList(2, x))
                        End If
                    Next x
                    'End If
                    
                    
                    ET = Abs(GetTickCount)
                    ET = Abs(ET)
                    If Abs(ET - LT) > 500 Then
                        GlobalTimer = ET
                        LT = ET
                        'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                        Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                        Form1.SSPanel1.Refresh
                        Form1.Refresh
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        
                        If Abs(ET - ELT) > 2000 Then
                            ELT = ET
                            If oTotRecs > 0 Then
                                PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                If PBV > Form1.ProgressBar1 Then
                                    Form1.ProgressBar1 = PBV
                                    Call UpdateF2Prog
                                End If
                            End If
                                    
                        End If
                        xNextno = NextNo
                        
                        DoEvents 'covered by currentlyrunningflag
                        NextNo = xNextno
                        If AbortFlag = 1 Then
                            WinPPY = NextNo
                            g = NextNo
                            H = NextNo
                        End If
                        UpdateRecNums (SEventNumber)
                        
                        Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                        Call UpdateTimeCaps(ET, SAll)
                        
                        
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        If AbortFlag = 1 Then
                            Exit For
                        End If
    
                    End If
                Next Y
            End If
            UseCompress = 0
               
            
        End If
        If DoScans(0, 3) = 1 Then
            Call SetupMCArrays
            ReDim DeleteArray(Len(StrainSeq(0)) + 1)
            'BAL = TripListLen
            BAL = NextNo - (RNum(WinPP) + 1)
            BAL = (BAL + 1) * BAL
            BAL = BAL * (RNum(WinPP) + 1)
            If BAL > TripListLen Then
                BAL = TripListLen
            End If
            If BAL > 10000000 Then
                BAL = 10000000
            End If
            ReDim AList(2, BAL + 3 * RNum(WinPP))
            ALC = -1
            ReDim RestartPos(2)
            ALC = MakeAListISP2(3, RestartPos(0), UBound(ProgBinRead, 1), ProgBinRead(0, 0), TraceSub(0), WinPP, RNum(0), UBound(RList, 1), RList(0, 0), UBound(Analysislist, 1), Analysislist(0, 0), TripListLen, Worthwhilescan(0), ActualSeqSize(0), PermNextno, NextNo, MinSeqSize, UBound(AList, 1), UBound(AList, 2), AList(0, 0), UBound(DoPairs, 1), DoPairs(0, 0))
            If ALC > -1 Then
                ReDim RedoL3(ALC)
                StepsX = CLng(100000000 / Len(StrainSeq(0)))
                UseCompress = 1
                oepx = -1
                For Y = 0 To ALC Step StepsX
                    If Y + StepsX - 1 > ALC Then
                        EPX = ALC
                    Else
                        EPX = Y + StepsX - 1
                    End If
                    '@'@'@'@'$'$'$'$'$'$'$'$'$'$'$'$'$
                    'NumRedos = AlistGC2(UBound(StoreLPV, 1), StoreLPV(0, 0), GCIndelFlag, GCMissmatchPen, GCDimSize, Analysislist(0, 0), TripListLen, Y, EPX, NextNo, UCTHresh,                        RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    'NumRedos = AlistGC2(UBound(StoreLPV, 1), StoreLPV(0, 0), GCIndelFlag, GCMissmatchPen, GCDimSize, AList(0, 0),        ALC,         Y, EPX, NextNo, CDbl(LowestProb / MCCorrection), RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    HWindowWidth = CLng(MCWinSize / 2)
                    lHWindowWidth = HWindowWidth
                    '@
                    NumRedos = AlistMC3(SEventNumber, Worthwhilescan(0), Y, EPX, LongWindedFlag, ShortOutFlag, MaxABWin, HWindowWidth, lHWindowWidth, CriticalDiff, FindAllFlagX, NextNo, UBound(StoreLPV, 1), StoreLPV(0, 0), AList(0, 0), ALC, RedoL3(0), CircularFlag, MCCorrection, MCFlag, UCThresh, LowestProb, MCWinFract, MCWinSize, MCProportionFlag, Len(StrainSeq(0)), UBound(CompressSeq, 1), CompressSeq(0, 0), UBound(FSSMC, 2), FSSMC(0, 0, 0, 0), SeqNum(0, 0), MissingData(0, 0), Chimap(0), ChiTable2(0))
                    'XX = FindallFlag
                    
                    
                    
                    'If NumRedos > 0 Then
                    '@'@
                    For x = Y To EPX
'                        If x <= oepx Then
'                            x = x
'                        End If
                        
                        If RedoL3(x) = 1 Then 'Or x = x Then
                            Seq1 = AList(0, x)
                            Seq2 = AList(1, x)
                            Seq3 = AList(2, x)
                            'ZZZ = ZZZ + 1
                            CurrentTripListNum = x
                            BQPV = 1
                            ''22,245,285
                            NewOneFound = 0
'                            orl = RedoListSize
                            Call MCXoverF(FindAllFlagX, 0, 0)
'                            If (NewOneFound = 0 And RedoL3(x) > 0) Or (NewOneFound = 1 And RedoL3(x) = 0) Then
'                                x = x
'                            End If
'
                        ElseIf RedoL3(x) = 2 Then
                            Call AddToRedoList(3, AList(0, x), AList(1, x), AList(2, x))
                            
                        End If
                    Next x
                    
                    
                    
                    'End If
                    OY = Y
                    oepx = EPX
                    
                    ET = Abs(GetTickCount)
                    ET = Abs(ET)
                    If Abs(ET - LT) > 500 Then
                        GlobalTimer = ET
                        LT = ET
                        'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                        Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                        Form1.SSPanel1.Refresh
                        Form1.Refresh
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        
                        If Abs(ET - ELT) > 2000 Then
                            ELT = ET
                            If oTotRecs > 0 Then
                                PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                If PBV > Form1.ProgressBar1 Then
                                    Form1.ProgressBar1 = PBV
                                    Call UpdateF2Prog
                                End If
                            End If
                                    
                        End If
                        xNextno = NextNo
                        
                        DoEvents 'covered by currentlyrunningflag
                        NextNo = xNextno
                        If AbortFlag = 1 Then
                            WinPPY = NextNo
                            g = NextNo
                            H = NextNo
                        End If
                        UpdateRecNums (SEventNumber)
                        
                        Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                        Call UpdateTimeCaps(ET, SAll)
                        
                        
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        If AbortFlag = 1 Then
                            Exit For
                        End If
    
                    End If
                Next Y
            End If
            UseCompress = 0
            Call SetupMCArrays
            
        End If
        If DoScans(0, 4) = 1 Then
        
            
        
        
            
            Dim LXOS() As Long
            Dim XDP() As Long, XPD() As Long
            
            HWindowWidth = CLng(CWinSize / 2)
            lHWindowWidth = HWindowWidth
            
            ReDim ScoresX(Len(StrainSeq(0)))  ' 0=s1,s2Matches etc
            ReDim WinScoresX(Len(StrainSeq(0)) + HWindowWidth * 2) ' 0=s1,s2Matches etc
            ReDim ChiValsX(Len(StrainSeq(0)))
            ReDim SmoothChiX(Len(StrainSeq(0)))
            ReDim XDiffPos(Len(StrainSeq(0)) + 200)
            ReDim XPosDiff(Len(StrainSeq(0)) + 200)
            ReDim LXOS(3)
            ReDim XDP(Len(StrainSeq(0)) + 200, 2), XPD(Len(StrainSeq(0)) + 200, 2)
            
            Call GetCriticalDiff(1)
            If CWinSize <> HWindowWidth * 2 And CProportionFlag = 0 Then
                CWinSize = HWindowWidth * 2
            End If
            
            ReDim DeleteArray(Len(StrainSeq(0)) + 1)
            'BAL = TripListLen
            BAL = NextNo - (RNum(WinPP) + 1)
            BAL = (BAL + 1) * BAL
            BAL = BAL * (RNum(WinPP) + 1)
            If BAL > TripListLen / 2 Then
                BAL = TripListLen / 2
            End If
            If BAL > 10000000 Then
                BAL = 10000000
            End If
            ReDim AList(2, BAL + 3 * RNum(WinPP))
            ALC = -1
            ReDim RestartPos(2)
            '$'$'$
            
            
            ALC = MakeAListISP2(4, RestartPos(0), UBound(ProgBinRead, 1), ProgBinRead(0, 0), TraceSub(0), WinPP, RNum(0), UBound(RList, 1), RList(0, 0), UBound(Analysislist, 1), Analysislist(0, 0), TripListLen, Worthwhilescan(0), ActualSeqSize(0), PermNextno, NextNo, MinSeqSize, UBound(AList, 1), UBound(AList, 2), AList(0, 0), UBound(DoPairs, 1), DoPairs(0, 0))
            If ALC > -1 Then
                ReDim RedoL3(ALC)
                StepsX = CLng(100000000 / Len(StrainSeq(0)))
                UseCompress = 1
                oepx = -1
                XX = RedoListSize
                For Y = 0 To ALC Step StepsX
                    If Y + StepsX - 1 > ALC Then
                        EPX = ALC
                    Else
                        EPX = Y + StepsX - 1
                    End If
                    '@'@'@'@'$'$'$'$'$'$'$'$'$'$'$'$'$
                    'NumRedos = AlistGC2(UBound(StoreLPV, 1), StoreLPV(0, 0), GCIndelFlag, GCMissmatchPen, GCDimSize, Analysislist(0, 0), TripListLen, Y, EPX, NextNo, UCTHresh,                        RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    'NumRedos = AlistGC2(UBound(StoreLPV, 1), StoreLPV(0, 0), GCIndelFlag, GCMissmatchPen, GCDimSize, AList(0, 0),        ALC,         Y, EPX, NextNo, CDbl(LowestProb / MCCorrection), RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                    HWindowWidth = CLng(CWinSize / 2)
                    lHWindowWidth = HWindowWidth
                    'NumRedos = AlistMC3(SEventNumber,                  Worthwhilescan(0), Y, EPX, LongWindedFlag, ShortOutFlag, MaxABWin, HWindowWidth, lHWindowWidth, CriticalDiff, 0,             NextNo, UBound(StoreLPV, 1), StoreLPV(0, 0), AList(0, 0), ALC, RedoL3(0), CircularFlag, MCCorrection, MCFlag, CDbl(LowestProb / MCCorrection), LowestProb, MCWinFract, MCWinSize, MCProportionFlag, Len(StrainSeq(0)), UBound(CompressSeq, 1), CompressSeq(0, 0), UBound(FSSMC, 2), FSSMC(0, 0, 0, 0), SeqNum(0, 0), MissingData(0, 0), Chimap(0), ChiTable2(0))
                    
                    NumRedos = AlistChi(SEventNumber, MissingData(0, 0), Worthwhilescan(0), Y, EPX, LongWindedFlag, ShortOutFlag, MaxABWin, HWindowWidth, lHWindowWidth, CriticalDiff, FindAllFlagX, NextNo, UBound(StoreLPV, 1), StoreLPV(0, 0), AList(0, 0), ALC, RedoL3(0), CircularFlag, MCCorrection, MCFlag, UCThresh, LowestProb, CWinFract, CWinSize, CProportionFlag, Len(StrainSeq(0)), UBound(CompressSeq, 1), CompressSeq(0, 0), UBound(FSSRDP, 2), FSSRDP(0, 0, 0, 0), SeqNum(0, 0), Chimap(0), ChiTable2(0))
                    
                    '@'@
                    For x = Y To EPX
                        '1578,4229, 4348
                        
                        CurrentTripListNum = x
                        If RedoL3(x) > 0 Then
                            If ProgBinRead(0, RedoL3(x)) = 1 Then
                                
                                Seq1 = AList(0, x) '0
                                Seq2 = AList(1, x) '31
                                Seq3 = AList(2, x) '83
                                ZZZ = ZZZ + 1
                                BQPV = 1
'                                If Y = 4229 Then
'                                    x = x
'                                End If
                                
                                NewOneFound = 0
                                Call CXoverA(FindAllFlagX, 0, 0)
'                                If (NewOneFound = 0 And ProgBinRead(0, RedoL3(x)) = 1) Or (NewOneFound = 1 And ProgBinRead(0, RedoL3(x)) = 0) Then
'                                    x = x
'                                End If
                                
                            End If
                            If ProgBinRead(2, RedoL3(x)) = 1 Then
                                
                                Seq3 = AList(0, x) '5
                                Seq1 = AList(1, x) '83
                                Seq2 = AList(2, x) '104
                                ZZZ = ZZZ + 1
                                BQPV = 1
                                NewOneFound = 0
                                Call CXoverA(FindAllFlagX, 0, 0)
'                                If (NewOneFound = 0 And ProgBinRead(2, RedoL3(x)) = 1) Or (NewOneFound = 1 And ProgBinRead(2, RedoL3(x)) = 0) Then
'                                    x = x
'                                End If
                            End If
                            If ProgBinRead(4, RedoL3(x)) = 1 Then
                                
                                Seq2 = AList(0, x) '5
                                Seq3 = AList(1, x) '83
                                Seq1 = AList(2, x) '107
                                ZZZ = ZZZ + 1
                                BQPV = 1
                                NewOneFound = 0
                                Call CXoverA(FindAllFlagX, 0, 0)
'                                If (NewOneFound = 0 And ProgBinRead(4, RedoL3(x)) = 1) Or (NewOneFound = 1 And ProgBinRead(4, RedoL3(x)) = 0) Then
'                                    x = x
'                                End If
                            End If
                            If ProgBinRead(1, RedoL3(x)) = 1 Or ProgBinRead(3, RedoL3(x)) = 1 Or ProgBinRead(5, RedoL3(x)) = 1 Then
                                ZZZ = ZZZ + 1
'                                If ProgBinRead(4, Worthwhilescan(x)) = 0 Then
'                                    Worthwhilescan(x) = Worthwhilescan(x) + 5
'                                End If
                                Call AddToRedoList(4, AList(0, x), AList(1, x), AList(2, x))
                            End If
                        End If
                        
                        
                    Next x
                    
                    
                    
                    'End If
                    OY = Y
                    oepx = EPX
                    
                    ET = Abs(GetTickCount)
                    ET = Abs(ET)
                    If Abs(ET - LT) > 500 Then
                        GlobalTimer = ET
                        LT = ET
                        'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                        Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                        Form1.SSPanel1.Refresh
                        Form1.Refresh
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        
                        If Abs(ET - ELT) > 2000 Then
                            ELT = ET
                            If oTotRecs > 0 Then
                                PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                If PBV > Form1.ProgressBar1 Then
                                    Form1.ProgressBar1 = PBV
                                    Call UpdateF2Prog
                                End If
                            End If
                                    
                        End If
                        xNextno = NextNo
                        
                        DoEvents 'covered by currentlyrunningflag
                        NextNo = xNextno
                        If AbortFlag = 1 Then
                            WinPPY = NextNo
                            g = NextNo
                            H = NextNo
                        End If
                        UpdateRecNums (SEventNumber)
                        
                        Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                        Call UpdateTimeCaps(ET, SAll)
                        
                        
                        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                        If AbortFlag = 1 Then
                            Exit For
                        End If
    
                    End If
                Next Y
            End If
            UseCompress = 0
            'Call SetupMCArrays
'            HWindowWidth = CLng(CWinSize / 2)
'            lHWindowWidth = HWindowWidth
'            ReDim ScoresX(Len(StrainSeq(0)))  ' 0=s1,s2Matches etc
'            ReDim WinScoresX(Len(StrainSeq(0)) + HWindowWidth * 2) ' 0=s1,s2Matches etc
'            ReDim ChiValsX(Len(StrainSeq(0)))
'            ReDim SmoothChiX(Len(StrainSeq(0)))
'            ReDim XDiffPos(Len(StrainSeq(0)) + 200)
'            ReDim XPosDiff(Len(StrainSeq(0)) + 200)
'            ReDim LXOS(3)
'            ReDim XDP(Len(StrainSeq(0)) + 200, 2), XPD(Len(StrainSeq(0)) + 200, 2)
            
        End If
'        Close #1
'        XXX = 0
'            For x = 0 To NextNo
'                XXX = XXX + CurrentXOver(x) '586,225,9411,1210,365
'                '585,350,363,5552
'            Next x
'            x = x
'        x = x
'        Open "RecombsNew.csv" For Output As #1
'            For x = 0 To NextNo
'                For Y = 1 To CurrentXOver(x)
'                    Print #1, Str(x) + "," + Str(Y) + "," + Str(XoverList(x, Y).Daughter) + "," + Str(XoverList(x, Y).MinorP) + "," + Str(XoverList(x, Y).MajorP) + ","
'                Next Y
'            Next x
'        Close #1
        x = x
    End If
    ZZZ = 0
    If DoScans(0, 5) = 1 Or DoScans(0, 8) = 1 Then 'Or DoScans(0, 3) = 1 Then  '
        
        'Open "old.csv" For Output As #1
       'XX = LongWindedFlag
'       If DoScans(0, 3) = 1 Then
'        Call SetupMCArrays
'       End If
       
        Call MakeScanCompressArrays(NextNo, SeqNum())
            UseCompress = 1
            GCIndelFlag = 0 'need to use this with compression
        For x = 0 To TripListLen
'            If x = 66886 Then
'                x = x
'            End If
            
            '@'@'@'@'@'@'@'@'@
            If Worthwhilescan(x) > 0 Or BusyWithExcludes = 1 Then
                Seq1 = Analysislist(0, x) '17,17,17,17
                Seq2 = Analysislist(1, x) '686,686,687,687
                Seq3 = Analysislist(2, x) '1531,1798,690, 694,710,822,824,832,913
                CurrentTripListNum = x
                For WinPPY = 0 To RNum(WinPP)
                    '@'@'@'@'@
                    A = RList(WinPP, WinPPY)
                    If A <= PermNextno Then
                        b = A
                    Else
                        b = TraceSub(A)
                    End If
                    If Seq1 = b Or Seq2 = b Or Seq3 = b Then
                        If b = Seq1 Then
                            Seq1 = A
                        ElseIf b = Seq2 Then
                            Seq2 = A
                        ElseIf b = Seq3 Then
                            Seq3 = A
                        End If
                        If ActualSeqSize(Seq1) > MinSeqSize Then
                            If ActualSeqSize(Seq2) > MinSeqSize Then
                                If ActualSeqSize(Seq3) > MinSeqSize Then
                                    If DoPairs(Seq1, Seq2) = 1 And DoPairs(Seq1, Seq3) = 1 And DoPairs(Seq2, Seq3) = 1 Then
'                                         If ProgBinRead(0, Worthwhilescan(x)) = 1 Then
'                                            If DoScans(0, 0) = 1 Then
''                                                If FastRecCheckP(CircularFlag, 0, MCCorrection, MCFlag, 1, (LowestProb / MCCorrection), LowestProb, NextNo, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(Distance, 1), Distance(0, 0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(FSSRDP, 2), UBound(CompressSeq, 1), UBound(XoverSeqNumW, 1), CompressSeq(0, 0), SeqNum(0, 0), Seq1, Seq2, Seq3, Len(StrainSeq(0)) + 1, XoverWindow, XOverWindowX, XoverSeqNum(0, 0), XoverSeqNumW(0, 0), UBound(XOverHomologyNum, 1), XOverHomologyNum(0, 0), FSSRDP(0, 0, 0, 0), ProbEstimateInFileFlag, UBound(ProbEstimate, 1), UBound(ProbEstimate, 2), ProbEstimate(0, 0, 0), UBound(Fact3X3, 1), Fact3X3(0, 0, 0), Fact(0), BQPV) = 1 Then
''                                                   ' Print #1, Str(Seq1) + "," + Str(Seq2) + "," + Str(Seq3)
''                                                    Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
''                                                End If
''                                                x = x
'                                            End If
'                                         End If
                                         'XX = UseCompress
                                         'XX = GCIndelFlag
'                                         If ProgBinRead(1, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
''                                            ReDim XDiffPos(Len(StrainSeq(0)) + 200)
''                                            ReDim XPosDiff(Len(StrainSeq(0)) + 200)
''                                            ReDim FragMaxScore(GCDimSize, 5)
''                                            ReDim MaxScorePos(GCDimSize, 5)
''                                            ReDim PVals(GCDimSize, 5)
''                                            ReDim FragSt(GCDimSize, 6)
''                                            ReDim FragEn(GCDimSize, 6)
''                                            ReDim FragScore(GCDimSize, 6)
''                                            ReDim DeleteArray(Len(StrainSeq(0)) + 1)
'                                            NewOneFound = 0
'                                            If DoScans(0, 1) = 1 Then Call GCXoverD(0)
'                                            x = x
'
'                                         End If
'                                         If ProgBinRead(2, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
'                                            If DoScans(0, 2) = 1 Then
'                                                Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
'                                            End If
'                                         End If
'                                         If ProgBinRead(3, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
'                                            If DoScans(0, 3) = 1 Then
'                                                NewOneFound = 0
'                                                Call MCXoverF(FindAllFlagX, 0, 0)
'
''                                                If (RedoL3(ZZZ) = 0 And NewOneFound = 1) Or (RedoL3(ZZZ) > 0 And NewOneFound = 0) Then
''                                                    x = x
''                                                    XX = AList(0, ZZZ) '0,105,149
''                                                    XX = AList(1, ZZZ)
''                                                    XX = AList(2, ZZZ)
''
''                                                End If
''                                                ZZZ = ZZZ + 1
''                                                x = x
'                                            End If
'                                        End If

'                                         If ProgBinRead(4, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
'                                            If DoScans(0, 4) = 1 Then
'
'                                                tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                Call CXoverA(FindAllFlagX, 0, 0)
'
'                                                Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                Call CXoverA(FindAllFlagX, 0, 0)
'
'                                                Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                Call CXoverA(FindAllFlagX, 0, 0)
'
'                                                Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                            End If
'                                        End If
                                         
                                         If ProgBinRead(6, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
                                            If DoScans(0, 8) = 1 Then
                                                tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
                                                        
                                                Call TSXOver(0)
                                                        
                                                Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
                                                        
                                                Call TSXOver(0)
                                                        
                                                Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
                                                        
                                                Call TSXOver(0)
                                                        
                                                Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
                                            End If
                                        End If
                                         If ProgBinRead(5, Worthwhilescan(x)) = 1 Or BusyWithExcludes = 1 Then
                                            If DoScans(0, 5) = 1 Then
                                                oSeq1 = Seq1: oSeq2 = Seq2: oSeq3 = Seq3
                                                Call SSXoverC(CLng(0), CLng(WinNum), SeqMap(), ZPScoreHolder(), ZSScoreHolder(), CorrectP, oSeq, PermSScores(), PermPScores(), SScoreHolder(), PScoreHolder(), TraceSub(), SeqScore3(), MeanPScore(), SDPScore(), Seq34Conv(), VRandConv(), VRandTemplate(), HRandTemplate(), TakenPos(), DG1(), DG2(), DoGroupS(), DoGroupP())
                                                Seq1 = oSeq1: Seq2 = oSeq2: Seq3 = oSeq3
                                            End If
                                        End If
                                    End If
                                
                                End If
                            End If
                        End If
                    End If
                    '@
                Next WinPPY
                ETx = Abs(GetTickCount)
                If Abs(ETx - GlobalTimer) > 500 Then
                                
                    GlobalTimer = ETx
                    'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                    Form1.SSPanel1.Caption = Trim(Str(x)) & " of " & Trim(Str(TripListLen)) & " triplets reexamined"
                    Form1.SSPanel1.Refresh
                    Form1.Refresh
                    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                    
                    If Abs(ETx - ELT) > 2000 Then
                        ELT = ETx
                        If oTotRecs > 0 Then
                            PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                            If PBV > Form1.ProgressBar1 Then
                                Form1.ProgressBar1 = PBV
                                Call UpdateF2Prog
                            End If
                        End If
                                
                    End If
                    xNextno = NextNo
                    
                    DoEvents 'covered by currentlyrunningflag
                    NextNo = xNextno
                    If AbortFlag = 1 Then
                        WinPPY = NextNo
                        g = NextNo
                        H = NextNo
                    End If
                    UpdateRecNums (SEventNumber)
                    
                    Form1.Label50(12).Caption = DoTimeII(Abs(ETx - STime))
                    Call UpdateTimeCaps(ETx, SAll)
                    
                    
                    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                    If AbortFlag = 1 Then
                        Exit For
                    End If
                    
                End If
            End If
            '@'@
        Next x
        UseCompress = 0
'        Close #1
'        Open "RecombsOld.csv" For Output As #1
'            For x = 0 To NextNo
'                For Y = 1 To CurrentXOver(x)
'                    Print #1, Str(x) + "," + Str(Y) + "," + Str(XoverList(x, Y).Daughter) + "," + Str(XoverList(x, Y).MinorP) + "," + Str(XoverList(x, Y).MajorP) + ","
'                Next Y
'            Next x
'        Close #1
'         XXX = 0
'            For x = 0 To NextNo
'                XXX = XXX + CurrentXOver(x) '586,225,9411,1210,365
'                '585,350,363,5552
'            Next x
'
'        If DoScans(0, 3) = 1 Then
'            Call SetupMCArrays
'        End If
'        If DoScans(0, 4) = 1 Then
'            'Call SetupMCArrays
'             HWindowWidth = CLng(CWinSize / 2)
'            lHWindowWidth = HWindowWidth
'            ReDim ScoresX(Len(StrainSeq(0)))  ' 0=s1,s2Matches etc
'            ReDim WinScoresX(Len(StrainSeq(0)) + HWindowWidth * 2) ' 0=s1,s2Matches etc
'            ReDim ChiValsX(Len(StrainSeq(0)))
'            ReDim SmoothChiX(Len(StrainSeq(0)))
'            ReDim XDiffPos(Len(StrainSeq(0)) + 200)
'            ReDim XPosDiff(Len(StrainSeq(0)) + 200)
'            ReDim LXOS(3)
'            ReDim XDP(Len(StrainSeq(0)) + 200, 2), XPD(Len(StrainSeq(0)) + 200, 2)
'        End If
    End If
    
    If DoScans(0, 2) = 1 Then
        For WinPPY = 0 To RNum(WinPP)
            Seq1 = RList(WinPP, WinPPY)
            GoOn = 0
            If IndividualA = TraceSub(ISeqs(WinPP)) Or IndividualB = TraceSub(ISeqs(WinPP)) Then
                If TraceSub(Seq1) = IndividualA Or TraceSub(Seq1) = IndividualB Then
                    GoOn = 1
                End If
            Else
                GoOn = 1
            End If
    
            GoOn = 1
            Dim oG As Long
            If Seq1 > UBound(MaskSeq, 1) Then ReDim Preserve MaskSeq(Seq1 + 10)
            If GoOn = 1 And ActualSeqSize(Seq1) > MinSeqSize And MaskSeq(Seq1) = 0 Then
                ReDim IsIn(NextNo)
                For x = 0 To WinPPY
                    IsIn(RList(WinPP, x)) = 1
                Next x
            
                For g = 1 To SLookupNum(0)
                    Seq2 = SLookup(0, g)
                    If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize Then
                        If IsIn(Seq2) = 0 And DoPairs(Seq1, Seq2) = 1 Then
                            For H = g + 1 To SLookupNum(1)
                                Seq3 = SLookup(1, H)
                                If ActualSeqSize(Seq3) > MinSeqSize Then
                                    If IsIn(Seq3) = 0 Then
                                        If DoPairs(Seq2, Seq3) = 1 Then '
                                            If PermValid(Seq1, Seq2) > MinSeqSize And PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
                                                            
                                                        'If FastestFlag = 0 Then
                                                             Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
                                                        'Else
                                                        '
                                                        '    NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
                                                        '    If ProgBinRead(2, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
                                                        '        Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
                                                        '    End If
                                                        'End If
                                                    
                                                        '
                                                        
                                                        b = b + 1
                                                        
                                                  
                                                'End If
                                            End If
                                            
                                        'Else
                                        '    X = X
                                        End If
                                    End If
                                End If
                                ET = Abs(GetTickCount)
                                '
                                If Abs(ET - GlobalTimer) > 500 Then
                                    If AbortFlag = 1 Then Exit For
                                    GlobalTimer = ET
                                    Form1.SSPanel1.Caption = Trim(Str(b)) & " of " & Trim(Str(MCCorrectX)) & " triplets reexamined"
                                    If Abs(ET - ELT) > 2000 Then
                                        ELT = ET
                                        If oTotRecs > 0 Then
                                            PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                            If PBV > Form1.ProgressBar1 Then
                                                Form1.ProgressBar1 = PBV
                                                Call UpdateF2Prog
                                            End If
                                        End If
                                                
                                    End If
                                    
                                    
                                    
                                    
                                    If AbortFlag = 1 Then
                                        WinPPY = NextNo
                                        g = NextNo
                                        H = NextNo
                                    End If
                                    UpdateRecNums (SEventNumber)
                                    Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                                    Call UpdateTimeCaps(ET, SAll)
                                    Form1.Refresh
                                    xNextno = NextNo
                                    
                                    DoEvents 'covered by currentlyrunningflag
                                    Form1.WindowState = Form1.WindowState
                                    NextNo = xNextno
                                End If
                            Next H
                        End If
                    End If
                    If AbortFlag = 1 Then Exit For
                Next g
            End If
        Next WinPPY
    
    End If
    
    
'    Dim TStr As String
'    TStr = ""
'    Open "TestOut.csv" For Append As #47
'    If SEventNumber = 1 Then
'        TStr = "Event numnber, RedolistSiz"
'
'        For x = 0 To NextNo
'            TStr = TStr + "," + Str(x)
'        Next x
'        Print #47, TStr
'    End If
'
'    TStr = Str(SEventNumber) + "," + Str(RedoListSize)
'
'    For x = 0 To NextNo
'        TStr = TStr + "," + Str(CurrentXOver(x))
'    Next x
'    Print #47, TStr
'    Close #47
    
    TT = Abs(GetTickCount)
    If TT - GlobalTimer > 500 Then
      GlobalTimer = TT
        Form1.SSPanel1.Caption = Trim(Str(TripListLen)) & " of " & Trim(Str(TripListLen)) & " triplets reexamined"
    '    Form1.SSPanel1.Refresh
    '    Form1.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    'DoEvents
    End If
    If TripListLen > 1000000 Then
        Erase Analysislist
        
    End If
    If FMatInFileFlag = 1 Then
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        
        If UBS1 > 0 Then
            ReDim SMat(UBS1, UBS1)
            Open "RDP5SMat" + UFTag For Binary As #FF
            Get #FF, , SMat()
            Close #FF
        End If
        If UBF1 > 0 Then
            ReDim FMat(UBF1, UBF1)
            Open "RDP5FMat" + UFTag For Binary As #FF
            Get #FF, , FMat()
            Close #FF
        End If
        FMatInFileFlag = 0
    End If
    
'ElseIf BusyWithExcludes = 0 Then
'    'For aaa = 1 To 10
'
'
'    ReDim BinArray(Len(StrainSeq(0)), NextNo)
'    Dim GoOnG() As Byte, ExitDoFlag As Byte, UB As Long, ElementNum As Long, LenXOverSeqG() As Long, ElementSeq() As Long, ElementSeq2() As Long, XPosDiffG() As Long, XDiffPosG() As Long, AHG() As Long, XOverSeqnumWG() As Byte
'    Dim GrpTest As Long
'    Dim SpacerSeqsG() As Integer, ValidSpacerG() As Integer, SpacerNoG() As Integer
'
'    Dim NDiffG() As Long, SubSeqG() As Byte
'    Dim FragStG() As Long, FragEnG() As Long, FragScoreG() As Long, FragCountG() As Long
'    Dim HiFragScoreG() As Long, FragMaxScoreG() As Long, MaxScorePosG() As Long, MissPenG() As Double
'
'
'
'    GroupSize = 31
'    If (((Len(StrainSeq(0)) + 200) * GroupSize) > 5000000) Then
'        GroupSize = CLng(GroupSize / (((Len(StrainSeq(0)) + 200) * GroupSize) / 5000000))
'    End If
'    If (DoScans(0, 0) = 1 Or DoScans(0, 1) = 1) And BusyWithExcludes = 0 Then
'        ReDim ElementSeq(GroupSize)
'        ReDim ElementSeq2(GroupSize)
'        ReDim XPosDiffG(Len(StrainSeq(0)) + 200, GroupSize)
'        ReDim XDiffPosG(Len(StrainSeq(0)) + 200, GroupSize)
'        ReDim GoOnG(GroupSize)
'        ReDim LenXOverSeqG(GroupSize)
'    End If
'    If DoScans(0, 0) = 1 And BusyWithExcludes = 0 Then
'        ReDim AHG(2, GroupSize), XOverSeqnumWG(UBound(XoverSeqNumW, 1), UBound(XoverSeqNumW, 2), GroupSize + 1)
'        UB = UBound(TreeDistance, 1)
'        ReDim SpacerSeqsG(UB, GroupSize), ValidSpacerG(UB, GroupSize), SpacerNoG(GroupSize)
'        ReDim Preserve MaskSeq(UB)
'
'
'        'ReDim XPosDiffG(Len(StrainSeq(0)) + 200, GroupSize), ElementSeq(GroupSize), ElementSeq2(GroupSize)
'    End If
'    '@
'    If DoScans(0, 1) = 1 And GCDimSize < 20000 And BusyWithExcludes = 0 Then
'        ReDim SubSeqG(Len(StrainSeq(0)), 6, GroupSize), NDiffG(6, GroupSize)
'        '@
'        ReDim FragStG(GCDimSize, 6, GroupSize), FragEnG(GCDimSize, 6, GroupSize), FragScoreG(GCDimSize, 6, GroupSize), FragCountG(6, GroupSize)
'        ReDim HiFragScoreG(5, GroupSize), FragMaxScoreG(GCDimSize, 5, GroupSize), MaxScorePosG(GCDimSize, 5, GroupSize), MissPenG(5, GroupSize)
'
'        'ReDim XPosDiffG(Len(StrainSeq(0)) + 200, GroupSize), ElementSeq(GroupSize), ElementSeq2(GroupSize)
'    End If
'
'    For WinPPY = 0 To RNum(WinPP)
'      'For Seq1 = 0 To Nextno
'        'scan seqx against all the rest
'        ' ie similar to individualA scan
'
'        Seq1 = RList(WinPP, WinPPY)
'
'        GoOn = 0
'        If IndividualA = TraceSub(ISeqs(WinPP)) Or IndividualB = TraceSub(ISeqs(WinPP)) Then
'            If TraceSub(Seq1) = IndividualA Or TraceSub(Seq1) = IndividualB Then
'                GoOn = 1
'            End If
'        Else
'            GoOn = 1
'        End If
'
'        GoOn = 1
'        Dim oG As Long
'        If Seq1 > UBound(MaskSeq, 1) Then ReDim Preserve MaskSeq(Seq1 + 10)
'        If GoOn = 1 And ActualSeqSize(Seq1) > MinSeqSize And MaskSeq(Seq1) = 0 Then
'
'            ReDim IsIn(NextNo)
'            For x = 0 To WinPPY
'                IsIn(RList(WinPP, x)) = 1
'            Next x
'            If IndividualA = -1 And IndividualB = -1 Then
'
'
'                'XX = UBound(BinArray, 2)
'
'                If (DoScans(0, 0) = 1 Or DoScans(0, 1) = 1) And BusyWithExcludes = 0 Then
'
'
'
'
'                    Dummy = MakeBinArray2P(UBound(PermValid, 1), PermValid(0, 0), UBound(DoPairs, 1), DoPairs(0, 0), Seq1, Len(StrainSeq(0)), NextNo, MaskSeq(0), SeqNum(0, 0), BinArray(0, 0), SLookupNum(0), SLookup(0, 0), IsIn(0), TraceSub(0), ActualSeqSize(0), MinSeqSize)
'                    If DoScans(0, 0) = 1 Then 'Do RDP
'                        'If DoScans(0, 0) = 1 Then
''                            ReDim AHG(2, GroupSize), XOverSeqnumWG(UBound(XoverSeqNumW, 1), UBound(XoverSeqNumW, 2), GroupSize + 1)
''                            UB = UBound(TreeDistance, 1)
''                            ReDim SpacerSeqsG(UB, GroupSize), ValidSpacerG(UB, GroupSize), SpacerNoG(GroupSize)
''                            ReDim Preserve Maskseq(UB)
''                            ReDim XDiffPosG(Len(StrainSeq(0)) + 200, GroupSize), GoOnG(GroupSize)
'                            'ReDim LenXOverSeqG(GroupSize)
'
'                       ' End If
'                        'ReDim LenXOverSeqG(GroupSize)
'                        ReDim GoOnG(GroupSize)  'this needs to be flushed
'                        For g = 1 To SLookupNum(0)
'                            Seq2 = SLookup(0, g)
'                            If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize Then
'                                If IsIn(Seq2) = 0 And DoPairs(Seq1, Seq2) = 1 Then
'
'
'
'                                    H = g
'                                    ExitDoFlag = 0
'                                    Do
'                                        ElementNum = -1
'
'                                        Do
'
'                                            H = H + 1
'                                            If H > SLookupNum(1) Then
'                                                Do
'                                                    g = g + 1
'                                                    If g > SLookupNum(0) Then
'                                                        ExitDoFlag = 1
'                                                        Exit Do
'                                                    End If
'                                                    Seq2 = SLookup(0, g)
'                                                    If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize And DoPairs(Seq1, Seq2) = 1 Then
'                                                        If IsIn(Seq2) = 0 Then
'                                                            H = g + 1
'                                                            If H > SLookupNum(1) Then
'                                                                ExitDoFlag = 1
'                                                                Exit Do
'                                                            Else
'                                                                Exit Do
'                                                            End If
'
'                                                        End If
'                                                    End If
'
'                                                Loop
'                                                If ExitDoFlag = 1 Then Exit Do
'                                                'Exit Do
'                                            End If
'                                            Seq3 = SLookup(1, H)
'                                            'If ExitDoFLag = 0 Then
'
'
'                                            If ActualSeqSize(Seq3) > MinSeqSize Then
'                                                If IsIn(Seq3) = 0 Then
'                                                    If DoPairs(Seq2, Seq3) = 1 Then '
'                                                        If PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
'                                                            GoOn = 1
'                                                            If SelGrpFlag > 0 Then
'                                                                GrpTest = GrpMaskSeq(Seq1) + GrpMaskSeq(Seq2) + GrpMaskSeq(Seq3)
'                                                                If GrpTest >= 2 Then
'                                                                    GoOn = 0
'                                                                End If
'                                                            End If
'                                                            If GoOn = 1 And FastestFlag = 1 Then
'                                                                NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'                                                                If ProgBinRead(0, Worthwhilescan(NumInList)) = 0 And BusyWithExcludes = 0 Then
'                                                                    GoOn = 0
'                                                                End If
'                                                            End If
'                                                            If GoOn = 1 Then
'                                                                ElementNum = ElementNum + 1
'                                                                ElementSeq(ElementNum) = Seq3
'                                                                ElementSeq2(ElementNum) = Seq2
'                                                            End If
'                                                        End If
'                                                    End If
'                                                End If
'                                            'Dummy = MakeBinArrayP(Seq2, Len(StrainSeq(0)), Nextno, Maskseq(0), SeqNum(0, 0), BinArray2(0, 0))
'                                            'For Seq3 = Seq2 + 1 To Nextno
'                                            End If
'                                            If ElementNum = GroupSize Then Exit Do
'                                        Loop
'                                        If ElementNum > -1 Then
'                                            ReDim GoOnG(ElementNum)
'                                            For x = 0 To ElementNum
'
'                                                Seq3 = ElementSeq(x)
'                                                Seq2 = ElementSeq2(x)
'                                                GoOnG(x) = 1
'
'                                                If SpacerFlag > 0 Then
'                                                    If SpacerFlag < 4 Then
'                                                        UB = UBound(TreeDistance, 1)
'
'                                                       InRangeFlag = SpacerFindB(UB, SpacerFlag, MiDistance, MaDistance, Seq1, Seq2, Seq3, Outlyer, SpacerNoG(x), TreeDistance(0, 0), Distance(0, 0), MaskSeq(0), SpacerSeqsG(0, x), ValidSpacerG(0, x))
'
'
'                                                        If InRangeFlag = 0 Then GoOnG(x) = 0
'                                                    ElseIf SpacerFlag = 4 Then
'                                                        SpacerNoG(x) = 1
'                                                        SpacerSeqsG(1, x) = Spacer4No
'                                                    End If
'
'
'
'                                                    'Find Information rich subsequences (takes 11/21)
'
'                                                    If SpacerNoG(x) = 0 Then
'                                                        GoOnG(x) = 0
'                                                    End If
'                                                End If
'
'
'                                            Next x
'                                           ' ReDim XOverSeqnumWG(UBound(XOverSeqnumWG, 1), UBound(XOverSeqnumWG, 2), UBound(XOverSeqnumWG, 3))
'                                            'WARNING: lenstrainseq here actually equals len(strainseq(0))+1
'                                            '@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@'@
'                                            '@
'                                            Dummy = FindSubSeqP8(UBound(XOverSeqnumWG, 1), UBound(XOverSeqnumWG, 2), UBound(XOverSeqnumWG, 3), LenXOverSeqG(0), ElementNum, GoOnG(0), AHG(0, 0), SpacerFlag, Outlyer, XoverWindow, LenStrainSeq, NextNo, Seq1, ElementSeq2(0), ElementSeq(0), SpacerNoG(0), SeqNum(0, 0), XOverSeqnumWG(0, 0, 0), SpacerSeqsG(0, 0), XDiffPosG(0, 0), XPosDiffG(0, 0), ValidSpacerG(0, 0), BinArray(0, 0))
'
'                '                                         XX = XDiffposG(2000, 1)
'                '                                         XX = LenXoverSeqG(1)
'                                            '@
'                                            For x = 0 To ElementNum
'
'                                                Seq3 = ElementSeq(x)
'                                                Seq2 = ElementSeq2(x)
'                                                'If Maskseq(Seq3) = 0 Then
''                                                XX = OriginalName(Seq1)
''                                                XX = OriginalName(Seq2)
''                                                XX = OriginalName(Seq3)
'                                                    LastY3 = -1
'                                                    b = b + 1
'                                                    ZZZ = ZZZ + 1
'                                                    'aaa = Abs(GetTickCount)
'                                                    'For X = 1 To 20                                            '
'                                                    If LenXOverSeqG(x) >= XoverWindow * 2 Then
'
'                                                        Call XOverV(0, x, LenXOverSeqG(x), SpacerNoG(x), AHG(), XOverSeqnumWG(), SpacerSeqsG(), XDiffPosG(), XPosDiffG(), ValidSpacerG(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                                    End If
'                                                    x = x
'                                                    'If DoScans(0, 3) = 1 Then Call MCXoverFIV(X, LenXoverSeqG(X), 0, 0, 0)
'                                            Next x
'    '                                    Else
'    '                                        For X = 0 To ElementNum
'    '                                            Seq3 = ElementSeq(X)
'    '                                            If DoScans(0, 0) = 1 Then
'    '                                                If FastestFlag = 1 Then
'    '
'    '                                                    NuminList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'    '                                                    If ProgBinRead(0, Worthwhilescan(NuminList)) = 1 Then
'    '                                                        Call XOver(SeqNum(), Seq1, Seq2, Seq3, 0)
'    '                                                        Unmissedscans = Unmissedscans + 1
'    '                                                    Else
'    '                                                        MissedScans = MissedScans + 1
'    '                                                    End If
'    '                                                Else
'    '                                                    Call XOver(SeqNum(), Seq1, Seq2, Seq3, 0)
'    '                                                End If
'    '
'    '                                            End If
'    '                                        Next X
'                                        End If
'                                        If ExitDoFlag = 1 Then Exit Do
'                                    Loop
'
'                                End If
'
'                            End If
'                        Next g
'                    End If
'                    If DoScans(0, 1) = 1 And GCDimSize < 20000 And BusyWithExcludes = 0 Then  'Do geneconv
'                        'If DoScans(0, 1) = 1 Then
''                            ReDim SubSeqG(Len(StrainSeq(0)), 6, GroupSize), NDiffG(6, GroupSize)
''                            ReDim FragStG(GCDimSize, 6, GroupSize), FragEnG(GCDimSize, 6, GroupSize), FragScoreG(GCDimSize, 6, GroupSize), FragCountG(6, GroupSize)
''                            ReDim HiFragScoreG(5, GroupSize), FragMaxScoreG(GCDimSize, 5, GroupSize), MaxScorePosG(GCDimSize, 5, GroupSize), MissPenG(5, GroupSize)
''                            ReDim XDiffPosG(Len(StrainSeq(0)) + 200, GroupSize), GoOnG(GroupSize)
'                            'ReDim LenXOverSeqG(GroupSize)
'                        'End If
'                        ReDim GoOnG(GroupSize) 'this needs to be flushed
'                        'ReDim LenXOverSeqG(GroupSize)
'                        For g = 1 To SLookupNum(0)
'                            Seq2 = SLookup(0, g)
'                            If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize Then
'                                If IsIn(Seq2) = 0 And DoPairs(Seq1, Seq2) = 1 Then
'
'
'
'                                    H = g
'                                    ExitDoFlag = 0
'                                    Do
'                                        ElementNum = -1
'
'                                        Do
'
'                                            H = H + 1
'                                            If H > SLookupNum(1) Then
'                                                Do
'                                                    g = g + 1
'                                                    If g > SLookupNum(0) Then
'                                                        ExitDoFlag = 1
'                                                        Exit Do
'                                                    End If
'                                                    Seq2 = SLookup(0, g)
'                                                    If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize And DoPairs(Seq1, Seq2) = 1 Then
'                                                        If IsIn(Seq2) = 0 Then
'                                                            H = g + 1
'                                                            If H > SLookupNum(1) Then
'                                                                ExitDoFlag = 1
'                                                                Exit Do
'                                                            Else
'                                                                Exit Do
'                                                            End If
'
'                                                        End If
'                                                    End If
'
'                                                Loop
'                                                If ExitDoFlag = 1 Then Exit Do
'                                                'Exit Do
'                                            End If
'                                            Seq3 = SLookup(1, H)
'                                            'If ExitDoFLag = 0 Then
'
'
'                                            If ActualSeqSize(Seq3) > MinSeqSize Then
'                                                If IsIn(Seq3) = 0 Then
'                                                    If DoPairs(Seq2, Seq3) = 1 Then '
'                                                        If PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
'                                                            GoOn = 1
'                                                            If SelGrpFlag > 0 Then
'                                                                GrpTest = GrpMaskSeq(Seq1) + GrpMaskSeq(Seq2) + GrpMaskSeq(Seq3)
'                                                                If GrpTest >= 2 Then
'                                                                    GoOn = 0
'                                                                End If
'                                                            End If
'                                                            If GoOn = 1 And FastestFlag = 1 Then
'                                                                NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'                                                                '@
'                                                                If ProgBinRead(1, Worthwhilescan(NumInList)) = 0 And BusyWithExcludes = 0 Then
'                                                                    GoOn = 0
'                                                                End If
'                                                            End If
'                                                            If GoOn = 1 Then
'                                                                ElementNum = ElementNum + 1
'                                                                ElementSeq(ElementNum) = Seq3
'                                                                ElementSeq2(ElementNum) = Seq2
'                                                            End If
'                                                        End If
'                                                    End If
'                                                End If
'                                            'Dummy = MakeBinArrayP(Seq2, Len(StrainSeq(0)), Nextno, Maskseq(0), SeqNum(0, 0), BinArray2(0, 0))
'                                            'For Seq3 = Seq2 + 1 To Nextno
'                                            End If
'                                            If ElementNum = GroupSize Then Exit Do
'                                        Loop
'                                        If ElementNum > -1 Then
'                                            'ReDim GoOnG(ElementNum)
'                                            'ReDim NDiffG(6, GroupSize)
'
'                                           ' ReDim XOverSeqnumWG(UBound(XOverSeqnumWG, 1), UBound(XOverSeqnumWG, 2), UBound(XOverSeqnumWG, 3))
'                                            'WARNING: lenstrainseq here actually equals len(strainseq(0))+1
'                                            '
'                                            'Dummy = FindSubSeqP8(UBound(XOverSeqnumWG, 1), UBound(XOverSeqnumWG, 2), UBound(XOverSeqnumWG, 3), LenXOverSeqG(0), ElementNum, GoOnG(0), AHG(0, 0), SpacerFlag, Outlyer, XoverWindow, LenStrainSeq, Nextno, Seq1, ElementSeq2(0), ElementSeq(0), SpacerNoG(0), SeqNum(0, 0), XOverSeqnumWG(0, 0, 0), SpacerSeqsG(0, 0), XDiffPosG(0, 0), XPosDiffG(0, 0), ValidSpacerG(0, 0), BinArray(0, 0))
'                                            '@
'                                            Dummy = FindSubSeqGCAP4(UBound(NDiffG, 1), UBound(XPosDiffG, 1), UBound(SubSeqG, 1), UBound(SubSeqG, 2), ElementNum, LenXOverSeqG(0), GCIndelFlag, Len(StrainSeq(0)), Seq1, ElementSeq2(0), ElementSeq(0), SeqNum(0, 0), SubSeqG(0, 0, 0), XPosDiffG(0, 0), XDiffPosG(0, 0), NDiffG(0, 0), BinArray(0, 0))
''                                           Open "Test GCAP3.csv" For Output As #1
''                                            For X = 0 To ElementNum
''                                               ' For Y = 0 To 6
''                                                    Print #1, " "
''                                                    'For Z = 0 To LenXOverSeqG(X)
''                                                    For Z = 0 To Len(StrainSeq(0))
''                                                        'Print #1, SubSeqG(Z, Y, X)
''                                                        Print #1, XDiffPosG(Z, X)
''                                                    Next Z
''                                               ' Next Y
''
''                                            Next X
'
''                                            Close #1
'                                            Dummy = GetFragsP2(GoOnG(0), ElementNum, UBound(FragCountG, 1), UBound(FragScoreG, 1), UBound(FragScoreG, 2), UBound(SubSeq, 1), UBound(SubSeq, 2), CircularFlag, LenXOverSeqG(0), Len(StrainSeq(0)), GCDimSize, SubSeqG(0, 0, 0), FragStG(0, 0, 0), FragEnG(0, 0, 0), FragScoreG(0, 0, 0), FragCountG(0, 0))
'                                            GetMaxFragScoreP2 ElementNum, LenXOverSeqG(0), GCDimSize, CircularFlag, GCMissmatchPen, MissPenG(0, 0), MaxScorePosG(0, 0, 0), FragMaxScoreG(0, 0, 0), FragScoreG(0, 0, 0), FragCountG(0, 0), HiFragScoreG(0, 0), NDiffG(0, 0)
'
'                                            For x = 0 To ElementNum
'
'                                                Seq3 = ElementSeq(x)
'                                                Seq2 = ElementSeq2(x)
'                                                'If Maskseq(Seq3) = 0 Then
'
'                                                    LastY3 = -1
'                                                    b = b + 1
'                                                    ZZZ = ZZZ + 1
'                                                    'aaa = Abs(GetTickCount)
'                                                    'For X = 1 To 20                                            '
'                                                    If LenXOverSeqG(x) > 0 Then
'
'                                                        'Call GCXoverDV(X, FragStG(), FragEnG(), FragScoreG(), FragCountG(), LenXOverSeqG(X), NDiffG(), XPosDiffG(), XDiffPosG(), SubSeqG(), 0)
'                                                        Call GCXoverDVI(HiFragScoreG(), FragMaxScoreG(), MaxScorePosG(), MissPenG(), x, FragStG(), FragEnG(), FragCountG(), LenXOverSeqG(x), NDiffG(), XPosDiffG(), XDiffPosG(), SubSeqG(), 0)
'                                                    End If
'                                                    'If DoScans(0, 3) = 1 Then Call MCXoverFIV(X, LenXoverSeqG(X), 0, 0, 0)
'                                            Next x
'    '                                    Else
'    '                                        For X = 0 To ElementNum
'    '                                            Seq3 = ElementSeq(X)
'    '                                            If DoScans(0, 0) = 1 Then
'    '                                                If FastestFlag = 1 Then
'    '
'    '                                                    NuminList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'    '                                                    If ProgBinRead(0, Worthwhilescan(NuminList)) = 1 Then
'    '                                                        Call XOver(SeqNum(), Seq1, Seq2, Seq3, 0)
'    '                                                        Unmissedscans = Unmissedscans + 1
'    '                                                    Else
'    '                                                        MissedScans = MissedScans + 1
'    '                                                    End If
'    '                                                Else
'    '                                                    Call XOver(SeqNum(), Seq1, Seq2, Seq3, 0)
'    '                                                End If
'    '
'    '                                            End If
'    '                                        Next X
'                                        End If
'                                        If ExitDoFlag = 1 Then Exit Do
'                                    Loop
'
'                                End If
'
'                            End If
'                        Next g
'                    End If
'                End If
'
'
'                If BusyWithExcludes = 1 Or (DoScans(0, 2) = 1 Or DoScans(0, 3) = 1 Or DoScans(0, 4) = 1 Or DoScans(0, 5) = 1 Or DoScans(0, 8) = 1 Or (DoScans(0, 1) = 1 And GCDimSize >= 20000)) Then
'                    For g = 1 To SLookupNum(0)
'                        Seq2 = SLookup(0, g)
'                        If ActualSeqSize(Seq2) > MinSeqSize And PermValid(Seq1, Seq2) > MinSeqSize Then
'                            If IsIn(Seq2) = 0 And DoPairs(Seq1, Seq2) = 1 Then
'
'
'                                For H = g + 1 To SLookupNum(1)
'
'
'
'                                    Seq3 = SLookup(1, H)
'                                    If ActualSeqSize(Seq3) > MinSeqSize Then
'                                        If IsIn(Seq3) = 0 Then
'                                            If DoPairs(Seq2, Seq3) = 1 Then '
'                                                If PermValid(Seq1, Seq2) > MinSeqSize And PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
'                                                    'If X = X Or SubValid(Seq1, Seq2) > 20 And SubValid(Seq1, Seq3) > 20 And SubValid(Seq2, Seq3) > 20 Then
'
'                                                        If (TraceSub(Seq1) <> TraceSub(Seq2) And TraceSub(Seq1) <> TraceSub(Seq3) And TraceSub(Seq2) <> TraceSub(Seq3)) Or BusyWithExcludes = 1 Then
'        '                                                     AA = Abs(GetTickCount)
'        '                                                    For zzz = 1 To 100
'                                                            If DoScans(0, 0) = 1 And BusyWithExcludes = 1 Then
'                                                                If FastestFlag = 1 Then
'
'                                                                    NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'                                                                    If ProgBinRead(0, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                        Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                                                        Unmissedscans = Unmissedscans + 1
'                                                                    Else
'                                                                        MissedScans = MissedScans + 1
'                                                                    End If
'                                                                Else
'                                                                    Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                                                End If
'
'                                                            End If
'        '                                                    Next zzz
'        '                                                    BB = Abs(GetTickCount)
'        '                                                    CC = BB - AA
'
'                                                           If FastestFlag = 1 Then
'                                                                NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'                                                            End If
'
'
'
'
'
'                                                             If (DoScans(0, 1) = 1 And GCDimSize >= 20000) Or BusyWithExcludes = 1 Then
'                                                             'XX = UBound(Worthwhilescan, 1)
'                                                                 'Call GCXoverD(0)
'                                                                 If FastestFlag = 0 Then
'                                                                     Call GCXoverD(0)
'                                                                 Else
'
'                                                                     If ProgBinRead(1, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                        Call GCXoverD(0)
'
'                                                                     End If
'                                                                 End If
'                                                             End If
'
'
'
'                                                             If DoScans(0, 2) = 1 Then
'
'                                                                 If FastestFlag = 0 Then
'                                                                      Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
'                                                                 Else
'
'                                                                     If ProgBinRead(2, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                         Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
'                                                                     End If
'                                                                 End If
'                                                             End If
'                                                             '
'                                                             If DoScans(0, 3) = 1 Then
'
'                                                                 If FastestFlag = 0 Then
'                                                                     Call MCXoverF(0, 0, 0)
'                                                                 Else
'
'                                                                     If ProgBinRead(3, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                        Call MCXoverF(0, 0, 0)
'                                                                     End If
'                                                                 End If
'                                                             End If
'                                                            '
'                                                             If DoScans(0, 4) = 1 Then
'
'                                                                 If FastestFlag = 0 Then
'                                                                      tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                                     Call CXoverA(0, 0, 0)
'
'                                                                     Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                                     Call CXoverA(0, 0, 0)
'
'                                                                     Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                                     Call CXoverA(0, 0, 0)
'
'                                                                     Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                                 Else
'
'                                                                     If ProgBinRead(4, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                         tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                                         Call CXoverA(0, 0, 0)
'
'                                                                         Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                                         Call CXoverA(0, 0, 0)
'
'                                                                         Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                                         Call CXoverA(0, 0, 0)
'
'                                                                         Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                                     End If
'                                                                 End If
'
'
'
'                                                             End If
'
'
'
'
'                                                             If DoScans(0, 8) = 1 Then
'
'                                                                 If FastestFlag = 0 Then
'                                                                      tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                                     Call TSXOver(0)
'
'                                                                     Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                                     Call TSXOver(0)
'
'                                                                     Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                                     Call TSXOver(0)
'
'                                                                     Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                                 Else
'
'                                                                     If ProgBinRead(6, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                         tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                                         Call TSXOver(0)
'
'                                                                         Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                                         Call TSXOver(0)
'
'                                                                         Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                                         Call TSXOver(0)
'
'                                                                         Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                                     End If
'                                                                 End If
'
'
'                                                             End If
'                                                             If DoScans(0, 5) = 1 Then
'
'                                                                 If FastestFlag = 0 Then
'                                                                     oSeq1 = Seq1: oSeq2 = Seq2: oSeq3 = Seq3
'                                                                     Call SSXoverC(CLng(0), CLng(WinNum), SeqMap(), ZPScoreHolder(), ZSScoreHolder(), CorrectP, oSeq, PermSScores(), PermPScores(), SScoreHolder(), PScoreHolder(), TraceSub(), SeqScore3(), MeanPScore(), SDPScore(), Seq34Conv(), VRandConv(), VRandTemplate(), HRandTemplate(), TakenPos(), DG1(), DG2(), DoGroupS(), DoGroupP())
'                                                                     Seq1 = oSeq1: Seq2 = oSeq2: Seq3 = oSeq3
'                                                                 Else
'
'                                                                     If ProgBinRead(5, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                         oSeq1 = Seq1: oSeq2 = Seq2: oSeq3 = Seq3
'                                                                         Call SSXoverC(CLng(0), CLng(WinNum), SeqMap(), ZPScoreHolder(), ZSScoreHolder(), CorrectP, oSeq, PermSScores(), PermPScores(), SScoreHolder(), PScoreHolder(), TraceSub(), SeqScore3(), MeanPScore(), SDPScore(), Seq34Conv(), VRandConv(), VRandTemplate(), HRandTemplate(), TakenPos(), DG1(), DG2(), DoGroupS(), DoGroupP())
'                                                                         Seq1 = oSeq1: Seq2 = oSeq2: Seq3 = oSeq3
'                                                                     End If
'                                                                 End If
'
'                                                             End If
'
'
'
'                                                            b = b + 1
'
'                                                        End If
'
'                                                    'End If
'                                                End If
'
'                                            'Else
'                                            '    X = X
'                                            End If
'                                        End If
'                                    End If
'                                    ET = Abs(GetTickCount)
'                                    '
'                                    If Abs(ET - GlobalTimer) > 500 Then
'                                        If AbortFlag = 1 Then Exit For
'                                        GlobalTimer = ET
'                                        Form1.SSPanel1.Caption = Trim(Str(b)) & " of " & Trim(Str(MCCorrectX)) & " triplets reexamined"
'                                        If Abs(ET - ELT) > 2000 Then
'                                            ELT = ET
'                                            If oTotRecs > 0 Then
'                                                PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
'                                                If PBV > Form1.ProgressBar1 Then
'                                                    Form1.ProgressBar1 = PBV
'                                                    Call UpdateF2Prog
'                                                End If
'                                            End If
'
'                                        End If
'
'
'
'
'                                        If AbortFlag = 1 Then
'                                            WinPPY = NextNo
'                                            g = NextNo
'                                            H = NextNo
'                                        End If
'                                        UpdateRecNums (SEventNumber)
'                                        Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
'                                        Call UpdateTimeCaps(ET, SAll)
'                                        Form1.Refresh
'                                        xNextno = NextNo
'
'                                        DoEvents 'covered by currentlyrunningflag
'                                        Form1.WindowState = Form1.WindowState
'                                        NextNo = xNextno
'                                    End If
'                                Next H
'                            End If
'                        End If
'                        If AbortFlag = 1 Then Exit For
'                    Next g
'                End If
'            Else
'            'For Seq2 = Seq1 + 1 To Nextno
'                For g = 1 To SLookupNum(0)
'                    Seq2 = SLookup(0, g)
'                    If ActualSeqSize(Seq2) > MinSeqSize Then
'                        If IsIn(Seq2) = 0 Then
'                            For H = g + 1 To SLookupNum(1)
'                                Seq3 = SLookup(1, H)
'                                If ActualSeqSize(Seq3) > MinSeqSize Then
'                                    If IsIn(Seq3) = 0 Then
'                                        If DoPairs(Seq2, Seq3) = 1 Then '
'                                            If PermValid(Seq1, Seq2) > MinSeqSize And PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
'                                                'If X = X Or SubValid(Seq1, Seq2) > 20 And SubValid(Seq1, Seq3) > 20 And SubValid(Seq2, Seq3) > 20 Then
'
'                                                    If TraceSub(Seq1) <> TraceSub(Seq2) And TraceSub(Seq1) <> TraceSub(Seq3) And TraceSub(Seq2) <> TraceSub(Seq3) Then
'    '                                                     AA = Abs(GetTickCount)
'    '                                                    For zzz = 1 To 100
'                                                        If DoScans(0, 0) = 1 Then
'                                                            If FastestFlag = 1 Then
'
'                                                                NumInList = GetNumInList(TraceSub(Seq1), TraceSub(Seq2), TraceSub(Seq3))
'                                                                If ProgBinRead(0, Worthwhilescan(NumInList)) = 1 Or BusyWithExcludes = 1 Then
'                                                                    Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                                                    Unmissedscans = Unmissedscans + 1
'                                                                Else
'                                                                    MissedScans = MissedScans + 1
'                                                                End If
'                                                            Else
'                                                                Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                                                x = x
'                                                            End If
'
'                                                        End If
'    '                                                    Next zzz
'    '                                                    BB = Abs(GetTickCount)
'    '                                                    CC = BB - AA
'                                                        '
'                                                        If DoScans(0, 1) = 1 Then Call GCXoverD(0)
'
'
'                                                        If DoScans(0, 2) = 1 Then
'                                                                'BSStepsize = BSStepsize
'                                                            Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
'                                                        End If
'
'                                                        If DoScans(0, 3) = 1 Then Call MCXoverF(0, 0, 0)
'
'
'                                                        If DoScans(0, 4) = 1 Then
'                                                            tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                            Call CXoverA(0, 0, 0)
'
'                                                            Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                            Call CXoverA(0, 0, 0)
'
'                                                            Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                            Call CXoverA(0, 0, 0)
'
'                                                            Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                        End If
'                                                        If DoScans(0, 8) = 1 Then
'                                                            tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                                            Call TSXOver(0)
'
'                                                            Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                                            Call TSXOver(0)
'
'                                                            Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                                            Call TSXOver(0)
'
'                                                            Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                                        End If
'                                                        If DoScans(0, 5) = 1 Then
'                                                            oSeq1 = Seq1: oSeq2 = Seq2: oSeq3 = Seq3
'                                                            Call SSXoverC(CLng(0), CLng(WinNum), SeqMap(), ZPScoreHolder(), ZSScoreHolder(), CorrectP, oSeq, PermSScores(), PermPScores(), SScoreHolder(), PScoreHolder(), TraceSub(), SeqScore3(), MeanPScore(), SDPScore(), Seq34Conv(), VRandConv(), VRandTemplate(), HRandTemplate(), TakenPos(), DG1(), DG2(), DoGroupS(), DoGroupP())
'                                                            Seq1 = oSeq1: Seq2 = oSeq2: Seq3 = oSeq3
'                                                        End If
'                                                        b = b + 1
'
'                                                    End If
'
'                                                'End If
'                                            End If
'
'                                        'Else
'                                        '    X = X
'                                        End If
'                                    End If
'                                End If
'                                ET = Abs(GetTickCount)
'                                '
'                                If Abs(ET - GlobalTimer) > 500 Then
'                                    If AbortFlag = 1 Then Exit For
'                                    GlobalTimer = ET
'                                    Form1.SSPanel1.Caption = Trim(Str(b)) & " of " & Trim(Str(MCCorrectX)) & " triplets reexamined"
'                                    If Abs(ET - ELT) > 2000 Then
'                                        ELT = ET
'                                        If oTotRecs > 0 Then
'                                            PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
'                                            If PBV > Form1.ProgressBar1 Then
'                                                Form1.ProgressBar1 = PBV
'                                                Call UpdateF2Prog
'                                            End If
'                                        End If
'
'                                    End If
'
'
'
'
'                                    If AbortFlag = 1 Then
'                                        WinPPY = NextNo
'                                        g = NextNo
'                                        H = NextNo
'                                    End If
'                                    UpdateRecNums (SEventNumber)
'                                    Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
'                                    Call UpdateTimeCaps(ET, SAll)
'                                    Form1.Refresh
'                                    xNextno = NextNo
'                                    DoEvents 'covered by currentlyrunning flag
'                                    NextNo = xNextno
'                                End If
'                            Next H
'                        End If
'                    End If
'                    If AbortFlag = 1 Then Exit For
'                Next g
'            End If
'        End If
'        If BusyWithExcludes = 1 Then
'            For x = 0 To NextNo
'                For Y = 1 To CurrentXOver(x)
'                    If XoverList(x, Y).MajorP > PermNextno And XoverList(x, Y).Daughter > PermNextno Then
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
'                        XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
'                    ElseIf XoverList(x, Y).MinorP > PermNextno And XoverList(x, Y).Daughter > PermNextno Then
'                        XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
'                    ElseIf XoverList(x, Y).MinorP > PermNextno And XoverList(x, Y).MajorP > PermNextno Then
'                        XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
'                    ElseIf XoverList(x, Y).MajorP > PermNextno Then
'                        XoverList(x, Y).EndP = 0
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
'                    ElseIf XoverList(x, Y).MinorP > PermNextno Then
'                        XoverList(x, Y).EndP = 0
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
'                    ElseIf XoverList(x, Y).Daughter > PermNextno Then
'                        XoverList(x, Y).EndP = 0
'                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
'                    'XX = XoverList(x, Y).EndP '0
'                    End If
''                    'XoverList(x, Y).EndP = OriginalPos(Seq)
''                    If XoverList(x, Y).MajorP > PermNextno Then
''                        'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).MajorP)
''                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (x + 1))
''                    ElseIf XoverList(x, Y).MinorP > PermNextno Then
''                        'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).MinorP)
''                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (x + 1))
''                    ElseIf XoverList(x, Y).Daughter > PermNextno Then
''                        'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).Daughter)
''                        XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (x + 1))
''                    End If
'                Next Y
'            Next x
'        End If
'
'        If AbortFlag = 1 Then Exit For
'    Next WinPPY
'    TT = Abs(GetTickCount)
'    If TT - GlobalTimer > 500 Then
'      GlobalTimer = TT
'    'Next aaa
'        Form1.SSPanel1.Caption = Trim(Str(MCCorrection)) & " of " & Trim(Str(MCCorrection)) & " triplets reexamined"
'    '    Form1.SSPanel1.Refresh
'    '    Form1.Refresh
'        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
'    End If
ElseIf BusyWithExcludes = 1 Then
    oDWS = DontWorryAboutSplitsFlag
    DontWorryAboutSplitsFlag = 1
    Dim Spos1 As Long, spos2 As Long
    'If (NextNo - PermNextno) > 100 Then 'probably worthwhile to do sequence compression
    
    'End If
    If DoScans(0, 0) = 1 Then
        ReDim XoverSeqNumW(Len(StrainSeq(0)) + Int(XOverWindowX / 2) * 2, 2)
    End If
    'Dim RestartPos() As Long
    ReDim RestartPos(2)
    If DoScans(0, 3) = 1 Then
        Call SetupMCArrays
    End If
    If DoScans(0, 0) = 1 Or DoScans(0, 1) = 1 Or DoScans(0, 3) = 1 Or DoScans(0, 4) = 1 Then
        BAL = (PermNextno + 1)
        BAL = BAL * (NextNo)
        BAL = BAL * (NextNo - 1)
        BAL = BAL / 6 + 1
        
        If BAL <= 6000000 Then
            ReDim AList(2, BAL)
        Else
            ReDim AList(2, 6000000)
        End If
        'Dim AList2() As Integer
        'ReDim AList2(2, BAL)
        'ReDim AList(2, BAL)
        Dim ProgP As Single, ProgS As Single
        ProgS = 0
        Do While RestartPos(0) > -1
            'If x = x Then
                ALC = MakeAListISE(RestartPos(0), PermNextno, NextNo, MinSeqSize, UBound(AList, 1), AList(0, 0), UBound(DoPairs, 1), DoPairs(0, 0), UBound(PermValid, 1), PermValid(0, 0))
                
'            Else
'
'
'                ALC = -1
'                For Seq1 = 0 To PermNextno
'                    For Seq2 = Seq1 + 1 To NextNo
'                        If DoPairs(Seq1, Seq2) = 1 Then
'                        If Seq1 <> Seq2 Then
'                            If Seq2 > PermNextno Then
'                                Spos = Seq2 + 1
'                            Else
'                                Spos = PermNextno + 1
'                            End If
'                            For Seq3 = Spos To NextNo
'                                If DoPairs(Seq1, Seq3) = 1 And DoPairs(Seq2, Seq3) = 1 Then
'                                    If Seq1 <= UBound(PermValid, 2) And Seq2 <= UBound(PermValid, 2) And Seq3 <= UBound(PermValid, 2) Then
'                                        If PermValid(Seq1, Seq2) > MinSeqSize And PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
'                                            If Seq1 <= NextNo And Seq2 <= NextNo And Seq3 <= NextNo Then
'                                                ALC = ALC + 1
'    '                                            If ALC = 260 Then
'    '                                                x = x
'    '                                            End If
'                                                AList(0, ALC) = Seq1
'                                                AList(1, ALC) = Seq2
'                                                AList(2, ALC) = Seq3
'    '                                            XX = AList2(0, ALC)
'    '                                            XX = AList2(1, ALC)
'    '                                            XX = AList2(2, ALC)
'    '                                            x = x
'                                            End If
'                                        End If
'                                    End If
'
'                                End If
'                            Next Seq3
'                        End If
'                        End If
'                    Next Seq2
'                Next Seq1
'            End If
    '        For Y = 0 To ALC
    '        For x = 0 To 2
    '            If AList(x, Y) <> AList2(x, Y) Then
    '                x = x
    '            End If
    '            If AList2(1, Y) > PermNextno Then
    '                x = x
    '            End If
    '
    '        Next x
    '
    '        Next Y
            If ALC > -1 Then
            
                If RestartPos(0) = -1 Then
                    PropP = 1
                Else
                    PropP = PermNextno - RestartPos(0) - 1
                End If
                
                If PropP > 1 Or PropP = 0 Then PropP = 1
                Call MakeScanCompressArrays(NextNo, SeqNum())
                UseCompress = 1
                'ReDim Preserve AList(2, ALC)
                
                StepsX = CLng(100000000 / Len(StrainSeq(0)))
                FindAllFlagX = 0
                If DoScans(0, 0) = 1 Then
                    ReDim RedoL3(ALC)
                    
                    For Y = 0 To ALC Step StepsX
                        If Y + StepsX - 1 > ALC Then
                            EPX = ALC
                        Else
                            EPX = Y + StepsX - 1
                        End If
                        '@'@'@'@
                        NumRedos = AlistRDP3(AList(0, 0), ALC, Y, EPX, NextNo, CDbl(LowestProb / MCCorrection), RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(Distance, 1), Distance(0, 0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(FSSRDP, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), SeqNum(0, 0), XoverWindow, XOverWindowX, FSSRDP(0, 0, 0, 0), ProbEstimateInFileFlag, UBound(ProbEstimate, 1), UBound(ProbEstimate, 2), ProbEstimate(0, 0, 0), UBound(Fact3X3, 1), Fact3X3(0, 0, 0), Fact(0))
                        'If NumRedos > 0 Then
                            
                        For x = Y To EPX
        '                    If x = 475 Then
        '                        x = x
        '                    End If
                            If RedoL3(x) > 0 Then
                                Seq1 = AList(0, x)
                                Seq2 = AList(1, x)
                                Seq3 = AList(2, x)
                                
                                ' Print #1, Str(Seq1) + "," + Str(Seq2) + "," + Str(Seq3)
                                ''22,245,285
                                Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
                            Else
                                x = x
                            End If
                            
                            
                        Next x
                        'End If
                        
                        
                        ET = Abs(GetTickCount)
                        ET = Abs(ET)
                        If Abs(ET - LT) > 500 Then
                            GlobalTimer = ET
                            LT = ET
                            'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                            Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                            Form1.SSPanel1.Refresh
                            Form1.Refresh
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            
                            If Abs(ET - ELT) > 2000 Then
                                ELT = ET
                                If oTotRecs > 0 Then
                                    PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                    If PBV > Form1.ProgressBar1 Then
                                        Form1.ProgressBar1 = PBV
                                        Call UpdateF2Prog
                                    End If
                                End If
                                        
                            End If
                            xNextno = NextNo
                            
                            DoEvents 'covered by currentlyrunningflag
                            NextNo = xNextno
                            If AbortFlag = 1 Then
                                WinPPY = NextNo
                                g = NextNo
                                H = NextNo
                            End If
                            UpdateRecNums (SEventNumber)
                            
                            Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                            Call UpdateTimeCaps(ET, SAll)
                            
                            
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            If AbortFlag = 1 Then
                                Exit For
                            End If
        
                        End If
                    Next Y
                End If
                If DoScans(0, 1) = 1 Then
                    ReDim RedoL3(ALC)
                    
                    For Y = 0 To ALC Step StepsX
                        If Y + StepsX - 1 > ALC Then
                            EPX = ALC
                        Else
                            EPX = Y + StepsX - 1
                        End If
                        '@'@'@'@
                        NumRedos = AlistGC(GCIndelFlag, GCMissmatchPen, GCDimSize, AList(0, 0), ALC, Y, EPX, NextNo, CDbl(LowestProb / MCCorrection), RedoL3(0), CircularFlag, MCCorrection, MCFlag, LowestProb, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(FSSGC, 2), UBound(CompressSeq, 1), CompressSeq(0, 0), FSSGC(0, 0, 0, 0))
                        'If NumRedos > 0 Then
                        '@'@
                        For x = Y To EPX
                            If RedoL3(x) > 0 Then
                                Seq1 = AList(0, x)
                                Seq2 = AList(1, x)
                                Seq3 = AList(2, x)
                                NewOneFound = 0
                                Call GCXoverD(0)
                            End If
                        Next x
                        
                        ET = Abs(GetTickCount)
                        ET = Abs(ET)
                        If Abs(ET - LT) > 500 Then
                            GlobalTimer = ET
                            LT = ET
                            'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                            Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                            Form1.SSPanel1.Refresh
                            Form1.Refresh
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            
                            If Abs(ET - ELT) > 2000 Then
                                ELT = ET
                                If oTotRecs > 0 Then
                                    PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                    If PBV > Form1.ProgressBar1 Then
                                        Form1.ProgressBar1 = PBV
                                        Call UpdateF2Prog
                                    End If
                                End If
                                        
                            End If
                            xNextno = NextNo
                            
                            DoEvents 'covered by currentlyrunningflag
                            NextNo = xNextno
                            If AbortFlag = 1 Then
                                WinPPY = NextNo
                                g = NextNo
                                H = NextNo
                            End If
                            UpdateRecNums (SEventNumber)
                            
                            Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                            Call UpdateTimeCaps(ET, SAll)
                            
                            
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            If AbortFlag = 1 Then
                                Exit For
                            End If
        
                        End If
                    Next Y
                End If
                
                If DoScans(0, 3) = 1 Then 'And x = 12345 Then
                    HWindowWidth = CLng(MCWinSize / 2)
                    lHWindowWidth = HWindowWidth
                    ReDim RedoL3(ALC)
                    For Y = 0 To ALC Step StepsX
                        If Y + StepsX - 1 > ALC Then
                            EPX = ALC
                        Else
                            EPX = Y + StepsX - 1
                        End If
                        HWindowWidth = CLng(MCWinSize / 2)
                        lHWindowWidth = HWindowWidth
                        NumRedos = AlistMC3(SEventNumber, Worthwhilescan(0), Y, EPX, LongWindedFlag, ShortOutFlag, MaxABWin, HWindowWidth, lHWindowWidth, CriticalDiff, FindAllFlagX, NextNo, UBound(StoreLPV, 1), StoreLPV(0, 0), AList(0, 0), ALC, RedoL3(0), CircularFlag, MCCorrection, MCFlag, CDbl(LowestProb / MCCorrection), LowestProb, MCWinFract, MCWinSize, MCProportionFlag, Len(StrainSeq(0)), UBound(CompressSeq, 1), CompressSeq(0, 0), UBound(FSSMC, 2), FSSMC(0, 0, 0, 0), SeqNum(0, 0), MissingData(0, 0), Chimap(0), ChiTable2(0))
                        For x = Y To EPX
                            If RedoL3(x) > 0 Then
                                Seq1 = AList(0, x)
                                Seq2 = AList(1, x)
                                Seq3 = AList(2, x)
                                CurrentTripListNum = x
                                BQPV = 1
                                NewOneFound = 0
                                Call MCXoverF(FindAllFlagX, 0, 0)
'                                If (RedoL3(x) = 0 And NewOneFound = 1) Or (RedoL3(x) > 0 And NewOneFound = 0) Then
'                                    x = x
'                                End If
'                            ElseIf RedoL3(x) = 2 Then
'                                Call AddToRedoList(3, AList(0, x), AList(1, x), AList(2, x))
'
                            End If
                        Next x
                        
                        
                        
                        'End If
                        OY = Y
                        oepx = EPX
                        
                        ET = Abs(GetTickCount)
                        ET = Abs(ET)
                        If Abs(ET - LT) > 500 Then
                            GlobalTimer = ET
                            LT = ET
                            'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                            Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                            Form1.SSPanel1.Refresh
                            Form1.Refresh
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            
                            If Abs(ET - ELT) > 2000 Then
                                ELT = ET
                                If oTotRecs > 0 Then
                                    PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                    If PBV > Form1.ProgressBar1 Then
                                        Form1.ProgressBar1 = PBV
                                        Call UpdateF2Prog
                                    End If
                                End If
                                        
                            End If
                            xNextno = NextNo
                            
                            DoEvents 'covered by currentlyrunningflag
                            NextNo = xNextno
                            If AbortFlag = 1 Then
                                WinPPY = NextNo
                                g = NextNo
                                H = NextNo
                            End If
                            UpdateRecNums (SEventNumber)
                            
                            Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                            Call UpdateTimeCaps(ET, SAll)
                            
                            
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            If AbortFlag = 1 Then
                                Exit For
                            End If
        
                        End If
                    Next Y
                    
                End If
                If DoScans(0, 4) = 1 Then
                    HWindowWidth = CLng(CWinSize / 2)
                    lHWindowWidth = HWindowWidth
                    ReDim RedoL3(ALC)
                    For Y = 0 To ALC Step StepsX
                        If Y + StepsX - 1 > ALC Then
                            EPX = ALC
                        Else
                            EPX = Y + StepsX - 1
                        End If
                        HWindowWidth = CLng(CWinSize / 2)
                        lHWindowWidth = HWindowWidth
                        NumRedos = AlistChi(SEventNumber, MissingData(0, 0), Worthwhilescan(0), Y, EPX, LongWindedFlag, ShortOutFlag, MaxABWin, HWindowWidth, lHWindowWidth, CriticalDiff, FindAllFlagX, NextNo, UBound(StoreLPV, 1), StoreLPV(0, 0), AList(0, 0), ALC, RedoL3(0), CircularFlag, MCCorrection, MCFlag, CDbl(LowestProb / MCCorrection), LowestProb, CWinFract, CWinSize, CProportionFlag, Len(StrainSeq(0)), UBound(CompressSeq, 1), CompressSeq(0, 0), UBound(FSSRDP, 2), FSSRDP(0, 0, 0, 0), SeqNum(0, 0), Chimap(0), ChiTable2(0))
                        For x = Y To EPX
                            
                            If RedoL3(x) > 0 Then
                                If ProgBinRead(0, RedoL3(x)) = 1 Or ProgBinRead(1, RedoL3(x)) = 1 Then
                                    CurrentTripListNum = x
                                    Seq1 = AList(0, x) '0
                                    Seq2 = AList(1, x) '31
                                    Seq3 = AList(2, x) '83
                                    ZZZ = ZZZ + 1
                                    BQPV = 1
    '                                If Y = 4229 Then
    '                                    x = x
    '                                End If
                                    
                                    NewOneFound = 0
                                    Call CXoverA(FindAllFlagX, 0, 0)
    '                                If (NewOneFound = 0 And ProgBinRead(0, RedoL3(x)) = 1) Or (NewOneFound = 1 And ProgBinRead(0, RedoL3(x)) = 0) Then
    '                                    x = x
    '                                End If
                                    
                                End If
                                If ProgBinRead(2, RedoL3(x)) = 1 Or ProgBinRead(3, RedoL3(x)) Then
                                    
                                    Seq3 = AList(0, x) '5
                                    Seq1 = AList(1, x) '83
                                    Seq2 = AList(2, x) '104
                                    ZZZ = ZZZ + 1
                                    BQPV = 1
                                    NewOneFound = 0
                                    Call CXoverA(FindAllFlagX, 0, 0)
                                End If
                                If ProgBinRead(4, RedoL3(x)) = 1 Or ProgBinRead(5, RedoL3(x)) Then
                                    
                                    Seq2 = AList(0, x) '5
                                    Seq3 = AList(1, x) '83
                                    Seq1 = AList(2, x) '107
                                    ZZZ = ZZZ + 1
                                    BQPV = 1
                                    NewOneFound = 0
                                    Call CXoverA(FindAllFlagX, 0, 0)
                                End If
'                                If ProgBinRead(1, RedoL3(x)) = 1 Or ProgBinRead(3, RedoL3(x)) = 1 Or ProgBinRead(5, RedoL3(x)) = 1 Then
'                                    ZZZ = ZZZ + 1
'                                    Call AddToRedoList(4, AList(0, x), AList(1, x), AList(2, x))
'                                End If
                            End If
                            
                            
                        Next x
                        
                        
                        
                        'End If
                        OY = Y
                        oepx = EPX
                        
                        ET = Abs(GetTickCount)
                        ET = Abs(ET)
                        If Abs(ET - LT) > 500 Then
                            GlobalTimer = ET
                            LT = ET
                            'Form1.SSPanel13.Caption = "Approximately " & DoTime((Abs(ET - ST)) * (100 / Form1.ProgressBar1.Value) - (Abs(ET - ST))) & " remaining"
                            Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                            Form1.SSPanel1.Refresh
                            Form1.Refresh
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            
                            If Abs(ET - ELT) > 2000 Then
                                ELT = ET
                                If oTotRecs > 0 Then
                                    PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                    If PBV > Form1.ProgressBar1 Then
                                        Form1.ProgressBar1 = PBV
                                        Call UpdateF2Prog
                                    End If
                                End If
                                        
                            End If
                            xNextno = NextNo
                            
                            DoEvents 'covered by currentlyrunningflag
                            NextNo = xNextno
                            If AbortFlag = 1 Then
                                WinPPY = NextNo
                                g = NextNo
                                H = NextNo
                            End If
                            UpdateRecNums (SEventNumber)
                            
                            Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                            Call UpdateTimeCaps(ET, SAll)
                            
                            
                            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                            If AbortFlag = 1 Then
                                Exit For
                            End If
        
                        End If
                    Next Y
                    
                    UseCompress = 0
                    'Call SetupMCArrays
        '            HWindowWidth = CLng(CWinSize / 2)
        '            lHWindowWidth = HWindowWidth
        '            ReDim ScoresX(Len(StrainSeq(0)))  ' 0=s1,s2Matches etc
        '            ReDim WinScoresX(Len(StrainSeq(0)) + HWindowWidth * 2) ' 0=s1,s2Matches etc
        '            ReDim ChiValsX(Len(StrainSeq(0)))
        '            ReDim SmoothChiX(Len(StrainSeq(0)))
        '            ReDim XDiffPos(Len(StrainSeq(0)) + 200)
        '            ReDim XPosDiff(Len(StrainSeq(0)) + 200)
        '            ReDim LXOS(3)
        '            ReDim XDP(Len(StrainSeq(0)) + 200, 2), XPD(Len(StrainSeq(0)) + 200, 2)
                    
                End If
                
                
                
                Form1.SSPanel1.Caption = Trim(Str(EPX)) & " of " & Trim(Str(ALC)) & " triplets reexamined"
                DoEvents
                UseCompress = 0
    '            XXX = 0
    '                       For x = 0 To NextNo
    '                XXX = XXX + CurrentXOver(x) '586,225,9411,1210,365
    '                '585,350,363,5552
    '            Next x
    '            x = x
    '        x = x
    '        Open "RecombsNew.csv" For Output As #1
    '            For x = 0 To NextNo
    '                For Y = 1 To CurrentXOver(x)
    '                    Print #1, Str(x) + "," + Str(Y) + "," + Str(XoverList(x, Y).Daughter) + "," + Str(XoverList(x, Y).MinorP) + "," + Str(XoverList(x, Y).MajorP) + ","
    '                Next Y
    '            Next x
    '        Close #1
            End If
        Loop
    End If
    If DoScans(0, 3) = 1 Then
        Call SetupMCArrays
    End If
    If DoScans(0, 2) = 1 Or DoScans(0, 5) = 1 Or DoScans(0, 8) = 1 Then 'Or DoScans(0, 3) = 1 Then  'Or DoScans(0, 4) = 1
        
        UseCompress = 1
        Call MakeScanCompressArrays(NextNo, SeqNum())
        
        For Seq1 = 0 To PermNextno
            For Seq2 = Seq1 + 1 To NextNo
                If DoPairs(Seq1, Seq2) = 1 Then
                If Seq1 <> Seq2 Then
                    If Seq2 > PermNextno Then
                        Spos = Seq2 + 1
                    Else
                        Spos = PermNextno + 1
                    End If
                    For Seq3 = Spos To NextNo
                    If DoPairs(Seq1, Seq3) = 1 And DoPairs(Seq2, Seq3) = 1 Then
                        
                        If Seq1 <= UBound(PermValid, 2) And Seq2 <= UBound(PermValid, 2) And Seq3 <= UBound(PermValid, 2) Then
                            If PermValid(Seq1, Seq2) > MinSeqSize And PermValid(Seq1, Seq3) > MinSeqSize And PermValid(Seq2, Seq3) > MinSeqSize Then
                                'If SubValid(Seq1, Seq2) > 20 And SubValid(Seq1, Seq3) > 20 And SubValid(Seq2, Seq3) > 20 Then
                                    If Seq1 <= NextNo And Seq2 <= NextNo And Seq3 <= NextNo Then
                                        b = b + 1
                                        '@'@
'                                        If DoScans(0, 0) = 1 Then
'
'                                            Call XOver(Distance(), XPosDiff(), XDiffPos(), CurrentXOver(), XoverList(), SeqNum(), Seq1, Seq2, Seq3, 0)
'                                        End If
'                                        If DoScans(0, 1) = 1 Then
'                                            Call GCXoverD(0)
'                                        End If
                                        If DoScans(0, 2) = 1 Then
                                            Call BSXoverS(BackUpNextno, Seq1, Seq2, Seq3, TraceSub(), MissingData())
                                        End If
'                                        If DoScans(0, 3) = 1 Then
'                                            Call MCXoverF(FindAllFlagX, 0, 0)
'                                        End If
                                        '@
'                                        If DoScans(0, 4) = 1 Then
'                                            tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
'
'                                            Call CXoverA(FindAllFlagX, 0, 0)
'
'                                            Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
'
'                                            Call CXoverA(FindAllFlagX, 0, 0)
'
'                                            Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
'
'                                            Call CXoverA(FindAllFlagX, 0, 0)
'
'                                            Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
'                                        End If
                                        
                                        If DoScans(0, 5) = 1 Then
                                            oSeq1 = Seq1: oSeq2 = Seq2: oSeq3 = Seq3
                                            Call SSXoverC(CLng(0), CLng(WinNum), SeqMap(), ZPScoreHolder(), ZSScoreHolder(), CorrectP, oSeq, PermSScores(), PermPScores(), SScoreHolder(), PScoreHolder(), TraceSub(), SeqScore3(), MeanPScore(), SDPScore(), Seq34Conv(), VRandConv(), VRandTemplate(), HRandTemplate(), TakenPos(), DG1(), DG2(), DoGroupS(), DoGroupP())
                                            Seq1 = oSeq1: Seq2 = oSeq2: Seq3 = oSeq3
                                        End If
                                        
                                        
                                        If DoScans(0, 8) = 1 Then
                                                                             
                                            tSeq1 = Seq1: tSeq2 = Seq2: tSeq3 = Seq3
                                                
                                            Call TSXOver(0)
                                                    
                                            Seq1 = tSeq2: Seq2 = tSeq3: Seq3 = tSeq1
                                                    
                                            Call TSXOver(0)
                                                    
                                            Seq1 = tSeq3: Seq2 = tSeq1: Seq3 = tSeq2
                                                    
                                            Call TSXOver(0)
                                                    
                                            Seq1 = tSeq1: Seq2 = tSeq2: Seq3 = tSeq3
                                        End If
                                       
                                        
                                    End If
                                'End If
                            End If
                        End If
                        ET = Abs(GetTickCount)
                        '@'@
                        If Abs(ET - GlobalTimer) > 500 Then
                            DoEvents
                            If AbortFlag = 1 Then Exit For
                            GlobalTimer = ET
                            Form1.SSPanel1.Caption = Trim(Str(b)) & " of " & Trim(Str(MCCorrectX)) & " triplets reexamined"
                            If Abs(ET - ELT) > 2000 Then
                                ELT = ET
                                If oTotRecs > 0 Then
                                    PBV = (1 - (oRecombNo(100) ^ 0.4 / oTotRecs ^ 0.4)) * 100
                                    If PBV > Form1.ProgressBar1 Then
                                        Form1.ProgressBar1 = PBV
                                        Call UpdateF2Prog
                                    End If
                                End If
                                        
                            End If
                            
                            
                            
                            
                            If AbortFlag = 1 Then
                                WinPPY = NextNo
                                g = NextNo
                                H = NextNo
                            End If
                            UpdateRecNums (SEventNumber)
                            Form1.Label50(12).Caption = DoTimeII(Abs(ET - STime))
                            Call UpdateTimeCaps(ET, SAll)
                            Form1.Refresh
                            xNextno = NextNo
                            DoEvents 'covered by currentlyrunning flag
                            NextNo = xNextno
                        End If
                    End If
                    Next Seq3
                End If
                End If
            Next Seq2
        Next Seq1
'        XXX = 0
'                       For x = 0 To NextNo
'                XXX = XXX + CurrentXOver(x) '586,225,9411,1210,365
'                '585,350,363,5552
'            Next x
            x = x
    
        If DoScans(0, 3) = 1 Then
            Call SetupMCArrays
        End If
    End If
    UseCompress = 0
    DontWorryAboutSplitsFlag = oDWS
    Dim NumNew
    NumNew = 0
    For x = 0 To NextNo
        For Y = 1 To CurrentXOver(x)
            NumNew = NumNew + 1
            
            If XoverList(x, Y).MajorP > PermNextno And XoverList(x, Y).Daughter > PermNextno Then
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
                XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
            ElseIf XoverList(x, Y).MinorP > PermNextno And XoverList(x, Y).Daughter > PermNextno Then
                XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
            ElseIf XoverList(x, Y).MinorP > PermNextno And XoverList(x, Y).MajorP > PermNextno Then
                XoverList(x, Y).EndP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
            ElseIf XoverList(x, Y).MajorP > PermNextno Then
                XoverList(x, Y).EndP = 0
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (XoverList(x, Y).MajorP))
            ElseIf XoverList(x, Y).MinorP > PermNextno Then
                XoverList(x, Y).EndP = 0
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (XoverList(x, Y).MinorP))
            ElseIf XoverList(x, Y).Daughter > PermNextno Then
                XoverList(x, Y).EndP = 0
                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (XoverList(x, Y).Daughter))
            'XX = XoverList(x, Y).EndP '0
            End If
'            If XoverList(x, Y).MajorP > PermNextno Then
'                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MajorP), (x + 1))
'                'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).MajorP)
'            ElseIf XoverList(x, Y).MinorP > PermNextno Then
'                'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).MinorP)
'                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).MinorP), (x + 1))
'            ElseIf XoverList(x, Y).Daughter > PermNextno Then
'                'XoverList(x, Y).EndP = OSNPos(XoverList(x, Y).Daughter)
'                XoverList(x, Y).BeginP = -CombineP(OSNPos(XoverList(x, Y).Daughter), (x + 1))
'            End If
            'XX = XoverList(x, Y).EndP '0
        Next Y
    Next x
    x = x



End If
If PermNextno > MemPoc Then
    ReDim PermDIffs(0, 0)
    ReDim PermValid(0, 0)
End If


End Sub
Public Sub CheckNums(PXOList() As XOverDefine, PCurrentXover() As Integer)
Dim total As Variant
For x = 0 To NextNo
    For Y = 1 To PCurrentXover(x)
        total = total + PXOList(x, Y).Probability
    Next Y
Next x

Open "PTots27.csv" For Append As #48
Print #48, Str(SEventNumber) + "," + Str(total)
Close #48

If SEventNumber = 200 Then
x = x
End If
'If SEventNumber = 40 Then
'    Open "pxo422b.csv" For Output As #48
'    For x = 0 To NextNo
'        For Y = 1 To PCurrentXover(x)
'            Print #48, Str(PXOList(x, Y).Daughter) + "," + Str(PXOList(x, Y).MinorP) + "," + Str(PXOList(x, Y).MajorP) + ","
'        Next Y
'    Next x
'
'
'
'    Close #48
'    x = x
'End If


End Sub
Public Sub SetupMCArrays()
HWindowWidth = CLng(MCWinSize / 2)
pHWindowWidth = HWindowWidth
lHWindowWidth = HWindowWidth
ReDim Scores(Len(StrainSeq(0)), 2)  ' 0=s1,s2Matches etc
ReDim Winscores(Len(StrainSeq(0)) + HWindowWidth * 2, 2) ' 0=s1,s2Matches etc
ReDim Chivals(Len(StrainSeq(0)), 2)
ReDim SmoothChi(Len(StrainSeq(0)), 2)
ReDim XDiffPos(Len(StrainSeq(0)) + 200)
ReDim XPosDiff(Len(StrainSeq(0)) + 200)
ReDim MDMap(Len(StrainSeq(0))), BanWin(Len(StrainSeq(0)) + HWindowWidth * 2)
End Sub
Public Sub CheckForOldRedolIst()

Dim FF As Long, oDirX As String, Iter As Long, UB As Long
    FF = FreeFile
    oDirX = CurDir
    ChDrive App.Path
    ChDir App.Path
    
    Iter = 0
    UB = -1
    Do While Iter < 100
        If Dir("RDP5Redolist" + Str(Iter) + UFTag) <> "" Then
            Open "RDP5Redolist" + Str(Iter) + UFTag For Binary As #FF
            Get #FF, , UB
            
            ReDim RedoList(3, UB)
            Get #FF, , RedoList()
            Close #FF
            Kill "RDP5Redolist" + Str(Iter) + UFTag
            Exit Do
        Else
            Iter = Iter + 1
        End If
        
    Loop
    If UB = -1 Then
        ReDim RedoList(3, 10)
    Else
        RedoListSize = UB
    End If
    ChDrive oDirX
    ChDir oDirX

End Sub

Public Sub MakeTeams(AllowOuterTeams As Byte, sNextno As Long, eNextno As Long, TD() As Single, Distance() As Single, ASS() As Long, Teams() As Integer, Members() As Integer)
Dim Z As Long, x As Long, Y As Long, CSS(3) As Long, MaskSeq() As Long, MTN() As Long, Seq1 As Long, Seq2 As Long, Seq3 As Long
Dim DoneThisPair() As Integer
Dim TreeDistance() As Single
ReDim TreeDistance(eNextno, eNextno)



For x = 0 To eNextno
    
    For Y = 0 To NextNo
    
        If TD(Y, x) <= 1.001 Then
            TreeDistance(Y, x) = TD(Y, x)
        End If
    Next Y
    TreeDistance(x, x) = 0
Next x
ReDim DoneThisPair(eNextno, eNextno), MTN(eNextno, 0)
For x = 0 To eNextno
    MTN(x, 0) = x
    
Next x
Dim Highest As Single, ColHigh() As Single
Highest = -1
ReDim MaskSeq(NextNo)
ReDim ColHigh(eNextno)
ReDim Teams(NextNo, NextNo), Members(NextNo)

For x = 0 To NextNo
    Members(x) = 0
    Teams(x, 0) = x
Next x
For x = 0 To eNextno
    Highest = 0
    For Y = 0 To C
        If Highest < TreeDistance(x, Y) Then
            Highest = TreeDistance(x, Y)
        End If
    Next Y
    ColHigh(x) = Highest
   
Next x

For Z = 0 To eNextno
    Highest = GetHighest2(eNextno, 0, CSS(0), UBound(MTN, 1), MTN(0, 0), TreeDistance(0, 0), ColHigh(0), MaskSeq(0), DoneThisPair(0, 0))
    If Highest = 0 Then Exit For
    'XX = TreeDistance(0, 4)
    Seq1 = CSS(0)
    Seq2 = CSS(1)
    If CSS(0) > sNextno And CSS(1) > sNextno Then
        GoOn = 0
        If Highest < 1 Then
            For x = 0 To sNextno
                If MaskSeq(MTN(x, A)) < 2 Then
                    
                    If x <> Seq1 And x <> Seq2 Then
                        GoOn = 0
                        Seq3 = x
                        GoOn = FastRecCheckP(CircularFlag, 0, MCCorrection, MCFlag, 1, (LowestProb / MCCorrection), LowestProb, eNextno, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(Distance, 1), Distance(0, 0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(FSSRDP, 2), UBound(CompressSeq, 1), UBound(XoverSeqNumW, 1), CompressSeq(0, 0), SeqNum(0, 0), Seq1, Seq2, Seq3, Len(StrainSeq(0)) + 1, XoverWindow, XOverWindowX, XoverSeqNum(0, 0), XoverSeqNumW(0, 0), UBound(XOverHomologyNum, 1), XOverHomologyNum(0, 0), FSSRDP(0, 0, 0, 0), ProbEstimateInFileFlag, UBound(ProbEstimate, 1), UBound(ProbEstimate, 2), ProbEstimate(0, 0, 0), UBound(Fact3X3, 1), Fact3X3(0, 0, 0), Fact(0), BQPV)
                        
                        If GoOn = 1 Then
                            Exit For
                        End If
                        
                    End If
                
                End If
            
            Next x
        
       
            DoneThisPair(Seq1, Seq2) = 1
            DoneThisPair(Seq2, Seq1) = 1
            If GoOn = 0 Then 'no recombination detected with this pair - add them to ateam
                If Seq1 > sNextno And Seq2 > sNextno Then
                    If ASS(Seq1) >= ASS(Seq2) Then
                        If Teams(Seq2, 0) > -1 Then
                            For x = 0 To Members(Seq2)
                                 Members(Seq1) = Members(Seq1) + 1
                                 Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                                 Teams(Seq2, 0) = -1
                                 
                            Next x
                            Members(Seq2) = -1
                        Else
                            x = x
                        End If
                        MaskSeq(Seq2) = 3
                        Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                    Else
                        If Teams(Seq1, 0) > -1 Then
                            For x = 0 To Members(Seq1)
                                 Members(Seq2) = Members(Seq2) + 1
                                 Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                                 Teams(Seq1, 0) = -1
                                 
                            Next x
                            Members(Seq1) = -1
                        Else
                            x = x
                        End If
                        MaskSeq(Seq1) = 3
                        Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                    End If
                ElseIf Seq1 > sNextno Then
                    If Teams(Seq2, 0) > -1 Then
                        For x = 0 To Members(Seq2)
                             Members(Seq1) = Members(Seq1) + 1
                             Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                             Teams(Seq2, 0) = -1
                        Next x
                        Members(Seq2) = -1
                    Else
                        x = x
                    End If
                    MaskSeq(Seq2) = 3
                    Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                Else
                    If Teams(Seq1, 0) > -1 Then
                        For x = 0 To Members(Seq1)
                             Members(Seq2) = Members(Seq2) + 1
                             Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                             Teams(Seq1, 0) = -1
                        Next x
                        Members(Seq1) = -1
                    Else
                        x = x
                    End If
                    MaskSeq(Seq1) = 3
                    Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                End If
            Else 'recombination detected - neither can belong to the same team
                DoneThisPair(Seq1, Seq2) = 1
                DoneThisPair(Seq2, Seq1) = 1
                MaskSeq(Seq1) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                MaskSeq(Seq2) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
            
            End If
        ElseIf Highest = 1 Then
            If ASS(Seq1) >= ASS(Seq2) Then
                If Teams(Seq2, 0) > -1 Then
                    For x = 0 To Members(Seq2)
                         Members(Seq1) = Members(Seq1) + 1
                         Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                         Teams(Seq2, 0) = -1
                         
                    Next x
                    Members(Seq2) = -1
                Else
                    x = x
                End If
                MaskSeq(Seq2) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
            Else
                If Teams(Seq1, 0) > -1 Then
                    For x = 0 To Members(Seq1)
                         Members(Seq2) = Members(Seq2) + 1
                         Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                         Teams(Seq1, 0) = -1
                         
                    Next x
                    Members(Seq1) = -1
                Else
                    x = x
                End If
                MaskSeq(Seq1) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
            End If
        
        Else
            DoneThisPair(Seq1, Seq2) = 1
            DoneThisPair(Seq2, Seq1) = 1
        End If
    ElseIf CSS(0) <= sNextno And CSS(1) <= sNextno And AllowOuterTeams = 1 Then
        GoOn = 0
        If Highest < 1 Then
            For x = sNextno + 1 To eNextno
                If MaskSeq(MTN(x, A)) < 2 Then
                    
                    If x <> Seq1 And x <> Seq2 Then
                        GoOn = 0
                        Seq3 = x
                        GoOn = FastRecCheckP(CircularFlag, 0, MCCorrection, MCFlag, 1, (LowestProb / MCCorrection), LowestProb, eNextno, TargetX, Len(StrainSeq(0)), ShortOutFlag, UBound(Distance, 1), Distance(0, 0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(FSSRDP, 2), UBound(CompressSeq, 1), UBound(XoverSeqNumW, 1), CompressSeq(0, 0), SeqNum(0, 0), Seq1, Seq2, Seq3, Len(StrainSeq(0)) + 1, XoverWindow, XOverWindowX, XoverSeqNum(0, 0), XoverSeqNumW(0, 0), UBound(XOverHomologyNum, 1), XOverHomologyNum(0, 0), FSSRDP(0, 0, 0, 0), ProbEstimateInFileFlag, UBound(ProbEstimate, 1), UBound(ProbEstimate, 2), ProbEstimate(0, 0, 0), UBound(Fact3X3, 1), Fact3X3(0, 0, 0), Fact(0), BQPV)
                        
                        If GoOn = 1 Then
                            Exit For
                        End If
                        
                    End If
                
                End If
            
            Next x
        
        
            DoneThisPair(Seq1, Seq2) = 1
            DoneThisPair(Seq2, Seq1) = 1
            If GoOn = 0 Then
                If Seq1 <= sNextno And Seq2 <= sNextno Then
                    If ASS(Seq1) >= ASS(Seq2) Then
                        If Teams(Seq2, 0) > -1 Then
                            For x = 0 To Members(Seq2)
                                 Members(Seq1) = Members(Seq1) + 1
                                 Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                                 Teams(Seq2, 0) = -1
                            Next x
                            Members(Seq2) = -1
                        Else
                            x = x
                        End If
                        MaskSeq(Seq2) = 3
                        Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                    Else
                        If Teams(Seq1, 0) > -1 Then
                            For x = 0 To Members(Seq1)
                                 Members(Seq2) = Members(Seq2) + 1
                                 Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                                 Teams(Seq1, 0) = -1
                            Next x
                            Members(Seq1) = -1
                        Else
                            x = x
                        End If
                        MaskSeq(Seq1) = 3
                        Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                    End If
                    
                ElseIf Seq1 < sNextno Then
                    If Teams(Seq2, 0) > -1 Then
                        For x = 0 To Members(Seq2)
                             Members(Seq1) = Members(Seq1) + 1
                             Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                             Teams(Seq2, 0) = -1
                        Next x
                        Members(Seq2) = -1
                    Else
                    
                        x = x
                    End If
                    MaskSeq(Seq2) = 3
                    Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                Else
                    If Teams(Seq1, 0) > -1 Then
                        For x = 0 To Members(Seq1)
                             Members(Seq2) = Members(Seq2) + 1
                             Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                             Teams(Seq1, 0) = -1
                        Next x
                        Members(Seq1) = -1
                    Else
                        x = x
                    End If
                    MaskSeq(Seq1) = 3
                    Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
                End If
            Else
                
            End If
        ElseIf Highest = 1 Then
            If ASS(Seq1) >= ASS(Seq2) Then
                If Teams(Seq2, 0) > -1 Then
                    For x = 0 To Members(Seq2)
                         Members(Seq1) = Members(Seq1) + 1
                         Teams(Seq1, Members(Seq1)) = Teams(Seq2, x)
                         Teams(Seq2, 0) = -1
                         
                    Next x
                    Members(Seq2) = -1
                Else
                    x = x
                End If
                MaskSeq(Seq2) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
            Else
                If Teams(Seq1, 0) > -1 Then
                    For x = 0 To Members(Seq1)
                         Members(Seq2) = Members(Seq2) + 1
                         Teams(Seq2, Members(Seq2)) = Teams(Seq1, x)
                         Teams(Seq1, 0) = -1
                         
                    Next x
                    Members(Seq1) = -1
                Else
                    x = x
                End If
                MaskSeq(Seq1) = 3
                Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
            End If
        Else
            DoneThisPair(Seq1, Seq2) = 1
            DoneThisPair(Seq2, Seq1) = 1
        End If
    Else
        DoneThisPair(Seq1, Seq2) = 1
        DoneThisPair(Seq2, Seq1) = 1
        MaskSeq(Seq1) = 3
        Dummy = UpdateColHigh(0, eNextno, Seq1, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
        MaskSeq(Seq2) = 3
        Dummy = UpdateColHigh(0, eNextno, Seq2, UBound(MTN, 1), MTN(0, 0), MaskSeq(0), ColHigh(0), UBound(TreeDistance, 1), TreeDistance(0, 0), UBound(DoneThisPair, 1), DoneThisPair(0, 0))
    
    End If
        
Next Z

End Sub
Function AnyArrayToBytes(ByVal SafeArray As Variant) As Byte()
Dim SArrayPtr As Long
Dim ElemSize As Long
Dim DimCount As Long
Dim ElemsInDim As Long
Dim TotalElems As Long
Dim DataSize As Long
Dim DataPtr As Long
Dim Bytes() As Byte
Dim n As Long

CopyMemory SArrayPtr, ByVal VarPtr(SafeArray) + 8, 4
If SArrayPtr = 0 Then Exit Function
DimCount = SafeArrayGetDim(SArrayPtr)
ElemSize = SafeArrayGetElemsize(SArrayPtr)

TotalElems = 1
For n = 0 To DimCount - 1
    CopyMemory ElemsInDim, ByVal SArrayPtr + 16 + n * 8, 4
    TotalElems = TotalElems * ElemsInDim
Next n

DataSize = TotalElems * ElemSize
ReDim Bytes(DataSize - 1)
SafeArrayAccessData SArrayPtr, DataPtr
CopyMemory Bytes(0), ByVal DataPtr, DataSize
SafeArrayUnaccessData SArrayPtr

AnyArrayToBytes = Bytes()
End Function
Function AnyArrayToInteger(ByVal SafeArray As Variant) As Integer()
Dim SArrayPtr As Long
Dim ElemSize As Long
Dim DimCount As Long
Dim ElemsInDim As Long
Dim TotalElems As Long
Dim DataSize As Long
Dim DataPtr As Long
Dim Bytes() As Integer
Dim n As Long

CopyMemory SArrayPtr, ByVal VarPtr(SafeArray) + 8, 4
If SArrayPtr = 0 Then Exit Function
DimCount = SafeArrayGetDim(SArrayPtr)
ElemSize = SafeArrayGetElemsize(SArrayPtr)

TotalElems = 1
For n = 0 To DimCount - 1
    CopyMemory ElemsInDim, ByVal SArrayPtr + 16 + n * 8, 4
    TotalElems = TotalElems * ElemsInDim
Next n

DataSize = TotalElems * ElemSize
ReDim Bytes((DataSize - 1) / 2)
SafeArrayAccessData SArrayPtr, DataPtr
CopyMemory Bytes(0), ByVal DataPtr, DataSize
SafeArrayUnaccessData SArrayPtr

AnyArrayToInteger = Bytes()
End Function
Function ArrayDims(arr As Variant) As Integer
    Dim Ptr As Long
    Dim VType As Integer
    
    Const VT_BYREF = &H4000&
    
    ' get the real VarType of the argument
    ' this is similar to VarType(), but returns also the VT_BYREF bit
    CopyMemory VType, arr, 2
    
    ' exit if not an array
    If (VType And vbArray) = 0 Then Exit Function
    
    ' get the address of the SAFEARRAY descriptor
    ' this is stored in the second half of the
    ' Variant parameter that has received the array
    CopyMemory Ptr, ByVal VarPtr(arr) + 8, 4
    
    ' see whether the routine was passed a Variant
    ' that contains an array, rather than directly an array
    ' in the former case ptr already points to the SA structure.
    ' Thanks to Monte Hansen for this fix
    
    If (VType And VT_BYREF) Then
        ' ptr is a pointer to a pointer
        CopyMemory Ptr, ByVal Ptr, 4
    End If
    
    ' get the address of the SAFEARRAY structure
    ' this is stored in the descriptor
    
    ' get the first word of the SAFEARRAY structure
    ' which holds the number of dimensions
    ' ...but first check that saAddr is non-zero, otherwise
    ' this routine bombs when the array is uninitialized
    ' (Thanks to VB2TheMax aficionado Thomas Eyde for
    '  suggesting this edit to the original routine.)
    If Ptr Then
        CopyMemory ArrayDims, ByVal Ptr, 2
    End If
End Function
Public Function SetTopMostWindow(hwnd As Long, Topmost As Boolean) _
   As Long
    If DebuggingFlag > 0 Then Exit Function
   If Topmost = True Then 'Make the window topmost
        'XX = GetForegroundWindow
        'If XX = hwnd Then
            SetTopMostWindow = SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, _
           0, FLAGS)
       ' End If
   Else
      SetTopMostWindow = SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, _
         0, 0, FLAGS)
      SetTopMostWindow = False
   End If
End Function

' Check Messages
' ================================================
Private Function WindowProc(ByVal Lwnd As Long, ByVal Lmsg As Long, ByVal wParam As Long, ByVal lParam As Long) As Long
  Dim MouseKeys As Long
  Dim Rotation As Long
  Dim Xpos As Long
  Dim YPos As Long
  Dim fFrm As Form

  Select Case Lmsg
  
    Case WM_MOUSEWHEEL
    
      MouseKeys = wParam And 65535
      Rotation = wParam / 65536
      Xpos = lParam And 65535
      YPos = lParam / 65536
      
      Set fFrm = GetForm(Lwnd)
'      If fFrm Is Nothing Then
'        ' it's not a form
'        If Not IsOver(Lwnd, Xpos, Ypos) And IsOver(GetParent(Lwnd), Xpos, Ypos) Then
'          ' it's not over the control and is over the form,
'          ' so fire mousewheel on form (if it's not a dropped down combo)
'          If SendMessage(Lwnd, CB_GETDROPPEDSTATE, 0&, 0&) <> 1 Then
'            GetForm(GetParent(Lwnd)).MouseWheel MouseKeys, Rotation, Xpos, Ypos
'            Exit Function ' Discard scroll message to control
'          End If
'        End If
'      Else
        ' it's a form so fire mousewheel
'        If IsOver(fFrm.hWnd, Xpos, Ypos) Then
            fFrm.MouseWheel MouseKeys, Rotation, Xpos, YPos
'        End If
'      End If
  End Select
  
  WindowProc = CallWindowProc(GetProp(Lwnd, "PrevWndProc"), Lwnd, Lmsg, wParam, lParam)
End Function

' Hook / UnHook
' ================================================
Public Sub WheelHook(ByVal hwnd As Long)
  If DebuggingFlag > 0 Then Exit Sub
  If DebuggingFlag < 2 Then On Error Resume Next
  SetProp hwnd, "PrevWndProc", SetWindowLong(hwnd, GWL_WNDPROC, AddressOf WindowProc)
  
End Sub

Public Sub WheelUnHook(ByVal hwnd As Long)
  If DebuggingFlag > 0 Then Exit Sub
  If DebuggingFlag < 2 Then On Error Resume Next
  SetWindowLong hwnd, GWL_WNDPROC, GetProp(hwnd, "PrevWndProc")
  RemoveProp hwnd, "PrevWndProc"
End Sub

' Window Checks
' ================================================
Public Function IsOver(ByVal hwnd As Long, ByVal lX As Long, ByVal lY As Long) As Boolean
  Dim rectCtl As RECT
  GetWindowRect hwnd, rectCtl
  With rectCtl
    IsOver = (lX >= .Left And lX <= .Right And lY >= .Top And lY <= .Bottom)
  End With
End Function

Private Function GetForm(ByVal hwnd As Long) As Form
  For Each GetForm In Forms
    If GetForm.hwnd = hwnd Then Exit Function
  Next GetForm
  Set GetForm = Nothing
End Function

Public Sub PictureBoxZoom(ByRef picBox As PictureBox, ByVal MouseKeys As Long, ByVal Rotation As Long, ByVal Xpos As Long, ByVal YPos As Long)
'  'picBox.Cls
'  'check for picture7
'  If oP7XP > 0 Then
'    If Rotation < 0 Then
'        P7ZoomLevel = P7ZoomLevel - 2
'        If P7ZoomLevel = 0 Then P7ZoomLevel = 0
'    Else
'        P7ZoomLevel = P7ZoomLevel + 2
'
'        If P7ZoomLevel > 50 Then P7ZoomLevel = 50
'    End If
'    P7XP = oP7XP
'    Call RedrawPlotAA(1)
'    Form1.Picture7.Refresh
'    P7XP = 0
'  ElseIf P1NT > -1 Then
'   If Rotation < 0 Then
'        Call DoSeqZoom(0)
'    Else
'        Call DoSeqZoom(1)
'    End If
'
' End If
End Sub
Public Sub PictureBox7Zoom(ByRef picBox As PictureBox, ByVal MouseKeys As Long, ByVal Rotation As Long, ByVal Xpos As Long, ByVal YPos As Long)
  picBox.Cls
  picBox.Print "MouseWheel " & IIf(Rotation < 0, "Down", "Up")
End Sub

Public Sub SHMatrix()


    

Dim MaxN As Double

'SHWinLen = 2000
'SHStep = 1000
'SHTree = 1 '0=upgma, 1=nj, 2= ls, 3 = ml
'SHTModel = 0 '0=JC, 1 = K2p, 2 = ??, 3 = ML
'SHTRndSeed = 3 'random number seed
'SHOptMethod = 1 '0=phyml, 1 =raxml
'SHOrAUFlag = 0 '0=SH, 1=AU
Dim Rat As Single

Call UnModNextno
Call UnModSeqNum(0)
                
If SHStep = 0 Then SHStep = 100
If SHWinLen < SHStep Then SHWinLen = SHStep * 10
If SHWinLen > Len(StrainSeq(0)) / 2 Then
    Rat = SHWinLen / SHStep
    SHWinLen = Len(StrainSeq(0)) / 2
    SHStep = SHWinLen / Rat
End If


If Len(StrainSeq(0)) / SHStep > 2000 Then
    SHStep = CLng(Len(StrainSeq(0)) / 2000)
End If

If SHWinLen < SHStep * 2 Then SHWinLen = SHStep * 2


Dim OutString As String, TempSeq() As String, Boots() As String, LnL() As Double, TDS As String, TDD As String, PhyMLFlag As Byte
oDir = CurDir
ChDir App.Path
ChDrive App.Path
If DoneMatX(12) = 0 Then
    Form1.Picture26.Enabled = False
    Form1.SSPanel1.Caption = "Constructing phylogenetic trees"
    Form1.ProgressBar1 = 5
    Call UpdateF2Prog
    Form1.Refresh
    
    If DebuggingFlag < 2 Then On Error Resume Next
    Open "dnadist.bat" For Output As #1
    OutString = ""
    SHOptMethod = 1
    PhyMLFlag = 0
    '''''''''''''''''''''''''''''''''''''''''''''''''''
    'STEP 1 set up the batch files for PHYML and RAXML'
    '''''''''''''''''''''''''''''''''''''''''''''''''''
    If SHOptMethod = 0 Then 'use phyml - unfortunately its not working with the beta build
         OutString = "PhyML_3.0_win32.exe -i infile "
         
         'bootstrap
         OutString = OutString + " -b 0"
         
         'Substitution model
         If TPModel = 0 Then
               OutString = OutString + " -m JC69 "
         ElseIf TPModel = 1 Then
               OutString = OutString + " -m K80 "
         ElseIf TPModel = 6 Then
               OutString = OutString + " -m HKY85 "
         ElseIf TPModel = 2 Then
               OutString = OutString + " -m F81 "
         ElseIf TPModel = 3 Then
               OutString = OutString + " -m F84 "
         ElseIf TPModel = 4 Then
               OutString = OutString + " -m TN93 "
         ElseIf TPModel = 5 Then
               OutString = OutString + " -m GTR "
         End If
         
         
         'tvrat
        ' Outstring = Outstring + "-t e "
         OutString = OutString + "-t 2 "
         
         'proportion invariable sites
         'Outstring = Outstring + " -v e "
         
         'number rate categories
         ' Outstring = Outstring + " -c " + Trim(Str(TPGamma))
           OutString = OutString + " -c 1 "
         
         'gamma correction
         'Outstring = Outstring + " -a e " ' " 1.0"
         OutString = OutString + " -a 0.5 " ' " 1.0"
         
         
         'user tree, optimise branche lengths and sub rates, print site-by site likelihood
         OutString = OutString + " -u intree -o lr --print_site_lnl --no_memory_check"
         'user tree, optimise only branch lengths, print site-by site likelihood
         'Outstring = Outstring + " -u intree -o l --print_site_lnl"
         
         
         
         Print #1, OutString
         Print #1, "del treefile"
         Print #1, "rename infile_phyml_tree.txt treefile "
         Close #1
         On Error GoTo 0
    Else 'use raxml instead of phyml
        Dim SysInfo As SYSTEM_INFO
                
        GetSystemInfo SysInfo
        If DebuggingFlag < 2 Then On Error Resume Next
        
        Print #1, "del RAxML_info.treefile"
        Print #1, "del RAxML_parsimonyTree.treefile"
        Print #1, "del RAxML_log.treefile"
        Print #1, "del RAxML_result.treefile"
        Print #1, "del RAxML_bestTree.treefile"
        Print #1, "del RAxML_bootstrap.treefile"
        Print #1, "del RAxML_perSiteLLs.treefile"
        On Error GoTo 0
        
        Print #1, "del RAxML_perSiteLLs.treefile"
        
        Dim NumProc As Long
        NumProc = SysInfo.dwNumberOrfProcessors
        If NumProc > 4 Then NumProc = 4
        
        If NumProc > 2 And x = 12345 Then 'for some reason pthreads crashes/does not give a tree
            OutString = "raxmlHPC-PTHREADS -p 1234 -s infile -n treefile -m GTRCAT -f g -z intree -T " + Trim(Str(NumProc - 1))
        Else
            OutString = "raxmlHPC -s infile -p 1234 -n treefile -m GTRGAMMA -f g -z intree"
        End If
        
        'If RAxMLCats <> 25 Or X = X Then
        '    Outstring = Outstring + " - c " + Trim(Str(RAxMLCats))
        'End If
        
        ' BS reps
        
        
        Print #1, OutString
        Print #1, "del treefile"
        Print #1, "del infile"
        Print #1, "rename RAxML_bestTree.treefile treefile"
        Print #1, "rename RAxML_perSiteLLs.treefile infile.sitelh."
        BatIndex = 53
         
        Close #1
    
    
    End If
    
    If PermSeqNumInFile = 1 Then
        
        ReDim PermSeqNum(Len(StrainSeq(0)), PermNextno)
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        Open "RDP5PSNFile" + UFTag For Binary As #FF
        Get #FF, , PermSeqNum
        Close #FF
        ChDrive oDirX
        ChDir oDirX
    
    End If
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'STEP 2 Move through the alignment and make a tree for every window'
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    'Make a copy of permseqnum in tstrainseq - ytempseq will store the sequences in each window that must be passed to phyml/raxml and consel
    Dim tStrainseq() As String, TempSeqNum() As Integer, TreeStrings() As String, NumTrees As Long, Treecount As Long, TreeMat() As Single
    
    NumTrees = Len(StrainSeq(0))
    NumTrees = CLng((NumTrees / SHStep) - 0.5)
    NumTrees = NumTrees + 1
    
    ReDim tStrainseq(NextNo), TempSeq(NextNo), TreeStrings(NumTrees)
    
    For x = 0 To PermNextno
        tStrainseq(x) = String(Len(StrainSeq(0)) + SHWinLen, " ")
    Next x
    
    For x = 0 To PermNextno
        For Y = 1 To Len(StrainSeq(0))
            Mid(tStrainseq(x), Y, 1) = Chr(PermSeqNum(Y, x) - 1)
        Next Y
        For Y = 1 To SHWinLen
            Mid(tStrainseq(x), Y + Len(StrainSeq(0)), 1) = Chr(PermSeqNum(Y, x) - 1)
        Next Y
    Next x
    
    SS = Abs(GetTickCount)
    'make the trees and store them in treestring
    Dim tSubDiffs() As Single, tSubValid() As Single, ValidX() As Single, DiffsX() As Single, Treearray() As Single, SHolder() As Byte, tMat() As Single, ColTotals() As Single, LTree As Long, AvDst As Double, Udst As Double
    ReDim tSubDiffs(PermNextno, PermNextno), tSubValid(PermNextno, PermNextno), tMat(PermNextno, PermNextno)
    Dim tRedoDist() As Integer
    ReDim tRedoDist(NextNo)
    
   
    
    For x = 0 To PermNextno
         tRedoDist(x) = 1
         
    Next x
    
    
    SS = Abs(GetTickCount)
    'make the trees and store them in treestring
    Treecount = -1
    TargetPos = CLng(Len(StrainSeq(0)) / SHStep + 0.5)
    Dim EPos3 As Long
    For Z = 1 To Len(StrainSeq(0)) Step SHStep
        Treecount = Treecount + 1
        'If SHTree = 3 Then
        '    For X = 0 To PermNextno
        '        TempSeq(X) = Mid$(tStrainseq(X), Z, SHWinLen)
        '    Next X
        
        'ElseIf SHTree = 0 Or SHTree = 1 Or SHTree = 2 Then
            'copy the relevant bit of sequence info to tempseqnum
            
            
'            ReDim TempSeqNum(SHWinLen, PermNextno)
'            For X = 0 To PermNextno
'                For Y = 0 To SHWinLen - 1
'                    A = Y + Z
'                    If A > Len(StrainSeq(0)) Then
'                        A = A - Len(StrainSeq(0))
'                    End If
'                    TempSeqNum(Y, X) = PermSeqNum(A, X)
'                Next Y
'            Next X
            
            'Make distance matrix with the windowed sequences
            
            ReDim ColTotals(PermNextno), SHolder((PermNextno + 1) * 40 * 2)
                ReDim Treearray(PermNextno, PermNextno)

            'If SHTModel = 0 Or X = X Then
                
                
                
                    
                If x = x Then
                    EPos3 = Z + SHWinLen - 1
                    If EPos3 > Len(StrainSeq(0)) Then EPos3 = Len(StrainSeq(0))
                    
                    'XX = UBound(tMat, 1)
                    'Call FastDistanceCalcX(0, Z, EPos3, PermNextno, tSubDiffs(), tSubValid(), PermSeqNum(), tMat(), AvDst, UDst, tRedoDist())
                    Call FastDistanceCalcZ(1, 0, Z, EPos3, PermNextno, tSubDiffs(), tSubValid(), PermSeqNum(), tMat(), AvDst, Udst, tRedoDist())
                    For A = 0 To PermNextno
                        For b = 0 To PermNextno
                            tMat(A, b) = 1 - tMat(A, b) '0,1 = 0.549, 0.72:0.54,0.72:
                            
                        Next
                        tMat(A, A) = 0
                    Next
                
'                Else
'                   redim ValidX(0), DiffsX(0)
'                   For A = 0 To PermNextno
'                        For B = A + 1 To PermNextno
'                            ValidX(0) = 0
'                            DiffsX(0) = 0
'                            For C = 1 To SHWinLen
'                                If TempSeqNum(C, A) <> 46 Then
'                                    If TempSeqNum(C, B) <> 46 Then
'                                        ValidX(0) = ValidX(0) + 1
'                                        If TempSeqNum(C, A) <> TempSeqNum(C, B) Then
'                                            DiffsX(0) = DiffsX(0) + 1
'                                        End If
'                                    End If
'                                End If
'                            Next C
'                            tMat(A, B) = DiffsX(0) / ValidX(0)
'                            tMat(B, A) = tMat(A, B)
'                            'If tMat(A, B) < 0.2 Then
'                            'X = X
'                            'End If
'                        Next B
'                    Next A
                End If
                
                
            'ElseIf SHTModel <> 3 Then
                'Use bootdist for more complex distance models than JC but DNADIST for ML model.
            'Else ' use DNADIST for the ML distance model
            
            'End If
            
            'Draw the NJ tree and store the tree in SHolder in
            SS = Abs(GetTickCount)
            LTree = NEIGHBOUR(1, 0, BSRndNumSeed, 1, PermNextno + 1, tMat(0, 0), SHolder(0), ColTotals(0), Treearray(0, 0))
            EE = Abs(GetTickCount)
            TT = EE - SS
            TreeStrings(Treecount) = String(LTree, " ")
            For x = 1 To LTree
                Mid$(TreeStrings(Treecount), x, 1) = Chr(SHolder(x))
            Next x
            x = x
        
        'End If
        ET = Abs(GetTickCount)
        If Abs(ET - LT) > 500 Then
            'Form1.ProgressBar1.Value = ((B + 1) / (MCCorrection + 1) * 100)
            Form1.ProgressBar1.Value = 5 + (Treecount / TargetPos) * 85
            Form1.SSPanel1.Caption = "Making Shimodaira-Hasegawa compatibility matrix (" + Trim(Str(Treecount + 1)) + " out of " + Trim(Str(TargetPos)) + " NJ trees constructed)"
            Call UpdateF2Prog
            LT = ET
            
        End If
        
        
     Next Z
     EE = Abs(GetTickCount)
     TT = EE - SS
     '2.543 seconds
     Form1.SSPanel1.Caption = "Doing Shimodaira-Hasegawa tests"
     
     '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     'STEP 3: Move through the treestrings from 0 to treecount and do SH tests against every other tree'
     '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
     
     SS = Abs(GetTickCount)
     Dim TString As String
     ReDim SHMatrixX(1, Treecount, Treecount) '0=sh test, 1 =au test
     For Z = 0 To Treecount
        TDD = Trim(Str(BTree)) + " - " + Trim(Str(ETree))
        ReDim LnL(Treecount, SHWinLen), Boots(PermNextno)
        
        'MAKE INFILE CONTINING SEQUENCE INFO
        Open "infile" For Output As #1
        Header = " " + Trim$(CStr((PermNextno + 1))) + "   " + Trim$(CStr(SHWinLen))
        Print #1, Header
        
        'keep track of how many characters there are in the sequence names
        NLen = Len(Trim(Str(PermNextno)))
        If NLen = 1 Then NLen = 2
        
        'puts the proper nts into tempseq
        For x = 0 To PermNextno
            TempSeq(x) = Mid$(tStrainseq(x), Z * SHStep + 1, SHWinLen)
        Next x
        
        
        For x = 0 To NextNo
            TName = Trim$(CStr(x))
            TName = String(NLen - Len(TName), "0") & TName
            TName = "S" & TName
            BootName = TName
            BootName = BootName + String$(10 - (Len(BootName)), " ")
            TString = TempSeq(x)
            Boots(x) = BootName + TString
            Print #1, Boots(x)
        Next 'X
        Close #1
        If DebuggingFlag < 2 Then On Error Resume Next
        FLen = 0
        FLen = FileLen("infile")
        On Error GoTo 0
        If FLen = 0 Then
           x = x
        End If
        'MAKE INTREE CONTAINING TREE INFO AND RUN EITHER PHYML OR RAXML
        
        
        Dim Crap As String, TS As String
        Dim TotLnL() As Double
        ReDim TotLnL(Treecount)
        If SHOptMethod = 0 Then 'this runs the tree branch length optimisation with phyml
            ' STILL NEED TO UPDATE THIS WHOLE BIT - AT THE MOMENT ONLY RAXML IS WORKING
            BatIndex = 7
            For Y = 0 To 1
                If Y = 0 Then
                    TDS = Trim(Str(BTree)) + " - " + Trim(Str(ETree))
                Else
                    TDS = Trim(Str(ETree + 1)) + " - " + Trim(Str(BTree - 1))
                End If
                If Z = 0 Then
                    If DebuggingFlag < 2 Then On Error Resume Next
                    KillFile "intree"
                    On Error GoTo 0
                    Open "intree" For Output As #1
                    Print #1, NHComp(Y)
                    Close #1
                End If
                
                
                Call ShellAndClose("dnadist.bat", 0)
                If PhyMLFlag = 1 Then
                    If DebuggingFlag < 2 Then On Error Resume Next
                    FLen = 0
                    FLen = FileLen("infile_phyml_lk.txt")
                    On Error GoTo 0
                    If FLen > 0 Then
                        Open "infile_phyml_lk.txt" For Input As #1
                        Do
                            Line Input #1, Crap
                            If Left$(Crap, 4) = "Site" Then Exit Do
                        Loop
                        For x = 1 To Len(TempSeq(0))
                            Line Input #1, Crap
                            Pos = InStr(1, Crap, " ", vbBinaryCompare)
                            If Pos = 0 Then Pos = 6
                            Do
                                Pos = Pos + 1
                                If Mid$(Crap, Pos, 1) <> " " Then
                                    Exit Do
                                    
                                End If
                            Loop
                            LPos = Pos
                            Pos = InStr(LPos, Crap, " ", vbBinaryCompare)
                            TS = Mid$(Crap, LPos, Pos - LPos)
                            x = x
                            LnL(Y, x) = val(TS)
                            LnL(Y, x) = -Log(LnL(Y, x))
                            TotLnL(Y) = TotLnL(Y) + LnL(Y, x)
                            x = x
                        Next x
                        Close #1
                    Else
                    
                    End If
                Else 'If Y = 1 Then
                    If DebuggingFlag < 2 Then On Error Resume Next
                    KillFile "infile" + Trim(Str(Y))
                    On Error GoTo 0
                    FileCopy "infile", "infile" + Trim(Str(Y))
                    x = x
                End If
                
                
                x = x
            Next Y
        
            If DebuggingFlag < 2 Then On Error Resume Next
            KillFile "infile.txt"
            On Error GoTo 0
            Open "infile.txt" For Output As #1
            OutString = ""
            OutString = "Tree" + Chr(9) + "-lnL" + Chr(9) + "Site" + Chr(9) + "-lnL"
            Print #1, OutString
            For Y = 0 To 1
                OutString = Trim(Str(Y + 1)) + Chr(9) + TotLnL(Y)
                Print #1, OutString
                For x = 1 To Len(TempSeq(0))
                    OutString = Chr(9) + Chr(9) + Trim(Str(x)) + Chr(9) + Trim(Str(LnL(Y, x)))
                    Print #1, OutString
                Next x
            Next Y
                
            Close #1
        Else
           BatIndex = 53
           If DebuggingFlag < 2 Then On Error Resume Next
            KillFile "infile.sitelh"
           On Error GoTo 0
            
            If Z = 0 Then
                If DebuggingFlag < 2 Then On Error Resume Next
                KillFile "intree"
                On Error GoTo 0
                Open "intree" For Output As #1
                For x = 0 To Treecount
                    Print #1, TreeStrings(x)
                Next x
                Close #1
                
            End If
            
            If Z = 0 Then
                Form1.SSPanel1.Caption = "Doing Shimodaira-Hasegawa tests (finding ML branch lengths)"
            Else
                 Form1.SSPanel1.Caption = "Doing SH tests (finding ML branch lengths for tree " + Trim(Str(Z + 1)) + " of " + Trim(Str(Treecount + 1)) + ")"
            End If
            Call ShellAndClose("dnadist.bat", 0)
            x = x
           
        End If
        
        
        XX = Z
        
        
        '0.249 seconds
        x = x
        If DebuggingFlag < 2 Then On Error Resume Next
        FLX = 0
        FLX = FileLen("infile.sitelh.")
        On Error GoTo 0
        If FLX > 0 Then
            If Z = 0 Then
                Form1.SSPanel1.Caption = "Doing Shimodaira-Hasegawa tests (busy with permutation test)"
            Else
                 Form1.SSPanel1.Caption = "Doing SH tests (busy with permutation test for tree " + Trim(Str(Z + 1)) + " of " + Trim(Str(Treecount + 1)) + ")"
            End If
        
            If SHOptMethod = 0 Then
                Call ShellAndClose("makermt --paup infile", 0)
            Else
                Call ShellAndClose("makermt --puzzle infile", 0)
                x = x
            End If
            
            
            Call ShellAndClose("consel infile", 0)
            
            
            
            'Call ShellAndClose("catpv infile", 1)
            Open "infile.pv" For Binary As #1
            Crap = String(LOF(1), " ")
            Get #1, , Crap
            Close #1
            XX = Len(Crap)
            Dim TreeListOrder() As Long
            ReDim TreeListOrder(Treecount)
            
            clistx = -1
            fpos = InStr(1, Crap, "# STAT:", vbBinaryCompare)
            Pos = InStr(1, Crap, "# ITEM:", vbBinaryCompare)
            If Pos > 0 Then
                LPos = Pos
                Pos = InStr(LPos + 7, Crap, " ", vbBinaryCompare)
                x = x
                
                
                Do While Pos <= fpos
                    Do While Pos <= fpos
                        Pos = Pos + 1
                        If Mid(Crap, Pos, 1) <> " " Then
                            If Mid(Crap, Pos, 1) <> Chr(13) Then
                                If Mid(Crap, Pos, 1) <> Chr(10) Then
                                    Exit Do
                                End If
                            End If
                        End If
                    Loop
                    LPos = Pos
                    'XX = Mid(Crap, LPos, 5)
                    Pos = InStr(LPos + 1, Crap, " ", vbBinaryCompare)
                    If Pos >= fpos Then Exit Do
                    clistx = clistx + 1
                    TreeListOrder(clistx) = CLng(Mid$(Crap, LPos, Pos - LPos))
                    
                Loop
                x = x
                
            End If
            'Exit Sub
            
            
            Pos = InStr(1, Crap, "# row:", vbBinaryCompare)
            For x = 0 To Treecount
                clistx = -1
                target1 = "# row: " + Trim(Str(x))
                If x < Treecount Then
                    target2 = "# row: " + Trim(Str(x + 1))
                Else
                    target2 = "# SE:"
                End If
                fpos = InStr(1, Crap, target2, vbBinaryCompare)
                Pos = InStr(1, Crap, target1, vbBinaryCompare)
                If Pos > 0 Then
                    LPos = Pos
                   
                    Pos = InStr(LPos + (Len(target1)), Crap, " ", vbBinaryCompare)
                     'XX = Mid(Crap, Pos, 5)
                    
                    
                    Do While Pos <= fpos
                        Do While Pos <= fpos
                            Pos = Pos + 1
                            'XX = Mid(Crap, Pos, 5)
                            If Mid(Crap, Pos, 1) <> " " Then
                                If Mid(Crap, Pos, 1) <> Chr(13) Then
                                    If Mid(Crap, Pos, 1) <> Chr(10) Then
                                        Exit Do
                                    End If
                                End If
                            End If
                        Loop
                        LPos = Pos
                        'XX = Mid(Crap, LPos, 5)
                        Pos = InStr(LPos + 1, Crap, " ", vbBinaryCompare)
                        If Pos >= fpos Then Exit Do
                        clistx = clistx + 1
                        If clistx = 5 Then
                        
                            SHMatrixX(0, Z, TreeListOrder(x)) = CSng(Mid$(Crap, LPos, Pos - LPos)) 'weighted sh test
                            x = x
                        ElseIf clistx = 6 Then
                            SHMatrixX(1, Z, TreeListOrder(x)) = CSng(Mid$(Crap, LPos, Pos - LPos)) 'approx unbiased test
                            Exit Do
                        End If
                        
                    Loop
                    x = x
                    
                End If
            Next x
            
            
        Else
            MsgBox ("RAxML experienced a problem optimising the branch lengths of the trees - I'll therefore be unable to do this test with these specific trees.  The test may, however, work if you change one or both trees from, for example, a UPGMA to a neighbour joining tree")
            
            Exit Sub
        End If
        
        
        Form1.ProgressBar1.Value = 5 + (Z / Treecount) * 95
        Form1.SSPanel1.Caption = "SH tests completed for " + Trim(Str(Z + 1)) + " of " + Trim(Str(Treecount + 1)) + " trees"
        Call UpdateF2Prog
        Form1.Refresh
    Next Z
    EE = Abs(GetTickCount)
    TT = EE - SS '3352 seconds with poty test 400 bp winodws and 100 bp stepsize on laptop
    x = x
    
    If PermSeqNumInFile = 1 Then
        
        ReDim PermSeqNum(0, 0)
        
    
    End If
    Form1.Picture26.Enabled = True
Else
    Treecount = UBound(SHMatrixX, 2)
End If
    
'CurMatrixFlag = 12

MatBound(12) = Treecount
MaxN = 0
SHOrAUFlag = 0
ReDim MatrixSH(Treecount + 1, Treecount + 1)

For x = 0 To Treecount
    For Y = 0 To Treecount
        If SHMatrixX(SHOrAUFlag, x, Y) > 0 Then
        
        
        
            MatrixSH(x, Y) = -Log(SHMatrixX(SHOrAUFlag, x, Y))
            If MatrixSH(x, Y) > 12 Then
                MatrixSH(x, Y) = 12
            End If
            'If SHMatrixX(0, X, Y) > 11 Then
            '    X = X
            'End If
        Else
            MatrixSH(x, Y) = 12
            
        End If
        If MatrixSH(x, Y) > MaxN Then
            MaxN = MatrixSH(x, Y)
        End If
    Next Y
Next x

Dim PosS(1) As Single, PosE(1) As Single, DistD As Double
RSize = Treecount

'MaxN = 0

'MaxN = FindMaxN(RSize, MatrixSH(0, 0))
Dim XAddj As Double
Form1.Picture26.ScaleMode = 3
XAddj = (Form1.Picture26.ScaleHeight) / RSize
DistD = RSize / MatZoom(12)
XAddj = (Form1.Picture26.ScaleHeight) / DistD
PosS(0) = MatCoord(12, 0)
PosE(0) = PosS(0) + DistD
PosS(1) = MatCoord(12, 1)
PosE(1) = PosS(1) + DistD
If PosE(1) > (UBound(MatrixSH, 1) - 1) - 1 Then PosE(1) = (UBound(MatrixSH, 1) - 1) - 1
If PosE(0) > (UBound(MatrixSH, 1) - 1) - 1 Then PosE(0) = (UBound(MatrixSH, 1) - 1) - 1

If PosS(0) < 0 Then SX = 0 Else SX = PosS(0)
If PosS(1) < 0 Then SY = 0 Else SY = PosS(1)
Form1.Picture26.Picture = LoadPicture()

Call DrawMatsVB(Form1.Picture26, 0, PosE(), PosS(), SX, SY, XAddj, MatrixSH(), HeatMap(), CurScale, MaxN)

If DontDoKey = 0 Then
    'Call DoKey(0, MaxN, MinN, 4, "Number of breakpoints", CurScale)
    Call DoKey(1, MaxN, 0, 12, "-Log(P-Val)", CurScale)
End If
Form1.Picture26.Refresh

DoneMatX(12) = 1
Call UnModNextno

If DebuggingFlag < 2 Then On Error Resume Next
KillFile "infile.txt"
KillFile "infile.rmt"
KillFile "infile.pv"
KillFile "infile.vt"
On Error GoTo 0

Form1.SSPanel1.Caption = ""
Form1.ProgressBar1 = 0
Call UpdateF2Prog
ChDir oDir
ChDrive oDir



End Sub

Public Sub RFMatrix()


    

Dim MaxN As Double, TargePos As Long

'SHWinLen = 2000
'SHStep = 1000
'SHTree = 1 '0=upgma, 1=nj, 2= ls, 3 = ml
'SHTModel = 0 '0=JC, 1 = K2p, 2 = ??, 3 = ML
'SHTRndSeed = 3 'random number seed
'SHOptMethod = 1 '0=phyml, 1 =raxml
'SHOrAUFlag = 0 '0=SH, 1=AU

If SHStep = 0 Then SHStep = 10
If SHWinLen < SHStep Then SHWinLen = SHStep * 100
If SHWinLen > Len(StrainSeq(0)) / 2 Then
    Rat = SHWinLen / SHStep
    SHWinLen = Len(StrainSeq(0)) / 2
    SHStep = SHWinLen / Rat
End If

If Len(StrainSeq(0)) / SHStep > 2000 Then
    SHStep = CLng(Len(StrainSeq(0)) / 2000)
    
End If

If SHWinLen < SHStep * 2 Then SHWinLen = SHStep * 2

Dim OutString As String, TempSeq() As String, Boots() As String, LnL() As Double, TDS As String, TDD As String, PhyMLFlag As Byte
oDir = CurDir
ChDir App.Path
ChDrive App.Path
If DoneMatX(13) = 0 Then
    Form1.SSPanel1.Caption = "Making Robinson-Foulds compatibility matrix"
    Form1.ProgressBar1 = 5
    Call UpdateF2Prog
    Form1.Refresh
    
    If DebuggingFlag < 2 Then On Error Resume Next
    Open "dnadist.bat" For Output As #1
    OutString = ""
    SHOptMethod = 1
    PhyMLFlag = 0
    '''''''''''''''''''''''''''''''''''''''''''''''''''
    'STEP 1 set up the batch files for PHYML and RAXML'
    '''''''''''''''''''''''''''''''''''''''''''''''''''
    If SHOptMethod = 0 Then 'use phyml - unfortunately its not working with the beta build
         OutString = "PhyML_3.0_win32.exe -i infile "
         
         'bootstrap
         OutString = OutString + " -b 0"
         
         'Substitution model
         If TPModel = 0 Then
               OutString = OutString + " -m JC69 "
         ElseIf TPModel = 1 Then
               OutString = OutString + " -m K80 "
         ElseIf TPModel = 6 Then
               OutString = OutString + " -m HKY85 "
         ElseIf TPModel = 2 Then
               OutString = OutString + " -m F81 "
         ElseIf TPModel = 3 Then
               OutString = OutString + " -m F84 "
         ElseIf TPModel = 4 Then
               OutString = OutString + " -m TN93 "
         ElseIf TPModel = 5 Then
               OutString = OutString + " -m GTR "
         End If
         
         
         'tvrat
        ' Outstring = Outstring + "-t e "
         OutString = OutString + "-t 2 "
         
         'proportion invariable sites
         'Outstring = Outstring + " -v e "
         
         'number rate categories
         ' Outstring = Outstring + " -c " + Trim(Str(TPGamma))
           OutString = OutString + " -c 1 "
         
         'gamma correction
         'Outstring = Outstring + " -a e " ' " 1.0"
         OutString = OutString + " -a 0.5 " ' " 1.0"
         
         
         'user tree, optimise branche lengths and sub rates, print site-by site likelihood
         OutString = OutString + " -u intree -o lr --print_site_lnl --no_memory_check"
         'user tree, optimise only branch lengths, print site-by site likelihood
         'Outstring = Outstring + " -u intree -o l --print_site_lnl"
         
         
         
         Print #1, OutString
         Print #1, "del treefile"
         Print #1, "rename infile_phyml_tree.txt treefile "
         Close #1
         On Error GoTo 0
    Else 'use raxml instead of phyml
        Dim SysInfo As SYSTEM_INFO
                
        GetSystemInfo SysInfo
        If DebuggingFlag < 2 Then On Error Resume Next
        
        Print #1, "del RAxML_info.outfile"
        Print #1, "del RAxML_RF-Distances.outfile"
        Print #1, "del RAxML_log.outfile"
        Print #1, "del RAxML_result.outfile"
        Print #1, "del RAxML_bestTree.outfile"
        Print #1, "del RAxML_bootstrap.outfile"
        Print #1, "del RAxML_perSiteLLs.outfile"
        Print #1, "del outfile2"
        'Print #1, "del intree"
        On Error GoTo 0
        
        Print #1, "del RAxML_perSiteLLs.treefile"
        
        Dim NumProc As Long
        NumProc = SysInfo.dwNumberOrfProcessors
        If NumProc > 4 Then NumProc = 4
        
        If NumProc > 2 And x = 12345 Then 'for some reason pthreads crashes/does not give a tree
            OutString = "raxmlHPC-PTHREADS -p 1234 -s infile -n treefile -m GTRCAT -f g -z intree -T " + Trim(Str(NumProc - 1))
        Else
            OutString = "raxmlHPC -p 1234 -f r -n outfile -m GTRCAT -z intree"
        End If
        'raxmlHPC m GTRCAT -z trees -f r -n outfile
        'If RAxMLCats <> 25 Or X = X Then
        '    Outstring = Outstring + " - c " + Trim(Str(RAxMLCats))
        'End If
        
        ' BS reps
        
        
        Print #1, OutString
        Print #1, "del intree"
        'Print #1, "del infile"
        Print #1, "rename RAxML_bestTree.treefile treefile"
        Print #1, "rename RAxML_perSiteLLs.treefile infile.sitelh."
        BatIndex = 53
         
        Close #1
    
    
    End If
    
    
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'STEP 2 Move through the alignment and make a tree for every window'
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
    'Make a copy of permseqnum in tstrainseq - ytempseq will store the sequences in each window that must be passed to phyml/raxml and consel
    Dim tStrainseq() As String, TempSeqNum() As Integer, TreeStrings() As String, NumTrees As Long, Treecount As Long
    
    NumTrees = Len(StrainSeq(0))
    NumTrees = CLng((NumTrees / SHStep) - 0.5)
    NumTrees = NumTrees + 1
    
    ReDim tStrainseq(NextNo), TempSeq(NextNo), TreeStrings(NumTrees)
    
    For x = 0 To PermNextno
        tStrainseq(x) = String(Len(StrainSeq(0)) + SHWinLen, " ")
    Next x
    
    If PermSeqNumInFile = 1 Then
        
        ReDim PermSeqNum(Len(StrainSeq(0)), PermNextno)
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        Open "RDP5PSNFile" + UFTag For Binary As #FF
        Get #FF, , PermSeqNum
        Close #FF
        ChDrive oDirX
        ChDir oDirX
    
    End If
    
    
    For x = 0 To PermNextno
        For Y = 1 To Len(StrainSeq(0))
            Mid(tStrainseq(x), Y, 1) = Chr(PermSeqNum(Y, x) - 1)
        Next Y
        For Y = 1 To SHWinLen
            Mid(tStrainseq(x), Y + Len(StrainSeq(0)), 1) = Chr(PermSeqNum(Y, x) - 1)
        Next Y
    Next x
    
    
    Dim tSubDiffs() As Single, tSubValid() As Single, ValidX() As Single, DiffsX() As Single, Treearray() As Single, SHolder() As Byte, tMat() As Single, ColTotals() As Single, LTree As Long, AvDst As Double, Udst As Double
    ReDim tSubDiffs(PermNextno, PermNextno), tSubValid(PermNextno, PermNextno), tMat(PermNextno, PermNextno)
    Dim tRedoDist() As Integer
    ReDim tRedoDist(NextNo)
    
   
    
    For x = 0 To PermNextno
         tRedoDist(x) = 1
         
    Next x
    
    
    SS = Abs(GetTickCount)
    'make the trees and store them in treestring
    Treecount = -1
    TargetPos = CLng(Len(StrainSeq(0)) / SHStep + 0.5)
    Dim EPos3 As Long
    SSS = Abs(GetTickCount)
    For Z = 1 To Len(StrainSeq(0)) Step SHStep
        Treecount = Treecount + 1
        'If SHTree = 3 Then
        '    For X = 0 To PermNextno
        '        TempSeq(X) = Mid$(tStrainseq(X), Z, SHWinLen)
        '    Next X
        
        'ElseIf SHTree = 0 Or SHTree = 1 Or SHTree = 2 Then
            'copy the relevant bit of sequence info to tempseqnum
            
            
'            ReDim TempSeqNum(SHWinLen, PermNextno)
'            For X = 0 To PermNextno
'                For Y = 0 To SHWinLen - 1
'                    A = Y + Z
'                    If A > Len(StrainSeq(0)) Then
'                        A = A - Len(StrainSeq(0))
'                    End If
'                    TempSeqNum(Y, X) = PermSeqNum(A, X)
'                Next Y
'            Next X
            
            'Make distance matrix with the windowed sequences
            
            ReDim ColTotals(PermNextno), SHolder((PermNextno + 1) * 40 * 2)
                ReDim Treearray(PermNextno, PermNextno)

            'If SHTModel = 0 Or X = X Then
                
                
                
                    
                If x = x Then
                    EPos3 = Z + SHWinLen - 1
                    If EPos3 > Len(StrainSeq(0)) Then EPos3 = Len(StrainSeq(0))
                    
                    'XX = UBound(tMat, 1)
                    'Call FastDistanceCalcX(0, Z, EPos3, PermNextno, tSubDiffs(), tSubValid(), PermSeqNum(), tMat(), AvDst, UDst, tRedoDist())
                    Call FastDistanceCalcZ(1, 0, Z, EPos3, PermNextno, tSubDiffs(), tSubValid(), PermSeqNum(), tMat(), AvDst, Udst, tRedoDist())
                    For A = 0 To PermNextno '6-405
                        For b = 0 To PermNextno
                            tMat(A, b) = 1 - tMat(A, b) '0,1 = 0.549, 0.72:0.54,0.72:
                            x = x
                        Next
                        tMat(A, A) = 0
                    Next
                
'                Else
'                   redim ValidX(0), DiffsX(0)
'                   For A = 0 To PermNextno
'                        For B = A + 1 To PermNextno
'                            ValidX(0) = 0
'                            DiffsX(0) = 0
'                            For C = 1 To SHWinLen
'                                If TempSeqNum(C, A) <> 46 Then
'                                    If TempSeqNum(C, B) <> 46 Then
'                                        ValidX(0) = ValidX(0) + 1
'                                        If TempSeqNum(C, A) <> TempSeqNum(C, B) Then
'                                            DiffsX(0) = DiffsX(0) + 1
'                                        End If
'                                    End If
'                                End If
'                            Next C
'                            tMat(A, B) = DiffsX(0) / ValidX(0)
'                            tMat(B, A) = tMat(A, B)
'                            'If tMat(A, B) < 0.2 Then
'                            'X = X
'                            'End If
'                        Next B
'                    Next A
                End If
                
                
            'ElseIf SHTModel <> 3 Then
                'Use bootdist for more complex distance models than JC but DNADIST for ML model.
            'Else ' use DNADIST for the ML distance model
            
            'End If
            
            'Draw the NJ tree and store the tree in SHolder in
            'SS = Abs(GetTickCount)
            LTree = NEIGHBOUR(1, 0, BSRndNumSeed, 1, PermNextno + 1, tMat(0, 0), SHolder(0), ColTotals(0), Treearray(0, 0))
            'LTree = Clearcut(0,PermNextno, 1, 100, BSRndNumSeed, 1, UBound(tMat, 1), tMat(0, 0), SHolder(0))
            'EE = Abs(GetTickCount)
            'TT = EE - SS
            TreeStrings(Treecount) = String(LTree, " ")
            For x = 1 To LTree
                Mid$(TreeStrings(Treecount), x, 1) = Chr(SHolder(x))
            Next x
            x = x
'            If Treecount > 0 Then
'                TreeStrings(Treecount) = TreeStrings(0)
'            End If
        
        'End If
        ET = Abs(GetTickCount)
        If Abs(ET - LT) > 500 Then
            'Form1.ProgressBar1.Value = ((B + 1) / (MCCorrection + 1) * 100)
            Form1.ProgressBar1.Value = 5 + (Treecount / TargetPos) * 85
            Form1.SSPanel1.Caption = "Making Robinson-Foulds compatibility matrix (" + Trim(Str(Treecount + 1)) + " out of " + Trim(Str(TargetPos)) + " NJ trees constructed)"
            Call UpdateF2Prog
            LT = ET
            
        End If
        
        
     Next Z
     EE = Abs(GetTickCount)
     TT = EE - SSS '1.250
     x = x
     Form1.SSPanel1.Caption = "Making Robinson-Foulds compatibility matrix (calculating normalised RF distances)"
     Form1.Refresh
     FF = FreeFile
     XX = CurDir
     On Error GoTo 0
     Open "intree" For Output As #FF
     For x = 0 To Treecount
        Print #FF, TreeStrings(x)
        
     Next x
     Close #FF
     
     Call ShellAndClose("dnadist.bat", 0)
     Dim TempMatrixRF() As Single
     ReDim TempMatrixRF(Treecount + 1, Treecount + 1)
    ReDim MatrixRF(Treecount + 1, Treecount + 1)
    'add values from "RAxML_RF-Distances.outfile" to matrixrf
    
    Open "RAxML_RF-Distances.outfile" For Binary As #FF
    Dim TempString As String
    TempString = String(LOF(FF), " ")
    Get #FF, , TempString
    Close #FF
    LastPos = 1
    Dim Pos2 As Long
    Dim LastSSS As Long
    Do
        Pos = InStr(LastPos, TempString, Chr(10), vbBinaryCompare)
        If Pos = 0 Then Exit Do
        'Line Input #FF, TempString
        Pos2 = InStr(LastPos, TempString, " ", vbBinaryCompare)
        'XX = Mid(TempString, LastPos, Pos2 - LastPos)
        x = val(Mid(TempString, LastPos, Pos2 - LastPos))
        LastPos = Pos2
        Pos2 = InStr(LastPos, TempString, ":", vbBinaryCompare)
        ' = Mid(TempString, LastPos + 1, Pos2 - (LastPos + 1))
        Y = val(Mid(TempString, LastPos + 1, Pos2 - (LastPos + 1)))
        LastPos = Pos2 + 2
        Pos2 = InStr(LastPos, TempString, " ", vbBinaryCompare)
        TempMatrixRF(x, Y) = val(Mid(TempString, Pos2 + 1, Pos - Pos2))
        TempMatrixRF(Y, x) = TempMatrixRF(x, Y)
        LastPos = Pos + 1
        'X = X
        SSS = Abs(GetTickCount)
        If Abs(SSS - LastSSS) > 500 Then
            LastSSS = SSS
            Form1.SSPanel1.Caption = Str(CLng(x / UBound(TempMatrixRF, 1) * 100)) + "% of RF distances calculated)"
            DoEvents
        End If
        
    Loop
    Dim TotS, SmoothWin As Long
    
    SmoothWin = 0
    For x = 0 To Treecount
        For Y = 0 To Treecount
            If x <> Y Then
                TotS = 0
                For A = x - SmoothWin To x + SmoothWin
                    For b = Y - SmoothWin To Y + SmoothWin
                        If A >= 0 And A <= Treecount Then
                            If b >= 0 And b <= Treecount Then
                                
                                If A <> b Then
                                    MatrixRF(x, Y) = MatrixRF(x, Y) + TempMatrixRF(A, b)
                                    TotS = TotS + 1
                                End If
                            End If
                        End If
                    Next b
                Next A
                MatrixRF(x, Y) = MatrixRF(x, Y) / TotS
            End If
        Next Y
    Next x
    
    If PermSeqNumInFile = 1 Then
        
        ReDim PermSeqNum(0, 0)
        
    
    End If
    
    'Close #FF
Else
    Treecount = UBound(MatrixRF, 1) - 1
End If
'smooth the matrix


MatBound(13) = Treecount
MaxN = 0
'SHOrAUFlag = 0


For x = 0 To Treecount
    For Y = 0 To Treecount
        
        If MatrixRF(x, Y) > MaxN Then
            MaxN = MatrixRF(x, Y)
        End If
    Next Y
Next x

Dim PosS(1) As Single, PosE(1) As Single, DistD As Double
RSize = Treecount

'MaxN = 0

'MaxN = FindMaxN(RSize, matrixrf(0, 0))
Dim XAddj As Double
Form1.Picture26.ScaleMode = 3
XAddj = (Form1.Picture26.ScaleHeight) / RSize
DistD = RSize / MatZoom(13)
XAddj = (Form1.Picture26.ScaleHeight) / DistD
PosS(0) = MatCoord(13, 0)
PosE(0) = PosS(0) + DistD
PosS(1) = MatCoord(13, 1)
PosE(1) = PosS(1) + DistD
If PosE(1) > (UBound(MatrixRF, 1) - 1) - 1 Then PosE(1) = (UBound(MatrixRF, 1) - 1) - 1
If PosE(0) > (UBound(MatrixRF, 1) - 1) - 1 Then PosE(0) = (UBound(MatrixRF, 1) - 1) - 1

If PosS(0) < 0 Then SX = 0 Else SX = PosS(0)
If PosS(1) < 0 Then SY = 0 Else SY = PosS(1)
Form1.Picture26.Picture = LoadPicture()

Call DrawMatsVB(Form1.Picture26, 0, PosE(), PosS(), SX, SY, XAddj, MatrixRF(), HeatMap(), CurScale, MaxN)

If DontDoKey = 0 Then
    'Call DoKey(0, MaxN, MinN, 4, "Number of breakpoints", CurScale)
    Call DoKey(1, MaxN, 0, 12, "Normalised RF distance", CurScale)
End If
Form1.Picture26.Refresh

DoneMatX(13) = 1
Call UnModNextno

If DebuggingFlag < 2 Then On Error Resume Next
KillFile "infile.txt"
KillFile "infile.rmt"
KillFile "infile.pv"
KillFile "infile.vt"
On Error GoTo 0

Form1.SSPanel1.Caption = ""
Form1.ProgressBar1 = 0
Call UpdateF2Prog
ChDir oDir
ChDrive oDir

End Sub
Public Sub DoLegend()
    If RIMode = 1 Then
        RIMode = 0
        VS4Max2 = Form1.VScroll4.Max
        VS4CV = Form1.VScroll4.Value
        Form1.VScroll4.Value = 0
        Form1.VScroll4.Max = VS4Max
        If SEventNumber > 0 Then
            Form1.Command13(2).Enabled = True
            Form1.Command13(2).Caption = "Overview"
            Form1.Command13(2).ToolTipText = "Press for summarized information on recombination events 1 through " + Trim(Str(SEventNumber))
            'Picture2.Height = 2500
        Else
            Form1.Command13(2).Caption = "Overview"
            Form1.Command13(2).Enabled = False
        End If
    End If
    Dim sty As Integer
    Dim LenStr As Long, OldCY As Long, x As Long, Z As Long, NumX As String, PowX As String, ExtraX As String

    If Form5.Combo1.ListIndex < 1 And (ManFlag = 3 Or ManFlag = 1 Or ManFlag = 7 Or ManFlag = 4) Then Exit Sub
    Form1.Frame17.Visible = False
    With Form1.Picture2
        .AutoRedraw = True
        .Picture = LoadPicture()
        .CurrentX = 0
        .CurrentY = 5
        .ScaleMode = 3
        .BackColor = BackColours
    End With
    If ManFlag <> 161 Then
        If ((NumberOfSeqs + 10) * 15 * Screen.TwipsPerPixelY) > Form1.Picture2.Height Then Form1.Picture2.Height = ((NumberOfSeqs + 10) * 15) * Screen.TwipsPerPixelY
    Else
        'If ((GeneNUmber * 2 + 30) * 15 * Screen.TwipsPerPixelY) > Form1.Picture2.Height Then Form1.Picture2.Height = ((GeneNUmber * 2 + 30) * 15) * Screen.TwipsPerPixelY
    End If
    With Form1.SSPanel16
        .BackColor = QBColor(8)
        .FontSize = 12
        .FontBold = True
    End With
    If ManFlag <> 161 Then
        With Form1.Combo1
            .Clear
            .BackColor = Form1.BackColor
            .Enabled = False
        End With
    End If

    ' Form1.Command29(0).Enabled = True:Form1.Command29(1).Enabled = false
    ReDim RefCol(NumberOfSeqs + 1)
    RefCol(0) = GetPixel(Form1.Picture2.hdc, 2, 2)
If DebuggingFlag < 2 Then On Error Resume Next
    If ManFlag = 60 Then 'SCHEMA legend
        Form1.SSPanel16.Caption = "SCHEMA (protein folding disruption tests)"
        'Form1.Picture2.FontBold = True
        Dim PWid As Long, Increment As Long
        PWid = Form1.Picture2.ScaleWidth - 10
        Increment = PWid / 14
        Form1.Picture2.CurrentY = 5
        Form1.Picture2.Line (5, Form1.Picture2.CurrentY)-(PWid + 5, Form1.Picture2.CurrentY)
        Form1.Picture2.CurrentY = 10
        Form1.Picture2.CurrentX = 5 + Increment * 1 - Form1.Picture2.TextWidth("Protein num") / 2
        Form1.Picture2.Print "Protein num (pdb name)"
        Form1.Picture2.CurrentY = 10
        Form1.Picture2.CurrentX = 5 + Increment * 5 - Form1.Picture2.TextWidth("Alignment coordinates") / 2
        Form1.Picture2.Print "Alignment coordinates"
        Form1.Picture2.CurrentY = 10
        Form1.Picture2.CurrentX = 5 + Increment * 9 - Form1.Picture2.TextWidth("Breakpoint num") / 2
        Form1.Picture2.Print "Breakpoint num"
        Form1.Picture2.CurrentY = 10
        Form1.Picture2.CurrentX = 5 + Increment * 12 - Form1.Picture2.TextWidth("p-value") / 2
        Form1.Picture2.Print "p-value"
        Form1.Picture2.Line (5, Form1.Picture2.CurrentY)-(PWid + 5, Form1.Picture2.CurrentY)
        Form1.Picture2.CurrentY = 30
        Dim Outval As String, BackY As Long
        
        For Y = 0 To PermPDBNo
            BackY = Form1.Picture2.CurrentY
            Outval = Trim(Str(Y + 1))
            Outval = Outval ' + "(" + PDBFileName(ProtInfo(3, Y)) + ")" 'ProtInfo(3, CurProt)
            Form1.Picture2.CurrentX = 5 + Increment * 1 - Form1.Picture2.TextWidth(Outval) / 2
            Form1.Picture2.Print Outval
            
            Form1.Picture2.CurrentY = BackY
            Outval = Trim(Str(ProtInfo(0, Y))) + " - " + Trim(Str(ProtInfo(1, Y)))
            Form1.Picture2.CurrentX = 5 + Increment * 5 - Form1.Picture2.TextWidth(Outval) / 2
            Form1.Picture2.Print Outval
            
            Form1.Picture2.CurrentY = BackY
            Outval = Trim(Str(NOC(Y)))
            Form1.Picture2.CurrentX = 5 + Increment * 9 - Form1.Picture2.TextWidth(Outval) / 2
            Form1.Picture2.Print Outval
            
            Form1.Picture2.CurrentY = BackY
            Outval = Trim(Str(LowerThanReal(Y)))
            If Left(Outval, 1) = "." Then
                Outval = "0" + Outval
            End If
            Form1.Picture2.CurrentX = 5 + Increment * 12 - Form1.Picture2.TextWidth(Outval) / 2
            Form1.Picture2.Print Outval
            
            
        Next Y
        Form1.Picture2.CurrentY = Form1.Picture2.CurrentY + 5
        Form1.Picture2.Line (5, Form1.Picture2.CurrentY)-(PWid + 5, Form1.Picture2.CurrentY)
        'Call WriteTextNum(Form1.Picture2, "Watterson theta per site: ", VarRho(6) / VarRho(3))
    ElseIf ManFlag = 161 Then 'recombination breakpoint clustering tests
        Call DrawCTBlocks
    ElseIf ManFlag = 20 Then
        If VarRho(3) = 0 Then Exit Sub 'this means ldhat/interval has not finished running yet
        Form1.SSPanel16.Caption = "LDHat recombination rate scan"
        Form1.Picture2.FontBold = True
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "POPULATION SCALED RECOMBINATION (RHO) & MUTATION (THETA) RATES"
        Form1.Picture2.Print ""
        Form1.Picture2.FontBold = False
        Call WriteTextNum(Form1.Picture2, "Watterson theta per site: ", VarRho(6) / VarRho(3))
        
        
        Form1.Picture2.Print ""
        Call WriteTextNum(Form1.Picture2, "Av. rho per site: ", VarRho(0))
        Call WriteTextNum(Form1.Picture2, "Lower bound (95th percentile): ", VarRho(1))
        Call WriteTextNum(Form1.Picture2, "Upper bound (95th percentile): ", VarRho(2))
        
        Form1.Picture2.Print ""
        
        Call WriteTextNum(Form1.Picture2, "Watterson theta: ", VarRho(6))
       
        Form1.Picture2.Print ""
        Call WriteTextNum(Form1.Picture2, "Rho: ", VarRho(0) * VarRho(3))
         Call WriteTextNum(Form1.Picture2, "Lower bound (95th percentile): ", VarRho(1) * VarRho(3))
         Call WriteTextNum(Form1.Picture2, "Upper bound (95th percentile): ", VarRho(2) * VarRho(3))

        Form1.Picture2.Print ""
        
        Call WriteTextNum(Form1.Picture2, "rho/theta: ", (VarRho(0) * VarRho(3)) / VarRho(6))
        
        Form1.Picture2.Print ""
        
        Call WriteTextNum(Form1.Picture2, "No. Segregating sites: ", VarRho(4))
        Call WriteTextNum(Form1.Picture2, "Av. pairwise difference: ", VarRho(5))
        Call WriteTextNum(Form1.Picture2, "Varience pairwise difference: ", VarRho(9))
        
        Form1.Picture2.Print ""
        
        If FreqCo < 1 / NextNo Then
            
        
        
            Form1.Picture2.FontBold = True
            Form1.Picture2.CurrentX = 5
            Form1.Picture2.Print "Tests of Neutrality"
            Form1.Picture2.FontBold = False
            If VarRho(7) >= 0 Then
                Call WriteTextNum(Form1.Picture2, "Tajima's D statistic: ", Str(VarRho(7)))
            Else
                Call WriteTextNum(Form1.Picture2, "Tajima's D statistic: -", Str(Abs(VarRho(7))))
            End If
            If VarRho(8) >= 0 Then
                Call WriteTextNum(Form1.Picture2, "Tajima's D statistic: ", Str(VarRho(8)))
            Else
                Call WriteTextNum(Form1.Picture2, "Tajima's D statistic: -", Str(Abs(VarRho(8))))
            End If
            Call NumToString(VarRho(8), 3, NumX, PowX, ExtraX)
            Form1.Picture2.Print ""
        End If
        Form1.Picture2.Print ""
        Form1.Picture2.FontBold = True
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "SETTINGS"
        Form1.Picture2.Print ""
        Form1.Picture2.FontBold = False
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "Starting rho:" + Str(StartRho)
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "Block penalty:" + Str(BlockPen)
        Call WriteTextNum(Form1.Picture2, "Minor allele frequency cutoff: ", FreqCo)
        Call WriteTextNum(Form1.Picture2, "Missing data frequency cutoff: ", FreqCoMD)
        If GCFlag = 1 Then
            Form1.Picture2.CurrentX = 5
            Form1.Picture2.Print "Average gene conversion tract length:" + Str(GCTractLen)
        End If
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "MCMC updates:" + Str(MCMCUpdates)
        Form1.Picture2.CurrentX = 5
        Form1.Picture2.Print "MCMC burnin:"; Str(CLng(MCMCUpdates / 10))
    ElseIf ManFlag = 1 Then
    
        Form1.SSPanel16.Caption = "Manual GENECONV Scan"
        Form1.Picture2.Print OriginalName(Form5.Combo1.ListIndex - 1) + " scanned against:"
        sty = Form1.Picture2.CurrentY + 5
        If APlot <= UBound(RevSeq, 1) Then
            If APlot > 0 And APlot <= NumberOfSeqs Then
                Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(APlot)), BF
            ElseIf APlot = NumberOfSeqs + 1 Then
                Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(0)), BF
            End If
        Else
            Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(0)), BF
        End If
        For Z = 1 To NumberOfSeqs
            If UBound(SeqCol, 1) < RevSeq(Z) Then ReDim Preserve SeqCol(RevSeq(Z))
            Form1.Picture2.Line (5, sty + (Z - 1) * 15)-(17, sty + 12 + (Z - 1) * 15), SeqCol(RevSeq(Z)), BF
            RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z - 1) * 15 + 1)
        Next 'Z

        Form1.Picture2.Line (5, sty + (Z - 1) * 15)-(17, sty + 12 + (Z - 1) * 15), SeqCol(RevSeq(0)), BF
        RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z - 1) * 15 + 1)
        Form1.Picture2.Print
        Form1.Picture2.Print "G-Scale:" & CStr(GCMissmatchPen)
        Form1.Picture2.Print "Minimum aligned fragment length:" & CStr(GCMinFragLen)
        Form1.Picture2.Print "Minimum number of polymorphisms per fragment:" & CStr(GCMinPolyInFrag)
        Form1.Picture2.Print "Minimum pairwise fragment score:" & CStr(GCMinPairScore)

        If GCIndelFlag = 0 Then
            Form1.Picture2.Print "Indels ignored"
        ElseIf GCIndelFlag = 1 Then
            Form1.Picture2.Print "Indel blocs used as single polymorphisms"
        Else
            Form1.Picture2.Print "Every indel used as a single polymorphism"
        End If

        If GCMonoSiteFlag = 0 Then
            Form1.Picture2.Print "Monomorphic sites not used"
        ElseIf GCMonoSiteFlag Then
            Form1.Picture2.Print "Monomorphic sites used"
        End If

        If GCNumPerms > 1 Then
            Form1.Picture2.Print "Permutations used:"; CStr(GCNumPerms)
        Else
            Form1.Picture2.Print "No Permutations used"
        End If

        Form1.Picture2.ForeColor = 0

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
            If MakeConsFlag = 1 Then
                Form1.Picture2.Print "Consensus of reference group " + Trim(Str(ReferenceList(RevSeq(Z)))) + " (which includes " + OriginalName(RevSeq(Z)) + ")"
            Else
                Form1.Picture2.Print OriginalName(RevSeq(Z))
            End If
        Next 'Z

        Form1.Picture2.CurrentX = 25
        Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
        Form1.Picture2.Print "Outer fragments (potentially unknown parents)"
    ElseIf ManFlag = 3 Then
        Form1.SSPanel16.Caption = "Manual Bootscan"
        Form1.Picture2.Print OriginalName(Form5.Combo1.ListIndex - 1) + " scanned against:"
        sty = Form1.Picture2.CurrentY + 5

        If APlot > 0 Then
            Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(APlot)), BF
        End If

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.Line (5, sty + (Z - 1) * 15)-(17, sty + 12 + (Z - 1) * 15), SeqCol(RevSeq(Z)), BF
            RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z - 1) * 15 + 1)
        Next 'Z

        Form1.Picture2.Print
        Form1.Picture2.Print "Window size:" + CStr(BSStepWin)
        Form1.Picture2.Print "Step size:" + CStr(BSStepSize)
        Form1.Picture2.Print "Bootstrap replicates:" + CStr(BSBootReps)

        If BSTypeFlag = 0 Then
            Form1.Picture2.Print "Pairwise distances used"
        ElseIf BSTypeFlag = 1 Then
            Form1.Picture2.Print "Positions in an UPGMA used"
        Else
            Form1.Picture2.Print "Positions in a NJ tree used"
        End If

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
            If MakeConsFlag = 1 Then
                Form1.Picture2.Print "Consensus of reference group " + Trim(Str(ReferenceList(RevSeq(Z)))) + " (which includes " + OriginalName(RevSeq(Z)) + ")"
            Else
                Form1.Picture2.Print OriginalName(RevSeq(Z))
            End If
        Next 'Z

    ElseIf ManFlag = 4 Then
        Form1.SSPanel16.Caption = "Manual MaxChi Scan"
        Form1.Picture2.Print OriginalName(Form5.Combo1.ListIndex - 1) + " scanned against:"
        'Exit Sub
        sty = Form1.Picture2.CurrentY + 5

        If APlot > 0 Then
            Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(APlot)), BF
        End If

        For Z = 0 To GPrintNum
            Form1.Picture2.Line (5, sty + (Z) * 15)-(17, sty + 12 + (Z) * 15), GPrintCol(Z), BF
            RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z) * 15 + 1)
        Next 'Z

        Form1.Picture2.Print

        If MCProportionFlag = 0 Then
            Form1.Picture2.Print "Window size:" + CStr(MCWinSize)
        Else
            Form1.Picture2.Print "Window size:" + CStr(Int(MCWinFract * LenXoverSeq))
        End If

        Form1.Picture2.Print "Step size:" + CStr(MCSteplen)

        If MCStripGapsFlag = 1 Then
            Form1.Picture2.Print "Gaps stripped"
        Else
            Form1.Picture2.Print "Gaps used"
        End If

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
            If MakeConsFlag = 1 Then
                Form1.Picture2.Print "Consensus of reference group " + Trim(Str(ReferenceList(RevSeq(Z)))) + " (which includes " + OriginalName(RevSeq(Z)) + ")"
            Else
                Form1.Picture2.Print OriginalName(RevSeq(Z))
            End If
        Next 'Z

    ElseIf TManFlag = 5 Then
        Form1.SSPanel16.Caption = "Manual LARD Scan"
        Form1.Picture2.CurrentY = 5
        Form1.Picture2.Print
        OldCY = Form1.Picture2.CurrentY
        LenStr = Form1.Picture2.TextWidth("Sequences scanned: ")
        Form1.Picture2.Print "Selected sequences:"
        Form1.Picture2.CurrentY = OldCY

        For x = 0 To 2
            Form1.Picture2.CurrentX = LenStr
            Form1.Picture2.Print OriginalName(RevSeq(x))
        Next 'X

        Form1.Picture2.Print
        Form1.Picture2.Print "Step size:" + CStr(LRDStep)
    ElseIf ManFlag = 7 Then
        Form1.SSPanel16.Caption = "Manual Distance Plot"
        Form1.Picture2.Print OriginalName(Form5.Combo1.ListIndex - 1) + " scanned against:"
        sty = Form1.Picture2.CurrentY + 5

        If APlot > 0 Then
            Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(APlot)), BF
        End If

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.Line (5, sty + (Z - 1) * 15)-(17, sty + 12 + (Z - 1) * 15), SeqCol(RevSeq(Z)), BF
            RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z - 1) * 15 + 1)
        Next 'Z

        Form1.Picture2.Print
        Form1.Picture2.Print "Window size:" + CStr(DPWindow)
        Form1.Picture2.Print "Step size:" + CStr(DPStep)

        For Z = 1 To NumberOfSeqs
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
            If MakeConsFlag = 1 Then
                Form1.Picture2.Print "Consensus of reference group " + Trim(Str(ReferenceList(RevSeq(Z)))) + " (which includes " + OriginalName(RevSeq(Z)) + ")"
            Else
                Form1.Picture2.Print OriginalName(RevSeq(Z))
            End If
        Next 'Z

    ElseIf ManFlag = 8 Then
        Form1.SSPanel16.Caption = "Manual TOPAL Scan"
        Form1.Picture2.CurrentY = 5
        Form1.Picture2.Print
        OldCY = Form1.Picture2.CurrentY
        LenStr = Form1.Picture2.TextWidth("Sequences scanned: ")
        Form1.Picture2.Print "Selected sequences:"
        Form1.Picture2.CurrentY = OldCY

        For x = 0 To ToNumSeqs
            Form1.Picture2.CurrentX = LenStr
            Form1.Picture2.Print OriginalName(RevSeq(x))
        Next 'X

        Form1.Picture2.Print

        If TOPerms > 0 Then
            sty = Form1.Picture2.CurrentY + 5
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (0) * 15
            Form1.Picture2.Print "Scan of selected sequences"
            Form1.Picture2.Line (5, sty + (0) * 15)-(17, sty + 12 + (0) * 15), 0, BF
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (1) * 15

            If TOPerms > 1 Then
                Form1.Picture2.Print "Scans of permuted datasets"
            Else
                Form1.Picture2.Print "Scan of permuted dataset"
            End If

            Form1.Picture2.Line (5, sty + (1) * 15)-(17, sty + 12 + (1) * 15), QBColor(8), BF
        End If

        Form1.Picture2.Print
        Form1.Picture2.Print "Window size:" + CStr(TOWinLen)
        Form1.Picture2.Print "Step size:" + CStr(TOStepSize)
        Form1.Picture2.Print "Smoothing window size:" + CStr(TOSmooth)

        If TOPerms > 0 Then
            Form1.Picture2.Print "Number of permutations:" + CStr(TOPerms)
        Else
            Form1.Picture2.Print "No permutations performed"
        End If
    ElseIf ManFlag = 10 Then
        'NumberOfSeqs = Nextno + 1
        
        Form1.SSPanel16.Caption = "Manual PhylPro Scan"
        
        sty = Form1.Picture2.CurrentY + 5
        If APlot <= GPrintNum Then
            If APlot > 0 Then
                Form1.Picture2.Line (0, sty - 2 + (APlot - 1) * 15)-(Form1.Picture2.ScaleWidth, sty + 14 + (APlot - 1) * 15), FFillCol(RevSeq(APlot)), BF
            End If
        End If
        For Z = 1 To GPrintNum + 1
            Form1.Picture2.Line (5, sty + (Z - 1) * 15)-(17, sty + 12 + (Z - 1) * 15), SeqCol(RevSeq(Z)), BF
            RefCol(Z) = GetPixel(Form1.Picture2.hdc, 6, sty + (Z - 1) * 15 + 1)
        Next 'Z

        Form1.Picture2.Print

        If MCProportionFlag = 0 Then
            Form1.Picture2.Print "Window size:" + CStr(MCWinSize)
        Else
            Form1.Picture2.Print "Window size:" + CStr(Int(MCWinFract * LenXoverSeq))
        End If

        Form1.Picture2.Print "Step size:" + CStr(MCSteplen)

        If MCStripGapsFlag = 1 Then
            Form1.Picture2.Print "Gaps stripped"
        Else
            Form1.Picture2.Print "Gaps used"
        End If

        For Z = 1 To GPrintNum + 1
            Form1.Picture2.ForeColor = 0
            Form1.Picture2.CurrentX = 25
            Form1.Picture2.CurrentY = sty + 1 + (Z - 1) * 15
            If MakeConsFlag = 1 Then
                Form1.Picture2.Print "Consensus of reference group " + Trim(Str(ReferenceList(RevSeq(Z)))) + " (which includes " + OriginalName(RevSeq(Z)) + ")"
            Else
                Form1.Picture2.Print OriginalName(RevSeq(Z))
            End If
        Next 'Z
    End If
    
    On Error GoTo 0
    
    If ManFlag <> 161 Then
        P2DHeight = Form1.Picture2.CurrentY + (15) * 7
    
        If P2DHeight > (Form1.Picture32.ScaleHeight / Screen.TwipsPerPixelY) Then
            Form1.VScroll4.Max = P2DHeight - (Form1.Picture32.ScaleHeight / Screen.TwipsPerPixelY)
            Form1.VScroll4.Enabled = True
        Else
    
            If Form1.Picture2.Top = 0 Then Form1.VScroll4.Enabled = False
        End If
    End If
    Form1.Picture2.Refresh
End Sub


Public Sub PutPermValid()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBPermValid = UBound(PermValid, 1)
Open "RDP5PermValid" + UFTag For Binary As #FF
Put #FF, , PermValid()
Close #FF
If oDirX <> App.Path Then
    ChDrive oDirX
    ChDir oDirX
End If
End Sub
Public Sub PutPermDiffs()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBPermDiffs = UBound(PermDIffs, 1)
Open "RDP5PermDiffs" + UFTag For Binary As #FF
Put #FF, , PermDIffs()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutSAMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBSAMat = UBound(SAMat, 1)
Open "RDP5SAMat" + UFTag For Binary As #FF
'&'&'&
Put #FF, , SAMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutSCMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBSCMat = UBound(SCMat, 1)
Open "RDP5SCMat" + UFTag For Binary As #FF
Put #FF, , SCMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutFCMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBFCMat = UBound(FCMat, 1)
Open "RDP5FCMat" + UFTag For Binary As #FF
Put #FF, , FCMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutFAMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBFAMat = UBound(FAMat, 1)
Open "RDP5FAMat" + UFTag For Binary As #FF
Put #FF, , FAMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutSubValid()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBSubValid = UBound(SubValid, 1)
Open "RDP5SubValid" + UFTag For Binary As #FF
'&'&
Put #FF, , SubValid()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutSubDiffs()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBSubDiffs = UBound(SubDiffs, 1)
Open "RDP5SubDiffs" + UFTag For Binary As #FF
Put #FF, , SubDiffs()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutSMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBSMat = UBound(SMat, 1)
Open "RDP5SMat" + UFTag For Binary As #FF
'&'&
Put #FF, , SMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub PutFMat()
Dim oDirX As String, FF As Long
FF = FreeFile
oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

UBFMat = UBound(FMat, 1)
Open "RDP5FMat" + UFTag For Binary As #FF
'&'&'&
Put #FF, , FMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub GetSCMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim SCMat(UBSCMat, UBSCMat)
Open "RDP5SCMat" + UFTag For Binary As #FF
Get #FF, , SCMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetSubValid()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim SubValid(UBSubValid, UBSubValid)
'@
Open "RDP5SubValid" + UFTag For Binary As #FF
'&'&
Get #FF, , SubValid()
Close #FF
'@
If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetSubDiffs()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim SubDiffs(UBSubDiffs, UBSubDiffs)
Open "RDP5SubDiffs" + UFTag For Binary As #FF
Get #FF, , SubDiffs()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub GetSAMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim SAMat(UBSAMat, UBSAMat)
Open "RDP5SAMat" + UFTag For Binary As #FF
Get #FF, , SAMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub

Public Sub GetSMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
'@
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim SMat(UBSMat, UBSMat)
Open "RDP5SMat" + UFTag For Binary As #FF
Get #FF, , SMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetFMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim FMat(UBFMat, UBFMat)
Open "RDP5FMat" + UFTag For Binary As #FF
Get #FF, , FMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If
End Sub
Public Sub GetFAMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile
'&
ReDim FAMat(UBFAMat, UBFAMat)
Open "RDP5FAMat" + UFTag For Binary As #FF
'&
Get #FF, , FAMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetFCMat()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim FCMat(UBFCMat, UBFCMat)
Open "RDP5FCMat" + UFTag For Binary As #FF
Get #FF, , FCMat()
Close #FF

If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetPermValid()
Dim oDirX As String, FF As Long

oDirX = CurDir
'@
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile
'&
ReDim PermValid(UBPermValid, UBPermValid)
'@
Open "RDP5PermValid" + UFTag For Binary As #FF
Get #FF, , PermValid()
Close #FF
'@
If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetPermDiffs()
Dim oDirX As String, FF As Long

oDirX = CurDir
If oDirX <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If
FF = FreeFile

ReDim PermDIffs(UBPermDiffs, UBPermDiffs)
'@
Open "RDP5PermDiffs" + UFTag For Binary As #FF
Get #FF, , PermDIffs()
Close #FF
'@'@
If oDirX <> App.Path Then
    ChDir oDirX
    ChDrive oDirX
End If

End Sub
Public Sub GetDistance()
Dim oDir As String, FF As Long
oDir = CurDir
If oDir <> App.Path Then
    ChDrive App.Path
    ChDir App.Path
End If

FF = FreeFile
ReDim Distance(UBDistance, UBDistance)
Open "RDP5Distance" + UFTag For Binary As #FF
Get #FF, , Distance()
Close #FF

If oDir <> App.Path Then
    ChDir oDir
    ChDrive oDir
End If
End Sub
Public Sub ShutRunning()

    Dim oDir As String, TitleTmp As String, Dummy As Long
    Dim tExitCode As Long, nRet As Long, x As Long

    Const STILL_ACTIVE = &H103
    If DebuggingFlag < 2 Then On Error Resume Next
    'Shut down any shelled apps that may still be running

    If scProcess > 0 Then
        TitleTmp = Space$(256)
        nRet = GetWindowText(scWndJob, TitleTmp, Len(TitleTmp))

        If nRet Then
            TitleTmp = UCase$(Left$(TitleTmp, nRet))

            If InStr(TitleTmp, "FINISHED") = 1 Then

                Call SendMessage(scWndJob, WM_CLOSE, 0, 0)

            End If

        End If

        GetExitCodeProcess scProcess, nRet

        If nRet = STILL_ACTIVE Then
            TerminateProcess scProcess, nRet
        End If

        CloseHandle scProcess
        scProcess = 0
    End If

    If reProcess > 0 Then
        GetExitCodeProcess reProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess reProcess, tExitCode
            Dummy = CloseHandle(reProcess)
        End If

        reProcess = 0
    End If

    tExitCode = 0

    If mcProcess > 0 Then
        GetExitCodeProcess mcProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess mcProcess, tExitCode
            Dummy = CloseHandle(mcProcess)
        End If

        mcProcess = 0
    End If

    tExitCode = 0

    If gcmcProcess > 0 Then
        GetExitCodeProcess gcmcProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess gcmcProcess, tExitCode
            Dummy = CloseHandle(gcmcProcess)
        End If

        gcmcProcess = 0
    End If

    tExitCode = 0

    If gcProcess > 0 Then
        GetExitCodeProcess gcProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess gcProcess, tExitCode
            Dummy = CloseHandle(gcProcess)
        End If

        gcProcess = 0
    End If

    tExitCode = 0

    If cProcess > 0 Then
        GetExitCodeProcess cProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess cProcess, tExitCode
            Dummy = CloseHandle(cProcess)
        End If

        cProcess = 0
    End If

    tExitCode = 0

    If hProcess > 0 Then
        GetExitCodeProcess hProcess, tExitCode

        If tExitCode = STILL_ACTIVE Then
            TerminateProcess hProcess, tExitCode
            Dummy = CloseHandle(hProcess)
        End If

        hProcess = 0
    End If

    If lProcess > 0 Then
        GetExitCodeProcess lProcess, nRet
        TitleTmp = Space$(256)
        nRet = GetWindowText(lWndJob, TitleTmp, Len(TitleTmp))

        If nRet Then
            TitleTmp = UCase$(Left$(TitleTmp, nRet))

            If InStr(TitleTmp, "FINISHED") = 1 Then

                Call SendMessage(lWndJob, WM_CLOSE, 0, 0)

            End If

        End If

        GetExitCodeProcess lProcess, nRet

        If nRet = STILL_ACTIVE Then
            TerminateProcess lProcess, nRet
        End If

        CloseHandle lProcess
        lProcess = 0
    End If

    'clean up outfiles
    
    oDir = CurDir
    ChDir App.Path
    ChDrive App.Path
    KillFile "tf"
    KillFile "comp.cfg"
    KillFile "comp.frags"
    KillFile GCFragCfg
    KillFile GCOFile
    KillFile GCCompCfg
    KillFile GCPOutCfg
    KillFile GCCFile
    KillFile GCFragSeq
    KillFile "outfiley"
    KillFile "infile"
    KillFile "outfilex"
    KillFile "rdpfile.txt"
    KillFile "LARD.EXE.stackdump"
    KillFile "lardin"
    KillFile "config.cfg"
    KillFile "dnadist.bat"
    KillFile "dnaml.bat"
    KillFile "fitch1.bat"
    KillFile "fitch2.bat"
    KillFile "fitch3.bat"
    KillFile "fitch4.bat"
    KillFile "in"
    KillFile "maxchi.bat"
    KillFile "RDP5maxchiout" + UFTag
    KillFile "neighbor.bat"
    KillFile "neighbor1.bat"
    KillFile "neighbor2.bat"
    KillFile "optfile"
    KillFile "optfiled"
    KillFile "optfilef1"
    KillFile "optfilef2"
    KillFile "optfilef3"
    KillFile "optfilef4"
    KillFile "optfilen"
    KillFile "optfilen1"
    KillFile "optfilen2"
    KillFile "optfiles"
    KillFile "out.eps"
    KillFile "out.sit"
    KillFile "RETICULATE.EXE.stackdump"
    KillFile "rnd.eps"
    KillFile "stat"
    KillFile "seqboot.bat"
    KillFile "RDP5BSScanData" + UFTag
    KillFile "RDP5bsfile2" + UFTag
    KillFile "distmatrix"
    KillFile "comptf"
    KillFile "consense.bat"
    KillFile "optfilec"
    KillFile "seqgen.bat"
    KillFile FName + "tempseq"
    KillFile BIGFilename
    KillFile "RDP5Distance" + UFTag
    KillFile "RDP5uDistance" + UFTag
    KillFile "RDP5PermValid" + UFTag
    KillFile "RDP5PermDiffs" + UFTag
    KillFile "RDP5TreeDistance" + UFTag
    KillFile "RDP5uTreeDistance" + UFTag
    KillFile "RDP5tTreeDistance" + UFTag
    KillFile "RDP5FVFile" + UFTag
    KillFile "RDP5PSNFile" + UFTag
    KillFile "RDP5PPermDiffs" + UFTag
    KillFile "RDP5PermDistance" + UFTag
    KillFile "RDP5PermTreeDistance" + UFTag
    KillFile "RDP5PPermValid" + UFTag
    KillFile "RDP5SCRFile" + UFTag
    KillFile "RDP5CDFile" + UFTag
    KillFile "RDP5SSFile" + UFTag
    KillFile "RDP5TreeSeqnum" + UFTag
    KillFile "RDP5uSeqnum" + UFTag
    KillFile "RDP5TreeSMat" + UFTag
    KillFile "RDP5TreeFMat" + UFTag
    KillFile "RDP5TreeMatrix" + UFTag
    KillFile "RDP5uMissingData" + UFTag
    'killfile "SequencesForSaving" + UFTag
    KillFile "RDP5BestXOListMi" + UFTag
    KillFile "RDP5BestXOListMa" + UFTag
    KillFile "RDP5BS2" + UFTag
    KillFile "RDP5treefile2" + UFTag
    KillFile "RDP5Longseq" + UFTag
    KillFile "RDP5Strainseq" + UFTag
    KillFile "RDP5VRandTemplate" + UFTag
    KillFile "RDP5TreeX" + UFTag
    KillFile "RDP5uDuTD" + UFTag
    KillFile "RDP5bsfile" + UFTag
    'killfile "SCF"
    KillFile "RDP5Analysislist" + UFTag
    KillFile "RDP5SubValid" + UFTag
    KillFile "RDP5SeqNumFile" + UFTag
    'KillFile "RDP5ExcludeList" + UFTag'cant put this here - needs to go in a form terminate/unload action
    KillFile "RDP5bsfile2" + UFTag
    KillFile "SMDrop" + UFTag
    KillFile "RDP5FMat" + UFTag
    KillFile "RDP5SMat" + UFTag
    KillFile "RDP5FAMat" + UFTag
    KillFile "RDP5SAMat" + UFTag
    KillFile "RDP5FCMat" + UFTag
    KillFile "RDP5SCMat" + UFTag
    KillFile "IF" + UFTag + ".fasta"
    KillFile "IF" + UFTag + ".seq"
    
    
    
    Dim FileName As String
    For x = 0 To MaxUndos
        FileName = "UndoSlot" + Trim(Str(x)) + UFTag
        KillFile FileName
    Next x
    
    Dim KS As String
    For x = 1 To 150
        If x <> 25 And x <> 50 And x <> 75 And x <> 100 And x <> 150 And x <> 125 Then
            KS = "LF0" + Trim(Str(x))
            If KS <> "LF0100" And KS <> "LF250" And KS <> "LF1100" Then
                 KillFile KS
            End If
            
            KS = "LF1" + Trim(Str(x))
           
            If KS <> "LF0100" And KS <> "LF250" And KS <> "LF1100" Then
                KillFile KS
            End If
            KS = "LF2" + Trim(Str(x))
            
            If KS <> "LF0100" And KS <> "LF250" And KS <> "LF1100" Then
                KillFile KS
            End If
        End If
    Next x
    
    Dim FNX As String
    For x = 0 To 25
        FNX = "NF" + UFTag + Trim(Str(x)) 'nodefind
        KillFile FNX
        FNX = "NP" + Trim(Str(x)) 'nodepath
        KillFile FNX
    Next x
    ChDir oDir
    ChDrive oDir
    On Error GoTo 0
End Sub
Public Sub KillFile(FN As String)
If FN = "" Then Exit Sub
If Dir(FN) <> "" Then
    On Error Resume Next
    Kill FN
    On Error GoTo 0
End If

End Sub
Public Sub DoTreeLegend(TNum, TType, TreeBlocksL() As Long, TBLLen As Long, PBox As PictureBox, ExtraDX, AdjYD)
If RelX = 0 And RelY = 0 Then Exit Sub
Dim UB As Long, x As Long, HCg As Long, QCg As Long, ECg As Long
Dim HCb As Long, QCb As Long, ECb As Long
Dim HCr As Long, QCr As Long, ECr As Long
Dim EEcg As Long, EECb As Long, EECr As Long
'Define Colours
HCg = BkG + (255 - BkG) / 2
QCg = BkG + (255 - BkG) / 4
ECg = BkG - (BkG) / 4
                
HCb = BkB + (255 - BkB) / 2
QCb = BkB + (255 - BkB) / 4
ECb = BkB - (BkB) / 4
                
HCr = BkR + (255 - BkR) / 2
QCr = BkR + (255 - BkR) / 4
ECr = BkR - (BkR) / 4
TBLLen = -1


'Define extra Colours

EEcg = (BkG - (BkG) / 8)


EECb = (BkB - (BkB) / 8)

EECr = (BkR + (220 - BkR) / 8)

'
'XX = RGB(0, 0, 255)
'X = X
'Draw Key
   AdjYD = 14
    'PBox.FontSize = 7
    'PBox.ScaleMode = 3
    'PBox.DrawMode = 9
    'PBox.Line (5, (Nextno + 4) * AdjYD)-(5 + AdjYD - 2, 1 * AdjYD - 2), RGB(255, 0, 0), BF
    
    
    If TNum = 3 And TType >= 2 Then
        TBLLen = TBLLen + 1
        'XX = UBound(TreeBlocksL, 2)
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = 0
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = 1 * AdjYD - 2
               
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 0, 128)
            
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = 0 * AdjYD + 1
        TreeBlocksL(TNum, TType, 2, TBLLen) = 11
        'bits with the same events
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = 1 * AdjYD
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = 2 * AdjYD - 2
        
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 128)
        
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = 1 * AdjYD + 1
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        TreeBlocksL(TNum, TType, 2, TBLLen) = 12
        
        ExtraD(0) = 1
                
        
        
               
        'Bits with partial evidence of same events
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 1) * AdjYD
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 1) * AdjYD - 2
        
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 192)
        
        
        
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 1) * AdjYD + 1
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        TreeBlocksL(TNum, TType, 2, TBLLen) = 14
            
        ExtraD(2) = 1
        
        
        'Bits with trace evidence of same events
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 2) * AdjYD
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 2) * AdjYD - 2
        
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 128, 192)
       
        
        
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 2) * AdjYD + 1
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        TreeBlocksL(TNum, TType, 2, TBLLen) = 16
            
        ExtraD(3) = 1
        
         'The major frag of the recombinant
            
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 3) * AdjYD
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 3) * AdjYD - 2
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 0)
        'PBox.DrawMode = 9
        'PBox.CurrentX = 20
        'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
        
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 3) * AdjYD + 1
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        TreeBlocksL(TNum, TType, 2, TBLLen) = 18
        
        ExtraD(3) = 1
          
        'The major Frag of corecombinants
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 4) * AdjYD
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 4) * AdjYD - 2
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(255, 220, 150)
        'PBox.DrawMode = 9
        'PBox.CurrentX = 20
        'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
        
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 4) * AdjYD + 1
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        TreeBlocksL(TNum, TType, 2, TBLLen) = 19
        
        'ExtraD(4) = 1
        'PBox.DrawMode = 9
        'PBox.Line (5, (1 + ExtraD) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD) * AdjYD - 2), RGB(0, 0, 220), BF
        'PBox.DrawMode = 13
        'PBox.CurrentX = 20
        'PBox.CurrentY = (1 + ExtraD) * AdjYD + 1
        'PBox.Print "Potential parent "
        
        If OutsideFlagX <> 2 Then
            'PBox.DrawMode = 9
            'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(64, 64, 220), BF
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 5
            TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 5) * AdjYD
            TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
            TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 5) * AdjYD - 2
            TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(64, 64, 220)
            'PBox.DrawMode = 13
            'PBox.CurrentX = 20
            'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 20
            TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 5) * AdjYD + 1
            TreeBlocksL(TNum, TType, 3, TBLLen) = -1
            TreeBlocksL(TNum, TType, 4, TBLLen) = -1
            TreeBlocksL(TNum, TType, 2, TBLLen) = 7
            'PBox.Print "Potential minor parent "
        Else
            'PBox.DrawMode = 9
            'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(ECr, ECg, QCb), BF
            
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 5
            TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 5) * AdjYD
            TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
            TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + 5) * AdjYD - 2
            TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(ECr, ECg, QCb)
            'PBox.DrawMode = 13
            'PBox.CurrentX = 20
            'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 20
            TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + 5) * AdjYD + 1
            TreeBlocksL(TNum, TType, 3, TBLLen) = -1
            TreeBlocksL(TNum, TType, 4, TBLLen) = -1
            TreeBlocksL(TNum, TType, 2, TBLLen) = 8
            'PBox.Print "Sequence used to infer unknown parent "
        End If
        If OutsideFlagX <> 1 Then
            'PBox.DrawMode = 9
            'PBox.Line (5, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (3 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(0, 220, 0), BF
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 5
            TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + 5) * AdjYD
            TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
            TreeBlocksL(TNum, TType, 3, TBLLen) = (3 + 5) * AdjYD - 2
            TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(0, 220, 0)
            TBLLen = TBLLen + 1
'            XX = UBound(TreeBlocksL, 2)
            TreeBlocksL(TNum, TType, 0, TBLLen) = 20
            TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + 5) * AdjYD + 1
            TreeBlocksL(TNum, TType, 3, TBLLen) = -1
            TreeBlocksL(TNum, TType, 4, TBLLen) = -1
            TreeBlocksL(TNum, TType, 2, TBLLen) = 9
        Else
            'PBox.DrawMode = 9
            'PBox.Line (5, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (3 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(ECr, QCg, ECb), BF
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 5
            TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + 5) * AdjYD
            TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
            TreeBlocksL(TNum, TType, 3, TBLLen) = (3 + 5) * AdjYD - 2
            TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(ECr, QCg, ECb)
            'PBox.DrawMode = 13
            'PBox.CurrentX = 20
            'PBox.CurrentY = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
            TBLLen = TBLLen + 1
            TreeBlocksL(TNum, TType, 0, TBLLen) = 20
            TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + 5) * AdjYD + 1
            TreeBlocksL(TNum, TType, 3, TBLLen) = -1
            TreeBlocksL(TNum, TType, 4, TBLLen) = -1
            TreeBlocksL(TNum, TType, 2, TBLLen) = 8
            'PBox.Print "Sequence used to infer unknown parent "
        End If
        For x = TBLLen + 1 To UBound(TreeBlocksL, 4)
            TreeBlocksL(TNum, TType, 0, x) = -1
            TreeBlocksL(TNum, TType, 1, x) = -1
            TreeBlocksL(TNum, TType, 3, x) = -1
            TreeBlocksL(TNum, TType, 4, x) = -1
            TreeBlocksL(TNum, TType, 2, x) = -1
        Next x
        
    
    Else
        TBLLen = TBLLen + 1
        'XX = UBound(TreeBlocksL, 2)
        TreeBlocksL(TNum, TType, 0, TBLLen) = 5
        TreeBlocksL(TNum, TType, 1, TBLLen) = 0
        TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
        TreeBlocksL(TNum, TType, 3, TBLLen) = 1 * AdjYD - 2
        TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 0, 0)
        If DebuggingFlag < 2 Then On Error Resume Next
        UB = -1
        UB = UBound(ExtraD, 1)
        On Error GoTo 0
        If UB > -1 Then
            If ExtraD(3) = 0 Then
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 0, 0)
            Else
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 0, 128)
            End If
        Else
            TBLLen = TBLLen = TBLLen + 1
            'Exit Sub
        End If
        'PBox.DrawMode = 13
        'PBox.CurrentX = 20
        'PBox.CurrentY = (Nextno + 4) * AdjYD + 1
        'PBox.Print "Potential daughter "
        TBLLen = TBLLen + 1
        TreeBlocksL(TNum, TType, 0, TBLLen) = 20
        TreeBlocksL(TNum, TType, 1, TBLLen) = 0 * AdjYD + 1
        If DebuggingFlag < 2 Then On Error Resume Next
        UB = -1
        UB = UBound(ExtraD, 1)
        On Error GoTo 0
        If UB > -1 Then
            If ExtraD(3) = 0 Then
                TreeBlocksL(TNum, TType, 2, TBLLen) = 0
            Else
                TreeBlocksL(TNum, TType, 2, TBLLen) = 11
            End If
        Else
            TBLLen = TBLLen - 1
        End If
        TreeBlocksL(TNum, TType, 3, TBLLen) = -1
        TreeBlocksL(TNum, TType, 4, TBLLen) = -1
        
        If UB > -1 Then
            If ExtraD(0) > 0 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, 1 * AdjYD)-(5 + AdjYD - 2, 2 * AdjYD - 2), RGB(255, 128, 128), BF
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = 1 * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = 2 * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 128, 128)
                If ExtraD(3) = 0 Then
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 128, 128)
                Else
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 128)
                End If
                'PBox.DrawMode = 9
                'PBox.CurrentX = 20
                'PBox.CurrentY = 1 * AdjYD + 1
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = 1 * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                If ExtraD(3) = 0 Then
                    If ExtraD(0) = 1 Then
                        'PBox.Print "Sequence with evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 1
                    Else
                        'PBox.Print "Sequences with evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 2
                    End If
                Else
                    If ExtraD(0) = 1 Then
                        'PBox.Print "Sequence with evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 12
                    Else
                        'PBox.Print "Sequences with evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 13
                    End If
                End If
                ExtraD(0) = 1
                
               
            End If
            If ExtraD(1) > 0 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0)) * AdjYD - 2), RGB(255, 128, 192), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0)) * AdjYD - 2
                
                If ExtraD(3) = 0 Then
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(255, 128, 192)
                Else
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 192)
                End If
                'PBox.DrawMode = 9
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0)) * AdjYD + 1
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                
                
                
                If ExtraD(3) = 0 Then
                    If ExtraD(1) = 1 Then
                        'PBox.Print "Sequence with partial evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 3
                    Else
                        'PBox.Print "Sequences with partial evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 4
                    End If
                Else
                    If ExtraD(1) = 1 Then
                        'PBox.Print "Sequence with partial evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 14
                    Else
                        'PBox.Print "Sequences with partial evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 15
                    End If
                End If
                ExtraD(1) = 1
            End If
            If ExtraD(2) > 0 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1)) * AdjYD - 2), RGB(255, 192, 192), BF
                
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0) + ExtraD(1)) * AdjYD - 2
                
                If ExtraD(3) = 0 Then
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(255, 192, 192)
                Else
                    TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 128, 192)
                End If
                'PBox.DrawMode = 9
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                If ExtraD(3) = 0 Then
                    If ExtraD(2) = 1 Then
                        'PBox.Print "Sequence with trace evidence of the same event "
                         TreeBlocksL(TNum, TType, 2, TBLLen) = 5
                    Else
                        'PBox.Print "Sequences with trace evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 6
                    End If
                Else
                    If ExtraD(2) = 1 Then
                        'PBox.Print "Sequence with trace evidence of the same event "
                         TreeBlocksL(TNum, TType, 2, TBLLen) = 16
                    Else
                        'PBox.Print "Sequences with trace evidence of the same event "
                        TreeBlocksL(TNum, TType, 2, TBLLen) = 17
                    End If
                End If
                ExtraD(2) = 1
            End If
            
            If ExtraD(3) > 0 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1)) * AdjYD - 2), RGB(220, 192, 192), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(196, 64, 0)
                'PBox.DrawMode = 9
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                
                TreeBlocksL(TNum, TType, 2, TBLLen) = 18
                
                ExtraD(3) = 1
            End If
            
            If ExtraD(20) > 0 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1)) * AdjYD - 2), RGB(220, 192, 192), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(220, 170, 230)
                'PBox.DrawMode = 9
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1)) * AdjYD + 1
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                
                TreeBlocksL(TNum, TType, 2, TBLLen) = 20
                
                ExtraD(20) = 1
            End If
        Else
            TBLLen = TBLLen - 1
        End If
        'PBox.DrawMode = 9
        'PBox.Line (5, (1 + ExtraD) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD) * AdjYD - 2), RGB(0, 0, 220), BF
        'PBox.DrawMode = 13
        'PBox.CurrentX = 20
        'PBox.CurrentY = (1 + ExtraD) * AdjYD + 1
        'PBox.Print "Potential parent "
        If UB > -1 Then
            If OutsideFlagX <> 2 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(64, 64, 220), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(64, 64, 220)
                'PBox.DrawMode = 13
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                TreeBlocksL(TNum, TType, 2, TBLLen) = 7
                'PBox.Print "Potential minor parent "
            Else
                'PBox.DrawMode = 9
                'PBox.Line (5, (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(ECr, ECg, QCb), BF
                
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(ECr, ECg, QCb)
                'PBox.DrawMode = 13
                'PBox.CurrentX = 20
                'PBox.CurrentY = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (1 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                TreeBlocksL(TNum, TType, 2, TBLLen) = 8
                'PBox.Print "Sequence used to infer unknown parent "
            End If
            If OutsideFlagX <> 1 Then
                'PBox.DrawMode = 9
                'PBox.Line (5, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (3 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(0, 220, 0), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (3 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(0, 220, 0)
                TBLLen = TBLLen + 1
'                XX = UBound(TreeBlocksL, 2)
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                TreeBlocksL(TNum, TType, 2, TBLLen) = 9
            Else
                'PBox.DrawMode = 9
                'PBox.Line (5, (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD)-(5 + AdjYD - 2, (3 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD - 2), RGB(ECr, QCg, ECb), BF
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 5
                TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD
                TreeBlocksL(TNum, TType, 2, TBLLen) = 5 + AdjYD - 2
                TreeBlocksL(TNum, TType, 3, TBLLen) = (3 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD - 2
                TreeBlocksL(TNum, TType, 4, TBLLen) = -RGB(ECr, QCg, ECb)
                'PBox.DrawMode = 13
                'PBox.CurrentX = 20
                'PBox.CurrentY = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2)) * AdjYD + 1
                TBLLen = TBLLen + 1
                TreeBlocksL(TNum, TType, 0, TBLLen) = 20
                TreeBlocksL(TNum, TType, 1, TBLLen) = (2 + ExtraD(0) + ExtraD(1) + ExtraD(2) + ExtraD(3) + ExtraD(20)) * AdjYD + 1
                TreeBlocksL(TNum, TType, 3, TBLLen) = -1
                TreeBlocksL(TNum, TType, 4, TBLLen) = -1
                TreeBlocksL(TNum, TType, 2, TBLLen) = 8
                'PBox.Print "Sequence used to infer unknown parent "
            End If
            For x = TBLLen + 1 To UBound(TreeBlocksL, 4)
                TreeBlocksL(TNum, TType, 0, x) = -1
                TreeBlocksL(TNum, TType, 1, x) = -1
                TreeBlocksL(TNum, TType, 3, x) = -1
                TreeBlocksL(TNum, TType, 4, x) = -1
                TreeBlocksL(TNum, TType, 2, x) = -1
            Next x
        End If
    End If
    'X = X
    'If TBS(TreeBlocksL(TNum, TType, 2, TBLLen)) = TBS(TreeBlocksL(TNum, TType, 2, TBLLen - 1)) Then
    '    TBLLen = TBLLen - 1
    'End If
End Sub
Public Sub GetWinPPfromDists(WinPP As Long, ISeqs() As Long, FMatSmall() As Single, SMatSmall() As Single)

If FMatSmall(0, ISeqs(1)) <= FMatSmall(0, ISeqs(2)) And FMatSmall(0, ISeqs(1)) <= FMatSmall(1, ISeqs(2)) Then
    If SMatSmall(0, ISeqs(2)) <= SMatSmall(1, ISeqs(2)) Then
        WinPP = 0
    Else
        WinPP = 1
    End If
    
ElseIf FMatSmall(0, ISeqs(2)) <= FMatSmall(0, ISeqs(1)) And FMatSmall(0, ISeqs(2)) <= FMatSmall(1, ISeqs(2)) Then
    If SMatSmall(0, ISeqs(1)) <= SMatSmall(1, ISeqs(2)) Then
        WinPP = 0
    Else
        WinPP = 2
    End If
ElseIf FMatSmall(1, ISeqs(2)) <= FMatSmall(0, ISeqs(1)) And FMatSmall(1, ISeqs(2)) <= FMatSmall(0, ISeqs(2)) Then

    If SMatSmall(0, ISeqs(1)) <= SMatSmall(0, ISeqs(2)) Then
        WinPP = 1
    Else
        WinPP = 2
    End If
    
End If

End Sub

Public Sub RedrawPlotAA(ClearScreenFlag As Long)
    'XX = NextNo
    If RelX <= 0 And RelY <= 0 And ManFlag = -1 And RunFlag = 0 Then
            Exit Sub
    End If
    If DontRedrawPlotsFlag = 1 Then
        Exit Sub
    End If
    Dim UB As Long, tSeq1 As Long, tSeq2 As Long, tSeq3 As Long, GoOn As Long, A As Long, Y As Long, LastPos As Long, FirstPos As Long, Z As Long, AA As Long, VOut As String, UBX As Long, UBY As Long, x As Long, YScaleFactor As Single, YPos As Long, Dummy As Long
    
    Dim PolyPoints() As POINTAPI, PosCount As Long, PPoints() As Single
    Dim Pen2 As Long, SP As Long, EP As Long
    Dim PColIn As Long, HFactor As Double, WFactor As Single
    Dim OldFont As Long, oldpen As Long, PEN As Long, LOffset As Long, TOffset As Long, MhDC As Long, EMFCls As Long
    Dim PntAPI As POINTAPI
    Dim LPn As LOGPEN
    Dim red As Long, Green2 As Long, blue As Long, PA As POINTAPI
    'LPn.lopnColor = RGB(255, 0, 0)
    'LPn.lopnWidth.XPos = 5
    'LPn.lopnWidth.Y = 5
    'LPn.lopnStyle = 0
    Form1.Picture7.DrawStyle = 0
    If CurrentCheck = 40 Or CurrentCheck = 11 Then
        Exit Sub
    End If
    PA.x = 0.75
    PA.Y = 0.75
    Dim rct As RECT
    Dim LoFnt As Long
                
    Dim AxLen As Long, AxStr As String
    
    If TypeSeqNumber > NextNo Then TypeSeqNumber = 0
    AxLen = GYAxHi(1)
    If AxLen = 0 Then Exit Sub
    Dim DF As Byte
    
    If DebuggingFlag < 3 Then On Error Resume Next
    UBX = 0
    UBY = 0
    UBX = UBound(GVarPos, 2)
    UBY = UBound(GVarPos, 1)
    
    On Error GoTo 0
    
    If UBX > 0 Then
        'If XX = XX Then
            DF = 1
        'Else
        '    DF = 0
        'End If
    Else
        DF = 0
    End If
    Dim t0 As Long
    ''@'@'@
    ReDim XDiffPosCA(AxLen + 1000)
    
    Call MakeCurveArray(P7XP)
    
    'XX = GVarPos(0, 25)
    
    'Exit Sub
    If P7XP > 0 Then
        If UBX > 0 Then
            
            t0 = XDiffPosCA(0)
            '@'@'@
            For x = 0 To UBX
                    
                    XDiffPosCA(x) = CLng(Decompress(GVarPos(0, x)) * CurveArray(Decompress(GVarPos(0, x))))
                
            Next x
            XDiffPosCA(0) = t0
        End If
    Else
        Dim UBDx As Long
        'XX = UBound(Decompress, 1)
        UBDx = UBound(Decompress, 1)
        If UBX > 0 Then
            t0 = XDiffPosCA(0)
            If UBX > UBound(Decompress, 1) Then UBX = UBound(Decompress, 1)
            For x = 0 To UBX
                If GVarPos(0, x) <= UBDx Then
                    XDiffPosCA(x) = Decompress(GVarPos(0, x))
                End If
            Next x
            
            XDiffPosCA(0) = t0
        End If
    End If
    LenXoverSeq = UBX
   ' Form1.SSPanel8.Visible = True
    'Draw Axes and variable site positions (or whatever else is in xdiffpos)
    
    If ClearScreenFlag = 1 Then
        If GYAxHi(1) <> Decompress(Len(StrainSeq(0))) Then
            
            If GDPCFlag = 0 Then
                Call DoAxes(0, 1, GYAxHi(1), -1, GPrintMin(1), GPrintMin(0), 0, GLegend)
            ElseIf GDPCFlag = 1 Then
                Call DoAxes(0, 1, GYAxHi(1), -1, GPrintMin(1), GPrintMin(0), 0, GLegend)
            End If
            XFactor = ((Form1.Picture7.Width - 40) / GYAxHi(1))
        Else
            If GDPCFlag = 0 Then
                Call DoAxes(1, 0, Decompress(Len(StrainSeq(0))), -1, GPrintMin(1), GPrintMin(0), 0, GLegend)
            ElseIf GDPCFlag = 1 Then
                Call DoAxes(0, 0, Decompress(Len(StrainSeq(0))), -1, GPrintMin(1), GPrintMin(0), 0, GLegend)
            End If
            XFactor = ((Form1.Picture7.Width - 40) / Decompress(Len(StrainSeq(0))))
        End If
    Else
        'XX = Len(StrainSeq(0))
         XFactor = ((Form1.Picture7.Width - 40) / GYAxHi(1))
    End If
    
    YScaleFactor = 0.85
    PicHeight = Form1.Picture7.Height * YScaleFactor
    HFactor = PicHeight
   
    LOffset = 30
    TOffset = 10

    'xFactor = ((Form1.Picture7.Width - 40) / Len(StrainSeq(0)))
    WFactor = XFactor
    
    
    
    
    
    Dim LongTXT As Long
    LongTXT = 0
    Dim LPX As Long, TOX As String
    LPX = -15
    'HLFlag
    
    'stand-in for highlight (i.e. add the breakpoint markers and missing data stuff)
    MhDC = Form1.Picture7.hdc
    Dim GB0 As Long, GB2 As Long
    
    If ShowSeqFlag = 1 Or ShowSeqFlag = 2 Then
        Dim BEX As Long, ENX As Long
        
        If (RelX > 0 Or RelY > 0) And PosIndicatorP11(0) <> PosIndicatorP11(1) Then
            
            GB0 = CLng(PosIndicatorP11(0) * Len(StrainSeq(0)) + 1)
            GB2 = CLng(PosIndicatorP11(1) * Len(StrainSeq(0)) + 1)
            If GB2 > UBound(CurveArray, 1) Then GB2 = UBound(CurveArray, 1)
            If gb1 < 0 Then gb1 = 0
            'If ShowSeqFlag = 1 Then
             Form1.Picture7.ForeColor = FourQuaterColour
             Form1.Picture7.FillColor = FourQuaterColour
             Form1.Picture1.DrawMode = 12
               Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
            'Else
            
            'End If
        End If
    End If
    
    If GBlockNum > 0 Then
        ColHL = RGB(0, 255, 255)
        
        
        For x = 0 To GBlockNum
            
            If GBlock(4, x) = RGB(255, 190, 190) Or GBlock(4, x) = RGB(255, 210, 210) Then
                '@
                Form1.Picture7.ForeColor = ColHL
                Form1.Picture7.FillColor = ColHL
                Form1.Picture7.DrawMode = 12
                YPos = TOffset
            ElseIf GBlock(4, x) = RGB(197, 197, 255) Then
                YPos = TOffset
                Form1.Picture7.DrawMode = 13
                Form1.Picture7.ForeColor = GBlock(4, x)
                Form1.Picture7.FillColor = GBlock(4, x)
            Else
                YPos = TOffset + 10
                Form1.Picture7.DrawMode = 13
                Form1.Picture7.ForeColor = GBlock(4, x)
                Form1.Picture7.FillColor = GBlock(4, x)
            End If
            Form1.Picture7.FillStyle = 0
            On Error Resume Next
            UB = -1
            UB = UBound(Decompress, 1)
            If UB < Len(StrainSeq(0)) Then
                Exit Sub
            End If
            On Error GoTo 0
            If GBlock(1, x) = 0 Then 'ie it is a block on the plot
                If GBlock(0, x) > UB Then Exit Sub
                GB0 = Decompress(GBlock(0, x))
                GB2 = Decompress(GBlock(2, x))
                If Form1.Picture7.ForeColor = ColHL Then
                    
                    If GBlock(0, x) = 1 Then
                        
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                        Dummy = MoveToEx(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15, PntAPI)
                        
                        Dummy = LineTo(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                       
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)

                    ElseIf GBlock(2, x) = Len(StrainSeq(0)) Then
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                        Dummy = MoveToEx(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, PntAPI)
                        Dummy = LineTo(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos)
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB0) * CurveArray(GB2), YPos)

                    Else
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                        Dummy = MoveToEx(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15, PntAPI)
                        Dummy = LineTo(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                        Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                        Dummy = MoveToEx(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, PntAPI)
                        Dummy = LineTo(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos)
                    
                    End If
                Else
                    'missing data
                    Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                End If
                
            ElseIf GBlock(1, x) = 1 Then 'ie it is a block on the plot
                
            ElseIf GBlock(1, x) = 2 Then 'ie it is a block on the plot
                
            ElseIf GBlock(1, x) = 3 Then 'ie it is a query sequence reference
                
            End If
            
            Form1.Picture7.DrawMode = 13
        Next x
        
         
    End If
    
    
    
    
   ' Form1.Picture7.Refresh
    Dim tGCritVal() As Double
    ReDim tGCritVal(10)
    On Error Resume Next
    UB = -1
    UB = UBound(GCritval, 1)
    On Error GoTo 0
    If (GExtraTNum > -1 Or GBlockNum > 0) And UB > -1 Then
        For x = 0 To UBound(GCritval, 1)
            If GCritval(x) <> 0 Then
                
                
                tGCritVal(x) = GCritval(x)
                
                
            End If
        Next x
        
    End If
    Form1.Picture7.DrawMode = 13
    Form1.Picture7.ForeColor = 0
    'Form1.Picture7.Refresh
    For x = 0 To 10
        If tGCritVal(x) <> 0 Then
        'Draw critical val lines
            
            If x = 0 Then
                Form1.Picture7.DrawStyle = 2
            ElseIf x = 1 Then
                Form1.Picture7.DrawStyle = 2
            ElseIf x = 2 Then
                Form1.Picture7.DrawStyle = 2
            ElseIf x = 3 Then
                Form1.Picture7.DrawStyle = 2
            ElseIf x = 4 Then
                Form1.Picture7.DrawStyle = 2
            ElseIf x = 5 Then
                Form1.Picture7.DrawStyle = 2
            End If
            Form1.Picture7.ForeColor = RGB(x + 1, x + 1, x + 1)
            'If COff <= GCritval(X) Then
                If tGCritVal(x) >= GPrintMin(0) And tGCritVal(x) <= GPrintMin(1) Then
                    MoveToEx MhDC, LOffset - 5, PicHeight - (15 + ((tGCritVal(x) - GPrintMin(0)) / (GPrintMin(1) - GPrintMin(0))) * (PicHeight - 35)), PntAPI
                    LineTo MhDC, LOffset + AxLen * WFactor * CurveArray(AxLen), PicHeight - (15 + ((tGCritVal(x) - GPrintMin(0)) / (GPrintMin(1) - GPrintMin(0))) * (PicHeight - 35))
                End If
            'End If
        End If
    Next x
    Form1.Picture7.DrawStyle = 0
    Form1.Picture7.ForeColor = 0
        
        
        
    'from here onwards everything is done with Imagedata array
    Dim ImageData() As Byte, bm As BITMAP
    GetObject Form1.Picture7.Image, Len(bm), bm 'grabs image from picture7
    '@'@'@
    ReDim ImageData(0 To (bm.bmBitsPixel \ 8) - 1, 0 To bm.bmWidth - 1, 0 To bm.bmHeight - 1)
    GetBitmapBits Form1.Picture7.Image, bm.bmWidthBytes * bm.bmHeight, ImageData(0, 0, 0) 'add the picture7 graphic to imagedata
    If ClearScreenFlag = 1 Then
        If GDPCFlag = 0 And ClearScreenFlag = 1 Then 'Draw the variablesite positions
            Call DrawDiffsVBAA(ImageData, LenXoverSeq, XFactor, XDiffPosCA())
            x = x
        ElseIf GDPCFlag = 1 And ClearScreenFlag = 1 Then
            Call DrawDiffsVBAA2(ImageData, LenXoverSeq, XFactor, XDiffPosC())
            x = x
        End If
    End If
    
    
    If ORFFlag = 1 Then
        
    
        Call DrawORFsP20
        x = x
        'Form1.Picture20.Refresh
    End If
    
    If GPrintType = 0 Then 'standard line plot
        Dim OriMod1 As Long, OriMod2 As Long, DiX As Single, DixA As Single, DixB As Single
        If GPrintMin(0) > GPrintMin(1) Then
            OriMod1 = 0
            OriMod2 = -1
            DixA = GPrintMin(0)
            DixB = GPrintMin(1)
        Else
            OriMod1 = 1
            OriMod2 = 1
            DixA = GPrintMin(1)
            DixB = GPrintMin(0)
        End If
'        SS = Abs(GetTickCount)
'
        
        
        For AA = 1 To 1
        Dim DonePrintNum() As Byte
        ReDim DonePrintNum(GPrintNum)
        
        Dim PC2() As Long
        ReDim PC2(GPrintNum)
        
        
        If ManFlag = -1 And (OVS = 5 Or CurrentCheck = 5 Or (CurrentCheck = -1 And XoverList(RelX, RelY).ProgramFlag = 5)) Then 'have to do something different for siscan
            For Z = 0 To GPrintNum
                If DebuggingFlag < 2 Then On Error Resume Next
                UBX = -1
                UBX = UBound(PltCol, 1)
                
                On Error GoTo 0
                'XX = PltCol2(2)
                If UBX > 0 Then
                    If Z < 15 Then
                        PC2(Z) = PltCol(Z + 1)
                    ElseIf Z < 23 Then
                        PC2(Z) = PltCol2(Z - 14)
                    ElseIf Z = 4 Or Z = 9 Then
                        PC2(Z) = PltCol(Z) 'GPrintCol(4) 'mPurple 'green'
                    ElseIf Z = 17 Or Z = 21 Then
                        PC2(Z) = PltCol2(Z - 15)
                    ElseIf Z = 1 Or Z = 7 Or Z = 15 Then
                        PC2(Z) = PltCol(Z) 'GPrintCol(1) ' green 'mPurple
                    ElseIf Z = 18 Then
                        PC2(Z) = PltCol2(Z - 15) 'GPrintCol(1) ' green 'mPurple
                    ElseIf Z = 2 Or Z = 8 Then
                        PC2(Z) = PltCol(Z) 'GPrintCol(2) 'mYellow
                    ElseIf Z = 16 Or Z = 19 Then
                        PC2(Z) = PltCol2(Z - 15)
                    ElseIf Z = 24 Then
                        PC2(Z) = RGB(64, 64, 64) 'mYellow
                    Else
                        PC2(Z) = RGB(240, 240, 240) 'GPrintCol(Z)
                    End If
                Else
                    PC2(Z) = 0
                End If
            Next Z
        Else
            On Error Resume Next
            UB = -1
            UB = UBound(GPrintCol, 1)
            On Error GoTo 0
            If UB >= GPrintNum Then
                For Z = 0 To GPrintNum
                    PC2(Z) = GPrintCol(Z)
                Next Z
            End If
        End If
        'XX = GPrint(2, 3)
        
        For Z = 0 To GPrintNum
            'If Z = 0 Then Exit For
            If DonePrintNum(Z) = 0 Then
                Form1.Picture7.ForeColor = Abs(PC2(Z))
                'Test if its a line
                FirstPos = 0: LastPos = GPrintLen
                
                For Y = 0 To GPrintLen
                    If GPrintPos(Z, Y) > 0 Then
                        FirstPos = Y
                        Exit For
                    End If
                Next Y
                
                For Y = GPrintLen To 0 Step -1
                    If GPrintPos(Z, Y) > 0 Then
                        LastPos = Y
                        Exit For
                    End If
                Next Y
                
              
                If (GPrintPos(Z, FirstPos) <> GPrintPos(Z, LastPos) And (GPrintPos(Z, LastPos) - GPrintPos(Z, FirstPos)) > 1) Or GPrintCol(Z) = 0 Then 'i.e. its a normal plot
                
                    Dim TransparencyFlag As Byte
                    TransparencyFlag = 0
                    If PC2(Z) < 0 Then
                        TransparencyFlag = 1
                    End If
                    
                    'If Z = 9 Then
                    '    LPn.lopnColor = RGB(255, 0, 0)
                    'End If
                    Dim LineList() As Single, GPP As Long
                    ReDim LineList(1, UBound(GPrintPos, 2) + 10)
                    Dim PC As Long
                    Dim ExtraZ As Long, PHAdj As Long, AmB As Single
                    PC = 0
                    For ExtraZ = Z To GPrintNum
                        Y = 1
                       If DonePrintNum(ExtraZ) = 0 And PC2(ExtraZ) = PC2(Z) Then
                            DonePrintNum(ExtraZ) = 1
                            
                            If ExtraZ <> Z Then
                                ReDim Preserve LineList(1, UBound(LineList, 2) + UBound(GPrintPos, 2) + 10)
                            End If
                           PC = PC + 1
                           '
                           Do
                               
                               If GPrintPos(ExtraZ, Y) > 0 Then
                                   GPP = Decompress(GPrintPos(ExtraZ, Y))
                                   'Dummy = MoveToEx(MhDC, LOffset + Decompress(GPrintPos(ExtraZ, Y)) * WFactor, PicHeight - (15 + ((OriMod2 * GPrint(ExtraZ, Y) - dixb) / (DiXA - dixb)) * (PicHeight - 35)), PntAPI)
                                   LineList(0, PC) = LOffset + GPP * WFactor * CurveArray(GPP)
                                   LineList(1, PC) = PicHeight - (15 + ((OriMod2 * GPrint(ExtraZ, Y) - DixB) / (DixA - DixB)) * (PicHeight - 35))
                                   Y = Y - 1
                                   PC = PC - 1
                                   Exit Do
                                   
                               End If
                               Y = Y + 1
                               PC = PC + 1
                               If Y > UBound(GPrintPos, 2) Then
                                   Y = Y - 1
                                   PC = PC - 1
                                   Exit Do
                               End If
                           Loop
                           
                           
                           
                           If Y = 0 Then
                                Y = 1
                                PC = PC + 1
                            End If
                           PHAdj = PicHeight - 35
                           AmB = DixA - DixB
                           Dim UBDC As Long
                           UBDC = UBound(Decompress, 1)
                           
                            'XX = GPrint(2, 3)
                            If x = x Then
                                '@
                                PC = MakeFastLineList(PC, ExtraZ, PHAdj, DixB, AmB, LOffset, GPrintLen, PicHeight, WFactor, Y, OriMod1, UBound(Decompress, 1), OriMod2, UBound(LineList, 1), UBound(GPrintPos, 1), UBound(GPrint, 1), CurveArray(0), GPrintMin(0), LineList(0, 0), GPrintPos(0, 0), GPrint(0, 0), Decompress(0))
                            
                                x = x
                            Else
                            
                                A = Y
                                For PosCount = Y To GPrintLen
                                    GPP = GPrintPos(ExtraZ, A)
                                    If GPP > 0 And GPP <= UBDC Then
                                         'And ((OriMod1 = 1 And GPrint(ExtraZ, PosCount) >= GPrintMin(0) And (GPrint(ExtraZ, PosCount) <= GPrintMin(1) * 1.1)) Or (OriMod1 = 0 And GPrint(ExtraZ, PosCount) <= GPrintMin(0) And GPrint(ExtraZ, PosCount) >= GPrintMin(1))) Then
                                           
'                                           If (OriMod1 = 1) Then
'                                             If GPrint(ExtraZ, A) < GPrintMin(0) Then
'                                                   GPrint(ExtraZ, A) = GPrintMin(0)
'                                              ElseIf GPrint(ExtraZ, A) > GPrintMin(1) Then
'                                                   GPrint(ExtraZ, A) = GPrintMin(1)
'                                              End If
'                                           ElseIf OriMod1 = 0 Then
'                                             If (OriMod2 * GPrint(ExtraZ, A)) > (GPrintMin(0)) Then
'                                                 GPrint(ExtraZ, A) = (GPrintMin(0))
'                                             ElseIf (OriMod2 * GPrint(ExtraZ, A)) < (GPrintMin(1)) Then
'                                                 GPrint(ExtraZ, A) = (GPrintMin(1))
'                                             End If
'
'                                           End If
                                           
                                           
                                            GPP = Decompress(GPP)
                                            'Dummy = LineTo(MhDC, LOffset + Decompress(GPrintPos(ExtraZ, PosCount)) * WFactor, PicHeight - (15 + ((OriMod2 * GPrint(ExtraZ, PosCount) - dixb) / (DiXA - dixb)) * (PicHeight - 35)))
                                            LineList(0, PC) = LOffset + GPP * WFactor * CurveArray(GPP)
                                            LineList(1, PC) = PicHeight - (15 + ((OriMod2 * GPrint(ExtraZ, A) - DixB) / AmB) * PHAdj)
                                            
                                            PC = PC + 1
                                           
                                           
                                    End If
                                    A = A + 1
                                Next PosCount
                            End If
                            
                        End If
                    Next ExtraZ
    '                Dim MaxPos As Long
    '                MaxPos = -1
    '                For PosCount = 1 To PC - 2
    '                    If LineList(1, PosCount) > MaxPos Then
    '                        MaxPos = X
    '                    Else
    '                        LineList(1, PosCount) = MaxPos
    '                    End If
    '
    '                Next PosCount
                    PC = 0
                    Dim r As Byte, g As Byte, b As Byte
                    '@
                    Call DoLineObject(ImageData(), Form1.Picture7, LineList(), Form1.Picture7.ForeColor, 1, CByte(TransparencyFlag), 1)
                    x = x
                Else ' i.e. its a polygon that needs to be filled
               
                    
                                  
                    
                    Form1.Picture7.ForeColor = Abs(GPrintCol(Z))
                    If Abs(GPrintCol(Z)) = RGB(128, 128, 128) Then
                        Form1.Picture7.ForeColor = RGB(130, 130, 130)
                        Form1.Picture7.FillColor = RGB(150, 150, 150) 'HalfColour
                    ElseIf Abs(GPrintCol(Z)) = RGB(198, 198, 198) Then
                        Form1.Picture7.ForeColor = RGB(200, 200, 200)
                        Form1.Picture7.FillColor = RGB(255, 255, 255)
                    End If
                    Form1.Picture7.FillStyle = 0
                    
                    
                   MhDC = Form1.Picture7.hdc
                    
                   
                    
                    'ReDim PolyPoints(GPrintLen)
                    ReDim PPoints(1, GPrintLen + 1)
                   
                    
                    'Exit Sub
                    Dim GPPm As Long
                    
                    
                    PHAdj = PicHeight - 35
                    AmB = DixA - DixB
                    SS = Abs(GetTickCount)
                    'For ZZ = 1 To 10
                         A = -1
                         'Dim GPPW As Long, GPP2 As Long
                         XX = UBound(CurveArray, 1)
                    For PosCount = 1 To GPrintLen
                            If GPrintPos(Z, PosCount) > 0 Then
                                GoOn = 0
                                GPP = Decompress(GPrintPos(Z, PosCount))
                                If PosCount > 0 Then
                                    GPPm = Decompress(GPrintPos(Z, PosCount - 1))
                                    If (CLng(GPP * WFactor * CurveArray(GPP)) <> CLng(GPPm * WFactor * CurveArray(GPPm))) Then
                                        GoOn = 1
                                    ElseIf (CLng(OriMod2 * (OriMod1 - ((GPrint(Z, PosCount) - DixB) / AmB)) * HFactor) <> CLng(OriMod2 * (OriMod1 - ((GPrint(Z, PosCount - 1) - DixB) / AmB)) * HFactor)) Then
                                        GoOn = 1
                                    End If
                                Else
                                    GoOn = 1
                                End If
                                If GoOn = 1 Then
                                    A = A + 1
                                    'PolyPoints(A).X = LOffset + Decompress(GPrintPos(Z, PosCount)) * WFactor
                                    'PolyPoints(A).Y = PicHeight - (15 + ((GPrint(Z, PosCount) - dixb) / (DiXA - dixb)) * (PicHeight - 35))
                                    PPoints(0, A) = LOffset + GPP * WFactor * CurveArray(GPP)
                                    '@
                                    PPoints(1, A) = PicHeight - (15 + ((GPrint(Z, PosCount) - DixB) / AmB) * PHAdj)
                                End If
                                x = x
                            End If
                    Next PosCount
                   ' Next ZZ
                    EE = Abs(GetTickCount)
                    TT = EE - SS
                    PPoints(0, A + 1) = PPoints(0, 0)
                    PPoints(1, A + 1) = PPoints(1, 0)
                    PPoints(0, A + 2) = PPoints(0, 1)
                    PPoints(1, A + 2) = PPoints(1, 1)
                    ReDim Preserve PPoints(1, A + 2)
                    'PolyPoints(0).X = 100
                    'PolyPoints(0).Y = 100
                    'PolyPoints(1).X = 200
                    'PolyPoints(1).Y = 100
                    'PolyPoints(2).X = 200
                    'PolyPoints(2).X = 200
                    'PolyPoints(3).X = 100
                    'PolyPoints(3).Y = 100
                   'ReDim Preserve PolyPoints(A)
                   If A < 16000 And A > 0 Then ' for some reason ppt crashes if you give it a polygon with >16000 points
                        'Polygon MhDC, PolyPoints(0), A
                        Call DoPolyPointObject(ImageData(), Form1.Picture7, PPoints(), Form1.Picture7.ForeColor, Form1.Picture7.FillColor)
                   Else
                        'ReDim PolyPoints(GPrintLen - 1)
                        ReDim PPoints(1, GPrintLen + 1)
                        Dim SkipFact As Double
                        SkipFact = CLng(A / 16000) + 1
                        
                         A = -1
                         
                         For PosCount = 0 To GPrintLen Step SkipFact
                                 If GPrintPos(Z, PosCount) > 0 Then
                                     GoOn = 0
                                     GPP = Decompress(GPrintPos(Z, PosCount))
                                     If PosCount > 0 Then
                                         GPPm = Decompress(GPrintPos(Z, PosCount - 1))
                                         If (CLng(LOffset + GPP * WFactor * CurveArray(GPP)) <> CLng(LOffset + GPPm * WFactor * CurveArray(GPPm))) Or (CLng(TOffset + OriMod2 * (OriMod1 - ((GPrint(Z, PosCount) - DixB) / (DixA - DixB))) * HFactor) <> CLng(TOffset + OriMod2 * (OriMod1 - ((GPrint(Z, PosCount - 1) - DixB) / (DixA - DixB))) * HFactor)) Then
                                         GoOn = 1
                                         End If
                                     Else
                                         GoOn = 1
                                     End If
                                     If GoOn = 1 Then
                                         A = A + 1
                                         PPoints(0, A) = LOffset + GPP * WFactor * CurveArray(GPP)
                                         PPoints(1, A) = PicHeight - (15 + ((GPrint(Z, PosCount) - DixB) / (DixA - DixB)) * (PicHeight - 35))
                                         'PolyPoints(A).X = LOffset + Decompress(GPrintPos(Z, PosCount)) * WFactor
                                         'PolyPoints(A).Y = PicHeight - (15 + ((GPrint(Z, PosCount) - dixb) / (DiXA - dixb)) * (PicHeight - 35))
                                         'PicHeight - (15 + ((GPrint(Z, PosCount) - dixb) / (DiXA - dixb)) * (PicHeight - 35))
                                     End If
                                     x = x
                                 End If
                         Next PosCount
                         PPoints(0, A + 1) = PPoints(0, 0)
                         PPoints(1, A + 1) = PPoints(1, 0)
                         PPoints(0, A + 2) = PPoints(0, 1)
                         PPoints(1, A + 2) = PPoints(1, 1)
                         ReDim Preserve PPoints(1, A + 2)
                         'PolyPoints(0).X = 100
                         'PolyPoints(0).Y = 100
                         'PolyPoints(1).X = 200
                         'PolyPoints(1).Y = 100
                         'PolyPoints(2).X = 200
                         'PolyPoints(2).X = 200
                         'PolyPoints(3).X = 100
                         'PolyPoints(3).Y = 100
                        'ReDim Preserve PolyPoints(A)
                       ' Polygon MhDC, PolyPoints(0), A
                        Call DoPolyPointObject(ImageData(), Form1.Picture7, PPoints(), Form1.Picture7.ForeColor, Form1.Picture7.FillColor)
                    End If
                
                End If
            End If
        Next Z
        Next AA
        x = x
'        EE = Abs(GetTickCount)
'        TT = EE - SS '0.811
            
            '14.352 for 10
            '4.758 with MakeImageDataBO
            '2.043 with modfp
            'for 40
            '5.320, 5.335 with new modfp
            'for 80
            '10.623
            '6.381
            'for 160
            '4.664 with only looking at fakepicture entries >0
            x = x
            
    ElseIf GPrintType = 1 Then 'blocks like in geneconv plot
'        SS = Abs(GetTickCount)
        'For AA = 1 To 1
        For Z = 0 To GPrintNum
            
            Dim UBPP As Long, TSVal As Single, XV1 As Single, XV2 As Single, YV1 As Single, YV2 As Single, Hold As Single, Hold2 As Single
            UBPP = UBound(GPrintPos, 3)
            Form1.Picture7.ForeColor = Abs(GPrintCol(Z))
            ReDim LineList(3, 1, GPrintLen)
            TSVal = (GPrintMin(0) / GPrintMin(1))
            Hold = PicHeight - 35
            Hold2 = PicHeight - (15 + (TSVal) * Hold)
            
            
            Dim GPP1 As Long
            For PosCount = 0 To GPrintLen
                If PosCount <= UBPP Then
                    If UBound(Decompress, 1) < GPrintPos(Z, 1, PosCount) Then GPrintPos(Z, 1, PosCount) = Recompress(GPrintPos(Z, 1, PosCount))
                    If PosCount > 0 And Decompress(GPrintPos(Z, 1, PosCount)) = 0 Then Exit For
                    GPP = Decompress(GPrintPos(Z, 0, PosCount))
                    GPP1 = Decompress(GPrintPos(Z, 1, PosCount))
                    XV1 = LOffset + GPP * WFactor * CurveArray(GPP)
                    XV2 = LOffset + GPP1 * WFactor * CurveArray(GPP1)
                    YV1 = PicHeight - (15 + ((GPrint(Z, PosCount) / GPrintMin(1))) * Hold)
                    YV2 = Hold2
                    LineList(0, 0, PosCount) = XV1
                    LineList(0, 1, PosCount) = YV1
                    'Dummy = MoveToEx(MhDC, LOffset + Decompress(GPrintPos(Z, 0, PosCount)) * WFactor, PicHeight - (15 + ((GPrint(Z, PosCount) / GPrintMin(1))) * (PicHeight - 35)), PntAPI)
                    
                    LineList(1, 0, PosCount) = XV2
                    LineList(1, 1, PosCount) = YV1
                    'Dummy = LineTo(MhDC, LOffset + Decompress(GPrintPos(Z, 1, PosCount)) * WFactor, PicHeight - (15 + ((GPrint(Z, PosCount) / GPrintMin(1))) * (PicHeight - 35)))
                    
                    LineList(2, 0, PosCount) = XV2
                    LineList(2, 1, PosCount) = YV2
                   ' Dummy = LineTo(MhDC, LOffset + Decompress(GPrintPos(Z, 1, PosCount)) * WFactor, PicHeight - (15 + ((GPrintMin(0) / GPrintMin(1))) * (PicHeight - 35)))
                    
                    LineList(3, 0, PosCount) = XV1
                    LineList(3, 1, PosCount) = YV2
                    'Dummy = LineTo(MhDC, LOffset + Decompress(GPrintPos(Z, 0, PosCount)) * WFactor, PicHeight - (15 + ((GPrintMin(0) / GPrintMin(1))) * (PicHeight - 35)))
                    
                    
                    'Dummy = LineTo(MhDC, LOffset + Decompress(GPrintPos(Z, 0, PosCount)) * WFactor, PicHeight - (15 + ((GPrint(Z, PosCount) / GPrintMin(1))) * (PicHeight - 35)))
                'PicHeight - (15 + ((GPrint(Z, PosCount) - dixb) / (DiXA - dixb)) * (PicHeight - 35))
                Else
                    Exit For
                End If
            Next PosCount
            'If PosCount > 1 Then
                Call DoBlockObject(ImageData(), Form1.Picture7, LineList(), Form1.Picture7.ForeColor, 1, 1)
            'Else
            '    X = X
            'End If
            x = x
            'End If
        Next Z
        x = x
        'Next AA
'        EE = Abs(GetTickCount)
'        TT = EE - SS '14.103, 5.350
'        X = X
        'for 80 times
        '3.947
        '3.853
        '7.690
        
        'for 40 times
        '4.712
        '3.479
        '2.527 with addfpx
        '1.997
        'for 20 times
        '5.193
        '5.085, 5.101, 5.132 with better caching in main loop
        '2.418 with mdfp
        'for 10 times
        '10.281
        '7.956 with optimization main loop
        '7.660 - not bothering with bottom line
        '2.589
    End If
    
    
    
    
    
    
   'Graphs are drawn - now copy them from imagedata back to picture 7
   '@
   SetBitmapBits Form1.Picture7.Image, bm.bmWidthBytes * bm.bmHeight, ImageData(0, 0, 0)
    
    
    
    'this is where the matchbar is done
    '
    If GLVS > 0 And AxLen = Decompress(Len(StrainSeq(0))) Then
        Dim Pict As Long
        Form1.Picture7.ForeColor = RGB(170, 170, 170)
        Form1.Picture7.DrawWidth = 3
        XFactor = ((Form1.Picture7.Width - 40) / Decompress(Len(StrainSeq(0))))
        Pict = Form1.Picture7.hdc
        MoveToEx Pict, 30 + Decompress(VXPos(1)) * XFactor * CurveArray(Decompress(VXPos(1))), 6, PntAPI
        'LineTo Pict, 30 + Decompress(VXPos(1)) * XFactor * CurveArray(Decompress(VXPos(1))), 8
        Dim UBCA As Long
        'ubca = UBound(CurveArray)
        For x = 2 To GLVS
'            If X = 1300 Then
'                X = X
'            End If
            'If Decompress(VXPos(X)) > ubca Then Exit Sub
            If (GVSS(x) + GVSS(x - 1)) / 2 > 0.55 Then
                Form1.Picture7.ForeColor = HeatMap(0, 1020 - CLng((((GVSS(x) + GVSS(x - 1)) / 2 - 0.55) / 0.45) * 1020))
            Else
                Form1.Picture7.ForeColor = HeatMap(0, 1020)
            End If
            Pict = Form1.Picture7.hdc
            'XX = UBound(CurveArray)
            LineTo Pict, 30 + Decompress(VXPos(x)) * XFactor * CurveArray(Decompress(VXPos(x))), 6
            'LineTo Pict, 30 + Decompress(VXPos(X)) * XFactor * CurveArray(Decompress(VXPos(X))), 8
            'Form1.Picture7.Refresh
            x = x
            'LineTo pict, (30 + VXPos(X) * XFactor), (PicHeight - (15 + gvss(X) * (PicHeight - 35)))
        Next x
        Form1.Picture7.DrawWidth = 1
    End If
    Form1.Picture7.DrawWidth = 1
    
    
    'XX = Form1.Picture7.FillStyle
    Form1.Picture7.FillStyle = 1
    Dim OFS As Single
    OFS = Form1.Picture7.FontSize
    If ManFlag = -1 And ClearScreenFlag = 1 Then
        Dim TraceSub() As Long
        
        If CurrentCheck > -1 Then
            If CurrentCheck = 10 Or CurrentCheck = 16 Or CurrentCheck = 13 Then 'chimaera, 3seq and phylpro
                Call WriteNames2(WN1, WN2, WN3, Abs(GPrintCol(0)), Abs(GPrintCol(1)), Abs(GPrintCol(2)))
            ElseIf CurrentCheck = 5 Then
                
                ReDim TraceSub(NextNo)
                For x = 0 To NextNo
                    TraceSub(x) = x
                Next x
                Call OrderSeqs(tSeq1, tSeq2, tSeq3, Seq1, Seq2, Seq3, TraceSub())
                Call WriteNames(WN1, WN2, WN3, Yellow, Green, Purple)
            ElseIf CurrentCheck = 41 Then
                Call WriteNamesViSRD(WN1, WN2, WN3)
            ElseIf CurrentCheck = 55 Or CurrentCheck = 6 Or CurrentCheck = 9 Or CurrentCheck = 12 Or CurrentCheck = 15 Or CurrentCheck = 17 Then
            x = x
            Else
                If UBound(GPrintCol, 1) >= 2 Then
                    Call WriteNames(WN1, WN2, WN3, Abs(GPrintCol(0)), Abs(GPrintCol(1)), Abs(GPrintCol(2)))
                Else
                    Call WriteNames(WN1, WN2, WN3, Abs(GPrintCol(0)), Abs(GPrintCol(1)), 0)
                End If
            End If
        Else
            
            If XoverList(RelX, RelY).ProgramFlag = 5 Or XoverList(RelX, RelY).ProgramFlag = 5 + AddNum Or OVS = 5 Then
                ReDim TraceSub(NextNo)
                For x = 0 To NextNo
                    TraceSub(x) = x
                Next x
                Call OrderSeqs(tSeq1, tSeq2, tSeq3, Seq1, Seq2, Seq3, TraceSub())
                Call WriteNames(WN1, WN2, WN3, Yellow, Green, Purple)
            ElseIf XoverList(RelX, RelY).ProgramFlag = 7 Or XoverList(RelX, RelY).ProgramFlag = 7 + AddNum Or OVS = 4 Or OVS = 7 Then
                
                If DebuggingFlag < 2 Then On Error Resume Next
                UB = -1
                UB = UBound(GPrintCol, 1)
                On Error GoTo 0
                If UB < 2 Then
                    ReDim Preserve GPrintCol(2)
                Else
                
                
                    Call WriteNames2(WN1, WN2, WN3, GPrintCol(0), GPrintCol(1), GPrintCol(2))
                End If
            ElseIf XoverList(RelX, RelY).ProgramFlag = 4 Or XoverList(RelX, RelY).ProgramFlag = 4 + AddNum Then
            
            ElseIf XoverList(RelX, RelY).ProgramFlag = 8 Or XoverList(RelX, RelY).ProgramFlag = 8 + AddNum Or OVS = 8 Then
                
            ElseIf XoverList(RelX, RelY).ProgramFlag <> 4 Then
                If UBound(GPrintCol, 1) >= 2 Then
                    Call WriteNames(WN1, WN2, WN3, GPrintCol(0), GPrintCol(1), GPrintCol(2))
                    XX = RunFlag
                End If
            End If
        
        End If
    End If
    
   Form1.Picture7.FontSize = OFS
    If CurrentCheck = 5 Or (CurrentCheck = -1 And XoverList(RelX, RelY).ProgramFlag = 5) Then 'need to keep a backup image of the siscan plot
        Form1.Picture21.Picture = LoadPicture()
        Form1.Picture21.Width = Form1.Picture7.Width + 100
        Form1.Picture21.Height = Form1.Picture7.Height + 100
        Form1.Picture21.PaintPicture Form1.Picture7.Image, Form1.Picture7.Left, Form1.Picture7.Top + 5
        
        
   End If
   
   
   'redo just the BP position and the missing data blocks
   If GBlockNum > -1 Then
        ColHL = RGB(0, 255, 255)
        
        
        For x = 0 To GBlockNum
            GoOn = 0
            If GBlock(4, x) = RGB(255, 190, 190) Or GBlock(4, x) = RGB(255, 210, 210) Then
                Form1.Picture7.ForeColor = ColHL
                Form1.Picture7.FillColor = ColHL
                Form1.Picture7.DrawMode = 12
                YPos = TOffset
                GoOn = 1
            ElseIf GBlock(4, x) = RGB(197, 197, 255) Then
                YPos = TOffset
                Form1.Picture7.DrawMode = 13
                Form1.Picture7.ForeColor = GBlock(4, x)
                Form1.Picture7.FillColor = GBlock(4, x)
                GoOn = 1
            Else
                YPos = TOffset + 10
                Form1.Picture7.DrawMode = 13
                Form1.Picture7.ForeColor = GBlock(4, x)
                Form1.Picture7.FillColor = GBlock(4, x)
            End If
            If GoOn = 1 Then
                Form1.Picture7.FillStyle = 0
                
                If GBlock(1, x) = 0 Then 'ie it is a block on the plot
                    GB0 = Decompress(GBlock(0, x))
                    GB2 = Decompress(GBlock(2, x))
                    If Form1.Picture7.ForeColor = ColHL Then
                        If GBlock(0, x) = 1 Then
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                            Dummy = MoveToEx(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15, PntAPI)
                            Dummy = LineTo(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
    
                        ElseIf GBlock(2, x) = Len(StrainSeq(0)) Then
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                            Dummy = MoveToEx(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, PntAPI)
                            Dummy = LineTo(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos)
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
    
                        Else
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15 + 10)
                            Dummy = MoveToEx(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), PicHeight - 15, PntAPI)
                            Dummy = LineTo(MhDC, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                            Dummy = Rectangle(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos + 10, LOffset + GB2 * XFactor * CurveArray(GB2), YPos)
                            Dummy = MoveToEx(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), PicHeight - 15, PntAPI)
                            Dummy = LineTo(MhDC, LOffset + GB0 * XFactor * CurveArray(GB0), YPos)
                        End If
                    Else
                        If GBlock(0, x) = GBlock(2, x) Then
                            Dummy = MoveToEx(MhDC, CLng(LOffset + GB0 * XFactor * CurveArray(GB0)), PicHeight - 14, PntAPI)
                            Dummy = LineTo(MhDC, CLng(LOffset + GB0 * XFactor * CurveArray(GB0)), YPos)
                        Else
                            Dummy = Rectangle(MhDC, CLng(LOffset + GB0 * XFactor * CurveArray(GB0)), PicHeight - 14, CLng(LOffset + GB2 * XFactor * CurveArray(GB2)), YPos)
                        End If
                        
                        
                    End If
                ElseIf GBlock(1, x) = 1 Then 'ie it is a block on the plot
                    
                ElseIf GBlock(1, x) = 2 Then 'ie it is a block on the plot
                    
                ElseIf GBlock(1, x) = 3 Then 'ie it is a query sequence reference
                    
                End If
            End If
            Form1.Picture7.DrawMode = 13
        Next x
        
         
    End If
   
   
   
   
   'do the text
    'GPVTNum As Long, GPVTFont() As Long, GPVText() As String,
    If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(GPVTFont, 2)
    On Error GoTo 0
    
    If UB > 0 Then
        OFS = Form1.Picture7.FontSize
        For x = 0 To GPVTNum
            Form1.Picture7.ForeColor = GPVTFont(3, x)
            If x / 2 = CLng(x / 2) Then
                Form1.Picture7.CurrentX = (GPVTFont(0, x) * (Form1.Picture7.Width / GPVTFont(4, 0)))
            ElseIf x > 0 Then
                Form1.Picture7.CurrentX = (GPVTFont(0, x - 1) * (Form1.Picture7.Width / GPVTFont(4, 0))) + (GPVTFont(0, x) - GPVTFont(0, x - 1))
            End If
            
            
            
            Form1.Picture7.CurrentY = GPVTFont(1, x) '(GPVTFont(1, 0) * (Form1.Picture7.Height / GPVTFont(5, 0))) + (GPVTFont(1, X) - GPVTFont(1, 0))
            
            
            Form1.Picture7.FontSize = GPVTFont(2, x)
            
            Form1.Picture7.Print GPVText(x)
            x = x
        Next x
        Form1.Picture7.FontSize = OFS
   End If
   If ORFFlag = 1 Then
    
        Form1.Picture20.Refresh
    End If
    Form1.Picture7.Refresh
End Sub

Public Sub IntegrateXOvers(SPF)
    'SSAa = Abs(GetTickCount)
    
    Dim RandNumber As Single, Response As Long, Target As Long, PosX As Long, Dummy As Long, GoOn As Long, A As Long, XONCx As Variant, TVX As Variant, RN As Long, APR() As Byte, ProgDo() As Byte, UB As Long, EHold As Long, XNHold As Long, SCol(3) As Long, X1 As Long, X2 As Long, Y1 As Long, Y2 As Long, iMaskSeq() As Integer, iRevseq() As Integer, MaxSPos() As Integer, MaxXONo() As Integer, XOverNoComponent() As Integer
    Dim UTarget As Long, REnd As Long, RBegin As Long, iMask As Integer, PNum As Integer, CurSeq As Long, Extend As Long, g As Integer
    Dim DoneList() As Long, TempArray() As Integer
    Dim b As Long, Z As Long, oldY As Long, OLastDim As Long, LastDim As Long, UltimateMax As Long, TSPos As Long, Spos As Long, LSeq As Long, ProbCol As Long, DistCol As Long, x As Long, Y As Long
    'Dim TDistance() As Single
    Dim DoneThisOne As Byte, CNum As Byte
    Dim UnknownExtend As Long
    Form1.Picture5.FontSize = 6.75
    On Error Resume Next
        UB = -1
        UB = UBound(XoverList, 1)
        If UB < PermNextno Then
            RunFlag = 0
            Exit Sub
            
        End If
    On Error GoTo 0
    Dim StartProgress As Single, TargetProgress As Single
    'Erase SBlockBak
    ReDim SBlockBak(UBound(XoverList, 1), UBound(XoverList, 2))
    ReDim SBlockBakE(NextnoBak)
    StartProgress = Form1.ProgressBar1.Value
    TargetProgress = 100
    If PermNextno <> NextNo Then
        Call UnModNextno
    
    End If
    'Call UnModSeqNum(0)
    
    PNum = 12
    If SEventNumber = 0 Then Exit Sub
    ReDim Preserve ProgF(100)
    ReDim APR(AddNum * 2)
    
    
    
    
    For x = 0 To AddNum - 1
        If DoScans(0, x) = 1 Then
            APR(x) = 1
            APR(x + AddNum) = 1
        End If
    
    Next x
    
    
    For x = 0 To AddNum
        If ProgF(x) = 1 Then ProgF(x + AddNum) = 1
    Next x
    ReDim ProgDo(AddNum * 2, NextNo)
    'Form1.ProgressBar1.Value = 2
    Form1.Picture6.AutoRedraw = True
    'Call DoConfirm
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.SSPanel1.Caption = "Planning recombination graphs"
        Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * 0.05
    Else
        Form1.SSPanel1.Caption = "Redrawing recombination graphs"
    End If
    Call UpdateF2Prog
    Dim Frm1Pic5ScaleWidth As Long

    Frm1Pic5ScaleWidth = Form1.Picture5.ScaleWidth - 10
    LSeq = Len(StrainSeq(0))
    If Frm1Pic5ScaleWidth >= 0 Then
        If DebuggingFlag < 2 Then On Error Resume Next
            UB = 0
            UB = UBound(PermArray, 2)
            
            
        On Error GoTo 0
        If UB > 0 Then
        ReDim PermArray(0, 0)
            ReDim PermArray(Frm1Pic5ScaleWidth, UB)
        Else
            ReDim PermArray(Frm1Pic5ScaleWidth, 100)
        End If
    Else
        ReDim PermArray(0, 100)
    End If
    AdjArrayPos = (Frm1Pic5ScaleWidth) / LSeq
    ReDim iMaskSeq(NextNo)
    ReDim iRevseq(NextNo)
    Y = 0

    For x = 0 To NextNo

        If CurrentXOver(x) > 0 Then
            iMaskSeq(Y) = x
            iRevseq(x) = Y
            Y = Y + 1
        End If

    Next 'X

    iMask = Y - 1
    If iMask < 0 Then iMask = 0
    
    Dim LSAdjust As Single, XONC As Long
    If LSeq > 10000 Then
        XONC = 10000
        LSAdjust = 10000 / LSeq
    Else
        XONC = LSeq
        LSAdjust = 1
        TVX = (AddNum * 2 + 1)
        TVX = TVX * (iMask + 1)
        TVX = TVX * (XONC + 11)
        TVX = TVX * 4
        If TVX > 100000000 Then
            XONCx = (100000000 / TVX)
            XONC = LSeq * XONCx
            LSAdjust = XONC / LSeq
        End If
    End If
    'Erase XOverNoComponent
    'XX = Nextno
    On Error Resume Next
    Do
    
    ReDim XOverNoComponent(AddNum * 2, iMask, XONC + 10)
    ubxonc = 0
    ubxonc = UBound(XOverNoComponent, 3)
    If ubxonc = XONC + 10 Then
        Exit Do
    Else
        XONC = CLng(XONC * 0.95)
        LSAdjust = XONC / LSeq
    End If
    Loop
    On Error GoTo 0
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
       
        Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * 0.1
        Call UpdateF2Prog
    End If
    
    ReDim MaxXONo(NextNo)
    'Initialise arrays (use C for this?)

    For x = 0 To iMask
        XoverList(iMaskSeq(x), 0).Probability = 1
    Next 'X
    
    
    
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.SSPanel1.Caption = "Drawing recombination graphs"
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.15
        StartProgress = Form1.ProgressBar1.Value
        Call UpdateF2Prog
    End If
    MinLogPValSch = 1
    MaxLogPValSch = 0
    ST = Abs(GetTickCount)
    Dim XoNoX As Long
    Dim MSX As Long, BProg As Byte, FProg As Byte, StartP As Byte, StartE As Long, BestEg() As Byte, BestP As Double, BestNum As Long, DoneNum() As Byte
    
    Rnd (-BSRndNumSeed)
    Dim SortArray() As Long, SortCounter As Long, SC() As Long, GG As Long, SCOrder() As Long, OrderedSC() As Long, D0 As Long, D1 As Long, D2 As Long, D3 As Long
    
    ReDim OrderedSC(NextNo, UBound(XoverList, 2)), SC(NextNo)
    For x = 0 To iMask
    
            MSX = iMaskSeq(x)
            
'            If MSX = 10 Then
'                x = x
'            End If
            XoNoX = CurrentXOver(MSX)
'            If iMaskSeq(X) = 301 Then
'                X = X
'                XX = BestEvent(14, 0)
'                XX = BestEvent(14, 1)
                'XX = OriginalName(XoverList(10, 21).Daughter)
''                XX = OriginalName(301)
'            End If
            ReDim BestEg(XoNoX)
            ReDim DoneNum(XoNoX)

            'check to see if the current xoverlist has any "addsomeextra" events in it
            'if it does then make a sorting array so that they will be done one at a time
            'if it does not then the sorting array will have just one entry
            ReDim SortArray(100)
            ReDim SCOrder(XoNoX)
            SortCounter = 0
            SortArray(0) = MSX
            For Y = 1 To XoNoX
                If XoverList(MSX, Y).Daughter = MSX Then
                    DoneNum(Y) = 1
                    SCOrder(Y) = SortCounter
                    OrderedSC(MSX, Y) = SortCounter
                End If
            Next Y
            For Y = 1 To XoNoX
                If DoneNum(Y) = 0 Then
                    DoneNum(Y) = 1
                    SortCounter = SortCounter + 1
                    SCOrder(Y) = SortCounter
                    OrderedSC(MSX, Y) = SortCounter
                    If SortCounter > UBound(SortArray) Then
                        ReDim Preserve SortArray(SortCounter + 100)
                    End If
                    SortArray(SortCounter) = XoverList(MSX, Y).Daughter
                    
                    For A = Y + 1 To XoNoX
                        If XoverList(MSX, A).Daughter = SortArray(SortCounter) Then
                            DoneNum(A) = 1
                            SCOrder(A) = SortCounter
                            OrderedSC(MSX, A) = SortCounter
                        End If
                        
                    Next A
                End If
            Next Y
            SC(MSX) = SortCounter
            ReDim DoneNum(XoNoX)
            For GG = 0 To SortCounter
            
                For Y = 1 To XoNoX
    '                If MSX = 10 And (Y = 21 Or Y = 27) Then
    '                    x = x
    '                End If
                    
                    If DoneNum(Y) = 0 And SCOrder(Y) = GG Then
                        If XoverList(MSX, Y).Eventnumber <= Eventnumber Then
                         'DoneNum(Y) = 1
                         StartE = SuperEventList(XoverList(MSX, Y).Eventnumber)
    '                     If StartE = 14 Then
    '                        x = x
    '                     End If
                         
                         ''If StartE = 23 Then
                          '  ' XX = BestEvent(23, 0)
                          '  ' XX = BestEvent(23, 1)
                          '   XX = XOverList(iMaskSeq(X), Y).Beginning
                         '    XX = XOverList(iMaskSeq(X), Y).Ending
                        ' End If
                         
                         StartP = XoverList(MSX, Y).ProgramFlag
                         BestP = XoverList(MSX, Y).Probability
                         If StartE > 0 Then
                         'If iMaskSeq(X) = 275 Then
                         '            X = X
                         '        End If
                         
                             If ShowAllHits(MSX) = 0 Then
                                 
                                 'XX = UBound(BestEvent, 2)
                                 'XX = XOverList(BestEvent(StartE, 0), BestEvent(StartE, 1)).ProgramFlag
                                 'If iMaskSeq(X) = BestEvent(StartE, 0) And Y = BestEvent(StartE, 1) Then
                                 If BestEvent(StartE, 1) = -1 Then
                                     BestEvent(StartE, 0) = MSX: BestEvent(StartE, 1) = Y
                                 End If
                                
                                 If MSX = BestEvent(StartE, 0) And BestEvent(StartE, 1) <= XoNoX And BestEvent(StartE, 1) > -1 Then
                                     'Y = BestEvent(StartE, 1)
                                     FProg = 1
                                     BestNum = BestEvent(StartE, 1)
    '                                 If MSX = 208 And (BestEvent(StartE, 1) = 11 Or BestEvent(StartE, 1) = 14) Then
    '                                    X = X
    '                                 End If
                                     DoneNum(BestEvent(StartE, 1)) = 1
                                     For A = 1 To XoNoX
                                         If SCOrder(A) = GG Then
                                             If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                                 If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
        '                                            If MSX = 208 And (A = 11 Or A = 14) Then
        '                                               X = X
        '                                            End If
                                                     DoneNum(A) = 1
                                                     
                                                 End If
                                             End If
                                         End If
                                     Next A
                                                 
                                                 
                                     
                                 x = x
                                     
                                 Else
                                     'If iMaskSeq(X) = BestEvent(StartE, 0) Then
                                     '    BestNum = BestEvent(StartE, 1)
                                     '    DoneNum(BestEvent(StartE, 1)) = 1
                                     '    FProg = 1
                                     'End If
                                     
                                                                       
                                     BProg = XoverList(BestEvent(StartE, 0), BestEvent(StartE, 1)).ProgramFlag
                                     FProg = 0
                                     'XX = UBound(SuperEventList, 1)
                                     For Z = Y To XoNoX
                                         If SCOrder(Z) = GG Then
                                             If DoneNum(Z) = 0 Then
                                                 If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                                    ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 50)
                                                 End If
                                                 If XoverList(MSX, Z).Eventnumber <= UBound(SuperEventList, 1) Then
                                                 If XoverList(MSX, Z).Accept <> 2 And SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And APR(XoverList(MSX, Z).ProgramFlag) = 1 Then 'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                     FProg = 1
                                                     BestNum = Z
                                                     DoneNum(Z) = 1
        '                                             If MSX = 208 And (Z = 11 Or Z = 14) Then
        '                                               X = X
        '                                            End If
                                                     For A = 0 To XoNoX
                                                         If SCOrder(A) = GG Then
                                                             If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                                                 If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                                     DoneNum(A) = 1
            '                                                         If MSX = 208 And (A = 11 Or A = 14) Then
            '                                                           X = X
            '                                                        End If
                                                                     If XoverList(MSX, A).Probability < BestP And APR(XoverList(MSX, A).ProgramFlag) = 1 And XoverList(MSX, A).Accept <> 2 Then
                                                                         FProg = 1
                                                                         BestNum = A
                                                                         BestP = XoverList(MSX, A).Probability
                                                                     End If
                                                                 End If
                                                             End If
                                                          End If
                                                     Next A
                                                     Exit For
                                                 End If
                                                 End If
                                             End If
                                        End If
                                     Next Z
                                     If FProg = 0 Then
                                        For Z = Y To XoNoX
                                           
                                            If DoneNum(Z) = 0 Then
                                                If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                                   ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 50)
                                                End If
                                                If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And APR(XoverList(MSX, Z).ProgramFlag) = 1 Then  'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                    FProg = 1
                                                    BestNum = Z
                                                    DoneNum(Z) = 1
    '                                                If MSX = 208 And (Z = 11 Or Z = 14) Then
    '                                                   X = X
    '                                                End If
                                                    For A = 0 To XoNoX
                                                        If SCOrder(A) = GG Then
                                                            If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                                                If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                                    DoneNum(A) = 1
        '                                                            If MSX = 208 And (A = 11 Or A = 14) Then
        '                                                               X = X
        '                                                            End If
                                                                    If XoverList(MSX, A).Probability < BestP And APR(XoverList(MSX, A).ProgramFlag) = 1 And XoverList(MSX, A).Accept <> 2 Then
                                                                        FProg = 1
                                                                        BestNum = A
                                                                        BestP = XoverList(MSX, A).Probability
                                                                    End If
                                                                End If
                                                            End If
                                                        End If
                                                    Next A
                                                    Exit For
                                                End If
                                            End If
                                        Next Z
                                     End If
                                     If FProg = 0 Then
                                         For Z = Y To XoNoX
                                             'If SuperEventlist(XOverList(iMaskSeq(X), Z).Eventnumber) = 54 Then
                                             '    X = X
                                             '    XX = XOverList(iMaskSeq(X), A).ProgramFlag
                                             'End If
                                             If DoneNum(Z) = 0 Then
                                                If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                                    ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 10)
                                                End If
                                                 If XoverList(MSX, Z).Accept <> 2 And SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE Then  'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                     FProg = 1
                                                     BestNum = Z
                                                     DoneNum(Z) = 1
    '                                                 If MSX = 208 And (Z = 11 Or Z = 14) Then
    '                                                   X = X
    '                                                End If
                                                     For A = 0 To XoNoX
                                                        If SCOrder(A) = GG Then
                                                            If XoverList(MSX, A).Eventnumber > UBound(SuperEventList, 1) Then
                                                                ReDim Preserve SuperEventList(XoverList(MSX, A).Eventnumber + 10)
                                                            End If
                                                             If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                                 DoneNum(A) = 1
        '                                                         If MSX = 208 And (A = 11 Or A = 14) Then
        '                                                           X = X
        '                                                        End If
                                                                 If XoverList(MSX, A).Probability < BestP And XoverList(MSX, A).Accept <> 2 Then
                                                                     FProg = 1
                                                                     BestNum = A
                                                                     BestP = XoverList(MSX, A).Probability
                                                                 End If
                                                             End If
                                                        End If
                                                     Next A
                                                     Exit For
                                                 End If
                                             End If
                                         Next Z
                                     End If
                                     
                                     
                                     
                                     
                                     
                                     
                                     If FProg = 0 Then
                                         For Z = Y To XoNoX
                                             'If SuperEventlist(XOverList(iMaskSeq(X), Z).Eventnumber) = 54 Then
                                             '    X = X
                                             '    XX = XOverList(iMaskSeq(X), A).ProgramFlag
                                             'End If
                                             If DoneNum(Z) = 0 Then
                                                 If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE Then    'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                     FProg = 1
                                                     BestNum = Z
                                                     DoneNum(Z) = 1
    '                                                 If MSX = 208 And (Z = 11 Or Z = 14) Then
    '                                                   X = X
    '                                                End If
                                                     For A = 0 To XoNoX
                                                        If SCOrder(A) = GG Then
                                                            If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                                DoneNum(A) = 1
'                                                                If MSX = 208 And (A = 11 Or A = 14) Then
'                                                                  x = x
'                                                               End If
                                                                If XoverList(MSX, A).Probability < BestP Then
                                                                    FProg = 1
                                                                    BestNum = A
                                                                    BestP = XoverList(MSX, A).Probability
                                                                '    If SuperEventList(XOverlist(iMaskSeq(X), Z).Eventnumber) = 1 And iMaskSeq(X) = 8 Then
                                                                '  X = X
                                                               'End If
                                                                End If
                                                                
                                                            End If
                                                        End If
                                                     Next A
                                                     Exit For
                                                 End If
                                             End If
                                         Next Z
                                     End If
                                     
                                 End If
                                 
                                 If FProg = 0 Then
                                    'If SuperEventList(XOverlist(iMaskSeq(X), Z).Eventnumber) = 1 Then
                                    '    X = X
                                    'End If
                                     BestP = 1
                                     For Z = Y To XoNoX
                                        If SCOrder(Z) = GG Then
                                             If DoneNum(Z) = 0 Then
                                                 If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And XoverList(MSX, Z).Probability > 0 And XoverList(MSX, Z).Probability < BestP Then
                                                     DoneNum(Z) = 1
        '                                             If MSX = 208 And (Z = 11 Or Z = 14) Then
        '                                               X = X
        '                                            End If
                                                     FProg = 1
                                                     BestNum = Z
                                                     BestP = XoverList(MSX, Z).Probability
                                                 End If
                                                 
                                             End If
                                        End If
                                     Next Z
                                     For A = 0 To XoNoX
                                        If SCOrder(A) = GG Then
                                             If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
        '                                        If MSX = 208 And (A = 11 Or A = 14) Then
        '                                               X = X
        '                                            End If
                                                 DoneNum(A) = 1
                                             End If
                                        End If
                                     Next A
                                 End If
                                 BestEg(BestNum) = 1
                                 
                             Else
                                 DoneNum(Y) = 1
    '                             If MSX = 208 And (Y = 11 Or Y = 14) Then
    '                                               X = X
    '                                            End If
                                 BestNum = Y
                                 For Z = Y + 1 To XoNoX
                                    If SCOrder(Z) = GG Then
                                         If DoneNum(Z) = 0 Then
                                             If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And XoverList(MSX, Z).ProgramFlag = StartP Then
                                                 DoneNum(Z) = 1
        '                                         If MSX = 208 And (Z = 11 Or Z = 14) Then
        '                                               X = X
        '                                            End If
                                                 If BestP > XoverList(MSX, Z).Probability Then
                                                     BestP = XoverList(MSX, Z).Probability
                                                     BestNum = Z
                                                 End If
                                             End If
                                         End If
                                    End If
                                 Next Z
                                 BestEg(BestNum) = 1
                             End If
                         End If
                        End If
                    End If
                    x = x
                Next Y
            
                'XX = BestEg(4)
                
                For Y = 1 To XoNoX
                    If SCOrder(Y) = GG Then
                        If BestEg(Y) = 1 Then
                            GoOn = 0
                            'Have enough methods detected the event?
                            If ConsensusProg > 0 Then
                                CNum = 1
                                
                                For Z = 0 To AddNum - 1
                                    If XoverList(MSX, Y).ProgramFlag <> Z And XoverList(MSX, Y).ProgramFlag <> Z + AddNum And Confirm(SuperEventList(XoverList(MSX, Y).Eventnumber), Z) > 0 Then
                                        CNum = CNum + 1
                                    End If
                                    '
                                Next
                                If CNum > ConsensusProg Then GoOn = 1
                            Else
                                GoOn = 1
                            End If
                            
                            If GoOn = 1 Then
                                'If enough methods detected the event then fit it in
                                
                                'update min/max P-vals
                                Dim CurProb As Double, CurBegin As Long, CurEnd As Long, CurProg As Long, UBXO As Long
                                CurProb = XoverList(MSX, Y).Probability
                                CurBegin = XoverList(MSX, Y).Beginning
                                CurEnd = XoverList(MSX, Y).Ending
                                CurProg = XoverList(MSX, Y).ProgramFlag
                                UBXO = UBound(XOverNoComponent, 1)
                                If CurProb < MinLogPValSch And CurProb > 0 Then
                                    MinLogPValSch = XoverList(MSX, Y).Probability
                                End If
                                If CurProb < LowestProb Then
                                    If CurProb > MaxLogPValSch And CurProb > 0 Then
                                        MaxLogPValSch = XoverList(MSX, Y).Probability
                                        
                                    End If
                                End If
                                DoneThisOne = 0
                                
                                If CurBegin < CurEnd Then 'if region internal
                    
                                    If CurEnd > LSeq Then
                    
                                        If CircularFlag = 0 Then
                                            XoverList(MSX, Y).Ending = LSeq
                                        Else
                                            XoverList(MSX, Y).Ending = LSeq - CurEnd
                                        End If
                                        CurEnd = XoverList(MSX, Y).Ending
                                    End If
                                    If CurProg > UBXO Then
                                        XoverList(MSX, Y).ProgramFlag = CurProg - AddNum
                                        CurProg = XoverList(MSX, Y).ProgramFlag
                                        
                                    End If
                                    If CurProb > 0 Then
        '                                If X = X Then
                                            Dummy = FixOverlapsP(DoneThisOne, CurBegin, CurEnd, CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                            
                                            DoneThisOne = Dummy
        '                                Else
        '
        '                                    For Z = CurBegin To CurEnd
        '
        '                                        'this is just a silly way of making sure that overlapping events detected by the same method
        '                                        'both get displayed
        '                                        RN = Int((3 * Rnd) + 1)
        '
        '                                        If RN = 2 Then
        '
        '                                            XOverNoComponent(CurProg, X, CLng(Z * LSAdjust)) = Y
        '
        '                                            ProgDo(CurProg, MSX) = 1
        '
        '                                            If DoneThisOne = 0 Then
        '                                                MaxXONo(MSX) = MaxXONo(MSX) + 1
        '                                                DoneThisOne = 1
        '                                            End If
        '
        '                                        End If
        '                                            'End If
        '
        '
        '
        '                                    Next 'Z
        '                                End If
                                    End If
                        
                                Else 'If end of region overlaps the end of the sequence
                                    
                                    If x = x Then
                                        
                                        Dummy = FixOverlapsP(DoneThisOne, 1, CurEnd, CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                        DoneThisOne = Dummy
                                        
                                        Dummy = FixOverlapsP(DoneThisOne, CurBegin, Len(StrainSeq(0)), CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                        If DoneThisOne = 0 Then
                                            DoneThisOne = Dummy
                                        End If
                                    Else
                                    
                                        For Z = 1 To CurEnd
                        'Exit Sub
                                            If CurProb > 0 Then
                                                
                                                'If XOverlist(MSX, XOverNoComponent(XOverlist(MSX, Y).ProgramFlag, X, CLng(Z * LSAdjust))).Probability > XOverlist(MSX, Y).Probability Or X = X Then
                                                    If XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) > 0 And XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) < Y Then
                                                        RandNumber = Rnd
                                                        If RandNumber > 0.5 Then
                                                            XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                        End If
                                                    Else
                                                        XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                    End If
                                                    ProgDo(CurProg, MSX) = 1
                                                    If DoneThisOne = 0 Then
                                                        MaxXONo(MSX) = MaxXONo(MSX) + 1
                                                        DoneThisOne = 1
                                                    End If
                        
                                                'End If
                        
                                            End If
                        
                                        Next 'Z
                        
                                        For Z = CurBegin To LSeq
                        
                                            If CurProb > 0 Then
                        
                                                'If XOverlist(MSX, XOverNoComponent(XOverlist(iMaskSeq(X), Y).ProgramFlag, X, CLng(Z * LSAdjust))).Probability > XOverlist(iMaskSeq(X), Y).Probability Or X = X Then
                                                    'XOverNoComponent(CurProg, X, CLng(Z * LSAdjust)) = Y
                                                    If XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) > 0 And XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) < Y Then
                                                        RandNumber = Rnd
                                                        If RandNumber > 0.5 Then
                                                            XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                        End If
                                                    Else
                                                        XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                    End If
                                                    ProgDo(CurProg, MSX) = 1
                                                    If DoneThisOne = 0 Then
                                                        MaxXONo(MSX) = MaxXONo(MSX) + 1
                                                        DoneThisOne = 1
                                                    End If
                        
                                                'End If
                        
                                            End If
                        
                                        Next 'Z
                                    End If
                                End If 'divides internal and sequences overlapping ends
                            End If
                        End If
                    End If
                Next 'Y
                If GG < SortCounter Then
                    MaxXONo(MSX) = MaxXONo(MSX) + 3
                End If
                
            Next GG
            If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
                ET = Abs(GetTickCount)
                If ET - ST > 100 Then
                    ST = ET
                    Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * x / NextNo * 0.25
                    Call UpdateF2Prog
                End If
            End If
            
    Next 'X
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.4
        StartProgress = Form1.ProgressBar1.Value
        Call UpdateF2Prog
    End If
    LastDim = 0
    x = -1
    If Frm1Pic5ScaleWidth < 0 Then Exit Sub
    'Erase TempArray
    ReDim TempArray(Frm1Pic5ScaleWidth, MaxXONo(b))
    
    PosX = UBound(XOverNoComponent, 3) - 10
    
    
    
    Dim FittedSomeIn As Long
    
    UnknownExtend = CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
    For b = 0 To NextNo
        'If B = 18 Then
        '    X = X
        'End If
        Spos = 0
        If ExcludedEventNum > 0 Then
            UltimateMax = UBound(XoverList, 2)
            MaxXONo(b) = MaxXONo(b) * 4
        Else
            UltimateMax = 0
            MaxXONo(b) = MaxXONo(b) + 4
        End If
        Dim IRSH As Long
        IRSH = iRevseq(b)
        If CurrentXOver(b) > 0 Then
            ReDim TempArray(Frm1Pic5ScaleWidth, MaxXONo(b)), DoneList(CurrentXOver(b)), MaxSPos(LSeq)
            For GG = 0 To SC(b) 'sc(b) reflects the number of distinct recombinant sequences that may need to be refelcted in this block of the schematic sequence display
                                'If there are excluded sequences this number can be very high
                If GG > 0 Then
                    FittedSomeIn = 0
                Else
                    FittedSomeIn = 0
                End If
                For g = 0 To AddNum * 2
    
                    If ProgDo(g, b) = 1 Then
    
                        For Y = 0 To PosX
                            XNHold = XOverNoComponent(g, IRSH, Y)
                            
                            If XNHold > 0 Then
                                If OrderedSC(b, XNHold) = GG Then
                                    If DoneList(XNHold) = 0 Then
                                        DoneList(XNHold) = 1
                                        If XoverList(b, XNHold).MinorP <= PermNextno Then
                                            If XoverList(b, XNHold).OutsideFlag < 2 And Len(OriginalName(XoverList(b, XNHold).MinorP)) > 0 Then
                                                
                                                Extend = CLng(LSeq * (((Form1.Picture5.TextWidth("O" & OriginalName(XoverList(b, XNHold).MinorP)))) / (Frm1Pic5ScaleWidth)))
                                            Else
                                                Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                                            End If
                                        Else
                                            Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                                            
                                        End If
                                        
                                        RBegin = XoverList(b, XNHold).Beginning
                                        REnd = XoverList(b, XNHold).Ending
                                        
                                        If RBegin = 0 Then XoverList(b, XNHold).Beginning = 1
            
                                        If REnd = 0 Then XoverList(b, XNHold).Ending = LSeq
                                        
                                        If REnd + Extend <= LSeq Then
                                            UTarget = REnd + Extend
                                        Else
                                            UTarget = LSeq
                                        End If
                                        
                                        If RBegin < REnd Then
                                            'Find a slot
                                            Spos = FindSlot(RBegin, UTarget + 1, Spos, MaxSPos(0))
                                            
                                            If Spos > UltimateMax Then
                                                '@
                                                Spos = ReFindSlot(AdjArrayPos, Frm1Pic5ScaleWidth, LSeq + 1, RBegin, UTarget + 1, 0, TempArray(0, 0), MaxSPos(0))
                                                
                                            End If
            
                                            If UltimateMax < Spos Then UltimateMax = Spos
                                            'Fill it
                                            FillArray2 AdjArrayPos, XNHold, RBegin, UTarget + 1, LSeq + 1, Spos, TempArray(0, Spos), MaxSPos(0)
                                            FittedSomeIn = 1
                                            
                                        Else
                                            'Find a slot
                                           
            
                                            
                                            For Z = RBegin To LSeq
            
                                                If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
                                            Next 'Z
                    
                                            For Z = 1 To UTarget
                    
                                                If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
                                                Z = Z + 10
                                            Next 'Z
                                            
                                          
            
                                            If Spos > UltimateMax Then
                                                
                                                If XoverList(b, XNHold).Beginning > LSeq Then
                                                    XoverList(b, XNHold).Beginning = 1
                                                End If
                                                Z = XoverList(b, XNHold).Beginning
                                                TSPos = 0
                                                
                                                Do
                                                    
                                                    If TempArray(CInt(Z * AdjArrayPos), TSPos) <> 0 Then
                                                        TSPos = TSPos + 1
                                                        Z = RBegin
                                                    End If
            
                                                    Z = Z + 1
                                                Loop While Z <= LSeq - 10
            
                                                Z = 1
                                                EHold = XoverList(b, XNHold).Ending - 10 + Extend
                                                Do
            
                                                    If TempArray(CInt(Z * AdjArrayPos), TSPos) <> 0 Then
                                                        TSPos = TSPos + 1
                                                        Z = 1
                                                    End If
            
                                                    Z = Z + 1
                                                    If Z > EHold Then
                                                        Exit Do
                                                    ElseIf Z > LSeq - 10 Then
                                                        Exit Do
                                                    End If
                                                    
                                                Loop
            
                                                Spos = TSPos
                                            End If
            
                                            If UltimateMax < Spos Then UltimateMax = Spos
                                            
                                            Z = XoverList(b, XNHold).Beginning
                                            
                                            Do
                                                
                                                TempArray(CInt(Z * AdjArrayPos), Spos) = XNHold
            
                                                If Spos >= MaxSPos(Z) Then MaxSPos(Z) = Spos + 1
                                                Z = Z + 1
                                                If Z > LSeq Then Exit Do
                                            Loop
            
                                            Z = 1
                                            EHold = XoverList(b, XNHold).Ending + Extend
                                            Do
                                                If Z > EHold Then
                                                    Exit Do
                                                ElseIf Z > LSeq Then
                                                    Exit Do
                                                End If
                                                
                                                TempArray(CInt(Z * AdjArrayPos), Spos) = XNHold
            
                                                If Spos >= MaxSPos(Z) Then MaxSPos(Z) = Spos + 1
                                                
                                                Z = Z + 1
                                                
                                            Loop
                                            FittedSomeIn = 1
                                        End If
                                    End If
                                
                                    
                                End If
                                
                            End If
                            
                        Next 'Y
    
                    End If
    
                Next 'G
                
                    
                If GG < SC(b) And FittedSomeIn = 1 Then
                    'If FittedSomeIn = 1 Then
                        Spos = Spos + 3
                    ElseIf GG = 0 And SC(b) > 0 And FittedSomeIn = 0 Then 'if gg=0 it is the seed sequence which must be displayed irrespective of whether any recombination events were detected in it
                    
                        Spos = Spos + 2
                   
                
                ElseIf GG = SC(b) And FittedSomeIn = 0 And SC(b) > 0 Then
                    Spos = Spos - 3
                End If
                
                For Z = 0 To LSeq Step 20
                    'MaxSPos(Z) = MaxSPos(Z) + 3
                    If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
                Next 'Z
            Next GG
            

        End If

        'Copies Temparray data into Permarray
        UB = UBound(PermArray, 2)
        If LastDim + Spos + 4 > UB Then
            ReDim Preserve PermArray(Frm1Pic5ScaleWidth, LastDim + Spos + 4 + 400)
            
        End If
        'Encode the first y column with sequence info
        ModPermArray Frm1Pic5ScaleWidth, UB, LastDim, Spos, b, PermArray(0, 0), TempArray(0, 0)
        
        LastDim = LastDim + Spos + 2
        If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
            ET = Abs(GetTickCount)
            If ET - ST > 400 Then
                ST = ET
                Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * b / NextNo * 0.5
                Call UpdateF2Prog
            End If
        End If
    Next 'B
    
    '3.445,3.555,3.465
    '3.365 with modpermarray
    '541 with prodo
    LastDim = LastDim - 1
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.9
        StartProgress = Form1.ProgressBar1.Value
        Form1.SSPanel1.Caption = "Drawing recombination graphs"
        Call UpdateF2Prog
    End If
    'Do Calcs for colour Schemes
    'Do Calcs for Prob colour schemes

    If MaxLogPValSch < LowestProb Then MaxLogPValSch = -Log10(LowestProb)

    If MinLogPValSch > 0 Then
        MinLogPValSch = -Log10(MinLogPValSch)
    Else
        MinLogPValSch = 999
    End If

    'Do Calcs for ID colour schemes
    MaxDistSch = -10
    MinDistSch = 10
    'If necessary work out distances between sequences

    If DistanceFlag = 0 Then  'If distancematrix not yet calculated and if a "spacer" is required
        
        Call CalcDistances(SeqNum(), AvDst, Decompress(), PermDIffs(), PermValid(), NextNo, Distance(), 0, 0)

    
    End If
    'Erase TDistance
    'ReDim TDistance(Nextno, Nextno)
    
    
    'ssbb = Abs(GetTickCount)
    
'    If X = X Then
        'Dummy = CopyDistandFindMinMax(Nextno, UBound(TDistance, 1), UBound(Distance, 1), MaxDistSch, MinDistSch, TDistance(0, 0), Distance(0, 0))
        Dummy = CopyDistandFindMinMax(NextNo, UBound(Distance, 1), UBound(Distance, 1), MaxDistSch, MinDistSch, Distance(0, 0), Distance(0, 0))
        'X = X
'    Else
'        For X = 0 To Nextno
'
'            For Y = X + 1 To Nextno
'                If Y <= UBound(Distance, 2) Then
'                    TDistance(X, Y) = Distance(X, Y)
'                    TDistance(Y, X) = TDistance(X, Y)
'
'                    If TDistance(X, Y) > MaxDistSch Then
'                        MaxDistSch = TDistance(X, Y)
'                    End If
'
'                    If TDistance(X, Y) < MinDistSch Then
'                        MinDistSch = TDistance(X, Y)
'                    End If
'
'                Else
'                    Exit For
'                End If
'
'            Next 'Y
'
'        Next 'X
'    End If
'    eebb = Abs(GetTickCount)
'    ttbb = eebb - ssbb '0.343 for freds'1.154 for urmillas' 0.032 for fred
    
    x = x
    
    'sscc = Abs(GetTickCount)
    OLastDim = LastDim
    Form1.SSPanel5.Enabled = True
    SpaceAdjust = 1 '  F1VS2Adj)
    

    
    
    Form1.Picture5.ScaleMode = 3
    Form1.Picture6.DrawMode = 13
    
    'Try to get the picturebox to the correvt size

    If CurrentXOver(NextNo) = 0 Then
        LastDim = LastDim + 2
    Else
        LastDim = LastDim + 2
    End If

    Form1.Picture6.Height = Form1.Picture5.ScaleHeight
    
    'ReDim Preserve originalname(NextNo + 1)
    'originalname(NextNo + 1) = "Unknown"
    ReDim SchemBlocks(3, 4, 100), SchemString(3, 3, 100)
    SBlocksLen = -1: SStringLen = -1
    LastDim = OLastDim
    Form1.Picture5.BackColor = BackColours
    Form1.Picture6.BackColor = BackColours
    Form1.Picture6.Left = 0
    'Test to make sure pictureboxes can be drawn onto
    X1 = 5: Y1 = 3 * SpaceAdjust
    SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
    Call AddString(X1, Y1, 0, SCol(), SStringLen, SchemString())
    X1 = 5 + 1: Y1 = 3 * SpaceAdjust + 1
    SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
    Call AddString(X1, Y1, 0, SCol(), SStringLen, SchemString())
    
    X1 = 5: X2 = 5 + LSeq * (Frm1Pic5ScaleWidth) / LSeq
    Y1 = 15 * SpaceAdjust: Y2 = 25 * SpaceAdjust
    SCol(0) = SeqCol(0)
    SCol(1) = QuaterColour
    SCol(2) = QuaterColour
    SCol(3) = QuaterColour
    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
    SBlockBak(0, 0) = SBlocksLen
RedoSizing:

    Dim YAdj As Single, YAdj2 As Single
    Dim XAdj As Single
    Dim TBegin As Long, TEnd As Long
    Dim BeginAdj As Integer, EndAdj As Integer

    XAdj = (Frm1Pic5ScaleWidth) / LSeq
    CurSeq = 0
    oldY = 1
    Dim DV0 As Long, DV1 As Long, DV2 As Long, DV3 As Long, BeginPW As Long, EndPW As Long
    Dim NameNumber As Long, NameString As String, PAV As Long, FirstSet As Long
    Call SplitP(-XoverList(RelX, RelY).BeginP, DV0, DV1)
    Y = 2
    FirstSet = 0
    Dim AlreadyDone() As Byte, NoAdd As Long
    ReDim AlreadyDone(Eventnumber)
    Do While Y <= LastDim
        YAdj = Int((Y * 12 + 3) * SpaceAdjust)
        YAdj2 = Int((Y * 12 + 13) * SpaceAdjust)
        NoAdd = NoAdd + 1
        If PermArray(0, Y) > 0 Then 'This is the name line
            NoAdd = 0
            CurSeq = PermArray(0, Y)
            If CurSeq > PermNextno Then
                CurSeq = TreeTrace(CurSeq)
            End If
            X1 = 5: Y1 = YAdj
            SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
            'If ExRecFlag = 0 Then
                Call AddString(X1, Y1, CurSeq, SCol(), SStringLen, SchemString())
                X1 = 5 + 1: Y1 = YAdj + 1
                SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                Call AddString(X1, Y1, CurSeq, SCol(), SStringLen, SchemString())
            'End If
        ElseIf PermArray(0, Y) < 0 Then 'This is the main sequence block line
            NoAdd = 0
            ReDim AlreadyDone(Eventnumber)
            X1 = 5: X2 = 5 + LSeq * XAdj
            Y1 = YAdj: Y2 = ((Y + 1) * 12 + 1)
            'XX = Y2 - Y1
            If UBound(SeqCol, 1) >= CurSeq Then
                SCol(0) = SeqCol(CurSeq): SCol(1) = QuaterColour: SCol(2) = QuaterColour: SCol(3) = QuaterColour
            End If
            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
'            If CurSeq = 10 Then
'                x = x
'            End If
            SBlockBak(CurSeq, 0) = SBlocksLen '255
            oldY = Y
            FirstSet = 1
        Else

            For x = 1 To Frm1Pic5ScaleWidth
                    
                If PermArray(x, Y) > 0 Then
                    NoAdd = 0
                    
'                    If SuperEventList(XoverList(CurSeq, PermArray(x, Y)).Eventnumber) = 558 Then
'                        x = x
'                    End If
                    DV0 = 0: DV1 = 0: DV2 = 0: DV3 = 0: BeginPW = -1: EndPW = -1
                    If ExcludedEventNum > 0 Then
                        FirstSet = 0
                        If FirstSet = 1 Then 'make sure to do all the events where curseq is the daughter frst
                        XX = UBound(WhereIsExclude)
                        Else
                            If XoverList(CurSeq, PermArray(x, Y)).BeginP < 0 Then
                                Call SplitP(-XoverList(CurSeq, PermArray(x, Y)).BeginP, DV0, DV1)
                                'XX = UBound(WhereIsExclude, 1)
                                BeginPW = WhereIsExclude(DV0)
                            End If
                            If XoverList(CurSeq, PermArray(x, Y)).EndP < 0 Then
                                Call SplitP(-XoverList(CurSeq, PermArray(x, Y)).EndP, DV2, DV3)
                                EndPW = WhereIsExclude(DV2)
                            End If
                            '''''''''''''''''''''''''''''''''''''''''
                            'Test faking a sequence
                            ''''''''''''''''''''''''''''''''''''''''
                            If XoverList(CurSeq, PermArray(x, Y)).BeginP < 0 And XoverList(CurSeq, PermArray(x, Y)).Daughter <> CurSeq And AlreadyDone(PermArray(x, Y)) = 0 Then
                                PAV = OrderedSC(CurSeq, PermArray(x, Y))
                                For A = 1 To CurrentXOver(CurSeq)
                                    If OrderedSC(CurSeq, A) = PAV Then
                                        AlreadyDone(A) = 1
                                    End If
                                Next A
                                ReDim Preserve PermArray(UBound(PermArray, 1), UBound(PermArray, 2) + 3)
                                
                                'Open up three rows of space in permarray
'                                For A = LastDim To Y Step -1
''                                    If PermArray(0, A) = 1 Then
''                                        x = x
''                                    End If
'                                    For b = 0 To UBound(PermArray, 1)
'                                        PermArray(b, A + 3) = PermArray(b, A)
'                                    Next b
'                                Next A
                                
                                LastDim = LastDim + 3
                                Dim tCurseq As Long
                                If DV1 = XoverList(CurSeq, PermArray(x, Y)).Daughter Then
                                    tCurseq = -DV0
                                ElseIf DV2 = XoverList(CurSeq, PermArray(x, Y)).Daughter Then
                                    tCurseq = -DV2
                                End If
                                
                                YAdj = Int(((Y - 2) * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int(((Y - 2) * 12 + 13) * SpaceAdjust)
                                
                                X1 = 5: Y1 = YAdj
                                SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
                                Call AddString(X1, Y1, tCurseq, SCol(), SStringLen, SchemString())
                                X1 = 5 + 1: Y1 = YAdj + 1
                                SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                Call AddString(X1, Y1, tCurseq, SCol(), SStringLen, SchemString())
                                
                                YAdj = Int(((Y - 1) * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int(((Y - 1) * 12 + 13) * SpaceAdjust)
                                
                                X1 = 5: X2 = 5 + LSeq * XAdj
                                Y1 = YAdj: Y2 = YAdj + 10
                                If DV1 = XoverList(CurSeq, PermArray(x, Y)).Daughter And BeginPW >= 0 Then
                                    SCol(0) = SeqCol(BeginPW)
                                    tCurseq = DV0
                                ElseIf DV3 = XoverList(CurSeq, PermArray(x, Y)).Daughter And EndPW >= 0 Then
                                    SCol(0) = SeqCol(EndPW)
                                    tCurseq = DV2
                                Else
                                    SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).Daughter)
                                    tCurseq = OriginalPos(CurSeq)
                                End If
                                SCol(1) = QuaterColour: SCol(2) = QuaterColour: SCol(3) = QuaterColour
                                
                                Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
'                                If CurSeq = 10 Then
'                                    x = x
'                                End If
                                'SBlockBak(CurSeq, 0) = SBlocksLen
                                SBlockBakE(tCurseq) = SBlocksLen
'                                For A = Y To Y + 2
'                                    For b = 0 To UBound(PermArray, 1)
'                                        PermArray(b, A) = 0
'
'                                    Next b
'                                Next A
                                oldY = Y - 1
                                'Y = Y + 3
                                YAdj = Int((Y * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int((Y * 12 + 13) * SpaceAdjust)
                            End If
                        End If
                    End If
                    
                    TBegin = XoverList(CurSeq, PermArray(x, Y)).Beginning
                    BeginAdj = CLng(TBegin * XAdj)
                    TEnd = XoverList(CurSeq, PermArray(x, Y)).Ending
                    EndAdj = CLng(TEnd * XAdj)
                    If XoverList(CurSeq, PermArray(x, Y)).Probability < LowestProb Then
                        Target = ((-Log10(XoverList(CurSeq, PermArray(x, Y)).Probability) - MaxLogPValSch) / (MinLogPValSch - MaxLogPValSch) * 1020)
                        If Target < 0 Then Target = 0
                        If Target > UBound(HeatMap, 2) Then Target = UBound(HeatMap, 2)
                        ProbCol = HeatMap(6, Target)
                    Else
                        ProbCol = 0
                    End If
                    'Call ProbColour(ProbCol)

                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= NextNo Then
                        If MaxDistSch - MinDistSch <> 0 And UBound(Distance, 1) = NextNo Then
                            If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(Distance, 1) And XoverList(CurSeq, PermArray(x, Y)).MajorP <= UBound(Distance, 1) Then
                                If CLng(((Distance(XoverList(CurSeq, PermArray(x, Y)).MinorP, XoverList(CurSeq, PermArray(x, Y)).MajorP) - MinDistSch) / (MaxDistSch - MinDistSch)) * 1020) > 0 Then
                                    Target = Int(((Distance(XoverList(CurSeq, PermArray(x, Y)).MinorP, XoverList(CurSeq, PermArray(x, Y)).MajorP) - MinDistSch) / (MaxDistSch - MinDistSch)) * 1020)
                                    If Target < 0 Then Target = 0
                                    If Target > UBound(HeatMap, 2) Then Target = UBound(HeatMap, 2)
                                    DistCol = HeatMap(6, Target)
                                Else
                                    DistCol = HeatMap(6, 1)
                                End If
                            Else
                                DistCol = HeatMap(6, 1)
                            End If
                        Else
                            DistCol = 0
                        End If
                        'Call DistColour(DistCol)

                    Else
                        DistCol = 0
                    End If

                    If TBegin < TEnd Then
                        'Draw the recombinant regions

                        If XoverList(CurSeq, PermArray(x, Y)).Accept = 2 Then
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = YAdj: Y2 = YAdj2
                            SCol(0) = Rejected: SCol(1) = Rejected: SCol(2) = Rejected: SCol(3) = Rejected
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                        Else
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = YAdj: Y2 = YAdj2
                            If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(SeqCol) Then
                                SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                SCol(0) = SeqCol(BeginPW)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV3 Then
                                SCol(0) = SeqCol(EndPW)
                            End If
                            SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                            SCol(2) = ProbCol
                            SCol(3) = DistCol
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                            'Exit Sub
                            If XoverList(CurSeq, PermArray(x, Y)).Accept = 1 Then
                                X1 = 4 + BeginAdj: X2 = 6 + EndAdj
                                Y1 = YAdj: Y2 = YAdj2
                                SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                'SBlockBak(CurSeq, CurSeq, PermArray(X, Y)) = SBlocksLen
                            End If
                            
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                            If CurSeq <= UBound(FFillCol, 1) Then
                                SCol(0) = FFillCol(CurSeq)
                            End If
                            SCol(1) = FillColour
                            SCol(2) = FillColour
                            SCol(3) = FillColour
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            'SBlockBak(CurSeq, CurSeq, PermArray(X, Y)) = SBlocksLen
                        End If

                    Else

                        If Int((x + 1) / AdjArrayPos) < TBegin Then

                            With Form1
                                'Draw the recombinant regions
                                'XX = XOverlist(CurSeq, PermArray(X, Y)).ProgramFlag
                                If XoverList(CurSeq, PermArray(x, Y)).Accept = 2 Then
                                    X1 = 5 + 1 * XAdj: X2 = 5 + EndAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    SCol(0) = Rejected
                                    SCol(1) = Rejected
                                    SCol(2) = Rejected
                                    SCol(3) = Rejected
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                                    
                                    
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    SCol(0) = Rejected
                                    SCol(1) = Rejected
                                    SCol(2) = Rejected
                                    SCol(3) = Rejected
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    
                                Else
                                    X1 = (5 + 1 * XAdj): X2 = 5 + EndAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    XX = NextNo
                                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= PermNextno Then
                                        SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    Else
                                        'SCol(0) = RGB(255, 255, 255)
                                        If DV1 > PermNextno And DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(BeginPW)
                                        ElseIf DV3 > PermNextno And DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(EndPW)
                                        Else
                                            SCol(0) = RGB(255, 255, 255)
                                        End If
                                    End If
                                    SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                                    SCol(2) = ProbCol
                                    SCol(3) = DistCol
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    'SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(SeqCol) Then
                                        SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    Else
                                        If DV1 > PermNextno And DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(BeginPW)
                                        ElseIf DV3 > PermNextno And DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(EndPW)
                                        Else
                                            SCol(0) = RGB(255, 255, 255)
                                        End If
                                    End If
                                    SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                                    SCol(2) = ProbCol
                                    SCol(3) = DistCol
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())

                                    If XoverList(CurSeq, PermArray(x, Y)).Accept = 1 Then
                                        X1 = 4 + 1 * XAdj: X2 = 6 + EndAdj
                                        Y1 = YAdj: Y2 = YAdj2
                                        SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                        Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                        
                                        X1 = 4 + BeginAdj: X2 = 6 + LSeq * XAdj
                                        Y1 = YAdj: Y2 = YAdj2
                                        SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                        Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                        
                                    End If

                                    '"Delete" the corresponding portion of the background sequence plot
                                    X1 = 5 + 1 * XAdj: X2 = 5 + EndAdj
                                    Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                                    SCol(0) = FFillCol(CurSeq)
                                    SCol(1) = FillColour
                                    SCol(2) = FillColour
                                    SCol(3) = FillColour
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                                    SCol(0) = FFillCol(CurSeq)
                                    SCol(1) = FillColour
                                    SCol(2) = FillColour
                                    SCol(3) = FillColour
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                End If

                            End With

                        End If

                    End If

                    'Print names
'                    If SuperEventList(XoverList(CurSeq, PermArray(x, Y)).Eventnumber) = 92 Then
'                        x = x
'                    End If
                    If TBegin < TEnd Or (Int((x + 1) / AdjArrayPos) < TBegin) Then
                        NameNumber = XoverList(CurSeq, PermArray(x, Y)).MinorP
                        'XX = XoverList(CurSeq, PermArray(x, Y)).MajorP
                        If NameNumber > PermNextno Then
                            If DV1 = NameNumber Then
                                NameNumber = BeginPW
                            ElseIf DV3 = NameNumber Then
                                NameNumber = EndPW
                            Else
                                NameNumber = -1
                            End If
                        
                        End If
                        If NameNumber > -1 And NameNumber <= PermNextno Then
                            If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                NameString = OriginalName(NameNumber)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                NameString = FullOName(DV0)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = (DV3) Then
                                NameString = FullOName(DV2)
                            Else
                                NameString = "Unknown"
                            End If
                            If NameNumber <= NextNo And XoverList(CurSeq, PermArray(x, Y)).OutsideFlag < 2 And Len(NameString) > 0 Then
                            
                                Extend = CLng(LSeq * (((Form1.Picture5.TextWidth("O" & NameString))) / (Frm1Pic5ScaleWidth)))
                                'Print shadows
                                '@
                                X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = 1 + YAdj
                                SCol(0) = QuaterColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                                'If ExRecFlag = 0 Then
                                    If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                        Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                    ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                        Call AddString(X1, Y1, -DV0, SCol(), SStringLen, SchemString())
                                    ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV3 Then
                                        Call AddString(X1, Y1, -DV2, SCol(), SStringLen, SchemString())
                                    End If
                                
                                'End If
                                
                                'Print Names in colour
                                    
                                If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                    X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                    If UBound(SeqCol, 1) >= NameNumber Then
                                        SCol(0) = SeqCol(NameNumber): SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                    End If
                                    'Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                    'If ExRecFlag = 0 Then
                                        If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                        ElseIf DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            Call AddString(X1, Y1, -DV0, SCol(), SStringLen, SchemString())
                                        ElseIf DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            Call AddString(X1, Y1, -DV2, SCol(), SStringLen, SchemString())
                                        End If
                                    'End If
                                End If
                            Else
                            
                            
                                Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                            
                                X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                SCol(0) = HalfColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                                Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                
    
                                If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                    'Print recombinant names in grey
                                    X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                    If UBound(SeqCol, 1) >= NameNumber Then
                                        SCol(0) = SeqCol(NameNumber): SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                    
                                    End If
                                    Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                    
                                End If
                            End If
                            

                        Else
                            Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                            
                            X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                            SCol(0) = HalfColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                            Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                            

                            If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                'Print recombinant names in grey
                                X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                If UBound(SeqCol, 1) >= NameNumber And NameNumber <> -1 Then
                                    SCol(0) = SeqCol(NameNumber)
                                Else
                                    SCol(0) = RGB(255, 255, 255) 'SeqCol(NameNumber)
                                End If
                                SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                
                            End If

                        End If
                        If CInt((TEnd + Extend) * AdjArrayPos) + 2 > x Then
                            x = CInt((TEnd + Extend) * AdjArrayPos) + 2
                        Else
                            x = x
                        End If
                        
                    Else
                        x = Frm1Pic5ScaleWidth
                    End If

                End If

            Next 'X

        End If
        If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
            ET = Abs(GetTickCount)
            If ET - ST > 500 Then
                ST = ET
                
                Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * (Y / LastDim)
                Call UpdateF2Prog
            End If
        End If
        DoEvents
        If NoAdd = 3 Then LastDim = Y
        Y = Y + 1
    Loop
    If F1MDF = 0 And F1RF = 0 Then
        
       ' Form1.ProgressBar1 = 100
    End If
    Form1.Picture6.Enabled = True
    If DebuggingFlag < 2 Then On Error Resume Next
    Dim TestVal As Double
    TestVal = (((LastDim) * 12 + 36) * SpaceAdjust) '- Form1.Picture5.ScaleHeight
    F1VS2Adj = 1
    'holderv = (((LastDim) * 12 + 20) * SpaceAdjust)
    If (TestVal - Form1.Picture5.ScaleHeight) < 32000 Then
        Form1.VScroll2.Max = TestVal - Form1.Picture5.ScaleHeight
    Else
        Form1.VScroll2.Max = 32000
        F1VS2Adj = TestVal / Form1.VScroll2.Max
    End If
'    If TestVal - CDbl(Form1.Picture5.ScaleHeight) <> Form1.VScroll2.MaX Then 'the vertical size is too big
'
'    End If
    On Error GoTo 0
    Form1.HScroll2.Max = (Form1.Picture6.Width - Form1.Picture5.ScaleWidth)
    Form1.HScroll2.LargeChange = Form1.Picture5.ScaleWidth
    P6OSize = Form1.Picture5.Width
    If Form1.VScroll2.Max > 0 Then
        Form1.VScroll2.Enabled = True
    Else
        Form1.VScroll2.Enabled = False
    End If

    Form1.HScroll2.Enabled = True
    Form1.VScroll2.LargeChange = (Form1.Picture5.Height / Screen.TwipsPerPixelY)
    Form1.VScroll2.SmallChange = 12
    
    Call SchemDrawing(SchemBlocks(), SBlocksLen, SchemString(), SStringLen, SchemFlag, OriginalName(), -Form1.VScroll2.Value, Form1.Picture6)
    
    'Exit Sub
    
    If SPF = 1 Then
        'Erase SeqProb2
            
        Dim PMa As Integer
    
        PMa = PNum - AddNum
    
        
        
    End If
    Form1.Timer1.Enabled = False
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = 0
        Form1.SSPanel1.Caption = ""
    Else
        Form1.SSPanel1.Caption = ""
    End If
    Call UpdateF2Prog
    P6Width = Form1.Picture5.Width
    
    'XX = UBound(PermArray, 2)
    
    'minimise the amount of memory being used by permarray
    ReDim Preserve PermArray(Frm1Pic5ScaleWidth, LastDim + Spos + 3)
        
    
'    eecc = Abs(GetTickCount)
'    ttcc = eecc - sscc
'
'    eeaa = Abs(GetTickCount)
'    ttaa = eeaa - SSAa '1.965 (Urmilas alignment);5.289, 4.446, 4.243, 4.305,3.260,3385, 3.026, 3136, 3198,3105, 3.697, 3.135, 3.151, 2.870,1498 with fixoverlaps for freds
'    '1466 using ISRH,1435 using unknownextend, 1420 using improvements in fixoverlaps,'1294 using fewer permarray redims
'

    Exit Sub
Ending:
    Exit Sub
RedoReDim:
    If CLine = "" Or CLine = " " Then
        Response = MsgBox("Your computer does not have enough available memory to integrate the recombination data.  Please save your results in .rdp format.  You could attempt to view the saved file by restarting your computer and try reloading the analysis results from the saved file", 48)
    End If
    Form1.Picture7.Enabled = False
    Form1.SSPanel5.Enabled = False
    Form1.Combo1.Enabled = False
     Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True

    Call EmergencySave

    Exit Sub
OutOfMemoryError:
    Exit Sub
ResizePictures:
    If CLine = "" Or CLine = " " Then
        Response = MsgBox("Your computer does not have enough available memory to fully display the recombination data.  This error is occasionally fatal so I recommend that you save your results before continuing", 48)
    End If
    LastDim = LastDim * 0.5
    Form1.Picture6.ScaleHeight = Form1.Picture5.Height

    Call EmergencySave

    GoTo RedoSizing
PictureResize:
    Return
End Sub
Public Sub IntegrateXOvers2(SPF)
    'SSAa = Abs(GetTickCount)
    
    Dim RandNumber As Single, Response As Long, Target As Long, PosX As Long, Dummy As Long, GoOn As Long, A As Long, XONCx As Variant, TVX As Variant, RN As Long, APR() As Byte, ProgDo() As Byte, UB As Long, EHold As Long, XNHold As Long, SCol(3) As Long, X1 As Long, X2 As Long, Y1 As Long, Y2 As Long, iMaskSeq() As Integer, iRevseq() As Integer, MaxSPos() As Integer, MaxXONo() As Integer, XOverNoComponent() As Integer
    Dim UTarget As Long, REnd As Long, RBegin As Long, iMask As Integer, PNum As Integer, CurSeq As Long, Extend As Long, g As Integer
    Dim DoneList() As Long, TempArray() As Integer
    Dim b As Long, Z As Long, oldY As Long, OLastDim As Long, LastDim As Long, UltimateMax As Long, TSPos As Long, Spos As Long, LSeq As Long, ProbCol As Long, DistCol As Long, x As Long, Y As Long
    'Dim TDistance() As Single
    Dim DoneThisOne As Byte, CNum As Byte
    Dim UnknownExtend As Long
    Form1.Picture5.FontSize = 6.75
    If DebuggingFlag < 2 Then On Error Resume Next
        UB = -1
        UB = UBound(XoverList, 1)
        If UB < PermNextno Then
            RunFlag = 0
            Exit Sub
            
        End If
    On Error GoTo 0
    Dim StartProgress As Single, TargetProgress As Single
    'Erase SBlockBak
    ReDim SBlockBak(UBound(XoverList, 1), UBound(XoverList, 2))
    StartProgress = Form1.ProgressBar1.Value
    TargetProgress = 100
    If PermNextno <> NextNo Then
        Call UnModNextno
    
    End If
    'Call UnModSeqNum(0)
    
    PNum = 12
    If SEventNumber = 0 Then Exit Sub
    ReDim Preserve ProgF(100)
    ReDim APR(AddNum * 2)
    
    
    
    
    For x = 0 To AddNum - 1
        If DoScans(0, x) = 1 Then
            APR(x) = 1
            APR(x + AddNum) = 1
        End If
    
    Next x
    
    
    For x = 0 To AddNum
        If ProgF(x) = 1 Then ProgF(x + AddNum) = 1
    Next x
    ReDim ProgDo(AddNum * 2, NextNo)
    'Form1.ProgressBar1.Value = 2
    Form1.Picture6.AutoRedraw = True
    'Call DoConfirm
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.SSPanel1.Caption = "Planning recombination graphs"
        Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * 0.05
    Else
        Form1.SSPanel1.Caption = "Redrawing recombination graphs"
    End If
    Call UpdateF2Prog
    Dim Frm1Pic5ScaleWidth As Long

    Frm1Pic5ScaleWidth = Form1.Picture5.ScaleWidth - 10
    LSeq = Len(StrainSeq(0))
    If Frm1Pic5ScaleWidth >= 0 Then
        If DebuggingFlag < 2 Then On Error Resume Next
            UB = 0
            UB = UBound(PermArray, 2)
            
            
        On Error GoTo 0
        If UB > 0 Then
        ReDim PermArray(0, 0)
            ReDim PermArray(Frm1Pic5ScaleWidth, UB)
        Else
            ReDim PermArray(Frm1Pic5ScaleWidth, 100)
        End If
    Else
        ReDim PermArray(0, 100)
    End If
    AdjArrayPos = (Frm1Pic5ScaleWidth) / LSeq
    ReDim iMaskSeq(NextNo)
    ReDim iRevseq(NextNo)
    Y = 0

    For x = 0 To NextNo

        If CurrentXOver(x) > 0 Then
            iMaskSeq(Y) = x
            iRevseq(x) = Y
            Y = Y + 1
        End If

    Next 'X

    iMask = Y - 1
    If iMask < 0 Then iMask = 0
    
    Dim LSAdjust As Single, XONC As Long
    If LSeq > 10000 Then
        XONC = 10000
        LSAdjust = 10000 / LSeq
    Else
        XONC = LSeq
        LSAdjust = 1
        TVX = (AddNum * 2 + 1)
        TVX = TVX * (iMask + 1)
        TVX = TVX * (XONC + 11)
        TVX = TVX * 4
        If TVX > 100000000 Then
            XONCx = (100000000 / TVX)
            XONC = LSeq * XONCx
            LSAdjust = XONC / LSeq
        End If
    End If
    'Erase XOverNoComponent
    'XX = Nextno
    ReDim XOverNoComponent(AddNum * 2, iMask, XONC + 10)
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
       
        Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * 0.1
        Call UpdateF2Prog
    End If
    
    ReDim MaxXONo(NextNo)
    'Initialise arrays (use C for this?)

    For x = 0 To iMask
        XoverList(iMaskSeq(x), 0).Probability = 1
    Next 'X
    
    
    
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.SSPanel1.Caption = "Drawing recombination graphs"
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.15
        StartProgress = Form1.ProgressBar1.Value
        Call UpdateF2Prog
    End If
    MinLogPValSch = 1
    MaxLogPValSch = 0
    ST = Abs(GetTickCount)
    Dim XoNoX As Long
    Dim MSX As Long, BProg As Byte, FProg As Byte, StartP As Byte, StartE As Long, BestEg() As Byte, BestP As Double, BestNum As Long, DoneNum() As Byte
    
    Rnd (-BSRndNumSeed)
    For x = 0 To iMask
    
            MSX = iMaskSeq(x)
            
'            If MSX = 10 Then
'                x = x
'            End If
            XoNoX = CurrentXOver(MSX)
'            If iMaskSeq(X) = 301 Then
'                X = X
'                XX = BestEvent(14, 0)
'                XX = BestEvent(14, 1)
                'XX = OriginalName(XoverList(10, 21).Daughter)
''                XX = OriginalName(301)
'            End If
            ReDim BestEg(XoNoX)
            ReDim DoneNum(XoNoX)
            'If iMaskSeq(X) = 33 Then
            '            X = X
            '        End If
            
            For Y = 1 To XoNoX
'                If MSX = 10 And (Y = 21 Or Y = 27) Then
'                    x = x
'                End If
                
                If DoneNum(Y) = 0 Then
                    If XoverList(MSX, Y).Eventnumber <= Eventnumber Then
                     'DoneNum(Y) = 1
                     StartE = SuperEventList(XoverList(MSX, Y).Eventnumber)
'                     If StartE = 14 Then
'                        x = x
'                     End If
                     
                     ''If StartE = 23 Then
                      '  ' XX = BestEvent(23, 0)
                      '  ' XX = BestEvent(23, 1)
                      '   XX = XOverList(iMaskSeq(X), Y).Beginning
                     '    XX = XOverList(iMaskSeq(X), Y).Ending
                    ' End If
                     
                     StartP = XoverList(MSX, Y).ProgramFlag
                     BestP = XoverList(MSX, Y).Probability
                     If StartE > 0 Then
                     'If iMaskSeq(X) = 275 Then
                     '            X = X
                     '        End If
                     
                         If ShowAllHits(MSX) = 0 Then
                             
                             
                             'XX = XOverList(BestEvent(StartE, 0), BestEvent(StartE, 1)).ProgramFlag
                             'If iMaskSeq(X) = BestEvent(StartE, 0) And Y = BestEvent(StartE, 1) Then
                             If BestEvent(StartE, 1) = -1 Then
                                 BestEvent(StartE, 0) = MSX: BestEvent(StartE, 1) = Y
                             End If
                            
                             If MSX = BestEvent(StartE, 0) And BestEvent(StartE, 1) <= XoNoX And BestEvent(StartE, 1) > -1 Then
                                 'Y = BestEvent(StartE, 1)
                                 FProg = 1
                                 BestNum = BestEvent(StartE, 1)
'                                 If MSX = 208 And (BestEvent(StartE, 1) = 11 Or BestEvent(StartE, 1) = 14) Then
'                                    X = X
'                                 End If
                                 DoneNum(BestEvent(StartE, 1)) = 1
                                 For A = 1 To XoNoX
                                     If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                         If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
'                                            If MSX = 208 And (A = 11 Or A = 14) Then
'                                               X = X
'                                            End If
                                             DoneNum(A) = 1
                                             
                                         End If
                                     End If
                                 Next A
                                             
                                             
                                 
                             x = x
                                 
                             Else
                                 'If iMaskSeq(X) = BestEvent(StartE, 0) Then
                                 '    BestNum = BestEvent(StartE, 1)
                                 '    DoneNum(BestEvent(StartE, 1)) = 1
                                 '    FProg = 1
                                 'End If
                                 
                                                                   
                                 BProg = XoverList(BestEvent(StartE, 0), BestEvent(StartE, 1)).ProgramFlag
                                 FProg = 0
                                 'XX = UBound(SuperEventList, 1)
                                 For Z = Y To XoNoX
                                    
                                     If DoneNum(Z) = 0 Then
                                         If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                            ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 50)
                                         End If
                                         If XoverList(MSX, Z).Eventnumber <= UBound(SuperEventList, 1) Then
                                         If XoverList(MSX, Z).Accept <> 2 And SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And APR(XoverList(MSX, Z).ProgramFlag) = 1 Then 'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                             FProg = 1
                                             BestNum = Z
                                             DoneNum(Z) = 1
'                                             If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                               X = X
'                                            End If
                                             For A = 0 To XoNoX
                                                 If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                                     If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                         DoneNum(A) = 1
'                                                         If MSX = 208 And (A = 11 Or A = 14) Then
'                                                           X = X
'                                                        End If
                                                         If XoverList(MSX, A).Probability < BestP And APR(XoverList(MSX, A).ProgramFlag) = 1 And XoverList(MSX, A).Accept <> 2 Then
                                                             FProg = 1
                                                             BestNum = A
                                                             BestP = XoverList(MSX, A).Probability
                                                         End If
                                                     End If
                                                 End If
                                             Next A
                                             Exit For
                                         End If
                                         End If
                                     End If
                                 Next Z
                                 If FProg = 0 Then
                                    For Z = Y To XoNoX
                                       
                                        If DoneNum(Z) = 0 Then
                                            If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                               ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 50)
                                            End If
                                            If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And APR(XoverList(MSX, Z).ProgramFlag) = 1 Then  'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                FProg = 1
                                                BestNum = Z
                                                DoneNum(Z) = 1
'                                                If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                                   X = X
'                                                End If
                                                For A = 0 To XoNoX
                                                    If XoverList(MSX, A).Eventnumber <= Eventnumber Then
                                                        If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                            DoneNum(A) = 1
'                                                            If MSX = 208 And (A = 11 Or A = 14) Then
'                                                               X = X
'                                                            End If
                                                            If XoverList(MSX, A).Probability < BestP And APR(XoverList(MSX, A).ProgramFlag) = 1 And XoverList(MSX, A).Accept <> 2 Then
                                                                FProg = 1
                                                                BestNum = A
                                                                BestP = XoverList(MSX, A).Probability
                                                            End If
                                                        End If
                                                    End If
                                                Next A
                                                Exit For
                                            End If
                                        End If
                                    Next Z
                                 End If
                                 If FProg = 0 Then
                                     For Z = Y To XoNoX
                                         'If SuperEventlist(XOverList(iMaskSeq(X), Z).Eventnumber) = 54 Then
                                         '    X = X
                                         '    XX = XOverList(iMaskSeq(X), A).ProgramFlag
                                         'End If
                                         If DoneNum(Z) = 0 Then
                                            If XoverList(MSX, Z).Eventnumber > UBound(SuperEventList, 1) Then
                                                ReDim Preserve SuperEventList(XoverList(MSX, Z).Eventnumber + 10)
                                            End If
                                             If XoverList(MSX, Z).Accept <> 2 And SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE Then  'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                 FProg = 1
                                                 BestNum = Z
                                                 DoneNum(Z) = 1
'                                                 If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                                   X = X
'                                                End If
                                                 For A = 0 To XoNoX
                                                    If XoverList(MSX, A).Eventnumber > UBound(SuperEventList, 1) Then
                                                        ReDim Preserve SuperEventList(XoverList(MSX, A).Eventnumber + 10)
                                                    End If
                                                     If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                         DoneNum(A) = 1
'                                                         If MSX = 208 And (A = 11 Or A = 14) Then
'                                                           X = X
'                                                        End If
                                                         If XoverList(MSX, A).Probability < BestP And XoverList(MSX, A).Accept <> 2 Then
                                                             FProg = 1
                                                             BestNum = A
                                                             BestP = XoverList(MSX, A).Probability
                                                         End If
                                                     End If
                                                 Next A
                                                 Exit For
                                             End If
                                         End If
                                     Next Z
                                 End If
                                 
                                 
                                 
                                 
                                 
                                 
                                 If FProg = 0 Then
                                     For Z = Y To XoNoX
                                         'If SuperEventlist(XOverList(iMaskSeq(X), Z).Eventnumber) = 54 Then
                                         '    X = X
                                         '    XX = XOverList(iMaskSeq(X), A).ProgramFlag
                                         'End If
                                         If DoneNum(Z) = 0 Then
                                             If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE Then    'And XOverList(iMaskSeq(X), Z).ProgramFlag = BProg Then
                                                 FProg = 1
                                                 BestNum = Z
                                                 DoneNum(Z) = 1
'                                                 If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                                   X = X
'                                                End If
                                                 For A = 0 To XoNoX
                                                     If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
                                                         DoneNum(A) = 1
                                                         If MSX = 208 And (A = 11 Or A = 14) Then
                                                           x = x
                                                        End If
                                                         If XoverList(MSX, A).Probability < BestP Then
                                                             FProg = 1
                                                             BestNum = A
                                                             BestP = XoverList(MSX, A).Probability
                                                         '    If SuperEventList(XOverlist(iMaskSeq(X), Z).Eventnumber) = 1 And iMaskSeq(X) = 8 Then
                                                         '  X = X
                                                        'End If
                                                         End If
                                                         
                                                     End If
                                                 Next A
                                                 Exit For
                                             End If
                                         End If
                                     Next Z
                                 End If
                                 
                             End If
                             
                             If FProg = 0 Then
                                'If SuperEventList(XOverlist(iMaskSeq(X), Z).Eventnumber) = 1 Then
                                '    X = X
                                'End If
                                 BestP = 1
                                 For Z = Y To XoNoX
                                     If DoneNum(Z) = 0 Then
                                         If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And XoverList(MSX, Z).Probability > 0 And XoverList(MSX, Z).Probability < BestP Then
                                             DoneNum(Z) = 1
'                                             If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                               X = X
'                                            End If
                                             FProg = 1
                                             BestNum = Z
                                             BestP = XoverList(MSX, Z).Probability
                                         End If
                                         
                                     End If
                                 Next Z
                                 For A = 0 To XoNoX
                                     If SuperEventList(XoverList(MSX, A).Eventnumber) = StartE Then
'                                        If MSX = 208 And (A = 11 Or A = 14) Then
'                                               X = X
'                                            End If
                                         DoneNum(A) = 1
                                     End If
                                 Next A
                             End If
                             BestEg(BestNum) = 1
                             
                         Else
                             DoneNum(Y) = 1
'                             If MSX = 208 And (Y = 11 Or Y = 14) Then
'                                               X = X
'                                            End If
                             BestNum = Y
                             For Z = Y + 1 To XoNoX
                                 If DoneNum(Z) = 0 Then
                                     If SuperEventList(XoverList(MSX, Z).Eventnumber) = StartE And XoverList(MSX, Z).ProgramFlag = StartP Then
                                         DoneNum(Z) = 1
'                                         If MSX = 208 And (Z = 11 Or Z = 14) Then
'                                               X = X
'                                            End If
                                         If BestP > XoverList(MSX, Z).Probability Then
                                             BestP = XoverList(MSX, Z).Probability
                                             BestNum = Z
                                         End If
                                     End If
                                 End If
                             Next Z
                             BestEg(BestNum) = 1
                         End If
                     End If
                    End If
                End If
                x = x
            Next Y
            'XX = BestEg(4)
            
            For Y = 1 To XoNoX
                If SuperEventList(XoverList(MSX, Y).Eventnumber) = 14 Then
                    x = x
                End If
                If BestEg(Y) = 1 Then
                    GoOn = 0
                    'Have enough methods detected the event?
                    If ConsensusProg > 0 Then
                        CNum = 1
                        
                        For Z = 0 To AddNum - 1
                            If XoverList(MSX, Y).ProgramFlag <> Z And XoverList(MSX, Y).ProgramFlag <> Z + AddNum And Confirm(SuperEventList(XoverList(MSX, Y).Eventnumber), Z) > 0 Then
                                CNum = CNum + 1
                            End If
                            '
                        Next
                        If CNum > ConsensusProg Then GoOn = 1
                    Else
                        GoOn = 1
                    End If
                    
                    If GoOn = 1 Then
                        'If enough methods detected the event then fit it in
                        
                        'update min/max P-vals
                        Dim CurProb As Double, CurBegin As Long, CurEnd As Long, CurProg As Long, UBXO As Long
                        CurProb = XoverList(MSX, Y).Probability
                        CurBegin = XoverList(MSX, Y).Beginning
                        CurEnd = XoverList(MSX, Y).Ending
                        CurProg = XoverList(MSX, Y).ProgramFlag
                        UBXO = UBound(XOverNoComponent, 1)
                        If CurProb < MinLogPValSch And CurProb > 0 Then
                            MinLogPValSch = XoverList(MSX, Y).Probability
                        End If
                        If CurProb < LowestProb Then
                            If CurProb > MaxLogPValSch And CurProb > 0 Then
                                MaxLogPValSch = XoverList(MSX, Y).Probability
                                
                            End If
                        End If
                        DoneThisOne = 0
                        
                        If CurBegin < CurEnd Then 'if region internal
            
                            If CurEnd > LSeq Then
            
                                If CircularFlag = 0 Then
                                    XoverList(MSX, Y).Ending = LSeq
                                Else
                                    XoverList(MSX, Y).Ending = LSeq - CurEnd
                                End If
                                CurEnd = XoverList(MSX, Y).Ending
                            End If
                            If CurProg > UBXO Then
                                XoverList(MSX, Y).ProgramFlag = CurProg - AddNum
                                CurProg = XoverList(MSX, Y).ProgramFlag
                                
                            End If
                            If CurProb > 0 Then
'                                If X = X Then
                                    Dummy = FixOverlapsP(DoneThisOne, CurBegin, CurEnd, CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                    
                                    DoneThisOne = Dummy
'                                Else
'
'                                    For Z = CurBegin To CurEnd
'
'                                        'this is just a silly way of making sure that overlapping events detected by the same method
'                                        'both get displayed
'                                        RN = Int((3 * Rnd) + 1)
'
'                                        If RN = 2 Then
'
'                                            XOverNoComponent(CurProg, X, CLng(Z * LSAdjust)) = Y
'
'                                            ProgDo(CurProg, MSX) = 1
'
'                                            If DoneThisOne = 0 Then
'                                                MaxXONo(MSX) = MaxXONo(MSX) + 1
'                                                DoneThisOne = 1
'                                            End If
'
'                                        End If
'                                            'End If
'
'
'
'                                    Next 'Z
'                                End If
                            End If
                
                        Else 'If end of region overlaps the end of the sequence
                            
                            If x = x Then
                                
                                Dummy = FixOverlapsP(DoneThisOne, 1, CurEnd, CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                DoneThisOne = Dummy
                                
                                Dummy = FixOverlapsP(DoneThisOne, CurBegin, Len(StrainSeq(0)), CurProg, x, Y, MSX, LSAdjust, UBound(ProgDo, 1), UBound(XOverNoComponent, 1), UBound(XOverNoComponent, 2), ProgDo(0, 0), XOverNoComponent(0, 0, 0), MaxXONo(0))
                                If DoneThisOne = 0 Then
                                    DoneThisOne = Dummy
                                End If
                            Else
                            
                                For Z = 1 To CurEnd
                'Exit Sub
                                    If CurProb > 0 Then
                                        
                                        'If XOverlist(MSX, XOverNoComponent(XOverlist(MSX, Y).ProgramFlag, X, CLng(Z * LSAdjust))).Probability > XOverlist(MSX, Y).Probability Or X = X Then
                                            If XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) > 0 And XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) < Y Then
                                                RandNumber = Rnd
                                                If RandNumber > 0.5 Then
                                                    XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                End If
                                            Else
                                                XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                            End If
                                            ProgDo(CurProg, MSX) = 1
                                            If DoneThisOne = 0 Then
                                                MaxXONo(MSX) = MaxXONo(MSX) + 1
                                                DoneThisOne = 1
                                            End If
                
                                        'End If
                
                                    End If
                
                                Next 'Z
                
                                For Z = CurBegin To LSeq
                
                                    If CurProb > 0 Then
                
                                        'If XOverlist(MSX, XOverNoComponent(XOverlist(iMaskSeq(X), Y).ProgramFlag, X, CLng(Z * LSAdjust))).Probability > XOverlist(iMaskSeq(X), Y).Probability Or X = X Then
                                            'XOverNoComponent(CurProg, X, CLng(Z * LSAdjust)) = Y
                                            If XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) > 0 And XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) < Y Then
                                                RandNumber = Rnd
                                                If RandNumber > 0.5 Then
                                                    XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                                End If
                                            Else
                                                XOverNoComponent(CurProg, x, CLng(Z * LSAdjust)) = Y
                                            End If
                                            ProgDo(CurProg, MSX) = 1
                                            If DoneThisOne = 0 Then
                                                MaxXONo(MSX) = MaxXONo(MSX) + 1
                                                DoneThisOne = 1
                                            End If
                
                                        'End If
                
                                    End If
                
                                Next 'Z
                            End If
                        End If 'divides internal and sequences overlapping ends
                    End If
                End If
            Next 'Y
            If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
                ET = Abs(GetTickCount)
                If ET - ST > 100 Then
                    ST = ET
                    Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * x / NextNo * 0.25
                    Call UpdateF2Prog
                End If
            End If
    Next 'X
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.4
        StartProgress = Form1.ProgressBar1.Value
        Call UpdateF2Prog
    End If
    LastDim = 0
    x = -1
    If Frm1Pic5ScaleWidth < 0 Then Exit Sub
    'Erase TempArray
    ReDim TempArray(Frm1Pic5ScaleWidth, MaxXONo(b))
    
    PosX = UBound(XOverNoComponent, 3) - 10
    
    
    
    
    UnknownExtend = CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
    For b = 0 To NextNo
        'If B = 18 Then
        '    X = X
        'End If
        Spos = 0
        UltimateMax = 0
        '
       ' If iRevseq(B) = 7 Then
       '             X = X
       '     End If
        Dim IRSH As Long
        IRSH = iRevseq(b)
        If CurrentXOver(b) > 0 Then
            ReDim TempArray(Frm1Pic5ScaleWidth, MaxXONo(b)), DoneList(CurrentXOver(b)), MaxSPos(LSeq)

            For g = 0 To AddNum * 2

                If ProgDo(g, b) = 1 Then

                    For Y = 0 To PosX
                        XNHold = XOverNoComponent(g, IRSH, Y)
                        
                        If XNHold > 0 Then
                            If DoneList(XNHold) = 0 Then
                                DoneList(XNHold) = 1
                                If XoverList(b, XNHold).MinorP <= UBound(OriginalName, 1) Then
                                    If XoverList(b, XNHold).OutsideFlag < 2 And Len(OriginalName(XoverList(b, XNHold).MinorP)) > 0 Then
                                        
                                        'extx = (LSeq * (((Form1.Picture5.TextWidth("O" & originalname(XOverList(B, XNHold).MinorP)))) / (Frm1Pic5ScaleWidth)))
                                        'Extend = CInt(extx)
                                        Extend = CLng(LSeq * (((Form1.Picture5.TextWidth("O" & OriginalName(XoverList(b, XNHold).MinorP)))) / (Frm1Pic5ScaleWidth)))
                                    Else
                                        Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                                    End If
                                Else
                                    Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                                    
                                End If
                                
                                RBegin = XoverList(b, XNHold).Beginning
                                REnd = XoverList(b, XNHold).Ending
                                
                                If RBegin = 0 Then XoverList(b, XNHold).Beginning = 1
    
                                If REnd = 0 Then XoverList(b, XNHold).Ending = LSeq
                                
                                If REnd + Extend <= LSeq Then
                                    UTarget = REnd + Extend
                                Else
                                    UTarget = LSeq
                                End If
                                
                                If RBegin < REnd Then
                                    'Find a slot
                                    Spos = FindSlot(RBegin, UTarget + 1, Spos, MaxSPos(0))
                                    
                                    If Spos > UltimateMax Then
                                        
                                        Spos = ReFindSlot(AdjArrayPos, Frm1Pic5ScaleWidth, LSeq + 1, RBegin, UTarget + 1, 0, TempArray(0, 0), MaxSPos(0))
                                        
                                    End If
    
                                    If UltimateMax < Spos Then UltimateMax = Spos
                                    'Fill it
                                    FillArray2 AdjArrayPos, XNHold, RBegin, UTarget + 1, LSeq + 1, Spos, TempArray(0, Spos), MaxSPos(0)
                                    x = x
                                    
                                Else
                                    'Find a slot
                                   
    
                                    
                                    For Z = RBegin To LSeq
    
                                        If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
                                    Next 'Z
            
                                    For Z = 1 To UTarget
            
                                        If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
                                        Z = Z + 10
                                    Next 'Z
                                    
                                  
    
                                    If Spos > UltimateMax Then
                                        
                                        If XoverList(b, XNHold).Beginning > LSeq Then
                                            XoverList(b, XNHold).Beginning = 1
                                        End If
                                        Z = XoverList(b, XNHold).Beginning
                                        TSPos = 0
                                        
                                        Do
                                            
                                            If TempArray(CInt(Z * AdjArrayPos), TSPos) <> 0 Then
                                                TSPos = TSPos + 1
                                                Z = RBegin
                                            End If
    
                                            Z = Z + 1
                                        Loop While Z <= LSeq - 10
    
                                        Z = 1
                                        EHold = XoverList(b, XNHold).Ending - 10 + Extend
                                        Do
    
                                            If TempArray(CInt(Z * AdjArrayPos), TSPos) <> 0 Then
                                                TSPos = TSPos + 1
                                                Z = 1
                                            End If
    
                                            Z = Z + 1
                                            If Z > EHold Then
                                                Exit Do
                                            ElseIf Z > LSeq - 10 Then
                                                Exit Do
                                            End If
                                            
                                        Loop
    
                                        Spos = TSPos
                                    End If
    
                                    If UltimateMax < Spos Then UltimateMax = Spos
                                    
                                    Z = XoverList(b, XNHold).Beginning
                                    
                                    Do
                                        
                                        TempArray(CInt(Z * AdjArrayPos), Spos) = XNHold
    
                                        If Spos >= MaxSPos(Z) Then MaxSPos(Z) = Spos + 1
                                        Z = Z + 1
                                        If Z > LSeq Then Exit Do
                                    Loop
    
                                    Z = 1
                                    EHold = XoverList(b, XNHold).Ending + Extend
                                    Do
                                        If Z > EHold Then
                                            Exit Do
                                        ElseIf Z > LSeq Then
                                            Exit Do
                                        End If
                                        
                                        TempArray(CInt(Z * AdjArrayPos), Spos) = XNHold
    
                                        If Spos >= MaxSPos(Z) Then MaxSPos(Z) = Spos + 1
                                        
                                        Z = Z + 1
                                        
                                    Loop
                                    
                                End If
                            End If
                            
                        End If
                        
                    Next 'Y

                End If

            Next 'G

            For Z = 0 To LSeq Step 20

                If MaxSPos(Z) > Spos Then Spos = MaxSPos(Z)
            Next 'Z

        End If

        'Copies Temparray data into Permarray
        UB = UBound(PermArray, 2)
        If LastDim + Spos + 3 > UB Then
            ReDim Preserve PermArray(Frm1Pic5ScaleWidth, LastDim + Spos + 3 + 400)
            
        End If
        'Encode the first y column with sequence info
        ModPermArray Frm1Pic5ScaleWidth, UB, LastDim, Spos, b, PermArray(0, 0), TempArray(0, 0)
        
        LastDim = LastDim + Spos + 2
        If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
            ET = Abs(GetTickCount)
            If ET - ST > 400 Then
                ST = ET
                Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * b / NextNo * 0.5
                Call UpdateF2Prog
            End If
        End If
    Next 'B
    
    '3.445,3.555,3.465
    '3.365 with modpermarray
    '541 with prodo
    LastDim = LastDim - 1
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = StartProgress + (TargetProgress - StartProgress) * 0.9
        StartProgress = Form1.ProgressBar1.Value
        Form1.SSPanel1.Caption = "Drawing recombination graphs"
        Call UpdateF2Prog
    End If
    'Do Calcs for colour Schemes
    'Do Calcs for Prob colour schemes

    If MaxLogPValSch < LowestProb Then MaxLogPValSch = -Log10(LowestProb)

    If MinLogPValSch > 0 Then
        MinLogPValSch = -Log10(MinLogPValSch)
    Else
        MinLogPValSch = 999
    End If

    'Do Calcs for ID colour schemes
    MaxDistSch = -10
    MinDistSch = 10
    'If necessary work out distances between sequences

    If DistanceFlag = 0 Then  'If distancematrix not yet calculated and if a "spacer" is required
        
        Call CalcDistances(SeqNum(), AvDst, Decompress(), PermDIffs(), PermValid(), NextNo, Distance(), 0, 0)

    
    End If
    'Erase TDistance
    'ReDim TDistance(Nextno, Nextno)
    
    
    'ssbb = Abs(GetTickCount)
    
'    If X = X Then
        'Dummy = CopyDistandFindMinMax(Nextno, UBound(TDistance, 1), UBound(Distance, 1), MaxDistSch, MinDistSch, TDistance(0, 0), Distance(0, 0))
        Dummy = CopyDistandFindMinMax(NextNo, UBound(Distance, 1), UBound(Distance, 1), MaxDistSch, MinDistSch, Distance(0, 0), Distance(0, 0))
        'X = X
'    Else
'        For X = 0 To Nextno
'
'            For Y = X + 1 To Nextno
'                If Y <= UBound(Distance, 2) Then
'                    TDistance(X, Y) = Distance(X, Y)
'                    TDistance(Y, X) = TDistance(X, Y)
'
'                    If TDistance(X, Y) > MaxDistSch Then
'                        MaxDistSch = TDistance(X, Y)
'                    End If
'
'                    If TDistance(X, Y) < MinDistSch Then
'                        MinDistSch = TDistance(X, Y)
'                    End If
'
'                Else
'                    Exit For
'                End If
'
'            Next 'Y
'
'        Next 'X
'    End If
'    eebb = Abs(GetTickCount)
'    ttbb = eebb - ssbb '0.343 for freds'1.154 for urmillas' 0.032 for fred
    
    x = x
    
    'sscc = Abs(GetTickCount)
    OLastDim = LastDim
    Form1.SSPanel5.Enabled = True
    SpaceAdjust = 1 '  F1VS2Adj)
    

    
    
    Form1.Picture5.ScaleMode = 3
    Form1.Picture6.DrawMode = 13
    
    'Try to get the picturebox to the correvt size

    If CurrentXOver(NextNo) = 0 Then
        LastDim = LastDim + 2
    Else
        LastDim = LastDim + 2
    End If

    Form1.Picture6.Height = Form1.Picture5.ScaleHeight
    
    'ReDim Preserve originalname(NextNo + 1)
    'originalname(NextNo + 1) = "Unknown"
    ReDim SchemBlocks(3, 4, 100), SchemString(3, 3, 100)
    SBlocksLen = -1: SStringLen = -1
    LastDim = OLastDim
    Form1.Picture5.BackColor = BackColours
    Form1.Picture6.BackColor = BackColours
    Form1.Picture6.Left = 0
    'Test to make sure pictureboxes can be drawn onto
    X1 = 5: Y1 = 3 * SpaceAdjust
    SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
    Call AddString(X1, Y1, 0, SCol(), SStringLen, SchemString())
    X1 = 5 + 1: Y1 = 3 * SpaceAdjust + 1
    SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
    Call AddString(X1, Y1, 0, SCol(), SStringLen, SchemString())
    
    X1 = 5: X2 = 5 + LSeq * (Frm1Pic5ScaleWidth) / LSeq
    Y1 = 15 * SpaceAdjust: Y2 = 25 * SpaceAdjust
    SCol(0) = SeqCol(0)
    SCol(1) = QuaterColour
    SCol(2) = QuaterColour
    SCol(3) = QuaterColour
    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
    SBlockBak(0, 0) = SBlocksLen
RedoSizing:

    Dim YAdj As Single, YAdj2 As Single
    Dim XAdj As Single
    Dim TBegin As Long, TEnd As Long
    Dim BeginAdj As Integer, EndAdj As Integer

    XAdj = (Frm1Pic5ScaleWidth) / LSeq
    CurSeq = 0
    oldY = 1
    Dim DV0 As Long, DV1 As Long, DV2 As Long, DV3 As Long, BeginPW As Long, EndPW As Long
    Dim NameNumber As Long, NameString As String, PAV As Long, FirstSet As Long
    Call SplitP(-XoverList(RelX, RelY).BeginP, DV0, DV1)
    Y = 2
    FirstSet = 0
    Dim AlreadyDone() As Byte
    ReDim AlreadyDone(Eventnumber)
    Do While Y <= LastDim
        YAdj = Int((Y * 12 + 3) * SpaceAdjust)
        YAdj2 = Int((Y * 12 + 13) * SpaceAdjust)
        
        If PermArray(0, Y) > 0 Then 'This is the name line
            
            CurSeq = PermArray(0, Y)
            If CurSeq > PermNextno Then
                CurSeq = TreeTrace(CurSeq)
            End If
            X1 = 5: Y1 = YAdj
            SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
            Call AddString(X1, Y1, CurSeq, SCol(), SStringLen, SchemString())
            X1 = 5 + 1: Y1 = YAdj + 1
            SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
            Call AddString(X1, Y1, CurSeq, SCol(), SStringLen, SchemString())
                
        ElseIf PermArray(0, Y) < 0 Then 'This is the main sequence block line
            ReDim AlreadyDone(Eventnumber)
            X1 = 5: X2 = 5 + LSeq * XAdj
            Y1 = YAdj: Y2 = ((Y + 1) * 12 + 1)
            'XX = Y2 - Y1
            If UBound(SeqCol, 1) >= CurSeq Then
                SCol(0) = SeqCol(CurSeq): SCol(1) = QuaterColour: SCol(2) = QuaterColour: SCol(3) = QuaterColour
            End If
            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
            
            SBlockBak(CurSeq, 0) = SBlocksLen
            oldY = Y
            FirstSet = 1
        Else

            For x = 1 To Frm1Pic5ScaleWidth
                    
                If PermArray(x, Y) > 0 Then
                    
'                    If SuperEventList(XoverList(CurSeq, PermArray(x, Y)).Eventnumber) = 558 Then
'                        x = x
'                    End If
                    DV0 = 0: DV1 = 0: DV2 = 0: DV3 = 0: BeginPW = -1: EndPW = -1
                    If ExcludedEventNum > 0 Then
                        FirstSet = 0
                        If FirstSet = 1 Then 'make sure to do all the vents where curseq is the daughter frst
                        
                        Else
                            If XoverList(CurSeq, PermArray(x, Y)).BeginP < 0 Then
                                Call SplitP(-XoverList(CurSeq, PermArray(x, Y)).BeginP, DV0, DV1)
                                BeginPW = WhereIsExclude(DV0)
                            End If
                            If XoverList(CurSeq, PermArray(x, Y)).EndP < 0 Then
                                Call SplitP(-XoverList(CurSeq, PermArray(x, Y)).EndP, DV2, DV3)
                                EndPW = WhereIsExclude(DV2)
                            End If
                            '''''''''''''''''''''''''''''''''''''''''
                            'Test faking a sequence
                            ''''''''''''''''''''''''''''''''''''''''
                            If XoverList(CurSeq, PermArray(x, Y)).BeginP < 0 And XoverList(CurSeq, PermArray(x, Y)).Daughter <> CurSeq And AlreadyDone(PermArray(x, Y)) = 0 Then
                                PAV = PermArray(x, Y)
                                AlreadyDone(PermArray(x, Y)) = 1
                                ReDim Preserve PermArray(UBound(PermArray, 1), UBound(PermArray, 2) + 3)
                                
                                'Open up three rows of space in permarray
                                For A = LastDim To Y Step -1
'                                    If PermArray(0, A) = 1 Then
'                                        x = x
'                                    End If
                                    For b = 0 To UBound(PermArray, 1)
                                        PermArray(b, A + 3) = PermArray(b, A)
                                    Next b
                                Next A
                                
                                LastDim = LastDim + 3
                                Dim tCurseq As Long
                                If DV1 = XoverList(CurSeq, PermArray(x, Y)).Daughter Then
                                    tCurseq = -DV0
                                ElseIf DV2 = XoverList(CurSeq, PermArray(x, Y)).Daughter Then
                                    tCurseq = -DV2
                                End If
                                
                                YAdj = Int(((Y + 1) * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int(((Y + 1) * 12 + 13) * SpaceAdjust)
                                
                                X1 = 5: Y1 = YAdj
                                SCol(0) = ThreeQuaterColour: SCol(1) = ThreeQuaterColour: SCol(2) = ThreeQuaterColour: SCol(3) = ThreeQuaterColour
                                Call AddString(X1, Y1, tCurseq, SCol(), SStringLen, SchemString())
                                X1 = 5 + 1: Y1 = YAdj + 1
                                SCol(0) = 0: SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                Call AddString(X1, Y1, tCurseq, SCol(), SStringLen, SchemString())
                                
                                YAdj = Int(((Y + 2) * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int(((Y + 2) * 12 + 13) * SpaceAdjust)
                                
                                X1 = 5: X2 = 5 + LSeq * XAdj
                                Y1 = YAdj: Y2 = YAdj + 10
                                If DV1 = XoverList(CurSeq, PermArray(x, Y)).Daughter And BeginPW >= 0 Then
                                    SCol(0) = SeqCol(BeginPW)
                                ElseIf DV2 = XoverList(CurSeq, PermArray(x, Y)).Daughter And EndPW >= 0 Then
                                    SCol(0) = SeqCol(EndPW)
                                Else
                                    SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).Daughter)
                                End If
                                SCol(1) = QuaterColour: SCol(2) = QuaterColour: SCol(3) = QuaterColour
                                
                                Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                
                                SBlockBak(CurSeq, 0) = SBlocksLen
                                For A = Y To Y + 2
                                    For b = 0 To UBound(PermArray, 1)
                                        PermArray(b, A) = 0
                                        
                                    Next b
                                Next A
                                oldY = Y + 2
                                Y = Y + 3
                                YAdj = Int((Y * 12 + 3) * SpaceAdjust)
                                YAdj2 = Int((Y * 12 + 13) * SpaceAdjust)
                            End If
                        End If
                    End If
                    
                    TBegin = XoverList(CurSeq, PermArray(x, Y)).Beginning
                    BeginAdj = CLng(TBegin * XAdj)
                    TEnd = XoverList(CurSeq, PermArray(x, Y)).Ending
                    EndAdj = CLng(TEnd * XAdj)
                    If XoverList(CurSeq, PermArray(x, Y)).Probability < LowestProb Then
                        Target = ((-Log10(XoverList(CurSeq, PermArray(x, Y)).Probability) - MaxLogPValSch) / (MinLogPValSch - MaxLogPValSch) * 1020)
                        If Target < 0 Then Target = 0
                        If Target > UBound(HeatMap, 2) Then Target = UBound(HeatMap, 2)
                        ProbCol = HeatMap(6, Target)
                    Else
                        ProbCol = 0
                    End If
                    'Call ProbColour(ProbCol)

                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= NextNo Then
                        If MaxDistSch - MinDistSch <> 0 And UBound(Distance, 1) = NextNo Then
                            If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(Distance, 1) And XoverList(CurSeq, PermArray(x, Y)).MajorP <= UBound(Distance, 1) Then
                                If CLng(((Distance(XoverList(CurSeq, PermArray(x, Y)).MinorP, XoverList(CurSeq, PermArray(x, Y)).MajorP) - MinDistSch) / (MaxDistSch - MinDistSch)) * 1020) > 0 Then
                                    Target = Int(((Distance(XoverList(CurSeq, PermArray(x, Y)).MinorP, XoverList(CurSeq, PermArray(x, Y)).MajorP) - MinDistSch) / (MaxDistSch - MinDistSch)) * 1020)
                                    If Target < 0 Then Target = 0
                                    If Target > UBound(HeatMap, 2) Then Target = UBound(HeatMap, 2)
                                    DistCol = HeatMap(6, Target)
                                Else
                                    DistCol = HeatMap(6, 1)
                                End If
                            Else
                                DistCol = HeatMap(6, 1)
                            End If
                        Else
                            DistCol = 0
                        End If
                        'Call DistColour(DistCol)

                    Else
                        DistCol = 0
                    End If

                    If TBegin < TEnd Then
                        'Draw the recombinant regions

                        If XoverList(CurSeq, PermArray(x, Y)).Accept = 2 Then
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = YAdj: Y2 = YAdj2
                            SCol(0) = Rejected: SCol(1) = Rejected: SCol(2) = Rejected: SCol(3) = Rejected
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                        Else
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = YAdj: Y2 = YAdj2
                            If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(SeqCol) Then
                                SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                SCol(0) = SeqCol(BeginPW)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV3 Then
                                SCol(0) = SeqCol(EndPW)
                            End If
                            SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                            SCol(2) = ProbCol
                            SCol(3) = DistCol
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                            'Exit Sub
                            If XoverList(CurSeq, PermArray(x, Y)).Accept = 1 Then
                                X1 = 4 + BeginAdj: X2 = 6 + EndAdj
                                Y1 = YAdj: Y2 = YAdj2
                                SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                'SBlockBak(CurSeq, CurSeq, PermArray(X, Y)) = SBlocksLen
                            End If
                            
                            X1 = 5 + BeginAdj: X2 = 5 + EndAdj
                            Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                            If CurSeq <= UBound(FFillCol, 1) Then
                                SCol(0) = FFillCol(CurSeq)
                            End If
                            SCol(1) = FillColour
                            SCol(2) = FillColour
                            SCol(3) = FillColour
                            Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                            'SBlockBak(CurSeq, CurSeq, PermArray(X, Y)) = SBlocksLen
                        End If

                    Else

                        If Int((x + 1) / AdjArrayPos) < TBegin Then

                            With Form1
                                'Draw the recombinant regions
                                'XX = XOverlist(CurSeq, PermArray(X, Y)).ProgramFlag
                                If XoverList(CurSeq, PermArray(x, Y)).Accept = 2 Then
                                    X1 = 5 + 1 * XAdj: X2 = 5 + EndAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    SCol(0) = Rejected
                                    SCol(1) = Rejected
                                    SCol(2) = Rejected
                                    SCol(3) = Rejected
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                                    
                                    
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    SCol(0) = Rejected
                                    SCol(1) = Rejected
                                    SCol(2) = Rejected
                                    SCol(3) = Rejected
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    
                                Else
                                    X1 = (5 + 1 * XAdj): X2 = 5 + EndAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    XX = NextNo
                                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= PermNextno Then
                                        SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    Else
                                        'SCol(0) = RGB(255, 255, 255)
                                        If DV1 > PermNextno And DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(BeginPW)
                                        ElseIf DV3 > PermNextno And DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(EndPW)
                                        Else
                                            SCol(0) = RGB(255, 255, 255)
                                        End If
                                    End If
                                    SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                                    SCol(2) = ProbCol
                                    SCol(3) = DistCol
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    SBlockBak(CurSeq, PermArray(x, Y)) = SBlocksLen
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = YAdj: Y2 = YAdj2
                                    'SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    If XoverList(CurSeq, PermArray(x, Y)).MinorP <= UBound(SeqCol) Then
                                        SCol(0) = SeqCol(XoverList(CurSeq, PermArray(x, Y)).MinorP)
                                    Else
                                        If DV1 > PermNextno And DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(BeginPW)
                                        ElseIf DV3 > PermNextno And DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                            SCol(0) = SeqCol(EndPW)
                                        Else
                                            SCol(0) = RGB(255, 255, 255)
                                        End If
                                    End If
                                    SCol(1) = ProgColour(XoverList(CurSeq, PermArray(x, Y)).ProgramFlag)
                                    SCol(2) = ProbCol
                                    SCol(3) = DistCol
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())

                                    If XoverList(CurSeq, PermArray(x, Y)).Accept = 1 Then
                                        X1 = 4 + 1 * XAdj: X2 = 6 + EndAdj
                                        Y1 = YAdj: Y2 = YAdj2
                                        SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                        Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                        
                                        X1 = 4 + BeginAdj: X2 = 6 + LSeq * XAdj
                                        Y1 = YAdj: Y2 = YAdj2
                                        SCol(0) = -1: SCol(1) = -1: SCol(2) = -1: SCol(3) = -1
                                        Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                        
                                    End If

                                    '"Delete" the corresponding portion of the background sequence plot
                                    X1 = 5 + 1 * XAdj: X2 = 5 + EndAdj
                                    Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                                    SCol(0) = FFillCol(CurSeq)
                                    SCol(1) = FillColour
                                    SCol(2) = FillColour
                                    SCol(3) = FillColour
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                    
                                    X1 = 5 + BeginAdj: X2 = 5 + LSeq * XAdj
                                    Y1 = ((oldY) * 12 + 3) * SpaceAdjust: Y2 = (oldY * 12 + 13) * SpaceAdjust
                                    SCol(0) = FFillCol(CurSeq)
                                    SCol(1) = FillColour
                                    SCol(2) = FillColour
                                    SCol(3) = FillColour
                                    Call AddBlock(X1, Y1, X2, Y2, SCol(), SBlocksLen, SchemBlocks())
                                End If

                            End With

                        End If

                    End If

                    'Print names
'                    If SuperEventList(XoverList(CurSeq, PermArray(x, Y)).Eventnumber) = 92 Then
'                        x = x
'                    End If
                    If TBegin < TEnd Or (Int((x + 1) / AdjArrayPos) < TBegin) Then
                        NameNumber = XoverList(CurSeq, PermArray(x, Y)).MinorP
                        'XX = XoverList(CurSeq, PermArray(x, Y)).MajorP
                        If NameNumber > PermNextno Then
                            If DV1 = NameNumber Then
                                NameNumber = BeginPW
                            ElseIf DV3 = NameNumber Then
                                NameNumber = EndPW
                            Else
                                NameNumber = -1
                            End If
                        
                        End If
                        If NameNumber > -1 And NameNumber <= PermNextno Then
                            If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                NameString = OriginalName(NameNumber)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                NameString = FullOName(DV0)
                            ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = (DV3) Then
                                NameString = FullOName(DV2)
                            Else
                                NameString = "Unknown"
                            End If
                            If NameNumber <= NextNo And XoverList(CurSeq, PermArray(x, Y)).OutsideFlag < 2 And Len(NameString) > 0 Then
                            
                                Extend = CLng(LSeq * (((Form1.Picture5.TextWidth("O" & NameString))) / (Frm1Pic5ScaleWidth)))
                                'Print shadows
                                '@
                                X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = 1 + YAdj
                                SCol(0) = QuaterColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                                
                                If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                    Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV1 Then
                                    Call AddString(X1, Y1, -DV0, SCol(), SStringLen, SchemString())
                                ElseIf XoverList(CurSeq, PermArray(x, Y)).MinorP = DV3 Then
                                    Call AddString(X1, Y1, -DV2, SCol(), SStringLen, SchemString())
                                End If
                                
                                
                                
                                'Print Names in colour
                                    
                                If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                    X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                    If UBound(SeqCol, 1) >= NameNumber Then
                                        SCol(0) = SeqCol(NameNumber): SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                    End If
                                    'Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                    If DV1 <> XoverList(CurSeq, PermArray(x, Y)).MinorP And DV3 <> XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                        Call AddString(X1, Y1, NameNumber, SCol(), SStringLen, SchemString())
                                    ElseIf DV1 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                        Call AddString(X1, Y1, -DV0, SCol(), SStringLen, SchemString())
                                    ElseIf DV3 = XoverList(CurSeq, PermArray(x, Y)).MinorP Then
                                        Call AddString(X1, Y1, -DV2, SCol(), SStringLen, SchemString())
                                    End If
                                    
                                End If
                            Else
                            
                            
                                Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                            
                                X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                SCol(0) = HalfColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                                Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                
    
                                If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                    'Print recombinant names in grey
                                    X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                    If UBound(SeqCol, 1) >= NameNumber Then
                                        SCol(0) = SeqCol(NameNumber): SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                    
                                    End If
                                    Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                    
                                End If
                            End If
                            

                        Else
                            Extend = UnknownExtend 'CLng(LSeq * (Form1.Picture5.TextWidth("OUnknown") / (Frm1Pic5ScaleWidth)))
                            
                            X1 = 3 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                            SCol(0) = HalfColour: SCol(1) = HalfColour: SCol(2) = HalfColour: SCol(3) = HalfColour
                            Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                            

                            If XoverList(CurSeq, PermArray(x, Y)).Accept <> 2 Then
                                'Print recombinant names in grey
                                X1 = 2 + Int(1 + (5 + EndAdj)): Y1 = YAdj
                                If UBound(SeqCol, 1) >= NameNumber And NameNumber <> -1 Then
                                    SCol(0) = SeqCol(NameNumber)
                                Else
                                    SCol(0) = RGB(255, 255, 255) 'SeqCol(NameNumber)
                                End If
                                SCol(1) = 0: SCol(2) = 0: SCol(3) = 0
                                Call AddString(X1, Y1, NextNo + 1, SCol(), SStringLen, SchemString())
                                
                            End If

                        End If
                        If CInt((TEnd + Extend) * AdjArrayPos) + 2 > x Then
                            x = CInt((TEnd + Extend) * AdjArrayPos) + 2
                        Else
                            x = x
                        End If
                        
                    Else
                        x = Frm1Pic5ScaleWidth
                    End If

                End If

            Next 'X

        End If
        If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
            ET = Abs(GetTickCount)
            If ET - ST > 500 Then
                ST = ET
                
                Form1.ProgressBar1 = StartProgress + (TargetProgress - StartProgress) * (Y / LastDim)
                Call UpdateF2Prog
            End If
        End If
        DoEvents
        Y = Y + 1
    Loop
    If F1MDF = 0 And F1RF = 0 Then
        
       ' Form1.ProgressBar1 = 100
    End If
    Form1.Picture6.Enabled = True
    If DebuggingFlag < 2 Then On Error Resume Next
    Dim TestVal As Double
    TestVal = (((LastDim) * 12 + 36) * SpaceAdjust) '- Form1.Picture5.ScaleHeight
    F1VS2Adj = 1
    'holderv = (((LastDim) * 12 + 20) * SpaceAdjust)
    If (TestVal - Form1.Picture5.ScaleHeight) < 32000 Then
        Form1.VScroll2.Max = TestVal - Form1.Picture5.ScaleHeight
    Else
        Form1.VScroll2.Max = 32000
        F1VS2Adj = TestVal / Form1.VScroll2.Max
    End If
'    If TestVal - CDbl(Form1.Picture5.ScaleHeight) <> Form1.VScroll2.MaX Then 'the vertical size is too big
'
'    End If
    On Error GoTo 0
    Form1.HScroll2.Max = (Form1.Picture6.Width - Form1.Picture5.ScaleWidth)
    Form1.HScroll2.LargeChange = Form1.Picture5.ScaleWidth
    P6OSize = Form1.Picture5.Width
    If Form1.VScroll2.Max > 0 Then
        Form1.VScroll2.Enabled = True
    Else
        Form1.VScroll2.Enabled = False
    End If

    Form1.HScroll2.Enabled = True
    Form1.VScroll2.LargeChange = (Form1.Picture5.Height / Screen.TwipsPerPixelY)
    Form1.VScroll2.SmallChange = 12
    
    Call SchemDrawing(SchemBlocks(), SBlocksLen, SchemString(), SStringLen, SchemFlag, OriginalName(), -Form1.VScroll2.Value, Form1.Picture6)
    
    'Exit Sub
    
    If SPF = 1 Then
        'Erase SeqProb2
            
        Dim PMa As Integer
    
        PMa = PNum - AddNum
    
        
        
    End If
    Form1.Timer1.Enabled = False
    If F1MDF = 0 And F1RF = 0 And UpdateProgressBar = 0 Then
        Form1.ProgressBar1.Value = 0
        Form1.SSPanel1.Caption = ""
    Else
        Form1.SSPanel1.Caption = ""
    End If
    Call UpdateF2Prog
    P6Width = Form1.Picture5.Width
    
    'XX = UBound(PermArray, 2)
    
    'minimise the amount of memory being used by permarray
    ReDim Preserve PermArray(Frm1Pic5ScaleWidth, LastDim + Spos + 3)
        
    
'    eecc = Abs(GetTickCount)
'    ttcc = eecc - sscc
'
'    eeaa = Abs(GetTickCount)
'    ttaa = eeaa - SSAa '1.965 (Urmilas alignment);5.289, 4.446, 4.243, 4.305,3.260,3385, 3.026, 3136, 3198,3105, 3.697, 3.135, 3.151, 2.870,1498 with fixoverlaps for freds
'    '1466 using ISRH,1435 using unknownextend, 1420 using improvements in fixoverlaps,'1294 using fewer permarray redims
'

    Exit Sub
Ending:
    Exit Sub
RedoReDim:
    If CLine = "" Or CLine = " " Then
        Response = MsgBox("Your computer does not have enough available memory to integrate the recombination data.  Please save your results in .rdp format.  You could attempt to view the saved file by restarting your computer and try reloading the analysis results from the saved file", 48)
    End If
    Form1.Picture7.Enabled = False
    Form1.SSPanel5.Enabled = False
    Form1.Combo1.Enabled = False
     Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True

    Call EmergencySave

    Exit Sub
OutOfMemoryError:
    Exit Sub
ResizePictures:
    If CLine = "" Or CLine = " " Then
        Response = MsgBox("Your computer does not have enough available memory to fully display the recombination data.  This error is occasionally fatal so I recommend that you save your results before continuing", 48)
    End If
    LastDim = LastDim * 0.5
    Form1.Picture6.ScaleHeight = Form1.Picture5.Height

    Call EmergencySave

    GoTo RedoSizing
PictureResize:
    Return
End Sub
Public Sub DistColour(DistCol As Long)
    'Translates a distance into a colour somewhere between white through red/purple to black

    Dim RCol As Integer, GCol As Integer, BCol As Integer

    If DistCol > 510 Then
        RCol = 255
        GCol = 255
        BCol = DistCol - 510
    ElseIf DistCol > 255 Then
        RCol = 255
        GCol = DistCol - 255
        BCol = 0
    ElseIf DistCol > 0 Then
        RCol = DistCol
        GCol = 0
        BCol = 0
    Else
        RCol = 0
        GCol = 0
        BCol = 0
    End If

    DistCol = RGB(RCol, BCol, GCol)
End Sub
Public Sub ProbColour(ProbCol As Long)
    'Translates a probability value into a colour somewhere between white through red/purple to black

    Dim RCol As Integer, GCol As Integer, BCol As Integer

    If ProbCol < 0 Then ProbCol = 0

    If ProbCol > 765 Then ProbCol = 765

    If ProbCol > 510 Then
        RCol = 255
        GCol = 255
        BCol = Int(ProbCol) - 510
    ElseIf ProbCol > 255 Then
        RCol = 255
        GCol = Int(ProbCol) - 255
        BCol = 0
    Else
        RCol = Int(ProbCol)
        GCol = 0
        BCol = 0
    End If

    If RCol < 0 Then RCol = 0
    XXX = RGB(RCol, BCol, GCol)
    ProbCol = RGB(RCol, BCol, GCol)
End Sub

Public Sub EmergencySave()

    Dim MissF As String
    
    If CLine = "" Or CLine = " " Then
        'Dim SFName As String

        With Form1.CommonDialog1
            .FileName = ""
            '.InitDir = currentdir
            .DefaultExt = ".rdp"   'Specify the default extension.
            'Specify which file extensions will be preferred.
            '.Filter = "DNA Man Multiple Alignment Files (*.msd)|*.msd|Alignment Files (*.ali)|*.ali|RDP Project Files (*.rdp)|*.rdp|Sequence Files (*.seq)|*.seq|all files (*.*)|*.*"
            .Filter = "RDP Project File (*.rdp)|*.rdp|Recombination Data in Text File (*.txt)|*.txt"
            '.InitDir = "c:/darren/DNA Man/msvstrai/dna project/"
            .Action = 2 'Specify that the "open file" action is required.
            sFName$ = .FileName  'Stores selected file name in the
            'string, fname$.
        End With

        If sFName$ = "" Then Exit Sub
        Screen.MousePointer = 11
        
        If Right$(sFName$, 4) = ".rdp" Or Right$(sFName$, 4) = ".RDP" Then

            If DoScans(0, 1) = 1 Then
                Open GCOFile For Binary Access Read As #1
                gcout$ = String$(LOF(1), " ")
                Get #1, 1, gcout$
                Close #1
            End If

            Open sFName$ For Output As #1
            SaveFlag = 1
            'Print #1, SeqFile

            For x = 0 To NextNo
                Print #1, ">" & OriginalName(x)
                Print #1, StrainSeq(x)
            Next 'X

            Print #1, "GB Data"
            Print #1, GBFile
            Write #1, "Recombination Data"
            Write #1, "r16"
            Write #1, pSpacerFlag, pCircularFlag, ShowPlotFlag, GPerms, PermTypeFlag, pXOverWindowX, LowestProb, MCFlag
            Write #1, SHWinLen, pGCIndelFlag, SHStep, pGCTripletflag
            Write #1, GCOutfileName
            Write #1, BSTreeStrat, BSupTest, GCSortFlag, GCTractLen, GCLogFlag
            Write #1, pGCMissmatchPen, SCHEMADistCO, SCHEMAPermNo, pGCMinFragLen, pGCMinPolyInFrag
            Write #1, pGCMinPairScore, pGCMaxOverlapFrags, ConservativeGroup, MaxTemperature, ntType
            Write #1, pBSStepWin, pBSStepSize, pBSCutoff, pBSBootReps, BSRndNumSeed, BSSubModelFlag
            Write #1, BSTTRatio, MCMCUpdates, BlockPen, StartRho, MatPermNo
            Write #1, DoScans(1, 2), DoScans(1, 5), FreqCo, MatWinSize, FreqCoMD
            Write #1, AllowConflict, 0, pMCSteplen, pMCWinSize
            Write #1, pDoScans(0, 0), pDoScans(0, 1), pDoScans(0, 2), pDoScans(0, 3), pDoScans(0, 4), pDoScans(0, 5)
            Write #1, FileList(1), FileList(2), FileList(3), FileList(4)
            Write #1, LRDModel, LRDCategs, LRDShape, LRDTvRat, LRDACCoeff, LRDAGCoeff, LRDATCoeff, LRDCGCoeff, LRDCTCoeff, LRDGTCoeff
            Write #1, LRDBaseFreqFlag, LRDAFreq, LRDCFreq, LRDGFreq, LRDTFreq, LRDCodon1, LRDCodon2, LRDCodon3, LRDStep, LRDRegion
            Write #1, pMCWinFract, pMCProportionFlag, pMCTripletFlag, pMCStripGapsFlag, MCFullOR, MCFullOL
            Write #1, DPModelFlag, DPWindow, DPStep, DPTVRatio, DPBFreqFlag, DPBFreqA, DPBFreqC, DPBFreqG, DPBFreqT
            Write #1, VisRDWin, ModelTestFlag
            Write #1, TOWinLen, TOStepSize, TOSmooth, TOTvTs, TOPower, TORndNum
            Write #1, TOPerms, TOPValCOff, TOFreqA, TOFreqC, TOFreqG, TOFreqT
            Write #1, TOTreeType, TOFreqFlag, TOModel
            Write #1, pBSTypeFlag, BSFreqFlag, BSFreqA, BSFreqC, BSFreqG, BSFreqT
            Write #1, GCFlag, BSCoeffVar, DPCoeffVar, TOCoeffVar
            Write #1, TBSReps, TRndSeed, TTVRat, TModel, TCoeffVar, TBaseFreqFlag
            Write #1, TAfreq, TCFreq, TGFreq, TTFreq, TPower
            Write #1, TNegBLFlag, TSubRepsFlag, TGRFlag, TRndIOrderFlag, pBSPValFlag, SSFastFlag, pSSGapFlag, pSSVarPFlag, pSSOutlyerFlag, pSSRndSeed, pSSWinLen, pSSStep, pSSNumPerms, pSSNumPerms2
            Write #1, ForcePhylE, PolishBPFlag, RealignFlag, ConsensusProg, pCWinFract, pCProportionFlag, pCWinSize, 0, 0
            Write #1, PPWinLen, pPPStripGaps, IncSelf, PPSeed, PPPerms, DoScans(0, 8)
            Write #1, TPTVRat, TPGamma, TPAlpha, TPInvSites, TPModel, TPBPFEstimate
            Write #1, TBModel, TBGamma, TBGammaCats, TBNGens, TBNChains, TBSampFreq, TBTemp, TBSwapFreq, TBSwapNum
            Write #1, MCCorrection

            For x = 0 To NextNo
                Write #1, MaskSeq(x)
            Next 'X

            Write #1, ""

            For x = 0 To NextNo
                Write #1, CurrentXOver(x)
            Next 'X

            Write #1, ""

            For x = 0 To NextNo

                For Y = 1 To CurrentXOver(x)
                    Write #1, XoverList(x, Y).Daughter, XoverList(x, Y).MajorP, XoverList(x, Y).MinorP, XoverList(x, Y).Beginning, XoverList(x, Y).Ending
                    Write #1, XoverList(x, Y).Probability, XoverList(x, Y).OutsideFlag, XoverList(x, Y).MissIdentifyFlag
                    Write #1, XX, XoverList(x, Y).PermPVal, XoverList(x, Y).ProgramFlag
                    Write #1, XXX, XX, XoverList(x, Y).LHolder, XoverList(x, Y).LHolder
                    Write #1, XoverList(x, Y).BeginP, XoverList(x, Y).EndP, XX, XXX
                    Write #1, XoverList(x, Y).SBPFlag
                    'Input #1, XOverList(X, Y).Daughter, XOverList(X, Y).MajorP, XOverList(X, Y).MinorP, XOverList(X, Y).Beginning, XOverList(X, Y).Ending, XOverList(X, Y).Probability, XOverList(X, Y).OutsideFlag, XOverList(X, Y).MissIdentifyFlag
                    'Input #1, XOverList(X, Y).MisPen, XOverList(X, Y).PermPVal, XOverList(X, Y).ProgramFlag, XOverList(X, Y).TotDiffs, XOverList(X, Y).NumDiffs, XOverList(X, Y).lholder, XOverList(X, Y).lholder
                Next 'Y

            Next 'X

            Write #1, gcout$
        ElseIf Right$(sFName$, 4) = ".txt" Or Right$(sFName$, 4) = ".TXT" Then
            'Print #1, SeqFile
            Open sFName$ For Output As #1
            ' Exit Sub
            Print #1, "Recombination Data for:", FName$
            Print #1, Chr$(9), "IncorrectDaughter?", Chr$(9), "RecombinantSequence", Chr$(9), "MajorParent", Chr$(9), "MinorParent", Chr$(9), "BeginningInAlignment", Chr$(9), "EndingInAlignment", Chr$(9), "BeginningInSequence", Chr$(9), "EndingInSequence", Chr$(9), "UncorrectedProbability", Chr$(9), "MCCorrectedProbability"
            Dim SSB As Long, SSE As Long, OS1 As Long
            If MCFlag = 0 Then

                For x = 0 To NextNo

                    For Y = 0 To CurrentXOver(x)

                        If XoverList(x, Y).Probability > 0 Then
                            If SeqSpacesInFileFlag = 1 Then
                                oDirX = CurDir
                                ChDrive App.Path
                                ChDir App.Path
                                FF = FreeFile
                                
                                OS1 = x * (Len(StrainSeq(0)) + 3)
                                Open "RDP5SSFile" + UFTag For Binary As #FF
                                
                                Get #FF, (((XoverList(x, Y).Beginning + OS1) - 1) * 4) + 1, SSB
                                Get #FF, (((XoverList(x, Y).Ending + OS1) - 1) * 4) + 1, SSE
                                
                                Close #FF
                                ChDrive oDirX
                                ChDir oDirX
                            Else
                                SSB = SeqSpaces(XoverList(x, Y).Beginning, x)
                                SSE = SeqSpaces(XoverList(x, Y).Ending, x)
                            End If

                            If XoverList(x, Y).OutsideFlag = 0 Then
                                
                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            ElseIf XoverList(x, Y).OutsideFlag = 1 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If
                                
                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MajorP) + ")", Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            ElseIf XoverList(x, Y).OutsideFlag = 2 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MinorP) + ")", Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            End If

                        Else
                            'Exit For
                        End If

                    Next 'Y

                Next 'X

            Else

                For x = 0 To NextNo

                    For Y = 0 To CurrentXOver(x)

                        If XoverList(x, Y).Probability > 0 Then
                            If SeqSpacesInFileFlag = 1 Then
                                oDirX = CurDir
                                ChDrive App.Path
                                ChDir App.Path
                                FF = FreeFile
                                
                                OS1 = x * (Len(StrainSeq(0)) + 3)
                                Open "RDP5SSFile" + UFTag For Binary As #FF
                                
                                Get #FF, (((XoverList(x, Y).Beginning + OS1) - 1) * 4) + 1, SSB
                                Get #FF, (((XoverList(x, Y).Ending + OS1) - 1) * 4) + 1, SSE
                                
                                Close #FF
                                ChDrive oDirX
                                ChDir oDirX
                            Else
                                SSB = SeqSpaces(XoverList(x, Y).Beginning, x)
                                SSE = SeqSpaces(XoverList(x, Y).Ending, x)
                            End If

                            If XoverList(x, Y).OutsideFlag = 0 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability, Chr$(9), XoverList(x, Y).Probability * MCCorrection
                            ElseIf XoverList(x, Y).OutsideFlag = 1 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MajorP) + ")", Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability, Chr$(9), XoverList(x, Y).Probability * MCCorrection
                            ElseIf XoverList(x, Y).OutsideFlag = 2 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MinorP) + ")", Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability, Chr$(9), XoverList(x, Y).Probability * MCCorrection
                            End If

                        Else
                            'Exit For
                        End If

                    Next 'Y

                Next 'X

            End If

        End If

        Close #1
        Screen.MousePointer = 0
    Else
        Open OutFileX For Append As #1

        If ShortOutFlag = 0 Then
            Print #1, "Start"
            Print #1, "Recombination Data for:", InFileX
            Print #1, "Possible recombination events:", oRecombNo(100)
            Print #1, Chr$(9), "IncorrectDaughter?", Chr$(9), "RecombinantSequence", Chr$(9), "MajorParent", Chr$(9), "MinorParent", Chr$(9), "BeginningInAlignment", Chr$(9), "EndingInAlignment", Chr$(9), "BeginningInSequence", Chr$(9), "EndingInSequence", Chr$(9), "UncorrectedProbability", Chr$(9), "MCCorrectedProbability"

            If MCFlag = 0 Then

                For x = 0 To NextNo

                    For Y = 0 To CurrentXOver(x)

                        If XoverList(x, Y).Probability > 0 Then
                            If SeqSpacesInFileFlag = 1 Then
                                oDirX = CurDir
                                ChDrive App.Path
                                ChDir App.Path
                                FF = FreeFile
                               
                                OS1 = x * (Len(StrainSeq(0)) + 3)
                                Open "RDP5SSFile" + UFTag For Binary As #FF
                                
                                Get #FF, (((XoverList(x, Y).Beginning + OS1) - 1) * 4) + 1, SSB
                                Get #FF, (((XoverList(x, Y).Ending + OS1) - 1) * 4) + 1, SSE
                                
                                Close #FF
                                ChDrive oDirX
                                ChDir oDirX
                            Else
                                SSB = SeqSpaces(XoverList(x, Y).Beginning, x)
                                SSE = SeqSpaces(XoverList(x, Y).Ending, x)
                            End If

                            If XoverList(x, Y).OutsideFlag = 0 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            ElseIf XoverList(x, Y).OutsideFlag = 1 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MajorP) + ")", Chr$(9), OriginalName(XoverList(x, Y).MinorP), Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            ElseIf XoverList(x, Y).OutsideFlag = 2 Then

                                If XoverList(x, Y).MissIdentifyFlag = 1 Then
                                    MissF = "+"
                                Else
                                    MissF = "-"
                                End If

                                Print #1, Chr$(9), MissF, Chr$(9), OriginalName(XoverList(x, Y).Daughter), Chr$(9), OriginalName(XoverList(x, Y).MajorP), Chr$(9), "Unknown (" + OriginalName(XoverList(x, Y).MinorP) + ")", Chr$(9), XoverList(x, Y).Beginning, Chr$(9), XoverList(x, Y).Ending, Chr$(9), XoverList(x, Y).Beginning - SSB, Chr$(9), XoverList(x, Y).Ending - SSE, Chr$(9), XoverList(x, Y).Probability / MCCorrection, Chr$(9), XoverList(x, Y).Probability
                            End If

                        Else
                            'Exit For
                        End If

                    Next 'Y

                Next 'X

            Else

                For x = 0 To NextNo

                    For Y = 0 To CurrentXOver(x)
                        If SeqSpacesInFileFlag = 1 Then
                                oDirX = CurDir
                                ChDrive App.Path
                                ChDir App.Path
                                FF = FreeFile
                                
                                OS1 = x * (Len(StrainSeq(0)) + 3)
                                Open "RDP5SSFile" + UFTag For Binary As #FF
                                
                                Get #FF, (((XoverList(x, Y).Beginning + OS1) - 1) * 4) + 1, SSB
                                Get #FF, (((XoverList(x, Y).Ending + OS1) - 1) * 4) + 1, SSE
                                
                                Close #FF
                                ChDrive oDirX
                                ChDir oDirX
                            Else
                                SSB = SeqSpaces(XoverList(x, Y).Beginning, x)
                                SSE = SeqSpaces(XoverList(x, Y).Ending, x)
                            End If

                        Print #1, OriginalName(XoverList(x, Y).Daughter), OriginalName(XoverList(x, Y).MajorP), OriginalName(XoverList(x, Y).MinorP), XoverList(x, Y).Beginning, XoverList(x, Y).Ending, XoverList(x, Y).Beginning - SSB, XoverList(x, Y).Ending - SSE, XoverList(x, Y).Probability, XoverList(x, Y).Probability * MCCorrection
                    Next 'Y

                Next 'X

            End If

            Print #1, "Finish"
        ElseIf ShortOutFlag = 1 Then

            For x = 0 To NextNo

                If RFlag(x) > 0 Then
                    Print #1, "1"
                Else
                    Print #1, "0"
                End If

            Next 'X

        ElseIf ShortOutFlag = 2 Then

            For x = 0 To NextNo
                Print #1, RFlag(x)
            Next 'X

        End If

        Close #1
        Screen.MousePointer = 0
    End If
    
End Sub

