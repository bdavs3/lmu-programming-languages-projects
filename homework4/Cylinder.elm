module Cylinder exposing (..)

type alias Cylinder =
    {
         radius : Float
    ,    height : Float
    }

new =
    Cylinder 1.0 1.0

volume : Cylinder -> Float
volume c =
    pi * c.radius^2 * c.height

surfaceArea : Cylinder -> Float
surfaceArea c =
    2 * pi * c.radius * c.height + 2 * pi * c.radius^2

widen : Float -> Cylinder -> Cylinder
widen factor c =
    { c | radius = c.radius * factor }

stretch : Float -> Cylinder -> Cylinder
stretch factor c =
    { c | height = c.height * factor }
