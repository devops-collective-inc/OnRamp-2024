BeforeAll {
    function Send-DataToApi {
        param(
            [string]$Uri,
            [PSCustomObject]$Body
        )

        $response = Invoke-RestMethod -Uri $Uri -Method Post -Body ($Body | ConvertTo-Json) -ContentType "application/json"
        return $response
    }
}

Describe "Send-DataToApi" {

    BeforeEach {
        <#
            You may think we want to mock the "Send-DataToApi"
            What we actually want to mock is the part of that function that would do something we don't want to run.
        #>
        Mock Invoke-RestMethod {
            return @{
                StatusCode = 200
                Content = "Success"
            }
        }
    }

    It "Posts data and receives a success response" {
        $uri = "https://example.com/api/data"
        $body = [PSCustomObject]@{ Name = "Test"; Value = "123" }

        $result = Send-DataToApi -Uri $uri -Body $body

        $result.StatusCode | Should -Be 200
        $result.Content | Should -Be "Success"

        # Assert if a mock has been called and if specified how many times.
        Assert-MockCalled Invoke-RestMethod -Exactly 1 -ParameterFilter {
            $Uri -eq "https://example.com/api/data" -and
            $Method -eq "Post" -and
            ($Body | ConvertFrom-Json).Name -eq "Test" -and
            ($Body | ConvertFrom-Json).Value -eq "123"
        }
    }
}