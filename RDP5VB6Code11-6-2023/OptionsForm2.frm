VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form Form3 
   Appearance      =   0  'Flat
   BackColor       =   &H80000004&
   BorderStyle     =   0  'None
   Caption         =   "Form3"
   ClientHeight    =   8610
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   12885
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8610
   ScaleWidth      =   12885
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7815
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   12828
      Begin VB.Frame Frame2 
         Height          =   4665
         Index           =   0
         Left            =   2280
         TabIndex        =   54
         Top             =   840
         Width           =   7815
         Begin VB.Frame Frame8 
            Caption         =   "Recombinant identification approach"
            Height          =   735
            Left            =   120
            TabIndex        =   399
            Top             =   2760
            Width           =   4815
            Begin VB.ComboBox Combo5 
               Height          =   315
               Left            =   1800
               TabIndex        =   508
               Text            =   "Combo5"
               Top             =   240
               Width           =   2295
            End
            Begin VB.CommandButton Command3 
               Height          =   285
               Left            =   2400
               MouseIcon       =   "OptionsForm2.frx":0000
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":0152
               Style           =   1  'Graphical
               TabIndex        =   401
               Top             =   360
               Visible         =   0   'False
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   37
               Left            =   3600
               TabIndex        =   400
               Text            =   "Text1"
               ToolTipText     =   "Warning: ONLY INCREASE THIS NUMBER >0 IF YOU REALLY KNOW WHAT YOU ARE DOING"
               Top             =   360
               Visible         =   0   'False
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "Number of permutations"
               Height          =   285
               Index           =   53
               Left            =   0
               TabIndex        =   403
               Top             =   240
               Visible         =   0   'False
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Use SEQGEN parametric simulations"
               Height          =   435
               Index           =   54
               Left            =   0
               TabIndex        =   402
               Top             =   480
               Visible         =   0   'False
               Width           =   3135
            End
         End
         Begin VB.Frame Frame27 
            Caption         =   "Data Processing Options"
            Height          =   2352
            Left            =   4200
            TabIndex        =   357
            Top             =   120
            Width           =   3672
            Begin VB.CommandButton Command8 
               Height          =   285
               Left            =   3480
               MouseIcon       =   "OptionsForm2.frx":045C
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":05AE
               Style           =   1  'Graphical
               TabIndex        =   505
               Top             =   1320
               Width           =   315
            End
            Begin VB.CheckBox Check13 
               Caption         =   "Disentangle overlapping signals"
               Height          =   405
               Left            =   240
               TabIndex        =   404
               ToolTipText     =   $"OptionsForm2.frx":08B8
               Top             =   1080
               Width           =   2865
            End
            Begin VB.CommandButton Command5 
               Height          =   285
               Left            =   3120
               MouseIcon       =   "OptionsForm2.frx":0991
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":0AE3
               Style           =   1  'Graphical
               TabIndex        =   398
               Top             =   1680
               Width           =   315
            End
            Begin VB.CheckBox Check10 
               Caption         =   "Require topological evidence"
               Height          =   255
               Left            =   240
               TabIndex        =   383
               ToolTipText     =   "If selected only phylogenetically supported recombination events will be considered"
               Top             =   360
               Width           =   2535
            End
            Begin VB.CheckBox Check11 
               Caption         =   "Check alignment consistency"
               Height          =   405
               Left            =   180
               TabIndex        =   361
               ToolTipText     =   "If selected will guard against misaligned nucleotides causing false positive recombination signals"
               Top             =   750
               Width           =   2865
            End
            Begin VB.CheckBox Check9 
               Caption         =   "Polish breakpoints"
               Height          =   225
               Left            =   180
               TabIndex        =   360
               ToolTipText     =   "If selected breakpoint locations will be optimised using the BURT method"
               Top             =   600
               Width           =   3015
            End
            Begin VB.CommandButton Command7 
               Height          =   285
               Left            =   3240
               MouseIcon       =   "OptionsForm2.frx":0DED
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":0F3F
               Style           =   1  'Graphical
               TabIndex        =   359
               Top             =   2040
               Width           =   315
            End
            Begin VB.Label Label15 
               Caption         =   "Group recombinants realistically"
               Height          =   312
               Left            =   240
               TabIndex        =   504
               ToolTipText     =   $"OptionsForm2.frx":1249
               Top             =   1440
               Width           =   2928
            End
            Begin VB.Label Label20 
               BackStyle       =   0  'Transparent
               Caption         =   "Do not show plots"
               Height          =   252
               Left            =   480
               TabIndex        =   397
               Top             =   1680
               Width           =   1392
            End
            Begin VB.Label Label43 
               Caption         =   "Display all potential events"
               Height          =   315
               Left            =   360
               TabIndex        =   358
               Top             =   2040
               Width           =   2925
            End
         End
         Begin VB.Frame Frame10 
            Caption         =   "General Recombination Detection Options"
            Height          =   1305
            Left            =   360
            TabIndex        =   69
            Top             =   480
            Width           =   3645
            Begin VB.TextBox Text3 
               Height          =   315
               Left            =   2550
               TabIndex        =   72
               Top             =   330
               Width           =   735
            End
            Begin VB.CommandButton Command16 
               Height          =   285
               Left            =   1950
               MouseIcon       =   "OptionsForm2.frx":12D9
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":142B
               Style           =   1  'Graphical
               TabIndex        =   71
               ToolTipText     =   "Warning: ONLY CHANGE THIS FROM 'BONFERRONI CORRECTION' IF YOU REALLY KNOW WHAT YOU ARE DOING"
               Top             =   660
               Width           =   315
            End
            Begin VB.CommandButton Command2 
               Height          =   285
               Left            =   2130
               MouseIcon       =   "OptionsForm2.frx":1735
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":1887
               Style           =   1  'Graphical
               TabIndex        =   70
               Top             =   90
               Width           =   315
            End
            Begin VB.Label Label18 
               BackStyle       =   0  'Transparent
               Caption         =   "Highest acceptable P-Value"
               Height          =   285
               Left            =   120
               TabIndex        =   75
               Top             =   360
               Width           =   2205
            End
            Begin VB.Label Label23 
               BackStyle       =   0  'Transparent
               Caption         =   "Multiple comparison Correction"
               Height          =   225
               Left            =   150
               TabIndex        =   74
               Top             =   600
               Width           =   1455
            End
            Begin VB.Label Label16 
               BackStyle       =   0  'Transparent
               Caption         =   "Sequences are circular"
               Height          =   315
               Left            =   90
               TabIndex        =   73
               Top             =   210
               Width           =   1815
            End
         End
         Begin VB.Frame Frame9 
            Caption         =   "Analyse Sequences Using:"
            Height          =   2235
            Left            =   1320
            TabIndex        =   55
            Top             =   1200
            Width           =   6675
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   7
               Left            =   3000
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   414
               Top             =   1680
               Width           =   285
            End
            Begin VB.CheckBox Check22 
               Caption         =   "LARD"
               Height          =   375
               Left            =   4080
               TabIndex        =   413
               ToolTipText     =   "Secondary scan"
               Top             =   1800
               Width           =   1095
            End
            Begin VB.CheckBox Check21 
               Enabled         =   0   'False
               Height          =   375
               Left            =   3840
               TabIndex        =   412
               ToolTipText     =   "Primary scan"
               Top             =   1800
               Visible         =   0   'False
               Width           =   1095
            End
            Begin VB.CheckBox Check20 
               Caption         =   "3Seq"
               Enabled         =   0   'False
               Height          =   375
               Left            =   4080
               TabIndex        =   411
               ToolTipText     =   "Secondary scan"
               Top             =   1440
               Value           =   1  'Checked
               Visible         =   0   'False
               Width           =   1095
            End
            Begin VB.CheckBox Check19 
               Caption         =   "SiScan"
               Height          =   315
               Left            =   5280
               TabIndex        =   410
               ToolTipText     =   "Secondary Scan"
               Top             =   1200
               Width           =   1215
            End
            Begin VB.CheckBox Check18 
               Caption         =   "Chimaera"
               Height          =   315
               Left            =   3840
               TabIndex        =   409
               ToolTipText     =   "Secondary scan"
               Top             =   720
               Visible         =   0   'False
               Width           =   1155
            End
            Begin VB.CheckBox Check17 
               Caption         =   "MaxChi"
               Height          =   285
               Left            =   4920
               TabIndex        =   408
               ToolTipText     =   "Secondary scan"
               Top             =   480
               Visible         =   0   'False
               Width           =   1425
            End
            Begin VB.CheckBox Check16 
               Caption         =   "BootScan"
               Height          =   315
               Left            =   4920
               TabIndex        =   407
               ToolTipText     =   "Secondary scan"
               Top             =   240
               Width           =   1365
            End
            Begin VB.CheckBox Check15 
               Caption         =   "GENECONV"
               Height          =   255
               Left            =   480
               TabIndex        =   406
               ToolTipText     =   "Secondary scan"
               Top             =   360
               Visible         =   0   'False
               Width           =   1275
            End
            Begin VB.CheckBox Check14 
               Caption         =   "RDP"
               Height          =   315
               Left            =   480
               TabIndex        =   405
               ToolTipText     =   "Secondary scan"
               Top             =   720
               Visible         =   0   'False
               Width           =   1515
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   6
               Left            =   3720
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   368
               Top             =   1080
               Width           =   285
            End
            Begin VB.CheckBox Check12 
               Caption         =   "3Seq"
               Height          =   375
               Left            =   3840
               TabIndex        =   367
               ToolTipText     =   "Primary scan"
               Top             =   1440
               Width           =   1095
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   0
               Left            =   2640
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   123
               Top             =   360
               Width           =   285
            End
            Begin VB.CheckBox Check4 
               Caption         =   "RDP"
               Height          =   315
               Left            =   300
               TabIndex        =   67
               ToolTipText     =   "Primary scan"
               Top             =   720
               Width           =   1515
            End
            Begin VB.CheckBox Check5 
               Caption         =   "GENECONV"
               Height          =   255
               Left            =   270
               TabIndex        =   66
               ToolTipText     =   "Primary scan"
               Top             =   390
               Width           =   1275
            End
            Begin VB.CheckBox Check1 
               Height          =   315
               Left            =   4680
               TabIndex        =   65
               ToolTipText     =   "Primary scan"
               Top             =   240
               Width           =   1365
            End
            Begin VB.CheckBox Check2 
               Caption         =   "MaxChi"
               Height          =   285
               Left            =   4680
               TabIndex        =   64
               ToolTipText     =   "Primary scan"
               Top             =   480
               Width           =   1425
            End
            Begin VB.CheckBox Check3 
               Caption         =   "Chimaera"
               Height          =   315
               Left            =   3600
               TabIndex        =   63
               ToolTipText     =   "Primary scan"
               Top             =   720
               Width           =   1155
            End
            Begin VB.CheckBox Check6 
               Height          =   315
               Left            =   5040
               TabIndex        =   62
               ToolTipText     =   "Primary Scan"
               Top             =   1200
               Width           =   1215
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   1
               Left            =   600
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   61
               Top             =   1200
               Width           =   285
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   2
               Left            =   1920
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   60
               Top             =   600
               Width           =   285
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   3
               Left            =   2880
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   59
               Top             =   720
               Width           =   285
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   4
               Left            =   1560
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   58
               Top             =   960
               Width           =   285
            End
            Begin VB.PictureBox Picture26 
               Appearance      =   0  'Flat
               BackColor       =   &H80000005&
               ForeColor       =   &H80000008&
               Height          =   285
               Index           =   5
               Left            =   2280
               ScaleHeight     =   255
               ScaleWidth      =   255
               TabIndex        =   57
               Top             =   1200
               Width           =   285
            End
            Begin VB.PictureBox Picture27 
               Appearance      =   0  'Flat
               AutoRedraw      =   -1  'True
               BackColor       =   &H80000004&
               ForeColor       =   &H80000008&
               Height          =   375
               Left            =   120
               ScaleHeight     =   345
               ScaleWidth      =   2235
               TabIndex        =   56
               Top             =   1680
               Width           =   2265
            End
            Begin VB.Label Label60 
               BackStyle       =   0  'Transparent
               Caption         =   "Estimated analysis time: Unknown"
               Height          =   225
               Left            =   1200
               TabIndex        =   68
               Top             =   870
               Width           =   855
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1845
         Index           =   11
         Left            =   8040
         TabIndex        =   240
         Top             =   5520
         Visible         =   0   'False
         Width           =   2895
         Begin VB.Frame Frame7 
            Caption         =   "Model Options"
            Height          =   2745
            Index           =   2
            Left            =   4080
            TabIndex        =   431
            Top             =   360
            Width           =   5085
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   35
               Left            =   3840
               TabIndex        =   481
               Text            =   "Text23"
               Top             =   1920
               Width           =   465
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   47
               Left            =   2640
               MouseIcon       =   "OptionsForm2.frx":1B91
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":1CE3
               Style           =   1  'Graphical
               TabIndex        =   468
               Top             =   120
               Width           =   315
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   42
               Left            =   3120
               TabIndex        =   451
               Text            =   "Text23"
               ToolTipText     =   "0 = maximise likelihood with phylogeny"
               Top             =   2160
               Width           =   465
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   34
               Left            =   3360
               TabIndex        =   449
               Text            =   "Text23"
               Top             =   1680
               Width           =   465
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   44
               Left            =   3240
               MouseIcon       =   "OptionsForm2.frx":1FED
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":213F
               Style           =   1  'Graphical
               TabIndex        =   443
               Top             =   1440
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   18
               Left            =   2400
               TabIndex        =   434
               Text            =   "Text1"
               ToolTipText     =   ">1 = maximise likelihood with the phylogeny"
               Top             =   1200
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   17
               Left            =   2520
               TabIndex        =   433
               Text            =   "Text1"
               ToolTipText     =   "0 = maximise likelihood with the phylogeny"
               Top             =   840
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   43
               Left            =   2640
               MouseIcon       =   "OptionsForm2.frx":2449
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":259B
               Style           =   1  'Graphical
               TabIndex        =   432
               Top             =   480
               Width           =   315
            End
            Begin VB.Label Label1 
               Caption         =   "ML"
               Height          =   285
               Index           =   69
               Left            =   120
               TabIndex        =   469
               Top             =   600
               Width           =   4485
            End
            Begin VB.Label Label21 
               BackStyle       =   0  'Transparent
               Caption         =   "Gamma distribution parameter (alpha)"
               Height          =   345
               Index           =   52
               Left            =   120
               TabIndex        =   452
               Top             =   2040
               Width           =   2955
            End
            Begin VB.Label Label21 
               BackStyle       =   0  'Transparent
               Caption         =   "Number of substitution rate categories"
               Height          =   345
               Index           =   42
               Left            =   0
               TabIndex        =   450
               Top             =   1680
               Width           =   3195
            End
            Begin VB.Label Label21 
               BackStyle       =   0  'Transparent
               Caption         =   "Empirical base frequency estimates"
               Height          =   345
               Index           =   46
               Left            =   -360
               TabIndex        =   444
               Top             =   1320
               Width           =   3765
            End
            Begin VB.Label Label1 
               Caption         =   "Proportion of invariable sites"
               Height          =   285
               Index           =   60
               Left            =   120
               TabIndex        =   437
               Top             =   1080
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Transition:transversion rate ratio"
               Height          =   285
               Index           =   59
               Left            =   0
               TabIndex        =   436
               Top             =   840
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "ML"
               Height          =   285
               Index           =   24
               Left            =   0
               TabIndex        =   435
               Top             =   240
               Width           =   4605
            End
         End
         Begin VB.Frame Frame22 
            Caption         =   "Tree Search Strategy"
            Height          =   735
            Left            =   3720
            TabIndex        =   478
            Top             =   2880
            Width           =   4095
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   49
               Left            =   2400
               MouseIcon       =   "OptionsForm2.frx":28A5
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":29F7
               Style           =   1  'Graphical
               TabIndex        =   480
               Top             =   360
               Width           =   315
            End
            Begin VB.Label Label1 
               Caption         =   "Search strat"
               Height          =   285
               Index           =   72
               Left            =   0
               TabIndex        =   479
               Top             =   360
               Width           =   3405
            End
         End
         Begin VB.Frame Frame6 
            Caption         =   "MCMC Options"
            Height          =   705
            Index           =   2
            Left            =   600
            TabIndex        =   455
            Top             =   2760
            Width           =   1995
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   43
               Left            =   2040
               TabIndex        =   467
               Text            =   "Text1"
               Top             =   1560
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   42
               Left            =   2280
               TabIndex        =   465
               Text            =   "Text1"
               Top             =   1200
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   41
               Left            =   2280
               TabIndex        =   463
               Text            =   "Text1"
               Top             =   1080
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   40
               Left            =   2280
               TabIndex        =   461
               Text            =   "Text1"
               Top             =   480
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   39
               Left            =   2400
               TabIndex        =   457
               Text            =   "Text1"
               Top             =   240
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   38
               Left            =   2370
               TabIndex        =   456
               Text            =   "Text1"
               Top             =   720
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "Swap number"
               Height          =   285
               Index           =   68
               Left            =   0
               TabIndex        =   466
               Top             =   1560
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Swap frequency"
               Height          =   285
               Index           =   67
               Left            =   0
               TabIndex        =   464
               Top             =   1320
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Temperature"
               Height          =   285
               Index           =   66
               Left            =   120
               TabIndex        =   462
               Top             =   1080
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Sampling frequency"
               Height          =   285
               Index           =   65
               Left            =   120
               TabIndex        =   460
               Top             =   840
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Number of generations"
               Height          =   285
               Index           =   64
               Left            =   120
               TabIndex        =   459
               Top             =   240
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Number of chains"
               Height          =   285
               Index           =   63
               Left            =   120
               TabIndex        =   458
               Top             =   600
               Width           =   2445
            End
         End
         Begin VB.Frame Frame6 
            Caption         =   "Branch Support Tests"
            Height          =   1425
            Index           =   0
            Left            =   0
            TabIndex        =   316
            Top             =   1560
            Width           =   4995
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   48
               Left            =   3840
               MouseIcon       =   "OptionsForm2.frx":2D01
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":2E53
               Style           =   1  'Graphical
               TabIndex        =   477
               Top             =   240
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   34
               Left            =   2490
               TabIndex        =   319
               Text            =   "Text1"
               Top             =   840
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   33
               Left            =   2400
               TabIndex        =   317
               Text            =   "Text1"
               Top             =   480
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "Branch tests"
               Height          =   285
               Index           =   71
               Left            =   240
               TabIndex        =   476
               Top             =   240
               Width           =   3765
            End
            Begin VB.Label Label1 
               Caption         =   "Random number seed"
               Height          =   285
               Index           =   46
               Left            =   120
               TabIndex        =   320
               Top             =   840
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Bootstrap replicates"
               Height          =   285
               Index           =   45
               Left            =   120
               TabIndex        =   318
               Top             =   600
               Width           =   2445
            End
         End
         Begin VB.Frame Frame7 
            Caption         =   "Model Options"
            Height          =   1425
            Index           =   3
            Left            =   4080
            TabIndex        =   438
            Top             =   3120
            Width           =   4365
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   46
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":315D
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":32AF
               Style           =   1  'Graphical
               TabIndex        =   454
               Top             =   960
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   20
               Left            =   2460
               TabIndex        =   440
               Text            =   "Text1"
               Top             =   1440
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   45
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":35B9
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":370B
               Style           =   1  'Graphical
               TabIndex        =   439
               Top             =   480
               Width           =   315
            End
            Begin VB.Label Label1 
               Caption         =   "Number of rate categories"
               Height          =   285
               Index           =   62
               Left            =   0
               TabIndex        =   442
               Top             =   1440
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Bayes"
               Height          =   285
               Index           =   61
               Left            =   120
               TabIndex        =   441
               Top             =   480
               Width           =   3765
            End
            Begin VB.Label Label21 
               BackStyle       =   0  'Transparent
               Caption         =   "Estimate from alignment"
               Height          =   345
               Index           =   51
               Left            =   -600
               TabIndex        =   453
               Top             =   840
               Width           =   3645
            End
         End
         Begin VB.Frame Frame6 
            Caption         =   "Tree Drawing Options"
            Height          =   975
            Index           =   1
            Left            =   240
            TabIndex        =   321
            Top             =   360
            Width           =   2835
            Begin VB.ComboBox Combo3 
               Height          =   315
               Left            =   1440
               TabIndex        =   429
               Text            =   "Combo3"
               Top             =   240
               Width           =   2175
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   32
               Left            =   2550
               MouseIcon       =   "OptionsForm2.frx":3A15
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":3B67
               Style           =   1  'Graphical
               TabIndex        =   331
               Top             =   2010
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   31
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":3E71
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":3FC3
               Style           =   1  'Graphical
               TabIndex        =   329
               Top             =   1650
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   30
               Left            =   2490
               MouseIcon       =   "OptionsForm2.frx":42CD
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":441F
               Style           =   1  'Graphical
               TabIndex        =   327
               Top             =   1410
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   29
               Left            =   2460
               MouseIcon       =   "OptionsForm2.frx":4729
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":487B
               Style           =   1  'Graphical
               TabIndex        =   325
               Top             =   1050
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   35
               Left            =   2460
               TabIndex        =   322
               Text            =   "Text1"
               Top             =   630
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "Tree type"
               Height          =   285
               Index           =   23
               Left            =   120
               TabIndex        =   430
               Top             =   240
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Randomise input order"
               Height          =   285
               Index           =   52
               Left            =   270
               TabIndex        =   330
               Top             =   2070
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Do global rearrangements"
               Height          =   285
               Index           =   51
               Left            =   270
               TabIndex        =   328
               Top             =   1710
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Do subreplicates"
               Height          =   285
               Index           =   50
               Left            =   240
               TabIndex        =   326
               Top             =   1470
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Allow negative branch lengths"
               Height          =   285
               Index           =   49
               Left            =   90
               TabIndex        =   324
               Top             =   1140
               Width           =   2745
            End
            Begin VB.Label Label1 
               Caption         =   "Power"
               Height          =   285
               Index           =   47
               Left            =   210
               TabIndex        =   323
               Top             =   750
               Width           =   2445
            End
         End
         Begin VB.Frame Frame7 
            Caption         =   "Model Options"
            Height          =   2505
            Index           =   1
            Left            =   360
            TabIndex        =   298
            Top             =   2760
            Width           =   3525
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   27
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":4B85
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":4CD7
               Style           =   1  'Graphical
               TabIndex        =   312
               Top             =   150
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   32
               Left            =   2460
               TabIndex        =   311
               Text            =   "Text1"
               Top             =   480
               Width           =   795
            End
            Begin VB.Frame Frame21 
               Caption         =   "Base frequencies"
               Height          =   1425
               Index           =   6
               Left            =   180
               TabIndex        =   300
               Top             =   1050
               Width           =   2715
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   33
                  Left            =   480
                  TabIndex        =   305
                  Text            =   "Text23"
                  Top             =   720
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   32
                  Left            =   2100
                  TabIndex        =   304
                  Text            =   "Text23"
                  Top             =   330
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   31
                  Left            =   570
                  TabIndex        =   303
                  Text            =   "Text23"
                  Top             =   360
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   30
                  Left            =   1980
                  TabIndex        =   302
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.CommandButton Command28 
                  Height          =   285
                  Index           =   26
                  Left            =   2220
                  MouseIcon       =   "OptionsForm2.frx":4FE1
                  MousePointer    =   99  'Custom
                  Picture         =   "OptionsForm2.frx":5133
                  Style           =   1  'Graphical
                  TabIndex        =   301
                  Top             =   150
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G"
                  Height          =   345
                  Index           =   39
                  Left            =   90
                  TabIndex        =   310
                  Top             =   720
                  Width           =   1035
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C"
                  Height          =   345
                  Index           =   38
                  Left            =   1410
                  TabIndex        =   309
                  Top             =   270
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A"
                  Height          =   345
                  Index           =   37
                  Left            =   120
                  TabIndex        =   308
                  Top             =   360
                  Width           =   255
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "T"
                  Height          =   345
                  Index           =   36
                  Left            =   1380
                  TabIndex        =   307
                  Top             =   840
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Estimate from alignment"
                  Height          =   345
                  Index           =   35
                  Left            =   90
                  TabIndex        =   306
                  Top             =   1170
                  Width           =   1965
               End
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   31
               Left            =   2460
               TabIndex        =   299
               Text            =   "Text1"
               Top             =   630
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "NJ and LS"
               Height          =   285
               Index           =   44
               Left            =   150
               TabIndex        =   315
               Top             =   270
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Transition:transversion rate ratio"
               Height          =   285
               Index           =   43
               Left            =   180
               TabIndex        =   314
               Top             =   510
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Coefficient of variation"
               Height          =   285
               Index           =   42
               Left            =   180
               TabIndex        =   313
               Top             =   750
               Width           =   2445
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1725
         Index           =   15
         Left            =   8040
         TabIndex        =   475
         Top             =   2160
         Visible         =   0   'False
         Width           =   4845
         Begin VB.Frame Frame29 
            Caption         =   "General"
            Height          =   1095
            Index           =   2
            Left            =   240
            TabIndex        =   501
            Top             =   240
            Width           =   4335
            Begin VB.ComboBox Combo4 
               Height          =   315
               Left            =   2880
               TabIndex        =   506
               Text            =   "Combo4"
               Top             =   720
               Width           =   615
            End
            Begin VB.TextBox Text6 
               Height          =   285
               Index           =   6
               Left            =   2880
               TabIndex        =   502
               Text            =   " "
               Top             =   360
               Width           =   855
            End
            Begin VB.Label Label19 
               Caption         =   "Reference sequence"
               Height          =   255
               Left            =   240
               TabIndex        =   507
               Top             =   720
               Width           =   1575
            End
            Begin VB.Label Label2 
               BackStyle       =   0  'Transparent
               Caption         =   "Permutation number"
               Height          =   375
               Index           =   7
               Left            =   240
               TabIndex        =   503
               Top             =   360
               Width           =   2295
            End
         End
         Begin VB.Frame Frame29 
            Caption         =   "Nucleic acid  folding disruption"
            Height          =   975
            Index           =   1
            Left            =   120
            TabIndex        =   494
            Top             =   2280
            Width           =   4335
            Begin VB.TextBox Text6 
               Height          =   285
               Index           =   7
               Left            =   2760
               TabIndex        =   500
               Text            =   "Text6"
               Top             =   600
               Width           =   855
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   50
               Left            =   3120
               MouseIcon       =   "OptionsForm2.frx":543D
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":558F
               Style           =   1  'Graphical
               TabIndex        =   495
               Top             =   360
               Width           =   315
            End
            Begin VB.Label Label2 
               BackStyle       =   0  'Transparent
               Caption         =   "Temparature"
               Height          =   375
               Index           =   9
               Left            =   240
               TabIndex        =   499
               Top             =   600
               Width           =   2295
            End
            Begin VB.Label Label2 
               BackStyle       =   0  'Transparent
               Caption         =   "Sequences are DNA"
               Height          =   375
               Index           =   8
               Left            =   480
               TabIndex        =   496
               Top             =   360
               Width           =   2295
            End
         End
         Begin VB.Frame Frame29 
            Caption         =   "Protein folding disruption"
            Height          =   1095
            Index           =   0
            Left            =   240
            TabIndex        =   493
            Top             =   1080
            Width           =   4335
            Begin VB.TextBox Text6 
               Height          =   285
               Index           =   11
               Left            =   3000
               TabIndex        =   497
               Text            =   "Text6"
               Top             =   120
               Width           =   855
            End
            Begin VB.Label Label2 
               BackStyle       =   0  'Transparent
               Caption         =   "Interaction distance (in angstroms)"
               Height          =   375
               Index           =   13
               Left            =   120
               TabIndex        =   498
               Top             =   240
               Width           =   3135
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   825
         Index           =   1
         Left            =   5040
         TabIndex        =   76
         Top             =   5400
         Visible         =   0   'False
         Width           =   1005
         Begin VB.Frame Frame11 
            Caption         =   "Recombinant Detection Options"
            Height          =   1065
            Left            =   150
            TabIndex        =   114
            Top             =   3300
            Width           =   4905
            Begin VB.TextBox Text8 
               Alignment       =   2  'Center
               Height          =   315
               Left            =   2250
               TabIndex        =   117
               Text            =   "Text8"
               Top             =   660
               Width           =   315
            End
            Begin VB.TextBox Text7 
               Alignment       =   2  'Center
               Height          =   315
               Left            =   1260
               TabIndex        =   116
               Text            =   "Text7"
               Top             =   660
               Width           =   375
            End
            Begin VB.TextBox Text2 
               Height          =   315
               Left            =   2340
               TabIndex        =   115
               Text            =   "Text2"
               ToolTipText     =   "For each trplet examined the number of variable sites per window"
               Top             =   180
               Width           =   735
            End
            Begin VB.Label Label25 
               BackStyle       =   0  'Transparent
               Caption         =   "% to"
               Height          =   255
               Left            =   1650
               TabIndex        =   121
               Top             =   690
               Width           =   885
            End
            Begin VB.Label Label24 
               BackStyle       =   0  'Transparent
               Caption         =   "% sequence identity"
               Height          =   255
               Left            =   2640
               TabIndex        =   120
               Top             =   690
               Width           =   2025
            End
            Begin VB.Label Label17 
               Alignment       =   2  'Center
               BackStyle       =   0  'Transparent
               Caption         =   "Window size"
               Height          =   315
               Left            =   150
               TabIndex        =   119
               Top             =   270
               Width           =   1245
            End
            Begin VB.Label Label49 
               BackStyle       =   0  'Transparent
               Caption         =   "Detect recombination between sequences sharing"
               Height          =   315
               Left            =   300
               TabIndex        =   118
               Top             =   600
               Width           =   4545
            End
         End
         Begin VB.Frame Frame12 
            Caption         =   "Reference sequence selection"
            Height          =   2445
            Left            =   0
            TabIndex        =   77
            Top             =   210
            Width           =   5265
            Begin VB.OptionButton Option6 
               Caption         =   "Option6"
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   225
               Left            =   0
               TabIndex        =   109
               Top             =   1980
               Width           =   195
            End
            Begin VB.OptionButton Option5 
               Caption         =   "Option5"
               BeginProperty Font 
                  Name            =   "Arial"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   30
               TabIndex        =   108
               Top             =   1530
               Width           =   255
            End
            Begin VB.OptionButton Option4 
               Caption         =   "Option4"
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   30
               TabIndex        =   107
               Top             =   1020
               Width           =   225
            End
            Begin VB.OptionButton Option3 
               Caption         =   "Option3"
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   195
               Left            =   0
               TabIndex        =   106
               Top             =   570
               Width           =   255
            End
            Begin VB.OptionButton Option2 
               Caption         =   "Option2"
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   255
               Left            =   120
               TabIndex        =   105
               Top             =   210
               Width           =   225
            End
            Begin VB.Frame Frame3 
               Caption         =   "Specify reference"
               Enabled         =   0   'False
               Height          =   915
               Left            =   240
               TabIndex        =   103
               Top             =   2040
               Width           =   2085
               Begin VB.ListBox List1 
                  Height          =   255
                  Left            =   240
                  TabIndex        =   104
                  Top             =   330
                  Width           =   1365
               End
            End
            Begin VB.Frame Frame4 
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   2715
               Index           =   3
               Left            =   360
               TabIndex        =   98
               Top             =   240
               Visible         =   0   'False
               Width           =   2535
               Begin VB.Label Label8 
                  Caption         =   "Sequence C"
                  Height          =   315
                  Index           =   11
                  Left            =   1020
                  TabIndex        =   102
                  Top             =   1800
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence B"
                  Height          =   315
                  Index           =   10
                  Left            =   1080
                  TabIndex        =   101
                  Top             =   1320
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence A"
                  Height          =   315
                  Index           =   9
                  Left            =   1110
                  TabIndex        =   100
                  Top             =   780
                  Width           =   1125
               End
               Begin VB.Line Line6 
                  BorderColor     =   &H00000000&
                  Index           =   3
                  X1              =   480
                  X2              =   960
                  Y1              =   1950
                  Y2              =   1950
               End
               Begin VB.Line Line36 
                  X1              =   480
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1950
               End
               Begin VB.Line Line35 
                  X1              =   630
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1140
               End
               Begin VB.Line Line34 
                  X1              =   630
                  X2              =   960
                  Y1              =   870
                  Y2              =   870
               End
               Begin VB.Line Line33 
                  X1              =   630
                  X2              =   930
                  Y1              =   1440
                  Y2              =   1440
               End
               Begin VB.Line Line32 
                  X1              =   630
                  X2              =   630
                  Y1              =   870
                  Y2              =   1440
               End
               Begin VB.Line Line31 
                  BorderColor     =   &H000000FF&
                  X1              =   480
                  X2              =   330
                  Y1              =   1560
                  Y2              =   1560
               End
               Begin VB.Line Line30 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   330
                  Y1              =   1560
                  Y2              =   2400
               End
               Begin VB.Line Line29 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   960
                  Y1              =   2400
                  Y2              =   2400
               End
               Begin VB.Label Label12 
                  Caption         =   "Reference"
                  ForeColor       =   &H000000FF&
                  Height          =   225
                  Left            =   1080
                  TabIndex        =   99
                  Top             =   2280
                  Width           =   765
               End
            End
            Begin VB.Frame Frame4 
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   2715
               Index           =   2
               Left            =   420
               TabIndex        =   92
               Top             =   150
               Visible         =   0   'False
               Width           =   2535
               Begin VB.Line Line18 
                  BorderColor     =   &H000000FF&
                  X1              =   630
                  X2              =   630
                  Y1              =   1260
                  Y2              =   1590
               End
               Begin VB.Label Label11 
                  Caption         =   "Reference B"
                  ForeColor       =   &H000000FF&
                  Height          =   225
                  Left            =   1230
                  TabIndex        =   97
                  Top             =   2280
                  Width           =   1125
               End
               Begin VB.Line Line27 
                  X1              =   810
                  X2              =   1020
                  Y1              =   600
                  Y2              =   600
               End
               Begin VB.Line Line26 
                  X1              =   810
                  X2              =   1050
                  Y1              =   1140
                  Y2              =   1140
               End
               Begin VB.Line Line25 
                  X1              =   810
                  X2              =   810
                  Y1              =   600
                  Y2              =   1140
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence C"
                  Height          =   315
                  Index           =   8
                  Left            =   1170
                  TabIndex        =   96
                  Top             =   1830
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence B"
                  Height          =   315
                  Index           =   7
                  Left            =   1110
                  TabIndex        =   95
                  Top             =   1020
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence A"
                  Height          =   315
                  Index           =   6
                  Left            =   1080
                  TabIndex        =   94
                  Top             =   480
                  Width           =   1125
               End
               Begin VB.Line Line6 
                  BorderColor     =   &H00000000&
                  Index           =   2
                  X1              =   480
                  X2              =   1080
                  Y1              =   1950
                  Y2              =   1950
               End
               Begin VB.Line Line24 
                  X1              =   480
                  X2              =   480
                  Y1              =   1260
                  Y2              =   1950
               End
               Begin VB.Line Line23 
                  X1              =   630
                  X2              =   480
                  Y1              =   1260
                  Y2              =   1260
               End
               Begin VB.Line Line22 
                  X1              =   630
                  X2              =   810
                  Y1              =   870
                  Y2              =   870
               End
               Begin VB.Line Line21 
                  BorderColor     =   &H000000FF&
                  X1              =   630
                  X2              =   1080
                  Y1              =   1590
                  Y2              =   1590
               End
               Begin VB.Line Line20 
                  X1              =   630
                  X2              =   630
                  Y1              =   870
                  Y2              =   1260
               End
               Begin VB.Line Line19 
                  BorderColor     =   &H000000FF&
                  X1              =   480
                  X2              =   330
                  Y1              =   1560
                  Y2              =   1560
               End
               Begin VB.Line Line17 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   1080
                  Y1              =   2400
                  Y2              =   2400
               End
               Begin VB.Line Line16 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   330
                  Y1              =   1560
                  Y2              =   2400
               End
               Begin VB.Label Label10 
                  Caption         =   "Reference A"
                  ForeColor       =   &H000000FF&
                  Height          =   225
                  Left            =   1200
                  TabIndex        =   93
                  Top             =   1500
                  Width           =   1035
               End
            End
            Begin VB.Frame Frame4 
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   2715
               Index           =   1
               Left            =   360
               TabIndex        =   87
               Top             =   -30
               Visible         =   0   'False
               Width           =   2535
               Begin VB.Label Label9 
                  Caption         =   "Reference"
                  ForeColor       =   &H000000FF&
                  Height          =   225
                  Left            =   1080
                  TabIndex        =   91
                  Top             =   1860
                  Width           =   1305
               End
               Begin VB.Line Line15 
                  BorderColor     =   &H000000FF&
                  X1              =   480
                  X2              =   480
                  Y1              =   1560
                  Y2              =   1950
               End
               Begin VB.Line Line14 
                  X1              =   330
                  X2              =   960
                  Y1              =   2400
                  Y2              =   2400
               End
               Begin VB.Line Line13 
                  X1              =   330
                  X2              =   330
                  Y1              =   1560
                  Y2              =   2400
               End
               Begin VB.Line Line12 
                  X1              =   480
                  X2              =   330
                  Y1              =   1560
                  Y2              =   1560
               End
               Begin VB.Line Line11 
                  X1              =   630
                  X2              =   630
                  Y1              =   870
                  Y2              =   1440
               End
               Begin VB.Line Line10 
                  X1              =   630
                  X2              =   930
                  Y1              =   1440
                  Y2              =   1440
               End
               Begin VB.Line Line9 
                  X1              =   630
                  X2              =   960
                  Y1              =   870
                  Y2              =   870
               End
               Begin VB.Line Line8 
                  X1              =   630
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1140
               End
               Begin VB.Line Line7 
                  X1              =   480
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1560
               End
               Begin VB.Line Line6 
                  BorderColor     =   &H000000FF&
                  Index           =   1
                  X1              =   480
                  X2              =   960
                  Y1              =   1950
                  Y2              =   1950
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence A"
                  Height          =   315
                  Index           =   5
                  Left            =   1050
                  TabIndex        =   90
                  Top             =   780
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence B"
                  Height          =   315
                  Index           =   4
                  Left            =   1080
                  TabIndex        =   89
                  Top             =   1320
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence C"
                  Height          =   315
                  Index           =   3
                  Left            =   1080
                  TabIndex        =   88
                  Top             =   2280
                  Width           =   1125
               End
            End
            Begin VB.Frame Frame4 
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   2715
               Index           =   0
               Left            =   2220
               TabIndex        =   83
               Top             =   210
               Width           =   2535
               Begin VB.Label Label8 
                  Caption         =   "Sequence C"
                  Height          =   315
                  Index           =   2
                  Left            =   1080
                  TabIndex        =   86
                  Top             =   1800
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence B"
                  Height          =   315
                  Index           =   1
                  Left            =   1110
                  TabIndex        =   85
                  Top             =   1320
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequence A"
                  Height          =   315
                  Index           =   0
                  Left            =   1050
                  TabIndex        =   84
                  Top             =   780
                  Width           =   1125
               End
               Begin VB.Line Line6 
                  Index           =   0
                  X1              =   480
                  X2              =   960
                  Y1              =   1950
                  Y2              =   1950
               End
               Begin VB.Line Line5 
                  X1              =   480
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1950
               End
               Begin VB.Line Line4 
                  X1              =   630
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1140
               End
               Begin VB.Line Line3 
                  X1              =   630
                  X2              =   960
                  Y1              =   870
                  Y2              =   870
               End
               Begin VB.Line Line2 
                  X1              =   630
                  X2              =   930
                  Y1              =   1440
                  Y2              =   1440
               End
               Begin VB.Line Line1 
                  X1              =   630
                  X2              =   630
                  Y1              =   870
                  Y2              =   1440
               End
            End
            Begin VB.Frame Frame4 
               BeginProperty Font 
                  Name            =   "Courier"
                  Size            =   9.75
                  Charset         =   0
                  Weight          =   400
                  Underline       =   0   'False
                  Italic          =   0   'False
                  Strikethrough   =   0   'False
               EndProperty
               Height          =   2715
               Index           =   4
               Left            =   3450
               TabIndex        =   78
               Top             =   390
               Visible         =   0   'False
               Width           =   2535
               Begin VB.Label Label13 
                  Caption         =   "Sequence D"
                  ForeColor       =   &H000000FF&
                  Height          =   225
                  Left            =   1080
                  TabIndex        =   82
                  Top             =   2280
                  Width           =   1005
               End
               Begin VB.Line Line43 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   960
                  Y1              =   2400
                  Y2              =   2400
               End
               Begin VB.Line Line42 
                  BorderColor     =   &H000000FF&
                  X1              =   330
                  X2              =   330
                  Y1              =   1560
                  Y2              =   2400
               End
               Begin VB.Line Line41 
                  BorderColor     =   &H000000FF&
                  X1              =   480
                  X2              =   330
                  Y1              =   1560
                  Y2              =   1560
               End
               Begin VB.Line Line40 
                  X1              =   630
                  X2              =   630
                  Y1              =   870
                  Y2              =   1440
               End
               Begin VB.Line Line39 
                  X1              =   630
                  X2              =   930
                  Y1              =   1440
                  Y2              =   1440
               End
               Begin VB.Line Line38 
                  X1              =   630
                  X2              =   960
                  Y1              =   870
                  Y2              =   870
               End
               Begin VB.Line Line37 
                  X1              =   630
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1140
               End
               Begin VB.Line Line28 
                  X1              =   480
                  X2              =   480
                  Y1              =   1140
                  Y2              =   1950
               End
               Begin VB.Line Line6 
                  BorderColor     =   &H00000000&
                  Index           =   4
                  X1              =   480
                  X2              =   960
                  Y1              =   1950
                  Y2              =   1950
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequqence A"
                  Height          =   315
                  Index           =   14
                  Left            =   1020
                  TabIndex        =   81
                  Top             =   780
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequqence B"
                  Height          =   315
                  Index           =   13
                  Left            =   1080
                  TabIndex        =   80
                  Top             =   1320
                  Width           =   1125
               End
               Begin VB.Label Label8 
                  Caption         =   "Sequqence C"
                  Height          =   315
                  Index           =   12
                  Left            =   1020
                  TabIndex        =   79
                  Top             =   1800
                  Width           =   1125
               End
            End
            Begin VB.Label Label7 
               Caption         =   "External references only"
               Height          =   255
               Left            =   390
               TabIndex        =   113
               Top             =   1590
               Width           =   2205
            End
            Begin VB.Label Label6 
               Caption         =   "Internal and external references"
               Height          =   255
               Left            =   450
               TabIndex        =   112
               Top             =   990
               Width           =   2475
            End
            Begin VB.Label Label5 
               Caption         =   "Internal references only"
               Height          =   285
               Left            =   420
               TabIndex        =   111
               Top             =   540
               Width           =   2235
            End
            Begin VB.Label Label4 
               Caption         =   "No reference"
               Height          =   315
               Left            =   630
               TabIndex        =   110
               Top             =   210
               Width           =   1065
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   555
         Index           =   7
         Left            =   1800
         TabIndex        =   161
         Top             =   1200
         Visible         =   0   'False
         Width           =   1245
         Begin VB.Frame Frame19 
            Caption         =   "Model"
            Height          =   3255
            Left            =   480
            TabIndex        =   162
            Top             =   240
            Width           =   7245
            Begin VB.Frame Frame21 
               Caption         =   "Rate matrix coefficients"
               Height          =   1275
               Index           =   2
               Left            =   180
               TabIndex        =   194
               Top             =   1740
               Width           =   3435
               Begin VB.TextBox Text23 
                  BackColor       =   &H80000004&
                  Enabled         =   0   'False
                  ForeColor       =   &H80000003&
                  Height          =   315
                  Index           =   17
                  Left            =   2430
                  TabIndex        =   205
                  Text            =   "Text23"
                  Top             =   990
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   16
                  Left            =   960
                  TabIndex        =   204
                  Text            =   "Text23"
                  Top             =   1020
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   15
                  Left            =   780
                  TabIndex        =   198
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   14
                  Left            =   2070
                  TabIndex        =   197
                  Text            =   "Text23"
                  Top             =   300
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   13
                  Left            =   810
                  TabIndex        =   196
                  Text            =   "Text23"
                  Top             =   300
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   12
                  Left            =   1980
                  TabIndex        =   195
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G - T"
                  Height          =   345
                  Index           =   19
                  Left            =   1530
                  TabIndex        =   206
                  Top             =   1110
                  Width           =   675
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A - T"
                  Height          =   345
                  Index           =   18
                  Left            =   90
                  TabIndex        =   203
                  Top             =   720
                  Width           =   1035
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A - G"
                  Height          =   345
                  Index           =   17
                  Left            =   1410
                  TabIndex        =   202
                  Top             =   270
                  Width           =   585
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A - C"
                  Height          =   345
                  Index           =   16
                  Left            =   120
                  TabIndex        =   201
                  Top             =   360
                  Width           =   645
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C - G"
                  Height          =   345
                  Index           =   15
                  Left            =   1410
                  TabIndex        =   200
                  Top             =   720
                  Width           =   525
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C - T"
                  Height          =   345
                  Index           =   14
                  Left            =   90
                  TabIndex        =   199
                  Top             =   990
                  Width           =   675
               End
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   11
               Left            =   3120
               TabIndex        =   191
               Text            =   "Text23"
               Top             =   1440
               Width           =   465
            End
            Begin VB.Frame Frame21 
               Caption         =   "Base frequencies"
               Height          =   1485
               Index           =   1
               Left            =   3960
               TabIndex        =   181
               Top             =   240
               Width           =   2715
               Begin VB.CommandButton Command28 
                  Height          =   285
                  Index           =   11
                  Left            =   2250
                  MouseIcon       =   "OptionsForm2.frx":5899
                  MousePointer    =   99  'Custom
                  Picture         =   "OptionsForm2.frx":59EB
                  Style           =   1  'Graphical
                  TabIndex        =   193
                  Top             =   150
                  Width           =   315
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   10
                  Left            =   1980
                  TabIndex        =   189
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   9
                  Left            =   570
                  TabIndex        =   184
                  Text            =   "Text23"
                  Top             =   300
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   8
                  Left            =   2100
                  TabIndex        =   183
                  Text            =   "Text23"
                  Top             =   300
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   7
                  Left            =   480
                  TabIndex        =   182
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Estimate from alignment"
                  Height          =   345
                  Index           =   13
                  Left            =   90
                  TabIndex        =   192
                  Top             =   1170
                  Width           =   1965
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "T"
                  Height          =   345
                  Index           =   11
                  Left            =   1380
                  TabIndex        =   188
                  Top             =   780
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A"
                  Height          =   345
                  Index           =   10
                  Left            =   120
                  TabIndex        =   187
                  Top             =   360
                  Width           =   255
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C"
                  Height          =   345
                  Index           =   9
                  Left            =   1410
                  TabIndex        =   186
                  Top             =   270
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G"
                  Height          =   345
                  Index           =   8
                  Left            =   90
                  TabIndex        =   185
                  Top             =   720
                  Width           =   1035
               End
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   6
               Left            =   3210
               TabIndex        =   180
               Text            =   "Text23"
               Top             =   1140
               Width           =   465
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   5
               Left            =   3210
               TabIndex        =   177
               Text            =   "Text23"
               Top             =   750
               Width           =   465
            End
            Begin VB.Frame Frame21 
               Caption         =   "Rates at different codon positions"
               Height          =   975
               Index           =   0
               Left            =   3750
               TabIndex        =   170
               Top             =   1920
               Width           =   3195
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   4
                  Left            =   2250
                  TabIndex        =   176
                  Text            =   "Text23"
                  Top             =   840
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   3
                  Left            =   2310
                  TabIndex        =   175
                  Text            =   "Text23"
                  Top             =   570
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   2
                  Left            =   2340
                  TabIndex        =   174
                  Text            =   "Text23"
                  Top             =   210
                  Width           =   465
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Position 3"
                  Height          =   345
                  Index           =   5
                  Left            =   150
                  TabIndex        =   173
                  Top             =   720
                  Width           =   1035
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Position 2"
                  Height          =   345
                  Index           =   4
                  Left            =   240
                  TabIndex        =   172
                  Top             =   450
                  Width           =   1035
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Position 1"
                  Height          =   345
                  Index           =   3
                  Left            =   180
                  TabIndex        =   171
                  Top             =   240
                  Width           =   975
               End
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   10
               Left            =   3240
               MouseIcon       =   "OptionsForm2.frx":5CF5
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":5E47
               Style           =   1  'Graphical
               TabIndex        =   164
               Top             =   360
               Width           =   315
            End
            Begin VB.Label Label21 
               Caption         =   "Transition:Transversion ratio"
               Height          =   345
               Index           =   12
               Left            =   120
               TabIndex        =   190
               Top             =   1440
               Width           =   2985
            End
            Begin VB.Label Label21 
               Caption         =   "Gama shape for site r. heterogeneity"
               Height          =   345
               Index           =   7
               Left            =   180
               TabIndex        =   179
               Top             =   1110
               Width           =   2985
            End
            Begin VB.Label Label21 
               Caption         =   "# Categs for gamma r. heterogeneity"
               Height          =   345
               Index           =   6
               Left            =   150
               TabIndex        =   178
               Top             =   780
               Width           =   2985
            End
            Begin VB.Label Label21 
               Caption         =   "Hasegawa, Kishino and Yano, 1985"
               Height          =   345
               Index           =   0
               Left            =   360
               TabIndex        =   163
               Top             =   300
               Width           =   2715
            End
         End
         Begin VB.Frame Frame20 
            Caption         =   "Scan Options"
            Height          =   1395
            Left            =   240
            TabIndex        =   165
            Top             =   3720
            Width           =   6705
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   41
               Left            =   5640
               MouseIcon       =   "OptionsForm2.frx":6151
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":62A3
               Style           =   1  'Graphical
               TabIndex        =   396
               Top             =   720
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   40
               Left            =   5640
               MouseIcon       =   "OptionsForm2.frx":65AD
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":66FF
               Style           =   1  'Graphical
               TabIndex        =   395
               Top             =   240
               Width           =   315
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   1
               Left            =   2400
               TabIndex        =   169
               Text            =   "Text23"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   720
               Width           =   465
            End
            Begin VB.TextBox Text23 
               Height          =   315
               Index           =   0
               Left            =   2490
               TabIndex        =   168
               Text            =   "Text23"
               Top             =   300
               Width           =   465
            End
            Begin VB.Label Label21 
               Caption         =   "Window size"
               Height          =   285
               Index           =   41
               Left            =   240
               TabIndex        =   394
               Top             =   720
               Width           =   2325
            End
            Begin VB.Label Label21 
               Caption         =   "Sliding partition scan"
               Height          =   285
               Index           =   40
               Left            =   3360
               TabIndex        =   393
               Top             =   720
               Width           =   2325
            End
            Begin VB.Label Label21 
               Caption         =   "Test one breakpoint"
               Height          =   285
               Index           =   2
               Left            =   3480
               TabIndex        =   167
               Top             =   300
               Width           =   2325
            End
            Begin VB.Label Label21 
               Caption         =   "Step Size"
               Height          =   285
               Index           =   1
               Left            =   240
               TabIndex        =   166
               Top             =   300
               Width           =   2325
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   3405
         Index           =   8
         Left            =   6000
         TabIndex        =   213
         Top             =   1440
         Visible         =   0   'False
         Width           =   5565
         Begin VB.Frame Frame25 
            Caption         =   "Matrix Drawing Options"
            Height          =   2535
            Index           =   0
            Left            =   720
            TabIndex        =   237
            Top             =   600
            Width           =   5175
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   9
               Left            =   2400
               TabIndex        =   491
               Top             =   1560
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   8
               Left            =   2760
               TabIndex        =   490
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   7
               Left            =   2640
               TabIndex        =   489
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   6
               Left            =   2760
               TabIndex        =   488
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   5
               Left            =   2160
               TabIndex        =   487
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   4
               Left            =   3000
               TabIndex        =   486
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   3
               Left            =   2760
               TabIndex        =   485
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   2
               Left            =   2280
               TabIndex        =   484
               Top             =   1200
               Width           =   975
            End
            Begin VB.ComboBox Combo1 
               Height          =   315
               Left            =   2040
               TabIndex        =   482
               Top             =   0
               Width           =   1455
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   19
               Left            =   3360
               MouseIcon       =   "OptionsForm2.frx":6A09
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":6B5B
               Style           =   1  'Graphical
               TabIndex        =   392
               Top             =   1560
               Width           =   315
            End
            Begin VB.PictureBox Picture1 
               Height          =   255
               Left            =   1320
               ScaleHeight     =   195
               ScaleWidth      =   1395
               TabIndex        =   390
               Top             =   1800
               Width           =   1455
            End
            Begin VB.ComboBox Combo2 
               Height          =   315
               Left            =   2640
               TabIndex        =   388
               Top             =   720
               Width           =   1455
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   1
               Left            =   1800
               TabIndex        =   387
               Top             =   1200
               Width           =   975
            End
            Begin VB.TextBox Text5 
               Height          =   285
               Index           =   0
               Left            =   1800
               TabIndex        =   386
               Top             =   840
               Width           =   975
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   15
               Left            =   2970
               MouseIcon       =   "OptionsForm2.frx":6E65
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":6FB7
               Style           =   1  'Graphical
               TabIndex        =   238
               Top             =   330
               Width           =   315
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Step size"
               Height          =   285
               Index           =   73
               Left            =   120
               TabIndex        =   492
               Top             =   1560
               Width           =   2625
            End
            Begin VB.Label Label3 
               Caption         =   "Matrix type"
               Height          =   255
               Left            =   240
               TabIndex        =   483
               Top             =   720
               Width           =   1335
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Colour scale"
               Height          =   285
               Index           =   58
               Left            =   120
               TabIndex        =   391
               Top             =   1800
               Width           =   2625
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Type sequence"
               Height          =   285
               Index           =   22
               Left            =   120
               TabIndex        =   389
               Top             =   240
               Width           =   2625
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Window size"
               Height          =   285
               Index           =   57
               Left            =   120
               TabIndex        =   385
               Top             =   1320
               Width           =   2625
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Permutations"
               Height          =   285
               Index           =   26
               Left            =   240
               TabIndex        =   384
               Top             =   960
               Width           =   2625
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Use only binary sites"
               Height          =   285
               Index           =   17
               Left            =   120
               TabIndex        =   239
               Top             =   480
               Width           =   3225
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1035
         Index           =   14
         Left            =   6480
         TabIndex        =   470
         Top             =   4560
         Visible         =   0   'False
         Width           =   1305
         Begin VB.Frame Frame28 
            Caption         =   "Scan Options"
            Height          =   1755
            Index           =   1
            Left            =   120
            TabIndex        =   471
            Top             =   120
            Width           =   3585
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   44
               Left            =   2460
               TabIndex        =   472
               Text            =   "400"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   720
               Width           =   735
            End
            Begin VB.Label Label1 
               Caption         =   "Window Size"
               Height          =   285
               Index           =   70
               Left            =   600
               TabIndex        =   473
               Top             =   720
               Width           =   3105
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   825
         Index           =   3
         Left            =   9720
         TabIndex        =   124
         Top             =   5520
         Visible         =   0   'False
         Width           =   1065
         Begin VB.Frame Frame17 
            Caption         =   "Re-Bootscan Check Options"
            Height          =   1065
            Left            =   6480
            TabIndex        =   137
            Top             =   2280
            Visible         =   0   'False
            Width           =   1125
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   25
               Left            =   2460
               MouseIcon       =   "OptionsForm2.frx":72C1
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":7413
               Style           =   1  'Graphical
               TabIndex        =   290
               Top             =   1230
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   10
               Left            =   2580
               TabIndex        =   148
               Text            =   "Text1"
               Top             =   900
               Width           =   795
            End
            Begin VB.CheckBox Check8 
               Caption         =   "Increase scan resolution in putative recombinant region"
               Height          =   405
               Left            =   420
               TabIndex        =   145
               Top             =   2100
               Width           =   2925
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   7
               Left            =   2010
               TabIndex        =   144
               Text            =   "Text1"
               Top             =   570
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   6
               Left            =   2070
               TabIndex        =   142
               Text            =   "Text1"
               Top             =   240
               Width           =   795
            End
            Begin VB.Frame Frame18 
               Height          =   1845
               Left            =   120
               TabIndex        =   139
               Top             =   2130
               Width           =   3285
               Begin VB.TextBox Text1 
                  Height          =   345
                  Index           =   12
                  Left            =   2100
                  TabIndex        =   157
                  Text            =   "Text1"
                  Top             =   870
                  Visible         =   0   'False
                  Width           =   795
               End
               Begin VB.TextBox Text1 
                  Height          =   345
                  Index           =   11
                  Left            =   2220
                  TabIndex        =   155
                  Text            =   "Text1"
                  Top             =   600
                  Visible         =   0   'False
                  Width           =   795
               End
               Begin VB.TextBox Text1 
                  Height          =   285
                  Index           =   9
                  Left            =   2610
                  TabIndex        =   147
                  Text            =   "Text1"
                  Top             =   1200
                  Width           =   795
               End
               Begin VB.TextBox Text1 
                  Height          =   345
                  Index           =   8
                  Left            =   2190
                  TabIndex        =   146
                  Text            =   "Text1"
                  Top             =   300
                  Width           =   795
               End
               Begin VB.Label Label1 
                  Caption         =   "Spanning region that is scanned at higher resolution"
                  Height          =   495
                  Index           =   10
                  Left            =   240
                  TabIndex        =   158
                  Top             =   1260
                  Width           =   2415
               End
               Begin VB.Label Label1 
                  Caption         =   "Bootstrap replicates"
                  Height          =   285
                  Index           =   15
                  Left            =   120
                  TabIndex        =   156
                  Top             =   990
                  Visible         =   0   'False
                  Width           =   1785
               End
               Begin VB.Label Label1 
                  Caption         =   "Window size"
                  Height          =   285
                  Index           =   14
                  Left            =   180
                  TabIndex        =   154
                  Top             =   690
                  Visible         =   0   'False
                  Width           =   1785
               End
               Begin VB.Label Label1 
                  Caption         =   "Step size"
                  Height          =   285
                  Index           =   7
                  Left            =   150
                  TabIndex        =   140
                  Top             =   390
                  Width           =   1785
               End
            End
            Begin VB.CheckBox Check7 
               Caption         =   "Center window on putative recombinant region"
               Height          =   645
               Left            =   390
               TabIndex        =   138
               Top             =   1440
               Width           =   2385
            End
            Begin VB.Label Label1 
               Caption         =   "Use Distances"
               Height          =   285
               Index           =   38
               Left            =   240
               TabIndex        =   291
               Top             =   1170
               Width           =   3165
            End
            Begin VB.Label Label1 
               Caption         =   "Number of bootstrap replicates"
               Height          =   285
               Index           =   12
               Left            =   150
               TabIndex        =   149
               Top             =   960
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Step size"
               Height          =   285
               Index           =   9
               Left            =   210
               TabIndex        =   143
               Top             =   630
               Width           =   2205
            End
            Begin VB.Label Label1 
               Caption         =   "Window size"
               Height          =   285
               Index           =   8
               Left            =   90
               TabIndex        =   141
               Top             =   330
               Width           =   1785
            End
         End
         Begin VB.Frame Frame7 
            Caption         =   "Model Options"
            Height          =   2205
            Index           =   0
            Left            =   3720
            TabIndex        =   130
            Top             =   360
            Width           =   2865
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   28
               Left            =   2460
               TabIndex        =   292
               Text            =   "Text1"
               Top             =   630
               Width           =   795
            End
            Begin VB.Frame Frame21 
               Caption         =   "Base frequencies"
               Height          =   975
               Index           =   5
               Left            =   240
               TabIndex        =   279
               Top             =   1080
               Width           =   2715
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   28
                  Left            =   1800
                  TabIndex        =   448
                  Text            =   "Text23"
                  Top             =   360
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   27
                  Left            =   600
                  TabIndex        =   445
                  Text            =   "Text23"
                  Top             =   360
                  Width           =   465
               End
               Begin VB.CommandButton Command28 
                  Height          =   285
                  Index           =   24
                  Left            =   2220
                  MouseIcon       =   "OptionsForm2.frx":771D
                  MousePointer    =   99  'Custom
                  Picture         =   "OptionsForm2.frx":786F
                  Style           =   1  'Graphical
                  TabIndex        =   282
                  Top             =   150
                  Width           =   315
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   29
                  Left            =   1980
                  TabIndex        =   281
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   26
                  Left            =   480
                  TabIndex        =   280
                  Text            =   "Text23"
                  Top             =   720
                  Width           =   465
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C"
                  Height          =   345
                  Index           =   32
                  Left            =   0
                  TabIndex        =   447
                  Top             =   240
                  Width           =   2535
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A"
                  Height          =   345
                  Index           =   31
                  Left            =   0
                  TabIndex        =   446
                  Top             =   0
                  Width           =   2715
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Estimate from alignment"
                  Height          =   345
                  Index           =   34
                  Left            =   90
                  TabIndex        =   285
                  Top             =   1170
                  Width           =   1965
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "T"
                  Height          =   345
                  Index           =   33
                  Left            =   1380
                  TabIndex        =   284
                  Top             =   810
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G"
                  Height          =   345
                  Index           =   30
                  Left            =   90
                  TabIndex        =   283
                  Top             =   720
                  Width           =   1035
               End
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   4
               Left            =   2460
               TabIndex        =   133
               Text            =   "Text1"
               Top             =   480
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   9
               Left            =   2730
               MouseIcon       =   "OptionsForm2.frx":7B79
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":7CCB
               Style           =   1  'Graphical
               TabIndex        =   132
               Top             =   150
               Width           =   315
            End
            Begin VB.Label Label1 
               Caption         =   "Coefficient of variation"
               Height          =   285
               Index           =   39
               Left            =   180
               TabIndex        =   293
               Top             =   720
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Transition:transversion rate ratio"
               Height          =   285
               Index           =   5
               Left            =   180
               TabIndex        =   134
               Top             =   570
               Width           =   2445
            End
            Begin VB.Label Label1 
               Caption         =   "Use Kimura two parameter model"
               Height          =   285
               Index           =   4
               Left            =   120
               TabIndex        =   131
               Top             =   270
               Width           =   2565
            End
         End
         Begin VB.Frame Frame5 
            Caption         =   "Scan Options"
            Height          =   2895
            Left            =   240
            TabIndex        =   125
            Top             =   240
            Width           =   3465
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   28
               Left            =   2340
               MouseIcon       =   "OptionsForm2.frx":7FD5
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":8127
               Style           =   1  'Graphical
               TabIndex        =   334
               Top             =   2340
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   2
               Left            =   2400
               TabIndex        =   287
               Text            =   "Text1"
               Top             =   1440
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   3
               Left            =   2400
               TabIndex        =   286
               Text            =   "Text1"
               Top             =   1860
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   23
               Left            =   2490
               MouseIcon       =   "OptionsForm2.frx":8431
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":8583
               Style           =   1  'Graphical
               TabIndex        =   278
               Top             =   1110
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   5
               Left            =   2550
               TabIndex        =   136
               Text            =   "Text1"
               Top             =   870
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   1
               Left            =   2580
               TabIndex        =   129
               Text            =   "Text1"
               Top             =   540
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   0
               Left            =   2580
               TabIndex        =   128
               Text            =   "Text1"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   270
               Width           =   735
            End
            Begin VB.Label Label1 
               Caption         =   "Use bootsrap value as P-value "
               Height          =   285
               Index           =   48
               Left            =   150
               TabIndex        =   335
               Top             =   2280
               Width           =   3165
            End
            Begin VB.Label Label1 
               Caption         =   "Number of bootstrap replicates"
               Height          =   285
               Index           =   2
               Left            =   60
               TabIndex        =   289
               Top             =   1530
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Random number seed"
               Height          =   285
               Index           =   3
               Left            =   90
               TabIndex        =   288
               Top             =   1860
               Width           =   2565
            End
            Begin VB.Label Label1 
               Caption         =   "Use Distances"
               Height          =   285
               Index           =   37
               Left            =   270
               TabIndex        =   277
               Top             =   1050
               Width           =   3165
            End
            Begin VB.Label Label1 
               Caption         =   "Cutoff percentage"
               Height          =   285
               Index           =   6
               Left            =   240
               TabIndex        =   135
               Top             =   780
               Width           =   1785
            End
            Begin VB.Label Label1 
               Caption         =   "Step size"
               Height          =   285
               Index           =   1
               Left            =   240
               TabIndex        =   127
               Top             =   540
               Width           =   2205
            End
            Begin VB.Label Label1 
               Caption         =   "Window size"
               Height          =   285
               Index           =   0
               Left            =   300
               TabIndex        =   126
               Top             =   360
               Width           =   1785
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   825
         Index           =   9
         Left            =   3960
         TabIndex        =   214
         Top             =   4200
         Visible         =   0   'False
         Width           =   615
         Begin VB.Frame Frame24 
            Caption         =   "Scan Options"
            Height          =   1035
            Index           =   0
            Left            =   30
            TabIndex        =   215
            Top             =   210
            Width           =   2865
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   14
               Left            =   1920
               TabIndex        =   220
               Text            =   "Text1"
               Top             =   660
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   13
               Left            =   2010
               TabIndex        =   218
               Text            =   "Text1"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   360
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   16
               Left            =   2070
               MouseIcon       =   "OptionsForm2.frx":888D
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":89DF
               Style           =   1  'Graphical
               TabIndex        =   216
               Top             =   1260
               Width           =   315
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Step size"
               Height          =   285
               Index           =   19
               Left            =   0
               TabIndex        =   219
               Top             =   600
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Window size"
               Height          =   285
               Index           =   18
               Left            =   270
               TabIndex        =   217
               Top             =   450
               Width           =   2355
            End
         End
         Begin VB.Frame Frame24 
            Caption         =   "Model Options"
            Height          =   2445
            Index           =   1
            Left            =   120
            TabIndex        =   221
            Top             =   1080
            Width           =   4185
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   29
               Left            =   2340
               TabIndex        =   294
               Text            =   "Text1"
               Top             =   870
               Width           =   795
            End
            Begin VB.Frame Frame21 
               Caption         =   "Base frequencies"
               Height          =   1485
               Index           =   3
               Left            =   0
               TabIndex        =   226
               Top             =   1290
               Width           =   2715
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   21
                  Left            =   480
                  TabIndex        =   231
                  Text            =   "Text23"
                  Top             =   720
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   20
                  Left            =   2100
                  TabIndex        =   230
                  Text            =   "Text23"
                  Top             =   300
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   19
                  Left            =   570
                  TabIndex        =   229
                  Text            =   "Text23"
                  Top             =   330
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   18
                  Left            =   1980
                  TabIndex        =   228
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.CommandButton Command28 
                  Height          =   285
                  Index           =   17
                  Left            =   2250
                  MouseIcon       =   "OptionsForm2.frx":8CE9
                  MousePointer    =   99  'Custom
                  Picture         =   "OptionsForm2.frx":8E3B
                  Style           =   1  'Graphical
                  TabIndex        =   227
                  Top             =   150
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G"
                  Height          =   345
                  Index           =   24
                  Left            =   90
                  TabIndex        =   236
                  Top             =   720
                  Width           =   1035
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C"
                  Height          =   345
                  Index           =   23
                  Left            =   1410
                  TabIndex        =   235
                  Top             =   270
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A"
                  Height          =   345
                  Index           =   22
                  Left            =   120
                  TabIndex        =   234
                  Top             =   360
                  Width           =   255
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "T"
                  Height          =   345
                  Index           =   21
                  Left            =   1380
                  TabIndex        =   233
                  Top             =   780
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Estimate from alignment"
                  Height          =   345
                  Index           =   20
                  Left            =   90
                  TabIndex        =   232
                  Top             =   1170
                  Width           =   1965
               End
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   18
               Left            =   2220
               MouseIcon       =   "OptionsForm2.frx":9145
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":9297
               Style           =   1  'Graphical
               TabIndex        =   225
               Top             =   420
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   15
               Left            =   1710
               TabIndex        =   222
               Text            =   "Text1"
               Top             =   720
               Width           =   795
            End
            Begin VB.Label Label1 
               Caption         =   "Coefficient of variation"
               Height          =   285
               Index           =   40
               Left            =   60
               TabIndex        =   295
               Top             =   960
               Width           =   2445
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Kimura 2-Parameter"
               Height          =   285
               Index           =   21
               Left            =   210
               TabIndex        =   224
               Top             =   450
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Transition:transversion rate ratio"
               Height          =   315
               Index           =   20
               Left            =   150
               TabIndex        =   223
               Top             =   660
               Width           =   2355
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1335
         Index           =   10
         Left            =   3000
         TabIndex        =   241
         Top             =   2520
         Visible         =   0   'False
         Width           =   2715
         Begin VB.Frame Frame24 
            Caption         =   "Scan Options"
            Height          =   1425
            Index           =   3
            Left            =   240
            TabIndex        =   258
            Top             =   240
            Width           =   2145
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   23
               Left            =   1890
               TabIndex        =   264
               Text            =   "Text1"
               Top             =   1050
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   22
               Left            =   2010
               TabIndex        =   260
               Text            =   "Text1"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   360
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   19
               Left            =   1950
               TabIndex        =   259
               Text            =   "Text1"
               Top             =   660
               Width           =   795
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Smoothing window"
               Height          =   285
               Index           =   31
               Left            =   60
               TabIndex        =   263
               Top             =   990
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Window size"
               Height          =   285
               Index           =   30
               Left            =   270
               TabIndex        =   262
               Top             =   450
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Step size"
               Height          =   285
               Index           =   29
               Left            =   120
               TabIndex        =   261
               Top             =   660
               Width           =   2355
            End
         End
         Begin VB.Frame Frame24 
            Caption         =   "Parametric Bootstrapping Options"
            Height          =   975
            Index           =   5
            Left            =   150
            TabIndex        =   272
            Top             =   2730
            Width           =   3285
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   24
               Left            =   2340
               TabIndex        =   275
               Text            =   "Text1"
               Top             =   630
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   27
               Left            =   2490
               TabIndex        =   273
               Text            =   "Text1"
               Top             =   270
               Width           =   795
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "P-Value cutoff"
               Height          =   285
               Index           =   35
               Left            =   60
               TabIndex        =   276
               Top             =   630
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Number of simulated datasets"
               Height          =   285
               Index           =   36
               Left            =   150
               TabIndex        =   274
               Top             =   300
               Width           =   2355
            End
         End
         Begin VB.Frame Frame24 
            Caption         =   "Tree Options"
            Height          =   1215
            Index           =   4
            Left            =   90
            TabIndex        =   265
            Top             =   1320
            Width           =   2565
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   22
               Left            =   2160
               MouseIcon       =   "OptionsForm2.frx":95A1
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":96F3
               Style           =   1  'Graphical
               TabIndex        =   271
               Top             =   180
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   26
               Left            =   1800
               TabIndex        =   267
               Text            =   "Text1"
               Top             =   840
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   25
               Left            =   1710
               TabIndex        =   266
               Text            =   "Text1"
               Top             =   510
               Width           =   795
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Construct NJ and LS trees"
               Height          =   285
               Index           =   34
               Left            =   120
               TabIndex        =   270
               Top             =   240
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Power"
               Height          =   285
               Index           =   33
               Left            =   210
               TabIndex        =   269
               Top             =   480
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Random number seed"
               Height          =   285
               Index           =   32
               Left            =   60
               TabIndex        =   268
               Top             =   810
               Width           =   2355
            End
         End
         Begin VB.Frame Frame24 
            Caption         =   "Model Options"
            Height          =   2415
            Index           =   2
            Left            =   2370
            TabIndex        =   242
            Top             =   210
            Width           =   4215
            Begin VB.TextBox Text1 
               Height          =   345
               Index           =   30
               Left            =   2250
               TabIndex        =   296
               Text            =   "Text1"
               Top             =   120
               Width           =   795
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   16
               Left            =   1710
               TabIndex        =   255
               Text            =   "Text1"
               Top             =   720
               Width           =   795
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   21
               Left            =   2220
               MouseIcon       =   "OptionsForm2.frx":99FD
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":9B4F
               Style           =   1  'Graphical
               TabIndex        =   254
               Top             =   420
               Width           =   315
            End
            Begin VB.Frame Frame21 
               Caption         =   "Base frequencies"
               Height          =   1485
               Index           =   4
               Left            =   540
               TabIndex        =   243
               Top             =   960
               Width           =   2835
               Begin VB.CommandButton Command28 
                  Height          =   285
                  Index           =   20
                  Left            =   2250
                  MouseIcon       =   "OptionsForm2.frx":9E59
                  MousePointer    =   99  'Custom
                  Picture         =   "OptionsForm2.frx":9FAB
                  Style           =   1  'Graphical
                  TabIndex        =   248
                  Top             =   150
                  Width           =   315
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   25
                  Left            =   1980
                  TabIndex        =   247
                  Text            =   "Text23"
                  Top             =   690
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   24
                  Left            =   600
                  TabIndex        =   246
                  Text            =   "Text23"
                  Top             =   330
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   23
                  Left            =   2100
                  TabIndex        =   245
                  Text            =   "Text23"
                  Top             =   330
                  Width           =   465
               End
               Begin VB.TextBox Text23 
                  Height          =   315
                  Index           =   22
                  Left            =   480
                  TabIndex        =   244
                  Text            =   "Text23"
                  Top             =   720
                  Width           =   465
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "Estimate from alignment"
                  Height          =   345
                  Index           =   29
                  Left            =   120
                  TabIndex        =   253
                  Top             =   1080
                  Width           =   1965
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "T"
                  Height          =   345
                  Index           =   28
                  Left            =   1380
                  TabIndex        =   252
                  Top             =   810
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "A"
                  Height          =   345
                  Index           =   27
                  Left            =   120
                  TabIndex        =   251
                  Top             =   360
                  Width           =   255
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "C"
                  Height          =   345
                  Index           =   26
                  Left            =   1410
                  TabIndex        =   250
                  Top             =   270
                  Width           =   315
               End
               Begin VB.Label Label21 
                  BackStyle       =   0  'Transparent
                  Caption         =   "G"
                  Height          =   345
                  Index           =   25
                  Left            =   90
                  TabIndex        =   249
                  Top             =   750
                  Width           =   1035
               End
            End
            Begin VB.Label Label1 
               Caption         =   "Coefficient of variation"
               Height          =   285
               Index           =   41
               Left            =   300
               TabIndex        =   297
               Top             =   210
               Width           =   2445
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Transition:transversion rate ratio"
               Height          =   315
               Index           =   28
               Left            =   150
               TabIndex        =   257
               Top             =   660
               Width           =   2355
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Kimura 2-Parameter"
               Height          =   285
               Index           =   25
               Left            =   210
               TabIndex        =   256
               Top             =   450
               Width           =   2355
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1245
         Index           =   13
         Left            =   480
         TabIndex        =   370
         Top             =   2040
         Visible         =   0   'False
         Width           =   1725
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   2
            Left            =   2760
            TabIndex        =   428
            Text            =   "Text6"
            Top             =   600
            Width           =   855
         End
         Begin VB.CommandButton Command28 
            Height          =   285
            Index           =   42
            Left            =   3120
            MouseIcon       =   "OptionsForm2.frx":A2B5
            MousePointer    =   99  'Custom
            Picture         =   "OptionsForm2.frx":A407
            Style           =   1  'Graphical
            TabIndex        =   426
            Top             =   1200
            Width           =   315
         End
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   5
            Left            =   2760
            TabIndex        =   425
            Text            =   "Text6"
            ToolTipText     =   "Value must be 100 000 or larger"
            Top             =   1800
            Width           =   855
         End
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   4
            Left            =   2880
            TabIndex        =   423
            Text            =   "Text6"
            Top             =   1440
            Width           =   855
         End
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   3
            Left            =   2880
            TabIndex        =   421
            Text            =   "Text6"
            Top             =   960
            Width           =   855
         End
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   1
            Left            =   2760
            TabIndex        =   418
            Text            =   "Text6"
            Top             =   360
            Width           =   855
         End
         Begin VB.TextBox Text6 
            Height          =   285
            Index           =   0
            Left            =   2880
            TabIndex        =   416
            Text            =   "Text6"
            Top             =   120
            Width           =   855
         End
         Begin VB.Label Label2 
            Caption         =   "MCMC Updates"
            Height          =   375
            Index           =   6
            Left            =   240
            TabIndex        =   427
            Top             =   1920
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Average tract length"
            Height          =   375
            Index           =   5
            Left            =   240
            TabIndex        =   424
            Top             =   1680
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Use gene conversion model"
            Height          =   375
            Index           =   4
            Left            =   120
            TabIndex        =   422
            Top             =   1440
            Width           =   2775
         End
         Begin VB.Label Label2 
            Caption         =   "Gap frequency cutoff"
            Height          =   375
            Index           =   3
            Left            =   240
            TabIndex        =   420
            Top             =   960
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Minor allele frequency cutoff"
            Height          =   375
            Index           =   2
            Left            =   240
            TabIndex        =   419
            Top             =   720
            Width           =   2415
         End
         Begin VB.Label Label2 
            Caption         =   "Block Penalty"
            Height          =   375
            Index           =   1
            Left            =   240
            TabIndex        =   417
            Top             =   480
            Width           =   1935
         End
         Begin VB.Label Label2 
            Caption         =   "Starting Rho"
            Height          =   375
            Index           =   0
            Left            =   240
            TabIndex        =   415
            Top             =   240
            Width           =   2295
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1275
         Index           =   5
         Left            =   360
         TabIndex        =   159
         Top             =   600
         Visible         =   0   'False
         Width           =   1185
         Begin VB.Frame Frame28 
            Caption         =   "Scan Options"
            Height          =   1155
            Index           =   0
            Left            =   120
            TabIndex        =   362
            Top             =   600
            Width           =   3585
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   36
               Left            =   2460
               TabIndex        =   364
               Text            =   "Text1"
               ToolTipText     =   "For each trplet examined the number of variable sites per window"
               Top             =   720
               Width           =   735
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   39
               Left            =   2850
               MouseIcon       =   "OptionsForm2.frx":A711
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":A863
               Style           =   1  'Graphical
               TabIndex        =   363
               Top             =   360
               Width           =   315
            End
            Begin VB.Label Label1 
               Caption         =   "Variable sites per window"
               Height          =   285
               Index           =   56
               Left            =   660
               TabIndex        =   366
               Top             =   720
               Width           =   3105
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Set window size"
               Height          =   285
               Index           =   55
               Left            =   570
               TabIndex        =   365
               Top             =   390
               Width           =   2355
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   795
         Index           =   4
         Left            =   600
         TabIndex        =   150
         Top             =   3960
         Visible         =   0   'False
         Width           =   765
         Begin VB.Frame Frame23 
            Caption         =   "Scan Options"
            Height          =   2115
            Left            =   120
            TabIndex        =   151
            Top             =   360
            Width           =   3345
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   14
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":AB6D
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":ACBF
               Style           =   1  'Graphical
               TabIndex        =   212
               Top             =   1290
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Enabled         =   0   'False
               Height          =   285
               Index           =   13
               Left            =   2670
               MouseIcon       =   "OptionsForm2.frx":AFC9
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":B11B
               Style           =   1  'Graphical
               TabIndex        =   210
               Top             =   60
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   12
               Left            =   2850
               MouseIcon       =   "OptionsForm2.frx":B425
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":B577
               Style           =   1  'Graphical
               TabIndex        =   208
               Top             =   360
               Width           =   315
            End
            Begin VB.TextBox Text1 
               Height          =   225
               Index           =   21
               Left            =   2460
               TabIndex        =   152
               Text            =   "Text1"
               ToolTipText     =   "For each trplet examined the number of variable sites per window"
               Top             =   750
               Width           =   735
            End
            Begin VB.Label Label1 
               Caption         =   "Strip gaps"
               Height          =   285
               Index           =   16
               Left            =   210
               TabIndex        =   211
               Top             =   1380
               Width           =   2205
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Scan triplets"
               Enabled         =   0   'False
               Height          =   285
               Index           =   13
               Left            =   210
               TabIndex        =   209
               Top             =   150
               Width           =   2775
            End
            Begin VB.Label Label1 
               BackStyle       =   0  'Transparent
               Caption         =   "Set window size"
               Height          =   285
               Index           =   11
               Left            =   330
               TabIndex        =   207
               Top             =   390
               Width           =   2355
            End
            Begin VB.Label Label1 
               Caption         =   "Variable sites per window"
               Height          =   285
               Index           =   27
               Left            =   300
               TabIndex        =   153
               Top             =   690
               Width           =   3105
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   2265
         Index           =   2
         Left            =   7200
         TabIndex        =   1
         Top             =   4560
         Visible         =   0   'False
         Width           =   3705
         Begin VB.Frame Frame14 
            Caption         =   "Sequence Options"
            Height          =   1995
            Left            =   240
            TabIndex        =   2
            Top             =   240
            Width           =   3315
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   2
               Left            =   3000
               Picture         =   "OptionsForm2.frx":B881
               Style           =   1  'Graphical
               TabIndex        =   8
               Top             =   240
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   3
               Left            =   3000
               Picture         =   "OptionsForm2.frx":BB8B
               Style           =   1  'Graphical
               TabIndex        =   7
               Top             =   540
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   4
               Left            =   3000
               Picture         =   "OptionsForm2.frx":BE95
               Style           =   1  'Graphical
               TabIndex        =   6
               Top             =   870
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Enabled         =   0   'False
               Height          =   285
               Index           =   8
               Left            =   3000
               Picture         =   "OptionsForm2.frx":C19F
               Style           =   1  'Graphical
               TabIndex        =   5
               Top             =   1200
               Width           =   315
            End
            Begin VB.TextBox Text21 
               Height          =   315
               Left            =   1830
               TabIndex        =   4
               Text            =   "Text21"
               Top             =   1500
               Width           =   525
            End
            Begin VB.TextBox Text22 
               Height          =   315
               Left            =   2730
               TabIndex        =   3
               Text            =   "Text22"
               Top             =   1500
               Width           =   555
            End
            Begin VB.Label Label29 
               BackStyle       =   0  'Transparent
               Caption         =   "Automatic detection of sequence type"
               Height          =   315
               Left            =   0
               TabIndex        =   14
               Top             =   240
               Width           =   3225
            End
            Begin VB.Label Label31 
               BackStyle       =   0  'Transparent
               Caption         =   "Ignor indels"
               Height          =   315
               Left            =   150
               TabIndex        =   13
               Top             =   510
               Width           =   3255
            End
            Begin VB.Label Label32 
               BackStyle       =   0  'Transparent
               Caption         =   "Use standard (nuclear) code"
               Height          =   345
               Left            =   60
               TabIndex        =   12
               Top             =   810
               Width           =   2985
            End
            Begin VB.Label Label39 
               BackStyle       =   0  'Transparent
               Caption         =   "Scan Triplets"
               Enabled         =   0   'False
               Height          =   285
               Left            =   120
               TabIndex        =   11
               Top             =   1110
               Width           =   2745
            End
            Begin VB.Label Label47 
               Caption         =   "Only examine positions"
               Height          =   285
               Left            =   90
               TabIndex        =   10
               Top             =   1530
               Width           =   1725
            End
            Begin VB.Label Label48 
               Caption         =   "to"
               Height          =   225
               Left            =   2460
               TabIndex        =   9
               Top             =   1560
               Width           =   285
            End
         End
         Begin VB.Frame Frame16 
            Caption         =   "Permutation Options"
            Height          =   1575
            Left            =   3960
            TabIndex        =   45
            Top             =   2520
            Width           =   2715
            Begin VB.TextBox Text20 
               Height          =   315
               Left            =   2040
               TabIndex        =   48
               Text            =   "0.05"
               Top             =   570
               Width           =   465
            End
            Begin VB.TextBox Text19 
               Height          =   315
               Left            =   2130
               TabIndex        =   47
               Text            =   "0"
               Top             =   150
               Width           =   405
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   7
               Left            =   2400
               Picture         =   "OptionsForm2.frx":C4A9
               Style           =   1  'Graphical
               TabIndex        =   46
               Top             =   870
               Width           =   315
            End
            Begin VB.Label Label46 
               BackStyle       =   0  'Transparent
               Caption         =   "Max. permutation P-value"
               Height          =   315
               Left            =   120
               TabIndex        =   51
               Top             =   720
               Width           =   1845
            End
            Begin VB.Label Label45 
               BackStyle       =   0  'Transparent
               Caption         =   "Number of permutations to perform"
               Height          =   435
               Left            =   90
               TabIndex        =   50
               Top             =   270
               Width           =   1725
            End
            Begin VB.Label Label59 
               BackStyle       =   0  'Transparent
               Caption         =   "Use only simple polymorphisms"
               Height          =   285
               Left            =   90
               TabIndex        =   49
               Top             =   900
               Width           =   2385
            End
         End
         Begin VB.Frame Frame15 
            Caption         =   "Fragment List Options"
            Height          =   3375
            Left            =   4080
            TabIndex        =   30
            Top             =   -120
            Width           =   2895
            Begin VB.TextBox Text18 
               Height          =   315
               Left            =   2460
               TabIndex        =   37
               Text            =   "1"
               Top             =   3000
               Width           =   345
            End
            Begin VB.TextBox Text17 
               Height          =   315
               Left            =   2130
               TabIndex        =   36
               Text            =   "2"
               Top             =   2610
               Width           =   405
            End
            Begin VB.TextBox Text16 
               Height          =   315
               Left            =   2340
               TabIndex        =   35
               Text            =   "2"
               Top             =   2130
               Width           =   315
            End
            Begin VB.TextBox Text15 
               Height          =   315
               Left            =   2340
               TabIndex        =   34
               Text            =   "1"
               Top             =   1710
               Width           =   375
            End
            Begin VB.TextBox Text14 
               Height          =   405
               Left            =   2190
               TabIndex        =   33
               Text            =   "2000"
               Top             =   780
               Width           =   705
            End
            Begin VB.TextBox Text13 
               Height          =   315
               Left            =   2370
               TabIndex        =   32
               Text            =   "0"
               Top             =   1290
               Width           =   525
            End
            Begin VB.TextBox Text12 
               Height          =   315
               Left            =   2250
               TabIndex        =   31
               Text            =   "0"
               Top             =   360
               Width           =   405
            End
            Begin VB.Label Label44 
               BackStyle       =   0  'Transparent
               Caption         =   "Max. number overlapping frags"
               Height          =   345
               Left            =   120
               TabIndex        =   44
               Top             =   3060
               Width           =   2295
            End
            Begin VB.Label Label42 
               BackStyle       =   0  'Transparent
               Caption         =   "Min. pairwise frag score"
               Height          =   345
               Left            =   150
               TabIndex        =   43
               Top             =   2550
               Width           =   1995
            End
            Begin VB.Label Label41 
               BackStyle       =   0  'Transparent
               Caption         =   "Min. polymorphisms in frags"
               Height          =   345
               Left            =   120
               TabIndex        =   42
               Top             =   2160
               Width           =   2085
            End
            Begin VB.Label Label40 
               BackStyle       =   0  'Transparent
               Caption         =   "Min. aligned fragment length"
               Height          =   405
               Left            =   60
               TabIndex        =   41
               Top             =   1770
               Width           =   2685
            End
            Begin VB.Label Label38 
               BackStyle       =   0  'Transparent
               Caption         =   "Max. number of global frags listed per sequence pair"
               Height          =   405
               Left            =   90
               TabIndex        =   40
               Top             =   780
               Width           =   2325
            End
            Begin VB.Label Label37 
               BackStyle       =   0  'Transparent
               Caption         =   "Max. number of pairwise frags listed per sequence pair"
               Height          =   405
               Left            =   90
               TabIndex        =   39
               Top             =   1260
               Width           =   2295
            End
            Begin VB.Label Label36 
               BackStyle       =   0  'Transparent
               Caption         =   "G-scale (mismatch penalty)"
               Height          =   315
               Left            =   180
               TabIndex        =   38
               Top             =   390
               Width           =   2085
            End
         End
         Begin VB.Frame Frame13 
            Caption         =   "Output File Options"
            Height          =   2625
            Left            =   480
            TabIndex        =   15
            Top             =   2280
            Width           =   3465
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   0
               Left            =   2160
               Picture         =   "OptionsForm2.frx":C7B3
               Style           =   1  'Graphical
               TabIndex        =   22
               Top             =   570
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   1
               Left            =   2130
               Picture         =   "OptionsForm2.frx":CABD
               Style           =   1  'Graphical
               TabIndex        =   21
               Top             =   2220
               Width           =   315
            End
            Begin VB.TextBox Text10 
               Height          =   315
               Left            =   2940
               TabIndex        =   20
               Text            =   "0"
               Top             =   1470
               Width           =   345
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   5
               Left            =   1800
               Picture         =   "OptionsForm2.frx":CDC7
               Style           =   1  'Graphical
               TabIndex        =   19
               Top             =   930
               Width           =   315
            End
            Begin VB.TextBox Text11 
               Height          =   345
               Left            =   2940
               TabIndex        =   18
               Text            =   "0"
               Top             =   1860
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   6
               Left            =   2490
               Picture         =   "OptionsForm2.frx":D0D1
               Style           =   1  'Graphical
               TabIndex        =   17
               Top             =   1260
               Width           =   315
            End
            Begin VB.CommandButton Command29 
               Caption         =   "Customise"
               Enabled         =   0   'False
               Height          =   285
               Left            =   2190
               TabIndex        =   16
               Top             =   960
               Width           =   1005
            End
            Begin VB.Label Label26 
               BackStyle       =   0  'Transparent
               Caption         =   "Output file name"
               Height          =   345
               Left            =   180
               TabIndex        =   29
               Top             =   270
               Width           =   1485
            End
            Begin VB.Label Label27 
               BackStyle       =   0  'Transparent
               Caption         =   "Space separated output"
               Height          =   345
               Left            =   120
               TabIndex        =   28
               Top             =   540
               Width           =   3225
            End
            Begin VB.Label Label28 
               BackStyle       =   0  'Transparent
               Caption         =   "Write log file"
               Height          =   285
               Left            =   150
               TabIndex        =   27
               Top             =   2220
               Width           =   1845
            End
            Begin VB.Label Label30 
               BackStyle       =   0  'Transparent
               Caption         =   "Bases shown at fragment endpoints"
               Height          =   285
               Left            =   180
               TabIndex        =   26
               Top             =   1560
               Width           =   2715
            End
            Begin VB.Label Label33 
               BackStyle       =   0  'Transparent
               Caption         =   "Simple output"
               Height          =   285
               Left            =   120
               TabIndex        =   25
               Top             =   990
               Width           =   1635
            End
            Begin VB.Label Label34 
               BackStyle       =   0  'Transparent
               Caption         =   "Sort fragment lists by P-Value"
               Height          =   255
               Left            =   120
               TabIndex        =   24
               Top             =   1320
               Width           =   2415
            End
            Begin VB.Label Label35 
               BackStyle       =   0  'Transparent
               Caption         =   "Number added to all alignment offsets"
               Height          =   345
               Left            =   90
               TabIndex        =   23
               Top             =   1860
               Width           =   2745
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   435
         Index           =   12
         Left            =   7200
         TabIndex        =   369
         Top             =   5520
         Visible         =   0   'False
         Width           =   645
         Begin VB.Frame Frame30 
            Caption         =   "Permutation Options"
            Height          =   855
            Index           =   1
            Left            =   0
            TabIndex        =   372
            Top             =   1320
            Width           =   3615
            Begin VB.TextBox Text4 
               Height          =   285
               Index           =   2
               Left            =   2280
               TabIndex        =   380
               Text            =   "Text4"
               Top             =   480
               Width           =   975
            End
            Begin VB.TextBox Text4 
               Height          =   285
               Index           =   1
               Left            =   2280
               TabIndex        =   379
               Text            =   "Text4"
               Top             =   120
               Width           =   975
            End
            Begin VB.Label Label14 
               Caption         =   "Permutation number"
               Height          =   255
               Index           =   4
               Left            =   120
               TabIndex        =   377
               Top             =   480
               Width           =   1575
            End
            Begin VB.Label Label14 
               Caption         =   "Random number seed"
               Height          =   255
               Index           =   3
               Left            =   120
               TabIndex        =   376
               Top             =   240
               Width           =   1575
            End
         End
         Begin VB.Frame Frame30 
            Caption         =   "Scan Options"
            Height          =   1215
            Index           =   0
            Left            =   360
            TabIndex        =   371
            Top             =   240
            Width           =   3495
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   38
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":D3DB
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":D52D
               Style           =   1  'Graphical
               TabIndex        =   382
               Top             =   720
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   37
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":D837
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":D989
               Style           =   1  'Graphical
               TabIndex        =   381
               Top             =   480
               Width           =   315
            End
            Begin VB.TextBox Text4 
               Height          =   285
               Index           =   0
               Left            =   2160
               TabIndex        =   378
               Text            =   "Text4"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   240
               Width           =   975
            End
            Begin VB.Label Label14 
               Caption         =   "Use self comparrisons"
               Height          =   255
               Index           =   2
               Left            =   120
               TabIndex        =   375
               Top             =   720
               Width           =   2895
            End
            Begin VB.Label Label14 
               Caption         =   "Strip gaps"
               Height          =   255
               Index           =   1
               Left            =   120
               TabIndex        =   374
               Top             =   480
               Width           =   975
            End
            Begin VB.Label Label14 
               Caption         =   "Window size"
               Height          =   255
               Index           =   0
               Left            =   120
               TabIndex        =   373
               Top             =   240
               Width           =   1215
            End
         End
      End
      Begin VB.Frame Frame2 
         Height          =   1065
         Index           =   6
         Left            =   1680
         TabIndex        =   160
         Top             =   4080
         Visible         =   0   'False
         Width           =   855
         Begin VB.Frame Frame26 
            Caption         =   "Permutation Options"
            Height          =   1575
            Index           =   2
            Left            =   3840
            TabIndex        =   348
            Top             =   1800
            Width           =   3615
            Begin VB.TextBox Text24 
               Height          =   285
               Index           =   4
               Left            =   2130
               TabIndex        =   355
               Text            =   "Text24"
               Top             =   420
               Width           =   855
            End
            Begin VB.TextBox Text24 
               Height          =   285
               Index           =   3
               Left            =   2160
               TabIndex        =   353
               Text            =   "Text24"
               Top             =   660
               Width           =   855
            End
            Begin VB.TextBox Text24 
               Height          =   285
               Index           =   2
               Left            =   2160
               TabIndex        =   350
               Text            =   "Text24"
               Top             =   240
               Width           =   855
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   34
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":DC93
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":DDE5
               Style           =   1  'Graphical
               TabIndex        =   349
               Top             =   960
               Width           =   315
            End
            Begin VB.Label Label22 
               Caption         =   "Scan permutation number"
               Height          =   375
               Index           =   8
               Left            =   90
               TabIndex        =   356
               Top             =   420
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "Random number seed"
               Height          =   375
               Index           =   7
               Left            =   90
               TabIndex        =   354
               Top             =   660
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "P-value  permutation number"
               Height          =   375
               Index           =   2
               Left            =   120
               TabIndex        =   352
               Top             =   270
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "Fast scan "
               Height          =   375
               Index           =   6
               Left            =   120
               TabIndex        =   351
               Top             =   960
               Width           =   2775
            End
         End
         Begin VB.Frame Frame26 
            Caption         =   "Fourth Sequence Selection"
            Height          =   1575
            Index           =   1
            Left            =   3840
            TabIndex        =   340
            Top             =   240
            Width           =   3615
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   35
               Left            =   2400
               MouseIcon       =   "OptionsForm2.frx":E0EF
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":E241
               Style           =   1  'Graphical
               TabIndex        =   345
               Top             =   960
               Width           =   315
            End
            Begin VB.Label Label22 
               Caption         =   "Use nearest outlyer"
               Height          =   375
               Index           =   5
               Left            =   240
               TabIndex        =   341
               Top             =   960
               Width           =   2775
            End
         End
         Begin VB.Frame Frame26 
            Caption         =   "Scan Options"
            Height          =   2895
            Index           =   0
            Left            =   240
            TabIndex        =   336
            Top             =   360
            Width           =   3375
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   36
               Left            =   2640
               MouseIcon       =   "OptionsForm2.frx":E54B
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":E69D
               Style           =   1  'Graphical
               TabIndex        =   347
               Top             =   1320
               Width           =   315
            End
            Begin VB.CommandButton Command28 
               Height          =   285
               Index           =   33
               Left            =   2520
               MouseIcon       =   "OptionsForm2.frx":E9A7
               MousePointer    =   99  'Custom
               Picture         =   "OptionsForm2.frx":EAF9
               Style           =   1  'Graphical
               TabIndex        =   344
               Top             =   960
               Width           =   315
            End
            Begin VB.TextBox Text24 
               Height          =   285
               Index           =   1
               Left            =   2280
               TabIndex        =   343
               Text            =   "Text24"
               Top             =   600
               Width           =   855
            End
            Begin VB.TextBox Text24 
               Height          =   285
               Index           =   0
               Left            =   2160
               TabIndex        =   342
               Text            =   "Text24"
               ToolTipText     =   "Considering all nucleotides"
               Top             =   240
               Width           =   855
            End
            Begin VB.Label Label22 
               Caption         =   "Use only variable positions"
               Height          =   375
               Index           =   4
               Left            =   120
               TabIndex        =   346
               Top             =   1320
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "Strip gaps"
               Height          =   375
               Index           =   3
               Left            =   120
               TabIndex        =   339
               Top             =   960
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "Step size"
               Height          =   375
               Index           =   1
               Left            =   90
               TabIndex        =   338
               Top             =   600
               Width           =   2775
            End
            Begin VB.Label Label22 
               Caption         =   "Window size"
               Height          =   375
               Index           =   0
               Left            =   -90
               TabIndex        =   337
               Top             =   240
               Width           =   2775
            End
         End
      End
      Begin VB.CommandButton Command6 
         Caption         =   "Default"
         Height          =   375
         Left            =   3120
         MouseIcon       =   "OptionsForm2.frx":EE03
         MousePointer    =   99  'Custom
         TabIndex        =   333
         Top             =   5820
         Width           =   855
      End
      Begin VB.CommandButton Command11 
         Caption         =   "OK"
         Height          =   315
         Left            =   2040
         MouseIcon       =   "OptionsForm2.frx":EF55
         MousePointer    =   99  'Custom
         TabIndex        =   53
         Top             =   5880
         Width           =   825
      End
      Begin VB.CommandButton Command4 
         Caption         =   "Cancel"
         Height          =   375
         Left            =   4200
         MouseIcon       =   "OptionsForm2.frx":F0A7
         MousePointer    =   99  'Custom
         TabIndex        =   52
         Top             =   5700
         Width           =   1035
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Command1"
         Height          =   195
         Left            =   2400
         TabIndex        =   474
         Top             =   5880
         Width           =   75
      End
      Begin ComctlLib.TabStrip TabStrip1 
         Height          =   5448
         Left            =   1680
         TabIndex        =   122
         Top             =   480
         Width           =   10812
         _ExtentX        =   19076
         _ExtentY        =   9604
         MultiRow        =   -1  'True
         TabFixedWidth   =   2006
         _Version        =   327682
         BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
            NumTabs         =   17
            BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "General"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab2 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "RDP "
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab3 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "GENECONV"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab4 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Bootscan (Recscan)"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab5 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "MaxChi"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab6 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Chimaera"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab7 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "SisScan"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab8 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "PhylPro"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab9 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "VisRD"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab10 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "LARD"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab11 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "DSS (TOPAL)"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab12 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Distance Plots"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab13 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Recombination Rates (LDHat)"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab14 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Breakpoint distribution plot"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab15 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Matrices"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab16 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "Trees"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
            BeginProperty Tab17 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   "SCHEMA"
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
         EndProperty
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin ComctlLib.TabStrip TabStrip2 
         Height          =   5865
         Left            =   120
         TabIndex        =   332
         Top             =   480
         Width           =   6855
         _ExtentX        =   12091
         _ExtentY        =   10345
         TabWidthStyle   =   2
         TabFixedWidth   =   17639
         _Version        =   327682
         BeginProperty Tabs {0713E432-850A-101B-AFC0-4210102A8DA7} 
            NumTabs         =   1
            BeginProperty Tab1 {0713F341-850A-101B-AFC0-4210102A8DA7} 
               Caption         =   ""
               Object.Tag             =   ""
               ImageVarType    =   2
            EndProperty
         EndProperty
      End
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Check1_Click()
    Call RefreshTimes
   
End Sub

Private Sub Check10_Click()
Call RefreshTimes

End Sub

Private Sub Check11_Click()
Call RefreshTimes

End Sub

Private Sub Check12_Click()
    Call RefreshTimes

End Sub

Private Sub Check13_Click()
Call RefreshTimes

End Sub

Private Sub Check14_Click()
Call RefreshTimes

End Sub

Private Sub Check15_Click()
Call RefreshTimes

End Sub

Private Sub Check16_Click()
Call RefreshTimes

End Sub

Private Sub Check17_Click()
Call RefreshTimes

End Sub

Private Sub Check18_Click()
Call RefreshTimes
End Sub

Private Sub Check19_Click()
Call RefreshTimes
End Sub

Private Sub Check2_Click()
    Call RefreshTimes

End Sub

Private Sub Check20_Click()
Call RefreshTimes
End Sub

Private Sub Check21_Click()
Call RefreshTimes
End Sub

Private Sub Check22_Click()
Call RefreshTimes
End Sub

Private Sub Check3_Click()
    Call RefreshTimes
    
End Sub

Private Sub Check4_Click()
    Call RefreshTimes
    
End Sub

Private Sub Check5_Click()
    Call RefreshTimes
    
    
    
End Sub

Private Sub Check6_Click()
    Call RefreshTimes
   
    
    

    
End Sub

Private Sub Check8_Click()

    If Check8.Value = 1 Then
        Frame18.Enabled = True
        Text1(8).Enabled = True
        Text1(9).Enabled = True
        Text1(11).Enabled = True
        Text1(12).Enabled = True
        Text1(8).BackColor = QBColor(15)
        Text1(9).BackColor = QBColor(15)
        Text1(8).ForeColor = QBColor(0)
        Text1(9).ForeColor = QBColor(0)
        Text1(11).BackColor = QBColor(15)
        Text1(12).BackColor = QBColor(15)
        Text1(11).ForeColor = QBColor(0)
        Text1(12).ForeColor = QBColor(0)
        Label1(7).Enabled = True
        Label1(10).Enabled = True
        Label1(14).Enabled = True
        Label1(15).Enabled = True
    Else
        Frame18.Enabled = False
        Text1(8).Enabled = False
        Text1(9).Enabled = False
        Text1(11).Enabled = False
        Text1(12).Enabled = False
        Text1(8).BackColor = Form1.BackColor
        Text1(9).BackColor = Form1.BackColor
        Text1(8).ForeColor = QBColor(8)
        Text1(9).ForeColor = QBColor(8)
        Text1(11).BackColor = Form1.BackColor
        Text1(12).BackColor = Form1.BackColor
        Text1(11).ForeColor = QBColor(8)
        Text1(12).ForeColor = QBColor(8)
        Label1(7).Enabled = False
        Label1(10).Enabled = False
        Label1(14).Enabled = False
        Label1(15).Enabled = False
    End If

End Sub

Private Sub Check9_Click()
If Form3.Visible = True And Form3.Command1.Enabled = True And Form3.Command1.Visible = True Then
    Form3.Command1.SetFocus
End If
End Sub

Private Sub Combo1_Click()

    Form3.Command28(19).Enabled = True
    Form3.Label1(58).Enabled = True
     Call DoColourScale

For x = 1 To 8
    Form3.Text5(x).Visible = False
Next x
If Form3.Combo1.ListIndex = 0 Then
            Form3.Command28(15).Enabled = False
            Form3.Label1(17) = "Use only binary sites"
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = False
            
            Form3.Combo2.Enabled = False
            Form3.Combo2.BackColor = Form1.BackColor
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            Form3.Text5(1) = MatWinSize
            Label1(57) = "Window size"
            Form3.Text5(1).Enabled = False
            Form3.Text5(1).BackColor = Form1.BackColor
            Form3.Text5(1).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = False
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 1 Then 'phitest matrix
            Form3.Command28(15).Enabled = False
            XX = Label1(57)
            Form3.Label1(17) = "Use all sites"
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = False
            
            Form3.Combo2.Enabled = False
            Form3.Combo2.BackColor = Form1.BackColor
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            Form3.Text5(1) = PHIWin
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = RGB(0, 0, 0)
            Label1(57) = "PHI-test optimal window size"
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 2 Then 'rf matrix
            Form3.Command28(15).Enabled = False
            Form3.Label1(17) = "Use all sites"
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = False
            Form3.Combo2.BackColor = Form1.BackColor
            
            Form3.Text5(1) = MatWinSize
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            
            Label1(57) = "RF/SH Window size"
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = 0
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = RGB(255, 255, 255)
            Form3.Text5(9).ForeColor = 0
            Form3.Text5(9).Enabled = True
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = True
            Form3.Text5(2).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 3 Then 'shmatrix
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = False
            Form3.Combo2.BackColor = Form1.BackColor
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(1) = MatWinSize
            
            Label1(57) = "SH/RF Window size"
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = 0
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = RGB(255, 255, 255)
            Form3.Text5(9).ForeColor = 0
            Form3.Text5(9).Enabled = True
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = True
            Form3.Text5(2).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 4 Then
            Form3.Label1(17) = "Use all sites"
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = True
            Form3.Combo2.BackColor = RGB(255, 255, 255)
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(1) = MatWinSize
            Label1(57) = "Window size"
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = 0
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 5 Then
            Form3.Label1(17) = "Use all sites"
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = True
            Form3.Combo2.BackColor = RGB(255, 255, 255)
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(1) = MatWinSize
            Label1(57) = "Window size"
            Form3.Text5(1).Enabled = False
            Form3.Text5(1).BackColor = Form1.BackColor
            Form3.Text5(1).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = False
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 6 Then
            Form3.Label1(17) = "Use all sites"
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            Form3.Combo2.Enabled = True
            Form3.Combo2.BackColor = RGB(255, 255, 255)
            
            Form3.Text5(0).Enabled = True
            Form3.Text5(0).BackColor = RGB(255, 255, 255)
            Form3.Text5(0).ForeColor = 0
            Label1(57) = "Window size"
            Form3.Text5(1) = MatWinSize
            Form3.Text5(1).Enabled = False
            Form3.Text5(1).BackColor = Form1.BackColor
            Form3.Text5(1).ForeColor = RGB(128, 128, 128)
                        
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = True
            Form3.Label1(57).Enabled = False
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 7 Then
            Form3.Label1(17) = "Use all sites"
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = True
            Form3.Combo2.BackColor = RGB(255, 255, 255)
            
            Form3.Text5(0).Enabled = False
            Form3.Text5(0).BackColor = Form1.BackColor
            Form3.Text5(0).ForeColor = RGB(128, 128, 128)
            
            Form3.Text5(1) = MatWinSize
            Label1(57) = "Window size"
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = 0
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = False
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = True
        ElseIf Form3.Combo1.ListIndex = 8 Then
            Form3.Label1(17) = "Use all sites"
            Form3.Command28(15).Enabled = False
            Form3.Label1(17).Enabled = False
            Form3.Label1(22).Enabled = True
            
            Form3.Combo2.Enabled = True
            Form3.Combo2.BackColor = RGB(255, 255, 255)
            
            Form3.Text5(0).Enabled = True
            Form3.Text5(0).BackColor = RGB(255, 255, 255)
            Form3.Text5(0).ForeColor = 0
            
            Form3.Text5(1) = MatWinSize
            Label1(57) = "Window size"
            Form3.Text5(1).Enabled = True
            Form3.Text5(1).BackColor = RGB(255, 255, 255)
            Form3.Text5(1).ForeColor = 0
            
            Form3.Text5(9).Enabled = False
            Form3.Text5(9).BackColor = Form1.BackColor
            Form3.Text5(9).ForeColor = RGB(128, 128, 128)
            Form3.Text5(9).Enabled = False
            
            Form3.Label1(26).Enabled = True
            Form3.Label1(57).Enabled = True
            Form3.Label1(73).Enabled = False
            Form3.Command28(19).Enabled = False
            Form3.Picture1 = LoadPicture()
            Form3.Label1(58).Enabled = False
            Form3.Text5(1).Visible = True
            Form3.Command28(19).Enabled = False
        End If
        If NextNo = 0 Then
            Form3.Label1(22).Enabled = False
            Form3.Combo2.Enabled = False
            Form3.Combo2.BackColor = Form1.BackColor
        End If
'        XX = Form3.Text5(1)
'        X = X
End Sub


Private Sub Command10_Click()
    Command1.SetFocus

    If HomologyIndicatorT = 1 Then
        HomologyIndicatorT = 2
        Label3 = "Histogram"
    Else
        HomologyIndicatorT = 1
        Label3 = "Coloured shading"
    End If

End Sub

Private Sub Combo2_Change()
If Combo4.ListIndex > -1 Then
    Combo4.ListIndex = Combo2.ListIndex
End If
End Sub

Private Sub Combo2_Click()
If Combo4.ListIndex > -1 Then
    Combo4.ListIndex = Combo2.ListIndex
End If
End Sub

Private Sub Combo3_Click()
x = x
If Combo3.ListIndex = 0 Then 'njtree
    Label1(71).Caption = "Bootstrap test"
    Label1(71).Enabled = False
    Command28(48).Enabled = False
    
    
    Frame7(1).Visible = True
    Frame7(2).Visible = False
    Frame7(3).Visible = False
    Frame22.Visible = False
    Label1(47).Enabled = False
    Text1(35).Enabled = False
    Text1(35).ForeColor = RGB(128, 128, 128)
    Text1(35).BackColor = Form1.BackColor
    
    
    Label1(50).Enabled = False
    Command28(30).Enabled = False
    Label1(51).Enabled = False
    Command28(31).Enabled = False
    
    Label1(49).Enabled = True
    Command28(29).Enabled = True
    Label1(52).Enabled = True
    Command28(32).Enabled = True
    Frame6(2).Visible = False
    Call EnableFrame6
ElseIf Combo3.ListIndex = 1 And x = 12345 Then 'LS
    Label1(71).Caption = "Bootstrap test"
    Label1(71).Enabled = False
    Command28(48).Enabled = False
    Label1(47).Enabled = True
    Text1(35).Enabled = True
    Text1(35).ForeColor = 0
    Text1(35).BackColor = RGB(255, 255, 255)
    
    Label1(50).Enabled = True
    Command28(30).Enabled = True
    Label1(51).Enabled = True
    Command28(31).Enabled = True
    
    Label1(49).Enabled = True
    Command28(29).Enabled = True
    Label1(52).Enabled = True
    Command28(32).Enabled = True
    
    Label1(47).Enabled = True
    Frame7(1).Visible = True
    Frame7(2).Visible = False
    Frame7(3).Visible = False
    Frame22.Visible = False
    
    Frame6(2).Visible = False
    Call EnableFrame6
ElseIf Combo3.ListIndex = 1 Then 'ML
    
    Label1(71).Enabled = True
    Command28(48).Enabled = True
    
    Frame7(1).Visible = False
    Frame7(2).Visible = True
    Frame22.Visible = True
    Frame7(3).Visible = False
    
    Label1(47).Enabled = False
    Text1(35).Enabled = False
    Text1(35).ForeColor = RGB(128, 128, 128)
    Text1(35).BackColor = Form1.BackColor
    
     Label1(50).Enabled = False
    Command28(30).Enabled = False
    Label1(51).Enabled = False
    Command28(31).Enabled = False
    Label1(49).Enabled = False
    Command28(29).Enabled = False
    Label1(52).Enabled = False
    Command28(32).Enabled = False
    Frame6(2).Visible = False
    Call EnableFrame6
    If BSupTest = 0 Or BSTreeStrat >= 3 Then
      Label1(71).Caption = "Bootstrap test"
      Label1(45).Enabled = True ' bootstrap labels
      Label1(46).Enabled = True
      Text1(33).Enabled = True 'bootstrap nums
      Text1(34).Enabled = True
      Text1(33).BackColor = QBColor(15)
      Text1(34).BackColor = QBColor(15)
        
    Else
        'Label1(45).Enabled = False
        'Label1(46).Enabled = False
        'Text1(33).Enabled = False
        'Text1(34).Enabled = False
        'Text1(33).BackColor = Form1.BackColor
        'Text1(34).BackColor = Form1.BackColor
        If BSupTest = 1 Then BSupTest = 2
        If BSupTest = 1 Then  'approximate lr test returning aLRT stats
          Label1(71).Caption = "Approximate likelihood ratio test (aLRT)"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
          x = x
        ElseIf BSupTest = 2 Then  'approximate lr test returning chi square based stats
          Label1(71).Caption = "Approximate likelihood ratio test (ChiSq)"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
        ElseIf BSupTest = 3 Then 'sh-like branch support test
          Label1(71).Caption = "SH-like branch support test"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
        End If
    End If
    x = x
    
    If BSTreeStrat = 0 Then
        If BSupTest > 0 Then
            Label1(45).Enabled = False
            Label1(46).Enabled = False
            Text1(33).Enabled = False
            Text1(34).Enabled = False
            Text1(33).BackColor = Form1.BackColor
            Text1(34).BackColor = Form1.BackColor
        
        End If
        Label1(72).Caption = "PhyML3 tree search by NNI"
        
    ElseIf BSTreeStrat = 1 Then
        Label1(72).Caption = "PhyML3 tree search by SPR"
        If BSupTest > 0 Then
            Label1(45).Enabled = False
            Label1(46).Enabled = False
            Text1(33).Enabled = False
            Text1(34).Enabled = False
            Text1(33).BackColor = Form1.BackColor
            Text1(34).BackColor = Form1.BackColor
        
        End If
    ElseIf BSTreeStrat = 2 Then
        Label1(72).Caption = "PhyML3 tree search by NNI and SPR"
        If BSupTest > 0 Then
            Label1(45).Enabled = False
            Label1(46).Enabled = False
            Text1(33).Enabled = False
            Text1(34).Enabled = False
            Text1(33).BackColor = Form1.BackColor
            Text1(34).BackColor = Form1.BackColor
        
        End If
    ElseIf BSTreeStrat = 3 Then
        Label1(72).Caption = "Fast PHYML1 search"
        Label1(45).Enabled = True
        Label1(46).Enabled = True
        Text1(33).Enabled = True
        Text1(34).Enabled = True
        Text1(33).BackColor = QBColor(15)
        Text1(34).BackColor = QBColor(15)
        
    ElseIf BSTreeStrat = 4 Then
        Label1(72).Caption = "Faster RAxML search"
        Label1(71).Caption = "Bootstrap test"
        Label1(71).Enabled = False
        Command28(48).Enabled = False
        
        Label1(45).Enabled = True
        Label1(46).Enabled = True
        Text1(33).Enabled = True
        Text1(34).Enabled = True
        Text1(33).BackColor = QBColor(15)
        Text1(34).BackColor = QBColor(15)
        Label21(42).Enabled = False
        'Text23(34).Enabled = False
        Label1(24).Caption = "GTR-CAT"
        Label1(69).Enabled = False
        Label1(59).Enabled = False
        Label1(60).Enabled = False
        Label21(46).Enabled = False
        Label21(52).Enabled = False
        Text23(34).Visible = False
        Text23(35).Visible = True
        Text23(35).Enabled = False
        Text23(35).BackColor = Form1.BackColor
        Text1(17).Enabled = False
        Text1(18).Enabled = False
        Command28(43).Enabled = False
        Command28(47).Enabled = False
        Text1(17).BackColor = Form1.BackColor
        Text1(18).BackColor = Form1.BackColor
        Command28(44).Enabled = False
        Text23(42).BackColor = Form1.BackColor
        Text23(42).Enabled = False
    ElseIf BSTreeStrat = 5 Then
        Label1(72).Caption = "Fastest FastTree search"
        
        Label1(71).Enabled = True
        Label1(71).Caption = "SH-like branch support test"
        Command28(48).Enabled = False
        Label1(45).Enabled = False
        Label1(46).Enabled = False
        Text1(33).Enabled = False
        Text1(34).Enabled = False
        Text1(33).BackColor = Form1.BackColor
        Text1(34).BackColor = Form1.BackColor
        
        
        
        Label21(42).Enabled = False
        'Text23(34).Enabled = False
        Label1(24).Caption = "GTR-CAT"
        Label1(69).Enabled = False
        Label1(59).Enabled = False
        Label1(60).Enabled = False
        Label21(46).Enabled = False
        Label21(52).Enabled = False
        Text23(34).Visible = False
        Text23(35).Visible = True
        Text23(35).Enabled = False
        Text23(35).BackColor = Form1.BackColor
        Text1(17).Enabled = False
        Text1(18).Enabled = False
        Command28(43).Enabled = False
        Command28(47).Enabled = False
        Text1(17).BackColor = Form1.BackColor
        Text1(18).BackColor = Form1.BackColor
        Command28(44).Enabled = False
        Text23(42).BackColor = Form1.BackColor
        Text23(42).Enabled = False
        
        
        
    End If
    
ElseIf Combo3.ListIndex = 2 Then 'Bayesian
    Label1(71).Caption = "Bootstrap test"
    Label1(71).Enabled = False
    Command28(48).Enabled = False
    Frame7(1).Visible = False
    Frame7(2).Visible = False
    Frame7(3).Visible = True
    Frame22.Visible = False
    Label1(47).Enabled = False
    Text1(35).Enabled = False
    Text1(35).ForeColor = RGB(128, 128, 128)
    Text1(35).BackColor = Form1.BackColor
    
    
     Label1(50).Enabled = False
    Command28(30).Enabled = False
    Label1(51).Enabled = False
    Command28(31).Enabled = False
    
    Label1(49).Enabled = False
    Command28(29).Enabled = False
    Label1(52).Enabled = False
    Command28(32).Enabled = False
    Frame6(2).Visible = True
    Call DisableFrame6
End If
If Form3.Visible = True Then
    Form3.Command1.SetFocus
End If
End Sub

Private Sub Combo4_Change()
Combo2.ListIndex = Combo4.ListIndex
End Sub

Private Sub Combo4_Click()
x = x
Combo2.ListIndex = Combo4.ListIndex

End Sub

Private Sub Command1_KeyDown(KeyCode As Integer, Shift As Integer)
Call DoKeydown(KeyCode)
End Sub

Private Sub Command11_Click()
   Form1.Timer2.Enabled = False
    OptButtonF = 0
    Dim Tot As Double, GoOn As Byte, TempDbl As Double
    Dim GoOnChi As Byte, GoOnRDP As Byte, GoOnPP As Byte, GoOnBPScan As Byte
     Command1.SetFocus
GoOn = 0
    
    If DebuggingFlag < 2 Then On Error Resume Next
    
    GoOnBPScan = 0
    'StartRho = val(Text6(0).Text)
    StartRho = CDbl(val(Text6(0).Text))
    'BlockPen = val(Text6(1).Text)
    BlockPen = CDbl(val(Text6(1).Text))
    'FreqCo = val(Text6(2).Text)
    FreqCo = CDbl(val(Text6(2).Text))
    'FreqCoMD = val(Text6(3).Text)
    FreqCoMD = CDbl(val(Text6(3).Text))
    'GCTractLen = val(Text6(4).Text)
    GCTractLen = CLng(val(Text6(4).Text))
    'MCMCUpdates = val(Text6(5).Text)
    MCMCUpdates = CLng(val(Text6(5).Text))
    On Error GoTo 0
    
    If MCMCUpdates < 100000 Then MCMCUpdates = 100000
        
        
    If xBlockPen <> BlockPen Or StartRho <> xStartRho Or xMCMCUpdates <> MCMCUpdates Then
        VRFlag = 0
    End If
    If xFreqCo <> FreqCo Or xFreqCoMD <> FreqCoMD Or xGCFlag <> GCFlag Or xGCTractLen <> GCTractLen Then
        VRFlag = 0
        DoneMatX(5) = 0
        DoneMatX(6) = 0
        DoneMatX(7) = 0
    End If
    
    
    'DoneMatX(5) = 0
    
    If CircularFlag <> CircularFlagT Then
        VRFlag = 0
    End If
    CircularFlag = CircularFlagT
    Form1.Text5.Text = Text2.Text
    Form1.Text1.Text = Text3.Text
    'LowestProb = CDbl(Val(Text3.Text))
    If DebuggingFlag < 2 Then On Error Resume Next
    LowestProb = val(Text3.Text)
    LowestProb = CDbl(val(Text3.Text))
    On Error GoTo 0
    pLowestProb = LowestProb
    xLowestProb = LowestProb
    If Check13 = 1 Then
        AllowConflict = 0
    Else
        AllowConflict = 1
    End If
    
        
    ShowPlotFlag = ShowPlotFlagT
    MCFlag = MCFlagT
    If XOverWindowX <> CDbl(Text2.Text) Or SpacerFlag <> SpacerFlagT Then
        GoOnRDP = 1
    End If
    'XX = Text1(37).Text
    If DebuggingFlag < 2 Then On Error Resume Next
    GPerms = val(Text1(37).Text)
    GPerms = CDbl(val(Text1(37).Text))
    On Error GoTo 0
    XOverWindowX = CDbl(Text2.Text)
    Form1.SSPanel2.Enabled = True
    Form1.SSPanel8.Enabled = True
    ForcePhylE = Check10
    PolishBPFlag = Check9
    RealignFlag = Check11
    If NextNo > 0 Then
        Form1.SSPanel3.Enabled = True
        Form1.SSPanel4.Enabled = True
        Form1.SSPanel5.Enabled = True
        Form1.SSPanel6(0).Enabled = True
        Form1.SSPanel6(1).Enabled = True
        Form1.SSPanel6(2).Enabled = True
        '
    End If

    
    If DebuggingFlag < 2 Then On Error Resume Next
    
    'TempDbl = val(Text7)
    TempDbl = CDbl(val(Text7))
    Text7 = TempDbl
    'TempDbl = val(Text8)
    TempDbl = CDbl(val(Text8))
    Text8 = TempDbl
    On Error GoTo 0
    If CDbl(Text7) < CDbl(Text8) Then
        MiDistance = CDbl(Text7.Text) / 100
        MaDistance = CDbl(Text8.Text) / 100
    Else
        MiDistance = CDbl(Text8.Text) / 100
        MaDistance = CDbl(Text7.Text) / 100
    End If
    
    
    If MiDistance < 0 Then MiDistance = 0

    If MaDistance > 1 Then MaDistance = 1
    
    If MaDistance = 0 Then MaDistance = 1
    
    Spacer4No = List1.TopIndex

    If Check4.Value = 1 Then
        DoScans(0, 0) = 1
    Else
        DoScans(0, 0) = 0
    End If

    If Check5.Value = 1 Then
        DoScans(0, 1) = 1
    Else
        DoScans(0, 1) = 0
    End If

    If Check1.Value = 1 Then
        DoScans(0, 2) = 1
    Else
        DoScans(0, 2) = 0
    End If

    If Check2.Value = 1 Then
        DoScans(0, 3) = 1
    Else
        DoScans(0, 3) = 0
    End If

    If Check3.Value = 1 Then
        DoScans(0, 4) = 1
    Else
        DoScans(0, 4) = 0
    End If

    If Check6.Value = 1 Then
        DoScans(0, 5) = 1
    Else
        DoScans(0, 5) = 0
    End If
    
    If Check12.Value = 1 Then
        DoScans(0, 8) = 1
    Else
        DoScans(0, 8) = 0
    End If

    
    'GENECONV options
    GCSeqTypeFlag = xGCSeqTypeFlag
    GCIndelFlag = xGCIndelFlag
    
    GCtripletflag = xGCTripletFlag
    GCSeqRange(0) = CDbl(Text21)
    GCSeqRange(1) = CDbl(Text22)
    
    GCOutFlag = xGCOutFlag
    GCOutFlagII = xGCOutFlagII
    GCSortFlag = xGCSortFlag
    GCEndLen = CDbl(val(Text10))
    GCOffsetAddjust = CDbl(val(Text11))
    GCLogFlag = xGCLogFlag
    GCMissmatchPen = CDbl(val(Text12))
    GCMaxGlobFrags = CDbl(val(Text14))
    GCMaxPairFrags = CDbl(val(Text13))
    GCMinFragLen = CDbl(val(Text15))
    GCMinPolyInFrag = CDbl(val(Text16))
    GCMinPairScore = CDbl(val(Text17))
    GCMaxOverlapFrags = CDbl(val(Text18))
    GCNumPerms = CDbl(val(Text19))
    
    If DebuggingFlag < 2 Then On Error Resume Next
    'GCMaxPermPVal = val(Text20)
    GCMaxPermPVal = CDbl(val(Text20))
    
    On Error GoTo 0
    GCPermPolyFlag = xGCPermPolyFlag
    
    

    Dim totalBS As Double
    oa = BSFreqA
    OC = BSFreqC
    oG = BSFreqG
    OT = BSFreqT
    
    If DebuggingFlag < 2 Then On Error Resume Next
'    BSFreqA = val(Text23(28))
'    BSFreqC = val(Text23(27))
'    BSFreqG = val(Text23(26))
'    BSFreqT = val(Text23(29))
    BSFreqA = CDbl(val(Text23(28)))
    BSFreqC = CDbl(val(Text23(27)))
    BSFreqG = CDbl(val(Text23(26)))
    BSFreqT = CDbl(val(Text23(29)))
    On Error GoTo 0
    totalBS = BSFreqA + BSFreqC + BSFreqG + BSFreqT
    
    If oa <> BSFreqA Or OC <> BSFreqC Or oG <> BSFreqG Or OT <> BSFreqT Then
        GoOn = 1
    End If
    
    
    
    BSStepWin = CDbl(val(Text1(0)))
    BSStepSize = CDbl(val(Text1(1)))
    BSCutOff = CDbl(val(Text1(5))) / 100
    BSBootReps = CDbl(val(Text1(2)))
    BSRndNumSeed = CDbl(val(Text1(3)))
    
    BSSubModelFlag = xBSSubModelFlag
    BSTTRatio = xBSTTRatio
    'BSStepWin = CDbl(Text1(6))
    'BSStepSize = CDbl(Text1(7))
    'BSBootReps = CDbl(Text1(10))
    BSCoeffVar = CDbl(val(Text1(28)))

    'If Check7.Value = 1 Then
    '    BSCCenterFlag = 1
    'Else
    '    BSCCenterFlag = 0
    'End If

    If Check8.Value = 1 Then
        BSCDecreaseStepFlag = 1
    Else
        BSCDecreaseStepFlag = 0
    End If

    'BSCDStepSize = CDbl(Text1(8))
    'BSStepWin = CDbl(Text1(11))
    'TStr = Text1(12)
    'BSCDBootReps = CDbl(Text1(12))
    'BSCDSpan = CDbl(Text1(9))
    
    totalBS = BSFreqA + BSFreqC + BSFreqG + BSFreqT

    If totalBS > 0 Then
        BSFreqA = BSFreqA / totalBS
        BSFreqC = BSFreqC / totalBS
        BSFreqG = BSFreqG / totalBS
        BSFreqT = BSFreqT / totalBS
    Else
        BSFreqA = 0.25
        BSFreqC = 0.25
        BSFreqG = 0.25
        BSFreqT = 0.25
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
        'TempDbl = val(Text1(17).Text)
        TempDbl = CDbl(val(Text1(17).Text))
    On Error GoTo 0
    
    
    
    If MCTripletFlag <> xMCTripletFlag Or MCProportionFlag <> xMCProportionFlag _
        Or MCWinSize <> xMCWinSize Or MCWinFract <> xMCWinFract _
        Or MCStripGapsFlag <> xMCStripGapsFlag Then
            GoOn = 1
    End If
    
    
    
    
    
    
    
    If MCProportionFlag = 1 Then
        If DebuggingFlag < 2 Then On Error Resume Next
        'MCWinFract = val(Text1(21))
        MCWinFract = CDbl(val(Text1(21)))
        On Error GoTo 0
    Else
        MCWinSize = CDbl(val(Text1(21).Text))
    End If
    
    
   
    
    
    If CProportionFlag = 1 Then
        If DebuggingFlag < 2 Then On Error Resume Next
        'CWinFract = val(Text1(36))
        CWinFract = CDbl(val(Text1(36)))
        On Error GoTo 0
    Else
        
        If DebuggingFlag < 2 Then On Error Resume Next
        'CWinSize = val(Text1(36).Text)
        CWinSize = CDbl(val(Text1(36).Text))
        On Error GoTo 0
    End If
    
    ow = PPWinLen
    
    If DebuggingFlag < 2 Then On Error Resume Next
        PPWinLen = val(Text4(0).Text)
        PPSeed = val(Text4(1).Text)
        PPPerms = val(Text4(2).Text)
        PPWinLen = CDbl(val(Text4(0).Text))
        PPSeed = CDbl(val(Text4(1).Text))
        PPPerms = CDbl(val(Text4(2).Text))
    On Error GoTo 0
    If PPWinLen <> ow Or IncSelf <> xIncSelf Or PPStripGaps <> xPPStripGaps Then
        GoOnPP = 1
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
        'TempDbl = val(Text1(38).Text)
        TempDbl = CDbl(val(Text1(38).Text))
    On Error GoTo 0
    If DebuggingFlag < 2 Then On Error Resume Next
    If CProportionFlag <> xCProportionFlag _
        Or CWinSize <> xCWinSize Or CWinFract <> xCWinFract Then
            GoOnChi = 1
    End If
    On Error GoTo 0
    otv = LRDTvRat
    oAc = LRDACCoeff
    oag = LRDAGCoeff
    oat = LRDATCoeff
    ocg = LRDCGCoeff
    Olct = LRDCTCoeff
    ogt = LRDGTCoeff
    oa = LRDAFreq
    OC = LRDCFreq
    oG = LRDGFreq
    OT = LRDTFreq
    oc1 = LRDCodon1
    oc2 = LRDCodon2
    oc3 = LRDCodon3
    ogamma = LRDShape
    If DebuggingFlag < 2 Then On Error Resume Next
    LRDTvRat = val(Text23(11))
    LRDACCoeff = val(Text23(13))
    LRDAGCoeff = val(Text23(14))
    LRDATCoeff = val(Text23(15))
    LRDCGCoeff = val(Text23(12))
    LRDCTCoeff = val(Text23(16))
    LRDGTCoeff = val(Text23(17))
    LRDAFreq = val(Text23(9))
    LRDCFreq = val(Text23(8))
    LRDGFreq = val(Text23(7))
    LRDTFreq = val(Text23(10))
    LRDCodon1 = val(Text23(2))
    LRDCodon2 = val(Text23(3))
    LRDCodon3 = val(Text23(4))
    
    LRDTvRat = CDbl(val(Text23(11)))
    LRDACCoeff = CDbl(val(Text23(13)))
    LRDAGCoeff = CDbl(val(Text23(14)))
    LRDATCoeff = CDbl(val(Text23(15)))
    LRDCGCoeff = CDbl(val(Text23(12)))
    LRDCTCoeff = CDbl(val(Text23(16)))
    LRDGTCoeff = CDbl(val(Text23(17)))
    LRDAFreq = CDbl(val(Text23(9)))
    LRDCFreq = CDbl(val(Text23(8)))
    LRDGFreq = CDbl(val(Text23(7)))
    LRDTFreq = CDbl(val(Text23(10)))
    LRDCodon1 = CDbl(val(Text23(2)))
    LRDCodon2 = CDbl(val(Text23(3)))
    LRDCodon3 = CDbl(Text23(4))
    'LRDShape = val(Text23(6))
    LRDShape = CDbl(val(Text23(6)))
    LRDCategs = val(Text23(5))
    
    On Error GoTo 0
    
    
    
    
    
    
    
    
    
   
    
    
    
     If DebuggingFlag < 2 Then On Error Resume Next
    SSWinLen = val(Text24(0))
    SSWinLen = CLng(Text24(0))
    SSStep = val(Text24(1))
    SSStep = CLng(Text24(1))
    SSNumPerms = val(Text24(2))
    SSNumPerms = CLng(Text24(2))
    SSRndSeed = val(Text24(3))
    SSRndSeed = CLng(Text24(3))
    SSNumPerms2 = val(Text24(4))
    SSNumPerms2 = CLng(Text24(4))
    LRDStep = val(Text23(0))
    LRDStep = CLng(Text23(0))
    LRDWinLen = val(Text23(1))
    LRDWinLen = CLng(Text23(1))
    
    On Error GoTo 0
    
    
    
    LRDModel = xLRDModel
    LRDBaseFreqFlag = xLRDBaseFreqFlag
    Tot = LRDAFreq + LRDCFreq + LRDGFreq + LRDTFreq
    If Tot = 0 Then
        LRDAFreq = 0.25
        LRDCFreq = 0.25
        LRDGFreq = 0.25
        LRDTFreq = 0.25
        Tot = 1
    End If
    
    LRDAFreq = LRDAFreq / Tot
    LRDCFreq = LRDCFreq / Tot
    LRDGFreq = LRDGFreq / Tot
    LRDTFreq = LRDTFreq / Tot
    DPWindow = CDbl(val(Text1(13)))
    DPStep = CDbl(val(Text1(14)))

    If DPModelFlag <> 0 Then
        If DebuggingFlag < 2 Then On Error Resume Next
        DPTVRatio = CDbl(Text1(15))
        On Error GoTo 0
        If DPTVRatio = 0 Then DPTVRatio = 0.5
    End If
    If DebuggingFlag < 2 Then On Error Resume Next
'    DPCoeffVar = val(Text1(29))
'    DPBFreqA = val(Text23(19))
'    DPBFreqC = val(Text23(20))
'    DPBFreqG = val(Text23(21))
'    DPBFreqT = val(Text23(18))
    DPCoeffVar = CDbl(val(Text1(29)))
    DPBFreqA = CDbl(val(Text23(19)))
    DPBFreqC = CDbl(val(Text23(20)))
    DPBFreqG = CDbl(val(Text23(21)))
    DPBFreqT = CDbl(val(Text23(18)))
    On Error GoTo 0
    
    
    Tot = DPBFreqA + DPBFreqC + DPBFreqG + DPBFreqT
    If Tot = 0 Then
        DPBFreqA = 0.25
        DPBFreqC = 0.25
        DPBFreqG = 0.25
        DPBFreqT = 0.25
        Tot = 1
    End If
    DPBFreqA = DPBFreqA / Tot
    DPBFreqC = DPBFreqC / Tot
    DPBFreqG = DPBFreqG / Tot
    DPBFreqT = DPBFreqT / Tot

    
    GlobalMemoryStatus MemSit
    
    APhys = Abs(MemSit.dwTotalPhys)
    If APhys > 1000000000 Or APhys < 1000000 Then APhys = 1000000000
        
    'Do TOPAL stuff
    oa = TOFreqA
    OC = TOFreqC
    oG = TOFreqG
    OT = TOFreqT
    opower = TOPower
    
    If DebuggingFlag < 2 Then On Error Resume Next
    
'    TOFreqA = val(Text23(24))
'    TOFreqC = val(Text23(23))
'    TOFreqG = val(Text23(22))
'    TOFreqT = val(Text23(25))
'    TOPValCOff = val(Text1(24))
'    TOCoeffVar = val(Text1(30))
    TOFreqA = CDbl(val(Text23(24)))
    TOFreqC = CDbl(val(Text23(23)))
    TOFreqG = CDbl(val(Text23(22)))
    TOFreqT = CDbl(val(Text23(25)))
    TOPValCOff = CDbl(val(Text1(24)))
    TOCoeffVar = CDbl(val(Text1(30)))
    
    On Error GoTo 0
    
    If oa <> TOFreqA Or OC <> TOFreqC Or oG <> TOFreqG Or OT <> TOFreqT Then
        GoOn = 1
    End If
    
    If TOTreeType <> xToTreeType Then
        GoOn = 1
    End If
    If DebuggingFlag < 2 Then On Error Resume Next
    TOWinLen = val(Text1(22))
    TOStepSize = val(Text1(19))
    TOSmooth = val(Text1(23))
    TOTvTs = val(Text1(16))
    TOPower = val(Text1(25))
    TORndNum = val(Text1(26))
    TOPerms = val(Text1(27))
    
    TOWinLen = CDbl(val(Text1(22)))
    TOStepSize = CDbl(val(Text1(19)))
    TOSmooth = CDbl(val(Text1(23)))
    TOTvTs = CDbl(val(Text1(16)))
    
    TOPower = CDbl(val(Text1(25)))
    TORndNum = CDbl(val(Text1(26)))
    TOPerms = CDbl(val(Text1(27)))
    On Error GoTo 0
    
    Tot = TOFreqC + TOFreqG + TOFreqT + TOFreqA
    If Tot = 0 Then
        TOFreqA = 0.25
        TOFreqC = 0.25
        TOFreqG = 0.25
        TOFreqT = 0.25
        Tot = 1
    End If
    TOFreqA = TOFreqA / Tot
    TOFreqC = TOFreqC / Tot
    TOFreqG = TOFreqG / Tot
    TOFreqT = TOFreqT / Tot
    'Do Tree options

    If TBSReps <> CDbl(Text1(33)) Then
        DoneTree(1, 0) = 0
        DoneTree(2, 0) = 0
        DoneTree(1, 1) = 0
        DoneTree(1, 2) = 0
        DoneTree(2, 1) = 0
        DoneTree(2, 2) = 0
        If BSupTest = 0 Then
            DoneTree(3, 0) = 0
            DoneTree(3, 1) = 0
            DoneTree(3, 2) = 0
        End If
    End If
   If BSTreeStrat <> xBStreeStrat Then
        'If BSupTest <> 0 Then
        DoneTree(3, 0) = 0
        DoneTree(3, 1) = 0
        DoneTree(3, 2) = 0
        'End If
   End If
   If BSupTest <> xBSupTest Then
        
        DoneTree(3, 0) = 0
        DoneTree(3, 1) = 0
        DoneTree(3, 2) = 0
       
   End If
   ' BSupTest = xBSupTest

    oa = TAfreq
    OC = TCFreq
    oG = TGFreq
    OT = TTFreq
    otvrat = TTVRat
    otpower = TPower
    If DebuggingFlag < 2 Then On Error Resume Next
'    TPower = val(Text1(35))
    TPower = CDbl(val(Text1(35)))
'    TAfreq = val(Text23(31))
'    TCFreq = val(Text23(32))
'    TGFreq = val(Text23(33))
'    TTFreq = val(Text23(30))
    TAfreq = CDbl(val(Text23(31)))
    TCFreq = CDbl(val(Text23(32)))
    TGFreq = CDbl(val(Text23(33)))
    TTFreq = CDbl(val(Text23(30)))
'    TTVRat = val(Text1(32))
    TTVRat = CDbl(val(Text1(32)))
    
    On Error GoTo 0
    
  
    If TTVRat <> otvrat Or TRndSeed <> CDbl(Text1(34)) Or TRndIOrderFlag <> xTRndIOrderFlag Or TModel <> xTModel Or TBaseFreqFlag <> xTBaseFreqFlag Then

        For x = 1 To 3
            For Y = 0 To 2
                DoneTree(x, Y) = 0
            Next Y
        Next 'X

    End If
    
    If TModel = 2 And TCoeffVar <> CDbl(Text1(31)) Then
        For x = 1 To 3
            For Y = 0 To 2
                DoneTree(x, Y) = 0
            Next Y
        Next 'X
    ElseIf TModel = 3 And TBaseFreqFlag = 1 And (TAfreq <> oa Or TCFreq <> OC Or TGFreq <> oG Or TTFreq <> OT) Then

        For x = 1 To 3
            For Y = 0 To 2
                DoneTree(x, Y) = 0
            Next Y
        Next 'X

    End If

    If TPower <> otpower Then
        x = 2
            For Y = 0 To 2
                DoneTree(x, Y) = 0
            Next Y
        
    End If
    
      
    VisRDWin = Text1(44)
    
    If val(Text5(0)) <> MatPermNo Then
        DoneMatX(0) = 0
        DoneMatX(3) = 0
        GoOnBPScan = 1
    End If
    MatPermNo = val(Text5(0))
    If Form3.Combo1.ListIndex <> 1 Then
        If MatWinSize <> val(Text5(1)) Then
            MatWinSize = val(Text5(1))
            DoneMatX(4) = 0: DoneMatX(1) = 0
            GoOnBPScan = 1
        End If
    ElseIf Form3.Combo1.ListIndex = 1 Then
        PHIWin = val(Text5(1))
    End If
    'MatWinSize = val(Text5(1))
    If val(Text5(2)) <> SHWinLen Or SHStep <> val(Text5(9)) Then
        DoneMatX(12) = 0
        DoneMatX(13) = 0
    End If
    SHWinLen = val(Text5(2))
    SHStep = val(Text5(9))
     
    
    TypeSeqNumber = Combo2.ListIndex
    
    'TNegBLFlag = xTNegBLFlag
    'TGRFlag = xTGRFlag
    TBSReps = CDbl(val(Text1(33)))
    TRndSeed = CDbl(val(Text1(34)))
    TCoeffVar = CDbl(val(Text1(31)))
    
    
    If TModel = 3 Then
        If TBSReps < 13 Then TBSReps = 13 'I need to do this to avoid a memory leak in DNADIST - I don't know why its leaking but it is.
    End If
    
    '     TBaseFreqFlag
    Tot = TAfreq + TCFreq + TGFreq + TTFreq
    If Tot = 0 Then
        TAfreq = 0.25
        TCFreq = 0.25
        TGFreq = 0.25
        TTFreq = 0.25
        Tot = 1
    End If
    TAfreq = TAfreq / Tot
    TCFreq = TCFreq / Tot
    TGFreq = TGFreq / Tot
    TTFreq = TTFreq / Tot
    'if midistance
    Form1.Enabled = True
    If Form2.Visible = True Then
        Form2.Enabled = True
    End If
    Form3.Visible = False
    Screen.MousePointer = 0
    Form3.TabStrip1.Visible = True
    Form1.Refresh

    If Form5.Visible = False Then
        
        If OptFlag <> 16 And SEventNumber > 0 And OptFlag > -1 And ManFlag = -1 Then
            If LongWindedFlag = 1 Then
                Call ModSeqNum(0, 0, 0)
             '       ReDim tSeqNum(Len(StrainSeq(0)), 2)
             '       En = XOverlist(RelX, RelY).Eventnumber
             '       For X = 1 To Len(StrainSeq(0))
             '           tSeqNum(X, 0) = SeqNum(X, Seq1)
             '           tSeqNum(X, 1) = SeqNum(X, Seq2)
             '           tSeqNum(X, 2) = SeqNum(X, Seq3)
             '           SeqNum(X, Seq1) = EventSeq(2, X, En)
             '           SeqNum(X, Seq2) = EventSeq(1, X, En)
             '           SeqNum(X, Seq3) = EventSeq(0, X, En)
             '
             '       Next X
             '       If XOverlist(RelX, RelY).ProgramFlag = 5 Then
             '           For X = 1 To Len(StrainSeq(0))
             '               SeqNum(X, Nextno + 1) = EventSeq(3, X, En)
             '           Next X
             '       End If
            End If
        End If
        If OptFlag = 0 And GoOnRDP = 1 Then
            ExeCheckFlag = 1
            Call XOverIII(0)
            
            If XoverList(RelX, RelY).ProgramFlag = 3 Or XoverList(RelX, RelY).ProgramFlag = 3 + AddNum Then
                Call FindSubSeqMC
            ElseIf XoverList(RelX, RelY).ProgramFlag = 2 Or XoverList(RelX, RelY).ProgramFlag = 2 + AddNum Then
                Call FindSubSeqBS
            End If
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        
        ElseIf OptFlag = 1 Then
            Form1.ProgressBar1.Value = 5
            Call UpdateF2Prog
            Call GCCompare

            Form1.ProgressBar1.Value = 70
            Call UpdateF2Prog
            Call GCCheck(0)
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
            Form1.ProgressBar1.Value = 100
            Call UpdateF2Prog
        ElseIf OptFlag = 50 Then
            If xVisRDWin <> VisRDWin Then
                Call VisRD(1)
            End If
        ElseIf OptFlag = 51 Then
            If xVisRDWin <> VisRDWin Then
                Call VisRD(0)
            End If
        
        ElseIf OptFlag = 3 Then

            Call FindSubSeqBS
            AllowExtraSeqsFlag = 0
            SpacerNo = 0
            If BSStepWin > Len(StrainSeq(0)) / 2 Then BSStepWin = Len(StrainSeq(0)) / 2
            If x = x Then
                GlobalMemoryStatus MemSit
                APhys = Abs(MemSit.dwTotalPhys)
                If APhys > 1000000000 Or APhys < 1000000 Then APhys = 1000000000
                If (BSBootReps * BSStepWin * 15) > APhys Then
                    over = (BSBootReps * BSStepWin * 15) / APhys
                    BSBootReps = BSBootReps / over
                    BSStepWin = BSStepWin / over
                    x = x
                Else
                    x = x
                End If
                
                Call FindSubSeqBS
                
                s1col = Yellow
                s1colb = LYellow
                s2col = Purple
                s2colb = LPurple
                s3col = Green
                s2colb = LGreen
                Dim WeightMod() As Long, Scratch() As Integer
                ReDim Scratch(BSStepWin), WeightMod(BSBootReps, BSStepWin - 1)
                Dummy = SEQBOOT2(BSRndNumSeed, BSBootReps, BSStepWin, Scratch(0), WeightMod(0, 0))
                Call BSXoverM(0, 0, WeightMod())

                
                
                If XoverList(RelX, RelY).ProgramFlag = 0 Or XoverList(RelX, RelY).ProgramFlag = 0 + AddNum Then
                    Call FindSubSeqRDP
                    x = x
                ElseIf XoverList(RelX, RelY).ProgramFlag = 3 Or XoverList(RelX, RelY).ProgramFlag = 3 + AddNum Then
                    Call FindSubSeqMC
                End If
                 Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
            Else
                XL = "Bootstrap support (%)"
                Form1.Picture10.Enabled = True
                Form1.Picture10.Picture = LoadPicture()
                Form1.Picture10.CurrentX = 5
                Form1.Picture10.FontSize = 6
                TW = Form1.Picture7.TextWidth(XL)
                Form1.Picture10.CurrentY = Form1.Picture7.Top + 15 + ((PicHeight - 10 - 15) + TW) / 2
                Call DoText(Form1.Picture10, Form1.Picture10.Font, XL, 90)
                
            End If

        ElseIf OptFlag = 4 And GoOn = 1 Then
            ExeCheckFlag = 1
            
            Call MCXoverG(0)
            
            If XoverList(RelX, RelY).ProgramFlag = 0 Or XoverList(RelX, RelY).ProgramFlag = 0 + AddNum Then
                Call FindSubSeqRDP
                x = x
            ElseIf XoverList(RelX, RelY).ProgramFlag = 2 Or XoverList(RelX, RelY).ProgramFlag = 2 + AddNum Then
                Call FindSubSeqBS
            End If
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True

        ElseIf OptFlag = 5 Then

            

                Call LXoverB(0, 1)

                

                 Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 10 Then
            If GoOnChi = 1 Then
                'If BSFileName = "RDP5bsfile2" Then
                    Call CXoverB
                    'Call CXoverC(0)
                    'Call CXoverC(0)
                'Else
                '    Call CXoverC(0)
                'End If
            End If
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 11 Then
            If GoOnChi = 1 Then
                Call CXoverC(0)
            End If
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 9 Then

            Call SSXoverB(0)
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 6 Then

            
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 13 And GoOnPP = 1 Then
            Call PXoverD(0)

        ElseIf OptFlag = 7 Then

            Call DXoverE
            
            
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True

        ElseIf OptFlag = 8 Then

           

                Call TXover3


                 Form1.Command29(1).Enabled = True
           
             
        ElseIf OptFlag = 22 Then
            
            Call MCXoverI
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        
        ElseIf OptFlag = 23 Then
            
            Call DXoverG
        ElseIf OptFlag = 50 Then
            
            Call VisRD(1)
        ElseIf OptFlag = 51 Then
            
            Call VisRD(0)
        ElseIf OptFlag = 31 Then

            Call GCManXOver
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 33 Then

            Call BSXoverN
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 34 Then

            Call MCXoverJ
            XX = LenXoverSeq
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 35 Then

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
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 37 Then
            
            Call DXoverF
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 38 Then
            
            Call TXover3
            
             Form1.Command29(0).Enabled = True: Form1.Command29(1).Enabled = True
        ElseIf OptFlag = 41 And GoOnBPScan = 1 Then
            getit = Form1.Combo1.ListIndex
            DontDoComboFlag = 1
            Form1.Combo1.ListIndex = 0
            DontDoComboFlag = 0
            If getit = 17 Then Form1.Combo1.ListIndex = 17
            If getit = 18 Then Form1.Combo1.ListIndex = 18
            
        End If
        If (RelX Or RelY) > 0 And OptFlag >= 0 And ManFlag = -1 Then
            If XoverList(RelX, RelY).ProgramFlag = 0 Or XoverList(RelX, RelY).ProgramFlag = 0 + AddNum Then
                Call FindSubSeqRDP
                x = x
            ElseIf XoverList(RelX, RelY).ProgramFlag = 6 Or XoverList(RelX, RelY).ProgramFlag = 6 + AddNum Then
                Call FindSubSeqPP
            ElseIf XoverList(RelX, RelY).ProgramFlag = 2 Or XoverList(RelX, RelY).ProgramFlag = 2 + AddNum Then
                Call FindSubSeqBS
            ElseIf (XoverList(RelX, RelY).ProgramFlag = 1 Or XoverList(RelX, RelY).ProgramFlag = 1 + AddNum) And pGCTripletflag = 1 Then
                Call FindSubSeqGC2
            ElseIf (XoverList(RelX, RelY).ProgramFlag = 3 Or XoverList(RelX, RelY).ProgramFlag = 3 + AddNum) And pMCTripletFlag = 0 Then
                Call FindSubSeqMC
            ElseIf (XoverList(RelX, RelY).ProgramFlag = 4 Or XoverList(RelX, RelY).ProgramFlag = 4 + AddNum) Then
                Call FindSubSeqChi
            ElseIf (XoverList(RelX, RelY).ProgramFlag = 5 Or XoverList(RelX, RelY).ProgramFlag = 3 + AddNum) Then
                Call FindSubSeqSS(1, SSOLoSeq)
            End If
        End If
    
        If LongWindedFlag = 1 And OptFlag > -1 And ManFlag = -1 Then
            Call UnModNextno
            Call UnModSeqNum(0)
            'For X = 1 To Len(StrainSeq(0))
            '    SeqNum(X, Seq1) = tSeqNum(X, 0)
            '    SeqNum(X, Seq2) = tSeqNum(X, 1)
            '    SeqNum(X, Seq3) = tSeqNum(X, 2)
            'Next X
        End If
    End If
    XX = LenXoverSeq
    If Form5.Visible = False Then
        Form1.Enabled = True
        If F2ontop = 0 Then
            Form1.ZOrder
        End If
        Form1.Refresh
    End If
    If Form2.Visible = True Then
        Form2.Enabled = True
        'Form2.ZOrder
        Form2.Refresh
    End If
    Form1.Combo1.Enabled = True
    Screen.MousePointer = 0
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
    For x = 0 To AddNum - 1
        If DoScans(0, x) = 1 Then Exit For
    Next x
    If x = AddNum Then
        DoScans(0, 0) = 1
        DoScans(0, 1) = 1
        DoScans(0, 2) = 0
        DoScans(1, 2) = 1
        DoScans(0, 3) = 1
        DoScans(0, 5) = 0
        DoScans(1, 5) = 1
        DoScans(0, 4) = 0
        Call SetChecks
    End If
    If ConsensusProg <> xConsensusProg Then
        Call IntegrateXOvers(0)
        If RelX > 0 Or RelY > 0 Then
         
            SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
            SEN = SEN - 1
            If SEN > 0 Then
                RelX = BestEvent(SEN, 0)
                RelY = BestEvent(SEN, 1)
                Form1.Timer7(0).Enabled = True 'this goes to the next event
            End If
        Else
            'Call IntegrateXOvers(0)
        End If
        x = x
        'If RelX > 0 Or RelY > 0 Then
        '    Call GoToThis2(0, RelX, RelY, PermXVal, PermYVal) 'takes you back to the current event
        '    Form1.Enabled = True
        'End If
      '  DoneTree(0, 3) = 0
      '  TreeImage(3) = 0
      '  DoneTree(1, 3) = 0
      '  DoneTree(2, 3) = 0
      '  DoneTree(3, 3) = 0
      '  DoneTree(4, 3) = 0
      '  CurTree(3) = 0
        'If CurTree(3) = 2 Then
        '    CurTree(3) = 1
       '
       ' ElseIf CurTree(3) = 4 Then
       '     CurTree(3) = 3
       ' End If
        'If CurTree(3) = 0 Then
        '        CurTree(3) = 0
        '        F2TreeIndex = 3
        '        TreeImage(3) = 0
        '        ADT = 1
        '        Call MultTreeWin
        '
        'ElseIf CurTree(3) = 1 Then
        '    'Call DrawUPGMA5
        '    Call DrawFastNJ5(Form2.Picture2(3))
        'ElseIf CurTree(3) = 3 Then
        '    Call DrawPADREU
        'End If
        Form1.ProgressBar1.Value = 0
        Call UpdateF2Prog
    End If
    
    'Public TPTVRat As Double, TPGamma As Long, TPAlpha As Double, TPInvSites As Double, TPModel As Byte, xTPModel As Byte, TPBPFEstimate As Byte, xTPBPFEstimate As Byte
    If DebuggingFlag < 2 Then On Error Resume Next
    
    otvr = TPTVRat
    oTPInvSites = TPInvSites
    oTPGamma = TPGamma
    oTPAlpha = TPAlpha
    
    
    
    Dim oTBGammaCats, oTBNGens, oTBNChains, oTBSampFreq, oTBTemp, oTBSwapFreq, oTBSwapNum
    
    oTBGammaCats = TBGammaCats
    oTBNGens = TBNGens
    oTBNChains = TBNChains
    oTBSampFreq = TBSampFreq
    oTBTemp = TBTemp
    oTBSwapFreq = TBSwapFreq
    oTBSwapNum = TBSwapNum
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    'MaxTemperature = val(Text6(7))
    MaxTemperature = CDbl(val(Text6(7)))
    On Error GoTo 0
    
    If DebuggingFlag < 2 Then On Error Resume Next
    'TPTVRat = val(Text1(17).Text)
    TPTVRat = CDbl(val(Text1(17).Text))
    'TPInvSites = val(Text1(18).Text)
    TPInvSites = CDbl(val(Text1(18).Text))
    'TPGamma = val(Text23(34).Text)
    TPGamma = CLng(val(Text23(34).Text))
    
    'RAxMLCats = val(Text23(35).Text)
    RAxMLCats = CLng(val(Text23(35).Text))
    
    'TPAlpha = val(Text23(42).Text)
    TPAlpha = CDbl(val(Text23(42).Text))
    
   ' TBGammaCats = val((Text1(20).Text))
    TBGammaCats = CLng((val(Text1(20).Text)))
    'TBNGens = val((Text1(39).Text))
    TBNGens = CLng((val(Text1(39).Text)))
    
    TBNChains = val((Text1(40).Text))
    TBNChains = CLng((Text1(40).Text))
    TBSampFreq = val((Text1(38).Text))
    TBSampFreq = CLng((Text1(38).Text))
    'TBTemp = val((Text1(41).Text))
    TBTemp = CDbl((val(Text1(41).Text)))
    
    TBSwapFreq = val((Text1(42).Text))
    TBSwapFreq = CLng((Text1(42).Text))
    TBSwapNum = val((Text1(43).Text))
    TBSwapNum = CLng((Text1(43).Text))
    
    SCHEMADistCO = val(Text6(11).Text)
      
    SCHEMAPermNo = val(Text6(6).Text)
    SCHEMAPermNo = CLng(Text6(6).Text)
    
    If SCHEMAPermNo < 50 Then SCHEMAPermNo = 50
    If SCHEMADistCO < 1 Then SCHEMADistCO = 1
    If SCHEMADistCO > 80 Then SCHEMADistCO = 80
    
    If SSNumPerms < 10 Then
        SSNumPerms = 100
    End If
    If SSNumPerms2 < 10 Then
        SSNumPerms2 = 1000
    End If
    
    On Error GoTo 0
    If xModelTestFlag <> ModelTestFlag Or TPModel <> xTPModel Or otvr <> TPTVRat Or oTPInvSites <> TPInvSites Or oTPGamma <> TPGamma Or oTPAlpha <> TPAlpha Then
        DoneTree(3, 0) = 0
    End If
    
    
    If xTBModel <> TBModel Or xTBGamma <> TBGamma Or oTBGammaCats <> TBGammaCats Or oTBNGens <> TBNGens Or oTBNChains <> TBNChains Or oTBSampFreq <> TBSampFreq Or oTBTemp <> TBTemp Or oTBSwapFreq <> TBSwapFreq Or oTBSwapNum <> TBSwapNum Then
        DoneTree(4, 0) = 0
    End If
    
    If CWinFract > 0.75 Then CWinFract = 0.75
    If MCWinFract > 0.75 Then MCWinFract = 0.75
    On Error GoTo 0
    
    If RelX = 0 And RelY = 0 Then
        Form1.Combo1.Enabled = False
        Form1.Command29(1).Enabled = False
    ElseIf XoverList(RelX, RelY).Accept = 1 Then
        Form1.Command29(1).Enabled = False
    End If
    If xPHIWin <> PHIWin And Form3.Combo1.ListIndex = 1 And DoneMatX(14) = 1 Then
        DoneMatX(14) = 0
        OKPress = 1
        Call DoColourScale
        'DoneMatX(14) = 1
    ElseIf xCurSCale <> CurScale And CurMatrixFlag > 0 And CurMatrixFlag < 255 Then
        OKPress = 1
        Call DoColourScale
        
    End If
    If Form3.Combo5.ListIndex = 1 Then 'use LR
        ConsensusStrat = 1
    ElseIf Form3.Combo5.ListIndex = 0 Then 'use DT
        ConsensusStrat = 0
    ElseIf Form3.Combo5.ListIndex = 2 Then 'use NN
        ConsensusStrat = 2
    End If
End Sub


Private Sub Command16_Click()
    Command1.SetFocus
    MCFlagT = MCFlagT + 1
    If MCFlagT > 2 Then MCFlagT = 0
    If MCFlagT = 0 Then
        
        Label23 = "Bonferroni correction"
    ElseIf MCFlagT = 1 Then
        
        Label23 = "No multiple comparison correction"
    ElseIf MCFlagT = 2 Then
        
        Label23 = "Step down correction"
    End If

End Sub

Private Sub Command2_Click()
    Command1.SetFocus

    If CircularFlagT = 1 Then
        CircularFlagT = 0
        Label16 = "Sequences are linear"
    Else
        CircularFlagT = 1
        Label16 = "Sequences are circular"
    End If

End Sub

Private Sub Command28_Click(Index As Integer)
    Command1.SetFocus
    If Index = 19 Then
        CurScale = CurScale + 1
        If CurScale > 6 Then CurScale = 0
        Call DoColourScale
    ElseIf Index = 50 Then
        ntType = ntType + 1
        If ntType > 1 Then ntType = 0
        If ntType = 0 Then
            Label2(8).Caption = "Sequences are DNA"
        Else
            Label2(8).Caption = "Sequences are RNA"
        End If
    ElseIf Index = 48 Then
        BSupTest = BSupTest + 1
        If BSupTest = 1 Then BSupTest = 2
        If BSupTest > 3 Then BSupTest = 0
        If BSupTest = 0 Then
          Label1(71).Caption = "Bootstrap test"
          Label1(45).Enabled = True
          Label1(46).Enabled = True
          Text1(33).Enabled = True
          Text1(34).Enabled = True
          Text1(33).BackColor = QBColor(15)
          Text1(34).BackColor = QBColor(15)
        ElseIf BSupTest = 1 Then  'approximate lr test returning aLRT stats
          Label1(71).Caption = "Approximate likelihood ratio test (aLRT)"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
        ElseIf BSupTest = 2 Then  'approximate lr test returning chi square based stats
          Label1(71).Caption = "Approximate likelihood ratio test (ChiSq)"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
        ElseIf BSupTest = 3 Then  'sh-like branch support test
          Label1(71).Caption = "SH-like branch support test"
          Label1(45).Enabled = False
          Label1(46).Enabled = False
          Text1(33).Enabled = False
          Text1(34).Enabled = False
          Text1(33).BackColor = Form1.BackColor
          Text1(34).BackColor = Form1.BackColor
        End If
    ElseIf Index = 49 Then
        BSTreeStrat = BSTreeStrat + 1
        If BSTreeStrat > 5 Then BSTreeStrat = 0
        If BSTreeStrat = 0 Then
            Label1(69).Enabled = True
            Label1(72).Caption = "PhyML3 tree search by NNI"
            Command28(48).Enabled = True
            'Label1(71).Caption = "Bootstrap test"
            Label1(71).Enabled = True
            
            Label1(59).Enabled = True
            Label1(60).Enabled = True
            Label21(46).Enabled = True
            Label21(52).Enabled = True
            Text23(34).Visible = True
            Text23(35).Visible = False
            Text1(17).Enabled = True
            Text1(17).BackColor = QBColor(15)
            Text1(18).Enabled = True
            Text1(18).BackColor = QBColor(15)
            Command28(43).Enabled = True
            Command28(47).Enabled = True
            Command28(44).Enabled = True
            Text23(42).BackColor = QBColor(15)
            Text23(42).Enabled = True
            If BSupTest = 0 Then
              'Command28(48).Enabled = False
              'Label1(71).Caption = "Bootstrap test"
              'Label1(71).Enabled = False
              Label1(71).Caption = "Bootstrap test"
              Label1(45).Enabled = True
              Label1(46).Enabled = True
              Text1(33).Enabled = True
              Text1(34).Enabled = True
              Text1(33).BackColor = QBColor(15)
              Text1(34).BackColor = QBColor(15)
            ElseIf BSupTest = 1 Then  'approximate lr test returning aLRT stats
              Label1(71).Caption = "Approximate likelihood ratio test (aLRT)"
              Label1(45).Enabled = False
              Label1(46).Enabled = False
              Text1(33).Enabled = False
              Text1(34).Enabled = False
              Text1(33).BackColor = Form1.BackColor
              Text1(34).BackColor = Form1.BackColor
            ElseIf BSupTest = 2 Then  'approximate lr test returning chi square based stats
              Label1(71).Caption = "Approximate likelihood ratio test (ChiSq)"
              Label1(45).Enabled = False
              Label1(46).Enabled = False
              Text1(33).Enabled = False
              Text1(34).Enabled = False
              Text1(33).BackColor = Form1.BackColor
              Text1(34).BackColor = Form1.BackColor
            ElseIf BSupTest = 3 Then  'sh-like branch support test
              Label1(71).Caption = "SH-like branch support test"
              Label1(45).Enabled = False
              Label1(46).Enabled = False
              Text1(33).Enabled = False
              Text1(34).Enabled = False
              Text1(33).BackColor = Form1.BackColor
              Text1(34).BackColor = Form1.BackColor
            End If
            Call SetMLModel
            'Label1(72).Caption = "Faster RAxML search"
            'Label1(69).Caption = "GTR-CAT"
            
        ElseIf BSTreeStrat = 1 Then
            Label1(72).Caption = "PhyML3 tree search by SPR"
            Label1(69).Enabled = True
        ElseIf BSTreeStrat = 2 Then
            Label1(72).Caption = "PhyML3 tree search by NNI and SPR"
            Label1(69).Enabled = True
        ElseIf BSTreeStrat = 3 Then
            Label1(69).Enabled = True
            Command28(48).Enabled = False
            Label1(71).Caption = "Bootstrap test"
            Label1(71).Enabled = False
            Label1(45).Enabled = True
              Label1(46).Enabled = True
              Text1(33).Enabled = True
              Text1(34).Enabled = True
              Text1(33).BackColor = QBColor(15)
              Text1(34).BackColor = QBColor(15)
            Label1(72).Caption = "Fast PHYML1 search"
        ElseIf BSTreeStrat = 4 Then
            Label1(72).Caption = "Faster RAxML search"
            Label1(71).Caption = "Bootstrap test"
            Label1(71).Enabled = False
            Command28(48).Enabled = False
            
            Label1(24).Caption = "GTR-CAT"
            Label1(69).Enabled = False
            Label1(59).Enabled = False
            Label1(60).Enabled = False
            Label21(46).Enabled = False
            Label21(52).Enabled = False
            Label21(42).Enabled = False
            'Text23(34).Enabled = False
            
            Text23(34).Visible = False
            Text23(35).Visible = True
            Text23(35).Enabled = False
            Text23(35).BackColor = Form1.BackColor
            Text1(17).Enabled = False
            Text1(18).Enabled = False
            Command28(43).Enabled = False
            Command28(47).Enabled = False
            Text1(17).BackColor = Form1.BackColor
            Text1(18).BackColor = Form1.BackColor
            Command28(44).Enabled = False
            Text23(42).BackColor = Form1.BackColor
            Text23(42).Enabled = False
            'disable everything and change model label to GTR-CAT
        ElseIf BSTreeStrat = 5 Then
        
            Label1(71).Enabled = True
            Label1(71).Caption = "SH-like branch support test"
            Command28(48).Enabled = False
            Label1(45).Enabled = False
            Label1(46).Enabled = False
            Text1(33).Enabled = False
            Text1(34).Enabled = False
            Text1(33).BackColor = Form1.BackColor
            Text1(34).BackColor = Form1.BackColor
            
            Label1(72).Caption = "Fastest FastTree search"
            Label1(24).Caption = "GTR-CAT"
            Label1(69).Enabled = False
            Label1(59).Enabled = False
            Label1(60).Enabled = False
            
            Label21(42).Enabled = False
            'Text23(34).Enabled = False
            Label21(46).Enabled = False
            Label21(52).Enabled = False
            Text23(34).Visible = False
            Text23(35).Visible = True
            Text23(35).Enabled = False
            Text23(35).BackColor = Form1.BackColor
            Text23(35).Enabled = False
            Text23(35).BackColor = Form1.BackColor
            Text1(17).Enabled = False
            Text1(18).Enabled = False
            Command28(43).Enabled = False
            Command28(47).Enabled = False
            Text1(17).BackColor = Form1.BackColor
            Text1(18).BackColor = Form1.BackColor
            Command28(44).Enabled = False
            Text23(42).BackColor = Form1.BackColor
            Text23(42).Enabled = False
            'disable everything and change model label to GTR-CAT
        End If
    ElseIf Index = 46 Then
        TBGamma = TBGamma + 1
        If TBGamma > 2 Then TBGamma = 0
        Call SetTBGamma
    ElseIf Index = 47 Then
        ModelTestFlag = ModelTestFlag + 1
        If ModelTestFlag > 2 Then ModelTestFlag = 0
        Call SetMLModel
    ElseIf Index = 44 Then
        TPBPFEstimate = TPBPFEstimate + 1
        If TPBPFEstimate > 1 Then TPBPFEstimate = 0
        If TPBPFEstimate = 0 Then
            Label21(46) = "Empirical base frequency estimates"
        Else
            Label21(46) = "Maximum likelihood base frequency estimates"
        End If
    ElseIf Index = 45 Then
        TBModel = TBModel + 1
        If TBModel > 2 Then TBModel = 0
        Call SetTBModel
    ElseIf Index = 42 Then
        GCFlag = GCFlag + 1
        If GCFlag > 1 Then
            GCFlag = 0
            Label2(4).Caption = "Do not use gene conversion model"
            Label2(5).Enabled = False
            Text6(4).Enabled = False
            Text6(4).BackColor = Form1.BackColor
        Else
            Label2(4).Caption = "Use gene conversion model"
            Label2(5).Enabled = True
            Text6(4).Enabled = True
            Text6(4).BackColor = RGB(255, 255, 255)
        End If
    ElseIf Index = 41 Then
        If LRDWin = 0 Then
            LRDWin = 1
        Else
            LRDWin = 0
        End If
        If LRDRegion = 1 Then
            Label21(2) = "Test one breakpoint"
            If LRDWin = 0 Then
                Label21(40) = "Moving partition scan"
            End If
        Else
            Label21(2) = "Test two breakpoints"
            If LRDWin = 0 Then
                Label21(40) = "Moving partitions scan"
            End If
        End If
        
        If LRDWin = 0 Then
            Text23(1).Enabled = False
            Label21(41).Enabled = False
            Text23(1).BackColor = Form1.BackColor
            Label21(2).Enabled = True
            Command28(40).Enabled = True
        Else
            Label21(40) = "Sliding window scan"
            Text23(1).Enabled = True
            Text23(1).BackColor = QBColor(15)
            '.Text23(1).ForeColor = 0
            Label21(41).Enabled = True
             Label21(2).Enabled = False
            Command28(40).Enabled = False
        End If
    ElseIf Index = 40 Then
        If LRDRegion = 1 Then
            LRDRegion = 2
        Else
            LRDRegion = 1
        End If
        If LRDRegion = 1 Then
            Label21(2) = "Test one breakpoint"
            If LRDWin = 0 Then
                Label21(40) = "Moving partition scan"
            End If
        Else
            Label21(2) = "Test two breakpoints"
            If LRDWin = 0 Then
                Label21(40) = "Moving partitions scan"
            End If
        End If
    ElseIf Index = 2 Then
        xGCSeqTypeFlag = xGCSeqTypeFlag + 1

        If xGCSeqTypeFlag = 4 Then xGCSeqTypeFlag = 0

        If xGCSeqTypeFlag = 0 Then
            Label29.Caption = "Automatic detection of sequence type"
            Label32.Enabled = False
            Command28(4).Enabled = False
        ElseIf xGCSeqTypeFlag = 1 Then
            Label29.Caption = "Sequences are DNA"
            Label32.Enabled = False
            Command28(4).Enabled = False
        ElseIf xGCSeqTypeFlag = 2 Then
            Label29.Caption = "Sequences are DNA coding region"
            Label32.Enabled = True
            Command28(4).Enabled = True
        ElseIf xGCSeqTypeFlag = 3 Then
            Label29.Caption = "Sequences are protein"
            Label32.Enabled = False
            Command28(4).Enabled = False
        End If
    ElseIf Index = 38 Then
        IncSelf = IncSelf + 1
        If IncSelf = 2 Then IncSelf = 0
        If IncSelf = 1 Then
            Label14(2) = "Use self comparrisons"
        Else
            Label14(2) = "Do not use self comparrisons"
        End If
    ElseIf Index = 37 Then
        PPStripGaps = PPStripGaps + 1
        If PPStripGaps = 2 Then PPStripGaps = 0
        If PPStripGaps = 0 Then
            Label14(1) = "Ignor gaps"
        ElseIf PPStripGaps = 1 Then
            Label14(1) = "Strip gaps"
        ElseIf PPStripGaps = 2 Then
            Label14(1) = "Use gaps as fith character"
        End If
    ElseIf Index = 33 Then
        SSGapFlag = SSGapFlag + 1
        If SSGapFlag > 1 Then SSGapFlag = 0
        If SSGapFlag = 0 Then
            Label22(3) = "Strip gaps"
        Else
            Label22(3) = "Use gaps"
        End If
    ElseIf Index = 36 Then
        SSVarPFlag = SSVarPFlag + 1
        If SSVarPFlag > 2 Then SSVarPFlag = 0
        If SSVarPFlag = 0 Then
            Label22(4) = "Use all positions"
        ElseIf SSVarPFlag = 1 Then
            Label22(4) = "Use only 1/2/3/4 variable positions"
        Else
            Label22(4) = "Use only 1/2/3 variable positions"
        End If
    ElseIf Index = 35 Then
        SSOutlyerFlag = SSOutlyerFlag + 1
        If SSOutlyerFlag > 2 Then SSOutlyerFlag = 0
        If SSOutlyerFlag = 0 Then
            Label22(5) = "Use randomised sequence"
        ElseIf SSOutlyerFlag = 1 Then
            Label22(5) = "Use nearest outlyer"
        Else
            Label22(5) = "Use most divergent sequence"
        End If
    ElseIf Index = 34 Then
        SSFastFlag = SSFastFlag + 1
        If SSFastFlag > 1 Then SSFastFlag = 0
        If SSFastFlag = 0 Then
            Label22(6) = "Do slow exhaustive scan"
        Else
            Label22(6) = "Do fast scan"
        End If


    ElseIf Index = 28 Then
        BSPValFlag = BSPValFlag + 1
        If BSPValFlag > 2 Then BSPValFlag = 0
        If BSPValFlag = 0 Then
            Label1(48) = "Use bootstrap value as P-value"
        ElseIf BSPValFlag = 1 Then
            Label1(48) = "Calculate binomial P-value"
        ElseIf BSPValFlag = 2 Then
            Label1(48) = "Calculate Chi square P-value"
        End If
    ElseIf Index = 23 Then
        BSTypeFlag = BSTypeFlag + 1

        If BSTypeFlag > 2 Then BSTypeFlag = 0

        If BSTypeFlag = 0 Then
            Label1(37) = "Use distances"
        ElseIf BSTypeFlag = 1 Then
            Label1(37) = "Use UPGMA trees"
        ElseIf BSTypeFlag = 2 Then
            Label1(37) = "Use neighbour joining trees"
        ElseIf BSTypeFlag = 3 Then
            Label1(37) = "Use least squares trees"
        ElseIf BSTypeFlag = 4 Then
            Label1(37) = "Use maximum likelihood trees"
        End If

    ElseIf Index = 25 Then
        
    ElseIf Index = 3 Then
        xGCIndelFlag = xGCIndelFlag + 1

        If xGCIndelFlag = 2 Then xGCIndelFlag = 0

        If xGCIndelFlag = 0 Then
            Label31.Caption = "Ignor indels"
        ElseIf xGCIndelFlag = 1 Then
            Label31.Caption = "Treat indel blocs as one polymorphism"
        ElseIf xGCIndelFlag = 2 Then
            Label31.Caption = "Treat each indel site as a polymorphism"
        End If

    ElseIf Index = 4 Then
        

    ElseIf Index = 8 Then
        xGCTripletFlag = xGCTripletFlag + 1

        If xGCTripletFlag = 2 Then xGCTripletFlag = 0

        If xGCTripletFlag = 0 Then
            Label39.Caption = "Scan sequence pairs"
            Command28(2).Enabled = True
            Command28(4).Enabled = True
            Text21.Enabled = True
            Text22.Enabled = True
            Label48.Enabled = True
            Label47.Enabled = True
            Label32.Enabled = True
            
            Frame13.Enabled = True
            Label38.Enabled = True
            Text14.Enabled = True
            Text13.Enabled = True
            Label37.Enabled = True
            
            Frame16.Enabled = True
            Label26.Enabled = True
            Label27.Enabled = True
            Label33.Enabled = True
            Label34.Enabled = True
            Label30.Enabled = True
            Label35.Enabled = True
            Label28.Enabled = True
            Label45.Enabled = True
            Label46.Enabled = True
            Label59.Enabled = True
            Label29.Enabled = True
            Text19.Enabled = True
            Text20.Enabled = True
            
            Text10.Enabled = True
            Text11.Enabled = True
            Command28(0).Enabled = True
            Command28(5).Enabled = True
            Command28(6).Enabled = True
            Command28(1).Enabled = True
            Command28(7).Enabled = True
            Text21.BackColor = QBColor(15)
            Text11.BackColor = QBColor(15)
            Text10.BackColor = QBColor(15)
            
            Text20.BackColor = QBColor(15)
            Text19.BackColor = QBColor(15)
            Text14.BackColor = QBColor(15)
            Text13.BackColor = QBColor(15)
            Text22.BackColor = QBColor(15)
        Else
            Label39.Caption = "Scan sequence triplets"

            'Disbable large sections of the interface
            Command28(2).Enabled = False
            Command28(4).Enabled = False
            Text21.Enabled = False
            
            Text22.Enabled = False
            Label48.Enabled = False
            Label47.Enabled = False
            Label32.Enabled = False
            Label29.Enabled = False
            
            Frame13.Enabled = False
            Label38.Enabled = False
            Text14.Enabled = False
            Text13.Enabled = False
            Label37.Enabled = False
            
            Frame16.Enabled = False
            Label26.Enabled = False
            Label27.Enabled = False
            Label33.Enabled = False
            Label34.Enabled = False
            Label30.Enabled = False
            Label35.Enabled = False
            Label28.Enabled = False
            Label45.Enabled = False
            Label46.Enabled = False
            Label59.Enabled = False
            
            Text19.Enabled = False
            Text20.Enabled = False
            
            Text10.Enabled = False
            Text11.Enabled = False
            Command28(0).Enabled = False
            Command28(5).Enabled = False
            Command28(6).Enabled = False
            Command28(1).Enabled = False
            Command28(7).Enabled = False
            Text21.BackColor = Form1.Command1.BackColor
            Text11.BackColor = Form1.Command1.BackColor
            Text10.BackColor = Form1.Command1.BackColor
            
            Text20.BackColor = Form1.Command1.BackColor
            Text19.BackColor = Form1.Command1.BackColor
            Text14.BackColor = Form1.Command1.BackColor
            Text13.BackColor = Form1.Command1.BackColor
            Text22.BackColor = Form1.Command1.BackColor
        
        End If

    ElseIf Index = 0 Then
        xGCOutFlag = xGCOutFlag + 1

        If xGCOutFlag = 4 Then xGCOutFlag = 0

        If xGCOutFlag = 0 Then
            Label27.Caption = "Space separated output"
        ElseIf xGCOutFlag = 1 Then
            Label27.Caption = "Tab separated output"
        ElseIf xGCOutFlag = 2 Then
            Label27.Caption = "DIF-format spreadsheet output"
        ElseIf xGCOutFlag = 3 Then
            Label27.Caption = "Output in all formats"
        End If

    ElseIf Index = 5 Then
        xGCOutFlagII = xGCOutFlagII + 1

        If xGCOutFlagII = 2 Then xGCOutFlagII = 0

        If xGCOutFlagII = 0 Then
            Label33.Caption = "Simple output"
            Command29.Enabled = False
        Else
            Label33.Caption = "Maximum output"
            'Command29.Enabled = True
        End If

    ElseIf Index = 6 Then
        xGCSortFlag = xGCSortFlag + 1

        If xGCSortFlag = 3 Then xGCSortFlag = 0

        If xGCSortFlag = 0 Then
            Label34.Caption = "Sort fragment lists by P-Value"
        ElseIf xGCSortFlag = 1 Then
            Label34.Caption = "Sort lists alphabetically by name"
        ElseIf xGCSortFlag = 2 Then
            Label34.Caption = "Sort lists by P-Value then name"
        End If

    ElseIf Index = 7 Then
        xGCPermPolyFlag = xGCPermPolyFlag + 1

        If xGCPermPolyFlag = 2 Then xGCPermPolyFlag = 0

        If xGCPermPolyFlag = 0 Then
            Label59.Caption = "Use simple polymorphisms"
        ElseIf xGCPermPolyFlag = 1 Then
            Label59.Caption = "Use only multiple polymorphisms"
        End If

    ElseIf Index = 1 Then
        xGCLogFlag = xGCLogFlag + 1

        If xGCLogFlag = 3 Then xGCLogFlag = 0

        If xGCLogFlag = 0 Then
            Label28.Caption = "Write log file"
        ElseIf xGCLogFlag = 1 Then
            Label28.Caption = "Append existing log file"
        ElseIf xGCLogFlag = 2 Then
            Label28.Caption = "Do not write log file"
        End If

    ElseIf Index = 10 Then
        xLRDModel = xLRDModel + 1

        If xLRDModel = 3 Then
            xLRDModel = 0
            Label21(0).Caption = "Hasegawa, Kishino and Yano, 1985"
            Frame21(2).Enabled = False

            For x = 14 To 19
                Label21(x).Enabled = False
            Next 'X

            Label21(12).Enabled = True
            Text23(11).Enabled = True
            Text23(11).ForeColor = QBColor(0)
            Text23(11).BackColor = QBColor(15)

            For x = 12 To 16
                Text23(x).ForeColor = QBColor(8)
                Text23(x).BackColor = Form3.BackColor
            Next 'X

        ElseIf xLRDModel = 1 Then
            Label21(0).Caption = "Falsenstein, 1984"
            Label21(13).Enabled = True
            Command28(11).Enabled = True

            If xLRDBaseFreqFlag = 0 Then
                Label21(13).Caption = "Estimate from alignment"

                For x = 8 To 11
                    Label21(x).Enabled = False
                Next 'X

                For x = 7 To 10
                    Text23(x).ForeColor = QBColor(8)
                    Text23(x).BackColor = Form3.BackColor
                    Text23(x).Enabled = False
                Next 'X

            End If

        ElseIf xLRDModel = 2 Then
            Command28(11).Enabled = False
            Label21(13).Enabled = False
            Label21(13).Caption = "User defined"

            For x = 8 To 11
                Label21(x).Enabled = True
            Next 'X

            For x = 7 To 10
                Text23(x).Enabled = True
                Text23(x).ForeColor = QBColor(0)
                Text23(x).BackColor = QBColor(15)
            Next 'X

            Label21(0).Caption = "Reversible process"
            Frame21(2).Enabled = True

            For x = 14 To 19
                Label21(x).Enabled = True
            Next 'X

            Label21(12).Enabled = False
            Text23(11).Enabled = False
            Text23(11).ForeColor = QBColor(8)
            Text23(11).BackColor = Form3.BackColor

            For x = 12 To 16
                Text23(x).ForeColor = QBColor(0)
                Text23(x).BackColor = QBColor(15)
            Next 'X

        End If

    ElseIf Index = 11 Then
        xLRDBaseFreqFlag = xLRDBaseFreqFlag + 1

        If xLRDBaseFreqFlag = 2 Then xLRDBaseFreqFlag = 0

        If xLRDBaseFreqFlag = 0 Then
            Label21(13).Caption = "Estimate from alignment"

            For x = 8 To 11
                Label21(x).Enabled = False
            Next 'X

            For x = 7 To 10
                Text23(x).ForeColor = QBColor(8)
                Text23(x).BackColor = Form3.BackColor
                Text23(x).Enabled = False
            Next 'X

        ElseIf xLRDBaseFreqFlag = 1 Then
            Label21(13).Caption = "User defined"

            For x = 8 To 11
                Label21(x).Enabled = True
            Next 'X

            For x = 7 To 10
                Text23(x).Enabled = True
                Text23(x).ForeColor = QBColor(0)
                Text23(x).BackColor = QBColor(15)
            Next 'X

        End If

    ElseIf Index = 12 Then
        MCProportionFlag = MCProportionFlag + 1

        If MCProportionFlag = 2 Then MCProportionFlag = 0
        'MCWinFract = cdbl(Text1(21))

        If MCProportionFlag = 0 Then
            Label1(11) = "Set window size"
            Label1(27) = "# Variable sites per window"
            Text1(21) = MCWinSize
        Else
            Label1(11) = "Variable window size"
            Label1(27) = "Fraction of variable sites per window"
            'If Nextno > 0 Then
            Text1(21) = MCWinFract
            'End If
        End If
    ElseIf Index = 39 Then
        CProportionFlag = CProportionFlag + 1

        If CProportionFlag = 2 Then CProportionFlag = 0

        If CProportionFlag = 0 Then
            Label1(55) = "Set window size"
            Label1(56) = "# Variable sites per window"
            Text1(36) = CWinSize
        Else
            Label1(55) = "Variable window size"
            Label1(56) = "Fraction of variable sites per window"
            Text1(36) = CWinFract
        End If
    ElseIf Index = 13 Then
        MCTripletFlag = MCTripletFlag + 1

        If MCTripletFlag = 2 Then MCTripletFlag = 0

        If MCTripletFlag = 0 Then
            Label1(13) = "Scan triplets"
            '           Command28(14).Enabled = True
            '           If MCStripGapsFlag = 0 Then
            '               Label1(16) = "Use gaps"
            '           Else
            '               Label1(16) = "Strip gaps"
            '           End If
            '           Label1(16).ForeColor = QBColor(0)
        Else
            Label1(13) = "Scan entire dataset simultaneously"
            '            Command28(14).Enabled = False
            '            Label1(16).Caption = "Use gaps"
            '            Label1(16).ForeColor = QBColor(8)
        End If
    
    ElseIf Index = 14 Then
        MCStripGapsFlag = MCStripGapsFlag + 1

        If MCStripGapsFlag = 2 Then MCStripGapsFlag = 0

        If MCStripGapsFlag = 0 Then
            Label1(16) = "Use gaps"
        Else
            Label1(16) = "Strip gaps"
        End If

    ElseIf Index = 15 Then
        RetSiteFlag = RetSiteFlag + 1

        If RetSiteFlag > 3 Then RetSiteFlag = 1

        If RetSiteFlag = 1 Then
            Label1(17) = "Use only binary sites"
        ElseIf RetSiteFlag = 2 Then
            Label1(17) = "Use as transition/transversions"
        ElseIf RetSiteFlag = 3 Then
            Label1(17) = "Use all sites"
        End If

    ElseIf Index = 19 Then
        

    ElseIf Index = 20 Then
        TOFreqFlag = TOFreqFlag + 1

        If TOFreqFlag > 1 Then TOFreqFlag = 0

        If TOFreqFlag = 0 Then
            Label21(29).Caption = "Estimate from alignment"
            Text23(25).BackColor = Form1.BackColor
            Text23(24).BackColor = Form1.BackColor
            Text23(23).BackColor = Form1.BackColor
            Text23(22).BackColor = Form1.BackColor
            Text23(25).Enabled = False
            Text23(24).Enabled = False
            Text23(23).Enabled = False
            Text23(22).Enabled = False
            Label21(28).Enabled = False
            Label21(27).Enabled = False
            Label21(26).Enabled = False
            Label21(25).Enabled = False
        Else
            Label21(29).Caption = "User defined"
            Text23(25).BackColor = QBColor(15)
            Text23(24).BackColor = QBColor(15)
            Text23(23).BackColor = QBColor(15)
            Text23(22).BackColor = QBColor(15)
            Text23(25).Enabled = True
            Text23(24).Enabled = True
            Text23(23).Enabled = True
            Text23(22).Enabled = True
            Label21(28).Enabled = True
            Label21(27).Enabled = True
            Label21(26).Enabled = True
            Label21(25).Enabled = True
        End If

    ElseIf Index = 17 Then
        DPBFreqFlag = DPBFreqFlag + 1

        If DPBFreqFlag > 1 Then DPBFreqFlag = 0

        If DPBFreqFlag = 0 Then
            Label21(20).Caption = "Estimate from alignment"
            Text23(18).BackColor = Form1.BackColor
            Text23(19).BackColor = Form1.BackColor
            Text23(20).BackColor = Form1.BackColor
            Text23(21).BackColor = Form1.BackColor
            Text23(18).Enabled = False
            Text23(19).Enabled = False
            Text23(20).Enabled = False
            Text23(21).Enabled = False
            Label21(21).Enabled = False
            Label21(22).Enabled = False
            Label21(23).Enabled = False
            Label21(24).Enabled = False
        Else
            Label21(20).Caption = "User defined"
            Text23(18).BackColor = QBColor(15)
            Text23(19).BackColor = QBColor(15)
            Text23(20).BackColor = QBColor(15)
            Text23(21).BackColor = QBColor(15)
            Text23(18).Enabled = True
            Text23(19).Enabled = True
            Text23(20).Enabled = True
            Text23(21).Enabled = True
            Label21(21).Enabled = True
            Label21(22).Enabled = True
            Label21(23).Enabled = True
            Label21(24).Enabled = True
        End If

    ElseIf Index = 21 Then
        TOModel = TOModel + 1

        If TOModel > 3 Then TOModel = 0

        If TOModel = 0 Then
            Label1(25).Caption = "Jukes and Cantor, 1969"
            Frame21(4).Enabled = False
            Text1(16).Text = "0.5"
            Text1(16).Enabled = False
            Text1(16).BackColor = Form1.BackColor
            Label1(28).Enabled = False
            Text1(30).Enabled = False
            Text1(30).BackColor = Form1.BackColor
            Text1(30).ForeColor = QBColor(8)
            Label1(41).Enabled = False
            Label21(29).Enabled = False
            Command28(20).Enabled = False
            Text23(25).BackColor = Form1.BackColor
            Text23(24).BackColor = Form1.BackColor
            Text23(23).BackColor = Form1.BackColor
            Text23(22).BackColor = Form1.BackColor
            Text23(25).Enabled = False
            Text23(24).Enabled = False
            Text23(23).Enabled = False
            Text23(22).Enabled = False
            Label21(28).Enabled = False
            Label21(27).Enabled = False
            Label21(26).Enabled = False
            Label21(25).Enabled = False
        ElseIf TOModel = 1 Then
            Label1(25).Caption = "Kimura, 1980"
            Text1(16).Text = TOTvTs
            Text1(16).Enabled = True
            Text1(16).BackColor = QBColor(15)
            Label1(28).Enabled = True
            Label1(29).Enabled = True
            Text1(30).Enabled = False
            Text1(30).BackColor = Form1.BackColor
            Text1(30).ForeColor = QBColor(8)
            Label1(41).Enabled = False
            Frame21(4).Enabled = False
            Label21(29).Enabled = False
            Command28(20).Enabled = False
            Text23(25).BackColor = Form1.BackColor
            Text23(24).BackColor = Form1.BackColor
            Text23(23).BackColor = Form1.BackColor
            Text23(22).BackColor = Form1.BackColor
            Text23(25).Enabled = False
            Text23(24).Enabled = False
            Text23(23).Enabled = False
            Text23(22).Enabled = False
            Label21(28).Enabled = False
            Label21(27).Enabled = False
            Label21(26).Enabled = False
            Label21(25).Enabled = False
        ElseIf TOModel = 2 Then
            Label1(25).Caption = "Jin  and  Nei, 1990"
            Text1(16).Text = TOTvTs
            Text1(16).Enabled = True
            Text1(16).BackColor = QBColor(15)
            Text1(30).Enabled = True
            Text1(30).BackColor = QBColor(15)
            Text1(30).ForeColor = QBColor(0)
            Label1(41).Enabled = True
            Label1(29).Enabled = True
            Label1(28).Enabled = True
            Frame21(4).Enabled = False
            Label21(29).Enabled = False
            Command28(20).Enabled = False
            Text23(25).BackColor = Form1.BackColor
            Text23(24).BackColor = Form1.BackColor
            Text23(23).BackColor = Form1.BackColor
            Text23(22).BackColor = Form1.BackColor
            Text23(25).Enabled = False
            Text23(24).Enabled = False
            Text23(23).Enabled = False
            Text23(22).Enabled = False
            Label21(28).Enabled = False
            Label21(27).Enabled = False
            Label21(26).Enabled = False
            Label21(25).Enabled = False
        ElseIf TOModel = 3 Then
            Label1(25).Caption = "Felsenstein, 1984"
            Text1(16).Text = TOTvTs
            Text1(16).Enabled = True
            Text1(16).BackColor = QBColor(15)
            Label1(29).Enabled = True
            Text1(30).Enabled = False
            Text1(30).BackColor = Form1.BackColor
            Text1(30).ForeColor = QBColor(8)
            Label1(41).Enabled = False
            Frame21(4).Enabled = True
            Label21(29).Enabled = True
            Label1(28).Enabled = True
            Command28(20).Enabled = True

            If TOFreqFlag = 1 Then
                Text23(25).Enabled = True
                Text23(24).Enabled = True
                Text23(23).Enabled = True
                Text23(22).Enabled = True
                Text23(25).BackColor = QBColor(15)
                Text23(24).BackColor = QBColor(15)
                Text23(23).BackColor = QBColor(15)
                Text23(22).BackColor = QBColor(15)
                Label21(28).Enabled = True
                Label21(27).Enabled = True
                Label21(26).Enabled = True
                Label21(25).Enabled = True
            Else
                Text23(25).Enabled = False
                Text23(24).Enabled = False
                Text23(23).Enabled = False
                Text23(22).Enabled = False
                Label21(28).Enabled = False
                Label21(27).Enabled = False
                Label21(26).Enabled = False
                Label21(25).Enabled = False
            End If

        End If

    ElseIf Index = 22 Then
        TOTreeType = TOTreeType + 1

        If TOTreeType > 1 Then TOTreeType = 0

        If TOTreeType = 0 Then
            Label1(34) = "Construct only LS trees"
        Else
            Label1(34) = "Construct NJ and LS trees"
        End If

    ElseIf Index = 24 Then
        BSFreqFlag = BSFreqFlag + 1

        If BSFreqFlag > 1 Then BSFreqFlag = 0

        If BSFreqFlag = 0 Then
            Label21(34).Caption = "Estimate from alignment"

            For x = 26 To 29
                Text23(x).BackColor = Form1.BackColor
                Text23(x).Enabled = False
            Next 'X

            For x = 30 To 33
                Label21(x).Enabled = False
            Next 'X

        Else
            Label21(34).Caption = "User defined"

            For x = 26 To 29
                Text23(x).BackColor = QBColor(15)
                Text23(x).Enabled = True
            Next 'X

            For x = 30 To 33
                Label21(x).Enabled = True
            Next 'X

        End If

    ElseIf Index = 9 Then
        xBSSubModelFlag = xBSSubModelFlag + 1

        If xBSSubModelFlag > 4 Then xBSSubModelFlag = 0

        If xBSSubModelFlag = 0 Then
            Label1(4).Caption = "Jukes and Cantor, 1969"
            Text1(4).Enabled = False
            Text1(4).BackColor = Form1.BackColor
            Text1(4).ForeColor = QBColor(8)
            Text1(4) = "0.5"
            Label1(5).Enabled = False
            Text1(28).Enabled = False
            Text1(28).BackColor = Form1.BackColor
            Text1(28).ForeColor = QBColor(8)
            Label1(39).Enabled = False
            Frame21(5).Enabled = False
            Command28(24).Enabled = False

            For x = 26 To 29
                Text23(x).BackColor = Form1.BackColor
                Text23(x).Enabled = False
            Next 'X

            For x = 30 To 34
                Label21(x).Enabled = False
            Next 'X
        ElseIf xBSSubModelFlag = 4 Then
            Label1(4).Caption = "Similarities"
            Text1(4).Enabled = False
            Text1(4).BackColor = Form1.BackColor
            Text1(4).ForeColor = QBColor(8)
            Text1(4) = "0.5"
            Label1(5).Enabled = False
            Text1(28).Enabled = False
            Text1(28).BackColor = Form1.BackColor
            Text1(28).ForeColor = QBColor(8)
            Label1(39).Enabled = False
            Frame21(5).Enabled = False
            Command28(24).Enabled = False

            For x = 26 To 29
                Text23(x).BackColor = Form1.BackColor
                Text23(x).Enabled = False
            Next 'X

            For x = 30 To 34
                Label21(x).Enabled = False
            Next 'X
        ElseIf xBSSubModelFlag = 1 Then
            Label1(4).Caption = "Kimura, 1980"
            Text1(4).Enabled = True
            Text1(4).BackColor = QBColor(15)
            Text1(4).ForeColor = QBColor(0)
            Text1(4) = xBSTTRatio
            Label1(5).Enabled = True
            Text1(28).Enabled = False
            Text1(28).BackColor = Form1.BackColor
            Text1(28).ForeColor = QBColor(8)
            Label1(39).Enabled = False
            Frame21(5).Enabled = False
            Command28(24).Enabled = False

            For x = 26 To 29
                Text23(x).BackColor = Form1.BackColor
                Text23(x).Enabled = False
            Next 'X

            For x = 30 To 34
                Label21(x).Enabled = False
            Next 'X

        ElseIf xBSSubModelFlag = 2 Then
            Label1(4).Caption = "Jin  and  Nei, 1990"
            Text1(4).Enabled = True
            Text1(4).BackColor = QBColor(15)
            Text1(4).ForeColor = QBColor(0)
            Text1(4) = xBSTTRatio
            Label1(5).Enabled = True
            Text1(28).Enabled = True
            Text1(28).BackColor = QBColor(15)
            Text1(28).ForeColor = QBColor(0)
            Label1(39).Enabled = True
            Frame21(5).Enabled = False
            Command28(24).Enabled = False

            For x = 26 To 29
                Text23(x).BackColor = Form1.BackColor
                Text23(x).Enabled = False
            Next 'X

            For x = 30 To 33
                Label21(x).Enabled = False
            Next 'X

        ElseIf xBSSubModelFlag = 3 Then
            Label1(4).Caption = "Felsenstein, 1984"
            Text1(4).Enabled = True
            Text1(4).BackColor = QBColor(15)
            Text1(4).ForeColor = QBColor(0)
            Text1(4) = xBSTTRatio
            Text1(28).Enabled = False
            Text1(28).BackColor = Form1.BackColor
            Text1(28).ForeColor = QBColor(8)
            Label1(39).Enabled = False
            Label1(5).Enabled = True
            Frame21(5).Enabled = True
            Command28(24).Enabled = True
            Label21(34).Enabled = True

            If BSFreqFlag = 0 Then

                For x = 26 To 29
                    Text23(x).BackColor = Form1.BackColor
                    Text23(x).Enabled = False
                Next 'X

                For x = 30 To 33
                    Label21(x).Enabled = False
                Next 'X

            Else

                For x = 26 To 29
                    Text23(x).BackColor = QBColor(15)
                    Text23(x).Enabled = True
                Next 'X

                For x = 30 To 33
                    Label21(x).Enabled = True
                Next 'X

            End If

        End If

    ElseIf Index = 18 Then
        DPModelFlag = DPModelFlag + 1

        If DPModelFlag > 4 Then DPModelFlag = 0

        If DPModelFlag = 0 Then
            Label1(21).Caption = "Jukes and Cantor, 1969"
            Frame21(3).Enabled = False
            tDbl = 0.5
            Text1(15).Text = tDbl
            Text1(15).Enabled = False
            Text1(15).BackColor = Form1.BackColor
            Text1(29).Enabled = False
            Text1(29).BackColor = Form1.BackColor
            Text1(29).ForeColor = QBColor(8)
            Label1(40).Enabled = False
            Label1(20).Enabled = False
            Label21(20).Enabled = False
            Command28(17).Enabled = False
            Text23(18).BackColor = Form1.BackColor
            Text23(19).BackColor = Form1.BackColor
            Text23(20).BackColor = Form1.BackColor
            Text23(21).BackColor = Form1.BackColor
            Text23(18).Enabled = False
            Text23(19).Enabled = False
            Text23(20).Enabled = False
            Text23(21).Enabled = False
            Label21(21).Enabled = False
            Label21(22).Enabled = False
            Label21(23).Enabled = False
            Label21(24).Enabled = False
        ElseIf DPModelFlag = 4 Then
            Label1(21).Caption = "Similarities"
            Frame21(3).Enabled = False
            tDbl = 0.5
            Text1(15).Text = tDbl
            Text1(15).Enabled = False
            Text1(15).BackColor = Form1.BackColor
            Text1(29).Enabled = False
            Text1(29).BackColor = Form1.BackColor
            Text1(29).ForeColor = QBColor(8)
            Label1(40).Enabled = False
            Label1(20).Enabled = False
            Label21(20).Enabled = False
            Command28(17).Enabled = False
            Text23(18).BackColor = Form1.BackColor
            Text23(19).BackColor = Form1.BackColor
            Text23(20).BackColor = Form1.BackColor
            Text23(21).BackColor = Form1.BackColor
            Text23(18).Enabled = False
            Text23(19).Enabled = False
            Text23(20).Enabled = False
            Text23(21).Enabled = False
            Label21(21).Enabled = False
            Label21(22).Enabled = False
            Label21(23).Enabled = False
            Label21(24).Enabled = False
        ElseIf DPModelFlag = 1 Then
            Label1(21).Caption = "Kimura, 1980"
            Text1(15).Text = DPTVRatio
            Text1(15).Enabled = True
            Text1(15).BackColor = QBColor(15)
            Label1(20).Enabled = True
            Text1(29).Enabled = False
            Text1(29).BackColor = Form1.BackColor
            Text1(29).ForeColor = QBColor(8)
            Label1(40).Enabled = False
            Frame21(3).Enabled = False
            Label21(20).Enabled = False
            Command28(17).Enabled = False
            Text23(18).BackColor = Form1.BackColor
            Text23(19).BackColor = Form1.BackColor
            Text23(20).BackColor = Form1.BackColor
            Text23(21).BackColor = Form1.BackColor
            Text23(18).Enabled = False
            Text23(19).Enabled = False
            Text23(20).Enabled = False
            Text23(21).Enabled = False
            Label21(21).Enabled = False
            Label21(22).Enabled = False
            Label21(23).Enabled = False
            Label21(24).Enabled = False
        ElseIf DPModelFlag = 2 Then
            Label1(21).Caption = "Jin  and  Nei, 1990"
            Text1(15).Text = DPTVRatio
            Text1(15).Enabled = True
            Text1(15).BackColor = QBColor(15)
            Text1(29).Enabled = True
            Text1(29).BackColor = QBColor(15)
            Text1(29).ForeColor = QBColor(0)
            Label1(40).Enabled = True
            Label1(20).Enabled = True
            Frame21(3).Enabled = False
            Label21(20).Enabled = False
            Command28(17).Enabled = False
            Text23(18).BackColor = Form1.BackColor
            Text23(19).BackColor = Form1.BackColor
            Text23(20).BackColor = Form1.BackColor
            Text23(21).BackColor = Form1.BackColor
            Text23(18).Enabled = False
            Text23(19).Enabled = False
            Text23(20).Enabled = False
            Text23(21).Enabled = False
            Label21(21).Enabled = False
            Label21(22).Enabled = False
            Label21(23).Enabled = False
            Label21(24).Enabled = False
        ElseIf DPModelFlag = 3 Then
            Label1(21).Caption = "Felsenstein, 1984"
            Text1(15).Text = DPTVRatio
            Text1(15).Enabled = True
            Text1(15).BackColor = QBColor(15)
            Text1(29).Enabled = False
            Text1(29).BackColor = Form1.BackColor
            Text1(29).ForeColor = QBColor(8)
            Label1(40).Enabled = False
            Label1(20).Enabled = True
            Frame21(3).Enabled = True
            Label21(20).Enabled = True
            Command28(17).Enabled = True

            If DPBFreqFlag = 1 Then
                Text23(18).BackColor = QBColor(15)
                Text23(19).BackColor = QBColor(15)
                Text23(20).BackColor = QBColor(15)
                Text23(21).BackColor = QBColor(15)
                Text23(18).Enabled = True
                Text23(19).Enabled = True
                Text23(20).Enabled = True
                Text23(21).Enabled = True
                Label21(21).Enabled = True
                Label21(22).Enabled = True
                Label21(23).Enabled = True
                Label21(24).Enabled = True
            Else
                Text23(18).BackColor = Form1.BackColor
                Text23(19).BackColor = Form1.BackColor
                Text23(20).BackColor = Form1.BackColor
                Text23(21).BackColor = Form1.BackColor
                Text23(18).Enabled = False
                Text23(19).Enabled = False
                Text23(20).Enabled = False
                Text23(21).Enabled = False
                Label21(21).Enabled = False
                Label21(22).Enabled = False
                Label21(23).Enabled = False
                Label21(24).Enabled = False
            End If

        End If

    ElseIf Index = 27 Then
        TModel = TModel + 1

        If TModel > 3 Then TModel = 0

        If TModel = 0 Then
            Label1(44).Caption = "Jukes and Cantor, 1969"
            Frame21(6).Enabled = False
            Text1(32).Text = "0.5"
            Text1(32).Enabled = False
            Text1(32).BackColor = Form1.BackColor
            Label1(43).Enabled = False
            Text1(31).Enabled = False
            Text1(31).BackColor = Form1.BackColor
            Text1(31).ForeColor = QBColor(8)
            Label1(42).Enabled = False
            Label21(35).Enabled = False
            Command28(26).Enabled = False
            Text23(30).BackColor = Form1.BackColor
            Text23(31).BackColor = Form1.BackColor
            Text23(32).BackColor = Form1.BackColor
            Text23(33).BackColor = Form1.BackColor
            Text23(30).Enabled = False
            Text23(31).Enabled = False
            Text23(32).Enabled = False
            Text23(33).Enabled = False
            Label21(36).Enabled = False
            Label21(37).Enabled = False
            Label21(38).Enabled = False
            Label21(39).Enabled = False
        ElseIf TModel = 1 Then
            Label1(44).Caption = "Kimura, 1980"
            Text1(32).Text = TTVRat
            Text1(32).Enabled = True
            Text1(32).BackColor = QBColor(15)
            Label1(43).Enabled = True
            Text1(31).Enabled = False
            Text1(31).BackColor = Form1.BackColor
            Text1(31).ForeColor = QBColor(8)
            Label1(42).Enabled = False
            Frame21(6).Enabled = False
            Label21(35).Enabled = False
            Command28(26).Enabled = False
            Text23(30).BackColor = Form1.BackColor
            Text23(31).BackColor = Form1.BackColor
            Text23(32).BackColor = Form1.BackColor
            Text23(33).BackColor = Form1.BackColor
            Text23(30).Enabled = False
            Text23(31).Enabled = False
            Text23(32).Enabled = False
            Text23(33).Enabled = False
            Label21(36).Enabled = False
            Label21(37).Enabled = False
            Label21(38).Enabled = False
            Label21(39).Enabled = False
        ElseIf TModel = 2 Then
            Label1(44).Caption = "Jin  and  Nei, 1990"
            Text1(32).Text = TTVRat
            Text1(32).Enabled = True
            Text1(32).BackColor = QBColor(15)
            Label1(43).Enabled = True
            Text1(31).Enabled = True
            Text1(31).BackColor = QBColor(15)
            Text1(31).ForeColor = QBColor(0)
            Label1(42).Enabled = True
            Frame21(6).Enabled = False
            Label21(35).Enabled = False
            Command28(26).Enabled = False
            Text23(30).BackColor = Form1.BackColor
            Text23(31).BackColor = Form1.BackColor
            Text23(32).BackColor = Form1.BackColor
            Text23(33).BackColor = Form1.BackColor
            Text23(30).Enabled = False
            Text23(31).Enabled = False
            Text23(32).Enabled = False
            Text23(33).Enabled = False
            Label21(36).Enabled = False
            Label21(37).Enabled = False
            Label21(38).Enabled = False
            Label21(39).Enabled = False
        ElseIf TModel = 3 Then
            Label1(44).Caption = "Felsenstein, 1984"
            Text1(32).Text = TTVRat
            Text1(32).Enabled = True
            Text1(32).BackColor = QBColor(15)
            Label1(43).Enabled = True
            Text1(31).Enabled = False
            Text1(31).BackColor = Form1.BackColor
            Text1(31).ForeColor = QBColor(8)
            Label1(42).Enabled = False
            Frame21(6).Enabled = True
            Label21(35).Enabled = True
            Command28(26).Enabled = True

            If TBaseFreqFlag = 1 Then
                Text23(30).BackColor = QBColor(15)
                Text23(31).BackColor = QBColor(15)
                Text23(32).BackColor = QBColor(15)
                Text23(33).BackColor = QBColor(15)
                Text23(30).Enabled = True
                Text23(31).Enabled = True
                Text23(32).Enabled = True
                Text23(33).Enabled = True
                Label21(36).Enabled = True
                Label21(37).Enabled = True
                Label21(38).Enabled = True
                Label21(39).Enabled = True
            Else
                Text23(30).BackColor = Form1.BackColor
                Text23(31).BackColor = Form1.BackColor
                Text23(32).BackColor = Form1.BackColor
                Text23(33).BackColor = Form1.BackColor
                Text23(30).Enabled = False
                Text23(31).Enabled = False
                Text23(32).Enabled = False
                Text23(33).Enabled = False
                Label21(36).Enabled = False
                Label21(37).Enabled = False
                Label21(38).Enabled = False
                Label21(39).Enabled = False
            End If

        End If
    ElseIf Index = 43 Then
        TPModel = TPModel + 1

        If TPModel > 6 Then TPModel = 0

        Call SetMLModel
    ElseIf Index = 26 Then
        TBaseFreqFlag = TBaseFreqFlag + 1

        If TBaseFreqFlag > 1 Then TBaseFreqFlag = 0

        If TBaseFreqFlag = 1 Then
            Label21(35).Caption = "User defined"
            Text23(30).BackColor = QBColor(15)
            Text23(31).BackColor = QBColor(15)
            Text23(32).BackColor = QBColor(15)
            Text23(33).BackColor = QBColor(15)
            Text23(30).Enabled = True
            Text23(31).Enabled = True
            Text23(32).Enabled = True
            Text23(33).Enabled = True
            Label21(36).Enabled = True
            Label21(37).Enabled = True
            Label21(38).Enabled = True
            Label21(39).Enabled = True
        Else
            Label21(35).Caption = "Estimate from alignment"
            Text23(30).BackColor = Form1.BackColor
            Text23(31).BackColor = Form1.BackColor
            Text23(32).BackColor = Form1.BackColor
            Text23(33).BackColor = Form1.BackColor
            Text23(30).Enabled = False
            Text23(31).Enabled = False
            Text23(32).Enabled = False
            Text23(33).Enabled = False
            Label21(36).Enabled = False
            Label21(37).Enabled = False
            Label21(38).Enabled = False
            Label21(39).Enabled = False
        End If

    ElseIf Index = 29 Then
        TNegBLFlag = TNegBLFlag + 1

        If TNegBLFlag > 1 Then TNegBLFlag = 0

        If TNegBLFlag = 0 Then
            Label1(49) = "Negative branch lengths not allowed"
        Else
            Label1(49) = "Negative branch lengths allowed"
        End If

    ElseIf Index = 30 Then
        TSubRepsFlag = TSubRepsFlag + 1

        If TSubRepsFlag > 1 Then TSubRepsFlag = 0

        If TSubRepsFlag = 0 Then
            Label1(50) = "Do not do subreplicates"
        Else
            Label1(50) = "Do subreplicates"
        End If

    ElseIf Index = 31 Then
        TGRFlag = TGRFlag + 1

        If TGRFlag > 1 Then TGRFlag = 0

        If TGRFlag = 0 Then
            Label1(51) = "Do not do global rearrangements"
        Else
            Label1(51) = "Do global rearrangements"
        End If

    ElseIf Index = 32 Then
        TRndIOrderFlag = TRndIOrderFlag + 1

        If TRndIOrderFlag > 1 Then TRndIOrderFlag = 0

        If TRndIOrderFlag = 0 Then
            Label1(52) = "Do not randomise input order"
        Else
            Label1(52) = "Randomise input order"
        End If

    End If

End Sub

Private Sub Command29_Click()
    Command1.SetFocus
End Sub

Private Sub Command3_Click()
    Command1.SetFocus
    PermTypeFlag = PermTypeFlag + 1
    If PermTypeFlag > 1 Then PermTypeFlag = 0
    If PermTypeFlag = 1 Then
        
        Label1(54) = "Shuffle alignment columns"
    Else
        
        Label1(54) = "Use SEQGEN parametric simulations"
    End If

End Sub

Private Sub Command4_Click()
    
    
    OptButtonF = 0
    Form1.Timer2.Enabled = False
    Command1.SetFocus
    Form1.SSPanel2.Enabled = True
    Form1.SSPanel8.Enabled = True


    If NextNo > 0 Then
        Form1.SSPanel3.Enabled = True
        Form1.SSPanel4.Enabled = True
        Form1.SSPanel5.Enabled = True
        Form1.SSPanel6(0).Enabled = True
        Form1.SSPanel6(1).Enabled = True
        Form1.SSPanel6(2).Enabled = True
        '
    End If
    
    GCFlag = xGCFlag
    
    
    PermTypeFlag = xPermTypeFlag
    
    SpacerFlag = SpacerFlagT
    List1.TopIndex = OLSeq
    DPModelFlag = xDPModelFlag
    DPBFreqFlag = xDPBFreqFlag
    DPTVRatio = xDPTVRatio
    RetSiteFlag = xRetSiteFlag
    
    MCTripletFlag = xMCTripletFlag
    MCProportionFlag = xMCProportionFlag
    MCWinSize = xMCWinSize
    MCWinFract = xMCWinFract
    MCStripGapsFlag = xMCStripGapsFlag
    AllowConflict = xAllowConflict
    
    CProportionFlag = xCProportionFlag
    CWinSize = xCWinSize
    CWinFract = xCWinFract
    
    TOTreeType = xToTreeType
    TOFreqFlag = xToFreqFlag
    TOTsTv = xTOTsTv
    TOModel = xTOModel
    TOWinLen = xTOWinLen
    BSFreqFlag = xBSFreqFlag
    BSTypeFlag = xBSTypeFlag
    
    BSPValFlag = xBSPValFlag
    TModel = xTModel
    TBaseFreqFlag = xTBaseFreqFlag
    TNegBLFlag = xTNegBLFlag
    TSubRepsFlag = xTSubRepsFlag
    TGRFlag = xTGRFlag
    TRndIOrderFlag = xTRndIOrderFlag
    ConsensusProg = xConsensusProg
    Form3.Visible = False
    Form3.TabStrip1.Visible = True
    SSNumPerms2 = xSSNumPerms2
    
    SSGapFlag = xSSGapFlag
    SSVarPFlag = xSSVarPFlag
    SSOutlyerFlag = xSSOutlyerFlag
    SSNumPerms = xSSNumPerms
    SSFastFlag = xSSFastFlag
    
    TPModel = xTPModel
    TPBPFEstimate = xTPBPFEstimate
    
    MatPermNo = xMatPermNo
    MatWinSize = xMatWinSize
    SHWinLen = xSHWinLen
    SHStep = xSHStep
    LRDRegion = xLRDRegion
    LRDWin = xLRDWin
    ntType = ontType
    TBModel = xTBModel
    TBGamma = xTBGamma
    
    BSTreeStrat = xBStreeStrat
    BSupTest = xBSupTest
    
    IncSelf = xIncSelf
    PPStripGaps = xPPStripGaps
    AllowConflict = xAllowConflict
    ModelTestFlag = xModelTestFlag
    If Form5.Visible = False Then
        Form1.Enabled = True
        If F2ontop = 0 Then
            Form1.ZOrder
        End If
        Form1.Refresh
    End If
    If Form2.Visible = True Then
        Form2.Enabled = True
        'Form2.ZOrder
        Form2.Refresh
    End If

End Sub

Private Sub Command5_Click()
    Command1.SetFocus
    ShowPlotFlagT = ShowPlotFlagT + 1
    If ShowPlotFlagT = 1 Then ShowPlotFlagT = 2
    If ShowPlotFlagT = 3 Then
        ShowPlotFlagT = 0
        Label20 = "Do not show plots during scan"
    ElseIf ShowPlotFlagT = 1 Then
        Label20 = "Show plots during scan"
    ElseIf ShowPlotFlagT = 2 Then
        Label20 = "Show overview during scan"
    End If
Call RefreshTimes
End Sub

Private Sub Command6_Click()

    Dim TotT As Double, CurXpos As Double, CC As Long, PF1 As Long
    Dim PWidth As Integer
    
    If CurrentCheck = -1 Then
        If RelX > 0 Or RelY > 0 Then
            PF1 = XoverList(RelX, RelY).ProgramFlag
            If PF1 >= AddNum Then PF1 = PF1 - AddNum
            
            If PF1 = 0 Then
                CC = 0
            ElseIf PF1 = 1 Then
                CC = 1
            ElseIf PF1 = 2 Then
                CC = 2
            ElseIf PF1 = 3 Then
                CC = 4
            ElseIf PF1 = 4 Then
                CC = 10
            ElseIf PF1 = 5 Then
                CC = 5
            ElseIf PF1 = 6 Then
                CC = 13
            ElseIf PF1 = 7 Then
                CC = 6
            End If
        Else
            CC = CurrentCheck
        End If
    Else
        CC = CurrentCheck
    End If
    Command1.SetFocus
    
    If TabStrip1.SelectedItem.Index = 1 And TManFlag = -1 Then
        Call ResetDefaults
        XX = XOverWindowX
        XX = Form3.Text2.Text
        Call SetF3Vals(1)
        XX = XOverWindowX
        XX = Form3.Text2.Text
        
'        ConsensusProg = 1
'        DoScans(0, 0) = 1
'        DoScans(0, 1) = 1
'        DoScans(0, 2) = 0
'        DoScans(1, 2) = 1
'        DoScans(0, 3) = 1
'        DoScans(0, 5) = 0
'        DoScans(1, 5) = 1
'        DoScans(0, 4) = 0
'        DoScans(0, 6) = 0
'        DoScans(0, 7) = 0
'        DoScans(1, 7) = 0
'        DoScans(1, 6) = 0
'        DoScans(0, 8) = 0
'        Call SetChecks
'        MCFlagT = 0
'        ShowPlotFlagT = 2
'        CircularFlagT = 1
'        PolishBPFlag = 1
'        RealignFlag = 0
'
'        Label43 = "List events detected by >1 methods"
'        Check10 = 1
'        Check9 = 1
'        'Check12 = 1
'        Check11 = 1
'
'        Check13.Value = 0
'
'        Text1(37) = 0
'        PermTypeFlag = 0
'        Label1(54) = "Use SEQGEN parametric simulations"
'
'        'FullWindowSize = 40
'        HomologyIndicatorT = 1
'        'LowestProb = 0.05
'
'        Label16 = "Sequences are circular"
'        Text3.Text = "0.05"
'        Label20 = "Show overview during scan"
'        Label23 = "Bonferroni correction"
'        AnalT(1) = 1.8 + 0.1 * GCNumPerms
'
        AnalT(0) = 1
        AnalT(1) = 2
        AnalT(2) = 1
        AnalT(3) = 1
        AnalT(4) = 1
        AnalT(5) = 1
        AnalT(6) = 20
        AnalT(8) = 1
'        Check4.Value = 1
        TotT = AnalT(0) + AnalT(1) + AnalT(3) + AnalT(2) + AnalT(5)
'
'        Check5.Value = 1
'        Check1.Value = 0
'        Check2.Value = 1
'        Check3.Value = 0
'        Check6.Value = 0
        PWidth = Picture27.Width - 100
        PHeight = Picture27.Height - 50
        CurXpos = 25
        Picture27.Picture = LoadPicture()
        
        If DoScans(0, 0) = 1 Then
            Picture27.Line (CurXpos, 20)-((CurXpos + AnalT(0) / TotT * PWidth), Picture27.Height - 50), ProgColour(0), BF
            CurXpos = CurXpos + AnalT(0) / TotT * PWidth
        End If

        CurXpos = CurXpos + 1

        If DoScans(0, 1) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(1) / TotT * PWidth, Picture27.Height - 50), ProgColour(1), BF
            CurXpos = CurXpos + AnalT(1) / TotT * PWidth
        End If

        If DoScans(0, 2) = 1 Or DoScans(1, 2) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(2) / TotT * PWidth, Picture27.Height - 50), ProgColour(2), BF
            CurXpos = CurXpos + AnalT(2) / TotT * PWidth
        End If

        If DoScans(0, 3) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(3) / TotT * PWidth, Picture27.Height - 50), ProgColour(3), BF
            CurXpos = CurXpos + AnalT(3) / TotT * PWidth
        End If

        If DoScans(0, 4) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(4) / TotT * PWidth, Picture27.Height - 50), ProgColour(4), BF
            CurXpos = CurXpos + AnalT(4) / TotT * PWidth
        End If

        If DoScans(0, 5) = 1 Or DoScans(1, 5) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(5) / TotT * PWidth, Picture27.Height - 50), ProgColour(5), BF
            CurXpos = CurXpos + AnalT(5) / TotT * PWidth
        End If
        
        If DoScans(0, 6) = 1 Then
             Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(6) / TotT * PWidth, Picture27.Height - 50), ProgColour(6), BF
            CurXpos = CurXpos + AnalT(6) / TotT * PWidth
        
        End If
        If DoScans(0, 8) = 1 Then
             Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(8) / TotT * PWidth, Picture27.Height - 50), ProgColour(8), BF
            CurXpos = CurXpos + AnalT(8) / TotT * PWidth
        
        End If
        Picture27.Refresh
    End If
    
    If TabStrip1.SelectedItem.Index = 2 Or (CC = 0 And TabStrip1.SelectedItem.Index = 1) Then
        Option3.Value = 0
        Option2.Value = 1
        Option4.Value = 0
        Option5.Value = 0
        Option6.Value = 0
        Text2.Text = 30
        Text7.Text = 0
        Text8.Text = 100
    End If
    If TabStrip1.SelectedItem.Index = 3 Or (OptButtonF = 1 And (TManFlag = 1 Or CC = 1)) Then
        xGCSeqTypeFlag = 0
        xGCIndelFlag = 0
        
        xGCTripletFlag = 1
        
        If NextNo > 0 Then
            Text21 = 1
            Text22 = Len(StrainSeq(0))
        Else
            Text21 = 0
            Text22 = 0
        End If
        'GCtripletflag = 1
        xGCOutFlag = 0
        xGCOutFlagII = 0
        xGCSortFlag = 0
        Text10 = 0
        Text11 = 0
        xGCLogFlag = 0
        Text12 = 1
        Text14 = 2000
        Text13 = 0
        Text15 = 1
        Text16 = 2
        Text17 = 2
        Text18 = 1
        Text19 = 0
        TmpD = 0.05
        Text20 = TmpD
        xGCPermPolyFlag = 0
        Label29.Caption = "Automatic detection of sequence type"
        Label32.Enabled = False
        Command28(4).Enabled = False
        Label31.Caption = "Ignor indels"
        Label32.Caption = "Use standard (nuclear) code"
        Label39.Caption = "Do not use monomorphic sites"
        Label27.Caption = "Space separated output"
        Label33.Caption = "Simple output"
        Command29.Enabled = False
        Label34.Caption = "Sort fragment lists by P-Value"
        Label28.Caption = "Write log file"
        Label59.Caption = "Use simple polymorphisms"
        Label39.Caption = "Scan sequence triplets"
        Text1(44) = 400
            xGCTripletFlag = 1
            'Disbable large sections of the interface
            Command28(2).Enabled = False
            Command28(4).Enabled = False
            Text21.Enabled = False
            
            Text22.Enabled = False
            Label48.Enabled = False
            Label47.Enabled = False
            Label32.Enabled = False
            Label29.Enabled = False
            
            Frame13.Enabled = False
            Label38.Enabled = False
            Text14.Enabled = False
            Text13.Enabled = False
            Label37.Enabled = False
            
            Frame16.Enabled = False
            Label26.Enabled = False
            Label27.Enabled = False
            Label33.Enabled = False
            Label34.Enabled = False
            Label30.Enabled = False
            Label35.Enabled = False
            Label28.Enabled = False
            Label45.Enabled = False
            Label46.Enabled = False
            Label59.Enabled = False
            
            Text19.Enabled = False
            Text20.Enabled = False
            
            Text10.Enabled = False
            Text11.Enabled = False
            Command28(0).Enabled = False
            Command28(5).Enabled = False
            Command28(6).Enabled = False
            Command28(1).Enabled = False
            Command28(7).Enabled = False
            Text21.BackColor = Form1.Command1.BackColor
            Text11.BackColor = Form1.Command1.BackColor
            Text10.BackColor = Form1.Command1.BackColor
            
            Text20.BackColor = Form1.Command1.BackColor
            Text19.BackColor = Form1.Command1.BackColor
            Text14.BackColor = Form1.Command1.BackColor
            Text13.BackColor = Form1.Command1.BackColor
            Text22.BackColor = Form1.Command1.BackColor
        End If
    If TabStrip1.SelectedItem.Index = 4 Or (OptButtonF = 1 And (CC = 2 Or CC = 3 Or TManFlag = 3)) Then
        Text1(0) = 200
        Text1(1) = 20
        Text1(5) = 70
        Text1(2) = 100
        Text1(3) = 3
        xBSSubModelFlag = 0
        BSFreqFlag = 0
        Text23(28) = 0.25
        Text23(27) = 0.25
        Text23(26) = 0.25
        Text23(29) = 0.25
        xBSTTRatio = 2#
        Text1(6) = 100
        Text1(7) = 10
        Text1(10) = 100
        Check7.Value = 0
        Check8.Value = 1
        Text1(8) = 10
        Text1(11) = 100
        Text1(12) = 200
        Text1(9) = 100
        BSTypeFlag = 0
        
        BSPValFlag = 1
        Text1(28) = 1
        Label1(4).Caption = "Jukes and Cantor, 1969"
        Text1(4).Enabled = False
        Text1(4).BackColor = Form1.BackColor
        Text1(4).ForeColor = QBColor(8)
        Text1(4) = 0.5
        Label1(5).Enabled = False
        Text1(28).Enabled = False
        Text1(28).BackColor = Form1.BackColor
        Text1(28).ForeColor = QBColor(8)
        Label1(39).Enabled = False
        Frame21(5).Enabled = False
        Command28(24).Enabled = False

        For x = 26 To 29
            Text23(x).BackColor = Form1.BackColor
            Text23(x).Enabled = False
        Next 'X

        For x = 30 To 34
            Label21(x).Enabled = False
        Next 'X

        Label21(34).Caption = "Estimate from alignment"
        Label1(37) = "Use distances"
        Label1(38) = "Use distances"
        Label1(48) = "Calculate binomial P-value"
        Text1(8).Enabled = True
        Text1(9).Enabled = True
        Text1(11).Enabled = True
        Text1(12).Enabled = True
        Frame18.Enabled = True
        Text1(8).BackColor = QBColor(15)
        Text1(9).BackColor = QBColor(15)
        Text1(8).ForeColor = QBColor(0)
        Text1(9).ForeColor = QBColor(0)
        Label1(7).Enabled = True
        Label1(10).Enabled = True
        Label1(14).Enabled = True
        Label1(15).Enabled = True
    End If
    If TabStrip1.SelectedItem.Index = 5 Or (OptButtonF = 1 And (TManFlag = 4 Or CC = 4)) Then
        
        
        MCWinSize = 70
        MCWinFract = 0.1
        MCProportionFlag = 0
        MCTripletFlag = 0
        MCStripGapsFlag = 1

        

        Label1(11) = "Set window size"
        Label1(27) = "# Variable sites per window"
        Text1(21) = 70
        Label1(13) = "Scan triplets"
        Label1(16) = "Strip gaps"
        xMCSteplen = MCSteplen
        xMCStart = MCStart
        xMCEnd = MCEnd

    End If
    If TabStrip1.SelectedItem.Index = 6 Or (OptButtonF = 1 And CC = 10) Then
        
        
        CWinSize = 60
        CWinFract = 0.1
        CProportionFlag = 0
        
        Label1(55) = "Set window size"
        Label1(56) = "# Variable sites per window"
        Text1(36) = 60
    End If
    If TabStrip1.SelectedItem.Index = 7 Or (OptButtonF = 1 And (TManFlag = 9 Or CC = 5)) Then
        Label22(3) = "Strip gaps"
        Label22(4) = "Use only 1/2/3 variable positions"
        Label22(5) = "Use nearest outlyer"
        Label22(6) = "Do fast scan"
        
        SSFastFlag = 1
        SSGapFlag = 0
        SSVarPFlag = 2
        SSOutlyerFlag = 1
        
        Text24(0) = 200
        Text24(1) = 20
        Text24(2) = 1000
        Text24(3) = 3
        Text24(4) = 100
    
    
    
    End If
    If TabStrip1.SelectedItem.Index = 10 Or (OptButtonF = 1 And (TManFlag = 5 Or CC = 6)) Then
        xLRDModel = 0
        Text23(5) = "0"
        Text23(6) = 0.5
        Text23(11) = 2#
        Text23(13) = 1
        Text23(14) = 1
        Text23(15) = 1
        Text23(12) = 1
        Text23(16) = 1
        Text23(17) = 1
        xLRDBaseFreqFlag = 1
        Text23(9) = 0.25
        Text23(8) = 0.25
        Text23(7) = 0.25
        Text23(10) = 0.25
        Text23(2) = 1
        Text23(3) = 1
        Text23(4) = 1
        Text23(0) = 20
        Text23(1) = 2
        Frame21(2).Enabled = False

        For x = 14 To 19
            Label21(x).Enabled = False
        Next 'X

        Label21(12).Enabled = True
        Text23(11).Enabled = True
        Text23(11).ForeColor = QBColor(0)
        Text23(11).BackColor = QBColor(15)

        For x = 7 To 10
            'Text23(X).ForeColor = QBColor(8)
            Text23(x).Enabled = True
            Text23(x).BackColor = QBColor(15) ' Form3.BackColor
        Next 'X

        For x = 12 To 16
            Text23(x).ForeColor = QBColor(8)
            Text23(x).BackColor = Form3.BackColor
        Next 'X

        Label21(0).Caption = "Hasegawa, Kishino and Yano, 1985"
        Command28(11).Enabled = False
        Label21(13).Enabled = False
        Label21(13).Caption = "User defined"

        For x = 8 To 11
            Label21(x).Enabled = True
        Next 'X

        For x = 7 To 10
            Text23(x).ForeColor = QBColor(0)
            Text23(x).BackColor = QBColor(15)
        Next 'X
        
        LRDWin = 0
        Label21(40) = "Sliding partition scan"
        LRDWinLen = 400
        Text23(1) = LRDWinLen
        Text23(1).Enabled = False
        Text23(1).BackColor = Form1.BackColor
        Label21(41).Enabled = False
        Label21(2) = "Test one breakpoint"
        Label21(2).Enabled = True
        Command28(40).Enabled = True
    End If
    If TabStrip1.SelectedItem.Index = 13 Or (OptButtonF = 1 And (CC = 15)) Then
        If CC = 15 And OptButtonF = 1 Then
            
            
            'Label1(17) = "Use all sites"
            Form3.Text5(0) = 100
            Form3.Text5(1) = 200
            'MatPermNo = 100
            'MatWinSize = 200
            'Combo1.ListIndex = 0
        ElseIf CC <> 15 Then
            
            Label1(17) = "Use all sites"
            Form3.Text5(0) = 100
            Form3.Text5(1) = 200
            Combo1.ListIndex = 0
        End If
        'Label1(22) = "Make 1 randomised matrix"
    End If
    If TabStrip1.SelectedItem.Index = 12 Or (OptButtonF = 1 And (TManFlag = 7 Or CC = 8)) Then
        DPModelFlag = 1
        DPBFreqFlag = 0
        DPTVRatio = 2#
        Text1(13) = 200
        Text1(14) = 20
        Text23(19) = 0.25
        Text23(20) = 0.25
        Text23(21) = 0.25
        Text23(18) = 0.25
        Label21(20).Caption = "Estimate from alignment"
        Text1(29) = 1
        Label1(21).Caption = "Kimura, 1980"
        Text1(15).Text = DPTVRatio
        Text1(15).Enabled = True
        Text1(15).BackColor = QBColor(15)
        Label1(20).Enabled = True
        Text1(29).Enabled = False
        Text1(29).BackColor = Form1.BackColor
        Text1(29).ForeColor = QBColor(8)
        Label1(40).Enabled = False
        Frame21(3).Enabled = False
        Label21(20).Enabled = False
        Command28(17).Enabled = False
        Text23(18).BackColor = Form1.BackColor
        Text23(19).BackColor = Form1.BackColor
        Text23(20).BackColor = Form1.BackColor
        Text23(21).BackColor = Form1.BackColor
        Text23(18).Enabled = False
        Text23(19).Enabled = False
        Text23(20).Enabled = False
        Text23(21).Enabled = False
        Label21(21).Enabled = False
        Label21(22).Enabled = False
        Label21(23).Enabled = False
        Label21(24).Enabled = False
    End If
    If TabStrip1.SelectedItem.Index = 9 Or (OptButtonF = 1 And TManFlag = 20) Then
        Text6(0) = 30
        Text6(1) = 10
        Text6(2) = 0.05
        Text6(3) = 0.1
        Text6(4) = 1000
        Text6(5) = 1000000
        GCFlag = 1
        Label2(4).Caption = "Use gene conversion model"
        Label2(5).Enabled = True
        Text6(4).Enabled = True
        Text6(4).BackColor = RGB(255, 255, 255)
    End If
    If TabStrip1.SelectedItem.Index = 11 Or (OptButtonF = 1 And (TManFlag = 8 Or CC = 9)) Then
        TOTreeType = 1
        TOFreqFlag = 0
        'TOTvTs = 2
        TOModel = 0
        TOPFlag = 0
        Text1(26) = 3
        Text1(27) = 0
        Text1(22) = 200
        Text1(19) = 10
        Text1(23) = 5
        Text1(25) = 2
        Text1(24) = 0.05
        Text23(24) = 0.25
        Text23(23) = 0.25
        Text23(22) = 0.25
        Text23(25) = 0.25
        Label21(29).Caption = "Estimate from alignment"
        Text1(30) = 1
        Label1(25).Caption = "Jukes and Cantor, 1969"
        Text1(16).Text = 2
        Text1(16).Enabled = True
        Text1(16).BackColor = QBColor(15)
        Label1(29).Enabled = True
        Text1(30).Enabled = False
        Text1(30).BackColor = Form1.BackColor
        Text1(30).ForeColor = QBColor(8)
        Label1(41).Enabled = False
        Frame21(4).Enabled = False
        Label21(29).Enabled = False
        Command28(20).Enabled = False
        Text23(25).BackColor = Form1.BackColor
        Text23(24).BackColor = Form1.BackColor
        Text23(23).BackColor = Form1.BackColor
        Text23(22).BackColor = Form1.BackColor
        Text23(25).Enabled = False
        Text23(24).Enabled = False
        Text23(23).Enabled = False
        Text23(22).Enabled = False
        Label21(28).Enabled = False
        Label21(27).Enabled = False
        Label21(26).Enabled = False
        Label21(25).Enabled = False
        Label1(34) = "Construct NJ and LS trees"
    End If
    If TabStrip1.SelectedItem.Index = 16 Then
        TModel = 0
        TBaseFreqFlag = 0
        TNegBLFlag = 0
        TSubRepsFlag = 0
        TGRFlag = 0
        TRndIOrderFlag = 0
        Text1(33) = 100
        Text1(34) = 3
        Text1(32) = 2
        Text1(31) = 1
        Text23(31) = 0.25
        Text23(32) = 0.25
        Text23(33) = 0.25
        Text23(30) = 0.25
        Text1(35) = 2
        Label1(44).Caption = "Jukes and Cantor, 1969"
        Text1(32).Text = 0.5
        Text1(32).Enabled = False
        Text1(32).BackColor = Form1.BackColor
        'Label1(42).Enabled = False
        Label1(43).Enabled = False
        Text1(31).Enabled = False
        Text1(31).BackColor = Form1.BackColor
        Text1(31).ForeColor = QBColor(8)
        Label1(42).Enabled = False
        Frame21(6).Enabled = False
        Label21(35).Enabled = False
        Command28(26).Enabled = False
        Text23(30).BackColor = Form1.BackColor
        Text23(31).BackColor = Form1.BackColor
        Text23(32).BackColor = Form1.BackColor
        Text23(33).BackColor = Form1.BackColor
        Text23(30).Enabled = False
        Text23(31).Enabled = False
        Text23(32).Enabled = False
        Text23(33).Enabled = False
        Label21(36).Enabled = False
        Label21(37).Enabled = False
        Label21(38).Enabled = False
        Label21(39).Enabled = False
        Label21(35).Caption = "Estimate from alignment"
        Label1(49) = "Negative branch lengths not allowed"
        Label1(50) = "Do not do subreplicates"
        Label1(51) = "Do not do global rearrangements"
        Label1(52) = "Do not randomise input order"
        
        
        TPModel = 6
        TPBPFEstimate = 0
        TPTVRat = 2
        Text1(17).Text = 2
        Text1(18).Text = 0
        Text23(34).Text = 1
        Text23(35).Text = 25
        Text23(42).Text = 2
        
        Call SetMLModel
        
        TBModel = 2
        TBGamma = 1
        
        Text1(20).Text = 4
        Text1(39).Text = 1000000
        Text1(40).Text = 4
        Text1(38).Text = 100
        Text1(41).Text = 0.2
        Text1(42).Text = 1
        Text1(43).Text = 1
        
        Call SetTBModel
        Call SetTBGamma
        
        BSTreeStrat = 0
        BSupTest = 0
        
        
        Label1(71).Caption = "Bootstrap test"
        Label1(45).Enabled = True
        Label1(46).Enabled = True
        Text1(33).Enabled = True
        Text1(34).Enabled = True
        Text1(33).BackColor = QBColor(15)
        Text1(34).BackColor = QBColor(15)
        Label1(72).Caption = "Tree search by NNI"
        
        ModelTestFlag = 0
        Form3.Label1(69) = "User specified model"
        Form3.Label1(24).Enabled = True
        Form3.Command28(43).Enabled = True
        Form3.Command28(44).Enabled = True
        Form3.Label1(59).Enabled = True
        Form3.Label1(60).Enabled = True
        Form3.Label21(46).Enabled = True
        Form3.Label21(42).Enabled = True
        Form3.Label21(52).Enabled = True
        Form3.Text23(34).BackColor = QBColor(15)
        Form3.Text23(34).Visible = True
        Form3.Text23(35).Visible = False
        Form3.Text23(42).BackColor = QBColor(15)
        Form3.Text1(18).BackColor = QBColor(15)
        Form3.Text1(17).BackColor = QBColor(15)
        Form3.Text23(34).Enabled = True
        Form3.Text23(42).Enabled = True
        Form3.Text1(18).Enabled = True
        Form3.Text1(17).Enabled = True
        Form3.Label1(24).Caption = "Hasagawa, Kishino and Yano, 1985"
         'Enable transition transversion rate selection option
        Form3.Text1(17).Text = TPTVRat
        Form3.Text1(17).Enabled = True
        Form3.Text1(17).BackColor = QBColor(15)
        Form3.Label1(59).Enabled = True
        'Enable base frequency estimate option
        Form3.Label21(46).Enabled = True
        Form3.Command28(44).Enabled = True
        Form3.Frame21(6).Enabled = True
        
            
            
            
        
        
            
            
        
            
        
        
    End If
    If TabStrip1.SelectedItem.Index = 8 Or (OptButtonF = 1 And CC = 13) Then
        
        Text4(0) = 60
        PPStripGaps = 0
        IncSelf = 0
        Label14(1) = "Ignor gaps"
        Label14(2) = "Do not do self comparrisons"
        Text4(1) = 3
        Text4(2) = 1000
    
    End If
    If TabStrip1.SelectedItem.Index = 17 Then
        Text6(11) = "4.5"
        Text6(6) = "100000"
        Text6(7) = "37"
    End If
    
    
    
End Sub

Private Sub Command7_Click()

    
    ConsensusProg = ConsensusProg + 1
    If ConsensusProg > AddNum - 2 Then ConsensusProg = 0
        
        If ConsensusProg = 0 Then
            Label43 = "List all events"
        ElseIf ConsensusProg = 1 Then
            Label43 = "List events detected by >1 method"
        ElseIf ConsensusProg = 2 Then
            Label43 = "List events detected by >2 methods"
        ElseIf ConsensusProg = 3 Then
            Label43 = "List events detected by >3 methods"
        ElseIf ConsensusProg = 4 Then
            Label43 = "List events detected by >4 methods"
        ElseIf ConsensusProg = 5 Then
            Label43 = "List events detected by >5 methods"
        ElseIf ConsensusProg = 6 Then
            Label43 = "List events detected by >6 methods"
        End If
        For x = 1 To 4
            DoneMatX(x) = 0
        Next x
End Sub

Private Sub Command8_Click()
ConservativeGroup = ConservativeGroup + 1
If ConservativeGroup > 1 Then
    ConservativeGroup = 0
    Label15.Caption = "Group recombinants realistically"
    Label15.ToolTipText = "The program will only infer that recombinants are descended from the same common ancestor if they have similar breakpoints and if they tend to group together in phylogenetic trees"
    Form3.Command8.ToolTipText = "The program will only infer that recombinants are descended from the same common ancestor if they have similar breakpoints and if they tend to group together in phylogenetic trees"

Else
    Label15.Caption = "Group recombinants conservatively"
    Label15.ToolTipText = "The program will infer that recombinants are descended from the same common ancestor if they have similar breakpoints (even if they don't tend to group together in phylogenetic trees)"
    Form3.Command8.ToolTipText = "The program will infer that recombinants are descended from the same common ancestor if they have similar breakpoints (even if they don't tend to group together in phylogenetic trees)"
    
End If

End Sub

Private Sub Form_Load()
    ReDim AnalT(AddNum)
    
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
Screen.MousePointer = 0
End Sub

Private Sub Form_Paint()
x = x
End Sub

Private Sub Frame1_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
Screen.MousePointer = 0
End Sub

Private Sub Option2_Click()
    Option3.Value = 0
    'If Option6.Value = True Then
    Frame3.Enabled = False
    List1.Enabled = False
    'End If
    Option4.Value = 0
    Option5.Value = 0
    Option6.Value = 0

    If Option2.Value = 0 Then
        Option2.Value = 1
    End If

    Frame4(SpacerFlag).Visible = False

    If SpacerFlag = 4 Then Frame3.Enabled = False
    SpacerFlag = 0
    Frame4(0).Visible = True
End Sub

Private Sub Option3_Click()
    Option2.Value = 0
    'If Option6.Value = True Then
    Frame3.Enabled = False
    List1.Enabled = False
    'End If
    Option4.Value = 0
    Option5.Value = 0
    Option6.Value = 0

    If Option3.Value = 0 Then
        Option3.Value = 1
    End If

    Frame4(SpacerFlag).Visible = False

    If SpacerFlag = 4 Then Frame3.Enabled = False
    SpacerFlag = 1
    Frame4(1).Visible = True
End Sub

Private Sub Option4_Click()
    Option3.Value = 0
    Option2.Value = 0
    Option5.Value = 0
    'If Option6.Value = True Then
    Frame3.Enabled = False
    List1.Enabled = False
    'End If
    Option6.Value = 0

    If Option4.Value = 0 Then
        Option4.Value = 1
    End If

    Frame4(SpacerFlag).Visible = False

    If SpacerFlag = 4 Then Frame3.Enabled = False
    SpacerFlag = 2
    Frame4(2).Visible = True
End Sub

Private Sub Option5_Click()
    Option3.Value = 0
    Option4.Value = 0
    Option2.Value = 0
    'If Option6.Value = True Then
    Frame3.Enabled = False
    List1.Enabled = False
    'End If
    Option6.Value = 0

    If Option5.Value = 0 Then
        Option5.Value = 1
    End If

    Frame4(SpacerFlag).Visible = False

    If SpacerFlag = 4 Then Frame3.Enabled = False
    SpacerFlag = 3
    Frame4(3).Visible = True
End Sub

Private Sub Option6_Click()
    Option3.Value = 0
    Option4.Value = 0
    Option5.Value = 0
    Option2.Value = 0

    If Option6.Value = False Then
        Option6.Value = 1
    End If

    Frame3.Enabled = True
    List1.Enabled = True
    Frame4(SpacerFlag).Visible = False
    SpacerFlag = 4
    Frame4(4).Visible = True
    Frame4(0).Visible = False
    Spacer4No = List1.TopIndex
End Sub

Private Sub TabStrip1_Click()

    If TabStrip1.SelectedItem.Index - 1 = 0 Then
        
        AnalT(1) = 1.8 + 0.1 * CDbl(Text19.Text)
        
        AnalT(0) = 1
        
        AnalT(2) = 3
        AnalT(3) = 1
        AnalT(4) = 1
        AnalT(5) = 10
        AnalT(6) = 10
        TotT = 0

        If DoScans(0, 0) = 1 Then
            TotT = TotT + AnalT(0)
        Else
            Check4.Value = 0
        End If

        If DoScans(0, 1) = 1 Then
            TotT = TotT + AnalT(1)
        Else
        End If

        If DoScans(0, 2) = 1 Then
            TotT = TotT + AnalT(2)
        Else
        End If

        If DoScans(0, 3) = 1 Then
            TotT = TotT + AnalT(3)
        Else
        End If

        If DoScans(0, 4) = 1 Then
            TotT = TotT + AnalT(4)
        Else
        End If

        If DoScans(0, 5) = 1 Then
            TotT = TotT + AnalT(5)
            PNum = PNum + 1
        Else
        End If
        
        If DoScans(0, 6) = 1 Then
            TotT = TotT + AnalT(6)
            PNum = PNum + 1
        Else
        End If

        PWidth = Picture27.Width - 100
        PHeight = Picture27.Height - 50
        CurXpos = 25
        Picture27.Picture = LoadPicture()
        Picture27.AutoRedraw = True

        If DoScans(0, 0) = 1 Then
            Picture27.Line (CurXpos, 20)-((CurXpos + AnalT(0) / TotT * PWidth), Picture27.Height - 50), ProgColour(0), BF
            CurXpos = CurXpos + AnalT(0) / TotT * PWidth
        End If

        CurXpos = CurXpos + 1

        If DoScans(0, 1) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(1) / TotT * PWidth, Picture27.Height - 50), ProgColour(1), BF
            CurXpos = CurXpos + AnalT(1) / TotT * PWidth
        End If

        If DoScans(0, 2) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(2) / TotT * PWidth, Picture27.Height - 50), ProgColour(2), BF
            CurXpos = CurXpos + AnalT(2) / TotT * PWidth
        End If

        If DoScans(0, 3) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(3) / TotT * PWidth, Picture27.Height - 50), ProgColour(3), BF
            CurXpos = CurXpos + AnalT(3) / TotT * PWidth
        End If

        If DoScans(0, 4) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(4) / TotT * PWidth, Picture27.Height - 50), ProgColour(4), BF
            CurXpos = CurXpos + AnalT(4) / TotT * PWidth
        End If

        If DoScans(0, 5) = 1 Then
            Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(5) / TotT * PWidth, Picture27.Height - 50), ProgColour(5), BF
            CurXpos = CurXpos + AnalT(5) / TotT * PWidth
        End If
        
        If DoScans(0, 6) = 1 Then
             Picture27.Line (CurXpos, 20)-(CurXpos + AnalT(6) / TotT * PWidth, Picture27.Height - 50), ProgColour(6), BF
            CurXpos = CurXpos + AnalT(6) / TotT * PWidth
        
        End If

        Picture27.Refresh
    End If
    Dim OnIndex As Long
    If TabStrip1.SelectedItem.Index = 1 Then
        OnIndex = 1
    ElseIf TabStrip1.SelectedItem.Index = 2 Then
        OnIndex = 2
    ElseIf TabStrip1.SelectedItem.Index = 3 Then
        OnIndex = 3
    ElseIf TabStrip1.SelectedItem.Index = 4 Then
        OnIndex = 4
    ElseIf TabStrip1.SelectedItem.Index = 5 Then
        OnIndex = 5
    ElseIf TabStrip1.SelectedItem.Index = 6 Then
        OnIndex = 6
    ElseIf TabStrip1.SelectedItem.Index = 7 Then
        OnIndex = 7
    ElseIf TabStrip1.SelectedItem.Index = 8 Then
        OnIndex = 13
    ElseIf TabStrip1.SelectedItem.Index = 9 Then
        OnIndex = 15
    ElseIf TabStrip1.SelectedItem.Index = 10 Then
        OnIndex = 8
    ElseIf TabStrip1.SelectedItem.Index = 11 Then
        OnIndex = 11
    ElseIf TabStrip1.SelectedItem.Index = 12 Then
        OnIndex = 10
    ElseIf TabStrip1.SelectedItem.Index = 13 Then
        OnIndex = 14
    ElseIf TabStrip1.SelectedItem.Index = 14 Then
        OnIndex = 9
        Form3.Combo1.ListIndex = 8
    ElseIf TabStrip1.SelectedItem.Index = 15 Then
        Form3.Combo1.ListIndex = 5
        OnIndex = 9
    ElseIf TabStrip1.SelectedItem.Index = 16 Then
        OnIndex = 12
    ElseIf TabStrip1.SelectedItem.Index = 17 Then
        OnIndex = 16
    End If
    
    For x = 0 To 15

        If x = OnIndex - 1 Then
            Frame2(x).Visible = True
            'Else
            '    Frame2(X).Visible = False
        Else
            Frame2(x).Visible = False
        End If

    Next 'X
    Form3.Command1.SetFocus
    'Frame2(OnIndex).Visible = True
End Sub

Private Sub TabStrip2_Click()
x = x
End Sub

Private Sub Text1_LostFocus(Index As Integer)
    Dim TNum As Long, TempDbl As Double
    BSStepSize = BSStepSize + 1
    If BSStepSize > 1000 Then
        
        Form1.Picture7.CurrentY = 0
        BSStepSize = 0
    End If
    If Index <> 36 And Index <> 5 And Index <> 4 And Index <> 17 And Index <> 21 And Index <> 15 And Index <> 25 And Index <> 24 And Index <> 32 And Index <> 35 Then
        
        If DebuggingFlag < 2 Then On Error Resume Next
        TempDbl = val(Text1(Index).Text)
        TempDbl = CDbl(Text1(Index).Text)
        On Error GoTo 0
        Text1(Index).Text = CLng(TempDbl)
        TStr = CLng(val(Text1(Index).Text))
        
    
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(0).Text)
    TempDbl = CDbl(Text1(0).Text)
    Text1(0) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(0).Text) < 10 Then
        Text1(0).Text = "10"
        Text1(0).ToolTipText = "The window size must be 10 or larger"
    ElseIf NextNo > 0 Then

        If CDbl(Text1(0).Text) > Len(StrainSeq(0)) / 1.5 Then
            Text1(0).Text = Len(StrainSeq(0)) / 1.5
            Text1(0).ToolTipText = "The window size must be between 10 and " & CStr(Len(StrainSeq(0)) / 1.5)
        End If

    End If

    If CDbl(Text1(1).Text) < 1 Then
        Text1(1).Text = "1"
        Text1(1).ToolTipText = "The step size must be 1 or larger"
    ElseIf CDbl(Text1(1).Text) > CDbl(Text1(0).Text) Then
        Text1(1).Text = Text1(0).Text
        Text1(1).ToolTipText = "The step size must be between 1 and " & Text1(0).Text
    End If

    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(5).Text)
    TempDbl = CDbl(Text1(5).Text)
    Text1(5) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(5).Text) < 70 Then
        Text1(5).Text = "70"
        Text1(5).ToolTipText = "The minimum cutoff must be 70% or higher"
    ElseIf CDbl(Text1(5).Text) > 100 Then
        Text1(5).Text = "100"
        Text1(5).ToolTipText = "The minimum cutoff must be between 70 and 100%"
    End If
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(2).Text)
    TempDbl = CDbl(Text1(2).Text)
    Text1(2) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(2).Text) < 10 Then
        Text1(2).Text = "10"
        Text1(2).ToolTipText = "At least 10 bootsrap replicates are required"
    ElseIf CDbl(Text1(2).Text) > 32000 Then
        Text1(2).Text = "32000"
        Text1(2).ToolTipText = "A maximum of 32000 bootsrap replicates can be performed"
    End If
    
    
    
    
    If val(Text1(2).Text) > 9999 Then
        Text1(2).Font = Ariel
        tsze = Text1(2).FontSize
        If Text1(2).FontSize <> 6.75 Then
            Text1(2).FontSize = 6.75
        End If
        TNum = CDbl(Text1(2).Text)
        Text1(2).Text = ""
        Text1(2).Text = TNum
    ElseIf Text1(2).FontSize <> 8.25 Then
        Text1(2).FontSize = 8.25
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(6).Text)
    TempDbl = CDbl(Text1(6).Text)
    Text1(6) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(6).Text) < 10 Then
        Text1(6).Text = "10"
        Text1(6).ToolTipText = "The window size must be 10 or larger"
    ElseIf NextNo > 0 Then

        If CDbl(Text1(6).Text) > Len(StrainSeq(0)) / 1.5 Then
            Text1(6).Text = Len(StrainSeq(0)) / 1.5
            Text1(6).ToolTipText = "The window size must be between 10 and " & CStr(Len(StrainSeq(0)) / 1.5)
        End If

    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(7).Text)
    TempDbl = CDbl(Text1(7).Text)
    Text1(7) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(7).Text) < 1 Then
        Text1(7).Text = "1"
        Text1(7).ToolTipText = "The step size must be 1 or larger"
    ElseIf CDbl(Text1(7).Text) > CDbl(Text1(6).Text) Then
        Text1(7).Text = Text1(6).Text
        Text1(7).ToolTipText = "The step size must be between 1 and " & Text1(6).Text
    End If
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(10).Text)
    TempDbl = CDbl(Text1(10).Text)
    Text1(10) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(10).Text) < 10 Then
        Text1(10).Text = "10"
        Text1(10).ToolTipText = "At least 10 bootsrap replicates are required"
    ElseIf CDbl(Text1(10).Text) > 32000 Then
        Text1(10).Text = "1000"
        Text1(10).ToolTipText = "A maximum of 32000 bootsrap replicates can be performed"
    End If

    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(8).Text)
    TempDbl = CDbl(Text1(8).Text)
    Text1(8) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(8).Text) < 1 Then
        Text1(8).Text = "1"
        Text1(8).ToolTipText = "The step size must be 1 or larger"
    ElseIf CDbl(Text1(8).Text) > CDbl(Text1(7).Text) Then
        Text1(8).Text = Text1(7).Text
        Text1(8).ToolTipText = "The step size must be between 1 and " & Text1(7).Text
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(12).Text)
    TempDbl = CDbl(val(Text1(12).Text))
    Text1(12) = TempDbl
    On Error GoTo 0
    
    If val(Text1(12).Text) < val(Text1(10).Text) Then
        Text1(12).Text = Text1(10).Text
        Text1(12).ToolTipText = "At least " & Text1(10).Text & " bootsrap replicates are required"
    ElseIf val(Text1(12).Text) > 32000 Then
        Text1(12).Text = "1000"
        Text1(12).ToolTipText = "A maximum of 32000 bootsrap replicates can be performed"
    End If

    
    
    

    'B$ = cdbl(Text1(21).Text)

    If MCProportionFlag = 0 Then
        If DebuggingFlag < 2 Then On Error Resume Next
        TempDbl = val(Text1(21).Text)
        TempDbl = CDbl(Text1(21).Text)
        On Error GoTo 0
        If TempDbl < 10 Then
            Text1(21).Text = "10"
            Text1(21).ToolTipText = "The window size must be 10 or larger"
        ElseIf NextNo > 0 Then
            
            If TempDbl > Len(StrainSeq(0)) / 1.5 Then
                Text1(21).Text = Int(Len(StrainSeq(0)) / 1.5)
                Text1(21).ToolTipText = "The window size must be between 10 and " & CStr(Int(Len(StrainSeq(0)) / 1.5))
            Else
                MCWinSize = val(Text1(21).Text)
            End If

        Else
            MCWinSize = val(Text1(21).Text)
        End If

    Else
        If DebuggingFlag < 2 Then On Error Resume Next
        TempDbl = val(Text1(21).Text)
        TempDbl = CDbl(Text1(21).Text)
        
        On Error GoTo 0

        
        If NextNo = 0 Then
            'B$ = cdbl(Text1(21).Text)
            
            If TempDbl < 0.001 Then
                Text1(21).Text = "0.001"
                Text1(21).ToolTipText = "The window fraction must be 0.001 or greater"
            ElseIf TempDbl > 1 / 1.5 Then
                Text1(21).Text = (1 / 1.5)
                Text1(21).ToolTipText = "The window size must be smaller than " & CStr(1 / 1.5)
            Else
                MCWinFract = TempDbl
            End If
        Else
            'B$ = cdbl(Text1(21).Text)

            If TempDbl < (10 / Len(StrainSeq(0))) Then
                Text1(21).Text = Int((10 / Len(StrainSeq(0))) * 100000) / 100000
                Text1(21).ToolTipText = "The window size must be " & CStr(Int((10 / Len(StrainSeq(0))) * 100000) / 100000) & " or larger"
            ElseIf TempDbl > 1 / 1.5 Then
                Text1(21).Text = Int(1 / 1.5)
                Text1(21).ToolTipText = "The window size must be smaller than " & CStr(1 / 1.5)
            Else
                MCWinFract = TempDbl
            End If

        End If

    End If

    'test = cdbl(Text1(3).Text)
    
    If DebuggingFlag < 2 Then On Error Resume Next
        
    TempDbl = val(Text1(3).Text)
    TempDbl = CDbl(Text1(3).Text)
    Text1(3) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(3).Text) < 3 Then
        Text1(3).Text = "3"
        Text1(3).ToolTipText = "The seed must be an odd number between 3 and 29999"
    ElseIf NextNo > 0 Then

        If CDbl(Text1(3).Text) > 29999 Then
            Text1(3).Text = 29999
            Text1(3).ToolTipText = "The seed must be an odd number between 3 and 29999"
        End If

    ElseIf (CDbl(Text1(3).Text) / 2) = Int(CDbl(Text1(3).Text) / 2) Then
        Text1(3).Text = CStr(CDbl(Text1(3).Text) + 1)
    End If

    
    
    If DebuggingFlag < 2 Then On Error Resume Next
        
    TempDbl = val(Text1(4).Text)
    TempDbl = CDbl(Text1(4).Text)
    Text1(4) = TempDbl
    On Error GoTo 0
    
    If CDbl(Text1(4).Text) < 0.1 Then
        Text1(4).Text = "0.1"
        Text1(4).ToolTipText = "Transition/transversion ratio must be between 0.1 and 10"
    ElseIf NextNo > 0 Then

        If CDbl(Text1(4).Text) > 10 Then
            Text1(4).Text = 10
            Text1(4).ToolTipText = "Transition/transversion ratio must be between 0.1 and 10"
        End If

    End If

    
    'xxx = Text1(15)
    
    If Text1(15) <> "" Then
        DPTVRatio = CDbl(Text1(15))
    End If
    If CDbl(Text1(22).Text) < 10 Then
        Text1(22).Text = 10

        If NextNo > 0 Then
            Text1(22).ToolTipText = "The window size must be larger than 10 and less than " & Len(StrainSeq(0)) - CDbl(Text1(19))
        Else
            Text1(22).ToolTipText = "The window size must be larger than 10"
        End If

    ElseIf NextNo > 0 Then

        If CDbl(Text1(22).Text) > Len(StrainSeq(0)) - TOStepSize Then
            Text1(22).Text = Len(StrainSeq(0)) - CDbl(Text1(19))
            Text1(22).ToolTipText = "The window size must be larger than 10 and less than " & Len(StrainSeq(0)) - CDbl(Text1(19))
        End If

    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl19 = val(Text1(19).Text)
    TempDbl19 = CDbl(Text1(19).Text)
    On Error GoTo 0
    
    If TempDbl19 < 1 Then
        Text1(19).Text = 1

        If NextNo > 0 Then
            Text1(19).ToolTipText = "The step size must be larger than 1 and less than " & Len(StrainSeq(0)) / 2
        Else
            Text1(19).ToolTipText = "The step size must be larger than 1"
        End If

    ElseIf NextNo > 0 Then

        If TempDbl19 > Len(StrainSeq(0)) / 2 Then
            Text1(19).Text = Len(StrainSeq(0)) / 2
            Text1(19).ToolTipText = "The step size must be larger than 1 and less than " & Len(StrainSeq(0)) / 2
        End If

    End If
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(23).Text)
    TempDbl = CDbl(Text1(23).Text)
    On Error GoTo 0
    
    If TempDbl < 1 Then
        Text1(23).Text = 1

        If NextNo > 0 Then
            Text1(23).ToolTipText = "The smooth window must be larger than 1 and less than " & Int(Len(StrainSeq(0)) / CDbl(Text1(19)))
        Else
            Text1(23).ToolTipText = "The smooth window  must be larger than 1"
        End If

    ElseIf NextNo > 0 Then

        If TempDbl > Int(Len(StrainSeq(0)) / TempDbl19) Then
            Text1(23).Text = Int(Len(StrainSeq(0)) / TempDbl19)
            Text1(23).ToolTipText = "The smooth window must be larger than 1 and less than " & Int(Len(StrainSeq(0)) / TempDbl19)
        End If

    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(25).Text)
    TempDbl = CDbl(Text1(25).Text)
    On Error GoTo 0
    
    If TempDbl <= 0 Then
        'Text1(25).Text = 0.01
        'Text1(25).ToolTipText = "The power must be larger than 0.01 and less than 100"
    ElseIf TempDbl > 100 Then
        Text1(25).Text = 100
        Text1(25).ToolTipText = "The power must be less than 100"
    End If
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(26).Text)
    TempDbl = CDbl(Text1(26).Text)
    On Error GoTo 0
    
    If TempDbl < 3 Then
        Text1(26).Text = 3
        Text1(26).ToolTipText = "The random number seed must be 3 or larger and less than 15999"
    ElseIf TempDbl > 15999 Then
        Text1(26).Text = 15999
        Text1(26).ToolTipText = "The random number seed must be 3 or larger and less than 15999"
    ElseIf TempDbl / 2 = Int(CDbl(Text1(26).Text) / 2) Then
        Text1(26).Text = CDbl(Text1(26).Text) + 1
    End If
    
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(27).Text)
    TempDbl = CDbl(Text1(27).Text)
    On Error GoTo 0
    
    If TempDbl < 0 Then
        Text1(27).Text = 0
        Text1(27).ToolTipText = "You may use between 0 and 10000 simulated datasets"
    ElseIf TempDbl > 10000 Then
        Text1(27).Text = 10000
        Text1(27).ToolTipText = "You may use between 0 and 10000 simulated datasets"
    End If
    
    If DebuggingFlag < 2 Then On Error Resume Next
    TempDbl = val(Text1(16).Text)
    TempDbl = CDbl(Text1(16).Text)
    On Error GoTo 0
    If TempDbl < 0.1 Then
        Text1(16).Text = 0.1
        Text1(16).ToolTipText = "The transition:transversion rate ratio must be higher than 0.1 and less than 10"
    ElseIf TempDbl > 10 Then
        Text1(16).Text = 10
        Text1(16).ToolTipText = "The transition:transversion rate ratio must be higher than 0.1 and less than 10"
    End If

    If TOModel > 0 Then
        TOTvTs = CDbl(Text1(16))
    End If
        
    
    If DebuggingFlag < 2 Then On Error Resume Next
        
    TempDbl = val(Text1(4).Text)
    TempDbl = CDbl(Text1(4).Text)
    Text1(4) = TempDbl
    On Error GoTo 0
    If xBSSubModelFlag > 0 Then
        xBSTTRatio = CDbl(Text1(4))
    End If
    If CDbl(Text1(34)) / 2 = Int(CDbl(Text1(34)) / 2) Then Text1(34) = CDbl(Text1(34)) + 1
End Sub

Private Sub Text10_LostFocus()
    Text10.Text = Int(val(Text10.Text))

    If CDbl(Text10.Text) < 0 Then
        Text10.Text = "0"
        Text10.ToolTipText = "Can only display between 1 and 500 nucleotides at endpoints"
    ElseIf CDbl(Text10.Text) > 500 Then
        Text10.Text = "500"
        Text10.ToolTipText = "Can only display between 1 and 500 nucleotides at endpoints"
    ElseIf CDbl(Text10.Text) >= 0 And CDbl(Text10.Text) <= 500 Then
    Else
        Text10.Text = "0"
    End If

End Sub

Private Sub Text11_LostFocus()
    Text11.Text = Int(val(Text11.Text))

    If CDbl(Text11.Text) < -1000000 Then
        Text11.Text = "-100000"
        'Text10.ToolTipText = "Can only display between 1 and 500 nucleotides at endpoints"
    ElseIf CDbl(Text11.Text) > 1000000 Then
        Text11.Text = "1000000"
        'Text10.ToolTipText = "Can only display between 1 and 500 nucleotides at endpoints"
    ElseIf CDbl(Text11.Text) <= 1000000 And CDbl(Text11.Text) >= -1000000 Then
    Else
        Text11.Text = "0"
    End If

End Sub

Private Sub Text12_LostFocus()
    Text12.Text = Int(val(Text12.Text))

    If CDbl(Text12.Text) < 0 Then
        Text12.Text = "0"
        Text12.ToolTipText = "The G-scale value must be 0 or greater"
    ElseIf CDbl(Text12.Text) > 100 Then
        Text12.Text = "100"
        Text12.ToolTipText = "The G-scale value must be between 0 and 100"
    ElseIf CDbl(Text12.Text) >= 0 And CDbl(Text12.Text) <= 100 Then
    Else
        Text12.Text = "2"
    End If

End Sub

Private Sub Text13_LostFocus()
    Text13.Text = Int(val(Text13.Text))

    If NextNo > 0 Then

        If CDbl(Text13.Text) < 0 Then
            Text13.Text = "0"
            'Text14.ToolTipText = "The starting nucleotide must be greater than 1"
        ElseIf CDbl(Text13.Text) > 100000 Then
            Text13.Text = "100000"
            'Text14.ToolTipText = "The starting nucleotide must be less than " & cstr(Len(StrainSeq(0)))
        ElseIf CDbl(Text13.Text) >= 0 And CDbl(Text13.Text) <= 100000 Then
        Else
            Text13.Text = "0"
        End If

    End If

End Sub

Private Sub Text14_LostFocus()
    Text14.Text = Int(val(Text14.Text))

    If NextNo > 0 Then

        If CDbl(Text14.Text) < 0 Then
            Text14.Text = "0"
            'Text14.ToolTipText = "The starting nucleotide must be greater than 1"
        ElseIf CDbl(Text14.Text) > 100000 Then
            Text14.Text = "100000"
            'Text14.ToolTipText = "The starting nucleotide must be less than " & cstr(Len(StrainSeq(0)))
        ElseIf CDbl(Text14.Text) >= 0 And CDbl(Text14.Text) <= 100000 Then
        Else
            Text14.Text = "2000"
        End If

    End If

End Sub

Private Sub Text15_LostFocus()
    Text15.Text = Int(val(Text15.Text))

    If NextNo > 0 Then

        If CDbl(Text15.Text) < 1 Then
            Text15.Text = "1"
            Text15.ToolTipText = "Fragments must have an aligned length of at least one nucleotide"
        ElseIf CDbl(Text15.Text) > Len(StrainSeq(0)) Then
            Text15.Text = CStr(Len(StrainSeq(0)))
            'Text15.ToolTipText = "Fragments must have fewer than 1000 polymorphisms" & cstr(Len(StrainSeq(0)))
        ElseIf CDbl(Text15.Text) >= 1 And CDbl(Text15.Text) <= Len(StrainSeq(0)) Then
        Else
            Text15.Text = "1"
        End If

    End If

End Sub

Private Sub Text16_LostFocus()
    Text16.Text = Int(val(Text16.Text))

    If CDbl(Text16.Text) < 1 Then
        Text16.Text = "1"
        Text16.ToolTipText = "Fragments must have at least one polymorphism"
    ElseIf CDbl(Text16.Text) > 999 Then
        Text16.Text = "999"
        Text16.ToolTipText = "Fragments must have fewer than 1000 polymorphisms" & CStr(Len(StrainSeq(0)))
    ElseIf CDbl(Text16.Text) >= 1 And CDbl(Text16.Text) <= 999 Then
    Else
        Text16.Text = "2"
    End If

End Sub

Private Sub Text17_LostFocus()
    Text17.Text = Int(val(Text17.Text))

    If CDbl(Text17.Text) < 1 Then
        Text17.Text = "1"
        Text17.ToolTipText = "Minimum fragment scores must be 1 or greater"
    ElseIf CDbl(Text17.Text) > 32000 Then
        Text17.Text = "32000"
        'Text17.ToolTipText = "The starting nucleotide must be less than " & cstr(Len(StrainSeq(0)))
    ElseIf CDbl(Text17.Text) >= 1 And CDbl(Text17.Text) <= 32000 Then
    Else
        Text17.Text = "2"
    End If

End Sub

Private Sub Text18_LostFocus()
    Text18.Text = Int(val(Text18.Text))

    If CDbl(Text18.Text) < 1 Then
        Text18.Text = "1"
        Text18.ToolTipText = "At least 1 fragment must be allowed"
    ElseIf CDbl(Text18.Text) > 1000000 Then
        Text18.Text = "1000000"
        'Text18.ToolTipText = "The starting nucleotide must be less than " & cstr(Len(StrainSeq(0)))
    ElseIf CDbl(Text18.Text) >= 1 And CDbl(Text18.Text) <= 1000000 Then
    Else
        Text18.Text = "1"
    End If

End Sub

Private Sub Text19_LostFocus()
    Text19.Text = Int(val(Text19.Text))
    
    
    If NextNo > 0 Then

        If CDbl(Text19.Text) <= 10 Then
            Text19.Text = "0"
            'Text19.ToolTipText = "The starting nucleotide must be greater than 1"
        ElseIf CDbl(Text19.Text) > 100000 Then
            Text19.Text = "100000"
            'Text19.ToolTipText = ""
        ElseIf CDbl(Text19.Text) >= 0 And CDbl(Text19.Text) <= 100000 Then
        Else
            Text19.Text = "0"
        End If

    End If

End Sub

Private Sub Text2_LostFocus()
    If DebuggingFlag < 2 Then On Error Resume Next
    If NextNo > 0 Then

        If CDbl(Text2.Text) < 5 Then
            Text2.Text = "5"
            Text2.ToolTipText = "You must specify a window size greater than 5 and less than 1000"
        ElseIf CDbl(Text2.Text) > 1000 Then
            Text2.Text = 1000
            Text2.ToolTipText = "You must specify a window size greater than 5 and less than 1000"
        ElseIf CDbl(Text2.Text) >= 5 And CDbl(Text2.Text) < 1000 Then
            x = x
        Else
            Text2.Text = "5"
        End If

    End If
    On Error GoTo 0
End Sub

Private Sub Text20_LostFocus()

    Dim TempDbl As Double
    If NextNo > 0 Then
        If DebuggingFlag < 2 Then On Error Resume Next
        
        TempDbl = val(Text20.Text)
        TempDbl = CDbl(Text20.Text)
        
        On Error GoTo 0
        If TempDbl <= 0 Then
            TempDbl = 0.0000000001
            Text20.Text = TempDbl
            Text20.ToolTipText = "You must specify a P-value greater than 0 and less than 1"
        ElseIf TempDbl >= 1 Then
            TempDbl = 0.05
            Text20.Text = TempDbl
            Text20.ToolTipText = "You must specify a P-value greater than 0 and less than 1"
        ElseIf TempDbl > 0 And TempDbl < 1 Then
        Else
            TempDbl = 0.05
            Text20.Text = TempDbl
        End If

    End If

End Sub

Private Sub Text21_LostFocus()
    Text21.Text = Int(CDbl(Text21.Text))

    If NextNo > 0 Then

        If CDbl(Text21.Text) < 1 Then
            Text21.Text = "1"
            Text21.ToolTipText = "The starting nucleotide must be greater than 1"
        ElseIf CDbl(Text21.Text) > Len(StrainSeq(0)) Then
            Text21.Text = CStr(Len(StrainSeq(0)))
            Text21.ToolTipText = "The starting nucleotide must be less than " & CStr(Len(StrainSeq(0)))
        ElseIf CDbl(Text21.Text) >= 1 And CDbl(Text21.Text) <= Len(StrainSeq(0)) Then
        Else
            Text21.Text = "1"
        End If

    End If

End Sub

Private Sub Text22_LostFocus()
    Text22.Text = Int(CDbl(Text22.Text))

    If NextNo > 0 Then

        If Text22.Text < 1 Then
            Text22.Text = "1"
            Text22.ToolTipText = "The ending nucleotide must be greater than 1"
        ElseIf Text22.Text > Len(StrainSeq(0)) Then
            Text22.Text = CStr(Len(StrainSeq(0)))
            Text22.ToolTipText = "The ending nucleotide must be less than " & CStr(Len(StrainSeq(0)))
        ElseIf CDbl(Text22.Text) >= 1 And CDbl(Text22.Text) <= Len(StrainSeq(0)) Then
        Else
            Text22.Text = CStr(Len(StrainSeq(0)))
        End If

    End If

End Sub

Private Sub Text23_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
If Index = 34 Then
    x = x
    If KeyCode = 13 Then
        Form3.Command1.SetFocus
    End If
End If
End Sub

Private Sub Text23_LostFocus(Index As Integer)
Dim Tmp As Double

If Index = 5 Then
    If DebuggingFlag < 2 Then On Error Resume Next
    Tmp = val(Text23(5))
    Tmp = CLng(Text23(5))
    On Error GoTo 0
    If Tmp > 32 Then
        Text23(5) = 32
        Text23(5).ToolTipText = "The number of breakpoints must be smaller than or equil to 2"
    ElseIf Tmp < 1 Then
        Text23(5) = 1
        Text23(5).ToolTipText = "The number of categories must be larger than or equil to 1"
        Tmp = 1
    End If
    Text23(5) = CLng(Tmp)
ElseIf Index = 34 Then
    If DebuggingFlag < 2 Then On Error Resume Next
    Tmp = val(Text23(34))
    Tmp = CLng(Text23(34))
    On Error GoTo 0
    If Tmp < 2 Then
        Text23(34) = "1"
        Text23(42).Enabled = False
        Text23(42).BackColor = Form1.BackColor
        Text23(42).ForeColor = RGB(128, 128, 128)
        Label21(52).Enabled = False
    Else
        If Tmp > 50 Then
            Tmp = 50
        End If
        Text23(42).Enabled = True
        Text23(42).BackColor = RGB(255, 255, 255)
        Text23(42).ForeColor = 0
        Label21(52).Enabled = True
    End If
ElseIf Index = 35 Then
    If DebuggingFlag < 2 Then On Error Resume Next
    Tmp = val(Text23(35))
    Tmp = CLng(Text23(35))
    On Error GoTo 0
    If Tmp < 2 Then
        Text23(35) = "1"
        
    Else
        If Tmp > 100 Then
            Tmp = 100
        End If
    End If
End If
End Sub

Private Sub Text24_LostFocus(Index As Integer)
If DebuggingFlag < 2 Then On Error Resume Next
If val(Text24(2)) < 10 Then Text24(2) = "10"
If val(Text24(4)) < 10 Then Text24(4) = "10"
If val(Text24(2)) < val(Text24(4)) Then Text24(2) = Text24(4)

On Error GoTo 0

End Sub

Private Sub Text3_LostFocus()
    Dim TempDbl As Double
    If NextNo > 0 Then
         On Error Resume Next
        
        TempDbl = val(Text3.Text)
        TempDbl = CDbl(Text3.Text)
        
        On Error GoTo 0
        If TempDbl <= 0 Then
            TempDbl = 0.0000000001
            Text3.Text = TempDbl
            Text3.ToolTipText = "You must specify a P-value greater than 0 and less than or equal to 1"
        ElseIf TempDbl > 1 Then
            TempDbl = 1#
            Text3.Text = TempDbl
            Text3.ToolTipText = "You must specify a P-value greater than 0 and less than or equal to 1"
        ElseIf TempDbl > 0 And TempDbl <= 1 Then
        Else
            TempDbl = 0.05
            Text3.Text = TempDbl
        End If

    End If

End Sub





Private Sub Text6_Change(Index As Integer)
x = x
End Sub

Private Sub Text6_LostFocus(Index As Integer)
If Index = 5 Then
    If val(Text6(5).Text) < 100000 Then Text6(5) = 100000
End If
End Sub
