# Pester

## Mocks

There can be times when you want to test something but not actually run it.

For example, if you have a function that builds an Azure virtual machine, you don't actually want to build it to test your code.

This is where mocking comes into play!

- We'll look at an example where we need to test calling an API.
- We want to make a POST to the API but we don't want to actually hit our API!
- We just want to mock how it would behave.

## Unit vs Integration

These topics are specific to testing and not specifically Pester.

- This is generally considered a _Unit Test_.
- An _Integration Test_ is another type of test where you actually would interact with a live system.

Unit tests are "cheaper" than their integration counter parts!

If we didn't mock in this coming example, it would be considered an integration test because we'd be accessing live systems.
