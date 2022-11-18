Attribute VB_Name = "MainStart"
Sub Main()
    Dim Result As Long
    m_nDevIndex = 0
    m_nCH1VoltDIV = 6
    m_nCH2VoltDIV = 6
    m_nTimeDIV = 11
    mili2Pixel = 2
    border = 5
    vmaxDataCH1 = 0
    vmaxDataCH2 = 0
    vminDataCH1 = 0
    vminDataCH2 = 0
    vppdataCH1 = 0
    vrmsDataCH1 = 0
    vppdataCH2 = 0
    vrmsDataCH2 = 0
    gain = 0
    damageLevel = 0
    minDamageLevel = 0.9054  'Vpp 9,1 V dalam keadaan sensor telentang
    maxDamageLevel = 0.96
    
    Result = dsoOpenDevice(m_nDevIndex)
    If Result = 1 Then
    
        Result = dsoGetCalLevel(m_nDevIndex, m_nCalData(0), 32)
        Result = dsoSetVoltDIV(m_nDevIndex, 0, m_nCH1VoltDIV)
        Result = dsoSetVoltDIV(m_nDevIndex, 1, m_nCH2VoltDIV)
        Result = dsoSetTimeDIV(m_nDevIndex, m_nTimeDIV)
    
    End If
    
    MainForm.Show
    
End Sub
