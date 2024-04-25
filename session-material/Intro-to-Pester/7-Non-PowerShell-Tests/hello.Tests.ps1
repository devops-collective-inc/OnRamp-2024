Describe 'The hello Application' {

    BeforeAll {
        $helloOutput = ./hello/hello
    }

    Context 'Test hello Output' {
        It 'Should return "Hello!' {
			$helloOutput | Should -Be 'Hello!'
		}
    }
}