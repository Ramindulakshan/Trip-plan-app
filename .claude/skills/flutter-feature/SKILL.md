# Flutter Feature

Use this skill when adding a new user-facing feature to the Flutter app.

## Goals

- keep changes scoped to one feature at a time
- preserve existing app structure and conventions
- prefer small, readable widget-based updates
- minimize unnecessary dependencies

## Workflow

1. Read the relevant screen or screen-related code in `lib/`.
2. Add the minimal UI and logic needed for the feature.
3. Keep code organized and easy to follow.
4. Update or add tests when behavior changes.
5. Run validation checks before finishing.

## Validation

```bash
fvm flutter analyze
fvm flutter test
```
