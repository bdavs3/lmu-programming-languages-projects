change : Int -> ( Int, Int, Int, Int )
change amt =


stripQuotes : String -> String
stripQuotes =

powers : Int -> Int -> List Int
powers base lim =

sumOfCubesOfOdds : List Int -> Int
sumOfCubesOfOdds numbers =


import Date exposing ( fromString, fromTime, toTime)
import Tuple exposing ( first, second )
daysBetween dateString1 dateString2 : String -> String -> Int
daysBetween =
  dates = (\
          dateString1\
          |> fromString\
          |> Result.withDefault (fromTime 0)\
          |> toTime\
          , dateString2\
          |> fromString\
          |> Result.withDefault (fromTime 0)\
          |> toTime\
          )
  timeDiff = ( first dates ) - ( second dates ) |> abs
  daysDiff = timeDiff / ( 6000 * 60 * 60 * 24 )
