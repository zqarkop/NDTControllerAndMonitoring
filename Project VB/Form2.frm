VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Circle"
   ClientHeight    =   1920
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   3810
   LinkTopic       =   "Form2"
   ScaleHeight     =   1920
   ScaleWidth      =   3810
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox jariJariTextBox 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2040
      TabIndex        =   1
      Top             =   360
      Width           =   1455
   End
   Begin VB.CommandButton submitBtn 
      Caption         =   "Submit"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   15.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   360
      TabIndex        =   0
      Top             =   960
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Radiusi (mm) :"
      BeginProperty Font 
         Name            =   "Calibri"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   360
      Width           =   1575
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub submitBtn_Click()
Load MainForm
dataOutput = jariJariTextBox.Text + "," + jariJariTextBox.Text
MainForm.arduino.Output = dataOutput
End Sub
