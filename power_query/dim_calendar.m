let
    // Detecta dinámicamente el rango de años según las transacciones de fact_sales
    MinDate = List.Min(fact_sales[order_date]),
    MaxDate = List.Max(fact_sales[order_date]),
    StartDate = #date(Date.Year(MinDate), 1, 1),
    EndDate = #date(Date.Year(MaxDate), 12, 31),
    
    // Genera la lista continua de días
    DayCount = Duration.Days(EndDate - StartDate) + 1,
    DateList = List.Dates(StartDate, DayCount, #duration(1, 0, 0, 0)),
    
    // Convierte a tabla y agrega atributos temporales estándar
    TableFromList = Table.FromList(DateList, Splitter.SplitByNothing(), {"date"}, null, ExtraValues.Error),
    ChangedType = Table.TransformColumnTypes(TableFromList, {{"date", type date}}),
    AddYear = Table.AddColumn(ChangedType, "year", each Date.Year([date]), Int64.Type),
    AddQuarter = Table.AddColumn(AddYear, "quarter", each "Q" & Number.ToText(Date.QuarterOfYear([date])), type text),
    AddMonthNum = Table.AddColumn(AddQuarter, "month_number", each Date.Month([date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonthNum, "month_name", each Date.ToText([date], "MMMM", "en-US"), type text),
    AddYearMonth = Table.AddColumn(AddMonthName, "year_month", each Date.ToText([date], "yyyy-MM"), type text),
    AddDayOfWeek = Table.AddColumn(AddYearMonth, "day_of_week", each Date.ToText([date], "dddd", "en-US"), type text)
in
    AddDayOfWeek