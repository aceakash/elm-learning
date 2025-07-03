module Main exposing (Msg(..), main, update, view)

import Browser
import Html exposing (Html, button, div, text)
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
                { counter = model.counter + 1 }

        Reset ->
            initialModel


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div []
                [ text (String.fromInt model.counter) ]
            , button
                [ onClick Increment ]
                [ text "+" ]
            ]
        , button
            [ onClick Reset ]
            [ text "RESET" ]
        ]
