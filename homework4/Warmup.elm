change : Int -> ( Int, Int, Int, Int )
change amt =


stripQuotes : String -> String
stripQuotes =

powers : Int -> Int -> List Int
powers base lim =

sumOfCubesOfOdds : List Int -> Int
sumOfCubesOfOdds numbers =


import Date.Extra.Create exposing ( dateFromFields, getTimezoneOffset )
import Date.Extra.Duration exposing ( diffDays )
import Date.Extra.Period as Period exposing ( add )
import Date exposing ( fromString, fromTime )
daysBetween dateString1 dateString2 : String -> String -> Int
daysBetween =

  dateString1 = "2017-02-14"
  dateString2 = "2016-12-25"

  date1WithOffset = dateString1 |> fromString |> Result.withDefault (fromTime 0)
  date1 = add Period.Minute (getTimezoneOffset date1WithOffset) date1WithOffset

  date2WithOffset = dateString2 |> fromString |> Result.withDefault (fromTime 0)
  date2 = add Period.Minute (getTimezoneOffset date2WithOffset) date2WithOffset

  diffDays date1 date2 |> abs
