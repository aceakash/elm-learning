module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, input, text)
import Html.Attributes exposing (checked, style, type_)
import Html.Events exposing (onCheck, onClick)


type alias Model =
    { counter : Int
    , allowNegatives : Bool
    , counterInput : String
    }


initialModel : Model
initialModel =
    { counter = 0, allowNegatives = True, counterInput = "0" }


main : Program () Model Msg
main =
    Browser.sandbox { init = initialModel, update = update, view = view }



-- Model is just an integer representing the count


type Msg
    = Increment
    | Decrement
    | Reset
    | ChangeAllowNegatives Bool
    | SetCounterInput String
    | CommitCounterInput


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            let
                newVal =
                    model.counter + 1
            in
            { model | counter = newVal }

        Decrement ->
            let
                allowPositivesOnly =
                    not model.allowNegatives

                alreadyAtZero =
                    model.counter == 0

                keepAtZero =
                    allowPositivesOnly && alreadyAtZero
            in
            if keepAtZero then
                { model | counter = 0 }

            else
                let
                    newVal =
                        model.counter - 1
                in
                { model | counter = newVal }

        Reset ->
            { model | counter = initialModel.counter, counterInput = String.fromInt initialModel.counter }

        ChangeAllowNegatives newValue ->
            let
                newCounter =
                    if newValue == False && (model.counter < 0) then
                        0

                    else
                        model.counter
            in
            { model | allowNegatives = newValue, counter = newCounter, counterInput = String.fromInt newCounter }

        SetCounterInput str ->
            { model | counterInput = str }

        CommitCounterInput ->
            case String.toInt model.counterInput of
                Just n ->
                    if not model.allowNegatives && n < 0 then
                        { model | counter = 0, counterInput = "0" }

                    else
                        { model | counter = n, counterInput = String.fromInt n }

                Nothing ->
                    model


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
        , div [ style "margin-top" "24px", style "display" "flex", style "align-items" "center", style "gap" "8px" ]
            [ input [ type_ "number", Html.Attributes.value model.counterInput, Html.Events.onInput SetCounterInput, style "width" "80px", style "font-size" "1rem" ] []
            , button [ onClick CommitCounterInput, style "font-size" "1rem" ] [ text "Set Counter" ]
            ]
        , Html.label [ style "margin-top" "24px", style "font-size" "1.1rem", style "display" "flex", style "align-items" "center", style "gap" "8px" ]
            [ input [ type_ "checkbox", checked model.allowNegatives, onCheck ChangeAllowNegatives ] []
            , text " Allow negatives?"
            ]
        , button (onClick Reset :: resetButtonStyles) [ text "RESET" ]
        ]
