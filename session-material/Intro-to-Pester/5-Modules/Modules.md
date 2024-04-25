# Pester

## Testing Modules

## Public Functions

This is fairly straight forward as you just need to ensure the module is imported as part of the test setup.

## Private Functions

There are some details around testing modules that you'll need to pay attention to in regards to a private (non-exported) function.

The [docs](https://pester.dev/docs/usage/modules#testing-private-functions) outline it in a very informative way.

Essentially:

- You can use `InModuleScope` however it's recommend to use the `-ModuleName` on your `Mock`!
- If you use `InModuleScope` you'll have access to all of the private functions.
