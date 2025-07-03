module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (checked, style, type_)
import Html.Events exposing (onCheck, onClick)


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
    }


initialModel : Model
initialModel =
    { counterValue = 0, allowNegatives = True }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }



-- Model is just an integer representing the count


type Msg
    = Increment
    | Decrement
    | Reset
    | ToggleAllowNegatives Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | counterValue = model.counterValue + 1 }

        Decrement ->
            if not model.allowNegatives && model.counterValue == initialModel.counterValue then
                { model | counterValue = initialModel.counterValue }

            else
                { model | counterValue = model.counterValue - 1 }

        Reset ->
            initialModel

        ToggleAllowNegatives newValue ->
            { model | allowNegatives = newValue }


view : Model -> Html Msg
view model =
    div containerStyle
        [ div counterRowStyle
            [ button (onClick Decrement :: buttonStyle) [ text "-" ]
            , div countStyle [ text (String.fromInt model.counterValue) ]
            , button (onClick Increment :: buttonStyle) [ text "+" ]
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
