import Html exposing (body, h1, p, text, input, span)
import Html.Attributes exposing (style, class, id, type_)
import Html.Events exposing (onInput)
import String exposing (toInt)
import Date exposing (..)


{-| This snippet uses the <ul> and <li> tags to create an unordered
list of French grocery items. Notice that all occurrences of 'ul'
and 'li' are followed by two lists. The first list is for any HTML
attributes, and the second list is all the HTML nodes inside the
tag.

Et maintenant le voyage au supermarché!
-}

main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }


-- Model

type alias Model =
  { firstDate : Date
  , secondDate : Date
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

view =
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
    millisecondsPerDay = 24 * 60 * 60 * 1000
    from = model.firstDate
    to = model.secondDate
    days = (to - from) / millisecondsPerDay
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


-- Thanks to "Flight of the Conchords" for creating "Foux Du Fafa"
