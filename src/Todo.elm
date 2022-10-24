module Todo exposing (main)
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN
main =
    Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { task_name : String
  , label : String
  , task : String
  , category : String
  , priority : String
  , status : String
  }


init : Model
init =
  Model "" "" "" "" "" ""



-- UPDATE


type Msg
  = Task_Name String
  | Label String
  | Task String
  | Priority String
  | Status String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Task_Name task_name ->
      { model | task_name = task_name }

    Label label ->
      { model | label = label }

    Task task ->
      { model | task = task }

    Priority priority ->
      { model | priority = priority }

    Status status ->
      { model | status = status }



-- VIEW


view : Model -> Html Msg
view model =
  div [ class "main" ] [
    div [ class "signup" ]
    [ Html.form [ action "http://localhost:4000/v1/todo", id "userform", method "POST" ]
        [ label [ attribute "aria-hidden" "true", for "chk" ]
            [ text "To-Do List Form" ]
        , div []
        [ viewInput "text" "What is the name of your task?" model.task_name Task_Name
        , viewInput "text" "What type of task is it?" model.label Label
        , viewInput "text" "What is your task?" model.task Task
        , viewInput "text" "How urgent is your task?" model.priority Priority
        , viewInput "text" "Is it completed or incomplete?" model.status Status
        , viewValidation model
        ]
        , button []
            [ text "SUBMIT" ]
        ]
    ]
  ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.task_name == "" || model.label == "" || model.task == "" || model.priority == "" || model.status == "" then
    div [ style "color" "red", style "text-align" "center" ] [ text "Please Fill All Fields!" ]
  else
    div [ style "color" "green",  style "text-align" "center" ] [ text "Good!" ] 