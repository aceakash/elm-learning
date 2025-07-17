# Copilot Instructions for `elm-learning`

These instructions can change anytime. Always read this file before any command.

## Project Overview

- This is a simple Elm counter app, designed for learning and experimentation with Elm's architecture and UI patterns.
- The main logic and UI are in `src/Main.elm`. There are no submodules or complex service boundaries.
- The app demonstrates Elm's Model-Update-View pattern, with features like increment/decrement, reset, toggling negatives, and a horizontally scrolling counter history.

## Key Files

- `src/Main.elm`: All application logic, state, and view code. This is the only Elm source file.
- `README.md`: Basic setup and run instructions.

## Developer Workflow

- **Run the app:**
  1. Install Elm (see the [Elm guide](https://guide.elm-lang.org/install/elm)).
  2. Run `elm reactor` in the project root.
  3. Open the provided local URL and navigate to `src/Main.elm` to view the app.
- **No build/test scripts** are present; all development is interactive via `elm reactor`.

## Project Patterns & Conventions

- **Model-Update-View:**
  - `Model` holds all state, including `counter`, `allowNegatives`, and `history`.
  - `update` handles all state transitions. Each counter change pushes the previous value to `history`.
  - `view` renders the UI, including a horizontally scrolling history bar.
- **UI Styling:**
  - Inline styles are used for all layout and appearance.
  - The history bar uses flexbox and horizontal scrolling to avoid layout shifts.
- **Negatives Toggle:**
  - The checkbox toggles whether the counter can go below zero. If toggled off and the counter is negative, it resets to zero.
- **No external Elm packages** are used; only core Elm modules are imported.

## Examples

- To add a new feature, extend the `Model`, add a new `Msg` variant, update the `update` function, and add UI in `view`.
- To persist history or add undo/redo, add new fields to `Model` and update the `update` logic accordingly.

## Integration Points

- No backend, API, or external integration is present.
- No tests or CI/CD scripts are present.

## Agent instructions

1. Work in small steps
2. Confirm each step before executing it
   2.5. When I ask you to implement something, always show me a plan and wait for my confirmation before you start making changes
3. Remind me to commit to source control
4. Optimise for readability
5. Remind me to update docs when relevant: readme and this copilot instructions doc

---

For more details, see `src/Main.elm` and `README.md`. For questions, follow Elm's official documentation and patterns.
