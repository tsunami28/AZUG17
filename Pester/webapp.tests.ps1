## Get template location
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Output $here

Describe "Template: webapp-custom-deployment-slots" -Tags Unit, azuredeploy {    
    Context "azuredeploy" {        
        It "Has a valid JSON template syntax" {        
            "$here\a\1\s\Infra\azuredeploy.json" | Should -Exist
        }        
        It "Converts from azuredeploy.JSON and has the expected template schema" {
            $expectedProperties = '$schema',
            'contentVersion',
            'parameters',     
            'resources', 
            'variables'
            $templateProperties = (get-content "$here\a\1\s\Infra\azuredeploy.json" | ConvertFrom-Json -ErrorAction SilentlyContinue) | Get-Member -MemberType NoteProperty | % Name
            $templateProperties | Should -Be $expectedProperties
        }
        It "parameters file Exist " {        
            "$here\drscoding\Presentations\AZUG17\AZUG17\Infra\$parmFile" | Should -Exist
        }  
        It "Converts from parameter files and has the expected template schema" {
            $expectedProperties = '$schema',
            'contentVersion',
            'parameters'          
            $templateProperties = (get-content "$here\a\1\s\Infra\azuredeploy.parameters.json" | ConvertFrom-Json -ErrorAction SilentlyContinue) | Get-Member -MemberType NoteProperty | % Name
            $templateProperties | Should -Be $expectedProperties
        } 
    }
}
Context "azuredeploy Template Resources" {        
    It "Creates the expected Azure resources" {
        $expectedResources = 'Microsoft.Web/serverfarms', 'Microsoft.Web/sites', 'Microsoft.Web/sites/slots'  
        $templateResources = (get-content "$here\a\1\s\Infra\azuredeploy.json" | ConvertFrom-Json -ErrorAction SilentlyContinue).Resources.type
        $templateResources | Should -Be $expectedResources
    }
} 