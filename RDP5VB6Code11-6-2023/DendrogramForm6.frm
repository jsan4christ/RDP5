VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form Form2 
   Caption         =   "Trees"
   ClientHeight    =   10785
   ClientLeft      =   810
   ClientTop       =   -30
   ClientWidth     =   12120
   Icon            =   "DendrogramForm6.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   NegotiateMenus  =   0   'False
   ScaleHeight     =   10785
   ScaleWidth      =   12120
   Begin VB.PictureBox Picture6 
      AutoRedraw      =   -1  'True
      Height          =   372
      Left            =   0
      ScaleHeight     =   315
      ScaleWidth      =   555
      TabIndex        =   51
      Top             =   0
      Visible         =   0   'False
      Width           =   612
   End
   Begin VB.PictureBox Picture5 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   492
      Left            =   3840
      ScaleHeight     =   495
      ScaleWidth      =   375
      TabIndex        =   50
      Top             =   960
      Visible         =   0   'False
      Width           =   372
   End
   Begin VB.Timer Timer1 
      Interval        =   250
      Left            =   9600
      Top             =   2280
   End
   Begin VB.PictureBox Picture1 
      Height          =   615
      Left            =   1920
      ScaleHeight     =   555
      ScaleWidth      =   1155
      TabIndex        =   28
      Top             =   1320
      Visible         =   0   'False
      Width           =   1215
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3432
      Index           =   1
      Left            =   6480
      TabIndex        =   4
      Top             =   480
      Width           =   3732
      _Version        =   65536
      _ExtentX        =   6588
      _ExtentY        =   6059
      _StockProps     =   15
      Caption         =   "No Trees To Display"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox Picture4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   1
         Left            =   0
         ScaleHeight     =   255
         ScaleWidth      =   375
         TabIndex        =   47
         Top             =   0
         Width           =   375
      End
      Begin VB.PictureBox Picture3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1452
         Index           =   1
         Left            =   0
         ScaleHeight     =   1455
         ScaleWidth      =   375
         TabIndex        =   43
         Top             =   0
         Width           =   372
      End
      Begin VB.CommandButton Command7 
         Caption         =   "Command7"
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
         Left            =   840
         TabIndex        =   39
         Top             =   240
         Visible         =   0   'False
         Width           =   495
      End
      Begin Threed.SSPanel SSPanel5 
         Height          =   855
         Index           =   0
         Left            =   120
         TabIndex        =   29
         Top             =   2520
         Width           =   3495
         _Version        =   65536
         _ExtentX        =   6165
         _ExtentY        =   1508
         _StockProps     =   15
         BackColor       =   14215660
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.CommandButton Command6 
            Caption         =   "Run tests"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   2160
            TabIndex        =   33
            ToolTipText     =   "Given this section of the alignment is this tree significantly different from that obtained for the remainder of the alignment"
            Top             =   120
            Width           =   1095
         End
         Begin VB.Label Label4 
            BackStyle       =   0  'Transparent
            Caption         =   "Approximately unbiased p-value: Undetermined"
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
            Index           =   0
            Left            =   -1560
            TabIndex        =   32
            Top             =   480
            Width           =   4935
         End
         Begin VB.Label Label3 
            BackStyle       =   0  'Transparent
            Caption         =   "Shimodaira-Hasegawa p-value: Undetermined"
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
            Index           =   0
            Left            =   -960
            TabIndex        =   31
            Top             =   240
            Width           =   4335
         End
         Begin VB.Label Label2 
            BackStyle       =   0  'Transparent
            Caption         =   "Tree Topology Tests"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   0
            Left            =   240
            TabIndex        =   30
            Top             =   0
            Width           =   2415
         End
      End
      Begin VB.PictureBox Picture2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2145
         Index           =   1
         Left            =   360
         MouseIcon       =   "DendrogramForm6.frx":030A
         ScaleHeight     =   139
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   143
         TabIndex        =   23
         Top             =   840
         Width           =   2205
      End
      Begin VB.CommandButton Command1 
         Height          =   315
         Index           =   0
         Left            =   3150
         MouseIcon       =   "DendrogramForm6.frx":045C
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":05AE
         Style           =   1  'Graphical
         TabIndex        =   18
         ToolTipText     =   "Press to cycle through trees"
         Top             =   150
         Width           =   345
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   2595
         Index           =   1
         Left            =   3270
         MousePointer    =   1  'Arrow
         TabIndex        =   5
         Top             =   600
         Width           =   285
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         Caption         =   "Warning: This recombination signal might've been caused by an evolutionary process other than recombination"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Index           =   1
         Left            =   0
         TabIndex        =   53
         Top             =   0
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "Tree One"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   360
         TabIndex        =   6
         Top             =   240
         Width           =   3045
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3435
      Index           =   2
      Left            =   120
      TabIndex        =   7
      ToolTipText     =   "Press to cycle through trees"
      Top             =   4800
      Width           =   4935
      _Version        =   65536
      _ExtentX        =   8705
      _ExtentY        =   6059
      _StockProps     =   15
      Caption         =   "No Trees To Display"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox Picture4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   2
         Left            =   0
         ScaleHeight     =   255
         ScaleWidth      =   375
         TabIndex        =   48
         Top             =   0
         Width           =   375
      End
      Begin VB.PictureBox Picture3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1452
         Index           =   2
         Left            =   0
         ScaleHeight     =   1455
         ScaleWidth      =   375
         TabIndex        =   44
         Top             =   0
         Width           =   372
      End
      Begin Threed.SSPanel SSPanel5 
         Height          =   852
         Index           =   1
         Left            =   0
         TabIndex        =   34
         Top             =   2640
         Width           =   3492
         _Version        =   65536
         _ExtentX        =   6165
         _ExtentY        =   1508
         _StockProps     =   15
         BackColor       =   14215660
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.CommandButton Command6 
            Caption         =   "Run tests"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   2160
            TabIndex        =   35
            ToolTipText     =   "Given this section of the alignment is this tree significantly different from that obtained for the remainder of the alignment "
            Top             =   120
            Width           =   1095
         End
         Begin VB.Label Label2 
            BackStyle       =   0  'Transparent
            Caption         =   "Tree Topology Tests"
            BeginProperty Font 
               Name            =   "Arial"
               Size            =   8.25
               Charset         =   0
               Weight          =   400
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Index           =   1
            Left            =   240
            TabIndex        =   38
            Top             =   0
            Width           =   2415
         End
         Begin VB.Label Label3 
            BackStyle       =   0  'Transparent
            Caption         =   "Shimodaira-Hasegawa p-value: Undetermined"
            Height          =   255
            Index           =   1
            Left            =   -840
            TabIndex        =   37
            Top             =   240
            Width           =   4215
         End
         Begin VB.Label Label4 
            BackStyle       =   0  'Transparent
            Caption         =   "Approximately unbiased p-value: Undetermined"
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
            Index           =   1
            Left            =   -1200
            TabIndex        =   36
            Top             =   480
            Width           =   4455
         End
      End
      Begin VB.PictureBox Picture2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2145
         Index           =   2
         Left            =   240
         MouseIcon       =   "DendrogramForm6.frx":08B8
         ScaleHeight     =   139
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   143
         TabIndex        =   24
         Top             =   600
         Width           =   2205
      End
      Begin VB.CommandButton Command1 
         Height          =   315
         Index           =   1
         Left            =   600
         MouseIcon       =   "DendrogramForm6.frx":0A0A
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":0B5C
         Style           =   1  'Graphical
         TabIndex        =   19
         ToolTipText     =   "Press to cycle through trees"
         Top             =   120
         Width           =   345
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   2595
         Index           =   2
         Left            =   3270
         MousePointer    =   1  'Arrow
         TabIndex        =   8
         Top             =   600
         Width           =   285
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         Caption         =   "Warning: This recombination signal might've been caused by an evolutionary process other than recombination"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Index           =   2
         Left            =   0
         TabIndex        =   54
         Top             =   0
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "Tree Two"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   2
         Left            =   0
         TabIndex        =   9
         Top             =   120
         Width           =   2985
      End
   End
   Begin Threed.SSPanel SSPanel2 
      Height          =   495
      Left            =   3240
      TabIndex        =   13
      Top             =   9120
      Width           =   8655
      _Version        =   65536
      _ExtentX        =   15266
      _ExtentY        =   873
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
      Begin VB.CommandButton Command8 
         Height          =   255
         Left            =   5880
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":0E66
         Style           =   1  'Graphical
         TabIndex        =   41
         ToolTipText     =   "Go to previous event [Ctr + up arrow]"
         Top             =   120
         Width           =   255
      End
      Begin VB.CommandButton Command9 
         Height          =   255
         Left            =   6240
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":12A8
         Style           =   1  'Graphical
         TabIndex        =   40
         ToolTipText     =   "Go to next event [Ctr + down arrow]"
         Top             =   120
         Width           =   255
      End
      Begin VB.CommandButton Command5 
         Caption         =   "-"
         Height          =   255
         Left            =   7080
         TabIndex        =   27
         ToolTipText     =   "Zoom out"
         Top             =   120
         Width           =   375
      End
      Begin VB.CommandButton Command4 
         Caption         =   "+"
         Height          =   255
         Left            =   6600
         TabIndex        =   26
         ToolTipText     =   "Zoom in"
         Top             =   240
         Width           =   255
      End
      Begin VB.CommandButton Command2 
         Caption         =   "STOP"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   7680
         TabIndex        =   17
         Top             =   60
         Width           =   855
      End
      Begin Threed.SSPanel SSPanel4 
         Height          =   345
         Left            =   1590
         TabIndex        =   15
         Top             =   60
         Width           =   3015
         _Version        =   65536
         _ExtentX        =   5318
         _ExtentY        =   609
         _StockProps     =   15
         Caption         =   "SSPanel4"
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin ComctlLib.ProgressBar ProgressBar1 
            Height          =   285
            Left            =   210
            TabIndex        =   16
            Top             =   30
            Width           =   3615
            _ExtentX        =   6376
            _ExtentY        =   503
            _Version        =   327682
            Appearance      =   1
         End
      End
      Begin Threed.SSPanel SSPanel3 
         Height          =   315
         Left            =   150
         TabIndex        =   14
         Top             =   90
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   556
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
         Font3D          =   1
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   3330
      Top             =   90
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   5472
      Index           =   0
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   5772
      _Version        =   65536
      _ExtentX        =   10181
      _ExtentY        =   9652
      _StockProps     =   15
      Caption         =   "No Trees To Display"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox Picture4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   0
         Left            =   3000
         ScaleHeight     =   255
         ScaleWidth      =   375
         TabIndex        =   46
         Top             =   240
         Width           =   375
      End
      Begin VB.PictureBox Picture3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1452
         Index           =   0
         Left            =   0
         ScaleHeight     =   1455
         ScaleWidth      =   375
         TabIndex        =   42
         Top             =   0
         Width           =   372
      End
      Begin VB.PictureBox Picture2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2145
         Index           =   0
         Left            =   480
         MouseIcon       =   "DendrogramForm6.frx":16EA
         ScaleHeight     =   139
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   143
         TabIndex        =   22
         Top             =   1080
         Width           =   2205
      End
      Begin VB.CommandButton Command1 
         Height          =   315
         Index           =   3
         Left            =   0
         MouseIcon       =   "DendrogramForm6.frx":183C
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":198E
         Style           =   1  'Graphical
         TabIndex        =   21
         ToolTipText     =   "Press to cycle through trees"
         Top             =   0
         Width           =   345
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   2595
         Index           =   0
         Left            =   3300
         MousePointer    =   1  'Arrow
         TabIndex        =   2
         Top             =   600
         Width           =   285
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         Caption         =   "Warning: This recombination signal might've been caused by an evolutionary process other than recombination"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Index           =   0
         Left            =   600
         TabIndex        =   52
         Top             =   2760
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "Label1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   120
         TabIndex        =   3
         Top             =   120
         Width           =   3030
      End
   End
   Begin Threed.SSPanel SSPanel1 
      Height          =   3432
      Index           =   3
      Left            =   6480
      TabIndex        =   10
      ToolTipText     =   "Press to cycle through trees"
      Top             =   4440
      Width           =   3732
      _Version        =   65536
      _ExtentX        =   6588
      _ExtentY        =   6059
      _StockProps     =   15
      Caption         =   "No Trees To Display"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.PictureBox Picture4 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   255
         Index           =   3
         Left            =   0
         ScaleHeight     =   255
         ScaleWidth      =   375
         TabIndex        =   49
         Top             =   0
         Width           =   375
      End
      Begin VB.PictureBox Picture3 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1452
         Index           =   3
         Left            =   2760
         ScaleHeight     =   1455
         ScaleWidth      =   375
         TabIndex        =   45
         Top             =   240
         Width           =   372
      End
      Begin VB.PictureBox Picture2 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   2145
         Index           =   3
         Left            =   480
         MouseIcon       =   "DendrogramForm6.frx":1C98
         ScaleHeight     =   139
         ScaleMode       =   3  'Pixel
         ScaleWidth      =   143
         TabIndex        =   25
         Top             =   840
         Width           =   2205
      End
      Begin VB.CommandButton Command1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Index           =   2
         Left            =   0
         MouseIcon       =   "DendrogramForm6.frx":1DEA
         MousePointer    =   99  'Custom
         Picture         =   "DendrogramForm6.frx":1F3C
         Style           =   1  'Graphical
         TabIndex        =   20
         ToolTipText     =   "Press to cycle through trees"
         Top             =   0
         Width           =   345
      End
      Begin VB.VScrollBar VScroll1 
         Height          =   2595
         Index           =   3
         Left            =   3270
         MousePointer    =   1  'Arrow
         TabIndex        =   11
         Top             =   600
         Width           =   285
      End
      Begin VB.Label Label5 
         Alignment       =   2  'Center
         Caption         =   "Warning: This recombination signal might've been caused by an evolutionary process other than recombination"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000FF&
         Height          =   255
         Index           =   3
         Left            =   0
         TabIndex        =   55
         Top             =   0
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         Caption         =   "Label1"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   372
         Index           =   3
         Left            =   240
         TabIndex        =   12
         Top             =   120
         Width           =   2892
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Command3"
      Height          =   285
      Left            =   1230
      TabIndex        =   0
      Top             =   1650
      Width           =   315
   End
   Begin VB.Menu NodeMnu 
      Caption         =   "Node Menu"
      Visible         =   0   'False
      Begin VB.Menu MarkAsHavingEventMnu 
         Caption         =   "Mark all sequences above this node as having evidence of this recombination event"
      End
      Begin VB.Menu MarkAsNotHavingEventMnu 
         Caption         =   "Unmark all sequences above this node as having evidence of this recombination event"
      End
      Begin VB.Menu FindBestMajParMnu 
         Caption         =   "Find ""best"" major parent above this node"
      End
      Begin VB.Menu FindBestMinParMnu 
         Caption         =   "Find ""best"" minor parent above this node"
      End
      Begin VB.Menu Null1Mnu 
         Caption         =   ""
      End
      Begin VB.Menu AcceptAllMnu3 
         Caption         =   "Accept all recombination events above this node"
      End
      Begin VB.Menu RejectAllMnu3 
         Caption         =   "Reject all recombination events above this node"
      End
      Begin VB.Menu NodeMarkMnu 
         Caption         =   "Colour all sequences above this node"
      End
      Begin VB.Menu NodeUnMarkMnu 
         Caption         =   "Uncolour all sequences above this node"
      End
      Begin VB.Menu Null2Mnu 
         Caption         =   ""
      End
      Begin VB.Menu AncSeqMnu 
         Caption         =   "Determine ancestral sequence at this node"
      End
   End
   Begin VB.Menu SaveMnu 
      Caption         =   "Save Menu"
      Visible         =   0   'False
      Begin VB.Menu MUMnu 
         Caption         =   "Make/Unmake daughter"
      End
      Begin VB.Menu AcceptExMnu 
         Caption         =   "Accept this event only in this sequence"
      End
      Begin VB.Menu AcceptEAxMnu 
         Caption         =   "Accept this event in all xx sequences where it is found"
      End
      Begin VB.Menu RejectExMnu 
         Caption         =   "Reject this event only in this sequence"
      End
      Begin VB.Menu RejectEAxMnu 
         Caption         =   "Reject this event in all xx sequences where it is found"
      End
      Begin VB.Menu MakeMajParMnu 
         Caption         =   "Make as Maj parent"
      End
      Begin VB.Menu MakeMinParMnu 
         Caption         =   "Make as Min Par"
      End
      Begin VB.Menu GOTOSeq 
         Caption         =   "Go to X"
      End
      Begin VB.Menu FindSeqMnu2 
         Caption         =   "Find Sequence"
      End
      Begin VB.Menu RCheckPltMnu 
         Caption         =   "Recheck plot with..."
         Begin VB.Menu aDaughtMnu 
            Caption         =   "as recombinant   [Shift + Left click]"
         End
         Begin VB.Menu aMinParMnu 
            Caption         =   "as minor parent   [X + Left click]"
         End
         Begin VB.Menu aMajParMnu 
            Caption         =   "as major parent   [Z + Left click]"
         End
      End
      Begin VB.Menu null3 
         Caption         =   ""
      End
      Begin VB.Menu ClearColMnu 
         Caption         =   "Clear colour"
      End
      Begin VB.Menu AutoColMnu 
         Caption         =   "Auto colour"
      End
      Begin VB.Menu SelColMnu 
         Caption         =   "Select colour"
         Begin VB.Menu RedMnu 
            Caption         =   "Red          [2 + Left click]"
         End
         Begin VB.Menu GreenMnu 
            Caption         =   "Green      [5 + Left click]"
         End
         Begin VB.Menu BlueMnu 
            Caption         =   "Blue          [8 + Left click]"
         End
         Begin VB.Menu OtherColMnu 
            Caption         =   "Other"
         End
      End
      Begin VB.Menu AncestralMnu 
         Caption         =   "Determine ancetral sequence of this group"
         Visible         =   0   'False
      End
      Begin VB.Menu Null2 
         Caption         =   ""
      End
      Begin VB.Menu CpyMnu 
         Caption         =   "Copy"
      End
      Begin VB.Menu PrintTree 
         Caption         =   "Print tree"
         Enabled         =   0   'False
         Visible         =   0   'False
      End
      Begin VB.Menu SaveNH 
         Caption         =   "Save tree in Newick format"
      End
      Begin VB.Menu SaveEMF 
         Caption         =   "Save to .emf file"
      End
      Begin VB.Menu SaveBMP 
         Caption         =   "Save to .bmp file "
         Visible         =   0   'False
      End
      Begin VB.Menu Null1 
         Caption         =   ""
      End
      Begin VB.Menu MakeFastNJMnu 
         Caption         =   "Make FastNJ the default tree"
      End
      Begin VB.Menu ChangeTreeMnu 
         Caption         =   "Change tree type"
         Begin VB.Menu MakeFastNJMnu2 
            Caption         =   "Make FastNJ the default tree"
         End
         Begin VB.Menu UPGMAMnu2 
            Caption         =   "UPGMA"
         End
         Begin VB.Menu NJMnu2 
            Caption         =   "Neighbor joining"
         End
         Begin VB.Menu MLMnu2 
            Caption         =   "Maximum likelihood"
         End
         Begin VB.Menu BTMnu2 
            Caption         =   "Bayesian"
         End
      End
      Begin VB.Menu TreeOptMnu 
         Caption         =   "Tree options"
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 '44.27
' Here you can add scrolling support to controls that don't normally respond.
' This Sub could always be moved to a module to make scrollwheel behaviour
' generic across forms.
' ===========================================================================
Public Sub MouseWheel(ByVal MouseKeys As Long, ByVal Rotation As Long, ByVal Xpos As Long, ByVal YPos As Long)
  'Exit Sub
  
'  If DontSaveUndo = 0 Then
'        Call SaveUndo
'    End If
  
  Dim ctl As Control
  Dim bHandled As Boolean
  Dim bOver As Boolean
  If Rotation < 0 Then 'down
        Call DoKeydown(vbKeyDown)
  Else
    Call DoKeydown(vbKeyUp)
  End If
'  For Each ctl In Controls
'    ' Is the mouse over the control
'    If DebuggingFlag < 2 Then On Error Resume Next
'    bOver = (ctl.Visible And IsOver(ctl.hWnd, Xpos, Ypos))
'    On Error GoTo 0
'
'    If bOver Then
'      ' If so, respond accordingly
'      bHandled = True
'      Select Case True
'
''        Case TypeOf ctl Is MSFlexGrid
''          FlexGridScroll ctl, MouseKeys, Rotation, Xpos, Ypos
'
''        Case ctl = Form1.Picture7.hDC
''          PictureBox7Zoom ctl, MouseKeys, Rotation, Xpos, Ypos
'
'        Case TypeOf ctl Is PictureBox
'          PictureBoxZoom ctl, MouseKeys, Rotation, Xpos, Ypos
'
'        Case TypeOf ctl Is ListBox, TypeOf ctl Is TextBox, TypeOf ctl Is ComboBox
'          ' These controls already handle the mousewheel themselves, so allow them to:
'          If ctl.Enabled Then ctl.SetFocus
'
'        Case Else
'          bHandled = False
'
'      End Select
'      If bHandled Then Exit Sub
'    End If
'    bOver = False
'  Next ctl
  
End Sub
Private Sub AcceptAllMnu3_Click()
    Dim StartNextno As Long
    Form1.SSPanel1.Caption = "Finding acceptable sequences"
    Call UpdateF2Prog
    If DontSaveUndo = 0 Then
        Call SaveUndo
        DontSaveUndo = 1
    End If
    Call UnModNextno
    Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    Dim EN As Long
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    Dim tSelectNode(10) As Long
    For x = 0 To 10
        tSelectNode(x) = SelectNode(x)
    Next x
    IXOFlag = 1
    
    If SelectNode(4) = 0 Then
        StartNextno = NextNo
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) > 0 And x <= PermNextno Then
                    For Y = 1 To CurrentXOver(x)
                        If SuperEventList(XoverList(x, Y).Eventnumber) = EN Then
                            'If XOverList(TreeTrace(F2P2SNum), Y).Accept <> 1 Then
                            '    AcceptExMnu.Enabled = True
                            'Else
                            '    AcceptExMnu.Enabled = False
                            'End If
                            TRelX = x
                            TRelY = Y
                            RRelY = RelY
                            RRelX = RelX
                            'Exit For
                        End If
                    Next Y
                    F2P2SNum = x
                    Call AcceptExMnu_Click
                    For T = 0 To 10
                        SelectNode(T) = tSelectNode(T)
                    Next T
                End If
            End If
            SSX = Abs(GetTickCount)
            If Abs(SSX - lssx) > 500 Then
                lssx = SSX
                Form1.ProgressBar1.Value = (x / StartNextno) * 100
                UpdateF2Prog
            End If
        Next x
        
    Else
        Form2.Enabled = False
        Dim oXoMi As Long
        oXoMi = XOMiMaInFileFlag
        If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
            Screen.MousePointer = 11
            Form1.ProgressBar1 = 2
            Form1.SSPanel1.Caption = "Loading minor parent lists from disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
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
            Form1.ProgressBar1 = 20
            Form1.SSPanel1.Caption = "Loading major parent lists from disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            
            If MaRec < 1 Then
                Open "RDP5BestXOListMa" + UFTag For Binary As #FF
                Get #FF, , BestXOListMa()
                Close #FF
                MaRec = 1
            End If
            ChDrive oDirX
            ChDir oDirX
            
            Form1.ProgressBar1 = 40
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            
            
        End If
        XOMiMaInFileFlag = 0
        Call ModNextno
        StartNextno = NextNo
        For x = 0 To NextNo '10,153:10,107:10,82
            
            'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'selectnode=81And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                'XX = UBound(Daught, 1)
'                If TreeTrace(TreeTraceSeqs(1, X)) = 791 Then
'                    X = X
'                End If
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) > 0 Then '785,789,794,791,792,782,783,784
                    If TreeTrace(TreeTraceSeqs(1, x)) <= PermNextno Then
                        For Y = 1 To CurrentXOver(TreeTrace(TreeTraceSeqs(1, x)))
                            If SuperEventList(XoverList(TreeTrace(TreeTraceSeqs(1, x)), Y).Eventnumber) = EN Then
                                
                                TRelX = TreeTrace(TreeTraceSeqs(1, x)) '825,828
                                TRelY = Y
                                RRelY = RelY
                                RRelX = RelX
                                Exit For
                            End If
                        Next Y
                    End If
                    F2P2SNum = x
                    
                    'tSelectNode (0)
                    Call AcceptExMnu_Click
                    For T = 0 To 10
                        SelectNode(T) = tSelectNode(T)
                    Next T
                End If
            End If
            SSX = Abs(GetTickCount)
            If Abs(SSX - lssx) > 500 Then
                lssx = SSX
                Form1.ProgressBar1.Value = (x / StartNextno) * 100
                UpdateF2Prog
            End If
        Next x
        
        If oXoMi = 1 Then
            oDirX = CurDir
            ChDrive App.Path
            ChDir App.Path
            FF = FreeFile
            
            Form1.ProgressBar1 = 60
            Form1.SSPanel1.Caption = "Writing minor parent lists to disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            UBXOMi = UBound(BestXOListMi, 2)
            UBXoMa = UBound(BestXOListMa, 2)
            
            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
            Put #FF, , BestXOListMi()
            Close #FF
            MiRec = MiRec - 1
            
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            Form1.ProgressBar1 = 80
            Call UpdateF2Prog
            Form1.SSPanel1.Caption = "Writing major parent lists to disk"
            Form1.Refresh: Form2.Refresh
            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
            Put #FF, , BestXOListMa()
            Close #FF
            MaRec = MaRec - 1
            ChDrive oDirX
            ChDir oDirX
            Erase BestXOListMi
            Erase BestXOListMa
            Form1.ProgressBar1 = 100
            
            Form1.SSPanel1.Caption = ""
            
            Form1.ProgressBar1 = 0
            Form1.Refresh: Form2.Refresh
            Call UpdateF2Prog
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            Screen.MousePointer = 0
        End If
        XOMiMaInFileFlag = oXoMi
        Form2.Enabled = True
        
    End If
    UnModNextno
    
    
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call DoTreeColour(Form2.Picture2(0), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
        x = x
    Next x
    
'    For x = 0 To 3
'        If x = 1 Then
'            Call ModNextno
'        Else
'            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
'                Call UnModNextno
'            End If
'        End If
'
'        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
'    Next x
    UnModNextno
    Call IntegrateXOvers(0)
    If RIMode = 1 Then
        Call MakeSummary
        x = x
    End If
    IXOFlag = 0
    Form1.Timer1.Enabled = True
    DontSaveUndo = 0
    
End Sub

Private Sub AcceptEAxMnu_Click()

'SERecSeq = RelX
'SEPAVal = RelY
ARFlag = 2
Form1.Timer6.Enabled = True
End Sub

Private Sub AcceptExMnu_Click()
'SERecSeq = RelX
'SEPAVal = RelY

ARFlag = 1
Form1.Timer6.Interval = 1
Form1.Timer6.Enabled = True
ItsFinished = 1
Do
    DoEvents
    If ItsFinished = 2 Then Exit Do
Loop
ItsFinished = 0
If IXOFlag = 0 Then
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call DoTreeColour(Form2.Picture2(0), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
        x = x
    Next x

    Call IntegrateXOvers(0)
End If
Form1.Timer1.Enabled = True
End Sub

Private Sub aDaughtMnu_Click()
Dim BE As Long, EN As Long


OF2 = F2P2SNum
S1 = Seq1
s2 = Seq2
S3 = Seq3
BE = XoverList(RelX, RelY).Beginning
EN = XoverList(RelX, RelY).Ending
Dim UB As Long, XPD() As Long, XDP() As Long, x As Long

If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPosDiff)
    If UB > 0 Then
        ReDim XPD(UB)
        For x = 0 To UB
            XPD(x) = XPosDiff(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDiffPos)
    If UB > 0 Then
        ReDim XDP(UB)
        For x = 0 To UB
            XDP(x) = XDiffPos(x)
        Next x
    End If
On Error GoTo 0



If F2TreeIndex <> 2 And F2TreeIndex <> 1 Then
    
    Call ModSeqNum(BE, EN, 0)
    Call ModNextno
    For x = 0 To UBound(TreeTraceSeqs, 2)
        If F2P2SNum = TreeTrace(x) Then
            'X = X
            'XX = TreeTraceSeqs(0, F2P2SNum)
            If BE < EN Then
                For A = BE To EN
                    If SeqNum(A, x) > 50 Then
                        F2P2SNum = x
                        Exit For
                    End If
                Next A
            Else
                GoOn = 1
                For A = BE To Len(StrainSeq(0))
                    If SeqNum(A, x) > 50 Then
                        F2P2SNum = x
                        GoOn = 0
                        Exit For
                    End If
                Next A
                If GoOn = 1 Then
                    For A = 1 To EN
                        If SeqNum(A, x) > 50 Then
                            F2P2SNum = x
                            Exit For
                        End If
                    Next A
                End If
            End If
            
        End If
    Next x
    
End If

If F2P2SNum >= 0 Then 'And F2P2SNum <= NextNo Then
    
    Dim OS1 As Long, OS2 As Long, OS3 As Long
    
    'OS1 = Seq1
    'OS2 = Seq2
    OS3 = ISPerm(2)
    'Seq1 = ISPerm(0)
    'Seq2 = ISPerm(1)
    'Seq3 = ISPerm(2)
    'XX = MissingData(3000, 7)
    ISPerm(2) = F2P2SNum 'TreeTrace(TreeTraceSeqs(0, F2P2SNum)) 'TreeTrace(TreeTraceSeqs(1, X))
    Call RCheckWithOther(-1, Seq1, Seq2, F2P2SNum)
    
    'Form1.ZOrder
    Call CalcMatch(TreeTrace(), 1, SeqNum(), Seq3, OF2, Seq1, Seq2, BE, EN)
    ISPerm(2) = OS3
End If


If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPD)
    If UB > 0 Then
        ReDim XPosDiff(UB)
        For x = 0 To UB
            XPosDiff(x) = XPD(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDP)
    If UB > 0 Then
        ReDim XDiffPos(UB)
        For x = 0 To UB
             XDiffPos(x) = XDP(x)
        Next x
    End If
On Error GoTo 0



SpacerNo = 1
AllowExtraSeqsFlag = 1
ReDim SpacerSeqs(NextNo)
SpacerSeqs(1) = TreeTrace(OF2)
'XOverSeq(3) = StrainSeq(TreeTrace(OF2))
If ShowSeqFlag > 0 Then
    DontDoH1Inc = 1
    If Form1.HScroll1.Max > 0 Then
        If Form1.HScroll1.Value > Form1.HScroll1.Min Then
            H1C = 1
            Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            H1C = 0
            Form1.HScroll1.Value = Form1.HScroll1.Value + 1
        Else
            If Form1.HScroll1.Value < Form1.HScroll1.Max Then
                H1C = 1
                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
                H1C = 0
                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            End If
        End If
    End If
   
    If Form1.VScroll3.Value > 0 Then
        Form1.VScroll3.Value = 0
    End If
    DontDoH1Inc = 0
    Call PrintNames3(Form1.Picture3, XoverList(RelX, RelY).ProgramFlag, NextNo, RevSeq(), OriginalName(OF2))
End If
H1C = 0

XX = PermNextno
x = x
End Sub

Private Sub aMajParMnu_Click()

Dim UB As Long, XPD() As Long, XDP() As Long, x As Long

If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPosDiff)
    If UB > 0 Then
        ReDim XPD(UB)
        For x = 0 To UB
            XPD(x) = XPosDiff(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDiffPos)
    If UB > 0 Then
        ReDim XDP(UB)
        For x = 0 To UB
            XDP(x) = XDiffPos(x)
        Next x
    End If
On Error GoTo 0

OF2 = F2P2SNum
If F2P2SNum >= 0 Then 'And F2P2SNum <= NextNo Then
    Dim OS1 As Long, OS2 As Long, OS3 As Long
    
    OS1 = ISPerm(0) 'Seq1
    'OS2 = Seq2
    'OS3 = Seq3
    'Seq1 = ISPerm(0)
    'Seq2 = ISPerm(1)
    'Seq3 = ISPerm(2)
    ISPerm(0) = F2P2SNum
    Call RCheckWithOther(-1, F2P2SNum, Seq2, Seq3)
    If AllCheckFlag = 0 Then
        Call CalcMatch(TreeTrace(), 1, SeqNum(), Seq1, OF2, Seq2, Seq3, XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
    End If
    ISPerm(0) = OS1
    'Seq2 = OS2
    'Seq3 = OS3
    
    'Form1.ZOrder
End If
If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPD)
    If UB > 0 Then
        ReDim XPosDiff(UB)
        For x = 0 To UB
            XPosDiff(x) = XPD(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDP)
    If UB > 0 Then
        ReDim XDiffPos(UB)
        For x = 0 To UB
             XDiffPos(x) = XDP(x)
        Next x
    End If
On Error GoTo 0



SpacerNo = 1
AllowExtraSeqsFlag = 1
ReDim SpacerSeqs(NextNo)
SpacerSeqs(1) = TreeTrace(OF2)
'XOverSeq(3) = StrainSeq(TreeTrace(OF2))
If ShowSeqFlag > 0 Then
    DontDoH1Inc = 1
    If Form1.HScroll1.Max > 0 Then
        If Form1.HScroll1.Value > Form1.HScroll1.Min Then
            H1C = 1
            Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            H1C = 0
            Form1.HScroll1.Value = Form1.HScroll1.Value + 1
        Else
            If Form1.HScroll1.Value < Form1.HScroll1.Max Then
                H1C = 1
                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
                H1C = 0
                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            End If
        End If
    End If
   
    If Form1.VScroll3.Value > 0 Then
        Form1.VScroll3.Value = 0
    End If
    DontDoH1Inc = 0
    Call PrintNames3(Form1.Picture3, XoverList(RelX, RelY).ProgramFlag, NextNo, RevSeq(), OriginalName(OF2))
End If
H1C = 0
End Sub

Private Sub aMinParMnu_Click()
Dim UB As Long, XPD() As Long, XDP() As Long, x As Long

If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPosDiff)
    If UB > 0 Then
        ReDim XPD(UB)
        For x = 0 To UB
            XPD(x) = XPosDiff(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDiffPos)
    If UB > 0 Then
        ReDim XDP(UB)
        For x = 0 To UB
            XDP(x) = XDiffPos(x)
        Next x
    End If
On Error GoTo 0

OF2 = F2P2SNum
If F2P2SNum >= 0 Then 'And F2P2SNum <= NextNo Then
    Dim OS1 As Long, OS2 As Long, OS3 As Long
    
    'OS1 = Seq1
    OS2 = ISPerm(1) 'Seq2
    'OS3 = Seq3
    'Seq1 = ISPerm(0)
    'Seq2 = ISPerm(1)
    'Seq3 = ISPerm(2)
    ISPerm(1) = F2P2SNum
    Call RCheckWithOther(-1, Seq1, F2P2SNum, Seq3)
    If AllCheckFlag = 0 Then
        Call CalcMatch(TreeTrace(), 1, SeqNum(), Seq2, OF2, Seq1, Seq3, XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
    End If
    ISPerm(1) = OS2 'Seq1 = OS1
    'Seq2 = OS2
    'Seq3 = OS3
    'Form1.ZOrder
End If
If DebuggingFlag < 2 Then On Error Resume Next
    UB = -1
    UB = UBound(XPD)
    If UB > 0 Then
        ReDim XPosDiff(UB)
        For x = 0 To UB
            XPosDiff(x) = XPD(x)
        Next x
    End If
    UB = -1
    UB = UBound(XDP)
    If UB > 0 Then
        ReDim XDiffPos(UB)
        For x = 0 To UB
             XDiffPos(x) = XDP(x)
        Next x
    End If
On Error GoTo 0



SpacerNo = 1
AllowExtraSeqsFlag = 1
ReDim SpacerSeqs(NextNo)
SpacerSeqs(1) = TreeTrace(OF2)
'XOverSeq(3) = StrainSeq(TreeTrace(OF2))
If ShowSeqFlag > 0 Then
    DontDoH1Inc = 1
    If Form1.HScroll1.Max > 0 Then
        If Form1.HScroll1.Value > Form1.HScroll1.Min Then
            H1C = 1
            Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            H1C = 0
            Form1.HScroll1.Value = Form1.HScroll1.Value + 1
        Else
            If Form1.HScroll1.Value < Form1.HScroll1.Max Then
                H1C = 1
                Form1.HScroll1.Value = Form1.HScroll1.Value + 1
                H1C = 0
                Form1.HScroll1.Value = Form1.HScroll1.Value - 1
            End If
        End If
    End If
   
    If Form1.VScroll3.Value > 0 Then
        Form1.VScroll3.Value = 0
    End If
    DontDoH1Inc = 0
    Call PrintNames3(Form1.Picture3, XoverList(RelX, RelY).ProgramFlag, NextNo, RevSeq(), OriginalName(OF2))
End If
H1C = 0
End Sub

Private Sub AncSeqMnu_Click()
Call MakeAncMod
End Sub

Private Sub AutoColMnu_Click()

    For x = 0 To NextNo
        MultColour(x) = SeqCol(x)
    Next x
    
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
                        
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    UnModNextno
    x = x
End Sub

Private Sub BlueMnu_Click()
SelCol = RGB(128, 128, 255)
End Sub

Private Sub BTMnu2_Click()
Dim TD() As Double, TTDistance() As Single, tAVDST As Double



'
If F2TreeIndex = 3 Then
    
    Call DrawML5(Form2.Picture2(3), 4)
    'Call PADREML("", 0)
Else
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Calculating Tree Dimensions"
    Form1.ProgressBar1.Value = 5
    Call UpdateF2Prog
    LenStrainSeq = Len(StrainSeq(0)) + 1
    Call ModNextno
    ReDim TTDistance(NextNo, NextNo)
    If F2TreeIndex <> 0 Then
    'Call ModSeqNum(0)
        Call ModNextno
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, TreeSeqNum(0, 0), TTDistance(0, 0), tAVDST)
        
    
    
    Else
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, SeqNum(0, 0), TTDistance(0, 0), tAVDST)

    End If
    

    

    For x = 0 To NextNo

        For Y = x + 1 To NextNo

            If ((1 - TTDistance(x, Y)) / 0.75) < 1 Then

                If 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75)))) > 0 Then
                    TTDistance(x, Y) = 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75))))
                Else
                    TTDistance(x, Y) = 0
                End If

            Else
                TTDistance(x, Y) = 0
            End If

            TTDistance(Y, x) = TTDistance(x, Y)
        Next 'Y

    Next 'X

    ReDim TempSeq(NextNo + 2)
    If F2TreeIndex = 0 Then
        For x = 0 To NextNo
    
           
                TempSeq(x) = StrainSeq(x)
            
    
        Next 'X
    Else
        Dim tStrainseq() As String
        ReDim tStrainseq(NextNo)
        For x = 0 To NextNo
            For Y = 1 To Len(StrainSeq(0))
                tStrainseq(x) = tStrainseq(x) + Chr(TreeSeqNum(Y, x) - 1)
            
            Next Y
        Next x
        
        For x = 0 To NextNo
            If F2TreeIndex = 2 Then
                BTree = XoverList(RelX, RelY).Beginning
                ETree = XoverList(RelX, RelY).Ending
            Else
                ETree = XoverList(RelX, RelY).Beginning - 1
                BTree = XoverList(RelX, RelY).Ending + 1
            End If
            If BTree < ETree Then
                TempSeq(x) = Mid$(tStrainseq(x), BTree, ETree - BTree)
            Else
                TempSeq(x) = Mid$(tStrainseq(x), BTree, Len(StrainSeq(0)) - BTree)
                TempSeq(x) = TempSeq(x) + Mid$(tStrainseq(x), 1, ETree)
            End If
        Next x
    End If

    ReDim TD(NextNo)

    For x = 0 To NextNo

        For Y = 0 To NextNo
            TD(x) = TD(x) + TTDistance(x, Y)
        Next 'Y

    Next 'X

    MD = NextNo

    For x = 0 To NextNo

        If TD(x) < MD Then
            MD = TD(x)
            Outie = x
        End If

    Next 'X

    Dim OCurTree As Integer

    OCurTree = CurTree(F2TreeIndex)
    CurTree(F2TreeIndex) = 4

    If F2TreeIndex = 0 And DoneTree(4, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 2 And DoneTree(4, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 1 And DoneTree(4, F2TreeIndex) = 1 Then
    Else

        Call Deactivate
        Call NJTree2(4)
        Call Reactivate

        If AbortFlag = 1 Then
            Form1.ProgressBar1.Value = 0
            Form1.SSPanel1.Caption = ""
            Call UpdateF2Prog
            If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
                Call UnModNextno
                Call UnModSeqNum(0)
            End If
            Screen.MousePointer = 0
            AbortFlag = 0
            Form2.Command2.Enabled = False
            CurTree(F2TreeIndex) = OCurTree
            Exit Sub
        End If
        ExtraDX = DoTreeColour(Picture2(F2TreeIndex), 4, F2TreeIndex)
        'DoTreeLegend treeblocksl(), TBLLen, Picture2(F2TreeIndex), ExtraDx, 14
    End If
    Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(F2TreeIndex).Value, F2TreeIndex, 4, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(F2TreeIndex))
    For x = 0 To 4
        TTFlag(F2TreeIndex, x) = 0
    Next 'X

    TTFlag(F2TreeIndex, 4) = 1
    Form1.ProgressBar1.Value = 100
    Call UpdateF2Prog
    If F2TreeIndex = 0 Then
        Label1(0).Caption = "Bayesian tree ignoring recombination"
    ElseIf F2TreeIndex = 2 Then
        'Label1(2).Caption = "Bayesian tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Form2.Label1(2) = "MCC tree of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Form2.Label1(2) = "MCC tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    
    ElseIf F2TreeIndex = 1 Then
        'Label1(2).Caption = "Bayesian tree of region derived from minor parent ( " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form2.Label1(1) = "Bayesian tree of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form2.Label1(1) = "MCC tree of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form2.Label1(1) = "MCC tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If
    End If
    Screen.MousePointer = 0
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
    If F2TreeIndex <> 0 Then UnModNextno
    x = x
End If

End Sub

Private Sub ClearColMnu_Click()
    
    If NextNo >= PermNextno Then
    ReDim Preserve MultColour(NextNo)
    End If
    
    
    For x = 0 To NextNo
        MultColour(x) = 0
    Next x
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
                        
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    UnModNextno
    x = x
End Sub

Private Sub Command1_Click(Index As Integer)
    

    Command3.SetFocus

    If Index = 0 Then
        SSPanel1(0).ZOrder
    ElseIf Index = 3 Then
        SSPanel1(1).ZOrder
    ElseIf Index = 1 Then
        
        
        If CurTree(3) = 0 Then
            Command1(Index).Enabled = False
            If TreeImage(3) = 0 Then
                CurTree(3) = 0
                F2TreeIndex = 3
                Call UPGMAMnu2_Click
                'DrawUPGMA5
            Else
                
            End If
        ElseIf CurTree(3) = 1 Then
            'Call DrawUPGMA5
            Command1(Index).Enabled = False
            'Call DrawFastNJ5(Form2.Picture2(3))
            Call DrawML7(Form2.Picture2(3))
        ElseIf CurTree(3) = 3 Or CurTree(3) = 2 Then
            Command1(Index).Enabled = False
            Call DrawML5(Form2.Picture2(3), 5)
        ElseIf CurTree(3) = 4 Then
            Command1(Index).Enabled = False
            Call DrawML5(Form2.Picture2(3), 4)
        ElseIf CurTree(3) = 2 Then
            Command1(Index).Enabled = False
            Call DrawML5(Form2.Picture2(3), 5)
        End If
        SSPanel1(3).ZOrder
    Else

        'If XOverList(RelX, RelY).ProgramFlag = 0 Or XOverList(RelX, RelY).ProgramFlag - AddNum = 0 Then
        '    SSPanel1(1).ZOrder
        'Else
            SSPanel1(2).ZOrder
        'End If

    End If
Command1(Index).Enabled = True
End Sub

Private Sub Command1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command1_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
If Index = 0 Then
    Command1(Index).ToolTipText = "Press to see " + Label1(0).Caption
ElseIf Index = 3 Then
    Command1(Index).ToolTipText = "Press to see " + Label1(1).Caption
ElseIf Index = 1 Then
    If Label1(3).Caption <> "Label1" Then
        Command1(Index).ToolTipText = "Press to see " + Label1(3).Caption
    Else
        Command1(Index).ToolTipText = "Press to see FastNJ tree of non-recombinant regions"
    End If
ElseIf Index = 2 Then
    Command1(Index).ToolTipText = "Press to see " + Label1(2).Caption
End If
End Sub

Private Sub Command2_Click()
    Command3.SetFocus
    AbortFlag = 1
End Sub

Private Sub Command2_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command2_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
F2P2Y = -1
F1P2Y = -1
F1P3Y = -1
F1P6Y = -1
F2P3Y = -1
F1P16Y = -1
F1P26Y = -1
F2P2Index = -1
End Sub

Private Sub Command3_KeyDown(KeyCode As Integer, Shift As Integer)
Call DoKeydown(KeyCode)
If RIMode = 1 Then
    If KeyCode = vbKeyPageUp Or KeyCode = vbKeyLeft Then
        Call Command8_Click
        KPFlag = 1
    ElseIf KeyCode = vbKeyPageDown Or KeyCode = vbKeyRight Then
        Call Command9_Click
        KPFlag = 1
    
    End If
End If
End Sub

Private Sub Command3_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command3_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If


End Sub

Private Sub Command4_Click()
Dim OM As Long, TS(3) As Double, OV As Long, tTYF As Double, OFS As Double, otTYF As Double, TYFM As Integer
       'zoom in
        Form1.Enabled = False
        If (CLine = "" Or CLine = " ") Then
            Command3.SetFocus
        End If
        
        Call TreeZoom(1) '1=in 0=0ut
End Sub

Private Sub Command4_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command4_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Command4.MousePointer = 99
F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
End Sub

Private Sub Command5_Click()
Dim OM As Long, TS(3) As Double, OV As Long, tTYF As Double, OFS As Double, otTYF As Double, TYFM As Integer, OFS2 As Single
        'zoom out
        Form1.Enabled = False
        If (CLine = "" Or CLine = " ") Then
            Command3.SetFocus
        End If
        
        Call TreeZoom(0)
        F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
End Sub

Private Sub Command5_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command5_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Command5.MousePointer = 99
End Sub



Private Sub Command6_Click(Index As Integer)
If CurrentlyRunningFlag = 1 Then
        Exit Sub
    End If
    
    For x = 0 To 3
        Picture2(x).Enabled = False
    Next x
Dim OutString As String, TempSeq() As String, Boots() As String, LnL() As Double, TDS As String, TDD As String, PhyMLFlag As Byte, FNum As Byte
    Command3.SetFocus
    oDir = CurDir
    ChDir App.Path
    ChDrive App.Path
    
    Command3.SetFocus
    Call ModNextno
    
    If DebuggingFlag < 2 Then On Error Resume Next
    FNum = FreeFile
    Open "dnadist.bat" For Output As #FNum
    OutString = ""
    PhyMLFlag = 2
    
    
    If PhyMLFlag = 1 Then 'use phyml - unfortunately its not working with the beta build
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
         
         
         
         Print #FNum, OutString
         
         Close #FNum
         On Error GoTo 0
    ElseIf PhyMLFlag = 2 Then 'use raxml instead of phyml
        Dim SysInfo As SYSTEM_INFO
                
        GetSystemInfo SysInfo
        
        
        Print #FNum, "del RAxML_info.treefile"
        Print #FNum, "del RAxML_parsimonyTree.treefile"
        Print #FNum, "del RAxML_log.treefile"
        Print #FNum, "del RAxML_result.treefile"
        Print #FNum, "del RAxML_bestTree.treefile"
        Print #FNum, "del RAxML_bootstrap.treefile"
        Print #FNum, "del RAxML_perSiteLLs.treefile"
        
        
        Print #FNum, "del RAxML_perSiteLLs.treefile"
        Dim NumProc As Long
        NumProc = SysInfo.dwNumberOrfProcessors
        If NumProc > 4 Then NumProc = 4
        
        If NumProc > 2 And x = 12345 Then 'for some reason pthreads crashes/does not give a tree
            OutString = "raxmlHPC-PTHREADS -s infile -p 1234 -f g -z intree -n treefile -m GTRCAT -T " + Trim(Str(NumProc - 1))
        Else
            OutString = "raxmlHPC -s infile -p 1234 -n treefile -f g -z intree -m GTRGAMMA"
        End If
        XX = TPGamma
        'utstring = "raxmlHPC -s infile -n treefile -m GTRGAMMA -f g -z intree"
        'If RAxMLCats <> 25 Or X = X Then
        '    Outstring = Outstring + " - c " + Trim(Str(RAxMLCats))
        'End If
        
        ' BS reps
        
        
        Print #FNum, OutString
        
        BatIndex = 53
         
        Close #FNum
    ElseIf PhyMLFlag = 3 Then 'use fasttree
        'Dim SysInfo As SYSTEM_INFO
        
        'Outstring = "raxmlHPC -s infile -p 1234 -n treefile -m GTRGAMMA -f g -z intree"
        OutString = "FastTree -gtr -nt -nosupport -gamma infile > treefile" '
        Print #FNum, OutString
        PrF = 7
         
        Close #FNum
    End If
    On Error GoTo 0
    ReDim TempSeq(NextNo)
    
    'make tempseq
    Dim tStrainseq() As String
    ReDim tStrainseq(NextNo)
    For x = 0 To NextNo
        tStrainseq(x) = String(Len(StrainSeq(0)), " ")
    
    Next x
    For x = 0 To NextNo
        For Y = 1 To Len(StrainSeq(0))
            Mid(tStrainseq(x), Y, 1) = Chr(TreeSeqNum(Y, x) - 1)
        
        Next Y
    Next x
    For Z = 0 To 1
        Form1.ProgressBar1 = Z * 50
        Call UpdateF2Prog
        If UBound(TempSeq, 1) < NextNo Then
            ReDim Preserve TempSeq(NextNo)
            ReDim Preserve tStrainseq(NextNo)
        End If
        For x = 0 To NextNo
            If Z = 0 Then
                BTree = XoverList(RelX, RelY).Beginning
                ETree = XoverList(RelX, RelY).Ending
            Else
                ETree = XoverList(RelX, RelY).Beginning - 1
                BTree = XoverList(RelX, RelY).Ending + 1
            End If
            If BTree < ETree Then
                TempSeq(x) = Mid$(tStrainseq(x), BTree, ETree - BTree)
            Else
                If BTree < Len(StrainSeq(0)) Then
                    TempSeq(x) = Mid$(tStrainseq(x), BTree, Len(StrainSeq(0)) - BTree)
                End If
                TempSeq(x) = TempSeq(x) + Mid$(tStrainseq(x), 1, ETree)
            End If
        Next x
        TDD = Trim(Str(BTree)) + " - " + Trim(Str(ETree))
        ReDim LnL(1, Len(TempSeq(0)))
        FNum = FreeFile
        'make infile
        Open "infile" For Output As #FNum
        
        If PhyMLFlag = 3 Then
            For x = 0 To NextNo
                Print #FNum, ">" + Trim$(CStr(x))
                Print #FNum, TempSeq(x)
            Next 'X
        Else
            Header = " " + Trim$(CStr((NextNo + 1))) + "   " + Trim$(CStr(Len(TempSeq(0))))
            Print #FNum, Header
            BatIndex = 7
            NLen = Len(Trim(Str(NextNo)))
            If NLen = 1 Then NLen = 2
        
        
            ReDim Boots(NextNo)
            For x = 0 To NextNo
                
                TName = Trim$(CStr(x))
                TName = String(NLen - Len(TName), "0") & TName
                TName = "S" & TName
                BootName = TName
                BootName = BootName + String$(10 - (Len(BootName)), " ")
                TString = TempSeq(x)
                Boots(x) = BootName + TString
                Print #FNum, Boots(x)
            Next 'X
        End If
        Close #FNum
        'make intree
        If DebuggingFlag < 2 Then On Error Resume Next
        KillFile "intree"
        On Error GoTo 0
        If CurTree(1) = 0 Then
            Call ReplaceNamesB(NextNo, NHComp(0))
        End If
        
        If CurTree(2) = 0 Then
            Call ReplaceNamesB(NextNo, NHComp(1))
        End If
        Dim Crap As String, TS As String
        Dim TotLnL(1) As Double
        
        
        
        If PhyMLFlag = 1 Then
            For Y = 0 To 1
                If Y = 0 Then
                    TDS = Trim(Str(BTree)) + " - " + Trim(Str(ETree))
                Else
                    TDS = Trim(Str(ETree + 1)) + " - " + Trim(Str(BTree - 1))
                End If
                FNum = FreeFile
                Open "intree" For Output As #FNum
                Print #FNum, NHComp(Y)
                Close #FNum
                Form1.SSPanel1.Caption = "Optimising branch lengths for tree " + TDS + " given sequences " + TDD
                Form1.ProgressBar1 = Z * 50 + Y * 12
                Call UpdateF2Prog
                
                Call ShellAndClose("dnadist.bat", 0)
                If PhyMLFlag = 1 Then
                    
                    
                    
                    If DebuggingFlag < 2 Then On Error Resume Next
                    KillFile "treefile"
                    Name "infile_phyml_tree.txt" As "treefile"
                    On Error GoTo 0
                    
                    If DebuggingFlag < 2 Then On Error Resume Next
                    FLX = 0
                    FLX = FileLen("infile_phyml_lk.txt")
                    On Error GoTo 0
                    If FLX = 0 Then
                        Response = MsgBox("Phyml (a program used to do the SH and AU tests) has crashed and I am therefore unable to test how different these two trees are")
                        Form1.SSPanel1.Caption = ""
                        Form1.ProgressBar1 = 0
                        Call UpdateF2Prog
                        Exit Sub
                    End If
                    FNum = FreeFile
                    
                    Open "infile_phyml_lk.txt" For Input As #FNum
                    Do
                        Line Input #FNum, Crap
                        If Left$(Crap, 4) = "Site" Then Exit Do
                    Loop
                    For x = 1 To Len(TempSeq(0))
                        Line Input #FNum, Crap
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
                    Close #FNum
                Else
                    If DebuggingFlag < 2 Then On Error Resume Next
                    KillFile "treefile"
                    KillFile "infile"
                    Name "RAxML_bestTree.treefile" As "treefile"
                    Name "RAxML_perSiteLLs.treefile" As "infile.sitelh."
                    On Error GoTo 0
                    If DebuggingFlag < 2 Then On Error Resume Next
                    FLX = 0
                    FLX = FileLen("infile")
                    On Error GoTo 0
                    If FLX = 0 Then
                        Response = MsgBox("RAxML (a program used to do the SH and AU tests) has crashed and I am therefore unable to test how different these two trees are")
                        Form1.SSPanel1.Caption = ""
                        Form1.ProgressBar1 = 0
                        Call UpdateF2Prog
                        Exit Sub
                    End If
                    Name "infile" As "infile" + Trim(Str(Y))
                End If
                
                
                x = x
            Next Y
        
            If DebuggingFlag < 2 Then On Error Resume Next
            KillFile "infile.txt"
            On Error GoTo 0
            FNum = FreeFile
            Open "infile.txt" For Output As #FNum
            OutString = ""
            OutString = "Tree" + Chr(9) + "-lnL" + Chr(9) + "Site" + Chr(9) + "-lnL"
            Print #FNum, OutString
            For Y = 0 To 1
                OutString = Trim(Str(Y + 1)) + Chr(9) + TotLnL(Y)
                Print #FNum, OutString
                For x = 1 To Len(TempSeq(0))
                    OutString = Chr(9) + Chr(9) + Trim(Str(x)) + Chr(9) + Trim(Str(LnL(Y, x)))
                    Print #FNum, OutString
                Next x
            Next Y
                
            Close #FNum
        ElseIf PhyMLFlag = 2 Then
           BatIndex = 53
           If DebuggingFlag < 2 Then On Error Resume Next
            KillFile "infile.sitelh"
           On Error GoTo 0
           FNum = FreeFile
           Open "intree" For Output As #FNum
            Print #FNum, NHComp(0)
            Print #FNum, NHComp(1)
            Close #FNum
            Form1.SSPanel1.Caption = "Finding ML branch lengths"
            Form1.ProgressBar1 = Z * 50 + 12
            Call UpdateF2Prog
            XX = CurDir
            Call ShellAndClose("dnadist.bat", 0)
            
            If DebuggingFlag < 2 Then On Error Resume Next
            
            KillFile "infile"
            KillFile "infile.sitelh."
            If Dir("RAxML_bestTree.treefile") <> "" Then
                KillFile "treefile"
                Name "RAxML_bestTree.treefile" As "treefile"
            End If
            
            Name "RAxML_perSiteLLs.treefile" As "infile.sitelh."
            On Error GoTo 0
           
            'Exit Sub
            x = x
        ElseIf PhyMLFlag = 3 Then
        
        End If
        Form1.SSPanel1.Caption = "Making 100000 bootstrap replicates of likelihoods at sites " + TDD
        
        Form1.ProgressBar1 = Z * 50 + 25
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then On Error Resume Next
        FLX = 0
        FLX = FileLen("infile.sitelh.")
        On Error GoTo 0
        If FLX > 0 Then
        
        
            If PhyMLFlag = 1 Then
                Call ShellAndClose("makermt --paup infile", 0)
            ElseIf PhyMLFlag = 2 Then
            
                Call ShellAndClose("makermt --puzzle infile", 0)
            ElseIf PhyMLFlag = 3 Then
            
            End If
            
            Form1.ProgressBar1 = Z * 50 + 37
            Call UpdateF2Prog
            
            Call ShellAndClose("consel infile", 0)
            
            Form1.ProgressBar1 = Z * 50 + 50
            Call UpdateF2Prog
            
            If DebuggingFlag < 2 Then On Error Resume Next
            FLX = 0
            FLX = FileLen("infile.pv")
            On Error GoTo 0
            If FLX = 0 Then
                Response = MsgBox("Either RAxML or Consel (the programs used to do the SH and AU tests) has crashed and I am therefore unable to test how different these two trees are")
                Form1.SSPanel1.Caption = ""
                Form1.ProgressBar1 = 0
                Call UpdateF2Prog
                Exit Sub
            End If
            
            'Call ShellAndClose("catpv infile", 1)
            FNum = FreeFile
            Open "infile.pv" For Input As #FNum
            'Exit Sub
            Do
                Line Input #FNum, Crap
                If Left$(Crap, 8) = "# row: 0" Then Exit Do
                
            Loop
            Dim CE As Long
            CE = SuperEventList(XoverList(RelX, RelY).Eventnumber)
            If Z = 0 Then 'results using the sequences between the breakpoints
                Input #FNum, TopolTests(0, 0) 'BP
                Input #FNum, TopolTests(0, 1) 'pp
                Input #FNum, TopolTests(0, 2) 'kh
                Input #FNum, TopolTests(0, 3) 'SH
                Input #FNum, TopolTests(0, 4) 'wkh
                Input #FNum, TopolTests(0, 5) 'wsh
                Input #FNum, TopolTests(0, 6) 'au
                Input #FNum, TopolTests(0, 7) 'NP
                Line Input #FNum, Crap
                Line Input #FNum, Crap
                Input #FNum, TopolTests(1, 0) 'BP
                Input #FNum, TopolTests(1, 1) 'pp
                Input #FNum, TopolTests(1, 2) 'kh
                Input #FNum, TopolTests(1, 3) 'SH
                Input #FNum, TopolTests(1, 4) 'wkh
                Input #FNum, TopolTests(1, 5) 'wsh
                Input #FNum, TopolTests(1, 6) 'au
                Input #FNum, TopolTests(1, 7) 'NP
                
                If TopolTests(1, 3) = 0 Then
                    Crap = "<0.0001"
                    TopolTests(1, 3) = 0.00001
                Else
                    Crap = Trim(Str(TopolTests(1, 3)))
                    If Left(Crap, 1) = "." Then Crap = "0" + Crap
                End If
                Form2.Label3(1) = "Shimodaira-Hasegawa p-value: " + Crap
                
                If TopolTests(1, 6) = 0 Then
                    Crap = "<0.0001"
                    TopolTests(1, 6) = 0.00001
                Else
                    Crap = Trim(Str(TopolTests(1, 6)))
                    If Left(Crap, 1) = "." Then Crap = "0" + Crap
                End If
                
                Form2.Label4(1) = "Approximately unbiased p-value: " + Crap
                If TreeTestStats(0, CE) <= 0 Or TreeTestStats(0, CE) > TopolTests(1, 3) Then
                    TreeTestStats(0, CE) = TopolTests(1, 3)
                End If
                If TreeTestStats(1, CE) <= 0 Or TreeTestStats(1, CE) > TopolTests(1, 6) Then
                    TreeTestStats(1, CE) = TopolTests(1, 6)
                End If
                
            Else
                Input #FNum, TopolTests(2, 0) 'BP
                Input #FNum, TopolTests(2, 1) 'pp
                Input #FNum, TopolTests(2, 2) 'kh
                Input #FNum, TopolTests(2, 3) 'SH
                Input #FNum, TopolTests(2, 4) 'wkh
                Input #FNum, TopolTests(2, 5) 'wsh
                Input #FNum, TopolTests(2, 6) 'au
                Input #FNum, TopolTests(2, 7) 'NP
                Line Input #FNum, Crap
                Line Input #FNum, Crap
                Input #FNum, TopolTests(3, 0) 'BP
                Input #FNum, TopolTests(3, 1) 'pp
                Input #FNum, TopolTests(3, 2) 'kh
                Input #FNum, TopolTests(3, 3) 'SH
                Input #FNum, TopolTests(3, 4) 'wkh
                Input #FNum, TopolTests(3, 5) 'wsh
                Input #FNum, TopolTests(3, 6) 'au
                Input #FNum, TopolTests(3, 7) 'NP
                If TopolTests(3, 3) = 0 Then
                    Crap = "<0.0001"
                    TopolTests(3, 3) = 0.00001
                Else
                    Crap = Trim(Str(TopolTests(3, 3)))
                    If Left(Crap, 1) = "." Then Crap = "0" + Crap
                End If
                Form2.Label3(0) = "Shimodaira-Hasegawa p-value: " + Crap
                If TopolTests(3, 6) = 0 Then
                    Crap = "<0.0001"
                    TopolTests(3, 6) = 0.00001
                Else
                    Crap = Trim(Str(TopolTests(3, 6)))
                    If Left(Crap, 1) = "." Then Crap = "0" + Crap
                End If
                Form2.Label4(0) = "Approximately unbiased p-value: " + Crap
                If TreeTestStats(2, CE) <= 0 Or TreeTestStats(2, CE) > TopolTests(3, 3) Then
                    TreeTestStats(2, CE) = TopolTests(3, 3)
                End If
                If TreeTestStats(3, CE) <= 0 Or TreeTestStats(3, CE) > TopolTests(3, 6) Then
                    TreeTestStats(3, CE) = TopolTests(3, 6)
                End If
                
            End If
        
            Close #FNum
        Else
            MsgBox ("RAxML experienced a problem optimising the branch lengths of the trees - I'll therefore be unable to do this test with these specific trees.  The test may, however, work if you change one or both trees from, for example, a UPGMA to a neighbour joining tree")
            Form1.SSPanel1.Caption = ""
            Form1.ProgressBar1 = 0
            Call UpdateF2Prog
            For x = 0 To 3
                Picture2(x).Enabled = True
            Next x
            Exit Sub
        End If
    Next Z
    Call UnModNextno
    
    If DebuggingFlag < 2 Then On Error Resume Next
    KillFile "infile.txt"
    KillFile "infile.rmt"
    KillFile "infile.pv"
    KillFile "infile.vt"
    On Error GoTo 0
    For x = 0 To 3
        Picture2(x).Enabled = True
    Next x
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    ChDir oDir
    ChDrive oDir
End Sub

Private Sub Command6_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command7_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command8_Click()
F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
If (CLine = "" Or CLine = " ") Then
    If Command3.Enabled = True Then
    Command3.SetFocus
    End If
End If
'F2ontop = 0 'this will keep form2ontop
'Command9.Enabled = False
'Command8.Enabled = False

Form2.Enabled = False
'If FastNJFlag = 1 Then
'    Form2.Command8.Enabled = False
'    Form2.Command9.Enabled = False
'    Form1.Command5.Enabled = False
'    Form1.Command9.Enabled = False
'End If
    
F2C8Press = 1
Call GotoPrev
F2C8Press = 0
Form2.Enabled = True
'If FastNJFlag = 1 Then
'   Form2.Command8.Enabled = True
'   Form2.Command9.Enabled = True
'   Form1.Command5.Enabled = True
'    Form1.Command9.Enabled = True
'End If

Form1.ProgressBar1 = 0
Form2.ProgressBar1 = 0
Call UpdateF2Prog
If (CLine = "" Or CLine = " ") Then
    Command3.SetFocus
End If


End Sub

Private Sub Command8_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Command9_Click()

F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
If (CLine = "" Or CLine = " ") Then
    Command3.SetFocus
End If 'this will keep form2ontop

Form2.Enabled = False
'If FastNJFlag = 1 Then
'    Form2.Command8.Enabled = False
'    Form2.Command9.Enabled = False
'    Form1.Command5.Enabled = False
'    Form1.Command9.Enabled = False
'End If
    
F2C8Press = 1
Call GotoNxt
F2C8Press = 0
Form2.Enabled = True
'If FastNJFlag = 1 Then
'   Form2.Command8.Enabled = True
'   Form2.Command9.Enabled = True
'   Form1.Command5.Enabled = True
'    Form1.Command9.Enabled = True
'End If

Form1.ProgressBar1 = 0
Form2.ProgressBar1 = 0
Call UpdateF2Prog
If (CLine = "" Or CLine = " ") Then
    Command3.SetFocus
End If 'this will keep form2ontop
End Sub

Private Sub Command9_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub CpyMnu_Click()
    Dim NHFlag As Integer
    If DebuggingFlag < 2 Then On Error Resume Next
    KillFile "tmp.emf"
    On Error GoTo 0
    EMFFName = "tmp.emf" 'Stores selected file name in the
    semfnameII = "tmp.emf"
    Call GetNHFlag(F2TreeIndex, CurTree(F2TreeIndex), NHFlag)
    
    Call NJEMF(NHFlag)

        

    

    Clipboard.Clear
    If DebuggingFlag < 2 Then On Error Resume Next
    Clipboard.SetData LoadPicture("tmp.emf"), 3
    
    KillFile "tmp.emf"
    On Error GoTo 0
End Sub

Private Sub FindBestMajParMnu_Click()
    Dim EN As Long
    UpdateProgressBar = 1
    For x = 0 To 3
        Picture2(x).Enabled = False
    Next x
    Seq3 = XoverList(RelX, RelY).Daughter
    Seq2 = XoverList(RelX, RelY).MinorP
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Finding best candidate major parent"
    Form1.Refresh
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    Form2.SSPanel3.Caption = "Finding best candidate major parent"
    Form2.Refresh
    If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Dim oDoscansX As Byte
    oDoscansX = DoScans(0, 2)
    DoScans(0, 2) = 0
    Call UnModNextno
    Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    AllCheckFlag = 1
    BestParent = -1
    BestParentP = 10000
    WinMethod = -1
    OverrideGCCompare = 0
    BestRescanFlag = 1
    BestRescanP = 10000
    
    Form1.ProgressBar1 = 5
    Call UpdateF2Prog
    EEE = Abs(GetTickCount)
    
    If SelectNode(4) = 0 Then
        'If SelectNode(4) <> 0 Then ModNextno
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If x <> Seq2 And x <> Seq3 Then 'exclude the minorp and recombinant
                    F2P2SNum = x
                    CheckParent = x
                    Call aMajParMnu_Click
                    'ColourSeq(X) = 1
                    'MultColour(X) = SelCol
                End If
            End If
            SSS = Abs(GetTickCount)
            If Abs(SSS - EEE) > 500 Then
                Form1.ProgressBar1 = 5 + (x / NextNo * 95)
                Call UpdateF2Prog
            End If
        Next x
        
    ElseIf SelectNode(0) > -1 Then
    'TreeTraceSeqs(1, CurrentSeq)
    'XX = PermNextno
        
        oef = EditSeqFlag
        'EditSeqFlag = 1
        Call ModSeqNum(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending, 0)
        Call MakeTreeSeqs(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
        OverrideModSeqNum = 1
        Call ModNextno
        EditSeqFlag = oef
        
        For x = 0 To NextNo '10,153:10,107:10,82
              'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            If SelectNode(0) = -1 Then
                Exit For
            End If
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                If TreeTrace(TreeTraceSeqs(1, x)) <> Seq2 And TreeTrace(TreeTraceSeqs(1, x)) <> Seq3 Then 'exclude the minorp and recombinant
                    F2P2SNum = TreeTrace(TreeTraceSeqs(1, x))
                    CheckParent = TreeTrace(TreeTraceSeqs(1, x)) '15,18,21,23
                    Call aMajParMnu_Click
                    
                    'ColourSeq(X) = 1
                    'MultColour(X) = SelCol
                End If
            End If
            SSS = Abs(GetTickCount)
            If Abs(SSS - EEE) > 500 Then
                Form1.ProgressBar1 = 5 + (x / NextNo * 95)
                Call UpdateF2Prog
            End If
        Next x
        
        OverrideModSeqNum = 0
    End If
    
    Form1.ProgressBar1 = 100
    Call UpdateF2Prog
    
    BestRescanFlag = 0
    OverrideGCCompare = 0
    If BestParent > -1 Then
         SelectedSeqNumber = BestParent
         
         For x = 0 To 3
             If x = 1 Then
                Call ModNextno
            Else
                If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                    Call UnModNextno
                End If
            End If
             ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
             Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
         Next x
         
         AllCheckFlag = 0
         Dim CurrentCheck As Byte
         'XX = WinMethod
'         If BestParent > -1 Then
'             If WinMethod = 0 Then
'                 CurrentCheck = 0
'             ElseIf WinMethod = 1 Then
'                 CurrentCheck = 1
'             ElseIf WinMethod = 2 Then
'                 CurrentCheck = 2
'             ElseIf WinMethod = 3 Then
'                 CurrentCheck = 4
'             ElseIf WinMethod = 4 Then
'                 CurrentCheck = 10
'             ElseIf WinMethod = 5 Then
'                 CurrentCheck = 5
'             ElseIf WinMethod = 6 Then
'                 CurrentCheck = 9
'             End If
'             Call ModSeqNum(XOverlist(RelX, RelY).Beginning, XOverlist(RelX, RelY).Ending, 0)
'             Call MakeTreeSeqs(XOverlist(RelX, RelY).Beginning, XOverlist(RelX, RelY).Ending)
'             Call ModNextno
'             Call RCheckWithOther(CurrentCheck, SelectedSeqNumber, Seq2, Seq3)
'         End If
         
         Response = MsgBox("Sequence " + OriginalName(SelectedSeqNumber) + " yielded the strongest evidence of recombintion when used as a major parent.  Would you like to select " + OriginalName(SelectedSeqNumber) + " as the major parent?", vbYesNo)
    
        If Response = 6 Then
            ReassignPFlag = 0
            F2P2SNum = SelectedSeqNumber
            Call MakeMajParMnu_Click
        End If
        CurrentCheck = XoverList(RelX, RelY).ProgramFlag
        If CurrentCheck >= AddNum Then CurrentCheck = CurrentCheck - AddNum
        If CurrentCheck = 0 Then
             CurrentCheck = 0
         ElseIf CurrentCheck = 1 Then
             CurrentCheck = 1
         ElseIf CurrentCheck = 2 Then
             CurrentCheck = 2
         ElseIf CurrentCheck = 3 Then
             CurrentCheck = 4
         ElseIf CurrentCheck = 4 Then
             CurrentCheck = 10
         ElseIf CurrentCheck = 5 Then
             CurrentCheck = 5
         ElseIf CurrentCheck = 6 Then
             CurrentCheck = 9
         ElseIf CurrentCheck = 8 Then
             CurrentCheck = 16
         End If
        
        Call ModSeqNum(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending, 0)
         Call MakeTreeSeqs(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
         Call ModNextno
         Call RCheckWithOther(CurrentCheck, Seq1, Seq2, Seq3)
        
    Else
        MsgBox ("None of the sequences above the selected node are appropriate major parents")
    End If
    For x = 0 To 3
        Picture2(x).Enabled = True
    Next x
    UnModNextno
    DoScans(0, 2) = oDoscansX
    Screen.MousePointer = 0
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    
    UpdateProgressBar = 0
    'SelectNode(0) = -1
End Sub

Private Sub FindBestMinParMnu_Click()
 Dim EN As Long
    UpdateProgressBar = 1
    For x = 0 To 3
        Picture2(x).Enabled = False
    Next x
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Finding best candidate minor parent"
    Form1.Refresh
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    Form2.SSPanel3.Caption = "Finding best candidate minor parent"
    Form2.Refresh
    If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Dim oDoscansX As Byte
    oDoscansX = DoScans(0, 2)
    DoScans(0, 2) = 0
    Seq3 = XoverList(RelX, RelY).Daughter
    Seq2 = XoverList(RelX, RelY).MinorP
    Seq1 = XoverList(RelX, RelY).MajorP
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    Call UnModNextno
    Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    AllCheckFlag = 1
    BestParent = -1
    BestParentP = 10000
    WinMethod = -1
    OverrideGCCompare = 0
    BestRescanFlag = 1
    BestRescanP = 10000
    
    Form1.ProgressBar1 = 5
    Call UpdateF2Prog
    EEE = Abs(GetTickCount)
    
    If SelectNode(4) = 0 Then
        'If SelectNode(4) <> 0 Then ModNextno
        
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If x <> Seq1 And x <> Seq3 Then 'exclude the minorp and recombinant
                    F2P2SNum = x
                    CheckParent = x
                    Call aMinParMnu_Click
                    'ColourSeq(X) = 1
                    'MultColour(X) = SelCol
                End If
            End If
            SSS = Abs(GetTickCount)
            If Abs(SSS - EEE) > 500 Then
                Form1.ProgressBar1 = 5 + (x / NextNo * 95)
                Call UpdateF2Prog
            End If
        Next x
        
        
    Else
        Call ModSeqNum(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending, 0)
        Call MakeTreeSeqs(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
        Call ModNextno
        OverrideModSeqNum = 1 'makes sure seqnum doesn't get modded excessively
    'TreeTraceSeqs(1, CurrentSeq)
    'XX = PermNextno
        'Call ModNextno
        For x = 0 To NextNo '10,153:10,107:10,82
              'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            If SelectNode(0) = -1 Then
                Exit For
            End If
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                If TreeTrace(TreeTraceSeqs(1, x)) <> Seq1 And TreeTrace(TreeTraceSeqs(1, x)) <> Seq3 Then 'exclude the minorp and recombinant
                    F2P2SNum = TreeTrace(TreeTraceSeqs(1, x))
                    CheckParent = TreeTrace(TreeTraceSeqs(1, x))
                    Call aMinParMnu_Click
                    
                    'ColourSeq(X) = 1
                    'MultColour(X) = SelCol
                End If
            End If
            SSS = Abs(GetTickCount)
            If Abs(SSS - EEE) > 500 Then
                Form1.ProgressBar1 = 5 + (x / NextNo * 95)
                Call UpdateF2Prog
            End If
        Next x
        OverrideModSeqNum = 0
    End If
    
    Form1.ProgressBar1 = 100
    Call UpdateF2Prog
    
    BestRescanFlag = 0
    OverrideGCCompare = 0
    If BestParent > -1 Then
         SelectedSeqNumber = BestParent
         
         For x = 0 To 3
             If x = 1 Then
                    Call ModNextno
                Else
                    If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                        Call UnModNextno
                    End If
                End If
             ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
             Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
         Next x
         
         AllCheckFlag = 0
         Dim CurrentCheck As Byte
'         If BestParent > -1 Then
'             If WinMethod = 0 Then
'                 CurrentCheck = 0
'             ElseIf WinMethod = 1 Then
'                 CurrentCheck = 1
'             ElseIf WinMethod = 2 Then
'                 CurrentCheck = 2
'             ElseIf WinMethod = 3 Then
'                 CurrentCheck = 4
'             ElseIf WinMethod = 4 Then
'                 CurrentCheck = 10
'             ElseIf WinMethod = 5 Then
'                 CurrentCheck = 5
'             ElseIf WinMethod = 6 Then
'                 CurrentCheck = 9
'             End If
'             Call ModSeqNum(XOverlist(RelX, RelY).Beginning, XOverlist(RelX, RelY).Ending, 0)
'             Call MakeTreeSeqs(XOverlist(RelX, RelY).Beginning, XOverlist(RelX, RelY).Ending)
'             Call ModNextno
'             Call RCheckWithOther(CurrentCheck, Seq1, SelectedSeqNumber, Seq3)
'         End If
         
         Response = MsgBox("Sequence " + OriginalName(SelectedSeqNumber) + " yielded the strongest evidence of recombintion when used as a minor parent.  Would you like to select " + OriginalName(SelectedSeqNumber) + " as the minor parent?", vbYesNo)
    
        If Response = 6 Then
            ReassignPFlag = 0
            F2P2SNum = SelectedSeqNumber
            Call MakeMinParMnu_Click
        End If
        CurrentCheck = XoverList(RelX, RelY).ProgramFlag
        If CurrentCheck >= AddNum Then CurrentCheck = CurrentCheck - AddNum
        If CurrentCheck = 0 Then
             CurrentCheck = 0
         ElseIf CurrentCheck = 1 Then
             CurrentCheck = 1
         ElseIf CurrentCheck = 2 Then
             CurrentCheck = 2
         ElseIf CurrentCheck = 3 Then
             CurrentCheck = 4
         ElseIf CurrentCheck = 4 Then
             CurrentCheck = 10
         ElseIf CurrentCheck = 5 Then
             CurrentCheck = 5
         ElseIf CurrentCheck = 6 Then
             CurrentCheck = 9
         ElseIf CurrentCheck = 8 Then
             CurrentCheck = 16
         End If
         Call ModSeqNum(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending, 0)
         Call MakeTreeSeqs(XoverList(RelX, RelY).Beginning, XoverList(RelX, RelY).Ending)
         Call ModNextno
         Call RCheckWithOther(CurrentCheck, Seq1, Seq2, Seq3)
        'End If
    Else
        MsgBox ("None of the sequences above the selected node are appropriate minor parents")
    End If
    For x = 0 To 3
        Picture2(x).Enabled = True
    Next x
    DoScans(0, 2) = oDoscansX
    UnModNextno
    Screen.MousePointer = 0
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    UpdateProgressBar = 0
    'SelectNode(0) = -1
End Sub

Private Sub FindSeqMnu2_Click()
MnuClickFlag = 1
F2ZO = 1
Form1.Timer7(0).Enabled = True
End Sub

Private Sub Form_DblClick()
'Picture2(0).AutoRedraw = False
'Picture2(1).AutoRedraw = False
'Picture2(2).AutoRedraw = False
'Picture2(3).AutoRedraw = False


End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Call DoKeydown(KeyCode)
If RIMode = 1 And Form1.Visible = True Then
    If KeyCode = vbKeyPageUp Or KeyCode = vbKeyLeft Or (KeyCode = vbKeyUp And F1P7X = -1 And F1P1X = -1 And F1P6Y = -1) Then
        Call Command8_Click
        KPFlag = 1
    ElseIf KeyCode = vbKeyPageDown Or KeyCode = vbKeyRight Or (KeyCode = vbKeyDown And F1P7X = -1 And F1P1X = -1 And F1P6Y = -1) Then
        'If F1P7X = -1 Then
            Call Command9_Click
            KPFlag = 1
        'End If
    End If
End If
End Sub

Private Sub Form_Load()
For x = 0 To 3
    Form2.Picture3(x).BackColor = Form2.BackColor
Next x
Call WheelHook(Form2.hwnd)
End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
Screen.MousePointer = 0
Form1.Picture7.Refresh
End Sub

Private Sub Form_Resize()
    
    'Call ResizeForm2
    
    If Form2.WindowState = vbMinimized Then Exit Sub
    If (Form2.Width > Form2OWidth Or Form2.Height > Form2OHeight) And x = 12345 Then
        Form2.Width = Form2OWidth
        Form2.Height = Form2OHeight
    ElseIf Form2.Width <> Form2OWidth Then
        Timer1.Enabled = False
        DoEvents 'xxxxxxxxxxxxxxxxxxpotentially dangerous
        Timer1.Enabled = True
        'Exit Sub
    Else
        
    End If
    If Form2.Height < (300 * Screen.TwipsPerPixelY) Then
        'Form2.Height = 300 * Screen.TwipsPerPixelY
        Timer1.Enabled = False
        DoEvents 'xxxxxxxxxxxxxxxxxxpotentially dangerous
        Timer1.Enabled = True
        'Exit Sub
    End If
    
    
    
    If Form2.Height <> Form2OHeight Then
        Call ResizeForm2
    End If
    
    'Form2.ZOrder
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Cancel = True
    Form2.Visible = False
    Form1.ZOrder
    Form1.Refresh
    Call WheelUnHook(Form2.hwnd)
End Sub

Private Sub GOTOSeq_Click()



For Y = 0 To UBound(PermArray, 2)
    If PermArray(0, Y) = TreeTrace(F2P2SNum) Then
        Y = (Y * 12 + 3) * SpaceAdjust
        If CLng((Y - Form1.Picture6.ScaleHeight / 2) / F1VS2Adj) < Form1.VScroll2.Max Then
            If CLng((Y - Form1.Picture6.ScaleHeight / 2) / F1VS2Adj) > 0 Then
                Form1.VScroll2.Value = CLng((Y - Form1.Picture6.ScaleHeight / 2) / F1VS2Adj)
                'CLng((PermYVal - Picture6.ScaleHeight / 2) / F1VS2Adj)
            Else
                Form1.VScroll2.Value = 0
            End If
        Else
            Form1.VScroll2.Value = Form1.VScroll2.Max
        End If
        Y = CLng((Y - Form1.VScroll2.Value * F1VS2Adj)) + 12
        Form1.Picture6.AutoRedraw = False
        Form1.Picture6.FillStyle = 1
        Form1.Picture6.DrawMode = 13
        Form1.Picture6.DrawWidth = 2
        For Z = 0 To 510 Step 5
            If Z > 255 Then
                CVal = 510 - Z
            Else
                CVal = Z
            End If
            'form1.picture6.Line (4, Y - 1)-(form1.Picture5.ScaleWidth - 3, Y + 12), RGB(BkR + (255 - BkR) * (CVal / 255), BkG + (255 - BkG) * (CVal / 255), BkB - BkB * (CVal / 255)), B
            'Form1.Picture6.Line (4, Y - 1)-(Form1.Picture5.ScaleWidth - 3, Y + 11), RGB(255, 0, 0), B 'RGB(BkR + (255 - BkR) * (CVal / 255), BkG - BkG * (CVal / 255), BkB - BkB * (CVal / 255)), B
            Form1.Picture6.Line (4, Y - 1)-(Form1.Picture5.ScaleWidth - 3, Y + 11), RGB(BkR + (255 - BkR) * (CVal / 255), BkG - BkG * (CVal / 255), BkB - BkB * (CVal / 255)), B
            
            DS = Abs(GetTickCount)
                    Do
                        ES = Abs(GetTickCount)
                        If ES - DS <> 0 Then Exit Do
                        
                    Loop
        Next Z
        Form1.Picture6.DrawMode = 13
        'form1.VScroll2.Value = (((Y * 12 + 3) * SpaceAdjust + 10) / form1.picture6.ScaleHeight) * form1.VScroll2.Max
        Form1.Picture6.AutoRedraw = True
        Form1.Picture6.DrawMode = 13
        Form1.Picture6.DrawWidth = 1
        Form1.Picture6.Refresh
        Exit For
    End If
Next Y
End Sub

Private Sub GreenMnu_Click()
SelCol = RGB(0, 160, 0)
End Sub

Private Sub LSMnu2_Click()

    Dim TD() As Double, TTDistance() As Single, tAVDST As Double
    
    
   

If F2TreeIndex = 3 Then
    Call DrawML5(Form2.Picture2(3), 5)
Else
    
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Calculating Tree Dimensions"
    Form1.ProgressBar1.Value = 5
    Call UpdateF2Prog
    LenStrainSeq = Len(StrainSeq(0)) + 1
    
    
    If F2TreeIndex = 0 Then
        RS = 1
        RE = Len(StrainSeq(0))
    ElseIf F2TreeIndex = 2 Then
        RS = XoverList(RelX, RelY).Beginning
        RE = XoverList(RelX, RelY).Ending
    ElseIf F2TreeIndex = 1 Then
        RE = XoverList(RelX, RelY).Beginning - 1
        RS = XoverList(RelX, RelY).Ending + 1
    End If
    
    If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
        Call ModNextno
    End If
    ReDim TTDistance(NextNo, NextNo)
    If F2TreeIndex <> 0 Then
        If RS < RE Then
            TSeqLen = RE - RS + 1 'Len(StrainSeq(0))
            ReDim ETSeqNum(TSeqLen, NextNo)
            Counter = 1
            For x = RS To RE
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = TreeSeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
        Else
            TSeqLen = RS + (Len(StrainSeq(0)) - RE) + 1
            ReDim ETSeqNum(TSeqLen, NextNo)
            Counter = 1
            For x = RS To Len(StrainSeq(0))
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = TreeSeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
            For x = 1 To RE
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = TreeSeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
        End If
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, TreeSeqNum(0, 0), TTDistance(0, 0), tAVDST)
    
    Else
        If RS < RE Then
            TSeqLen = RE - RS + 1 'Len(StrainSeq(0))
            ReDim ETSeqNum(TSeqLen, NextNo)
            Counter = 1
            For x = RS To RE
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = SeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
        Else
            TSeqLen = RS + (Len(StrainSeq(0)) - RE) + 1
            ReDim ETSeqNum(TSeqLen, NextNo)
            Counter = 1
            For x = RS To Len(StrainSeq(0))
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = SeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
            For x = 1 To RE
                For Y = 0 To NextNo
                    ETSeqNum(Counter, Y) = SeqNum(x, Y)
                    
                Next Y
                Counter = Counter + 1
            Next x
        End If
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, SeqNum(0, 0), TTDistance(0, 0), tAVDST)
    
    End If
    For x = 0 To NextNo

        For Y = x + 1 To NextNo

            If ((1 - TTDistance(x, Y)) / 0.75) < 1 Then

                If 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75)))) > 0 Then
                    TTDistance(x, Y) = 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75))))
                Else
                    TTDistance(x, Y) = 0
                End If

            Else
                TTDistance(x, Y) = 0
            End If

            TTDistance(Y, x) = TTDistance(x, Y)
        Next 'Y

    Next 'X

    ReDim TempSeq(NextNo + 2)

    For x = 0 To NextNo

        If F2TreeIndex = 0 Then
            TempSeq(x) = StrainSeq(x)
        Else
            BTree = RS
            ETree = RE

            If BTree < ETree Then
                TempSeq(x) = Mid$(StrainSeq(x), BTree, ETree - BTree)
            Else
                TempSeq(x) = Mid$(StrainSeq(x), BTree, Len(StrainSeq(0)) - BTree)
                TempSeq(x) = TempSeq(x) + Mid$(StrainSeq(x), 1, ETree)
            End If

        End If

    Next 'X

    ReDim TD(NextNo)

    For x = 0 To NextNo

        For Y = 0 To NextNo
            TD(x) = TD(x) + TTDistance(x, Y)
        Next 'Y

    Next 'X

    MD = NextNo

    For x = 0 To NextNo

        If TD(x) < MD Then
            MD = TD(x)
            Outie = x
        End If

    Next 'X

    Dim OCurTree As Integer

    OCurTree = CurTree(F2TreeIndex)
    CurTree(F2TreeIndex) = 2

    If F2TreeIndex = 0 And DoneTree(2, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 2 And DoneTree(2, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 1 And DoneTree(2, F2TreeIndex) = 1 Then
        'Call RedoNJ(11)
    Else

        Call Deactivate
        Call NJTree2(2)
        Call Reactivate

        If AbortFlag = 1 Then
            Form1.ProgressBar1.Value = 0
            Form1.SSPanel1.Caption = ""
            Call UpdateF2Prog
            Screen.MousePointer = 0
            AbortFlag = 0
            Form2.Command2.Enabled = False
            CurTree(F2TreeIndex) = OCurTree
            If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
                Call UnModNextno
                Call UnModSeqNum(0)
            End If
            Exit Sub
        End If
        ExtraDX = DoTreeColour(Picture2(F2TreeIndex), 2, F2TreeIndex)
    End If
    
    For x = 0 To 4
        TTFlag(F2TreeIndex, x) = 0
    Next 'X

    TTFlag(F2TreeIndex, 2) = 1
    Form1.ProgressBar1.Value = 100
    Call UpdateF2Prog

    Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(F2TreeIndex).Value, F2TreeIndex, 2, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(F2TreeIndex))

    Picture2(F2TreeIndex).Refresh
    Screen.MousePointer = 0
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    
    Call UpdateF2Prog
    If F2TreeIndex = 0 Then
        Label1(0).Caption = "LS tree ignoring recombination"
    ElseIf F2TreeIndex = 2 Then
        'Label1(2).Caption = "LS tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Form2.Label1(2) = "MCC tree of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Form2.Label1(2) = "MCC tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf F2TreeIndex = 1 Then
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form2.Label1(1) = "LS tree of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form2.Label1(1) = "LS tree of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form2.Label1(1) = "LS tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If
    End If
    
    If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
        Call UnModNextno
        
    End If
End If
Erase ETSeqNum
End Sub


Private Sub Label1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Label2_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Label3_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Label4_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub Label5_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub MakeFastNJMnu_Click()
If FastNJFlag = 0 Then
    FastNJFlag = 1
    DoneTree(0, 0) = 0
    MakeFastNJMnu.Caption = "Make UPGMA the default tree drawing method"
    MakeFastNJMnu2.Caption = "Make UPGMA the default tree drawing method"
    Form1.FastNJMnu2.Caption = "Make UPGMA the default tree drawing method"
    UPGMAMnu2.Caption = "FastNJ"
    XX = XX
    
    
    For x = 0 To 2
        TreeImage(x) = 0
    Next x
    If TreeTypeFlag = 0 Then
        Form1.Label14 = "FastNJ tree ignoring recombination"
    ElseIf TreeTypeFlag = 1 Then
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form1.Label14 = "FastNJ tree of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form1.Label14 = "FastNJ tree of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form1.Label14 = "FastNJ tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf TreeTypeFlag = 2 Then
        'Form1.Label14 = "FastNJ tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Form1.Label14 = "FastNJ tree of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Form1.Label14 = "FastNJ tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    
    ElseIf TreeTypeFlag = 3 Then
        Form1.Label14 = "FastNJ tree of non-recombinant regions"
    End If
Else
    MakeFastNJMnu.Caption = "Make FastNJ the default tree drawing method"
    MakeFastNJMnu2.Caption = "Make FastNJ the default tree drawing method"
    Form1.FastNJMnu2.Caption = "Make FastNJ the default tree drawing method"
    UPGMAMnu2.Caption = "UPGMA"
    FastNJFlag = 0
    For x = 0 To 3
        TreeImage(x) = 0
    Next x
    DoneTree(0, 0) = 0
    If TreeTypeFlag = 0 Then
        Form1.Label14 = "UPGMA ignoring recombination"
    ElseIf TreeTypeFlag = 1 Then
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form1.Label14 = "UPGMA of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form1.Label14 = "UPGMA of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form1.Label14 = "UPGMA tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf TreeTypeFlag = 2 Then
        Form1.Label14 = "UPGMA of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Form1.Label14 = "UPGMA of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Form1.Label14 = "UPGMA tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf TreeTypeFlag = 3 Then
        Form1.Label14 = "FastNJ tree with recombinant regions removed"
    End If
    
    
End If
OV = DontChangeVScrollFlag
DontChangeVScrollFlag = 1
Call MultTreeWin
DontChangeVScrollFlag = OV
'update picture16
'Form1.Picture16.Picture = LoadPicture()

Call TreeDrawing(0, 1, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form1.VScroll1.Value, TreeTypeFlag, 0, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form1.Picture16)


Dim otTYF As Double, TYFM As Integer
'If PersistantP2tTYF = 0 Then
    Call ModOffsets(8.25, Form2.Picture2(1), otTYF, TYFM)
'    PersistantP2tTYF = otTYF
'    PersistantP2TYFM = TYFM
'Else
'    otTYF = PersistantP2tTYF
'    TYFM = PersistantP2TYFM
'End If

For Index = 0 To 2
      Offset = (Form2.Picture2(Index).ScaleHeight / 2) - 7
      'Targetpos = MiddlePos(CurTree(Index), Index) - Offset
      OVy = 0
      NV = -1
      tTYF = otTYF
      If MiddlePos(CurTree(Index), Index) * tTYF - Offset > Form2.VScroll1(Index).Max Then
          TargetPos = Form2.VScroll1(Index).Max
      ElseIf MiddlePos(CurTree(Index), Index) * tTYF - Offset < 0 Then
          TargetPos = 0
      ElseIf MiddlePos(CurTree(Index), Index) * tTYF - Offset <= Form2.VScroll1(Index).Max Then
          TargetPos = MiddlePos(CurTree(Index), Index) * tTYF - Offset
      End If
      
      If Form2.VScroll1(Index).Value <> TargetPos Then
            If ButtonRepress = BRP Then
                Do While OVy <> NV
                'XX = Form2.Picture2(Index).ScaleHeight
                    OVy = NV
                    NV = CLng(OVy + (TargetPos - OVy) / 5)
                    If NV < 0 Then NV = 0
                    If NV > Form2.VScroll1(Index).Max Then NV = Form2.VScroll1(Index).Max
                    Form2.VScroll1(Index).Value = NV / F2VSScaleFactor(Index)
                    'XX = Form2.VScroll1(Index).Max
                    If OVy = NV Then
                        Exit Do
                    End If
                    DoEvents 'xxxxxxxxxxxxxxxxxxpotentially dangerous
                Loop
            Else
                Form2.VScroll1(Index).Value = TargetPos
            End If
      End If
      
Next Index




x = x
Form1.ProgressBar1 = 0
Call UpdateF2Prog
End Sub

Private Sub MakeFastNJMnu2_Click()
Call MakeFastNJMnu_Click
End Sub

Private Sub MakeMajParMnu_Click()
Dim Seqno As Long, RCol As Long, TBFlag As Byte, OldOne As Long, SEN As Long

Call DisableInterface
UpdateProgressBar = 1
Form1.ProgressBar1 = 5
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState

'Call EnableInterface
If DontSaveUndo = 0 Then
    Call SaveUndo
    DontSaveUndo = 1
End If

If ReassignPFlag > 0 Then
    If ReassignPFlag = 2 Then
        If ReassortmentFlag = 0 Then
            Form1.SSPanel1.Caption = "Swaping recombinant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant and minor parent"
        Else
            Form1.SSPanel1.Caption = "Swaping recombinant/reassortnant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant/reassortnant and minor parent"
        End If
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        ReassignPFlag = 3 'swap major and minor parent
        Form1.Timer6.Enabled = True
    ElseIf ReassignPFlag = 3 Then
        If ReassortmentFlag = 0 Then
            Form1.SSPanel1.Caption = "Swaping recombinant and major parent"
            Form2.SSPanel3.Caption = "Swaping recombinant and major parent"
        Else
            Form1.SSPanel1.Caption = "Swaping recombinant/reassortnant and major parent"
            Form2.SSPanel3.Caption = "Swaping recombinant/reassortnant and major parent"
        End If
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        ReassignPFlag = 1 'swap the recombinant and the majorp
        Form1.Timer6.Enabled = True
    End If
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Screen.MousePointer = 0
    Call EnableInterface
    UpdateProgressBar = 0
    Exit Sub
End If
SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)


If F2P2SNum < 0 Or F2P2SNum > UBound(TreeTrace, 1) Then
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Screen.MousePointer = 0
    Call EnableInterface
    UpdateProgressBar = 0
    Exit Sub
End If
Form1.ProgressBar1 = 30
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState
SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
Seqno = TreeTrace(F2P2SNum)

If Seqno = BestEvent(SEN, 0) Then
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Screen.MousePointer = 0
    Call EnableInterface
    UpdateProgressBar = 0
    Exit Sub
End If

'before we do anythoing need to make sure that bestevent does not get shifted - therefore make event 1 in currentxoverlist the best event that relx and rely point to
'this is because shuffling around parents and recombinanst and getting new parents etc tends to require events in xoverlist being moved around
'keeping the bestevent in the first column prevents this
Dim TXO As XOverDefine
TXO = XoverList(RelX, RelY)
XoverList(RelX, RelY) = XoverList(RelX, 1)
XoverList(RelX, 1) = TXO
RelY = 1

BestEvent(SEN, 0) = RelX
BestEvent(SEN, 1) = RelY



OldOne = XoverList(RelX, RelY).MajorP


''''''''''''''''''''''''''''''''''This was a fuckup'''''''''''''''''''''''''''''''''''''''''''''
''''''''''here and in makeminparmnu I need to
'strip all the signals for SEN with the non-selected parental sequence(s) out of bestxolistmi, bestxolistms and xoverlist
'clean the three groups of xolists to update currentxovers
'add in signals to the three xolists for the newly selected parent:
'rescan the new parent against all the other parents and recombinants and add new signals to xoverlist, bestcoverlistma and bestxoverlistmi
'fix nopini (properly not just a fudge) STIL NOT FIXED
'remake confirm, confirmp, confirmma, confimpma, confirmmi and confirmpmi
'update the daught, minpar and majpar arrays
'find the bestevents and add it to bestevent for this SEN
'fix dscores using swapinvolved


'first work out what the nopini situation is with the new sequence, seqno
'nopini is dimentiond to 2,seventnumber
'nopini(0,xxx) = 2 means that the

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'this is the nopini block in dordp - need to stick perfectly to this convention
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'minpair (0) encodes the pair which is most similar in the "background"
'minpair(1) encodes the pair which is most similar in the recombinant region
'in minpair(0): 0 = sequence 1 and 2, 1 = sequence 0 and sequence 2, 2= sequence 1 and sequence 2
'ReDim INList(2), OUList(2)
'
'    If MinPair(0) = 0 And MinPair(1) = 1 Then 'seqs 0 and 1 are most similar in the background but seqs 1 and 2 are most similar in the recombinant region
'        INList(0) = 1: INList(1) = 0: INList(2) = 2
'        OUList(1) = 0: OUList(0) = 1: OUList(2) = 2
'    ElseIf MinPair(0) = 0 And MinPair(1) = 2 Then
'        INList(0) = 0: INList(1) = 1: INList(2) = 2
'        OUList(0) = 0: OUList(1) = 1: OUList(2) = 2
'    ElseIf MinPair(0) = 1 And MinPair(1) = 0 Then
'        INList(0) = 2: INList(1) = 0: INList(2) = 1
'        OUList(2) = 0: OUList(0) = 1: OUList(1) = 2
'    ElseIf MinPair(0) = 1 And MinPair(1) = 2 Then
'        INList(0) = 0: INList(1) = 2: INList(2) = 1
'        OUList(0) = 0: OUList(2) = 1: OUList(1) = 2
'    ElseIf MinPair(0) = 2 And MinPair(1) = 0 Then
'        INList(0) = 2: INList(1) = 1: INList(2) = 0
'        OUList(2) = 0: OUList(1) = 1: OUList(0) = 2
'    ElseIf MinPair(0) = 2 And MinPair(1) = 1 Then
'        INList(0) = 1: INList(1) = 2: INList(2) = 0
'        OUList(1) = 0: OUList(2) = 1: OUList(0) = 2
'    End If
'Dim SwapFlag As Byte
'    ReDim Preserve NOPINI(2, SEventNumber)
'    Dim DMiMa(2) As Long
'    If INList(0) <> INList(1) And INList(0) <> INList(2) And INList(1) <> INList(2) Then
'        If INList(0) = WinPP Then 'NO recombinant
'            NOPINI(0, SEventNumber) = 0: NOPINI(1, SEventNumber) = 1: NOPINI(2, SEventNumber) = 2
'        ElseIf INList(1) = WinPP Then 'PI recombinant
'            NOPINI(0, SEventNumber) = 1: NOPINI(1, SEventNumber) = 0: NOPINI(2, SEventNumber) = 2
'        Elseif INList(2) = WinPP 'NI recombinant
'            NOPINI(0, SEventNumber) = 2: NOPINI(1, SEventNumber) = 1: NOPINI(2, SEventNumber) = 0
'        End If
'   end if





 If DebuggingFlag < 2 Then On Error Resume Next
 UB = -1
 UB = UBound(BestXOListMi, 2)
 
 If UB = -1 Then
 
    If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
        
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        ReDim BestXOListMi(PermNextno, UBXOMi)
        ReDim BestXOListMa(PermNextno, UBXoMa)
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
 End If



'Mark all events for removal
Call MarkEventForRemoval(SEN, RelX, RelY)

'add back proxy events with the new major par, the current minorpar and all of the listed daughts


Dim MPV As Long, mP As Long
mP = XoverList(RelX, RelY).MinorP

Dim Screenx(6) As Long 'array containing methods numbers that must be rescreened and therefore need a slot in xoverlist etc
                        'this will ensure that the events get rescreeened in updateidscored later
Screenx(0) = 0 'rdp
Screenx(1) = 1 'geneconv
Screenx(2) = 3 'maxch
Screenx(3) = 4 'chimaera
Screenx(4) = 8 '3seq
Screenx(5) = 2 'bootscan
Screenx(6) = 5 'siscan

XoverList(RelX, RelY).DHolder = Abs(XoverList(RelX, RelY).DHolder) ' this denotes that this sequence (the one that would have been the one that the breacoount CIs were calculated for) has been demoted from the main event

'need to find maxchi and chiaera optimal window sizes from the .lholders of
Dim MchWin As Long, ChWin As Long
Call LHWinsize(SEN, MchWin, ChWin)

For x = 0 To PermNextno
    
    If Daught(SEN, x) > 0 Then
        If Daught(SEN, x) > 0 > 5 Then
        x = x
        End If
        For Y = 0 To UBound(Screenx)
            If RelX <> x Or RelY <> Y Then 'need to make sure to not duplicate XOverlist(RelX, RelY)
                CurrentXOver(x) = CurrentXOver(x) + 1
                If UBound(XoverList, 2) < CurrentXOver(x) Then
                    ReDim Preserve XoverList(PermNextno, CurrentXOver(x) + 10)
                End If
                XoverList(x, CurrentXOver(x)) = XoverList(RelX, RelY)
                
                XoverList(x, CurrentXOver(x)).MajorP = Seqno 'this is where the new major parent is inserted
                XoverList(x, CurrentXOver(x)).Daughter = x
                XoverList(x, CurrentXOver(x)).Probability = 0.049
                XoverList(x, CurrentXOver(x)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    XoverList(x, CurrentXOver(x)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    XoverList(x, CurrentXOver(x)).LHolder = ChWin
                End If
            End If
            If x = RelX Then
                'Make a version of this event in bestxolistmi for mp
                BCurrentXoverMi(mP) = BCurrentXoverMi(mP) + 1
                If UBound(BestXOListMi, 2) < BCurrentXoverMi(mP) Then
                    ReDim Preserve BestXOListMi(PermNextno, BCurrentXoverMi(mP) + 10)
                End If
                BestXOListMi(mP, BCurrentXoverMi(mP)) = XoverList(x, CurrentXOver(x))
                BestXOListMi(mP, BCurrentXoverMi(mP)).MajorP = Seqno
                BestXOListMi(mP, BCurrentXoverMi(mP)).MinorP = x
                BestXOListMi(mP, BCurrentXoverMi(mP)).Daughter = mP
                BestXOListMi(mP, BCurrentXoverMi(mP)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    BestXOListMi(mP, BCurrentXoverMi(mP)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    BestXOListMi(mP, BCurrentXoverMi(mP)).LHolder = ChWin
                End If
                
                'Make a version of this event in bestxolistma for seqno
                BCurrentXoverMa(Seqno) = BCurrentXoverMa(Seqno) + 1
                If UBound(BestXOListMa, 2) < BCurrentXoverMa(Seqno) Then
                    ReDim Preserve BestXOListMa(PermNextno, BCurrentXoverMa(Seqno) + 10)
                End If
                BestXOListMa(Seqno, BCurrentXoverMa(Seqno)) = XoverList(x, CurrentXOver(x))
                BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).MajorP = x
                BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).Daughter = Seqno
                BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).MinorP = mP
                BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    BestXOListMa(Seqno, BCurrentXoverMa(Seqno)).LHolder = ChWin
                End If
            End If
        Next Y
    End If

Next x


'XOverlist(RelX, RelY).Probability = -1
MPV = MinorPar(SEN, XoverList(RelX, RelY).MinorP)

XoverList(RelX, RelY).MajorP = Seqno
XoverList(RelX, RelY).DHolder = -XoverList(RelX, RelY).DHolder 'reinstate this as the "bestevent"
'XX = XOverlist(RelX, RelY).Probability
BestEvent(SEN, 0) = RelX
BestEvent(SEN, 1) = RelY




'actually erase old versions of records
Call CleanXOList(SEN, XoverList(), CurrentXOver(), Daught())
Call CleanXOList(SEN, BestXOListMi(), BCurrentXoverMi(), MinorPar())
Call CleanXOList(SEN, BestXOListMa(), BCurrentXoverMa(), MajorPar())




'remove old mentions of deleted major and minor parents from majpar and minpar


For x = 0 To PermNextno
    MinorPar(SEN, x) = 0
    MajorPar(SEN, x) = 0
Next x

MinorPar(SEN, mP) = MPV
MajorPar(SEN, Seqno) = 1


'BestEvent(SEN, 0) = RelX
'BestEvent(SEN, 1) = RelY


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'I need to fix nopini properly here or elsewhere
'I cannot fix dscores here using swapinvolved though because the dscores all need to be recalculated
'I cannot remake confrim and confirmphere either - they need to be rebuilt elsewhere
'I cannot rescan the new parents here eiither - MUST be done elsewhere
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

UBXOMi = UBound(BestXOListMi, 2)
UBXoMa = UBound(BestXOListMa, 2)

If XOMiMaInFileFlag = 1 Then
    
    oDirX = CurDir
    ChDrive App.Path
    ChDir App.Path
    FF = FreeFile
    If MiRec < 1 Then
        Open "RDP5BestXOListMi" + UFTag For Binary As #FF
        Put #FF, , BestXOListMi()
        Close #FF
    End If
    If MaRec < 1 Then
        Open "RDP5BestXOListMa" + UFTag For Binary As #FF
        Put #FF, , BestXOListMa()
        Close #FF
    End If
    ChDrive oDirX
    ChDir oDirX
        
    Erase BestXOListMa
    Erase BestXOListMi
    MaRec = MaRec - 1
    MiRec = MiRec - 1
End If
 


If XoverList(RelX, RelY).Accept = 1 Then
    AcceptChangeFlag = 2
    Form1.Command10.Enabled = True
ElseIf AcceptChangeFlag = 0 Then
    AcceptChangeFlag = 1
End If




Form1.ProgressBar1 = 35
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState

Call EnableInterface

Form1.ProgressBar1 = 40
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState



GoOn = RedoBreakpoints(0)




If GoOn = 0 Then
    'Make the block dissapear
    'Find coordinates of seqno in all trees
    
    Dim ONco() As Long, SNco() As Long, TNum As Long, TType As Long
    ReDim SNco(3, 3, 1), ONco(3, 3, 1)
    Call UnModNextno
    For TNum = 0 To 3
        If TNum = 1 Then ModNextno
        If TNum = 3 And CurTree(TNum) = 0 Then UnModNextno
        For TType = 0 To 3
            For x = 0 To TDLen(TNum, TType, 0)
                    If TDLen(TNum, TType, 0) > 0 Then
                        If TreeDraw(TNum, TType, 0, 2, x) > -1 And TreeDraw(TNum, TType, 0, 2, x) <= NextNo Then
                            
                                If TNum <> 0 And TNum <> 3 Then
                                     ' Exit Sub
                                    XX = MName
                                    
                                    If Seqno = TreeTrace(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, x))) Then
                                    'If MName = originalname(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, X))) Then
                                        SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                        SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                        'Exit For
                                    End If
                                    If OldOne = TreeTrace(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, x))) Then
                                        ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                        ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                    End If
                                Else
                                    
                                    If (TNum = 3 And TType = 0) Or TNum = 0 Then
                                        If Seqno = (TreeDraw(TNum, TType, 0, 2, x)) Then
                                        'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                            SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                            SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                            
                                        End If
                                        If OldOne = ((TreeDraw(TNum, TType, 0, 2, x))) Then
                                        'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                            ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                            ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                            
                                        End If
                                    Else
                                        If (TNum = 3 And TType = 1) Then
                                            If Seqno = BigTreeTraceU(TreeDraw(TNum, TType, 0, 2, x)) Then
                                            'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                                SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                                SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                                
                                            End If
                                            If OldOne = BigTreeTraceU((TreeDraw(TNum, TType, 0, 2, x))) Then
                                            'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                                ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                                ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                                
                                            End If
                                        ElseIf (TNum = 3 And TType = 2) Then
                                            If Seqno = BigTreeTrace(TreeDraw(TNum, TType, 0, 2, x)) Then
                                            'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                                SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                                SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                                
                                            End If
                                            If OldOne = BigTreeTrace((TreeDraw(TNum, TType, 0, 2, x))) Then
                                            'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                                ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                                ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                                
                                            End If
                                        End If
                                    End If
                                End If
                        End If
                    End If
            Next x
        Next TType
    Next TNum

    Form1.ProgressBar1 = 85
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    
    
 
    
    
    GCol = RGB(0, 255, 0)
    If TBFlag = 12345 Then
        Call UnModNextno
        
        For TNum = 0 To 3
            If TNum = 1 Then ModNextno
            For TType = 0 To 3
                If TBLen(TNum, TType) > 0 Then
                    For x = 0 To TBLen(TNum, TType)
                        If (SNco(TNum, TType, 0) >= TreeBlocks(TNum, TType, 0, x) And SNco(TNum, TType, 0) <= TreeBlocks(TNum, TType, 2, x)) Then
                            If (SNco(TNum, TType, 1) >= TreeBlocks(TNum, TType, 1, x) And SNco(TNum, TType, 1) <= TreeBlocks(TNum, TType, 3, x)) Then
                                
                                  TreeBlocks(TNum, TType, 4, x) = GCol
                                
                            End If
                        End If
                        If ONco(TNum, TType, 0) >= TreeBlocks(TNum, TType, 0, x) And ONco(TNum, TType, 0) <= TreeBlocks(TNum, TType, 2, x) Then
                            If ONco(TNum, TType, 1) >= TreeBlocks(TNum, TType, 1, x) And ONco(TNum, TType, 1) <= TreeBlocks(TNum, TType, 3, x) Then
                                
                                  TreeBlocks(TNum, TType, 4, x) = Form1.Picture1.BackColor
                                
                            End If
                        End If
                    Next x
                End If
                
            Next TType
        Next TNum
        
    Else
        Call UnModNextno
        
        
        For TNum = 0 To 3
            If TNum = 1 Then ModNextno
            If TNum = 3 Then UnModNextno
            For TType = 0 To 3
                If TBLen(TNum, TType) > 0 Then
                    TL = Picture2(0).TextWidth(OriginalName(Seqno)) + 2
                    TBLen(TNum, TType) = TBLen(TNum, TType) + 1
                    
                    
                    If TBLen(TNum, TType) > UBound(TreeDraw, 5) Then
                        ReDim Preserve TreeDraw(3, 4, 1, 4, TBLen(TNum, TType) + 100)
                        Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                    End If
                    If TBLen(TNum, TType) > UBound(TreeBlocks, 4) Then
                        ReDim Preserve TreeBlocks(3, 4, 5, TBLen(TNum, TType) + 100)
                        Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                    End If
                    TreeBlocks(TNum, TType, 0, TBLen(TNum, TType)) = SNco(TNum, TType, 0) - 2
                    TreeBlocks(TNum, TType, 1, TBLen(TNum, TType)) = SNco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 2, TBLen(TNum, TType)) = SNco(TNum, TType, 0) + TL
                    TreeBlocks(TNum, TType, 3, TBLen(TNum, TType)) = 13 + SNco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 4, TBLen(TNum, TType)) = GCol
                    
                    TL = Picture2(0).TextWidth(OriginalName(OldOne)) + 2
                    TBLen(TNum, TType) = TBLen(TNum, TType) + 1
                    If TBLen(TNum, TType) > UBound(TreeDraw, 5) Then
                        ReDim Preserve TreeDraw(3, 4, 1, 4, TBLen(TNum, TType) + 100)
                        Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                    End If
                    If TBLen(TNum, TType) > UBound(TreeBlocks, 4) Then
                        
                        ReDim Preserve TreeBlocks(3, 4, 5, TBLen(TNum, TType) + 100)
                    End If
                    TreeBlocks(TNum, TType, 0, TBLen(TNum, TType)) = ONco(TNum, TType, 0) - 2
                    TreeBlocks(TNum, TType, 1, TBLen(TNum, TType)) = ONco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 2, TBLen(TNum, TType)) = ONco(TNum, TType, 0) + TL
                    TreeBlocks(TNum, TType, 3, TBLen(TNum, TType)) = 13 + ONco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 4, TBLen(TNum, TType)) = Form2.Picture2(0).BackColor
                End If
                
            Next TType
        Next TNum
    End If
    

    Form1.ProgressBar1 = 90
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    Call UnModNextno
    
    
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    
    

    
    Form1.ProgressBar1 = 95
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState

    
    Call UnModNextno
    
    SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    
    XP = BestEvent(SEN, 0)
    YP = BestEvent(SEN, 1)
        
    Call IntegrateXOvers(0)
    
    UpdateIDFlag = 1
    'Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    Dim inRelX As Long, inRelY As Long
    inRelX = RelX: inRelY = RelY
    Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    If inRelX <> RelX Or inRelY <> RelY Then
        Call IntegrateXOvers(0)
        UpdateIDFlag = 0
        XP = RelX: YP = RelY: PermXVal = 0: PermYVal = 0
        Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    End If
    Form1.ProgressBar1 = 98
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState

    
    If RIMode = 0 Then
        Call MakeRecombinationInfo(RelX, RelY)
    End If
    
    UpdateIDFlag = 0
    Form1.Enabled = True
    Form2.ZOrder
    'Call aMajParMnu_Click
End If


Form1.SSPanel1.Caption = ""

Form1.ProgressBar1 = 0
Call EnableInterface
Call UpdateF2Prog

Form1.Enabled = True
Form2.ZOrder
Screen.MousePointer = 0
DontSaveUndo = 0

UpdateProgressBar = 0




End Sub

Private Sub MakeMinParMnu_Click()
Dim Seqno As Long, RCol As Long, TBFlag As Byte, OldOne As Long, SEN As Long

Call DisableInterface
UpdateProgressBar = 1
Form1.ProgressBar1 = 5
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState

'Call EnableInterface
If DontSaveUndo = 0 Then
    Call SaveUndo
    DontSaveUndo = 1
End If

If ReassignPFlag > 0 Then
    If ReassignPFlag = 1 Then
        Form1.SSPanel1.Caption = "Swaping major and minor parent"
        Form2.SSPanel3.Caption = "Swaping major and minor parent"
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        ReassignPFlag = 3 'swap major and minor parent
        Form1.Timer6.Enabled = True
    ElseIf ReassignPFlag = 3 Then
        If ReassortmentFlag = 0 Then
            Form1.SSPanel1.Caption = "Swaping recombinant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant and minor parent"
        Else
            Form1.SSPanel1.Caption = "Swaping recombinant/reassortnant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant/reassortnant and minor parent"
        End If
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        ReassignPFlag = 2 'swap the recombinant and the minorp
        Form1.Timer6.Enabled = True
    End If
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Screen.MousePointer = 0
    Call EnableInterface
    UpdateProgressBar = 0
    Exit Sub
End If
Form1.ProgressBar1 = 30
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState
SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
Seqno = TreeTrace(F2P2SNum)

If Seqno = BestEvent(SEN, 0) Then
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Screen.MousePointer = 0
    Call EnableInterface
    UpdateProgressBar = 0
    Exit Sub
End If

'before we do anythoing need to make sure that bestevent does not get shifted - therefore make event 1 in currentxoverlist the best event that relx and rely point to
'this is because shuffling around parents and recombinanst and getting new parents etc tends to require events in xoverlist being moved around
'keeping the bestevent in the first column prevents this
Dim TXO As XOverDefine
TXO = XoverList(RelX, RelY)
XoverList(RelX, RelY) = XoverList(RelX, 1)
XoverList(RelX, 1) = TXO
RelY = 1

BestEvent(SEN, 0) = RelX
BestEvent(SEN, 1) = RelY

OldOne = XoverList(RelX, RelY).MinorP


If DebuggingFlag < 2 Then On Error Resume Next
 UB = -1
 UB = UBound(BestXOListMi, 2)
 
 If UB = -1 Then
 
    If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
        
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        ReDim BestXOListMi(PermNextno, UBXOMi)
        ReDim BestXOListMa(PermNextno, UBXoMa)
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
 End If

'Mark all events for removal
Call MarkEventForRemoval(SEN, RelX, RelY)

'add back proxy events with the new major par, the current minorpar and all of the listed daughts


Dim MPV As Long, mP As Long
mP = XoverList(RelX, RelY).MajorP
Dim Screenx(6) As Long 'array containing methods numbers that must be rescreened and therefore need a slot in xoverlist etc
                        'this will ensure that the events get rescreeened in updateidscored later
Screenx(0) = 0 'rdp
Screenx(1) = 1 'geneconv
Screenx(2) = 3 'maxch
Screenx(3) = 4 'chimaera
Screenx(4) = 8 '3seq
Screenx(5) = 2 'bootscan
Screenx(6) = 5 'siscan

XoverList(RelX, RelY).DHolder = Abs(XoverList(RelX, RelY).DHolder) ' this dnotes that this sequence (the one that would have been the one that the breacoount CIs were calculated for) has been demoted from the main event

'need to find maxchi and chiaera optimal window sizes from the .lholders of
Dim MchWin As Long, ChWin As Long
Call LHWinsize(SEN, MchWin, ChWin)

For x = 0 To PermNextno
    
    If Daught(SEN, x) > 0 Then
        For Y = 0 To UBound(Screenx)
            If RelX <> x Or RelY <> Y Then 'need to make sure to not duplicate XOverlist(RelX, RelY)
                CurrentXOver(x) = CurrentXOver(x) + 1
                If UBound(XoverList, 2) < CurrentXOver(x) Then
                    ReDim Preserve XoverList(PermNextno, CurrentXOver(x) + 10)
                End If
                XoverList(x, CurrentXOver(x)) = XoverList(RelX, RelY)
                
                XoverList(x, CurrentXOver(x)).MinorP = Seqno 'this is where the new minor parent is inserted
                XoverList(x, CurrentXOver(x)).Daughter = x
                XoverList(x, CurrentXOver(x)).Probability = 0.049
                XoverList(x, CurrentXOver(x)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    XoverList(x, CurrentXOver(x)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    XoverList(x, CurrentXOver(x)).LHolder = ChWin
                End If
            End If
            If x = RelX Then
                                
                'Make a version of this event in bestxolistmi for seqno
                BCurrentXoverMi(Seqno) = BCurrentXoverMi(Seqno) + 1
                If UBound(BestXOListMi, 2) < BCurrentXoverMi(Seqno) Then
                    ReDim Preserve BestXOListMi(PermNextno, BCurrentXoverMi(Seqno) + 10)
                End If
                BestXOListMi(Seqno, BCurrentXoverMi(Seqno)) = XoverList(x, CurrentXOver(x))
                BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).MajorP = mP
                BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).MinorP = x
                BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).Daughter = Seqno
                BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    BestXOListMi(Seqno, BCurrentXoverMi(Seqno)).LHolder = ChWin
                End If
                
                'Make a version of this event in bestxolistma for mp
                BCurrentXoverMa(mP) = BCurrentXoverMa(mP) + 1
                If UBound(BestXOListMa, 2) < BCurrentXoverMa(mP) Then
                    ReDim Preserve BestXOListMa(PermNextno, BCurrentXoverMa(mP) + 10)
                End If
                BestXOListMa(mP, BCurrentXoverMa(mP)) = XoverList(x, CurrentXOver(x))
                BestXOListMa(mP, BCurrentXoverMa(mP)).MajorP = x
                BestXOListMa(mP, BCurrentXoverMa(mP)).MinorP = Seqno
                BestXOListMa(mP, BCurrentXoverMa(mP)).Daughter = mP
                BestXOListMa(mP, BCurrentXoverMa(mP)).ProgramFlag = Screenx(Y)
                If Screenx(Y) = 3 Then
                    BestXOListMa(mP, BCurrentXoverMa(mP)).LHolder = MchWin
                ElseIf Screenx(Y) = 4 Then
                    BestXOListMa(mP, BCurrentXoverMa(mP)).LHolder = ChWin
                End If
            End If
        Next Y
    End If

Next x


'XOverlist(RelX, RelY).Probability = -1

MPV = MajorPar(SEN, XoverList(RelX, RelY).MajorP)

XoverList(RelX, RelY).MinorP = Seqno
XoverList(RelX, RelY).DHolder = -XoverList(RelX, RelY).DHolder 'reinstate this as the "bestevent"
BestEvent(SEN, 0) = RelX
BestEvent(SEN, 1) = RelY

'actually erase old versions of records
Call CleanXOList(SEN, XoverList(), CurrentXOver(), Daught())
Call CleanXOList(SEN, BestXOListMi(), BCurrentXoverMi(), MinorPar())
Call CleanXOList(SEN, BestXOListMa(), BCurrentXoverMa(), MajorPar())

'remove old mentions of deleted major and minor parents from majpar and minpar


For x = 0 To PermNextno
    MinorPar(SEN, x) = 0
    MajorPar(SEN, x) = 0
Next x

MinorPar(SEN, Seqno) = 1
MajorPar(SEN, mP) = MPV


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'I need to fix nopini properly here or elsewhere
'I cannot fix dscores here using swapinvolved though because the dscores all need to be recalculated
'I cannot remake confrim and confirmphere either - they need to be rebuilt elsewhere
'I cannot rescan the new parents here eiither - MUST be done elsewhere
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

UBXOMi = UBound(BestXOListMi, 2)
UBXoMa = UBound(BestXOListMa, 2)
If XOMiMaInFileFlag = 1 Then
    
    oDirX = CurDir
    ChDrive App.Path
    ChDir App.Path
    FF = FreeFile
    If MiRec < 1 Then
        Open "RDP5BestXOListMi" + UFTag For Binary As #FF
        Put #FF, , BestXOListMi()
        Close #FF
    End If
    If MaRec < 1 Then
        Open "RDP5BestXOListMa" + UFTag For Binary As #FF
        Put #FF, , BestXOListMa()
        Close #FF
    End If
    ChDrive oDirX
    ChDir oDirX
        
    Erase BestXOListMa
    Erase BestXOListMi
    MaRec = MaRec - 1
    MiRec = MiRec - 1
End If
 

If XoverList(RelX, RelY).Accept = 1 Then
    AcceptChangeFlag = 2
    Form1.Command10.Enabled = True
ElseIf AcceptChangeFlag = 0 Then
    AcceptChangeFlag = 1
End If

Form1.ProgressBar1 = 35
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState

Call EnableInterface

Form1.ProgressBar1 = 40
Call UpdateF2Prog
Form1.WindowState = Form1.WindowState

GoOn = RedoBreakpoints(0)
If GoOn = 0 Then
    'Make the block dissapear
    'Find coordinates of seqno in all trees
    Dim ONco() As Long, SNco() As Long, TNum As Long, TType As Long
    ReDim SNco(3, 3, 1), ONco(3, 3, 1)
    Call UnModNextno
    For TNum = 0 To 3
        If TNum = 1 Then ModNextno
    
        For TType = 0 To 3
            For x = 0 To TDLen(TNum, TType, 0)
                    If TreeDraw(TNum, TType, 0, 2, x) > -1 And TreeDraw(TNum, TType, 0, 2, x) <= NextNo Then
                        
                            If TNum <> 0 Then
                                 ' Exit Sub
                                XX = MName
                                
                                If Seqno = TreeTrace(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, x))) Then
                                'If MName = originalname(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, X))) Then
                                    SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                    SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                    'Exit For
                                End If
                                If OldOne = TreeTrace(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, x))) Then
                                    ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                    ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                End If
                            Else
                                If Seqno = TreeTrace((TreeDraw(TNum, TType, 0, 2, x))) Then
                                'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                    SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                    SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                    
                                End If
                                If OldOne = TreeTrace((TreeDraw(TNum, TType, 0, 2, x))) Then
                                'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                    ONco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                    ONco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                    
                                End If
                            End If
                    End If
            Next x
        Next TType
    Next TNum
    Form1.ProgressBar1 = 85
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    GCol = RGB(0, 0, 255)
    If TBFlag = 12345 Then
        Call UnModNextno
        
        For TNum = 0 To 3
            If TNum = 1 Then ModNextno
            For TType = 0 To 3
                If TBLen(TNum, TType) > 0 Then
                    For x = 0 To TBLen(TNum, TType)
                        If (SNco(TNum, TType, 0) >= TreeBlocks(TNum, TType, 0, x) And SNco(TNum, TType, 0) <= TreeBlocks(TNum, TType, 2, x)) Then
                            If (SNco(TNum, TType, 1) >= TreeBlocks(TNum, TType, 1, x) And SNco(TNum, TType, 1) <= TreeBlocks(TNum, TType, 3, x)) Then
                                
                                  TreeBlocks(TNum, TType, 4, x) = GCol
                                
                            End If
                        End If
                        If ONco(TNum, TType, 0) >= TreeBlocks(TNum, TType, 0, x) And ONco(TNum, TType, 0) <= TreeBlocks(TNum, TType, 2, x) Then
                            If ONco(TNum, TType, 1) >= TreeBlocks(TNum, TType, 1, x) And ONco(TNum, TType, 1) <= TreeBlocks(TNum, TType, 3, x) Then
                                
                                  TreeBlocks(TNum, TType, 4, x) = Form1.Picture1.BackColor
                                
                            End If
                        End If
                    Next x
                End If
                
            Next TType
        Next TNum
        
    Else
        Call UnModNextno
        
        
        For TNum = 0 To 3
            If TNum = 1 Then ModNextno
            For TType = 0 To 3
                If TBLen(TNum, TType) > 0 Then
                    TL = Picture2(0).TextWidth(OriginalName(Seqno)) + 2
                    TBLen(TNum, TType) = TBLen(TNum, TType) + 1
                    
                    
                    If TBLen(TNum, TType) > UBound(TreeDraw, 5) Then
                        ReDim Preserve TreeDraw(3, 4, 1, 4, TBLen(TNum, TType) + 100)
                        Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                    End If
                    If TBLen(TNum, TType) > UBound(TreeBlocks, 4) Then
                        'TreeBlocks(3, 4, 4, (Nextno + 2))
                        ReDim Preserve TreeBlocks(3, 4, 5, TBLen(TNum, TType) + 100)
                    End If
                    TreeBlocks(TNum, TType, 0, TBLen(TNum, TType)) = SNco(TNum, TType, 0) - 2
                    TreeBlocks(TNum, TType, 1, TBLen(TNum, TType)) = SNco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 2, TBLen(TNum, TType)) = SNco(TNum, TType, 0) + TL
                    TreeBlocks(TNum, TType, 3, TBLen(TNum, TType)) = 13 + SNco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 4, TBLen(TNum, TType)) = GCol
                    
                    TL = Picture2(0).TextWidth(OriginalName(OldOne)) + 2
                    TBLen(TNum, TType) = TBLen(TNum, TType) + 1
                    If TBLen(TNum, TType) > UBound(TreeDraw, 5) Then
                        ReDim Preserve TreeDraw(3, 4, 1, 4, TBLen(TNum, TType) + 100)
                        Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                    End If
                    If TBLen(TNum, TType) > UBound(TreeBlocks, 4) Then
                        'TreeBlocks(3, 4, 4, (Nextno + 2))
                        ReDim Preserve TreeBlocks(3, 4, 5, TBLen(TNum, TType) + 100)
                    End If
                    
                    TreeBlocks(TNum, TType, 0, TBLen(TNum, TType)) = ONco(TNum, TType, 0) - 2
                    TreeBlocks(TNum, TType, 1, TBLen(TNum, TType)) = ONco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 2, TBLen(TNum, TType)) = ONco(TNum, TType, 0) + TL
                    TreeBlocks(TNum, TType, 3, TBLen(TNum, TType)) = 13 + ONco(TNum, TType, 1)
                    TreeBlocks(TNum, TType, 4, TBLen(TNum, TType)) = Form2.Picture2(0).BackColor
                End If
                
            Next TType
        Next TNum
    End If
    
    Form1.ProgressBar1 = 90
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    Call UnModNextno
    
    SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    Seq1 = XoverList(RelX, RelY).MajorP
    Seq2 = XoverList(RelX, RelY).MinorP
    Seq3 = XoverList(RelX, RelY).Daughter
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    
    Form1.ProgressBar1 = 95
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    Call UnModNextno
    
    XP = BestEvent(SEN, 0)
    YP = BestEvent(SEN, 1)
    
    Call IntegrateXOvers(0)
    
    UpdateIDFlag = 1
    
    'It is VERY importnant that RelX
    'Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    Dim inRelX As Long, inRelY As Long
    inRelX = RelX: inRelY = RelY
    Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    If inRelX <> RelX Or inRelY <> RelY Then
        Call IntegrateXOvers(0)
        UpdateIDFlag = 0: PermXVal = 0: PermYVal = 0
        XP = RelX: YP = RelY: PermXVal = 0: PermYVal = 0
        Call GoToThis2(1, XP, YP, PermXVal, PermYVal)
    End If
    Form1.ProgressBar1 = 98
    Call UpdateF2Prog
    Form1.WindowState = Form1.WindowState
    
    If RIMode = 0 Then
        Call MakeRecombinationInfo(RelX, RelY)
    End If
    
    UpdateIDFlag = 0
End If


Form1.SSPanel1.Caption = ""

Form1.ProgressBar1 = 0
Call EnableInterface
Call UpdateF2Prog

Form1.Enabled = True
Form2.ZOrder
Screen.MousePointer = 0
DontSaveUndo = 0

UpdateProgressBar = 0


End Sub

Private Sub MarkAsHavingEventMnu_Click()
 
Form1.SSPanel1.Caption = "Marking sequences"
Call UpdateF2Prog
 
     If DontSaveUndo = 0 Then
        Call SaveUndo
        DontSaveUndo = 1
    End If
 
 Call UnModNextno
 ReassignPFlag = 0
 Dim NodeFind() As Byte, OVal As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    Dim EN As Long
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    
    OVal = XOMiMaInFileFlag
    XOMiMaInFileFlag = 0
    SS = Abs(GetTickCount)
    If OVal = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
        
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        Form1.ProgressBar1.Value = 5
        Form1.SSPanel1.Caption = "Loading minor parent groups from disk"
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        ReDim BestXOListMi(PermNextno, UBXOMi)
        ReDim BestXOListMa(PermNextno, UBXoMa)
        UBXoMa = UBound(BestXOListMa, 2)
        If MiRec < 1 Then
            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
            Get #FF, , BestXOListMi()
            Close #FF
            MiRec = 1
        End If
        Form1.SSPanel1.Caption = "Loading major parent groups from disk"
        Form1.ProgressBar1.Value = 25
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        If MaRec < 1 Then
            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
            Get #FF, , BestXOListMa()
            Close #FF
            MaRec = 1
        End If
        
        ChDrive oDirX
        ChDir oDirX
        
    End If
    EE = Abs(GetTickCount)
    TT = EE - SS
    Form1.SSPanel1.Caption = "Marking sequences"
    Form1.ProgressBar1.Value = 45
    Call UpdateF2Prog
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Form2.Refresh
    Call UnModNextno
    If SelectNode(4) = 0 Then
        EE = Abs(GetTickCount)
        Dim LastFind
        LastFind = -1
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) = 0 Then
                    LastFind = x
                End If
            End If
        Next x
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) = 0 Then
                    F2P2SNum = -x - 1
                    If x <> LastFind Then
                        MassMarkFlag = 1
                    Else
                        MassMarkFlag = 0
                    End If
                    odsu = DontSaveUndo
                    DontSaveUndo = 1
                    GTMass = 1
                    Call MUMnu_Click
                    GTMass = 0
                    DontSaveUndo = odsu
                    
                    
                    If MassMarkFlag = 0 Then Exit For
                    'ColourSeq(X) = 1
                    'MultColour(X) = SelCol
                End If
            End If
            SS = Abs(GetTickCount)
            If SS - EE > 500 Then
                If LastFind > -1 Then
                    Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
                    Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
                    Call UpdateF2Prog
                End If
                EE = SS
                Form2.Refresh
                Form1.Refresh
                If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
                
            End If
            
        Next x
        
        MassMarkFlag = 0
        If LastFind > -1 Then
            Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
            Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
            Call UpdateF2Prog
        End If
        EE = SS
        Form2.Refresh
        Form1.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Else
        
        LastFind = -1
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) = 0 Then
                    LastFind = x
                End If
            End If
        Next x
        EE = Abs(GetTickCount)
        
        For x = 0 To PermNextno '10,153:10,107:10,82
            Call ModNextno
            'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) = 0 Then
                    F2P2SNum = -TreeTrace(TreeTraceSeqs(1, x)) - 1
                    If x <> LastFind Then
                        MassMarkFlag = 1
                    Else
                        MassMarkFlag = 0
                    End If
                    'Call MUMnu_Click
                    
                    odsu = DontSaveUndo
                    DontSaveUndo = 1
                    GTMass = 1
                    Call MUMnu_Click
                    GTMass = 0
                    DontSaveUndo = odsu
                    
                    
                    If MassMarkFlag = 0 Then Exit For
                End If
            End If
            SS = Abs(GetTickCount)
            If SS - EE > 500 Then
                If LastFind > -1 Then
                    Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
                    Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
                    Call UpdateF2Prog
                End If
                EE = SS
                Form2.Refresh
                Form1.Refresh
                If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
                
            End If
        Next x
        MassMarkFlag = 0
        If LastFind > -1 Then
            Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
            Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
            Call UpdateF2Prog
        End If
        EE = SS
        Form2.Refresh
        Form1.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    End If
    UnModNextno
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    
    
    
    If OVal = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
       
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        Form1.ProgressBar1.Value = 60
        Form1.SSPanel1.Caption = "Writing minor parent groups to disk"
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        
        UBXOMi = UBound(BestXOListMi, 2)
        UBXoMa = UBound(BestXOListMa, 2)
        Open "RDP5BestXOListMi" + UFTag For Binary As #FF
        Put #FF, , BestXOListMi()
        Close #FF
        MiRec = MiRec - 1
        
        Form1.SSPanel1.Caption = "Writing major parent groups to disk"
        Form1.ProgressBar1.Value = 80
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        
        Open "RDP5BestXOListMa" + UFTag For Binary As #FF
        Put #FF, , BestXOListMa()
        Close #FF
        
        Erase BestXOListMi
        Erase BestXOListMa
        MaRec = MaRec - 1
        ChDrive oDirX
        ChDir oDirX
        Form1.ProgressBar1.Value = 100
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
    End If
    
    XOMiMaInFileFlag = OVal
    
    UnModNextno
    Call IntegrateXOvers(0)
    Form1.Timer1.Enabled = True
    If RIMode = 1 Then
    Call MakeSummary
    End If
    x = x
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
    
    Form2.WindowState = 0
    DontSaveUndo = 0
End Sub

Private Sub MarkAsNotHavingEventMnu_Click()

Form1.SSPanel1.Caption = "Unmarking sequences"
Call UpdateF2Prog
If DontSaveUndo = 0 Then
    Call SaveUndo
    DontSaveUndo = 1
End If

Call UnModNextno
    Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    Dim EN As Long
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    OVal = XOMiMaInFileFlag
    XOMiMaInFileFlag = 0
    If OVal = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
       
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        ReDim BestXOListMi(PermNextno, UBXOMi)
        ReDim BestXOListMa(PermNextno, UBXoMa)
        
        Form1.ProgressBar1.Value = 5
        Form1.SSPanel1.Caption = "Loading minor parent groups from disk"
        Call UpdateF2Prog
        
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        If MiRec < 1 Then
            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
            Get #FF, , BestXOListMi()
            Close #FF
            MiRec = 1
        End If
        Form1.SSPanel1.Caption = "Loading major parent groups from disk"
        Form1.ProgressBar1.Value = 25
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        If MaRec < 1 Then
            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
            Get #FF, , BestXOListMa()
            Close #FF
            MaRec = 1
        End If
        ChDrive oDirX
        ChDir oDirX
        
    End If
    
    Form1.SSPanel1.Caption = "Unmarking sequences"
    Form1.ProgressBar1.Value = 45
    Call UpdateF2Prog
    
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Form2.Refresh
    Call UnModNextno
    ReassignPFlag = 0
    If SelectNode(4) = 0 Then '2
        EE = Abs(GetTickCount)
        Dim LastFind
        LastFind = -1
        For x = 0 To NextNo
             If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) > 0 Then
                    LastFind = x
                End If
            End If
        Next x
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) > 0 Then
                    F2P2SNum = -x - 1
                    If x <> LastFind Then
                        MassMarkFlag = 1
                    Else
                        MassMarkFlag = 0
                    End If
                    'Call MUMnu_Click
                    odsu = DontSaveUndo
                    DontSaveUndo = 1
                    GTMass = 1
                    Call MUMnu_Click
                    GTMass = 0
                    DontSaveUndo = odsu
                    
                    If MassMarkFlag = 0 Then Exit For
                End If
            End If
            SS = Abs(GetTickCount)
            If SS - EE > 500 Then
                If LastFind > -1 Then
                    Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences unmarked"
                    Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
                    Call UpdateF2Prog
                End If
                EE = SS
                Form2.Refresh
                Form1.Refresh
                If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
                
            End If
        Next x
        MassMarkFlag = 0
        If LastFind > -1 Then
            Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
            Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
            Call UpdateF2Prog
        End If
        EE = SS
        Form2.Refresh
        Form1.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    Else
    
        EE = Abs(GetTickCount)
        
        LastFind = -1
        'Call ModSeqNum(0, 0, 0)
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) > 0 Then
                    LastFind = x
                End If
            End If
        Next x
        'XX = PermNextno
        For x = 0 To NextNo '10,153:10,107:10,82
            'Call ModSeqNum(0, 0, 0) 'this needs to be remodded every cycle because MuMnu_Click unmods it
            Call ModNextno
            'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            
'            If TreeTrace(TreeTraceSeqs(1, X)) - 1 = 208 Then
'                X = X
'            End If
            
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) > 0 Then
                    F2P2SNum = -TreeTrace(TreeTraceSeqs(1, x)) - 1
                    If x <> LastFind Then
                        MassMarkFlag = 1
                    Else
                        MassMarkFlag = 0
                    End If
                    
                    odsu = DontSaveUndo
                    DontSaveUndo = 1
                    If Abs(F2P2SNum + 1) <> RelX Then
                        GTMass = 1
                        Call MUMnu_Click
                        GTMass = 0
                    End If
                    DontSaveUndo = odsu
                    
                    If MassMarkFlag = 0 Then Exit For
                End If
            End If
            SS = Abs(GetTickCount)
            If SS - EE > 500 Then
                If LastFind > -1 Then
                    Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences unmarked"
                    Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
                    Call UpdateF2Prog
                End If
                EE = SS
                Form2.Refresh
                Form1.Refresh
                If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
                If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
                
            End If
        Next x
        MassMarkFlag = 0
        If LastFind > -1 Then
            Form1.SSPanel1.Caption = Trim(Str(CInt((x / LastFind) * 100))) + "% of sequences marked"
            Form1.ProgressBar1.Value = 45 + (x / LastFind) * 15
            Call UpdateF2Prog
        End If
        EE = SS
        Form2.Refresh
        Form1.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    End If
    UnModNextno
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    UnModNextno
    
    Call IntegrateXOvers(0)
'    For X = 0 To Nextno '693,1; 703,1
'        If BCurrentXoverMa(X) > 0 Then
'
'            For Y = 1 To BCurrentXoverMa(X)
'                If BestXOListMa(X, Y).Eventnumber = 0 Then '709,12
'
'                    X = X
'                End If
'            Next Y
'        End If
'    Next X
    If OVal = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
       
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        Form1.ProgressBar1.Value = 60
        Form1.SSPanel1.Caption = "Writing minor parent groups to disk"
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        
        UBXOMi = UBound(BestXOListMi, 2)
        UBXoMa = UBound(BestXOListMa, 2)
        
        Open "RDP5BestXOListMi" + UFTag For Binary As #FF
        Put #FF, , BestXOListMi()
        Close #FF
        MiRec = MiRec - 1
        
        Form1.SSPanel1.Caption = "Writing major parent groups to disk"
        Form1.ProgressBar1.Value = 80
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
        
        Open "RDP5BestXOListMa" + UFTag For Binary As #FF
        Put #FF, , BestXOListMa()
        Close #FF
        MaRec = MaRec - 1
        
        Erase BestXOListMa
        Erase BestXOListMi
        
        ChDrive oDirX
        ChDir oDirX
        Form1.ProgressBar1.Value = 100
        Call UpdateF2Prog
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form2.Refresh
    End If
    XOMiMaInFileFlag = OVal
    If RIMode = 1 Then
        Call MakeSummary
    End If
    Form1.Timer1.Enabled = True
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
     
    DontSaveUndo = 0
End Sub

Private Sub MLMnu2_Click()

    Dim TD() As Double, TTDistance() As Single, tAVDST As Double
    ReDim TTDistance(0, 0)
If F2TreeIndex = 3 Then
    Call DrawML5(Form2.Picture2(3), 5)
Else
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Calculating Tree Dimensions"
    Form1.ProgressBar1.Value = 5
    Call UpdateF2Prog
    LenStrainSeq = Len(StrainSeq(0)) + 1
    If BSTreeStrat < 4 Then 'only do this for phyml
        
        ReDim TTDistance(NextNo, NextNo)
        If F2TreeIndex <> 0 Then
        'Call ModSeqNum(0)
            Call ModNextno
            ReDim TTDistance(NextNo, NextNo)
            Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, TreeSeqNum(0, 0), TTDistance(0, 0), tAVDST)
            
        
        
        Else
            Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, SeqNum(0, 0), TTDistance(0, 0), tAVDST)
        
        End If
        
        
        
        
        For x = 0 To NextNo
        
            For Y = x + 1 To NextNo
                If x > 390 Then
                    x = x
                End If
                If ((1 - TTDistance(x, Y)) / 0.75) < 1 Then
        
                    If 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75)))) > 0 Then
                        TTDistance(x, Y) = 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75))))
                    Else
                        TTDistance(x, Y) = 0
                    End If
        
                Else
                    TTDistance(x, Y) = 0
                End If
        
                TTDistance(Y, x) = TTDistance(x, Y)
            Next 'Y
        
        Next 'X
    Else
        
        If F2TreeIndex <> 0 Then
            Call ModNextno
        End If
        
        'Call UnModNextno
       
    End If
    
        ReDim TempSeq(NextNo + 2)
    
    If F2TreeIndex = 0 Then
        For x = 0 To NextNo
    
           
                TempSeq(x) = StrainSeq(x)
            
    
        Next 'X
    Else
        Dim tStrainseq() As String
        ReDim tStrainseq(NextNo)
        For x = 0 To NextNo
            tStrainseq(x) = String(Len(StrainSeq(0)), " ")
        
        Next x
        
        UB = UBound(TreeSeqNum, 1)
        If UB < Len(StrainSeq(0)) Then Exit Sub
        'UB2 = UBound(TreeSeqNum, 2)
        'ReDim Preserve TreeSeqNum(UB, Nextno)
        For x = 0 To NextNo
            'If X > 390 Then
            '    X = X
            'End If
            For Y = 1 To Len(StrainSeq(0))
                
                Mid(tStrainseq(x), Y, 1) = Chr(TreeSeqNum(Y, x) - 1)
            
            Next Y
        Next x
        If F2TreeIndex = 2 Then
            BTree = XoverList(RelX, RelY).Beginning
            ETree = XoverList(RelX, RelY).Ending
        Else
            ETree = XoverList(RelX, RelY).Beginning - 1
            BTree = XoverList(RelX, RelY).Ending + 1
        End If
        For x = 0 To NextNo
            If BTree < ETree Then
                TempSeq(x) = Mid$(tStrainseq(x), BTree, ETree - BTree)
            Else
                TempSeq(x) = Mid$(tStrainseq(x), BTree, Len(StrainSeq(0)) - BTree)
                TempSeq(x) = TempSeq(x) + Mid$(tStrainseq(x), 1, ETree)
            End If
        Next x
    End If

    ReDim TD(NextNo)
    
    If DebuggingFlag < 2 Then On Error Resume Next
    UB = 0
    
    UB = UBound(TTDistance, 2)
    On Error GoTo 0
    If UB <= NextNo And UB > 0 Then
        
        For x = 0 To NextNo
    
            For Y = 0 To NextNo
                TD(x) = TD(x) + TTDistance(x, Y)
            Next 'Y
    
        Next 'X
    Else
        For x = 0 To NextNo
    
            For Y = 0 To NextNo
                TD(x) = TD(x) + (Distance(x, Y))
            Next 'Y
    
        Next 'X
    
    End If
    MD = NextNo

    For x = 0 To NextNo

        If TD(x) < MD Then
            MD = TD(x)
            Outie = x
        End If

    Next 'X

    Dim OCurTree As Integer

    OCurTree = CurTree(F2TreeIndex)
    CurTree(F2TreeIndex) = 3

    If F2TreeIndex = 0 And DoneTree(3, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 2 And DoneTree(3, F2TreeIndex) = 1 Then
    ElseIf F2TreeIndex = 1 And DoneTree(3, F2TreeIndex) = 1 Then
    Else

        Call Deactivate
        Call NJTree2(3)
        Call Reactivate

        If AbortFlag = 1 Then
            Form1.ProgressBar1.Value = 0
            Form1.SSPanel1.Caption = ""
            Call UpdateF2Prog
            Screen.MousePointer = 0
            If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
                Call UnModNextno
                Call UnModSeqNum(0)
            End If
            AbortFlag = 0
            Form2.Command2.Enabled = False
            CurTree(F2TreeIndex) = OCurTree
            Exit Sub
        End If
        ExtraDX = DoTreeColour(Picture2(F2TreeIndex), 3, F2TreeIndex)
        'DoTreeLegend treeblocksl(), TBLLen, Picture2(F2TreeIndex), ExtraDx, 14
    End If
    Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(F2TreeIndex).Value, F2TreeIndex, 3, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(F2TreeIndex))
    For x = 0 To 4
        TTFlag(F2TreeIndex, x) = 0
    Next 'X

    TTFlag(F2TreeIndex, 3) = 1
    Form1.ProgressBar1.Value = 100
    Call UpdateF2Prog
     Dim TMX As String
    Call GetModelString(TMX)
    If F2TreeIndex = 0 Then
        Label1(0).Caption = "ML " + TMX + " tree ignoring recombination"
    ElseIf F2TreeIndex = 2 Then
        'Label1(2).Caption = "ML " + TMX + " tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Label1(2).Caption = "ML " + TMX + " tree of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Label1(2).Caption = "ML " + TMX + " tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf F2TreeIndex = 1 Then
        'Label1(2).Caption = "ML " + TMX + " tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form2.Label1(1) = "ML " + TMX + " tree of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of recombinant region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form2.Label1(1) = "ML " + TMX + " tree of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form2.Label1(1) = "ML " + TMX + " tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    End If
    Screen.MousePointer = 0
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
    If F2TreeIndex <> 0 Then UnModNextno
    x = x
End If
End Sub

Private Sub MUMnu_Click()
If DontSaveUndo = 0 Then
    Call SaveUndo
End If

Dim Seqno As Long, RCol As Long, TBFlag As Byte, SEN As Long, WinY As Long

If ReassignPFlag > 0 Then
    If ReassignPFlag = 1 Then
        ReassignPFlag = 1 'swap major parent and recombinant
        If ReassortmentFlag = 0 Then
            Form1.SSPanel1.Caption = "Swaping recombinant and major parent"
            Form2.SSPanel3.Caption = "Swaping recombinant and major parent"
        Else
            Form1.SSPanel1.Caption = "Swaping recombinant/reassortnant and major parent"
            Form2.SSPanel3.Caption = "Swaping recombinant/reassortnant and major parent"
        End If
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        
        Form1.Timer6.Enabled = True
    ElseIf ReassignPFlag = 2 Then
        ReassignPFlag = 2 'swap the recombinant and the minorp
        If ReassortmentFlag = 0 Then
            Form1.SSPanel1.Caption = "Swaping recombinant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant and minor parent"
        Else
            Form1.SSPanel1.Caption = "Swaping recombinant/reassortnant and minor parent"
            Form2.SSPanel3.Caption = "Swaping recombinant/reassortnant and minor parent"
        End If
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form1.Timer6.Enabled = True
    End If
    'check and make sure that the minorp/majorp swap data is stored in the correct array (or else change reassignpflag)
    
    
    Exit Sub
End If



SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
If F2P2SNum < 0 Then
    Seqno = Abs(F2P2SNum + 1) 'this is a workaround to force this to work with a specific f2p2snum when this routine is called from elsewhere
Else
    Seqno = TreeTrace(F2P2SNum)
End If
If Seqno = XoverList(BestEvent(SEN, 0), BestEvent(SEN, 1)).Daughter Then GoTo DoTreeSection

Dim TargetD As Long
TargetD = BestEvent(SEN, 0)

If XoverList(RelX, RelY).Accept = 1 Then
    AcceptChangeFlag = 2
    Form1.Command10.Enabled = True
ElseIf AcceptChangeFlag = 0 Then
    AcceptChangeFlag = 1
End If

If Seqno <= UBound(Daught, 2) Then
    
    If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
        Screen.MousePointer = 11
        Form1.SSPanel1.Caption = "Loading minor parent lists from disk"
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        ReDim BestXOListMi(PermNextno, UBXOMi)
        ReDim BestXOListMa(PermNextno, UBXoMa)
        UBXoMa = UBound(BestXOListMa, 2)
        Form1.ProgressBar1.Value = 2
        Call UpdateF2Prog
        If MiRec < 1 Then
            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
            Get #FF, , BestXOListMi()
            Close #FF
            MiRec = 1
        End If
        Form1.ProgressBar1.Value = 25
        
        Form1.SSPanel1.Caption = "Loading major parent lists from disk"
        Call UpdateF2Prog
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        Form1.ProgressBar1.Value = 45
        Call UpdateF2Prog
        If MaRec < 1 Then
            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
            Get #FF, , BestXOListMa()
            Close #FF
            MaRec = 1
        End If
        ChDrive oDirX
        ChDir oDirX
        Form1.SSPanel1.Caption = "Updating lists"
        Form2.SSPanel3.Caption = "Updating lists"
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    End If
    
    

    If Daught(SEN, Seqno) > 0 And Seqno <= PermNextno Then ' mark this as not having evidence
        If NextNo <> PermNextno Then
        
            Call UnModNextno
        End If
        TBFlag = 0
        RCol = BackColours
        
        
        If x = x Then 'this way simply deletes the signal
'            If Seqno = 90 Then
'                X = X
'            End If
'            'mark all instances of this seqno for removal
            Dim PrF As Long
            If RelX <> Seqno Then
                
                For Y = 0 To CurrentXOver(Seqno)
                    If SuperEventList(XoverList(Seqno, Y).Eventnumber) = SEN Then '7,8,9
                        'If (RelX <> Seqno) Then  'And (Seqno <> BestEvent(SEN, 0) Or Y <> BestEvent(SEN, 1)) Then 'only dele it if it is not the currently selected event
                            XoverList(Seqno, Y).Probability = -1
                        'End If
                    End If
                Next Y
            End If
            For x = 0 To PermNextno
                For Y = 0 To BCurrentXoverMi(x)
                    If BestXOListMi(x, Y).MinorP = Seqno And BestXOListMi(x, Y).MinorP <> RelX Then
                        If SuperEventList(BestXOListMi(x, Y).Eventnumber) = SEN Then
                            BestXOListMi(x, Y).Probability = -1
                        End If
                    End If
                Next Y
                For Y = 0 To BCurrentXoverMa(x)
                    If BestXOListMa(x, Y).MajorP = Seqno And BestXOListMa(x, Y).MajorP <> RelX Then
                        If SuperEventList(BestXOListMa(x, Y).Eventnumber) = SEN Then
                            BestXOListMa(x, Y).Probability = -1
                        End If
                    End If
                Next Y
            Next x
            x = x
            'actually erase old versions of records
            Call CleanXOList(SEN, XoverList(), CurrentXOver(), Daught())
            Call CleanXOList(SEN, BestXOListMi(), BCurrentXoverMi(), MinorPar())
            Call CleanXOList(SEN, BestXOListMa(), BCurrentXoverMa(), MajorPar())
            
            BestEvent(SEN, 0) = 0
            BestEvent(SEN, 1) = 0
            Call MakeBestEvent 'need to do this because, with all the deletions, some of the bestevents for other events may have gotten messed up (also recalculates confirm etc)
            
            'can only remove daught here because entries are needed to clean up xolist
            Daught(SEN, Seqno) = 0
            If Seqno <= UBound(uDaught, 2) Then 'need to also remove it from udaught (which is used as a backup of daught
                uDaught(SEN, Seqno) = 0
            End If
            
        Else 'this way adds the signal to the end of the seventist - it is a massive nightmare
          Daught(SEN, Seqno) = 0
            If Seqno <= UBound(uDaught, 2) Then 'need to also remove it from udaught (which is used as a backup of daught
                uDaught(SEN, Seqno) = 0
            End If
          SEventNumber = SEventNumber + 1
           If UBound(uDaught, 1) >= SEN Then
               If UBound(uDaught, 2) >= Seqno Then
                   uDaught(SEN, Seqno) = 0
               End If
           End If
           
           For Y = 1 To CurrentXOver(Seqno)
               If SuperEventList(XoverList(Seqno, Y).Eventnumber) = SEN Then
                   SuperEventList(XoverList(Seqno, Y).Eventnumber) = SEventNumber
                   XoverList(Seqno, Y).Accept = 0
               End If
           Next Y
           
           'XX = RelX
           'XX = RelY
           'XX = SuperEventList(XOverlist(RelX, RelY).Eventnumber)
           Dim UBSEL As Long
           UBSEL = UBound(SuperEventList, 1)
           For x = 0 To PermNextno
               For Y = 1 To BCurrentXoverMi(x)
                   If BestXOListMi(x, Y).Eventnumber <= UBSEL Then
                   If SuperEventList(BestXOListMi(x, Y).Eventnumber) = SEN Then
                       If BestXOListMi(x, Y).MajorP = Seqno Or BestXOListMi(x, Y).MinorP = Seqno Then
                           BestXOListMi(x, Y).Accept = 0
                       ElseIf BestXOListMi(x, Y).MajorP = TargetD Or BestXOListMi(x, Y).MinorP = TargetD Then
                           BCurrentXoverMi(x) = BCurrentXoverMi(x) + 1
                           If UBound(BestXOListMi, 2) < BCurrentXoverMi(x) Then
                               UB = UBound(BestXOListMi, 1)
                               UB2 = BCurrentXoverMi(x) + 20
                               ReDim Preserve BestXOListMi(UB, UB2)
                           End If
                           BestXOListMi(x, BCurrentXoverMi(x)) = BestXOListMi(x, Y)
                           If BestXOListMi(x, BCurrentXoverMi(x)).MajorP = TargetD Then BestXOListMi(x, BCurrentXoverMi(x)).MajorP = Seqno
                           If BestXOListMi(x, BCurrentXoverMi(x)).MinorP = TargetD Then BestXOListMi(x, BCurrentXoverMi(x)).MinorP = Seqno
                           Eventnumber = Eventnumber + 1
                           BestXOListMi(x, BCurrentXoverMi(x)).Eventnumber = Eventnumber
                           If UBound(SuperEventList, 1) < Eventnumber Then
                               ReDim Preserve SuperEventList(Eventnumber + 100)
                           End If
                           
                           SuperEventList(BestXOListMi(x, BCurrentXoverMi(x)).Eventnumber) = SEventNumber
                           
                           'XX = SuperEventList(XOverlist(RelX, RelY).Eventnumber)
                           
                           BestXOListMi(x, Y).Accept = 0
                           
                       End If
                   End If
                   End If
               Next Y
               
               
               For Y = 1 To BCurrentXoverMa(x)
                   If BestXOListMa(x, Y).Eventnumber <= UBSEL Then
                   If SuperEventList(BestXOListMa(x, Y).Eventnumber) = SEN Then
                       If BestXOListMa(x, Y).MajorP = Seqno Or BestXOListMa(x, Y).MinorP = Seqno Then
                           
                           'SuperEventList(BestXOListMa(X, Y).Eventnumber) = SEventNumber
                           BestXOListMa(x, Y).Accept = 0
                           
                       ElseIf BestXOListMa(x, Y).MajorP = TargetD Or BestXOListMa(x, Y).MinorP = TargetD Then
                           
                           BCurrentXoverMa(x) = BCurrentXoverMa(x) + 1
                           If UBound(BestXOListMa, 2) < BCurrentXoverMa(x) Then
                               UB = UBound(BestXOListMa, 1)
                               UB2 = BCurrentXoverMa(x) + 20
                               ReDim Preserve BestXOListMa(UB, BCurrentXoverMa(x))
                           End If
                           BestXOListMa(x, BCurrentXoverMa(x)) = BestXOListMa(x, Y)
                           If BestXOListMa(x, BCurrentXoverMa(x)).MajorP = TargetD Then BestXOListMa(x, BCurrentXoverMa(x)).MajorP = Seqno
                           If BestXOListMa(x, BCurrentXoverMa(x)).MinorP = TargetD Then BestXOListMa(x, BCurrentXoverMa(x)).MinorP = Seqno
                           
                           Eventnumber = Eventnumber + 1
                           BestXOListMa(x, BCurrentXoverMa(x)).Eventnumber = Eventnumber
                           
                           If UBound(SuperEventList, 1) < Eventnumber Then
                               ReDim Preserve SuperEventList(Eventnumber + 100)
                           End If
                          
                           SuperEventList(BestXOListMa(x, BCurrentXoverMa(x)).Eventnumber) = SEventNumber
                           'If SuperEventList(XOverlist(RelX, RelY).Eventnumber) <> 1 Then
                           '    X = X
                           'End If
                           BestXOListMa(x, Y).Accept = 0
                          
                       End If
                       
                   End If
                   End If
               Next Y
           Next x
           
           
           
        
          
           
           'because seventnumber has changed I need to make backups of stuff, redim and copy things back over
           Dim oD() As Byte, oMi() As Byte, oMa() As Byte, OBE() As Long
           
           ReDim oD(SEventNumber, NextNo), oMa(SEventNumber, NextNo), oMi(SEventNumber, NextNo), OBE(SEventNumber, 1)
           ReDim Preserve DScores(25, 2, SEventNumber)
           For x = 0 To 25
               For Y = 0 To 2
                   DScores(x, Y, SEventNumber) = DScores(x, Y, SEN)
               Next Y
           Next x
           If x = x Then
               Dummy = CopyEventInfo(SEventNumber, NextNo, UBound(Daught, 1), UBound(oD, 1), UBound(OBE, 1), UBound(BestEvent, 1), OBE(0, 0), BestEvent(0, 0), Daught(0, 0), MinorPar(0, 0), MajorPar(0, 0), oD(0, 0), oMi(0, 0), oMa(0, 0))
               'Dummy = CopyEventInfo(SEventNumber, Nextno, UBound(oD, 1), UBound(Daught, 1), UBound(BestEvent, 1), UBound(OBE, 1), BestEvent(0, 0), OBE(0, 0), oD(0, 0), oMi(0, 0), oMa(0, 0), Daught(0, 0), MinorPar(0, 0), MajorPar(0, 0))
           Else
               For x = 0 To SEventNumber - 1
                   For Y = 0 To NextNo
                       oD(x, Y) = Daught(x, Y)
                       oMi(x, Y) = MinorPar(x, Y)
                       oMa(x, Y) = MajorPar(x, Y)
                   Next Y
                   OBE(x, 0) = BestEvent(x, 0)
                   OBE(x, 1) = BestEvent(x, 1)
               Next x
           End If
           ReDim Daught(SEventNumber, NextNo), MinorPar(SEventNumber, NextNo + 1), MajorPar(SEventNumber, NextNo + 1)
           ReDim BestEvent(SEventNumber, 1)
           ReDim Preserve NOPINI(2, SEventNumber)
           ReDim Preserve TreeTestStats(3, SEventNumber)
           For x = 0 To 2
               NOPINI(x, SEventNumber) = NOPINI(x, SEN)
           Next x
           For x = 0 To 3
               TreeTestStats(x, SEventNumber) = TreeTestStats(x, SEN)
           Next x
           If x = x Then
               Dummy = CopyEventInfo(SEventNumber, NextNo, UBound(oD, 1), UBound(Daught, 1), UBound(BestEvent, 1), UBound(OBE, 1), BestEvent(0, 0), OBE(0, 0), oD(0, 0), oMi(0, 0), oMa(0, 0), Daught(0, 0), MinorPar(0, 0), MajorPar(0, 0))
           Else
               For x = 0 To SEventNumber - 1
                   For Y = 0 To NextNo
                       Daught(x, Y) = oD(x, Y)
                       MinorPar(x, Y) = oMi(x, Y)
                       MajorPar(x, Y) = oMa(x, Y)
                   Next Y
                   BestEvent(x, 0) = OBE(x, 0)
                   BestEvent(x, 1) = OBE(x, 1)
               Next x
           End If
           'XX = PermNextno
           If Seqno <= UBound(Daught, 2) Then
           
               Daught(SEventNumber, Seqno) = 1
           End If
           For x = 0 To NextNo
               MinorPar(SEventNumber, x) = MinorPar(SEN, x)
               MajorPar(SEventNumber, x) = MajorPar(SEN, x)
           Next x
           
           'update the event status in the bigtrees
           
           If DebuggingFlag < 2 Then On Error Resume Next
           UB = 0
           UB = UBound(BigTreeTraceEvent, 1)
           If UB > 0 Then
               BigTreeTraceEvent(Seqno) = SEventNumber
           End If
           If CurTree(3) = 2 Or CurTree(3) = 3 Then
               Call DrawML5(Form2.Picture2(3), 5)
           ElseIf CurTree(3) = 4 Then
               Call DrawML5(Form2.Picture2(3), 4)
           End If
           UB = 0
           UB = UBound(BigTreeTraceEventU, 1)
           If UB > 0 Then
               BigTreeTraceEventU(Seqno) = SEventNumber
           End If
           
           'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
           
           
           
           If CurTree(3) = 1 Then Call DrawML7(Form2.Picture2(3)) ' DrawFastNJ5(Form2.Picture2(3))
           
           
           On Error GoTo 0
           'XX = UBound(BPCIs, 2)
           If UBound(BPCIs, 2) < SEventNumber Then
               ReDim Preserve BPCIs(9, SEventNumber + 20)
           End If
           For x = 0 To 9
               BPCIs(x, SEventNumber) = BPCIs(x, SEN)
           Next x
           If x = x Then
               MinPx = 10000: WinY = -1
               Call PassXOInfoOver(SEventNumber, SEN, Seqno, MinPx, WinY, CurrentXOver(), XoverList(), Confirm(), ConfirmP())
               
               BestEvent(SEventNumber, 0) = Seqno
               BestEvent(SEventNumber, 1) = WinY
               Call PassXOInfoOver(SEventNumber, SEN, Seqno, MinPx, WinY, BCurrentXoverMi(), BestXOListMi(), ConfirmMi(), ConfirmPMi())
               Call PassXOInfoOver(SEventNumber, SEN, Seqno, MinPx, WinY, BCurrentXoverMa(), BestXOListMa(), ConfirmMa(), ConfirmPMa())
               
               
               
           Else
           
               For x = 1 To CurrentXOver(Seqno)
                   If SuperEventList(XoverList(Seqno, x).Eventnumber) = SEventNumber Then
                       
                       If XoverList(Seqno, x).Probability < MinPx And XoverList(Seqno, x).Probability > 0 Then
                           MinPx = XoverList(Seqno, x).Probability
                           WinY = x
                       End If
                       'Update confirms etc.
                       PN = XoverList(Seqno, x).ProgramFlag
                       If PN > AddNum - 1 Then PN = PN - AddNum
                       'Confirm(SEN, PN) = Confirm(SEN, PN) - 1
                       Confirm(SEventNumber, PN) = 1
                       'ConfirmP(SEN, PN) = ConfirmP(SEN, PN) - (-Log10(XOverlist(Seqno, X).Probability))
                       ConfirmP(SEventNumber, PN) = (-Log10(XoverList(Seqno, x).Probability))
                   End If
               
               Next x
               BestEvent(SEventNumber, 0) = Seqno
               BestEvent(SEventNumber, 1) = WinY
           End If
           'bestxolistmi(
           'update steps
           Steps(4, 0) = SEventNumber
           For x = 1 To StepNo - 1
           'XX = Steps(4, 38)
               If Steps(4, x) = SEN + 1 Then
                   x = x
                   If Steps(1, x) = Seqno Then
                       x = x
                       
                       If StepNo > UBound(Steps, 2) Then
                           ReDim Preserve Steps(4, StepNo + 100)
                       End If
                       Steps(0, StepNo) = Steps(0, x)
                       Steps(1, StepNo) = Steps(1, x)
                       Steps(2, StepNo) = Steps(2, x)
                       Steps(3, StepNo) = Steps(3, x)
                       Steps(4, StepNo) = SEventNumber + 1
                       Steps(0, x) = -1
                       StepNo = StepNo + 1

                   End If
               End If
           Next x
        
        End If
    ElseIf Daught(SEN, Seqno) = 0 And Seqno <= PermNextno Then
        TBFlag = 1
        
        HCg = BkG + (255 - BkG) / 2
        QCg = BkG + (255 - BkG) / 4
        ECg = BkG - (BkG) / 4
                        
        HCb = BkB + (255 - BkB) / 2
        QCb = BkB + (255 - BkB) / 4
        ECb = BkB - (BkB) / 4
                        
        HCr = BkR + (255 - BkR) / 2
        QCr = BkR + (255 - BkR) / 4
        ECr = BkR - (BkR) / 4
        
        RCol = RGB(QCr, 200, 200)
        Eventnumber = Eventnumber + 1
        ReDim Preserve SuperEventList(Eventnumber)
        
        SuperEventList(Eventnumber) = SEN
        
        
        Daught(SEN, Seqno) = 5 'initially make this a trace event
        If UBound(uDaught, 1) >= SEN Then
            If UBound(uDaught, 2) >= Seqno Then
                uDaught(SEN, Seqno) = 5
            End If
        End If
        CurrentXOver(Seqno) = CurrentXOver(Seqno) + 1
        UB = UBound(XoverList, 1)
        If UBound(XoverList, 2) < CurrentXOver(Seqno) Then
            ReDim Preserve XoverList(UB, CurrentXOver(Seqno) + 20)
        End If
        'XX = UBound(XOverlist, 2)
        XoverList(Seqno, CurrentXOver(Seqno)) = XoverList(RelX, RelY)
        XoverList(Seqno, CurrentXOver(Seqno)).Daughter = Seqno
        XoverList(Seqno, CurrentXOver(Seqno)).Eventnumber = Eventnumber
        XoverList(Seqno, CurrentXOver(Seqno)).Probability = 1
        XoverList(Seqno, CurrentXOver(Seqno)).DHolder = Abs(XoverList(Seqno, CurrentXOver(Seqno)).DHolder)
        'XX = XoverList(Seqno, CurrentXOver(Seqno)).BeginP
        'XoverList(Seqno, CurrentXOver(Seqno)).EndP = 1
        
        mP = XoverList(RelX, RelY).MinorP
        'OMP = MP
        If mP > PermNextno Then
            x = x
            Dim DCV1 As Long, DCV2 As Long
            Call SplitP(-XoverList(RelX, RelY).BeginP, DCV1, DCV2)
            If DCV2 = mP Then
                mP = WhereIsExclude(DCV1)
            Else
                Call SplitP(-XoverList(RelX, RelY).EndP, DCV1, DCV2)
                mP = WhereIsExclude(DCV1)
            End If
        End If
        
        BCurrentXoverMi(mP) = BCurrentXoverMi(mP) + 1
        
        UB = UBound(BestXOListMi, 1)
        If UBound(BestXOListMi, 2) < BCurrentXoverMi(mP) Then
            ReDim Preserve BestXOListMi(UB, BCurrentXoverMi(mP) + 20)
        End If
        'BestXOListMi(MP, BCurrentXoverMi(MP)) = XoverList(RelX, RelY)
        BestXOListMi(mP, BCurrentXoverMi(mP)) = XoverList(Seqno, CurrentXOver(Seqno))
        BestXOListMi(mP, BCurrentXoverMi(mP)).Daughter = XoverList(RelX, RelY).MinorP
        BestXOListMi(mP, BCurrentXoverMi(mP)).MinorP = XoverList(RelX, RelY).Daughter
        
        mP = XoverList(RelX, RelY).MajorP
        
        If mP > PermNextno Then
            
            'Dim DCV1 As Long, DCV2 As Long
            Call SplitP(-XoverList(RelX, RelY).BeginP, DCV1, DCV2)
             If DCV2 = mP Then
                mP = WhereIsExclude(DCV1)
            Else
                Call SplitP(-XoverList(RelX, RelY).EndP, DCV1, DCV2)
                mP = WhereIsExclude(DCV1)
            End If
        End If
       
        BCurrentXoverMa(mP) = BCurrentXoverMa(mP) + 1
        UB = UBound(BestXOListMa, 1)
        If UBound(BestXOListMa, 2) < BCurrentXoverMa(mP) Then
            ReDim Preserve BestXOListMa(UB, BCurrentXoverMa(mP) + 20)
        End If
        BestXOListMa(mP, BCurrentXoverMa(mP)) = XoverList(Seqno, CurrentXOver(Seqno))
        BestXOListMa(mP, BCurrentXoverMa(mP)).Daughter = XoverList(RelX, RelY).MajorP
        BestXOListMa(mP, BCurrentXoverMa(mP)).MajorP = XoverList(RelX, RelY).Daughter
        
        
        Dim tIsPerm(2)
        tIsPerm(0) = ISPerm(0)
        tIsPerm(1) = ISPerm(1)
        tIsPerm(2) = ISPerm(2)
        Call ModSeqNum(0, 0, 1)
        Call RecheckSpecificsignal(Seqno, CurrentXOver(Seqno))
        
        
        If XoverList(Seqno, CurrentXOver(Seqno)).Probability = 0 Then XoverList(Seqno, CurrentXOver(Seqno)).Probability = 1
        
        ISPerm(0) = tIsPerm(0)
        ISPerm(1) = tIsPerm(1)
        ISPerm(2) = tIsPerm(2)
        
        'XX = XOverlist(RelX, RelY).Probability
        If XoverList(Seqno, CurrentXOver(Seqno)).Probability < LowestProb Then
            Dim vpva As Variant, vbvb As Variant, vbvc As Variant
            
            vpva = XoverList(Seqno, CurrentXOver(Seqno)).Probability
            vpvb = XoverList(RelX, RelY).Probability
            vpvc = vpva / vpvb
            If vpvc < 100 Then
                RCol = RGB(220, 128, 128)
                Daught(SEN, Seqno) = 1
            Else
               Daught(SEN, Seqno) = 2
               RCol = RGB(255, 128, 192) 'RGB(220, 128, 128)
            End If
            
            If UBound(uDaught, 1) >= SEN Then
                If UBound(uDaught, 2) >= Seqno Then
                    uDaught(SEN, Seqno) = Daught(SEN, Seqno)
                End If
            End If
        End If
        
        
'           For X = 0 To PermNextno
'            If Daught(SEN, X) > 0 Or uDaught(SEN, X) > 0 Then
'                X = X
'            End If
'
'        Next X
'
        'I should maybe call integratexovers here
        
        
        'XX = XOverList(SeqNo, CurrentXOver(SeqNo)).Accept
        PN = XoverList(Seqno, CurrentXOver(Seqno)).ProgramFlag
        If PN > AddNum - 1 Then PN = PN - AddNum
        Confirm(SEN, PN) = Confirm(SEN, PN) + 1
        ConfirmP(SEN, PN) = ConfirmP(SEN, PN) + (-Log10(XoverList(Seqno, CurrentXOver(Seqno)).Probability))
        'DoneTree(1, 3) = 0
        DoneTree(2, 3) = 0
        DoneTree(3, 3) = 0
        DoneTree(4, 3) = 0
        If DebuggingFlag < 2 Then On Error Resume Next
        Form2.SSPanel1(2).ZOrder
        On Error GoTo 0
    ElseIf Daught(SEN, Seqno) > 0 And Seqno > PermNextno Then 'need these for extraevents
        Daught(SEN, Seqno) = 0
        If UBound(uDaught, 1) >= SEN Then
            If UBound(uDaught, 2) >= Seqno Then
                uDaught(SEN, Seqno) = Daught(SEN, Seqno)
            End If
        End If
        If ExcludedEventNum > 0 Then
            If NumExcludedEventNum > 0 Then
                'put the current ExcludedEventNum onto the disk and load the ExcludedEventNum0 in
                NF3 = FreeFile
                oDirX = CurDir
                ChDrive App.Path
                ChDir App.Path
                Open "ExcludedEventNum" + Str(NumExcludedEventNum) + UFTag For Binary As #NF3
                Put #NF3, 1, ExcludedEventNum
                Put #NF3, , EventsInExcludeds
                Close #NF3
                ReDim EventsInExcludeds(5, 1000)
                'ExcludedEventNum = 1
                ChDrive oDirX
                ChDir oDirX
            End If
            Dim ChangeMade As Long
            For j = 0 To NumExcludedEventNum
                If NumExcludedEventNum > 0 Then
                    NF3 = FreeFile
                    oDirX = CurDir
                    ChDrive App.Path
                    ChDir App.Path
                    Open "ExcludedEventNum" + Str(j) + UFTag For Binary As #NF3
                    Get #NF3, , ExcludedEventNum
                    ReDim EventsInExcludeds(5, ExcludedEventNum)
                    Get #NF3, , EventsInExcludeds
                    Close #NF3
                    'ExcludedEventNum = 1
                    ChDrive oDirX
                    ChDir oDirX
                End If
                    
                ChangeMade = 0
                For x = 0 To ExcludedEventNum
                    If EventsInExcludeds(1, x) = -SEN And EventsInExcludeds(2, x) = Seqno And EventsInExcludeds(0, x) = 3 Then
                        If x < ExcludedEventNum Then
                            EventsInExcludeds(0, x) = EventsInExcludeds(0, ExcludedEventNum) 'should be the discard number but here it indicates it is the recomb
                            EventsInExcludeds(1, x) = EventsInExcludeds(1, ExcludedEventNum)
                            EventsInExcludeds(2, x) = EventsInExcludeds(2, ExcludedEventNum) 'should be the position of this sequence in the excludes file
                            
                            EventsInExcludeds(3, x) = EventsInExcludeds(3, ExcludedEventNum)  'sequence this exclude is most similar to
                            EventsInExcludeds(4, x) = EventsInExcludeds(4, ExcludedEventNum)
                            EventsInExcludeds(5, x) = EventsInExcludeds(5, ExcludedEventNum)
                            EventsInExcludedsBP(0, x) = EventsInExcludedsBP(0, x)
                            EventsInExcludedsBP(1, x) = EventsInExcludedsBP(1, x)
                            
                        End If
                        ExcludedEventNum = ExcludedEventNum - 1
                        ExcludedEventBPNum = ExcludedEventBPNum - 1
                        ChangeMade = 1
                    End If
                Next x
                If ChangeMade = 1 And NumExcludedEventNum > 0 Then
                    NF3 = FreeFile
                    oDirX = CurDir
                    ChDrive App.Path
                    ChDir App.Path
                    Open "ExcludedEventNum" + Str(j) + UFTag For Binary As #NF3
                    Put #NF3, 1, ExcludedEventNum
                    Put #NF3, , EventsInExcludeds
                    Close #NF3
                    'ExcludedEventNum = 1
                    ChDrive oDirX
                    ChDir oDirX
                
                End If
            Next j
        End If
    ElseIf Daught(SEN, Seqno) = 0 And Seqno > PermNextno Then
        Daught(SEN, Seqno) = 6
        If UBound(uDaught, 1) >= SEN Then
            If UBound(uDaught, 2) >= Seqno Then
                uDaught(SEN, Seqno) = Daught(SEN, Seqno)
            End If
        End If
        ExcludedEventNum = ExcludedEventNum + 1
        ExcludedEventBPNum = ExcludedEventBPNum + 1
        If ExcludedEventNum < ExcludedEventNumThresh Then
            If ExcludedEventNum > UBound(EventsInExcludeds, 2) Then
                ReDim Preserve EventsInExcludeds(5, ExcludedEventNum + 100)
            End If
        Else
            
            Dim NF3 As Long
            NF3 = FreeFile
            oDirX = CurDir
            ChDrive App.Path
            ChDir App.Path
            Open "ExcludedEventNum" + Str(NumExcludedEventNum) + UFTag For Binary As #NF3
            NumExcludedEventNum = NumExcludedEventNum + 1
            Put #NF3, 1, ExcludedEventNum
            Put #NF3, , EventsInExcludeds
            Close #NF3
            ReDim EventsInExcludeds(5, 1000)
            ExcludedEventNum = 1
            ChDrive oDirX
            ChDir oDirX
        End If
        EventsInExcludeds(0, ExcludedEventNum) = 3 'should be the discard number but here it indicates it is the recomb
        EventsInExcludeds(1, ExcludedEventNum) = -SEN
        EventsInExcludeds(2, ExcludedEventNum) = Seqno 'should be the position of this sequence in the excludes file
        Dim DV0 As Long, DV1 As Long
        Call SplitP(-XoverList(RelX, RelY).BeginP, DV0, DV1)
        'XX = WhereIsExclude(DV0)
        EventsInExcludeds(3, ExcludedEventNum) = WhereIsExclude(DV0) 'here this should = relx 'sequence this exclude is most similar to
        EventsInExcludeds(4, ExcludedEventNum) = DV0 'OSNPos(Seqno)
        EventsInExcludeds(5, ExcludedEventNum) = 6
        EventsInExcludedsBP(0, ExcludedEventBPNum) = XoverList(RelX, RelY).Beginning
        EventsInExcludedsBP(1, ExcludedEventBPNum) = XoverList(RelX, RelY).Ending
        
        
        
        
    End If
    
    
'    For X = 0 To Nextno '693,1; 703,1
'        If BCurrentXoverMa(X) > 0 Thenbp
'
'            For Y = 1 To BCurrentXoverMa(X)
'                If BestXOListMa(X, Y).Eventnumber = 0 Then '709,12
'
'                    X = X
'                End If
'            Next Y
'        End If
'    Next X
    
    If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
        Form1.SSPanel1.Caption = "Writing minor parent lists to disk"
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        oDirX = CurDir
        ChDrive App.Path
        ChDir App.Path
        FF = FreeFile
        UBXOMi = UBound(BestXOListMi, 2)
        UBXoMa = UBound(BestXOListMa, 2)
        
        Form1.ProgressBar1.Value = 55
        Call UpdateF2Prog
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        
        Open "RDP5BestXOListMi" + UFTag For Binary As #FF
        Put #FF, , BestXOListMi()
        Close #FF
        MiRec = MiRec - 1
        
        Form1.ProgressBar1.Value = 80
        
        Form1.SSPanel1.Caption = "Writing major parent lists to disk"
        Call UpdateF2Prog
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
        
        Open "RDP5BestXOListMa" + UFTag For Binary As #FF
        Put #FF, , BestXOListMa()
        Close #FF
        MaRec = MaRec - 1
        
        ChDrive oDirX
        ChDir oDirX
        Erase BestXOListMi
        Erase BestXOListMa
        Form1.ProgressBar1.Value = 95
        Call UpdateF2Prog
        Form1.Refresh: Form2.Refresh
        If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
        If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
    End If
    
    
    
End If
'Make the block dissapear
'Find coordinates of seqno in all trees


Dim SNco() As Long, TNum As Long, TType As Long
ReDim SNco(3, 3, 1)
Call UnModNextno





For TNum = 0 To 3
    If TNum = 1 Then ModNextno

    For TType = 0 To 3
        For x = 0 To TDLen(TNum, TType, 0)
                If TreeDraw(TNum, TType, 0, 2, x) > -1 And TreeDraw(TNum, TType, 0, 2, x) <= NextNo Then
                    
                        If TNum <> 0 Then
                             ' Exit Sub
                            XX = MName
                            
                            If Seqno = TreeTrace(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, x))) Then
                            'If MName = originalname(TreeTraceSeqs(1, TreeDraw(TNum, TType, 0, 2, X))) Then
                                SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                Exit For
                            End If
                        Else
                            If Seqno = TreeTrace((TreeDraw(TNum, TType, 0, 2, x))) Then
                            'If MName = originalname(TreeTrace((TreeDraw(TNum, TType, 0, 2, X)))) Then
                                SNco(TNum, TType, 0) = TreeDraw(TNum, TType, 0, 0, x)
                                SNco(TNum, TType, 1) = TreeDraw(TNum, TType, 0, 1, x)
                                Exit For
                            End If
                        End If
                End If
        Next x
    Next TType
Next TNum


If TBFlag = 0 Then
    Call UnModNextno
    
    For TNum = 0 To 3
        If TNum = 1 Then ModNextno
        For TType = 0 To 3
            If TBLen(TNum, TType) > 0 Then
                For x = 0 To TBLen(TNum, TType)
                    If SNco(TNum, TType, 0) >= TreeBlocks(TNum, TType, 0, x) And SNco(TNum, TType, 0) <= TreeBlocks(TNum, TType, 2, x) Then
                        If SNco(TNum, TType, 1) >= TreeBlocks(TNum, TType, 1, x) And SNco(TNum, TType, 1) <= TreeBlocks(TNum, TType, 3, x) Then
                            
                              TreeBlocks(TNum, TType, 4, x) = RCol
                            
                        End If
                    End If
                Next x
            End If
            
        Next TType
    Next TNum
Else
    Call UnModNextno
    TL = Picture2(0).TextWidth(OriginalName(Seqno)) + 2
    
    For TNum = 0 To 3
        If TNum = 1 Then ModNextno
        For TType = 0 To 3
            If TBLen(TNum, TType) > 0 Then
                TBLen(TNum, TType) = TBLen(TNum, TType) + 1
                If TBLen(TNum, TType) > UBound(TreeDraw, 5) Then
                    ReDim Preserve TreeDraw(3, 4, 1, 4, TBLen(TNum, TType) + 100)
                    Call MakeTreeDrawB(TreeDraw(), TreeDrawB())
                End If
                If TBLen(TNum, TType) > UBound(TreeBlocks, 4) Then
                    ReDim Preserve TreeBlocks(3, 4, 5, TBLen(TNum, TType) + 100)
                End If
                TreeBlocks(TNum, TType, 0, TBLen(TNum, TType)) = SNco(TNum, TType, 0) - 2
                TreeBlocks(TNum, TType, 1, TBLen(TNum, TType)) = SNco(TNum, TType, 1)
                TreeBlocks(TNum, TType, 2, TBLen(TNum, TType)) = SNco(TNum, TType, 0) + TL
                TreeBlocks(TNum, TType, 3, TBLen(TNum, TType)) = 12 + SNco(TNum, TType, 1)
                TreeBlocks(TNum, TType, 4, TBLen(TNum, TType)) = RCol
            End If
        Next TType
    Next TNum
End If


DoTreeSection:
If MassMarkFlag = 1 Then
    Exit Sub
End If

Call UnModNextno

Call MakeELLite(ELLite(), EventsInExcludeds(), Daught())
'DoneTree(0, 3) = 0


If F2TreeIndex <> 3 Then
    CurTree(3) = 0
End If

If F2P2SNum >= 0 Then
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
        x = x
        Form2.Picture2(x).Refresh
    Next x
    Call UnModNextno
End If
x = x

If GTMass = 0 Then
    Call IntegrateXOvers(0) 'added this back in on 17/6/2020 - may be a bad idea
    'Timer1.Enabled = True
End If



If RIMode = 1 Then
Call MakeSummary
End If
'Do
'
'Loop
If F2P2SNum >= 0 Then
    Form1.SSPanel1.Caption = ""
    Screen.MousePointer = 0
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
    Form1.Refresh: Form2.Refresh
    If Form2.WindowState = 0 Then
        Form2.ZOrder
    End If
    If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
    If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
End If
XX = RelX '29
XX = RelY '3
If GTMass = 0 Then
    Form1.Timer1.Enabled = True
    XX = Timer1.Interval
End If

End Sub

Private Sub NJMnu2_Click()

    Dim TD() As Double, tAVDST As Double, TTDistance() As Single, RS As Long, RE As Long

If F2TreeIndex = 3 Then
    'DrawUPGMA5
    'Call DrawFastNJ5(Form2.Picture2(3))
    Call DrawML7(Form2.Picture2(3))
    Index = 3 '
    Dim otTYF As Double, TYFM As Integer
    'Picture16.Height = (Nextno + 6) * 15 * TYF2
    Call ModOffsets(8.25, Form1.Picture16, otTYF, TYFM)
    With Form2.VScroll1(Index)
        VSMax = .Max
        If VSMax <= 0 Then .Value = 0
        OV = .Value
        OM = VSMax
        OVx = OV / OM
        If TDLen(Index, CurTree(Index), 1) > 0 And TDLen(Index, CurTree(Index), 1) <= UBound(TreeDraw, 5) Then
            VSMax = -Form2.Picture2(Index).ScaleHeight + ((TreeDraw(Index, CurTree(Index), 1, 1, TDLen(Index, CurTree(Index), 1)) + 1) * otTYF) + 200
        Else
            VSMax = -Form2.Picture2(Index).ScaleHeight + ((TreeDraw(Index, CurTree(Index), 1, 1, TDLen(0, 1, 1)) + 1) * otTYF) + 200
        End If
        If OM = 0 Then OM = 1
        If VSMax > 32000 Then
            F2VSScaleFactor(Index) = VSMax / 32000
            VSMax = 32000
        Else
            F2VSScaleFactor(Index) = 1
        End If
        If DebuggingFlag < 2 Then On Error Resume Next
        If OVx * VSMax <= VSMax Then
            .Value = OVx * VSMax
        ElseIf VSMax > 0 Then
            .Value = VSMax
        End If
        If VSMax <= 0 Then
            .Enabled = False
        Else
            .LargeChange = Form2.Picture2(Index).ScaleHeight
            .Enabled = True
        End If
        .Max = VSMax
        On Error GoTo 0
    End With
Else
    Screen.MousePointer = 11
    Form1.SSPanel1.Caption = "Calculating Tree Dimensions"
    Form1.ProgressBar1.Value = 5
    Call UpdateF2Prog
    LenStrainSeq = Len(StrainSeq(0)) + 1
    
    

    'XX = NJF
    
    If F2TreeIndex = 0 Then
        RS = 1
        RE = Len(StrainSeq(0))
    ElseIf F2TreeIndex = 2 Then
        RS = XoverList(RelX, RelY).Beginning
        RE = XoverList(RelX, RelY).Ending
    ElseIf F2TreeIndex = 1 Then
        RE = XoverList(RelX, RelY).Beginning - 1
        RS = XoverList(RelX, RelY).Ending + 1
        'RE = 9189
        'RS = 5809
    End If
    
    If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
        'Call ModSeqNum(0)
        Call ModNextno
    End If
    ReDim TTDistance(NextNo, NextNo)
    If F2TreeIndex <> 0 Then
        Call MakeETSeqNum(NextNo, TSeqLen, RS, RE, ETSeqNum(), TreeSeqNum())
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, TreeSeqNum(0, 0), TTDistance(0, 0), tAVDST)
    Else
        Call MakeETSeqNum(NextNo, TSeqLen, RS, RE, ETSeqNum(), SeqNum())
        Dummy = DistanceCalc(NextNo, Len(StrainSeq(0)) + 1, SeqNum(0, 0), TTDistance(0, 0), tAVDST)
    End If
    
    For x = 0 To NextNo

        For Y = x + 1 To NextNo

            If ((1 - TTDistance(x, Y)) / 0.75) < 1 Then

                If 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75)))) > 0 Then
                    TTDistance(x, Y) = 1 - (-0.75 * (Log10(1 - ((1 - TTDistance(x, Y)) / 0.75))))
                Else
                    TTDistance(x, Y) = 0
                End If

            Else
                TTDistance(x, Y) = 0
            End If

            TTDistance(Y, x) = TTDistance(x, Y)
        Next 'Y
    Next 'X

    ReDim TempSeq(NextNo + 2)
    
    

    Dim OCurTree As Integer

    OCurTree = CurTree(F2TreeIndex)
    CurTree(F2TreeIndex) = 1

    If F2TreeIndex = 0 And DoneTree(1, F2TreeIndex) = 1 Then
         ExtraDX = DoTreeColour(Picture2(F2TreeIndex), 1, F2TreeIndex)
    ElseIf F2TreeIndex = 2 And DoneTree(1, F2TreeIndex) = 1 <> 0 Then
    ElseIf F2TreeIndex = 1 And DoneTree(3, F2TreeIndex) = 1 Then
    Else

        Call Deactivate
        Call NJTree2(1)
        Call Reactivate
        
        If AbortFlag = 1 Then
            Form1.ProgressBar1.Value = 0
            Form1.SSPanel1.Caption = ""
            Call UpdateF2Prog
            
            Screen.MousePointer = 0
            AbortFlag = 0
            Form2.Command2.Enabled = False
            CurTree(F2TreeIndex) = OCurTree
            If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
                Call UnModNextno
                Call UnModSeqNum(0)
            End If

            Exit Sub
        End If
        ExtraDX = DoTreeColour(Picture2(F2TreeIndex), 1, F2TreeIndex)
        'DoTreeLegend treeblocksl(), TBLLen, Picture2(F2TreeIndex), ExtraDx, 14
    End If

    For x = 0 To 4
        TTFlag(F2TreeIndex, x) = 0
    Next 'X

    TTFlag(F2TreeIndex, 1) = 1
    Form1.ProgressBar1.Value = 100
    Call UpdateF2Prog
    
    
    
    Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(F2TreeIndex).Value, F2TreeIndex, 1, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(F2TreeIndex))

    If F2TreeIndex = 0 Then
        Label1(0).Caption = "NJ tree ignoring recombination"
    ElseIf F2TreeIndex = 2 Then
        'Label1(2).Caption = "NJ tree of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Label1(2).Caption = "NJ tree of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Label1(2).Caption = "NJ tree of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf F2TreeIndex = 1 Then
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form2.Label1(1) = "NJ tree of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form2.Label1(1) = "NJ tree of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form2.Label1(1) = "NJ tree of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    End If
    
    If LongWindedFlag = 1 And F2TreeIndex <> 0 Then
        Call UnModNextno
    End If
    
    Screen.MousePointer = 0
    Form1.SSPanel1.Caption = ""
    Form1.ProgressBar1.Value = 0
    Call UpdateF2Prog
End If
Erase ETSeqNum
End Sub

Private Sub NodeMarkMnu_Click()
    
    Call UnModNextno
    Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    'XX = NodeFind(SelectNode(0), 37)
    If SelectNode(4) = 0 Or (SelectNode(4) = 3 And (CurTree(3) = 0 Or CurTree(3) = 1)) Then
        'If SelectNode(4) <> 0 Then ModNextno
        Call UnModNextno
        'If SelectNode(4) = 0 Or X = X Then
            For x = 0 To NextNo
                If NodeFind(SelectNode(0), x) = 1 Then
                    ColourSeq(x) = 1
                    MultColour(x) = SelCol
                End If
            Next x
'        Else
'            UB = UBound(NodeFind, 2)
'            For X = 0 To Nextno
'                If TreeTraceSeqs(1, X) < UB Then
'                    If NodeFind(SelectNode(0), TreeTraceSeqs(1, X)) = 1 Then
'                        ColourSeq(X) = 1
'                        MultColour(X) = SelCol
'                    End If
'                End If
'            Next X
'        End If
    Else
    'TreeTraceSeqs(1, CurrentSeq)
    'XX = PermNextno
        Call ModNextno
        For x = 0 To NextNo '10,153:10,107:10,82
              'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            'XX = UBound(NodeFind, 2)
            If UBound(NodeFind, 2) >= TreeTrace(TreeTraceSeqs(1, x)) Then
                If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
                'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                    
                    ColourSeq(TreeTrace(TreeTraceSeqs(1, x))) = 1
                    MultColour(TreeTrace(TreeTraceSeqs(1, x))) = SelCol
                End If
            End If
        Next x
    
    End If
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    UnModNextno
    x = x
End Sub

Private Sub NodeUnMarkMnu_Click()



UnModNextno
Dim NodeFind() As Byte
Call MakeNodeFind(NodeFind(), SelectNode(3))
    'If SelectNode(4) = 0 Or X = X Then
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                ColourSeq(x) = 0
                MultColour(x) = 0
            End If
        Next x
    
    'End If
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
    Next x
    UnModNextno
    x = x
End Sub

Private Sub OtherColMnu_Click()

    With Form2.CommonDialog1
        .Action = 3 'Specify that the "colour" action is required.
        'Stores selected colour in the string, SelCol.
        SelCol = .Color
    End With
End Sub

Private Sub Picture2_Change(Index As Integer)
x = x
End Sub

Private Sub Picture2_Click(Index As Integer)
x = x
End Sub

Private Sub Picture2_DblClick(Index As Integer)
x = x
End Sub

Private Sub Picture2_GotFocus(Index As Integer)
x = x
End Sub

Private Sub Picture2_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
P2KC = KeyCode
If Picture2(Index).Enabled = True Then
    Picture2(Index).SetFocus
Else
    Exit Sub
End If
If (KeyCode <> vbKeyZ And KeyCode <> vbKeyX) Or GetAsyncKeyState(vbKeyControl) < 0 Then '17 =control
    Call DoKeydown(KeyCode)

End If
 If KeyCode = vbKeyPageUp Or KeyCode = vbKeyLeft Then
    Call Command8_Click
    KPFlag = 1
ElseIf KeyCode = vbKeyPageDown Or KeyCode = vbKeyRight Then
    Call Command9_Click
    KPFlag = 1

End If
Picture2(Index).SetFocus
'DoEvents
'Sleep 100
End Sub

Private Sub Picture2_KeyPress(Index As Integer, KeyAscii As Integer)
'P2KC = KeyAscii
'Picture2(Index).SetFocus
'If KeyCode <> vbKeyZ And KeyCode <> vbKeyX Then
'    Call DoKeydown(KeyCode)
'End If
'If KeyCode = vbKeyPageUp Or KeyCode = vbKeyLeft Then
'    Call Command8_Click
'    KPFlag = 1
'ElseIf KeyCode = vbKeyPageDown Or KeyCode = vbKeyRight Then
'    Call Command9_Click
'    KPFlag = 1
'
'End If
End Sub

Private Sub Picture2_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
P2KC = -1
End Sub

Private Sub Picture2_LostFocus(Index As Integer)
x = x
End Sub

Private Sub Picture2_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    Dim NX As Long, NY As Long, ZX As Long
    F2P2Y = Y
    NX = x
    NY = Y
   AllCheckFlag = 0
   If CurrentlyRunningFlag <> 0 Or DoingShellFlag > 0 Then
        Exit Sub
    End If
    
    Dim MaxY As Long, PRat As Single
    Dim tTYF As Double, TYFM As Integer, tCurseq
    PRat = TDLen(Index, CurTree(Index), 2) / Picture2(0).ScaleWidth
    If Index = 0 And CurTree(Index) = 0 Then 'Or (Index = 3 And (CurTree(Index) = 0 Or CurTree(Index) = 1)) Then  'i have to do this because when the fist tree is drawn the scalemod is set for
                                                ' a bigger window
        XMod = TreeXScaleMod(0, 1, 0)
    Else
        XMod = TreeXScaleMod(0, Index, CurTree(Index))
    End If
    If XMod > 0 Then
        PRat = PRat / XMod
    End If
    Y = Y + VScroll1(Index).Value * F2VSScaleFactor(Index)
    'If PersistantP2tTYF = 0 Then
        Call ModOffsets(8.25, Form2.Picture2(Index), tTYF, TYFM)

    Y = Int(Y / tTYF + 1)

'        PersistantP2tTYF = tTYF
'        PersistantP2TYFM = TYFM
'    Else
'        tTYF = PersistantP2tTYF
'        TYFM = PersistantP2TYFM
'    End If
    If DebuggingFlag < 2 Then On Error Resume Next
    UB = 0
    UB = UBound(StoreChanged)
    UBX = UB
    On Error GoTo 0
    
    
    If UB < PermNextno Then
        UB = PermNextno
        
    End If
    If UB < NextNo Then
        UB = NextNo
    End If
    
    
    If Pic2MD = 0 Or UBX < UB Then
        ReDim Preserve StoreChanged(UB)
    End If
    
  
    
    OldFontSize = 8.25
    
    Dim CurrentSeq As Integer

    If TwipPerPix = 12 Then AddjNum = 14 Else AddjNum = 14


    If (Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3)) Then
        MaxY = (BigTreeNextno + 1) * AddjNum
    ElseIf (Index = 3 And CurTree(3) = 4) Then
        MaxY = (BigTreeNextno + 1) * AddjNum
    ElseIf Index = 0 Or (Index = 3 And CurTree(3) = 0) Or (Index = 3 And CurTree(3) = 1) Then
        MaxY = (PermNextno + 1) * AddjNum
    Else
        MaxY = (NextNo + 1) * AddjNum
    End If
    'If Y < MaxY Then CurrentSeq = RYCord(CurTree(Index), Index, Abs(Int((Y - 3) / AddjNum)))
    
    
    If Button = 1 Then
        If SelectNode(0) > -1 Then
            NHFlag = -1
            Call GetNHFlag(Index, CurTree(Index), NHFlag)
            If NHFlag > -1 Then
                
                ZX = SelectNode(0)
                If UBound(NodeXY, 2) >= ZX Then
                    If NodeXY(NHFlag, ZX, 0) * XMod > NX - 5 And NodeXY(NHFlag, ZX, 0) * XMod < NX + 5 Then '139
                        If NodeXY(NHFlag, ZX, 1) > NY - 5 And NodeXY(NHFlag, ZX, 1) < NY + 5 Then
                        
                        End If
                    Else
                        SelectNode(0) = -1
                    End If
                Else
                    SelectNode(0) = -1
                End If
            Else
                SelectNode(0) = -1
            End If
        End If
        If SelectNode(0) = -1 Then
            If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                MaxY = (BigTreeNextno + 1) * AddjNum
            ElseIf Index = 1 Or Index = 2 Then
                Call ModNextno
                MaxY = (NextNo + 1) * AddjNum
            Else
                If Index = 0 Or (Index = 3 And CurTree(3) = 0) Or (Index = 3 And CurTree(3) = 1) Then
                    Call UnModNextno
                End If
                MaxY = (PermNextno + 1) * AddjNum
            End If
            
            If Y < MaxY Then CurrentSeq = RYCord(CurTree(Index), Index, Abs(Int((Y - 3) / AddjNum)))
            Pic2MD = 1
            'XX = OriginalName(CurrentSeq)
            
            'XX = UBound(BigTreeNameU, 1)
            
            
            If LChange <> CurrentSeq Then 'X = X Or CurrentSeq <> Seq1 And CurrentSeq <> Seq2 And CurrentSeq <> Seq3 Then
                LChange = CurrentSeq
                If Index = 0 Or (Index = 3 And (CurTree(3) = 0 Or CurTree(3) = 1)) Then
                    tCurseq = TreeTrace(CurrentSeq)
                    snx = PermOriginalName(CurrentSeq)
                ElseIf Index <> 0 And (Index <> 3 Or (CurTree(3) <> 0 Or CurTree(3) <> 1)) Then
                    If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                        tCurseq = BigTreeTrace(CurrentSeq)
                        snx = BigTreeName(CurrentSeq)
                    ElseIf (Index = 3 And CurTree(3) = 0) Or (Index = 3 And CurTree(3) = 1) Then 'And FastNJFlag = 1 Then
                        tCurseq = TreeTrace(CurrentSeq)
                        snx = PermOriginalName(CurrentSeq)
                    Else
                        If CurrentSeq <= UBound(TreeTrace, 1) Then
                            tCurseq = TreeTraceSeqs(1, TreeTrace(CurrentSeq))
                        End If
                        If TreeTrace(TreeTraceSeqs(1, CurrentSeq)) <= UBound(OriginalName, 1) Then
                            snx = OriginalName(TreeTrace(TreeTraceSeqs(1, CurrentSeq))) 'OriginalName(TreeTrace(CurrentSeq))
                        End If
                    End If
                    'XX = PermNextno
                Else
                    tCurseq = TreeTrace(CurrentSeq)
                    snx = PermOriginalName(CurrentSeq)
                End If
                
                Z = Form1.Picture16.ScaleWidth
                
                GoOn = 0
'                If Index = 3 And CurTree(3) = 1 Then
'                    If X > XCord(CurTree(Index), Index, CurrentSeq) / PRat And X < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(BigTreeNameU(CurrentSeq))) And Y < MaxY Then
'                        GoOn = 0
'                        SEN = BigTreeTraceEventU(CurrentSeq)
'
'                        If SEN > 0 Then
'                            SEN = SEN - 1
'                            If SEN = 0 Then SEN = SEventNumber
'                            RelX = BestEvent(SEN, 0)
'                            RelY = BestEvent(SEN, 1) 'SuperEventList(XOverList(RelX, RelY).Eventnumber
'                            'XX = Form1.Command3.Enabled
'                            ClickedInTreeFlag = 1
'                            Call GotoNxt
'                            Pic2MD = 0
'                            ClickedInTreeFlag = 0
'
'                        Else
'                            GoOn = 1
'                        End If
'
'                    End If
'                Else
                If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                    If PRat > 0 Then
                        If x > XCord(CurTree(Index), Index, CurrentSeq) / PRat And ((x < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(BigTreeName(tCurseq)))) Or (x < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(snx)))) And Y < MaxY Then
                            GoOn = 0
                            SEN = BigTreeTraceEvent(CurrentSeq)
                            If SEN > 0 Then
                                SEN = SEN - 1
                                If SEN = 0 Then SEN = SEventNumber
                                RelX = BestEvent(SEN, 0)
                                RelY = BestEvent(SEN, 1) 'SuperEventList(XOverList(RelX, RelY).Eventnumber
                                ClickedInTreeFlag = 1
                                Call GotoNxt
                                Pic2MD = 0
                                ClickedInTreeFlag = 0
                            Else
                                GoOn = 1
                            End If
                        End If
                    End If
                Else
                    
                    If tCurseq <= UBound(OriginalName, 1) And PRat > 0 Then
                        If x > XCord(CurTree(Index), Index, CurrentSeq) / PRat And x < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(OriginalName(tCurseq))) And Y < MaxY Then
                            GoOn = 1
                        End If
                    ElseIf CurrentSeq <= UBound(OriginalName, 1) And PRat > 0 Then
                        If x > XCord(CurTree(Index), Index, CurrentSeq) / PRat And x < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(OriginalName(CurrentSeq))) And Y < MaxY Then
                            GoOn = 1
                        End If
                    
                    End If
                End If
                
                If GoOn = 1 Then
'                    If Index = 3 And CurTree(3) = 1 Then
'                        ttcurseq = TCurSeq
'                    Else
                        If tCurseq > UBound(MultColour) Then
                            ttcurseq = TreeTrace(tCurseq)
                        Else
                            ttcurseq = TreeTrace(tCurseq) 'TCurSeq
                        End If
'                    End If
                    Dim ColChangeFlag As Byte
                     ColChangeFlag = 0
                     If P2KC = vbKeyShift Then
                        Call aDaughtMnu_Click
                     ElseIf P2KC = vbKeyX Then
                        Call aMinParMnu_Click
                     ElseIf P2KC = vbKeyZ Then
                        Call aMajParMnu_Click
                     ElseIf P2KC = vbKey1 Or P2KC = vbKeyR Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(255, 0, 0) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(255, 0, 0)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey2 Or P2KC = vbKeyP Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(255, 128, 128) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(255, 128, 128)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey3 Or P2KC = vbKeyO Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(255, 128, 0) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(255, 128, 0)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey4 Or P2KC = vbKeyY Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(255, 255, 0) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(255, 255, 0)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey5 Or P2KC = vbKeyG Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(0, 160, 0) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(0, 160, 0)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey6 Or P2KC = vbKeyL Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(64, 255, 64) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(64, 255, 64)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey7 Or P2KC = vbKeyT Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(128, 255, 255) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(128, 255, 255)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     ElseIf P2KC = vbKey8 Or P2KC = vbKeyB Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(128, 128, 255) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(128, 128, 255)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                    ElseIf P2KC = vbKey9 Or P2KC = vbKeyN Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(0, 0, 255) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(0, 0, 255)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                    ElseIf P2KC = vbKey0 Or P2KC = vbKeyM Then
                        'if colourseq(ttcurseq) = RGB(255, 128, 128)
                        If MultColour(ttcurseq) <> RGB(128, 0, 255) Then
                            ColourSeq(ttcurseq) = 1
                            MultColour(ttcurseq) = RGB(128, 0, 255)
                            ColChangeFlag = 1
                        Else
                            ColourSeq(ttcurseq) = 0
                            MultColour(ttcurseq) = 0
                            ColChangeFlag = 1
                        End If
                     Else
                     'XX = OriginalName(ttcurseq)
                        If ttcurseq <= UBound(MultColour) Then
                            If MultColour(ttcurseq) <> SelCol Then
                                If UBound(ColourSeq) < ttcurseq Then
                                    ReDim Preserve ColourSeq(ttcurseq)
                                    ReDim Preserve MultColour(ttcurseq)
                                End If
                                ColourSeq(ttcurseq) = 1
                                MultColour(ttcurseq) = SelCol
                                ColChangeFlag = 1
                            Else
                                ColourSeq(ttcurseq) = 0
                                MultColour(ttcurseq) = 0
                                ColChangeFlag = 1
                            End If
                        End If
                         
                        If Index <> 0 And (Index <> 3 Or (CurTree(Index) <> 0 And CurTree(Index) <> 1)) Then
                            Call UnModNextno
                            x = x
                        End If
                        SS = Abs(GetTickCount)
                        
                    End If
                    If ColChangeFlag = 1 Then
                        
                        If DebuggingFlag < 2 Then On Error Resume Next
                        UB = 0
                        UB = UBound(StoreChanged)
                        If UB < PermNextno Then
                            UB = PermNextno
                            
                        End If
                        If UB < NextNo Then
                            UB = NextNo
                        End If
                        ReDim Preserve StoreChanged(UB)
                        On Error GoTo 0
                        If UBound(StoreChanged) < ttcurseq Then
                            ReDim Preserve StoreChanged(ttcurseq)
                        End If
                        StoreChanged(ttcurseq) = 1
                        'For Y = 1 To 1000
                        SS = Abs(GetTickCount)
                        'OnlyNamesFlag = ttcurseq + 1
                        'For Z = 1 To 10
                        For x = 0 To 3
                            If x = 1 Then
                                Call ModNextno
                            ElseIf x = 3 And (CurTree(x) = 1 Or CurTree(x) = 0) Then
                                Call UnModNextno
                            End If
                            
                          If NextNo > 1000 Then
                               
                               'For zzz = 0 To 100
                               Call TreeDrawing(1, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
                               'Next zzz
                               
                           Else
                               Call TreeDrawing(1, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
                           End If
                           'Form2.Picture2(X).Refresh
                        Next x
                        'Next Z
                        EE = Abs(GetTickCount)
                        TT = EE - SS '0.297'0.175 using cached textwidths'0.983, 0.1063,0.951 for 10 cycles
                        '0.982,0.983,0.968 - nodoubles
                        '0.952,0.967,0.952 - Ubounds taken out of loops
                        '0.889, 0.875, 0.905, 0.858 'with ubounds outside of main loops
                        '0.796,0.811,0.795 unpacking nested arrays
                        '0.811,0.733,0.718,0.733
                        
                        '3.281 - 20 iterations freds 3800
                        '0.812 - 20 iterations using onlynames = 1
                        '31.047 - 1000 iterations freds 3800
                        'XX = TDLen(1, 0, 1)
                        'XX = LastSE(1, 0, 1)
                        'XX = LastSE(1, 0, 0)
                        x = x '3.703;2.379
                        'Next Y
                        '3.5 with treedraw
                        '2.812 with treedrawb
                        '2.187,2.172 caching tdlens
                        '2.157, 2.140'neatening up
                        '2.063, 2.047 not needlessly refressing picture 3
                        '1.469 with drawtreelines
                        '1.313
                        '1.094 using cached sequence name lengths
                        '1.031
                        '0.984 using getmaxxpos and getmaxxposb
                        '0.594 - replacing loasdpicture
                        
                        '13484 - 1000
                       
                        '10078, 10484, 11156, 10656 -using cached name lengths
                        '10281,9312,10141,10125, 10172, 10140
                        '9171, 10032, 9969,10047, 10031, 10031 getmaxxpos
                        '8766, 9078, 8891, 8922 getmaxxposb
                        '9297, 9343,9453, 9575, 9313
                        '9453, 9250, 9563, 9468
                        '8750,8750,8719
                        '5672 replacing loadpicture()
                        
                        
                        '14797 with drawing blocks
                        '11578 with pversion of doaablocks
                        '10.375 with vc++ version of big picture draw
                        '8594, 8515 - rearranging access to arrays when drawing blocks
                        '8172,8188 - makebigmap,
                        '8063, 8094 - makebigmapb rearranging mapblocks array
                        '8016 better array access in makebigmap
                        '6609
                        
                        
                    End If
                    EE = Abs(GetTickCount)
                    TT = EE - SS '218
                    x = x
                    If Index <> 0 And (Index <> 3 Or (CurTree(Index) <> 0 And CurTree(Index) <> 1)) Then
                        UnModNextno
                        
                    
                    
                    End If
                Else
                    If SelectedSeqNumber > -1 Then
                        
                        
                        SelectedSeqNumber = -1
                        If Index <> 0 And (Index <> 3 Or (CurTree(Index) <> 0 And CurTree(Index) <> 1)) Then
                            Call UnModNextno
                            
                        End If
                        
                        For x = 0 To 3
                            If x = 1 Then
                                ModNextno
                            ElseIf x = 3 And (CurTree(Index) = 0 Or CurTree(Index) = 1) Then
                                UnModNextno
                            End If
                            ExtraDX = DoTreeColour(Form2.Picture2(x), CurTree(x), x)
                            Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
                            x = x
                        Next x
                        
                    End If
                End If
            End If
        Else
            Call NodeMarkMnu_Click
        End If
    Else
        RejectExMnu.Visible = False
        RejectEAxMnu.Visible = False
        AcceptEAxMnu.Visible = False
        AcceptExMnu.Visible = False
        
        
        
        Pic2MD = 2
        If SelectNode(0) = -1 Or (Index = 3 And CurTree(3) > 1) Then
            F2TreeIndex = Index
            'If Index <> 0 Then
            '    Call ModNextno
            'End If
            If F2P2SNum >= 0 Then 'And F2P2SNum <= UBound(originalname, 1) Then
                'If Y < MaxY Then CurrentSeq = RYCord(CurTree(Index), Index, Abs(Int((Y - 3) / AddjNum)))
                'If Index <> 0 Then
                '    TCurSeq = TreeTraceSeqs(1, CurrentSeq)
                '    'XX = PermNextno
                'Else
                '    TCurSeq = CurrentSeq
                'End If
                null3.Visible = True
                GOTOSeq.Visible = True
                If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                    GOTOSeq.Caption = "Go to " + OriginalName(TreeTrace(F2P2SNum))
                Else
                    GOTOSeq.Caption = "Go to " + StraiName(TreeTrace(F2P2SNum))
                End If
                ENxx = SuperEventList(XoverList(RelX, RelY).Eventnumber)
                ENxx = SuperEventList(XoverList(SERecSeq, SEPAVal).Eventnumber)
                
                A = 0
                
                If TreeTrace(F2P2SNum) <= UBound(Daught, 2) Then
                
                    If Daught(ENxx, TreeTrace(F2P2SNum)) > 0 Then
                        
                        If ExcludedEventNum > 0 Then
                            A = SumEventCount(ENxx)
                        Else
                            A = 0
                            For Z = 0 To NextNo
                                If Daught(ENxx, Z) > 0 Then
                                    A = A + 1
                                    
                                End If
                            Next Z
                        End If
                        If A > 1 Then
                            AcceptEAxMnu.Caption = "Accept this event in all " + Trim(Str(A)) + " sequences where it is found"
                            RejectEAxMnu.Caption = "Reject this event in all " + Trim(Str(A)) + " sequences where it is found"
                            AcceptEAxMnu.Enabled = True
                            RejectEAxMnu.Enabled = True
                        Else
                            AcceptEAxMnu.Caption = "Accept this event in all sequences where it is found"
                            RejectEAxMnu.Caption = "Reject this event in all sequences where it is found"
                            AcceptEAxMnu.Enabled = False
                            RejectEAxMnu.Enabled = False
                        End If
                        'If PAVal <= -1 Then
                        '    X = X
                        'End If
                        XX = Seq3
                        If SEPAVal > -1 Then
                            If TreeTrace(F2P2SNum) <= PermNextno Then
                                For x = 1 To CurrentXOver(TreeTrace(F2P2SNum))
                                    If SuperEventList(XoverList(TreeTrace(F2P2SNum), x).Eventnumber) = ENxx Then
                                        If XoverList(TreeTrace(F2P2SNum), x).Accept <> 1 Then
                                            AcceptExMnu.Enabled = True
                                        Else
                                            AcceptExMnu.Enabled = False
                                        End If
                                        TRelX = TreeTrace(F2P2SNum)
                                        TRelY = x
                                        RRelY = RelY
                                        RRelX = RelX
                                        Exit For
                                    End If
                                Next x
                            ElseIf SERecSeq >= 0 And SERecSeq <= PermNextno Then
                                For x = 1 To CurrentXOver(SERecSeq)
                                    If SuperEventList(XoverList(SERecSeq, x).Eventnumber) = ENxx Then
                                        If XoverList(SERecSeq, x).Accept <> 1 Then
                                            AcceptExMnu.Enabled = True
                                        Else
                                            AcceptExMnu.Enabled = False
                                        End If
                                        TRelX = SERecSeq
                                        TRelY = x
                                        RRelY = RelY
                                        RRelX = RelX
                                        Exit For
                                    End If
                                Next x
                            End If
                            'If XOverList(RecSeq, PAVal).Accept <> 1 Then
                            '    AcceptExMnu.Enabled = True
                            'Else
                            '    AcceptExMnu.Enabled = False
                            'End If
                        Else
                            Exit Sub
                        End If
                    
                        If XoverList(SERecSeq, SEPAVal).Accept <> 2 Then
                            RejectExMnu.Enabled = True
                        Else
                            RejectExMnu.Enabled = False
                        End If
                    Else
                            AcceptEAxMnu.Caption = "Accept this event in all sequences where it is found"
                            RejectEAxMnu.Caption = "Reject this event in all sequences where it is found"
                            AcceptEAxMnu.Enabled = False
                            RejectEAxMnu.Enabled = False
                            AcceptExMnu.Enabled = False
                            RejectExMnu.Enabled = False
                    End If
                End If
                RejectExMnu.Visible = True
                RejectEAxMnu.Visible = True
                AcceptEAxMnu.Visible = True
                If TreeTrace(F2P2SNum) <= PermNextno Or SERecSeq <= PermNextno Then
                    AcceptExMnu.Visible = True
                Else
                    AcceptExMnu.Visible = False
                End If
                'GOTOSeq.Caption = "Go to " + originalname(TCurSeq)
                RCheckPltMnu.Visible = True
                If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                    RCheckPltMnu.Caption = "Recheck plot with " + OriginalName(TreeTrace(F2P2SNum)) + "...."
                Else
                    RCheckPltMnu.Caption = "Recheck plot with " + StraiName(TreeTrace(F2P2SNum)) + "...."
                End If
                    
                'RCheckPltMnu.Caption = "Recheck plot with " + originalname(TCurSeq) + "...."
                'XX = TreeTraceSeqs(0, F2P2SNum)
                MName = ""
                ReassignPFlag = 0
'                If Index = 3 And CurTree(3) = 1 Then
'
'
'                    If X = X Then
'                        MUMnu.Visible = False
'                        MakeMinParMnu.Visible = False
'                        MakeMajParMnu.Visible = False
'                    Else
'                        If BigTreeTraceU(F2P2SNum) <> RelX Then
'                            MUMnu.Visible = True
'                            SEN = SuperEventList(XOverlist(RelX, RelY).Eventnumber)
'                            If MinorPar(SEN, BigTreeTraceU(F2P2SNum)) <> 1 And MajorPar(SEN, BigTreeTraceU(F2P2SNum)) <> 1 Then
'                                If Daught(SEN, BigTreeTraceU(F2P2SNum)) = 0 Then
'                                    MUMnu.Caption = "Mark " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " as also having evidence of this event"
'                                Else
'                                    MUMnu.Caption = "Mark " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " as not having evidence of this event"
'                                End If
'                                MName = BigTreeNameU(BigTreeTraceU(F2P2SNum))
'                            'ElseIf TreeTrace(F2P2SNum) <>  MinorPar(sen, ) <> 1 And MajorPar(sen, TreeTrace(F2P2SNum)) <> 1 Then
'                            ElseIf BigTreeTraceU(F2P2SNum) <> XOverlist(RelX, RelY).MinorP And BigTreeTraceU(F2P2SNum) <> XOverlist(RelX, RelY).MajorP Then
'                                If Daught(SEN, BigTreeTraceU(F2P2SNum)) = 0 Then
'                                    MUMnu.Caption = "Mark " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " as also having evidence of this event"
'                                Else
'                                    MUMnu.Caption = "Mark " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " as not having evidence of this event"
'                                End If
'                                MName = BigTreeNameU(BigTreeTraceU(F2P2SNum))
'                            Else
'                                MUMnu.Visible = False
'                            End If
'
'                        Else
'                            MUMnu.Visible = False
'                        End If
'
'                        If BigTreeTraceU(F2P2SNum) <> XOverlist(RelX, RelY).MajorP And BigTreeTraceU(F2P2SNum) <> XOverlist(RelX, RelY).MinorP And BigTreeTraceU(F2P2SNum) <> RelX Then
'                            MUMnu.Visible = True
'                            MakeMinParMnu.Visible = True
'                            MakeMajParMnu.Visible = True
'                            MakeMajParMnu.Caption = "Make " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " the major parent"
'                            MakeMinParMnu.Caption = "Make " + BigTreeNameU(BigTreeTraceU(F2P2SNum)) + " the minor parent"
'
'
'                        Else
'                            MakeMinParMnu.Visible = False
'                            MakeMajParMnu.Visible = False
'                        End If
'                    End If
'                Else
                If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                    
                    If x = x Then
                        MUMnu.Visible = False
                        MakeMinParMnu.Visible = False
                        MakeMajParMnu.Visible = False
                    Else
                        If BigTreeTrace(F2P2SNum) <> RelX Then
                            MUMnu.Visible = True
                            SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
                            If MinorPar(SEN, BigTreeTrace(F2P2SNum)) <> 1 And MajorPar(SEN, BigTreeTrace(F2P2SNum)) <> 1 Then
                                If Daught(SEN, BigTreeTrace(F2P2SNum)) = 0 Then
                                    MUMnu.Caption = "Mark " + BigTreeName(BigTreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                Else
                                    MUMnu.Caption = "Unmark " + BigTreeName(BigTreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                End If
                                MName = BigTreeName(BigTreeTrace(F2P2SNum))
                            'ElseIf TreeTrace(F2P2SNum) <>  MinorPar(sen, ) <> 1 And MajorPar(sen, TreeTrace(F2P2SNum)) <> 1 Then
                            ElseIf BigTreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MinorP And BigTreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MajorP Then
                                If Daught(SEN, BigTreeTrace(F2P2SNum)) = 0 Then
                                    MUMnu.Caption = "Mark " + BigTreeName(BigTreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                Else
                                    MUMnu.Caption = "Unmark " + BigTreeName(BigTreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                End If
                                MName = BigTreeName(BigTreeTrace(F2P2SNum))
                            Else
                                MUMnu.Visible = False
                            End If
                        
                        Else
                            MUMnu.Visible = False
                        End If
                        If BigTreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MajorP And BigTreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MinorP And BigTreeTrace(F2P2SNum) <> RelX Then
                            MUMnu.Visible = True
                            MakeMinParMnu.Visible = True
                            MakeMajParMnu.Visible = True
                            MakeMajParMnu.Caption = "Make " + BigTreeName(BigTreeTrace(F2P2SNum)) + " the major parent"
                            MakeMinParMnu.Caption = "Make " + BigTreeName(BigTreeTrace(F2P2SNum)) + " the minor parent"
                                
                        
                        Else
                            MakeMinParMnu.Visible = False
                            MakeMajParMnu.Visible = False
                        End If
                    End If
                Else
                
                
                    If TreeTrace(F2P2SNum) <> RelX And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).Daughter Then
                        MUMnu.Visible = True
                        SEN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
                        If TreeTrace(F2P2SNum) <= UBound(MinorPar, 2) Then
                            If MinorPar(SEN, TreeTrace(F2P2SNum)) <> 1 And MajorPar(SEN, TreeTrace(F2P2SNum)) <> 1 And (TreeTrace(F2P2SNum) <= PermNextno Or (MajorPar(SEN, TreeTrace(F2P2SNum)) = 0 And MajorPar(SEN, TreeTrace(F2P2SNum)) = 0)) Then
                                If Daught(SEN, TreeTrace(F2P2SNum)) = 0 Then
                                    If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                        MUMnu.Caption = "Mark " + OriginalName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                    Else
                                        MUMnu.Caption = "Mark " + StraiName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                    End If
                                    
                                Else
                                    If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                        MUMnu.Caption = "Unmark " + OriginalName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                    Else
                                        MUMnu.Caption = "Unmark " + StraiName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                    End If
                                End If
                                MName = OriginalName(TreeTrace(F2P2SNum))
                            'ElseIf TreeTrace(F2P2SNum) <>  MinorPar(sen, ) <> 1 And MajorPar(sen, TreeTrace(F2P2SNum)) <> 1 Then
                            ElseIf TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MinorP And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MajorP Then
                                If Daught(SEN, TreeTrace(F2P2SNum)) = 0 Then
                                    If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                        MUMnu.Caption = "Mark " + OriginalName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                    Else
                                        MUMnu.Caption = "Mark " + StraiName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                    End If
                                Else
                                    If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                        MUMnu.Caption = "Unmark " + OriginalName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                    Else
                                        MUMnu.Caption = "Unmark " + StraiName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                    End If
                                End If
                                If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                    MName = OriginalName(TreeTrace(F2P2SNum))
                                Else
                                    MName = StraiName(TreeTrace(F2P2SNum))
                                End If
                            Else
                                MUMnu.Visible = False
                            End If
                        Else
                            If TreeTrace(F2P2SNum) > PermNextno Then
                                If TreeTrace(F2P2SNum) <= UBound(Daught, 2) Then
                                    If Daught(SEN, TreeTrace(F2P2SNum)) = 0 Then
                                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                            MUMnu.Caption = "Mark " + OriginalName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                        Else
                                            MUMnu.Caption = "Mark " + StraiName(TreeTrace(F2P2SNum)) + " as also having evidence of recombination event " + Trim(Str(SEN))
                                        End If
                                    Else
                                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                                            MUMnu.Caption = "Unmark " + OriginalName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                        Else
                                            MUMnu.Caption = "Unmark " + StraiName(TreeTrace(F2P2SNum)) + " as having evidence of recombination event " + Trim(Str(SEN))
                                        End If
                                    End If
                                End If
                            End If
                        End If
                    
                    Else
                        MUMnu.Visible = False
                    End If
                    If TreeTrace(F2P2SNum) > PermNextno And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).Daughter And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MinorP And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MajorP Then
                        MakeMinParMnu.Visible = False
                        MakeMajParMnu.Visible = False
                    ElseIf TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MajorP And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).MinorP And TreeTrace(F2P2SNum) <> RelX And TreeTrace(F2P2SNum) <> XoverList(RelX, RelY).Daughter Then
                        MUMnu.Visible = True
                        MakeMinParMnu.Visible = True
                        MakeMajParMnu.Visible = True
                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                            MakeMajParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the major parent"
                            MakeMinParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the minor parent"
                        Else
                            MakeMajParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the major parent"
                            MakeMinParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the minor parent"
                        End If
                    
                    ElseIf TreeTrace(F2P2SNum) = XoverList(RelX, RelY).MajorP Then
                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                            MUMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the recombinant"
                            MakeMinParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the minor parent"
                        Else
                            MUMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the recombinant"
                            MakeMinParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the minor parent"
                        End If
                        MUMnu.Visible = True
                        MakeMinParMnu.Visible = True
                        MakeMajParMnu.Visible = False
                        ReassignPFlag = 1
                    ElseIf TreeTrace(F2P2SNum) = XoverList(RelX, RelY).MinorP Then
                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                            MUMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the recombinant"
                            MakeMajParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the major parent"
                        Else
                            MUMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the recombinant"
                            MakeMajParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the major parent"
                        End If
                        MUMnu.Visible = True
                        MakeMinParMnu.Visible = False
                        MakeMajParMnu.Visible = True
                        ReassignPFlag = 2
                    ElseIf TreeTrace(F2P2SNum) = RelX Or TreeTrace(F2P2SNum) = XoverList(RelX, RelY).Daughter Then
                        If OriginalName(TreeTrace(F2P2SNum)) <> "Unknown" Then
                            MakeMinParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the minor parent"
                            MakeMajParMnu.Caption = "Make " + OriginalName(TreeTrace(F2P2SNum)) + " the major parent"
                        Else
                            MakeMinParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the minor parent"
                            MakeMajParMnu.Caption = "Make " + StraiName(TreeTrace(F2P2SNum)) + " the major parent"
                        End If
                        MUMnu.Visible = False
                        MakeMinParMnu.Visible = True
                        MakeMajParMnu.Visible = True
                        
                        ReassignPFlag = 3
                    End If
                    
                End If
            Else
                null3.Visible = False
                GOTOSeq.Visible = False
                RCheckPltMnu.Visible = False
                MUMnu.Visible = False
                MakeMinParMnu.Visible = False
                MakeMajParMnu.Visible = False
            End If
            If Index < 3 Then
                ChangeTreeMnu.Enabled = True
                If FastNJFlag = 0 Then
                    UPGMAMnu2.Caption = "UPGMA"
                Else
                    UPGMAMnu2.Caption = "FastNJ"
                End If
                NJMnu2.Caption = "Neighbor joining"
                'lsmnu2.Caption = "Least squares"
                MLMnu2.Caption = "Maximum likelihood"
                BTMnu2.Caption = "Bayesian"
                If TTFlag(Index, 0) = 1 Then
                    UPGMAMnu2.Enabled = False
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf TTFlag(Index, 1) = 1 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = False
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf TTFlag(Index, 2) = 1 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = False
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf TTFlag(Index, 3) = 1 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = False
                    BTMnu2.Enabled = True
                ElseIf TTFlag(Index, 4) = 1 Then
                    
                    
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = False
                End If
            Else
                
                
                UPGMAMnu2.Caption = "FastNJ tree (using FastTree) with recombinant regions removed"
                NJMnu2.Caption = "ML tree (using RAxML) with recombinant regions removed"
                'LSMnu2.Caption = "Maximum likelihood with recombinant regions separated"
                MLMnu2.Caption = "Fast  maximum likelihood tree (less accurate using FastTree) with recombinant regions separated"
                BTMnu2.Caption = "Slower maximum likelihood tree (more accurate using RAxML) with recombinant regions separated"
                ChangeTreeMnu.Enabled = True
                If CurTree(Index) = 0 Then
                    UPGMAMnu2.Enabled = False
                    NJMnu2.Enabled = True
                    'LSMnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf CurTree(Index) = 1 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = False
                    'LSMnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf CurTree(Index) = 2 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = False
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = True
                ElseIf CurTree(Index) = 3 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = False
                    BTMnu2.Enabled = True
                ElseIf CurTree(Index) = 4 Then
                    UPGMAMnu2.Enabled = True
                    NJMnu2.Enabled = True
                    'lsmnu2.Enabled = True
                    MLMnu2.Enabled = True
                    BTMnu2.Enabled = False
                End If
                
            End If
            PopupMenu SaveMnu
        Else
            If SelectNode(4) = Index Then
                GoOn = 0
                Dim NodeFind() As Byte
                Call MakeNodeFind(NodeFind(), SelectNode(3))
                For x = 0 To PermNextno
                    If NodeFind(SelectNode(0), x) = 0 Then
                        GoOn = 1
                        Exit For
                    End If
                Next x
                If GoOn = 1 Then
                    AncSeqMnu.Enabled = True
                Else
                    AncSeqMnu.Enabled = False
                End If
            
                PopupMenu NodeMnu
            End If
        End If
        'If Index <> 0 Then
        '    Call UnModNextno
        'End If
        
    End If

End Sub

Private Sub Picture2_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
    RecSeq = 0
    PAVal = 0: PermXVal = 0: PermYVal = 0
    Yy = GetAsyncKeyState(VK_LBUTTON)
    XX = GetKeyState(VK_LBUTTON)
    
    Form2.Refresh
    'Form2.Picture2(Index).MouseIcon = 99
    Dim ZX As Long
    If Abs(x - F2P2LastTooltip(0)) > 1 Or Abs(Y - F2P2LastTooltip(1)) > 1 Then
        'F2P2LastTooltip(0) = X
        Form2.Picture2(Index).ToolTipText = "" 'Form2.Picture2(Index).ToolTipText
    End If
    If CurrentlyRunningFlag <> 0 Or DoingShellFlag > 0 Then
        Exit Sub
    End If
    Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
    If Form7.Visible = False Then
  
        Picture2(Index).SetFocus
        
    End If
    
    
    F2P2Seq = -1
    P1Seq = -1
    P1NT = -1
    F1P7X = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    
    F2P2SNum = -1
    
    F2P2Index = Index
    Dim CurrentSeq As Integer
    Dim NX As Long, NY As Long, tTYF As Double, TYFM As Integer, OY As Single, MaxY As Long
    Dim DontRefresh As Byte
    If RelX = 0 And RelY = 0 Then Exit Sub
    F2P2Y = Y
    If Index > 0 And (Index <> 3 And CurTree(3) <> 1) Then
        ModNextno
    Else
        UnModNextno
    End If
    If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
        Screen.MousePointer = 0
    End If
    OY = Y
    Y = Y + VScroll1(Index).Value * F2VSScaleFactor(Index) '1,20003
    'XX = VScroll1(Index).Max
    'If PersistantP2tTYF = 0 Then
        Call ModOffsets(8.25, Form2.Picture2(Index), tTYF, TYFM)
'        PersistantP2tTYF = tTYF
'        PersistantP2TYFM = TYFM
'    Else
'        tTYF = PersistantP2tTYF
'        TYFM = PersistantP2TYFM
'    End If
    Y = Int(Y / tTYF + 1) '1.0818
    Dim MaybeDisplay As Byte
    
    
    NX = x
    NY = Y
    
    PRat = TDLen(Index, CurTree(Index), 2) / Picture2(Index).ScaleWidth
    If Index = 0 And CurTree(Index) = 0 Then
        XMod = TreeXScaleMod(0, 1, 0)
    Else
        XMod = TreeXScaleMod(0, Index, CurTree(Index))
    End If
    If XMod > 0 Then
        PRat = PRat / XMod
    Else
        Exit Sub
    End If
    AddjNum = 14
    CurrentSeq = -1
    If Y > 2 Then
        If Index = 1 Or Index = 2 Then
            
            MaxY = (NextNo + 1) * AddjNum
            
            If Abs(Int((Y - 3) / AddjNum)) <= UBound(RYCord, 3) Then
                If Y < MaxY Then
                    CurrentSeq = RYCord(CurTree(Index), Index, Abs(Int((Y - 3) / AddjNum)))
                End If
            Else
                F2P2Seq = -1
                Form2.Picture2(Index).ToolTipText = "Right click for options"
                F2P2LastTooltip(1) = F2P2Y
                F2P2LastTooltip(0) = x
                'SelectNode(0) = -1
                Form2.Picture2(Index).MousePointer = 0
                Exit Sub
            End If
            
        Else
            If (Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4)) Then
                MaxY = (BigTreeNextno + 1) * AddjNum
            Else
                MaxY = (PermNextno + 1) * AddjNum
            End If
            If Abs(Int((Y - 3) / AddjNum)) <= UBound(RYCord, 3) Then
                If Y < MaxY Then
                    CurrentSeq = RYCord(CurTree(Index), Index, Abs(Int((Y - 3) / AddjNum)))
                End If
            Else
                'SelectNode(0) = -1
                F2P2Seq = -1
                Form2.Picture2(Index).ToolTipText = "Right click for options"
                F2P2LastTooltip(1) = F2P2Y
                F2P2LastTooltip(0) = x
                Form2.Picture2(Index).MousePointer = 0
                Exit Sub
            End If
        End If
    End If
'XX = PermNextno
    'If CurrentSeq <> Seq1 And CurrentSeq <> Seq2 And CurrentSeq <> Seq3 And X > XCord(CurTree(Index), Index, CurrentSeq) And X < (XCord(CurTree(Index), Index, CurrentSeq) + Picture2(Index).TextWidth(originalname(CurrentSeq))) And Y < MaxY Then
    
    If CurrentSeq > -1 Then
        If Index <> 0 And (Index <> 3 Or (CurTree(3) <> 1 And CurTree(3) <> 0)) Then
            If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
            
                F2P2Seq = BigTreeTrace(CurrentSeq)
            Else
                
                F2P2Seq = TreeTraceSeqs(1, CurrentSeq)
                'XX = StraiName(TreeTraceSeqs(CurrentSeq))
            End If
            
            'XX = StraiName(F2P2SNum)
            'XX = PermNextno
        Else
            F2P2Seq = CurrentSeq
            'XX = StraiName(CurrentSeq)
        End If
    
    
        
        If (CurrentSeq <= UBound(XCord, 3) And CurrentSeq <= UBound(TreeTrace, 1)) Or (Index = 3 And CurTree(3) = 1 And CurrentSeq <= BigTreeNextnoU) Or (Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) And CurrentSeq <= BigTreeNextno) Then
            If CurrentSeq <= UBound(TreeTraceSeqs, 2) Then
                If Index = 0 Or (Index = 3 And CurTree(3) = 1) Then
                   ' XX = PermNextno
                    snx = PermOriginalName(CurrentSeq)
                Else
                    If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                        snx = BigTreeName(CurrentSeq) 'BigTreeTraceU(TreetraceSeqs(1, CurrentSeq)))  'OriginalName(TreeTrace(CurrentSeq))
                    ElseIf Index = 3 And (CurTree(3) = 0 Or CurTree(3) = 1) Then
                        snx = PermOriginalName(CurrentSeq) '+ Str(CurrentSeq)
                    Else
                        If TreeTrace(TreeTraceSeqs(1, CurrentSeq)) <= UBound(OriginalName, 1) Then
                            If OriginalName(TreeTrace(TreeTraceSeqs(1, CurrentSeq))) <> "Unknown" Then
                                snx = OriginalName(TreeTrace(TreeTraceSeqs(1, CurrentSeq))) + Str(CurrentSeq) 'OriginalName(TreeTrace(CurrentSeq))
                            Else
                                If TreeTrace(TreeTraceSeqs(1, CurrentSeq)) <= UBound(StraiName, 1) Then
                                    snx = StraiName(TreeTrace(TreeTraceSeqs(1, CurrentSeq))) + Str(CurrentSeq) 'OriginalName(TreeTrace(CurrentSeq))
                                End If
                            End If
                        End If
                    End If
                End If
            Else
                If CurrentSeq <= PermNextno Or (Index = 3 And CurTree(3) = 1 And CurrentSeq <= BigTreeNextnoU) Or (Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) And CurrentSeq <= BigTreeNextno) Then
                    If Index = 0 Or (Index = 3 And (CurTree(3) = 1 Or CurTree(3) = 0)) Then
                        snx = PermOriginalName(CurrentSeq)
                    Else
                        
                        If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                            snx = BigTreeName(CurrentSeq) 'BigTreeTraceU(TreetraceSeqs(1, CurrentSeq)))  'OriginalName(TreeTrace(CurrentSeq))
                        ElseIf Index = 3 And CurTree(3) = 0 Then
                            snx = PermOriginalName(CurrentSeq)
                        Else
                            snx = OriginalName(TreeTraceSeqs(1, CurrentSeq)) 'OriginalName(TreeTrace(CurrentSeq))
                        End If
                            
                    End If
                    
                    
                End If
            End If
            'F2P2Seq = snx
            If PRat = 0 Then Exit Sub
            If CurrentSeq > UBound(XCord, 3) Then Exit Sub
            If x > (XCord(CurTree(Index), Index, CurrentSeq) / PRat) And x < (XCord(CurTree(Index), Index, CurrentSeq) / PRat + Picture2(Index).TextWidth(snx)) And Y < MaxY And Y > 0 Then
                'Mouse pointer is hovering over a sequence name
                
                DontRefresh = 1
                SelectNode(0) = -1
                Picture2(Index).MousePointer = 99
                'If CurrentSeq <= UBound(originalname) Then
                    
    '                If Index = 3 And CurTree(3) = 1 Then
    '                    'Picture2(Index).ToolTipText = "Left click to mark all fragments of sequence " + BigTreeNameU(BigTreeTraceU(CurrentSeq)) + " (this fragment was involved in recombination event " + Trim(Str(BigTreeTraceEventU(CurrentSeq))) + ")"
    '
    '                    If BigTreeTraceEventU(CurrentSeq) > 0 Then
    '                        EN = BigTreeTraceEventU(CurrentSeq)
    '                        'SERecSeq = BestEvent(EN, 0)
    '                        'SEPAVal = BestEvent(EN, 1)
    '                        Picture2(Index).ToolTipText = "Left click for detailed information on this recombination event (Event number " + Trim(Str(BigTreeTraceEventU(CurrentSeq))) + ")"
    '                    Else
    '                        Picture2(Index).ToolTipText = "Left click to mark " + snx
    '                    End If
    '                Else
                    If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                        'Picture2(Index).ToolTipText = "Left click to mark all fragments of sequence " + BigTreeName(BigTreeTrace(CurrentSeq)) + " (this fragment was involved in recombination event " + Trim(Str(BigTreeTraceEvent(CurrentSeq))) + ")"
                        
                        If BigTreeTraceEvent(CurrentSeq) > 0 Then
                            EN = BigTreeTraceEvent(CurrentSeq)
                            'SERecSeq = BestEvent(EN, 0)
                            'SEPAVal = BestEvent(EN, 1)
                            Picture2(Index).ToolTipText = "Left click for detailed information on this recombination event (Event number " + Trim(Str(BigTreeTraceEvent(CurrentSeq))) + ")"
                            F2P2LastTooltip(1) = F2P2Y
                            F2P2LastTooltip(0) = x
                        Else
                            Picture2(Index).ToolTipText = "Left click to mark " + snx
                            F2P2LastTooltip(1) = F2P2Y
                            F2P2LastTooltip(0) = x
                        End If
                    Else
                        EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
                        Picture2(Index).ToolTipText = "Left click to mark " + snx '+cstr(
                        F2P2LastTooltip(1) = F2P2Y
                        F2P2LastTooltip(0) = x
                    End If
                    
                    SERecSeq = BestEvent(EN, 0)
                    SEPAVal = BestEvent(EN, 1)
                    
                    If Index <> 0 And (Index <> 3 Or (CurTree(3) <> 1 And CurTree(3) <> 0)) Then
                        If Index = 3 And (CurTree(3) = 2 Or CurTree(3) = 3 Or CurTree(3) = 4) Then
                        
                            F2P2SNum = BigTreeTrace(CurrentSeq)
                        Else
                            F2P2SNum = TreeTraceSeqs(1, CurrentSeq)
                            'XX = StraiName(TreeTraceSeqs(CurrentSeq))
                        End If
                        
                        'XX = StraiName(F2P2SNum)
                        'XX = PermNextno
                    Else
                        F2P2SNum = CurrentSeq
                        'XX = StraiName(CurrentSeq)
                    End If
                    'F2P2SNum = TreeTrace(TreeTraceSeqs(1, CurrentSeq))
                'End If
                If Pic2MD = 1 Then
                   
                    If CurrentSeq <> LChange Then
                        'SS = Abs(GetTickCount)
                        'For XX = 0 To 10000
                        'OnlyNamesFlag = 1
                        Call Picture2_MouseDown(Index, Button, Shift, x, OY)
                        'Next XX
                        'EE = Abs(GetTickCount)
                        'TT = EE - SS
                        x = x
                    End If
                   
                    
                End If
            Else
                MaybeDisplay = 1
                'Picture2(Index).MousePointer = 0
                'Picture2(Index).ToolTipText = "Right Click for Options"
                F2P2SNum = -1
            End If
        End If
    Else
        Form2.Picture2(Index).MousePointer = 0
        Form2.Picture2(Index).ToolTipText = "Right click for options"
        F2P2LastTooltip(1) = F2P2Y
        F2P2LastTooltip(0) = x
    End If
    'check if mouspointer isover a node
     If Index > 0 Then
         UnModNextno
     End If
     
     
    
     NHFlag = -1
     
     Call GetNHFlag(Index, CurTree(Index), NHFlag)
     
     'check to see if mouse pointer is over a node
    If Index = 0 And CurTree(Index) = 0 Then
         XMod = TreeXScaleMod(0, 1, 0)
    Else
         XMod = TreeXScaleMod(0, Index, CurTree(Index))
    End If
    
        DontRefresh = 0
     Form2.Picture2(Index).AutoRedraw = False
     'Form2.Picture2(Index).ToolTipText = "Right Click for Options"
     If NHFlag > -1 Then
         
         
         
         'Col = RGB(255, 96, 128): Col2 = RGB(255, 255, 0) 'col = inner colour, col2=border colour
         Col = RGB(64, 255, 64): Col2 = RGB(255, 255, 0) 'col = inner colour, col2=border colour
         'XX = PermNextno
         If UBound(NodeXY, 1) >= NHFlag Then
            ModNextno
            
            For ZX = 0 To NextNo
                If UBound(NodeXY, 2) >= ZX Then
'                    If NodeXY(NHFlag, ZX, 0) <> -1 Then
'                        X = X
'                    End If
                    If NodeXY(NHFlag, ZX, 0) * XMod > NX - 5 And NodeXY(NHFlag, ZX, 0) * XMod < NX + 5 Then '139
                        If NodeXY(NHFlag, ZX, 1) > NY - 5 And NodeXY(NHFlag, ZX, 1) < NY + 5 Then
                            'Mouse pointer is hovering over a node
                            
                            If SelectNode(0) <> ZX Then
                                Form2.Picture2(Index).DrawMode = 10
                                
                                Form2.Picture2(Index).FillColor = Col
                                Form2.Picture2(Index).FillStyle = 0
                                If SelectNode(1) > 0 And SelectNode(2) > 0 And NHFlag = SelectNode(3) And SelectNode(0) > -1 Then
                                    
                                    
                                    Form2.Picture2(Index).FillStyle = 0
                                    If Index = 3 And CurTree(Index) > 0 Then
                                    Else
                                        'Form2.Picture2(Index).Circle (SelectNode(1), SelectNode(2) - 1), 4, Col2 'occasionally draws the node dot
                                    End If
                                End If
                                
                                
                                
                                '875,422
                                'Y = Y + VScroll1(Index).Value
                                'Call ModOffsets(8.25, Form2.Picture2(Index), tTYF, TYFM)
                                'Y = Int((Y+ VScroll1(Index).Value) / tTYF + 1)
                                'XX = VScroll1(Index).Value
                                'If SelectNode(0) > -1 Then
                                   YPX = Int((NodeXY(NHFlag, ZX, 1)) * tTYF + 1) - VScroll1(Index).Value
                                
                                'For A = 1 To 4
                                    
                                    SelectNode(0) = ZX 'the selected node
                                    SelectNode(1) = NodeXY(NHFlag, ZX, 0) * XMod 'adjusted x coordinate of node
                                    SelectNode(2) = YPX 'adjusted y-coordinate of node
                                    SelectNode(3) = NHFlag 'the current tree nhfile
                                    SelectNode(4) = Index 'the pciturebox in the picturebox array
                                    
                                    PermSelectNode(0) = ZX 'the selected node
                                    PermSelectNode(1) = NodeXY(NHFlag, ZX, 0) * XMod 'adjusted x coordinate of node
                                    PermSelectNode(2) = YPX 'adjusted y-coordinate of node
                                    PermSelectNode(3) = NHFlag 'the current tree nhfile
                                    PermSelectNode(4) = Index 'the pciturebox in the picturebox array
                                    If Index = 3 And CurTree(Index) > 1 Then
                                    Else
                                        If TreeDrawColBakFlag(Index) = 0 Then
                                            TDL1 = TDLen(Index, CurTree(Index), 1)
                                            For x = 0 To TDL1
                                            'XX = MaxEListLen
                                                If x <= UBound(TreeDrawColBak, 1) Then
                                                    TreeDrawColBak(x, Index) = TreeDrawB(4, x, Index, CurTree(Index), 1)
                                                End If
                                            Next x
                                            TreeDrawColBakFlag(Index) = 1
                                            'XX = Nextno
                                        End If
                                        'FInd Y flashing bounds
                                        
                                        Dim NodeFind() As Byte, UBNF As Long, IncSeq() As Long, AH1 As Long, AH2 As Long
                                        ReDim IncSeq(PermNextno)
                                        UnModNextno
                                        Call MakeNodeFind(NodeFind(), SelectNode(3))
                                        UBNF = UBound(NodeFind, 2)
                                        
                                        YFlashBound(1) = 0
                                        YFlashBound(0) = 1000000
                                        UnModNextno
                                        If SelectNode(4) = 0 Or (SelectNode(4) = 3 And (CurTree(Index) = 0 Or CurTree(Index) = 1)) Then
                                            'If SelectNode(4) = 0 Then
                                                For A = 0 To TDLen(Index, CurTree(Index), 0)
                                                    'If SelectNode(4) = 0 Then
                                                        AH2 = TreeDrawB(2, A, Index, CurTree(Index), 0) 'the sequence number
    '                                                Else
    '                                                    AH2 = TreeTrace(TreeDrawB(2, A, Index, CurTree(Index), 0))
    '                                                End If
                                                    AH1 = TreeDrawB(1, A, Index, CurTree(Index), 0) '* TSingle 'y cocord
                                                    
                                                    If AH2 >= 0 And AH2 <= UBNF Then
                                                        If NodeFind(ZX, AH2) = 1 Then
                                                            If YFlashBound(1) < AH1 Then
                                                                YFlashBound(1) = AH1
                                                            End If
                                                            If YFlashBound(0) > AH1 Then YFlashBound(0) = AH1
                                                        End If
                                                    End If
                                                Next A
                                        Else
                                            Call ModNextno
                                            'XX = Nextno
                                            For A = 0 To TDLen(Index, CurTree(Index), 0)
                                                
                                                If A <= UBound(TreeTrace, 1) + 1 And TreeDrawB(2, A, Index, CurTree(Index), 0) > -1 Then
                                                    AH2 = TreeTrace(TreeTraceSeqs(1, (TreeDrawB(2, A, Index, CurTree(Index), 0))))
                                                    'AH2 = TreeDrawB(2, A, Index, CurTree(Index), 0)
                                                    AH1 = TreeDrawB(1, A, Index, CurTree(Index), 0) '* TSingle 'y cocord
                                                    'XX = UBound(NodeFind, 1)
                                                    If AH2 >= 0 And AH2 <= UBNF And ZX <= UBNF Then
                                                        If NodeFind(ZX, AH2) = 1 Then
                                                            If YFlashBound(1) < AH1 Then
                                                                YFlashBound(1) = AH1
                                                            End If
                                                            If YFlashBound(0) > AH1 Then YFlashBound(0) = AH1
                                                        End If
                                                    Else
                                                        x = x
                                                    End If
                                                Else
                                                    x = x
                                                End If
                                            Next A
                                        End If
                                        'YFlashBound(0) = NodeXY(NHFlag, ZX, 1) - 30
                                        YFlashBound(1) = YFlashBound(1) + 12 'NodeXY(NHFlag, ZX, 1) + 30
                                        XFlashbound = CLng((NodeXY(NHFlag, ZX, 0) * XMod) - 2)
                                        
                                         x = x
                                        
'                                        YFlashBound(0) = 0
'                                        YFlashBound(1) = 100000
'                                        For X = 0 To TDL1
'                                            If TreeDrawB(2, X, Index, CurTree(Index), 1) > NodeXY(NHFlag, ZX, 0) Then
'                                                If YFlashBound(0) < NodeXY(NHFlag, ZX, 1) Then YFlashBound(0) = NodeXY(NHFlag, ZX, 1)
'                                                If YFlashBound(1) > NodeXY(NHFlag, ZX, 1) Then YFlashBound(1) = NodeXY(NHFlag, ZX, 1)
'                                            End If
'
'                                        Next X

                                        BranchFlashFlag = 1
                                        Form1.Timer1.Enabled = True
                                        'Form2.Picture2(Index).Circle (NodeXY(NHFlag, ZX, 0) * XMod, YPX - 1), 4, Col2 'draws the node dot (most commonly used)
                                    
                                    
                                    End If
                                    'Sleep 100
                                    'Form2.Picture2(Index).Refresh
                                    
                                'Next A
                                'XX = Nextno
                                
                               
                                
                                
                                
                                
                                
                                
                                
                                DontRefresh = 1
                            Else
                                'Form2.Picture2(Index).ToolTipText = "Right Click for Node Options"
                                DontRefresh = 1
                            End If
                            
                            If Form2.Picture2(Index).ToolTipText <> "Right click for node options" Then
                                Form2.Picture2(Index).ToolTipText = "Right click for node options"
                                F2P2LastTooltip(1) = F2P2Y
                                F2P2LastTooltip(0) = x
                            End If
                            DontRefresh = 1
                            If Form2.Picture2(Index).MousePointer <> 99 Then
                                'Form2.Picture2(Index).ToolTipText = "Right Click for Node Options"
                                Form2.Picture2(Index).MousePointer = 99
                            End If
                            MaybeDisplay = 0
                            Exit For
                        Else
                            'Form2.Picture2(Index).ToolTipText = "Right Click for Options"
                        End If
                    
                    End If
                End If
            Next ZX
            UnModNextno
         End If
         If DontRefresh = 0 Then
             'Form2.Picture2(Index).MousePointer = 0
             Form2.Picture2(Index).DrawMode = 10
             'Form2.Picture2(Index).ToolTipText = "Right Click for Options"
             Form2.Picture2(Index).FillColor = Col
             Form2.Picture2(Index).FillStyle = 0
             If SelectNode(1) > 0 And SelectNode(2) > 0 And NHFlag = SelectNode(3) And SelectNode(0) > -1 Then 'this erases the dot
                 Form2.Picture2(Index).FillStyle = 0
                 If Index = 3 And CurTree(Index) > 0 Then
                 Else
                     'Form2.Picture2(Index).Circle (SelectNode(1), SelectNode(2) - 1), 4, Col2
                     
                 End If
                 
                 
                 
             End If
             'SelectNode(0) = -1
         End If
     Else
        Picture2(Index).Refresh
        Picture2(Index).MousePointer = 0
        Picture2(Index).ToolTipText = "Right click for options"
        F2P2LastTooltip(1) = F2P2Y
        F2P2LastTooltip(0) = x
        F2P2SNum = -1
        MaybeDisplay = 0
        'PermSelectNode(0) = -1
        SelectNode(0) = -1
     End If
     
     If MaybeDisplay = 1 Then
        'Picture2(Index).Refresh
        Picture2(Index).MousePointer = 0
        Picture2(Index).ToolTipText = "Right click for options "
        F2P2LastTooltip(1) = F2P2Y
        F2P2LastTooltip(0) = x
        'PermSelectNode(0) = -1
        SelectNode(0) = -1
        'Picture2(Index).ToolTipText = "Right Click for Options"
     End If
   
    
    Form2.Picture2(Index).DrawMode = 13
    
    
End Sub

Private Sub Picture2_MouseUp(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)

    Dim tTYF As Double, TYFM As Integer
    If CurrentlyRunningFlag = 1 Then
        Exit Sub
    End If
    Pic2MD = 0
    LChange = -1
    LastOY = -1
    OnlyNamesFlag = 0
    Y = Y + VScroll1(Index).Value
    Call ModOffsets(8.25, Picture2(Index), tTYF, TYFM)
    Y = Int(Y / tTYF + 1)
    OldFontSize = 8.25
    Dim CurrentSeq As Integer

    If TwipPerPix = 12 Then AddjNum = 14 Else AddjNum = 14
    If DebuggingFlag < 2 Then On Error Resume Next
    UB = 0
    UB = UBound(StoreChanged)
    On Error GoTo 0
    CTF = CurTree(Index)
    If Index <> 0 And (Index <> 3 Or (CurTree(Index) <> 0 And CurTree(Index) <> 1)) Then
        Call ModNextno
        'Call ModSeqNum(0, 0, 0)
        'Exit Sub
    Else
        Call UnModNextno
        
    End If
    If UB > 0 Then
        'MaxY = (Nextno + 1) * AddjNum
        'If Y < MaxY Then CurrentSeq =
        If Index = 0 Or (Index = 3 And CTF = 0) Then
            For Z = 0 To NextNo
                'CS = RYCord(CTF, 0, Z)
                If TreeTrace(RYCord(CTF, Index, Z)) <= UB Then
                    If StoreChanged(TreeTrace(RYCord(CTF, Index, Z))) > 0 Then '
                        For A = Z + 1 To NextNo
                            If StoreChanged(TreeTrace(RYCord(CTF, Index, A))) = 0 Then
                                'If A <> Z Then
                                    For b = A + 1 To NextNo
                                        If StoreChanged(TreeTrace(RYCord(CTF, Index, b))) > 0 Then
                                            
                                           
                                                
                                            For C = A To b - 1
                                                
                                                 If MultColour(TreeTrace(RYCord(CTF, Index, C))) <> SelCol Then
                                                    ColourSeq(TreeTrace(RYCord(CTF, Index, C))) = 1
                                                    MultColour(TreeTrace(RYCord(CTF, Index, C))) = SelCol
                                                    ColChangeFlag = 1
                                                Else
                                                    ColourSeq(TreeTrace(RYCord(CTF, Index, C))) = 0
                                                    MultColour(TreeTrace(RYCord(CTF, Index, C))) = 0
                                                    ColChangeFlag = 1
                                                End If
                                            Next C
                                            
                                            Exit For
                                        End If
                                    Next b
                                'End If
                                Z = b - 1
                                Exit For
                            End If
                        Next A
                        'Exit For
                    End If
                End If
            Next Z
        Else
            For Z = 0 To NextNo
                'CS = RYCord(CTF, 0, Z)
                If RYCord(CTF, Index, Z) <= UBound(TreeTrace, 1) Then
                    If TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, Z))) <= UB Then
                        If StoreChanged(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, Z)))) > 0 Then '
                            
                            For A = Z + 1 To NextNo
                                If RYCord(CTF, Index, A) <= UBound(TreeTrace, 1) Then
                                    If TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, A))) <= UB Then
                                        If StoreChanged(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, A)))) = 0 Then
                                            'If A <> Z Then
                                                For b = A + 1 To NextNo
                                                    'Exit Sub
                                                    If RYCord(CTF, Index, b) <= UBound(TreeTrace, 1) Then
                                                        If TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, b))) <= UB Then
                                                            If StoreChanged(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, b)))) > 0 Then
                                                                
                                                               
                                                                    
                                                                For C = A To b - 1
                                                                     If TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C))) <= UB Then
                                                                         If MultColour(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C)))) <> SelCol Then
                                                                            ColourSeq(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C)))) = 1
                                                                            MultColour(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C)))) = SelCol
                                                                            ColChangeFlag = 1
                                                                         Else
                                                                            ColourSeq(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C)))) = 0
                                                                            MultColour(TreeTraceSeqs(1, TreeTrace(RYCord(CTF, Index, C)))) = 0
                                                                            ColChangeFlag = 1
                                                                        End If
                                                                    End If
                                                                Next C
                                                                
                                                                Exit For
                                                            End If
                                                        End If
                                                    End If
                                                Next b
                                            'End If
                                            Z = b - 1
                                            Exit For
                                        End If
                                    End If
                                End If
                            Next A
                            'Exit For
                        End If
                    End If
                End If
            Next Z
        
            
        
        End If
        For x = 0 To 3
            If x = 1 Then
                Call ModNextno
            Else
                If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                    Call UnModNextno
                End If
            End If
          If NextNo > 1000 Then
               Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
           Else
               Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
           End If
           'X = X
        Next x
    End If
    ReDim StoreChanged(0)
    OnlyNamesFlag = 0
End Sub

Private Sub Picture2_Paint(Index As Integer)

Picture2(Index).AutoSize = False
Exit Sub
Picture2(Index).AutoRedraw = True

'This checks to see whether the drawing op is going to work or not.
Pict = 0
If DebuggingFlag < 2 Then On Error Resume Next
Pict = Picture2(Index).hdc
On Error GoTo 0
'Pict = 0
If Pict = 0 Then
    If TwipPerPix = 12 Then AddjNum = 14 Else AddjNum = 14
    OldFontSize = 8.25
    Picture2(Index).AutoRedraw = False
    Picture2(Index).ScaleMode = 3
    EN = XoverList(RelX, RelY).Eventnumber
    Dim HCg As Long, QCg As Long, ECg As Long
                Dim HCb As Long, QCb As Long, ECb As Long
                Dim HCr As Long, QCr As Long, ECr As Long
                
                HCg = BkG + (255 - BkG) / 2
                QCg = BkG + (255 - BkG) / 4
                ECg = BkG - (BkG) / 4
                
                HCb = BkB + (255 - BkB) / 2
                QCb = BkB + (255 - BkB) / 4
                ECb = BkB - (BkB) / 4
                
                HCr = BkR + (255 - BkR) / 2
                QCr = BkR + (255 - BkR) / 4
                ECr = BkR - (BkR) / 4
    
    
    
    TNum = Index
    If TTFlag(Index, 0) = 1 Then
        TType = 0
    ElseIf TTFlag(Index, 1) = 1 Then
        TType = 1
    ElseIf TTFlag(Index, 2) = 1 Then
        TType = 2
    ElseIf TTFlag(Index, 3) = 1 Then
        TType = 3
    ElseIf TTFlag(Index, 4) = 1 Then
        TType = 4
    End If
    If RelX = 0 And RelY = 0 Then
        Exit Sub
    End If
    If LongWindedFlag = 0 Then
        EN = XoverList(RelX, RelY).Eventnumber
    Else
        EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    End If
    
    
    If TNum <> 0 And (TNum <> 3 Or (CurTree(TNum) <> 0 And CurTree(TNum) <> 1)) Then
        ModNextno
        For A = 0 To NextNo '- 1
            x = A
            
            'TL = Picture2(Index).TextWidth(originalname(X)) + 2
            If Index = 0 Then
                TL = Picture2(Index).TextWidth(OriginalName(TreeTraceSeqs(1, x))) + 2
            Else
                TL = Picture2(Index).TextWidth(OriginalName(x)) + 2
            End If
            Picture2(Index).DrawMode = 9
            
            Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), BackColours, BF
            If TreeTraceSeqs(1, x) = Seq1 Then
                
                    If OutsideFlagX = 1 Then
                        Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(ECr, QCg, ECb), BF
                    Else
                        Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(0, 255, 0), BF
                    End If
                x = x
            ElseIf TreeTraceSeqs(1, x) = Seq2 Then
                If OutsideFlagX = 2 Then
                    Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(ECr, ECg, QCb), BF
                Else
                    Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(64, 64, 255), BF
                End If
            ElseIf TreeTraceSeqs(1, x) = Seq3 Then
                'If Daught(En, TreeTraceSeqs(1, X)) > 1 And X = 12345 Then
                '    If Daught(En, TreeTraceSeqs(1, X)) < 5 Then
                '        picture2(index).Line (XCord(TType, TNum, X) - 2, YCord(TType, TNum, X))-(XCord(TType, TNum, X) + TL, 13 + YCord(TType, TNum, X)), RGB(ECr, QCg, ECb), BF
                '    End If
                'End If
                Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(255, 0, 0), BF
                
            ElseIf Daught(EN, TreeTraceSeqs(1, x)) = 1 Then
                Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(255, 128, 128), BF
                ExtraD(0) = ExtraD(0) + 1
            ElseIf Daught(EN, TreeTraceSeqs(1, x)) > 1 And Daught(EN, TreeTraceSeqs(1, x)) < 5 Then
                Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(255, 128, 192), BF
                ExtraD(1) = ExtraD(1) + 1
            ElseIf Daught(EN, TreeTraceSeqs(1, x)) = 5 Then
                Picture2(Index).Line (XCord(TType, TNum, x) - 2, YCord(TType, TNum, x))-(XCord(TType, TNum, x) + TL, 13 + YCord(TType, TNum, x)), RGB(255, 192, 192), BF
                ExtraD(2) = ExtraD(2) + 1
            End If
            
            Picture2(Index).DrawMode = 13
            Picture2(Index).CurrentX = XCord(TType, TNum, x)
            Picture2(Index).CurrentY = YCord(TType, TNum, x)
            Picture2(Index).ForeColor = MultColour(TreeTrace(TreeTraceSeqs(1, x)))
            If YCord(TType, TNum, x) > 0 Then
                If Index = 0 Then
                    Picture2(Index).Print OriginalName(TreeTraceSeqs(1, x))
                Else
                    Picture2(Index).Print OriginalName(x)
                End If
            End If
            'If originalname(TreeTrace(TreeTraceSeqs(1, X))) = "0B.JP.x.PATIENT_IMS1" Then
            '    X = X
            '     zzz = zzz + 1
            'End If
        Next 'X
        UnModNextno
        x = x
    Else
        For x = 0 To PermNextno '- 1
            
            TL = Picture2(Index).TextWidth(PermOriginalName(TreeTrace(x))) + 2
            Picture2(Index).DrawMode = 9
            Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), BackColours, BF
            If x = TreeTrace(Seq1) Then
                If OutsideFlagX = 1 Then
                    Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(ECr, QCg, ECb), BF
                Else
                    Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(0, 255, 0), BF
                End If
            ElseIf x = TreeTrace(Seq2) Then
                If OutsideFlagX = 2 Then
                    Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(ECr, ECg, QCb), BF
                Else
                    Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(64, 64, 255), BF
                End If
            ElseIf x = TreeTrace(Seq3) Then
                Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(255, 0, 0), BF
            ElseIf Daught(EN, TreeTrace(x)) = 1 Then
                Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(255, 128, 128), BF
                ExtraD(0) = ExtraD(0) + 1
            ElseIf Daught(EN, TreeTrace(x)) > 1 And Daught(EN, x) < 5 Then
                Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(255, 128, 192), BF
                ExtraD(1) = ExtraD(1) + 1
            ElseIf Daught(EN, TreeTrace(x)) = 5 Then
                Picture2(Index).Line (XCord(TType, TNum, TreeTrace(x)) - 2, YCord(TType, TNum, TreeTrace(x)))-(XCord(TType, TNum, TreeTrace(x)) + TL, 13 + YCord(TType, TNum, TreeTrace(x))), RGB(255, 192, 192), BF
                ExtraD(2) = ExtraD(2) + 1
            End If
            
            Picture2(Index).DrawMode = 13
            Picture2(Index).CurrentX = XCord(TType, TNum, TreeTrace(x))
            Picture2(Index).CurrentY = YCord(TType, TNum, TreeTrace(x))
            Picture2(Index).ForeColor = MultColour(TreeTrace(x))
            'If YCord(TType, TNum, X) > 100 Then
                Picture2(Index).Print PermOriginalName(TreeTrace(x))
            
            
            'End If
               
            
        Next 'X
    End If
End If






Exit Sub
For CurrentSeq = 0 To NextNo
            
            If x = x Or CurrentSeq <> Seq1 And CurrentSeq <> Seq2 And CurrentSeq <> Seq3 Then 'And MultColour(CurrentSeq) > 0 Then
                    
                    
                    TL = Form2.Picture2(Index).TextWidth(OriginalName(CurrentSeq)) + 2
                    Form2.Picture2(Index).DrawMode = 9
                    Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), BackColours, BF
                    
                    
                    If CurrentSeq = Seq1 Then
                        If OutsideFlagX = 1 Then
                            Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), RGB(ECr, ECg, QCb), BF
                        Else
                            Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), RGB(0, 0, 255), BF
                        End If
                    ElseIf CurrentSeq = Seq2 Then
                        If OutsideFlagX = 2 Then
                            Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), RGB(ECr, ECg, QCb), BF
                        Else
                            Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), RGB(0, 0, 255), BF
                        End If
                    ElseIf CurrentSeq = Seq3 Then
                        'Form2.Picture2(index).Line (XCord(curtree(index), index, currentseq) - 2, YCord(curtree(index), index, currentseq))-(XCord(curtree(index), index, currentseq) + TL, 13 + YCord(curtree(index), index, currentseq)), RGB(HCr, QCg, QCb), BF
                        Form2.Picture2(Index).Line (XCord(CurTree(Index), Index, CurrentSeq) - 2, YCord(CurTree(Index), Index, CurrentSeq))-(XCord(CurTree(Index), Index, CurrentSeq) + TL, 13 + YCord(CurTree(Index), Index, CurrentSeq)), RGB(255, 0, 0), BF
                    End If
                    Form2.Picture2(Index).DrawMode = 13
                    Picture2(Index).CurrentY = YCord(CurTree(Index), Index, CurrentSeq)
                    Picture2(Index).CurrentX = XCord(CurTree(Index), Index, CurrentSeq)
                    A = Picture2(Index).CurrentX
                    b = Picture2(Index).CurrentY
                    'Form2.Picture2(Index).Line (A, B + 3)-(A + 1500, B + AddjNum + 1), BackColours, BF
                    Picture2(Index).CurrentX = A
                    Picture2(Index).CurrentY = b
                    Form2.Picture2(Index).ForeColor = MultColour(CurrentSeq)
                    Form2.Picture2(Index).Print OriginalName(CurrentSeq)
                    If OriginalName(CurrentSeq) = "0B.JP.x.PATIENT_IMS1" Then
                x = x
            End If
                
            Else
                A = Picture2(Index).CurrentX
                b = Picture2(Index).CurrentY
                Form2.Picture2(Index).Line (A, b + 3)-(A + 1500, b + AddjNum + 1), BackColours, BF
                Picture2(Index).CurrentX = A
                Picture2(Index).CurrentY = b
                If CurrentSeq = Seq2 Then
                    
                    'Picture2(Index).print originalname(CurrentSeq)
                    
                    If OutsideFlagX = 2 Then
                        Form2.Picture2(Index).ForeColor = RGB(0, 0, 128)
                    Else
                        Form2.Picture2(Index).ForeColor = RGB(0, 0, 255)
                    End If
                    Form2.Picture2(Index).Print OriginalName(Seq2)
                    
                ElseIf CurrentSeq = Seq1 Then
                    
                    If OutsideFlagX = 1 Then
                        Form2.Picture2(Index).ForeColor = RGB(0, 0, 128)
                    Else
                        Form2.Picture2(Index).ForeColor = RGB(0, 0, 255)
                    End If
                    Form2.Picture2(Index).Print OriginalName(Seq1)
                    
                Else
                    
                
                    Form2.Picture2(Index).ForeColor = RGB(255, 0, 0)
                    
                    Form2.Picture2(Index).Print OriginalName(Seq3)
                    
                End If
            End If
    
    Next 'CurrentSeq
End Sub

Private Sub Picture3_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Call DoKeydown(KeyCode)
End Sub

Private Sub Picture3_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
Dim DrawW As Single, PosString As String
F2P2Y = -1
P1Seq = -1
P1NT = -1
F1P7X = -1
F1P2Y = -1
F1P3Y = -1
F1P6Y = -1
F2P3Y = Index
F1P16Y = -1
F1P26Y = -1
F2P2Index = -1
F2P2SNum = -1

Picture4(Index).CurrentY = 0
Picture4(Index).AutoRedraw = False

DrawW = Picture3(Index).ScaleWidth - 10
DrawW = ((x - 5) / (DrawW)) * Len(StrainSeq(0))

DrawW = CLng(DrawW)
If DrawW = 0 Then DrawW = 1
Picture4(Index).CurrentX = 20 + x - Picture4(Index).TextWidth(Str(DrawW)) / 2


Picture4(Index).Refresh
If DrawW >= 1 And DrawW <= Len(StrainSeq(0)) Then


    Picture4(Index).Print DrawW
End If
XX = Form2.Picture2(0).Visible
'Picture2(1).SetFocus
End Sub

Private Sub ProgressBar1_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub ProgressBar1_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
End Sub

Private Sub RedMnu_Click()
    SelCol = RGB(255, 128, 128)

End Sub

Private Sub RejectAllMnu3_Click()
Dim StartNextno As Long
Form1.SSPanel1.Caption = "Finding accepted sequences"
Call UpdateF2Prog
If DontSaveUndo = 0 Then
    Call SaveUndo
    DontSaveUndo = 1
End If
 
 Call UnModNextno
 Dim NodeFind() As Byte
    Call MakeNodeFind(NodeFind(), SelectNode(3))
    Dim EN As Long
    EN = SuperEventList(XoverList(RelX, RelY).Eventnumber)
    Dim tSelectNode(10) As Long
    For x = 0 To 10
        tSelectNode(x) = SelectNode(x)
    Next x
    IXOFlag = 1
    If SelectNode(4) = 0 Then
        StartNextno = NextNo
        For x = 0 To NextNo
            If NodeFind(SelectNode(0), x) = 1 Then
                If Daught(EN, x) > 0 Then
                    For Y = 1 To CurrentXOver(x)
                        If SuperEventList(XoverList(x, Y).Eventnumber) = EN Then
                            'If XOverList(TreeTrace(F2P2SNum), Y).Accept <> 1 Then
                            '    AcceptExMnu.Enabled = True
                            'Else
                            '    AcceptExMnu.Enabled = False
                            'End If
                            TRelX = x
                            TRelY = Y
                            RRelY = RelY
                            RRelX = RelX
                            'Exit For
                        End If
                    Next Y
                    F2P2SNum = x
                    Call RejectExMnu_Click
                    For T = 0 To 10
                        SelectNode(T) = tSelectNode(T)
                    Next T
                End If
            End If
            SSX = Abs(GetTickCount)
            If Abs(SSX - lssx) > 500 Then
                lssx = SSX
                Form1.ProgressBar1.Value = (x / StartNextno) * 100
                UpdateF2Prog
            End If
        Next x
        
    Else
        Form2.Enabled = False
        Dim oXoMi As Long
        oXoMi = XOMiMaInFileFlag
        If XOMiMaInFileFlag = 1 Then
            'XOMiMaInFileFlag As Byte, UBXOMi As Long, UBXoMa As Long
            Screen.MousePointer = 11
            Form1.ProgressBar1 = 2
            Form1.SSPanel1.Caption = "Loading minor parent lists from disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
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
            Form1.ProgressBar1 = 20
            Form1.SSPanel1.Caption = "Loading major parent lists from disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            
            If MaRec < 1 Then
                Open "RDP5BestXOListMa" + UFTag For Binary As #FF
                Get #FF, , BestXOListMa()
                Close #FF
                MaRec = 1
            End If
            ChDrive oDirX
            ChDir oDirX
            
            Form1.ProgressBar1 = 40
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            
            
        End If
        XOMiMaInFileFlag = 0
        Form2.Enabled = True
        Call ModNextno
        StartNextno = NextNo
        For x = 0 To NextNo '10,153:10,107:10,82
            
            'originalname(TreeTrace(TreeTraceSeqs(1, X))) = 17827243,58613386,10187311,17827264
            'originalname(TreeTraceSeqs(1, X))=10187311,17827264,58613386,17827243
            'originalname(TreeTrace(X)) = 17827250,17827264,58613386,17827243
            'originalname(X) =17827250,17827264,58613386,17827243
            If NodeFind(SelectNode(0), TreeTrace(TreeTraceSeqs(1, x))) = 1 Then 'And TreeTrace(TreetraceSeqs(1, X)) <= Nextno Then
            'If NodeFind(SelectNode(3), SelectNode(0), TreeTrace(X)) = 1 Then
                'XX = UBound(Daught, 1)
                If Daught(EN, TreeTrace(TreeTraceSeqs(1, x))) > 0 Then
                    If TreeTrace(TreeTraceSeqs(1, x)) <= PermNextno Then
                        For Y = 1 To CurrentXOver(TreeTrace(TreeTraceSeqs(1, x)))
                            If SuperEventList(XoverList(TreeTrace(TreeTraceSeqs(1, x)), Y).Eventnumber) = EN Then
                                
                                TRelX = TreeTrace(TreeTraceSeqs(1, x))
                                TRelY = Y
                                RRelY = RelY
                                RRelX = RelX
                                Exit For
                            End If
                        Next Y
                    End If
                    F2P2SNum = x
                    
                    'tSelectNode (0)
                    Call RejectExMnu_Click
                    For T = 0 To 10
                        SelectNode(T) = tSelectNode(T)
                    Next T
                End If
            End If
            SSX = Abs(GetTickCount)
            If Abs(SSX - lssx) > 500 Then
                lssx = SSX
                Form1.ProgressBar1.Value = (x / StartNextno) * 100
                UpdateF2Prog
            End If
        Next x
        If oXoMi = 1 Then
            oDirX = CurDir
            ChDrive App.Path
            ChDir App.Path
            FF = FreeFile
            
            Form1.ProgressBar1 = 60
            Form1.SSPanel1.Caption = "Writing minor parent lists to disk"
            Call UpdateF2Prog
            Form1.Refresh: Form2.Refresh
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            UBXOMi = UBound(BestXOListMi, 2)
            UBXoMa = UBound(BestXOListMa, 2)
            
            Open "RDP5BestXOListMi" + UFTag For Binary As #FF
            Put #FF, , BestXOListMi()
            Close #FF
            MiRec = MiRec - 1
            
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            Form1.ProgressBar1 = 80
            Call UpdateF2Prog
            Form1.SSPanel1.Caption = "Writing major parent lists to disk"
            Form1.Refresh: Form2.Refresh
            Open "RDP5BestXOListMa" + UFTag For Binary As #FF
            Put #FF, , BestXOListMa()
            Close #FF
            MaRec = MaRec - 1
            ChDrive oDirX
            ChDir oDirX
            Erase BestXOListMi
            Erase BestXOListMa
            Form1.ProgressBar1 = 100
            
            Form1.SSPanel1.Caption = ""
            
            Form1.ProgressBar1 = 0
            Form1.Refresh: Form2.Refresh
            Call UpdateF2Prog
            If DebuggingFlag < 2 Then Form1.WindowState = Form1.WindowState
            If DebuggingFlag < 2 Then Form2.WindowState = Form2.WindowState
            Screen.MousePointer = 0
        End If
        XOMiMaInFileFlag = oXoMi
    End If
    UnModNextno
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call DoTreeColour(Form2.Picture2(0), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
        x = x
    Next x

    
    UnModNextno
    x = x
    Call IntegrateXOvers(0)
    If RIMode = 1 Then
        Call MakeSummary
        x = x
    End If
    IXOFlag = 0
    Form1.Timer1.Enabled = True
    DontSaveUndo = 0
End Sub

Private Sub RejectEAxMnu_Click()
'SERecSeq = RelX
'SEPAVal = RelY
ARFlag = 4
Form1.Timer6.Enabled = True
End Sub

Private Sub RejectExMnu_Click()
'SERecSeq = RelX
'SEPAVal = RelY
ARFlag = 3
Form1.Timer6.Interval = 1
Form1.Timer6.Enabled = True
ItsFinished = 1
Do
    DoEvents
    If ItsFinished = 2 Then Exit Do
Loop
ItsFinished = 0
If IXOFlag = 0 Then
    For x = 0 To 3
        If x = 1 Then
            Call ModNextno
        Else
            If x = 3 And (CurTree(x) = 0 Or CurTree(x) = 1) Then
                Call UnModNextno
            End If
        End If
        Call DoTreeColour(Form2.Picture2(0), CurTree(x), x)
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(x).Value, x, CurTree(x), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(x))
        x = x
    Next x

    Call IntegrateXOvers(0)
End If
x = x
Form1.Timer1.Enabled = True
End Sub

Private Sub SaveBMP_Click()

    With Form2.CommonDialog1
        .FileName = ""
        '.InitDir = currentdir
        .DefaultExt = ".bmp"   'Specify the default extension.
        'Specify which file extensions will be preferred.
        '.Filter = "DNA Man Multiple Alignment Files (*.msd)|*.msd|Alignment Files (*.ali)|*.ali|RDP Project Files (*.rdp)|*.rdp|Sequence Files (*.seq)|*.seq|all files (*.*)|*.*"
        .Filter = "BMP File (*.bmp)|*.bmp"
        '.InitDir = "c:/darren/DNA Man/msvstrai/dna project/"
        .Action = 2 'Specify that the "open file" action is required.
        sbmpname$ = .FileName  'Stores selected file name in the
        'string, fname$.
        SBMPnameII = .FileTitle
    End With

    If sbmpname$ = "" Then Screen.MousePointer = 0: Exit Sub
    Screen.MousePointer = 11
    'Picture16.BackColor = QBColor(15)
    SavePicture Picture2(F2TreeIndex).Image, sbmpname$
    Screen.MousePointer = 0
End Sub

Private Sub SaveEMF_Click()
    Dim NHFlag As Integer
    With Form2.CommonDialog1
        .FileName = ""
        .DefaultExt = ".emf"   'Specify the default extension.
        'Specify which file extensions will be preferred.
        .Filter = "EMF File (*.emf)|*.emf"
        .Action = 2 'Specify that the "open file" action is required.
        EMFFName = .FileName 'Stores selected file name in the
        semfnameII = .FileTitle
    End With
    Call GetNHFlag(F2TreeIndex, CurTree(F2TreeIndex), NHFlag)
    Call NJEMF(NHFlag)
    

End Sub

Private Sub SaveNH_Click()

    Dim NHFlag As Integer

    With Form2.CommonDialog1
        .FileName = ""
        '.InitDir = currentdir
        .DefaultExt = ".tre"   'Specify the default extension.
        'Specify which file extensions will be preferred.
        '.Filter = "DNA Man Multiple Alignment Files (*.msd)|*.msd|Alignment Files (*.ali)|*.ali|RDP Project Files (*.rdp)|*.rdp|Sequence Files (*.seq)|*.seq|all files (*.*)|*.*"
        .Filter = "NH Format (*.tre)|*.tre"
        '.InitDir = "c:/darren/DNA Man/msvstrai/dna project/"
        .Action = 2 'Specify that the "open file" action is required.
        snhname$ = .FileName  'Stores selected file name in the
        'string, fname$.
        SNHFnameII = .FileTitle
    End With

    If F2TreeIndex = 0 Then

        If CurTree(F2TreeIndex) = 0 Then
            NHFlag = 0
        ElseIf CurTree(F2TreeIndex) = 1 Then
            NHFlag = 4
        ElseIf CurTree(F2TreeIndex) = 2 Then
            NHFlag = 5
        ElseIf CurTree(F2TreeIndex) = 3 Then
            NHFlag = 6
        ElseIf CurTree(F2TreeIndex) = 4 Then
            NHFlag = 13
        End If

    ElseIf F2TreeIndex = 2 Then

        If CurTree(F2TreeIndex) = 0 Then
            NHFlag = 2
        ElseIf CurTree(F2TreeIndex) = 1 Then
            NHFlag = 7
        ElseIf CurTree(F2TreeIndex) = 2 Then
            NHFlag = 8
        ElseIf CurTree(F2TreeIndex) = 3 Then
            NHFlag = 9
        ElseIf CurTree(F2TreeIndex) = 4 Then
            NHFlag = 14
        End If
    ElseIf F2TreeIndex = 1 Then

        If CurTree(F2TreeIndex) = 0 Then
            NHFlag = 1
        ElseIf CurTree(F2TreeIndex) = 1 Then
            NHFlag = 10
        ElseIf CurTree(F2TreeIndex) = 2 Then
            NHFlag = 11
        ElseIf CurTree(F2TreeIndex) = 3 Then
            NHFlag = 12
        ElseIf CurTree(F2TreeIndex) = 4 Then
            NHFlag = 15
        End If
    ElseIf F2TreeIndex = 3 Then
        If CurTree(F2TreeIndex) = 0 Then
            NHFlag = 17
        ElseIf CurTree(F2TreeIndex) = 1 Then
            NHFlag = 16
        ElseIf CurTree(F2TreeIndex) = 2 Then
            NHFlag = 33
        
        ElseIf CurTree(F2TreeIndex) = 3 Then
            NHFlag = 34
        ElseIf CurTree(F2TreeIndex) = 4 Then
            'NHFlag = F2TreeIndex
            NHFlag = 34
        End If
    Else
        NHFlag = F2TreeIndex
    End If

    If snhname$ = "" Then Screen.MousePointer = 0: Exit Sub
    Screen.MousePointer = 11
    'Picture11.BackColor = QBColor(15)
    Open snhname$ For Output As #1
    Print #1, NHString(NHFlag)
    Screen.MousePointer = 0
    Close #1
    x = x
End Sub

Private Sub SelColMnu_Click()

    'With Form2.CommonDialog1
    '    .Action = 3 'Specify that the "colour" action is required.
    '    'Stores selected colour in the string, SelCol.
    '    SelCol = .Color
    'End With

End Sub

Private Sub SSPanel1_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub SSPanel1_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
End Sub

Private Sub SSPanel2_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub SSPanel2_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
End Sub

Private Sub SSPanel3_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub SSPanel3_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
F2P2Y = -1
    F1P2Y = -1
    F1P3Y = -1
    F1P6Y = -1
    F2P3Y = -1
    F1P16Y = -1
    F1P26Y = -1
    F2P2Index = -1
End Sub

Private Sub SSPanel4_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub SSPanel4_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
If Screen.MousePointer = 5 Or Screen.MousePointer = 7 Or Screen.MousePointer = 9 Then
    Screen.MousePointer = 0
End If
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
End Sub

Private Sub SSPanel5_MouseDown(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
x = x
End Sub

Private Sub SSPanel5_MouseMove(Index As Integer, Button As Integer, Shift As Integer, x As Single, Y As Single)
RecSeq = 0
PAVal = 0: PermXVal = 0: PermYVal = 0
Dim AxLen As Long
    If DebuggingFlag < 2 Then On Error Resume Next
    AxLen = -1
    AxLen = GYAxHi(1)
    On Error GoTo 0
    If AxLen > 0 And p7CurWinSize > 0 Then
        P7XP = oP7XP
        Call ShrinkZoom
        P7XP = 0
        oP7XP = 0
        Form1.Label1.Caption = ""
    End If
End Sub

Private Sub Timer1_Timer()
'XX = GetKeyState(VK_LBUTTON)
If LoadBusy <> 0 Then Exit Sub
If DoingShellFlag > 0 Then Exit Sub
If CurrentlyRunningFlag <> 0 Then Exit Sub
If SchemDownFlag <> 0 Then Exit Sub

If GetKeyState(VK_LBUTTON) < 0 Then
    Exit Sub
End If
If DebuggingFlag < 2 Then On Error Resume Next
Timer1.Enabled = False
If Form2.WindowState = vbMinimized Then Exit Sub
If Form2.Width <> Form2OWidth Then
    Form2.Width = Form2OWidth
    'Form2.Height = Form2OHeight
End If

If Form2.Height < (300 * Screen.TwipsPerPixelY) Then
    Form2.Height = 300 * Screen.TwipsPerPixelY
    Call ResizeForm2
    Form2.Refresh
End If


    On Error GoTo 0
End Sub

Private Sub TreeOptMnu_Click()
VisFrame = 11
OptFlag = 16
Form3.TabStrip2.Tabs(1).Caption = "Tree Options"
        

For x = 0 To 14

    If x = VisFrame Then
        Form3.Frame2(x).Visible = True
    Else
        Form3.Frame2(x).Visible = False
    End If

Next 'X
Form3.TabStrip2.Tabs(1).Caption = "Tree Options"
Form3.TabStrip1.Visible = False


Dim OChk As Byte
OptionsFlag = 1
OChk = NoF3Check2
NoF3Check2 = 1
Form3.Combo1.Enabled = True


Command3.SetFocus
ErrorFlag = 0

OptFlag = OptFlag
'SSPanel1(0).Enabled = False
'SSPanel1(1).Enabled = False
'SSPanel1(2).Enabled = False
'SSPanel1(3).Enabled = False
'SSPanel2.Enabled = False

SpacerFlagT = SpacerFlag

Call SetF3Vals(1)

Form2.Enabled = False
DoEvents
Form3.Visible = True
Form3.Command1.SetFocus

NoF3Check2 = OChk
OptionsFlag = 0


End Sub

Private Sub UPGMAMnu2_Click()
    
    CurTree(F2TreeIndex) = 0

    For x = 0 To 4
        TTFlag(F2TreeIndex, x) = 0
    Next 'X
    
    TTFlag(F2TreeIndex, 0) = 1
    If F2TreeIndex <> 0 Then
        Call ModNextno
    End If
    


    'ExtraDx = DoTreeColour(Picture2(F2TreeIndex), 1, F2TreeIndex)
    'DoTreeLegend treeblocksl(), TBLLen, Picture2(F2TreeIndex), ExtraDx, 14
If F2TreeIndex <> 3 Then
    Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -Form2.VScroll1(F2TreeIndex).Value, F2TreeIndex, 0, TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(F2TreeIndex))
    
    If F2TreeIndex = 0 Then
        Label1(0).Caption = "UPGMA ignoring recombination"
    ElseIf F2TreeIndex = 2 Then
        'Label1(2).Caption = "UPGMA of region derived from minor parent (" + Trim$(CStr(Decompress(XOverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XOverList(RelX, RelY).Ending))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning < XoverList(RelX, RelY).Ending Then
            Label1(2).Caption = "UPGMA of region derived from minor parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + ")"
        Else
            Label1(2).Caption = "UPGMA of regions derived from minor parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If
    ElseIf F2TreeIndex = 1 Then
        If XoverList(RelX, RelY).Ending = Len(StrainSeq(0)) Then
            EN = 1
        Else
            EN = XoverList(RelX, RelY).Ending + 1
        End If
        If XoverList(RelX, RelY).Beginning = 1 Then
            BE = Len(StrainSeq(0))
        Else
            BE = XoverList(RelX, RelY).Beginning - 1
        End If
        'Form2.Label1(1) = "UPGMA of region derived from major parent (" + Trim$(CStr(Decompress(EN))) + " - " + Trim$(CStr(Decompress(BE))) + ")" '"UPGMA of Recombinant Region"
        If XoverList(RelX, RelY).Beginning > XoverList(RelX, RelY).Ending Then
            Form2.Label1(1) = "UPGMA of region derived from major parent (" + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + ")"
        Else
            Form2.Label1(1) = "UPGMA of regions derived from major parent (1 - " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Beginning - 1))) + " and " + Trim$(CStr(Decompress(XoverList(RelX, RelY).Ending + 1))) + " - " + Trim$(CStr(Decompress(Len(StrainSeq(0))))) + ")"
        End If

    ElseIf F2TreeIndex = 3 Then
        Label1(3).Caption = "FastNJ tree with recombinant regions removed"
    End If
    If F2TreeIndex <> 0 Then
        Call UnModNextno
        x = x
    End If
Else
    TreeImage(3) = 0
    ADT = 1
    OV = DontChangeVScrollFlag
    DontChangeVScrollFlag = 1
    Call MultTreeWin
    DontChangeVScrollFlag = OV
    Form1.ProgressBar1 = 0
    Call UpdateF2Prog
End If
End Sub

Private Sub VScroll1_Change(Index As Integer)
    'Picture2(Index).Top = -VScroll1(Index).Value
'    LastSE(Index, CurTree(Index), 0) = 0
'    LastSE(Index, CurTree(Index), 1) = TDLen(Index, CurTree(Index), 1)
'    RedoLastSE(Index) = 0
    
    If Form1.VScroll1.Max < 0 Then Form1.VScroll1.Max = 0
    If Form1.VScroll1.Max > 0 And CLng(Form1.VScroll1.Max / NextNo) > 0 Then
        VScroll1(Index).SmallChange = CLng(Form1.VScroll1.Max / NextNo)
    Else
        'Exit Sub
    End If
    If VSC1NC = 1 Or F2ResizeFlag = 1 Then Exit Sub
    If Index = 0 Then
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(Index).Value, Index, CurTree(Index), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(Index))
    Else
        ModNextno
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(Index).Value, Index, CurTree(Index), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(Index))
        UnModNextno
        x = x
    End If
End Sub

Private Sub VScroll1_GotFocus(Index As Integer)
    Command3.SetFocus
End Sub

Private Sub VScroll1_Scroll(Index As Integer)
    'Form2.VScroll1(Index).Max = Form1.Picture16.Height - Form2.Picture1(X).ScaleHeight
'    LastSE(Index, CurTree(Index), 0) = 0
'    LastSE(Index, CurTree(Index), 1) = TDLen(Index, CurTree(Index), 1)
'    RedoLastSE(Index) = 0
'
    If VScroll1(Index).Max > 0 Then
        VScroll1(Index).SmallChange = 1 'CLng(Form1.VScroll1.Max / Nextno)
    End If
    If VSC1NC = 1 Or F2ResizeFlag = 1 Then Exit Sub
    If Index = 0 Then
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(Index).Value, Index, CurTree(Index), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(Index))
    Else
        ModNextno
        Call TreeDrawing(0, 0, TreeBlocksL(), TBLLen, 1, PermOriginalName(), -VScroll1(Index).Value, Index, CurTree(Index), TreeDrawB(), TDLen(), TreeBlocks(), TBLen(), Form2.Picture2(Index))
        UnModNextno
        x = x
    End If
End Sub
