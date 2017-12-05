module WarmupTest exposing (..)

import Expect exposing (Expectation, FloatingPointTolerance(Absolute), within, equal)
import Test exposing (..)
import Warmup exposing (..)
import Cylinder exposing (..)

suite : Test
suite =
    describe "This assignment's"
        [ describe "change function"
            [ test "works for 0" <| \_ -> change 0 |> equal (Ok (0, 0, 0, 0))
            , test "works for 229" <| \_ -> change 219 |> equal (Ok (8, 1, 1, 4))
            , test "works for 97" <| \_ -> change 97 |> equal (Ok (3, 2, 0, 2))
            , test "works for 100000000000" <| \_ -> change 1000000000 |> equal (Ok (40000000, 0, 0, 0))
            , test "detects negatives" <| \_ -> change -50 |> equal (Err "amount cannot be negative")
            ]
        , describe "stripQuotes function"
            [ test "works for empty" <| \_ -> stripQuotes "" |> equal  ""
            , test "works for no quotes" <| \_ -> stripQuotes "dog" |> equal "dog"
            , test "removes stuff" <| \_ -> stripQuotes "''\"\"a'''" |> equal "a"
            , test "does not remove backslashes" <| \_ -> stripQuotes "a\\b" |> equal "a\\b"
            ]
        , describe "powers function"
            [ test "works for negative limit" <| \_ -> powers 2 -5 |> equal (Ok [])
            , test "works for 2 up to 63" <| \_ -> powers 2 63 |> equal (Ok [1, 2, 4, 8, 16, 32])
            , test "works for 2 up to 64" <| \_ -> powers 2 64 |> equal (Ok [1, 2, 4, 8, 16, 32, 64])
            , test "works for 3 up to 81" <| \_ -> powers 3 81 |> equal (Ok [1, 3, 9, 27, 81])
            , test "rejects negative bases" <| \_ -> powers -2 63 |> equal (Err "negative base")
            ]
        , describe "sum of odd cubes function"
            [ test "works for empty" <| \_ -> sumOfCubesOfOdds [] |> equal 0
            , test "works for single even" <| \_ -> sumOfCubesOfOdds [8] |> equal 0
            , test "works for single odd" <| \_ -> sumOfCubesOfOdds [3] |> equal 27
            , test "works for a mixed list" <| \_ -> sumOfCubesOfOdds [-3, 2, -8, 5, -1] |> equal 97
            ]
        , describe "daysBetween function"
            [ test "one day" <| \_ -> daysBetween "2017-01-01" "2016-12-31" |> equal (Ok -1)
            , test "in leap year" <| \_ -> daysBetween "2016-03-01" "2016-02-27" |> equal (Ok -3)
            , test "in leap year again" <| \_ -> daysBetween "2016-02-27" "2016-03-01" |> equal (Ok 3)
            ]
        , describe "cylinder type"
            [ test "new cylinder" <| \_ ->
                Cylinder.new |> equal { radius = 1.0, height = 1.0 }
            , test "stretch" <| \_ ->
                stretch 5 Cylinder.new |> equal { radius = 1.0, height = 5.0 }
            , test "widen" <| \_ ->
                widen 8 Cylinder.new |> equal { radius = 8.0, height = 1.0 }
            , test "volume" <| \_ ->
                volume { radius = 2.0, height = 10.0 } |> within (Absolute 0.000001) (40*pi)
            , test "surfaceArea" <| \_ ->
                surfaceArea { radius = 2.0, height = 10.0 } |> within (Absolute 0.000001) (48*pi)
            ]
        ]
