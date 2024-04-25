# Pester

## Discovery, Run, and Cleanup

Pester runs test files in two phases:

- Discovery
    - Test setup happens in Discovery
- Run
    - Pester will run the tests

There is actually a nice way to see what happens in each phase, we'll see that in the "output" section.

### Syntax

There are notable commands to use for test setup:

- `BeforeDiscovery`: This will run before the discovery phase and allow you to do any kind of arbitrary test setup.  This allows you to define what needs to run during discovery.
  - In versions of Pester before v5 this code was often stuffed outside of a block or within `Describe` blocks.
- `BeforeAll`: This will run at the beginning of the current container, this could be the root, `Describe`, or `Context`.  What is run within it will apply to all child blocks.

Each vs All

- `BeforeAll` and `AfterAll` will run once for the block they are in, the result of the 1 run will apply to all child blocks.
- `BeforeEach` and `AfterEach` will run before each and every test in the current and child blocks.

I like to think of this as:

> Do I want to run something before ALL the tests, or before EACH of the tests?