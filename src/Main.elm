module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


type alias Model =
    { counter : Int
    }


initialModel : Model
initialModel =
    { counter = 0 }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }



-- Model is just an integer representing the count


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { counter = model.counter + 1 }

        Decrement ->
            if model == initialModel then
                initialModel

            else
                { counter = model.counter - 1 }

        Reset ->
            initialModel


containerStyles : List (Html.Attribute msg)
containerStyles =
    [ style "display" "flex"
    , style "flex-direction" "column"
    , style "align-items" "center"
    , style "justify-content" "center"
    , style "height" "100vh"
    , style "font-family" "sans-serif"
    ]


rowStyles : List (Html.Attribute msg)
rowStyles =
    [ style "display" "flex"
    , style "align-items" "center"
    , style "gap" "16px"
    ]


buttonStyles : List (Html.Attribute msg)
buttonStyles =
    [ style "font-size" "2rem"
    , style "width" "48px"
    , style "height" "48px"
    ]


counterStyles : List (Html.Attribute msg)
counterStyles =
    [ style "font-size" "2rem"
    , style "width" "48px"
    , style "text-align" "center"
    ]


resetButtonStyles : List (Html.Attribute msg)
resetButtonStyles =
    [ style "margin-top" "24px"
    , style "padding" "8px 24px"
    , style "font-size" "1rem"
    ]


view : Model -> Html Msg
view model =
    div containerStyles
        [ div rowStyles
            [ button (onClick Decrement :: buttonStyles) [ text "-" ]
            , div counterStyles [ text (String.fromInt model.counter) ]
            , button (onClick Increment :: buttonStyles) [ text "+" ]
            ]
        , button (onClick Reset :: resetButtonStyles) [ text "RESET" ]
        ]
