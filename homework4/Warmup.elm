module Warmup exposing (..)

import Date.Extra.Create exposing ( dateFromFields, getTimezoneOffset )
import Date.Extra.Duration exposing ( diffDays )
import Date.Extra.Period as Period exposing ( add )
import Date exposing ( fromString, fromTime )
import String exposing (..)
import List exposing (..)
import Result exposing (..)

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
            Debug.crash "amount cannot be negative"


stripQuotes : String -> String
stripQuotes string =
    if String.length string == 0 then
        ""

    else
        if String.left 1 string == "\"" then
            stripQuotes (String.dropLeft 1 string)
        else if String.left 1 string == "'" then
            stripQuotes (String.dropLeft 1 string)
        else
            (String.left 1 string) ++ stripQuotes (String.dropLeft 1 string)

powers : Int -> Int -> List Int
powers base limit =
    if base < 0 then
        Debug.crash "negative base"
    else
        if limit < 0 then
            []
        else
            base^limit :: powers base (limit - 1)

sumOfCubesOfOdds : List Int -> Int
sumOfCubesOfOdds numbers =
    let cube : Int -> Int
        cube num =
            num^3
        isOdd : Int -> Bool
        isOdd num =
            num % 2 /= 0

    in
        List.foldr (+) 0 (List.map cube (List.filter isOdd (numbers)))


daysBetween : String -> String -> Int
daysBetween dateString1 dateString2 =
  let
    date1WithOffset = dateString1 |> fromString |> Result.withDefault (fromTime 0)
    date1 = add Period.Minute (getTimezoneOffset date1WithOffset) date1WithOffset
    date2WithOffset = dateString2 |> fromString |> Result.withDefault (fromTime 0)
    date2 = add Period.Minute (getTimezoneOffset date2WithOffset) date2WithOffset
  in
    diffDays date1 date2 |> abs
