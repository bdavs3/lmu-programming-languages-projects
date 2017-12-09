import String exposing (..)

change : Int -> (Int, Int, Int, Int)
change amount =
    let addTuple : (Int, Int, Int, Int) -> (Int, Int, Int, Int) -> (Int, Int, Int, Int)
        addTuple (q1, d1, n1, p1) (q2, d2, n2, p2) =
            (q1 + q2, d1 + d2, n1 + n2, p1 + p2)

    in
        if amount >= 25 then
            addTuple (change (amount - 25)) (1, 0, 0, 0)

        else if amount >= 10 then
            addTuple (change (amount - 10)) (0, 1, 0, 0)

        else if amount >= 5 then
            addTuple (change (amount - 5)) (0, 0, 1, 0)

        else if amount >= 1 then
            addTuple (change (amount - 1)) (0, 0, 0, 1)
        else if amount == 0 then
            (0, 0, 0, 0)
        else
            Debug.crash "negative coin input"


stripQuotes : String -> String
stripQuotes string =
    if length string == 0 then
        ""

    else
        if left 1 string == "\"" then
            stripQuotes (dropLeft 1 string)
        else if left 1 string == "'" then
            stripQuotes (dropLeft 1 string)
        else
            (left 1 string) ++ stripQuotes (dropLeft 1 string)

powers : Int -> Int -> List Int
powers base limit =
    if limit < 0 then
        []
    else
        base^limit :: powers base (limit - 1)

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
