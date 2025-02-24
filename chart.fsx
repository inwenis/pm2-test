open System
open System.IO
#r "nuget: FSharp.Data"
open FSharp.Data
#r "nuget: Plotly.NET"
open Plotly.NET

[<Literal>]
let sample = """2025-02-24T15:15:17.7994104+01:00,8252df6496b8,test4-pm2:6901e55,44.54,MiB,512,MiB
2025-02-24T15:15:17.7994104+01:00,0efff9bafd69,test3-pm2:6901e55,45.15,MiB,512,MiB
2025-02-24T15:15:17.7994104+01:00,b2c7e1b8306c,test3-node:6901e55,15.05,MiB,512,MiB
2025-02-24T15:15:17.7994104+01:00,27d39be675bd,test2-pm2:6901e55,51.18,MiB,512,MiB
"""

type CSVData = CsvProvider<sample, HasHeaders=false>

let lines =
    let file =
        Directory.GetFiles "./out"
        |> Array.sortDescending
        |> Array.head
    use x = CSVData.Load file
    x.Rows |> Seq.toList

let toChartable (lines: CSVData.Row list) =
    lines
    |> List.map (fun x -> x.Column1.DateTime, x.Column4)
    |> List.sortBy fst

lines
|> List.groupBy (fun x -> x.Column3)
|> List.map (fun (k, v) -> k, v |> toChartable |> List.unzip)
|> List.map (fun (k, (x,y)) -> Chart.Line(x=x, y=y, Name=k))
|> Chart.combine
|> Chart.withLayout(Layout.init(Width=1200))
|> Chart.show
