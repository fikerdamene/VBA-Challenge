
Sub Stock_Market_Analysis()


'--------------------------------------------------

'Define a variable for all the headers 

            Dim Ticker As String
            
            Dim year_open As Double
            
            Dim year_close As Double
            
            Dim Yearly_Change As Double
            
            Dim Total_Stock_Volume As Double
            
            Dim Percent_Change As Double
            
            Dim start_data As Integer

'Define a variable that excutes code in all worksheets at the same time

            Dim ws As Worksheet

'-------------------------------------------------------------------------------

            For Each ws In Worksheets

'Assign a column header for every task to be done

            ws.Range("I1").Value = "Ticker"
            ws.Range("J1").Value = "Yearly Change"
            ws.Range("K1").Value = "Percent Change"
            ws.Range("L1").Value = "Total Stock Volume"

'Assign intiger for the loop to start
    
            start_data = 2
            previous_i = 1
            Total_Stock_Volume = 0
            
'Go to the last row of column A

            EndRow = ws.Cells(Rows.Count, "A").End(xlUp).Row
            
'For each ticker, summarize and loop the yearly change, percent change and total stock volume

            For i = 2 To EndRow

'If ticker symbol changes or is not equal to the previous, excute to record

            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then

'Get the Ticker symbol

            Ticker = ws.Cells(i, 1).Value

'Intiate the variable to go to the next Ticker Alphabet

            previous_i = previous_i + 1

'Get the value of first day open from column 3 or "C" column and last day close of the year from column 6 or "F" column

            year_open = ws.Cells(previous_i, 3).Value
            year_close = ws.Cells(i, 6).Value

'For loop to sum the total stock volume using vol which is found in column 7 or "G" column

            For j = previous_i To i

            Total_Stock_Volume = Total_Stock_Volume + ws.Cells(j, 7).Value

            Next j

'When the loop get the value zero, open the data

            If year_open = 0 Then

            Percent_Change = year_close

            Else
                Yearly_Change = year_close - year_open

                Percent_Change = Yearly_Change / year_open

            End If
            
'--------------------------------------------------

'Get the values in the worksheet summary table

            ws.Cells(start_data, 9).Value = Ticker
            ws.Cells(start_data, 10).Value = Yearly_Change
            ws.Cells(start_data, 11).Value = Percent_Change

'Use percentage format

            ws.Cells(start_data, 11).NumberFormat = "0.00%"
            ws.Cells(start_data, 12).Value = Total_Stock_Volume

'In the data summary; when the first row task is completed, go to the next row

            start_data = start_data + 1

'Get the variable to zero

            Total_Stock_Volume = 0
            Yearly_Change = 0
            Percent_Change = 0

'Move i number to variable previous_i

            previous_i = i

            End If
            
'Finish the loop

            Next i

'The second summary table

'--------------------------------------------------

'Go to the last row of column k

            kEndRow = ws.Cells(Rows.Count, "K").End(xlUp).Row

'Define a variable to initiate the second summary table value

            Increase = 0
            Decrease = 0
            Greatest = 0

'Find max/min for percentage change and the max volume Loop
        
            For k = 3 To kEndRow

'Define previous increment to check

            last_k = k - 1

'Define current row for percentage
            
            current_k = ws.Cells(k, 11).Value

'Define Previous row for percentage
            
            prevous_k = ws.Cells(last_k, 11).Value

'Greatest total volume row
            
            volume = ws.Cells(k, 12).Value

'Prevous greatest volume row
            
            prevous_vol = ws.Cells(last_k, 12).Value

   '--------------------------------------------------

'Find the increase
            
            If Increase > current_k And Increase > prevous_k Then

            Increase = Increase

'Define name for increase percentage

            Increase_name = ws.Cells(k, 9).Value

            ElseIf current_k > Increase And current_k > prevous_k Then

            Increase = current_k

'Define name for increase percentage

            Increase_name = ws.Cells(k, 9).Value

            ElseIf prevous_k > Increase And prevous_k > current_k Then

            Increase = prevous_k

'Define name for increase percentage

                Increase_name = ws.Cells(last_k, 9).Value

            End If

'--------------------------------------------------
            
'Find the decrease

            If Decrease < current_k And Decrease < prevous_k Then

'Define decrease as decrease

            Decrease = Decrease

'Define name for increase percentage

            ElseIf current_k < Increase And current_k < prevous_k Then

            Decrease = current_k


            decrease_name = ws.Cells(k, 9).Value

            ElseIf prevous_k < Increase And prevous_k < current_k Then

            Decrease = prevous_k

            decrease_name = ws.Cells(last_k, 9).Value

            End If

'--------------------------------------------------
           
'Find the greatest volume

            If Greatest > volume And Greatest > prevous_vol Then

            Greatest = Greatest

'Define name for greatest volume

            greatest_name = ws.Cells(k, 9).Value

            ElseIf volume > Greatest And volume > prevous_vol Then

            Greatest = volume

'Define name for greatest volume

            greatest_name = ws.Cells(k, 9).Value

            ElseIf prevous_vol > Greatest And prevous_vol > volume Then

            Greatest = prevous_vol

'Define name for greatest volume

            greatest_name = ws.Cells(last_k, 9).Value

            End If

        Next k
        
'--------------------------------------------------
    
'Assign names for greatest increase,greatest decrease, and  greatest volume

            ws.Range("N1").Value = "Column Name"
            ws.Range("N2").Value = "Greatest % Increase"
            ws.Range("N3").Value = "Greatest % Decrease"
            ws.Range("N4").Value = "Greatest Total Volume"
            ws.Range("O1").Value = "Ticker Name"
            ws.Range("P1").Value = "Value"

'Get for greatest increase, greatest increase, and  greatest volume Ticker name
    
            ws.Range("O2").Value = Increase_name
            ws.Range("O3").Value = decrease_name
            ws.Range("O4").Value = greatest_name
            ws.Range("P2").Value = Increase
            ws.Range("P3").Value = Decrease
            ws.Range("P4").Value = Greatest

'Greatest increase and decrease in percentage format

            ws.Range("P2").NumberFormat = "0.00%"
            ws.Range("P3").NumberFormat = "0.00%"


'--------------------------------------------------

' Conditional formatting

'The end row for column J

            jEndRow = ws.Cells(Rows.Count, "J").End(xlUp).Row


            For j = 2 To jEndRow

'If greater than or less than zero
            
            If ws.Cells(j, 10) > 0 Then

            ws.Cells(j, 10).Interior.ColorIndex = 4

            Else

                ws.Cells(j, 10).Interior.ColorIndex = 3
            
            End If

        Next j

'Excute to next worksheet

        Next ws
'--------------------------------------------------

End Sub
