VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form MainForm 
   AutoRedraw      =   -1  'True
   Caption         =   "NDT Controller And Monitoring"
   ClientHeight    =   8340
   ClientLeft      =   225
   ClientTop       =   570
   ClientWidth     =   17265
   LinkTopic       =   "Form1"
   ScaleHeight     =   8340
   ScaleWidth      =   17265
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton btnSave 
      Caption         =   "Save Data"
      Height          =   660
      Left            =   14020
      TabIndex        =   26
      Top             =   7200
      Width           =   2055
   End
   Begin VB.PictureBox saveImageWafeForm 
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000008&
      Height          =   9855
      Left            =   -120
      Picture         =   "MainForm.frx":0000
      ScaleHeight     =   653
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   1203
      TabIndex        =   17
      Top             =   10080
      Visible         =   0   'False
      Width           =   18105
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000008&
      Height          =   9855
      Left            =   4320
      Picture         =   "MainForm.frx":23FDAE
      ScaleHeight     =   653
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   1203
      TabIndex        =   16
      Top             =   9240
      Visible         =   0   'False
      Width           =   18105
   End
   Begin VB.PictureBox ResultDisplay 
      BackColor       =   &H80000008&
      Height          =   6255
      Left            =   9840
      Picture         =   "MainForm.frx":47FB5C
      ScaleHeight     =   413
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   413
      TabIndex        =   11
      Top             =   840
      Width           =   6260
   End
   Begin VB.Timer Timer1 
      Interval        =   1
      Left            =   0
      Top             =   7320
   End
   Begin MSCommLib.MSComm arduino 
      Left            =   0
      Top             =   7920
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   16
      DTREnable       =   -1  'True
      BaudRate        =   115200
   End
   Begin VB.CommandButton btnCalibrate 
      Caption         =   "Calibrate"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1851
      Left            =   490
      TabIndex        =   8
      Top             =   6120
      Width           =   1806
   End
   Begin VB.CommandButton btnXmin 
      Caption         =   "X -"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   2640
      TabIndex        =   7
      Top             =   6120
      Width           =   1476
   End
   Begin VB.CommandButton btnXplus 
      Caption         =   "X +"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   2640
      TabIndex        =   6
      Top             =   7130
      Width           =   1476
   End
   Begin VB.CommandButton btnYmin 
      Caption         =   "Y -"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   4320
      TabIndex        =   5
      Top             =   6120
      Width           =   1476
   End
   Begin VB.CommandButton btnYplus 
      Caption         =   "Y +"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   4320
      TabIndex        =   4
      Top             =   7130
      Width           =   1476
   End
   Begin VB.CommandButton btnZmin 
      Caption         =   "Z -"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   6000
      TabIndex        =   3
      Top             =   6120
      Width           =   1476
   End
   Begin VB.CommandButton btnZplus 
      Caption         =   "Z +"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   830
      Left            =   6000
      TabIndex        =   2
      Top             =   7130
      Width           =   1476
   End
   Begin VB.CommandButton btnAuto 
      Caption         =   "Auto"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1836
      Left            =   7690
      TabIndex        =   1
      Top             =   6120
      Width           =   1806
   End
   Begin VB.PictureBox DisplayPicture 
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000008&
      Height          =   4928
      Left            =   480
      Picture         =   "MainForm.frx":48B80B
      ScaleHeight     =   325
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   600
      TabIndex        =   0
      Top             =   840
      Width           =   9053
   End
   Begin VB.Label Label24 
      Caption         =   "20"
      Height          =   255
      Left            =   16680
      TabIndex        =   37
      Top             =   5640
      Width           =   495
   End
   Begin VB.Label Label23 
      Caption         =   "10"
      Height          =   255
      Left            =   16680
      TabIndex        =   36
      Top             =   6240
      Width           =   495
   End
   Begin VB.Label Label22 
      Caption         =   "40"
      Height          =   255
      Left            =   16680
      TabIndex        =   35
      Top             =   4440
      Width           =   495
   End
   Begin VB.Label Label21 
      Caption         =   "30"
      Height          =   255
      Left            =   16680
      TabIndex        =   34
      Top             =   5040
      Width           =   495
   End
   Begin VB.Label Label20 
      Caption         =   "80"
      Height          =   255
      Left            =   16680
      TabIndex        =   33
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label Label19 
      Caption         =   "60"
      Height          =   255
      Left            =   16680
      TabIndex        =   32
      Top             =   3240
      Width           =   495
   End
   Begin VB.Label Label18 
      Caption         =   "70"
      Height          =   255
      Left            =   16680
      TabIndex        =   31
      Top             =   2640
      Width           =   495
   End
   Begin VB.Label Label17 
      Caption         =   "90"
      Height          =   255
      Left            =   16680
      TabIndex        =   30
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label Label16 
      Caption         =   "50"
      Height          =   255
      Left            =   16680
      TabIndex        =   29
      Top             =   3840
      Width           =   495
   End
   Begin VB.Label Label15 
      Caption         =   "0"
      Height          =   255
      Left            =   16680
      TabIndex        =   28
      Top             =   6840
      Width           =   495
   End
   Begin VB.Label Label14 
      Caption         =   "100"
      Height          =   255
      Left            =   16680
      TabIndex        =   27
      Top             =   840
      Width           =   495
   End
   Begin VB.Image Image1 
      Height          =   6255
      Left            =   16200
      Picture         =   "MainForm.frx":4984CC
      Stretch         =   -1  'True
      Top             =   840
      Width           =   375
   End
   Begin VB.Label Label13 
      Caption         =   "Damage :"
      Height          =   255
      Left            =   12480
      TabIndex        =   25
      Top             =   7560
      Width           =   735
   End
   Begin VB.Label Label12 
      Caption         =   "la 12"
      Height          =   255
      Left            =   13320
      TabIndex        =   24
      Top             =   7560
      Width           =   495
   End
   Begin VB.Label Label11 
      Caption         =   "la 11"
      Height          =   255
      Left            =   13320
      TabIndex        =   23
      Top             =   7200
      Width           =   495
   End
   Begin VB.Label Label10 
      Caption         =   "Gain       :"
      Height          =   255
      Left            =   12480
      TabIndex        =   22
      Top             =   7200
      Width           =   735
   End
   Begin VB.Label Label9 
      Caption         =   "X :"
      Height          =   255
      Left            =   11520
      TabIndex        =   21
      Top             =   7200
      Width           =   255
   End
   Begin VB.Label Label8 
      Caption         =   "Y :"
      Height          =   255
      Left            =   11520
      TabIndex        =   20
      Top             =   7560
      Width           =   255
   End
   Begin VB.Label Label7 
      Caption         =   "lab 7"
      Height          =   255
      Left            =   11880
      TabIndex        =   19
      Top             =   7200
      Width           =   375
   End
   Begin VB.Label Label6 
      Caption         =   "lab 6"
      Height          =   255
      Left            =   11880
      TabIndex        =   18
      Top             =   7560
      Width           =   375
   End
   Begin VB.Label Label5 
      Caption         =   "lab 5"
      Height          =   255
      Left            =   10920
      TabIndex        =   15
      Top             =   7560
      Width           =   400
   End
   Begin VB.Label Label4 
      Caption         =   "lab 4"
      Height          =   255
      Left            =   10920
      TabIndex        =   14
      Top             =   7200
      Width           =   400
   End
   Begin VB.Label Label3 
      Caption         =   "Label3"
      Height          =   375
      Left            =   1800
      TabIndex        =   13
      Top             =   11520
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Vrms CH 2 :"
      Height          =   255
      Left            =   9960
      TabIndex        =   12
      Top             =   7560
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Vrms CH 1 :"
      Height          =   255
      Left            =   9960
      TabIndex        =   10
      Top             =   7200
      Width           =   855
   End
   Begin VB.Label header 
      Alignment       =   2  'Center
      Caption         =   "NDT Controller and Monitoring"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   21.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   540
      Left            =   6120
      TabIndex        =   9
      Top             =   120
      Width           =   5865
   End
End
Attribute VB_Name = "MainForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnAuto_Click()
arduino.Output = "s"
Form4.Show
End Sub

Private Sub btnCalibrate_Click()
arduino.Output = "c"
ResultDisplay.Picture = LoadPicture("bgResult.jpg")
End Sub

Private Sub btnSave_Click()
'kode Buat Save
Set fsoStream = fso.CreateTextFile("Save File\CSV File\Data.csv", True)
fsoStream.WriteLine "X;Y;Vtx;Vrx;Gain"
For x = 0 To 499
    For y = 0 To 499
        If coordinateSaveData(x, y) <> "" Then
            strLine = x & ";" & y & ";" & coordinateSaveData(x, y)
            fsoStream.WriteLine strLine
        End If
    Next y
Next x
fsoStream.Close
Set fsoStream = Nothing
Set fso = Nothing
End Sub

Private Sub btnXmin_Click()
arduino.Output = "1"
End Sub

Private Sub btnXplus_Click()
arduino.Output = "x"
End Sub

Private Sub btnYmin_Click()
arduino.Output = "y"
End Sub

Private Sub btnYplus_Click()
arduino.Output = "2"
End Sub

Private Sub btnZmin_Click()
arduino.Output = "3"
End Sub

Private Sub btnZplus_Click()
arduino.Output = "z"
End Sub

Private Sub Form_Load()
arduino.PortOpen = True
Timer1.Enabled = True
End Sub

Private Sub Timer1_Timer()
   Dim nReadLen As Long
   Dim nDrawLen As Long
   Dim nTrigLevel As Integer
   Dim nSlope As Integer
   Dim nHTrigPos As Integer
   Dim nTrigPoint(0) As Long
   Dim nRe As Integer
    
    nReadLen = 10240 '10K
    nDrawLen = 10000 '
    nTrigLevel = 64 '
    nSlope = 0 ' 0:Rise; 1: Fall
    nHTrigPos = 50 ' 0 ~ 100
    nTrigPoint(0) = 0 '


    nRe = dsoReadHardData(m_nDevIndex, m_nCH1Data(0), m_nCH2Data(0), nReadLen, m_nCalData(0), m_nCH1VoltDIV, m_nCH2VoltDIV, 0, 0, nTrigLevel, nSlope, m_nTimeDIV, nHTrigPos, nDrawLen, nTrigPoint(0), 0)
    If nRe > 0 Then
        MainForm.DisplayPicture.Cls
        'Draw CH1
         nRe = HTDrawWaveInYTVB(MainForm.DisplayPicture.hDC, 0, 0, MainForm.DisplayPicture.ScaleWidth, MainForm.DisplayPicture.ScaleHeight, 255, 255, 0, 0, m_nCH1Data(0), nReadLen, nDrawLen, nReadLen / 2, 128, 1#, 1#, 0, 0)

        'Draw CH2
         nRe = HTDrawWaveInYTVB(MainForm.DisplayPicture.hDC, 0, 0, MainForm.DisplayPicture.ScaleWidth, MainForm.DisplayPicture.ScaleHeight, 0, 255, 0, 0, m_nCH2Data(0), nReadLen, nDrawLen, nReadLen / 2, 128, 1#, 1#, 0, 0)
    
        'Draw in Save Image Picture Box
        MainForm.Picture1.Cls
        'Draw CH1
         nRe = HTDrawWaveInYTVB(MainForm.Picture1.hDC, 0, 0, MainForm.Picture1.ScaleWidth, MainForm.Picture1.ScaleHeight, 255, 255, 0, 0, m_nCH1Data(0), nReadLen, nDrawLen, nReadLen / 2, 128, 1#, 1#, 0, 0)
    
        'Draw CH2
         nRe = HTDrawWaveInYTVB(MainForm.Picture1.hDC, 0, 0, MainForm.Picture1.ScaleWidth, MainForm.Picture1.ScaleHeight, 0, 255, 0, 0, m_nCH2Data(0), nReadLen, nDrawLen, nReadLen / 2, 128, 1#, 1#, 0, 0)
    
    End If
    
    'Get Data VRMS
    For x = 10 To 10000
        If m_nCH1Data(x) >= vmaxDataCH1 Then
            vmaxDataCH1 = m_nCH1Data(x)
        End If
        If m_nCH2Data(x) >= vmaxDataCH2 Then
            vmaxDataCH2 = m_nCH2Data(x)
        End If
        If m_nCH1Data(x) <= vminDataCH1 Then
            vminDataCH1 = m_nCH1Data(x)
        End If
        If m_nCH2Data(x) <= vminDataCH2 Then
            vminDataCH2 = m_nCH2Data(x)
        End If
    Next x
    vppdataCH1 = ((vminDataCH1 - vmaxDataCH1) * -1) / 166 * 5.2 * 2
    vrmsDataCH1 = vppdataCH1 / (2 * Math.Sqr(2))
    vppdataCH2 = ((vminDataCH2 - vmaxDataCH2) * -1) / 166 * 5.2 * 2
    vrmsDataCH2 = vppdataCH2 / (2 * Math.Sqr(2))
    If vrmsDataCH2 = 0 Then
        gain = 0
    Else
        gain = (((vminDataCH2 - vmaxDataCH2) * -1) / ((vminDataCH1 - vmaxDataCH1) * -1))
    End If
    
    damageLevel = (gain - minDamageLevel) / (maxDamageLevel - minDamageLevel) * 255
    damageLevelRange100 = (gain - minDamageLevel) / (maxDamageLevel - minDamageLevel) * 100
    If damageLevel < 0 Then
        damageLevel = 0
    End If
    If damageLevel > 255 Then
        damageLevel = 255
    End If
    
    'Parsing Data From Arduino
    If arduino.InBufferCount > 0 Then
        dataInput = arduino.Input
        For x = 1 To Len(dataInput)
            comaSeparator = Mid(dataInput, x, 1)
            If comaSeparator = Chr(44) Then
                xCoordinates = Mid(dataInput, 1, x - 1)
                yCoordinates = Mid(dataInput, x + 1, Len(dataInput))
            End If
        Next x
    End If
    
    xCoordinate = Val(xCoordinates)
    yCoordinate = Val(yCoordinates)
    
    'Draw Result Display Range 1.30 - 1.39
    ResultDisplay.Line ((xCoordinate * mili2Pixel) + border, (yCoordinate * mili2Pixel) + border)-(((xCoordinate * mili2Pixel) + mili2Pixel) + border, ((yCoordinate * mili2Pixel) + mili2Pixel) + border), RGB((damageLevel), 255 - (damageLevel), 0), BF
    
    'Save Data to Array (coordinateSaveData)
    coordinateSaveData(xCoordinate, yCoordinate) = vrmsDataCH1 & ";" & vrmsDataCH2 & ";" & gain
    
    'Save WaveForm
    'saveImageWafeForm.Picture = Picture1.Image
    'SavePicture saveImageWafeForm.Picture, "Save File\Wave Form\x = " & xCoordinate & "; y = " & yCoordinate & ".bmp"
    'saveImageWafeForm.Picture = LoadPicture("bgSave.bmp")
    
    'Print Legenda
    Label4.Caption = vrmsDataCH1
    Label5.Caption = vrmsDataCH2
    Label7.Caption = xCoordinate
    Label6.Caption = yCoordinate
    Label11.Caption = gain
    Label12.Caption = damageLevelRange100
    'Label12.Caption = ((vminDataCH2 - vmaxDataCH2) * -1)
    
    'Clear Variable Data
    vmaxDataCH1 = 0
    vmaxDataCH2 = 0
    vminDataCH1 = 0
    vminDataCH2 = 0
    vppdataCH1 = 0
    vrmsDataCH1 = 0
    vppdataCH2 = 0
    vrmsDataCH2 = 0
    
End Sub
