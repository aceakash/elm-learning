module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (checked, style, type_)
import Html.Events exposing (onCheck, onClick)


type alias Model =
    { counter : Int
    , allowNegatives : Bool
    }


initialModel : Model
initialModel =
    { counter = 0, allowNegatives = True }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }



-- Model is just an integer representing the count


type Msg
    = Increment
    | Decrement
    | Reset
    | ChangeAllowNegatives Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            -- { counter = model.counter + 1, allowNegatives = model.allowNegatives }
            { model | counter = model.counter + 1 }

        Decrement ->
            if not model.allowNegatives && model.counter == initialModel.counter then
                { model | counter = initialModel.counter }

            else
                { model | counter = model.counter - 1 }

        Reset ->
            { model | counter = initialModel.counter }

        ChangeAllowNegatives newValue ->
            if newValue then
                { model | allowNegatives = newValue }

            else
                { model | allowNegatives = newValue, counter = initialModel.counter }


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
        , input [ type_ "checkbox", checked model.allowNegatives, onCheck ChangeAllowNegatives ] []
        , button (onClick Reset :: resetButtonStyles) [ text "RESET" ]
        ]
