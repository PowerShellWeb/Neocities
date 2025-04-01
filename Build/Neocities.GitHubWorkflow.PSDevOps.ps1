#requires -Module PSDevOps
Import-BuildStep -SourcePath (
    Join-Path $PSScriptRoot 'GitHub'
) -BuildSystem GitHubWorkflow

Push-Location ($PSScriptRoot | Split-Path)

New-GitHubWorkflow -Name "Build Module" -On Push, 
    PullRequest, Demand -Job TestPowerShellOnLinux, 
    TagReleaseAndPublish, BuildNeocities -Environment ([Ordered]@{
        REGISTRY = 'ghcr.io'
        IMAGE_NAME = '${{ github.repository }}'
    }) -OutputPath .\.github\workflows\Build.yml

Pop-Location