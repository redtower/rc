VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "FileView"
   ClientHeight    =   5550
   ClientLeft      =   2325
   ClientTop       =   1335
   ClientWidth     =   7770
   LinkTopic       =   "Form1"
   ScaleHeight     =   5550
   ScaleWidth      =   7770
   Begin VB.DriveListBox Drive1 
      Height          =   300
      Left            =   240
      TabIndex        =   4
      Top             =   120
      Width           =   2775
   End
   Begin VB.FileListBox File1 
      Height          =   2610
      Left            =   240
      TabIndex        =   3
      Top             =   2760
      Width           =   2775
   End
   Begin VB.DirListBox Dir1 
      Height          =   2190
      Left            =   240
      TabIndex        =   2
      Top             =   480
      Width           =   2775
   End
   Begin VB.TextBox Text1 
      Height          =   4695
      Left            =   3120
      MultiLine       =   -1  'True
      ScrollBars      =   2  '����
      TabIndex        =   1
      Text            =   "Form1.frx":0000
      Top             =   720
      Width           =   4455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "view(&V)"
      Height          =   495
      Left            =   3120
      TabIndex        =   0
      Top             =   120
      Width           =   1935
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===========================================================
'   Date   :    2008/08/10
'   Purpose:    xdoc2txt.dll �̃T���v���v���O����
'   Author  :   hishida
'===========================================================

' �t�@�C���̓��e�̕\��
Private Sub Command1_Click()

    Dim idx As Integer
    
    Dim path As String, text As String
        
    idx = Form1.File1.ListIndex
    If idx >= 0 Then
        path = Form1.File1.path + "\" + Form1.File1.List(idx)
    
        '�N���X�I�u�W�F�N�g���擾����
        Set obj = CreateObject("XDOC2TXT.xdoc2txtCtrl.1")
        
        ' �����̃e�L�X�g�𒊏o����
        text = obj.Convert(path)
        
        ' ��ʕ\��
        Form1.Text1.text = text
        
        'MsgBox text
        
        ' �I�u�W�F�N�g�̉��
        Set obj = Nothing
    
    End If
    
End Sub
' �h���C�u�̕ύX
Private Sub Drive1_Change()

    Dim idx As Integer
    Dim drv As String
            
    idx = Form1.Drive1.ListIndex
    If idx >= 0 Then
    
        drv = Form1.Drive1.List(idx)
        Form1.Dir1.path = drv
        path = Form1.Dir1.path
        Form1.File1.path = path
    
    End If
    
End Sub
' �f�B���N�g���̕ύX
Private Sub Dir1_Change()

    Dim path As String
    
    path = Form1.Dir1.path
    Form1.File1.path = path

End Sub

Private Sub File1_Click()

'    Call Command1_Click
    
End Sub
