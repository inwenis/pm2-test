open System
open System.IO
#r "nuget: FSharp.Data"
open FSharp.Data
#r "nuget: Plotly.NET"
open Plotly.NET

type CSVData = CsvProvider<"./out/20250216220844.csv", HasHeaders=false>

let lines =
    use x = CSVData.Load "./out/20250216220844.csv"
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
