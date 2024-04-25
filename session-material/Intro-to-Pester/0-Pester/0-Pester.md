# Pester 🧪

## Overview

What is Pester?

> Pester is a testing and mocking framework for PowerShell.

- The current major version of Pester is 5.x, the versions actually matter!
    - The current version at the time of this is 5.5.0
- Pester is a DSL _(Domain Specific Language)_ implemented in PowerShell
    - Because of it being a DSL, it's declarations like `Describe`, `Context`, `It`, and `Should` are actually PowerShell functions!!!
    - This means you have to keep the opening `{` on the same line as the word, sorry Allman style bracing fans!

---

### Install

How do You Install Pester?
Well, just like any other module!

```powershell
Install-Module -Name Pester
```

### Files and Syntax

Pester considers any _**.Tests.ps1**_ to be Pester test files.

Best practices generally ask your tests either live next to the files they are for, or in a specific test directory.

Example :

```text
Get-Something.ps1
Get-Something.Tests.ps1
```

or (we will see a module like this later)

```text
src/functions/Get-Something.ps1
test/functions/Get-Something.Tests.ps1
```

Pester syntax:

- Tests are your `It` blocks
- It blocks define an assertion with `Should`
- `It` blocks are generally contained within a `Describe` to group them
    - `It` cannot be at the root, they must be within a `Describe` _(or a `Context`)_
- If needed `Context` can be used within a `Describe` though they are essentially interchangeable.

Typically tests look structurally like this:

```powershell
BeforeAll {
    # Test setup
}

Describe 'Something' {
    Context 'Detail of Something' {
        It 'Should Be X' {
            $something | Should -Be X
        }
    }
}
```

Let's take a look at some real tests that test a PowerShell function.

---

### List of `Should` Assertions

[Pester Docs Should](https://pester.dev/docs/commands/Should)

### Docs

I live and die by the docs, don't be afraid to use them!

[Pester Docs](https://pester.dev/docs/commands/Should)