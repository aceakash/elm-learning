module Main exposing (Msg(..), main, update, view)

import Browser
import Debug exposing (toString)
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (checked, style, type_, value)
import Html.Events exposing (onCheck, onClick, onInput)
import String exposing (toInt)


containerStyle : List (Html.Attribute msg)
containerStyle =
    [ style "display" "flex"
    , style "flex-direction" "column"
    , style "align-items" "center"
    , style "justify-content" "center"
    , style "height" "100vh"
    ]


counterRowStyle : List (Html.Attribute msg)
counterRowStyle =
    [ style "display" "flex"
    , style "align-items" "center"
    , style "gap" "16px"
    ]


buttonStyle : List (Html.Attribute msg)
buttonStyle =
    [ style "font-size" "2rem"
    , style "padding" "0.5rem 1rem"
    ]


countStyle : List (Html.Attribute msg)
countStyle =
    [ style "font-size" "2rem"
    , style "width" "2.5rem"
    , style "text-align" "center"
    ]


resetButtonStyle : List (Html.Attribute msg)
resetButtonStyle =
    [ style "margin-top" "24px"
    , style "padding" "0.5rem 1.5rem"
    , style "font-size" "1rem"
    ]


checkboxContainerStyle : List (Html.Attribute msg)
checkboxContainerStyle =
    [ style "display" "flex"
    , style "align-items" "center"
    , style "gap" "8px"
    , style "margin-top" "16px"
    ]


type alias Model =
    { counterValue : Int
    , allowNegatives : Bool
    , delta : Int
    }


initialModel : Model
initialModel =
    { counterValue = 0, allowNegatives = True, delta = 1 }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }


type Msg
    = Increment
    | Decrement
    | Reset
    | ToggleAllowNegatives Bool
    | ChangeDelta (Maybe Int)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counterValue = model.counterValue + model.delta }

        Decrement ->
            if not model.allowNegatives && model.counterValue == initialModel.counterValue then
                { model | counterValue = initialModel.counterValue }

            else
                { model | counterValue = model.counterValue - model.delta }

        Reset ->
            initialModel

        ToggleAllowNegatives newValue ->
            { model | allowNegatives = newValue }

        ChangeDelta delta ->
            case delta of
                Nothing ->
                    model

                Just val ->
                    { model | delta = val }


view : Model -> Html Msg
view model =
    div containerStyle
        [ div counterRowStyle
            [ button (onClick Decrement :: buttonStyle) [ text "-" ]
            , div countStyle [ text (String.fromInt model.counterValue) ]
            , button (onClick Increment :: buttonStyle) [ text "+" ]
            ]
        , div []
            [ input
                [ type_ "text"
                , value (toString model.delta)
                , onInput onInputChanged
                ]
                []
            ]
        , div checkboxContainerStyle
            [ input
                [ type_ "checkbox"
                , checked model.allowNegatives
                , onCheck ToggleAllowNegatives
                ]
                []
            , text "Allow negatives?"
            ]
        , button (onClick Reset :: resetButtonStyle) [ text "RESET" ]
        ]


onInputChanged : String -> Msg
onInputChanged newValue =
    ChangeDelta (toInt newValue)
