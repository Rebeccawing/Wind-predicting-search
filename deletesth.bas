Attribute VB_Name = "模块1"
Sub 删除()
    Application.ScreenUpdating = False
    
    Dim FileName As String, wb As Workbook, Erow As Long, fn As String
    FileName = Dir(ThisWorkbook.Path & "\*.xls")
    Do While FileName <> ""
        If FileName <> ThisWorkbook.Name Then
            fn = ThisWorkbook.Path & "\" & FileName
            Set wb = Workbooks.Open(fn)
            Set sht = wb.Worksheets(1)
            sht.Rows(1).Delete
            wb.Save
             wb.Close False
        End If
        FileName = Dir
    Loop
    Application.ScreenUpdating = True
End Sub

Attribute VB_Name = "模块2"
Sub 删除()
    Columns(5).Delete
    Columns(5).Delete
    Columns(6).Delete
    Columns(6).Delete
    Columns(7).Delete
    Columns(7).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(8).Delete
    Columns(9).Delete
    Columns(9).Delete
    Columns(10).Delete
    Columns(10).Delete
    Columns(11).Delete
    Columns(11).Delete
    Columns(12).Delete
    Columns(12).Delete
    Columns(12).Delete
    Columns(12).Delete
    Columns(12).Delete
    Columns(13).Delete
    Columns(13).Delete
    Columns(14).Delete
    Columns(14).Delete
    Columns(15).Delete
    Columns(15).Delete
    Columns(16).Delete
    Columns(16).Delete
    Columns(17).Delete
    Columns(17).Delete
    Columns(18).Delete
    Columns(18).Delete
    Columns(18).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    Columns(19).Delete
    
End Sub
