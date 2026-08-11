# Flutter Testing

Use this skill when adding or updating tests for the Flutter app.

## Goals

- validate behavior with real widget tests
- prefer deterministic, lightweight tests
- test user-visible outcomes rather than implementation details
- keep tests maintainable and clear

## Workflow

1. Identify the behavior or screen to verify.
2. Add or update a focused widget test in `test/`.
3. Keep assertions on visible behavior and app state.
4. Run the test suite and fix issues as needed.

## Validation

```bash
fvm flutter test
```
