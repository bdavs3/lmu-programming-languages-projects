import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (toInt)
import Date exposing (..)
import Warmup exposing (daysBetween)

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- Model

type alias Model =
  { firstDate : String
  , secondDate : String
  }

model : Model
model =
  Model "" ""


-- Update

type Msg
  = FirstDate Date
  | SecondDate Date

update : Msg -> Model -> Model
update msg model =
  case msg of
    FirstDate firstDate ->
      { model | firstDate = firstDate }

    SecondDate secondDate ->
      { model | secondDate = secondDate }


-- View

view : Model -> Html Msg
view model =
  body [bodyStyle] [
    h1 [headerStyle] [
    text "Date Calculator"]
    , p []
      [ text "From"
      , input [inputStyle, id "from", type_ "date", onInput FirstDate] []
      ]
    , p []
      [ text "to"
      , input [inputStyle, id "to", type_ "date", onInput SecondDate] []
      ]
    , viewValidation model
    ]


viewValidation : Model -> Html.Html msg
viewValidation model =
  let
    days = daysBetween model.firstDate model.secondDate
  in
    p []
      [ text "is "
      , span [outputStyle, id "output"] [days |> toString |> text, text "days"]
      ]


-- Styles

bodyStyle =
  style
    [ ("text-align", "center")
    , ("font", "16px Arial")
    , ("background-color", "linen")
    , ("margin", "0")
    ]

headerStyle =
  style
    [ ("font", "bold 40px Avenir")
    , ("margin-top", "0")
    , ("padding", "5px")
    , ("background-color", "cyan")
    ]

inputStyle =
  style
    [ ("border", "2px solid grey")
    , ("margin-left", "8px")
    ]

outputStyle =
  style
    [ ("font-size", "28px")
    ]
