<#
.Synopsis
   A Powershell wrapper for the Global Airports DB data.
.DESCRIPTION
   Based on GlobalAirports.Net by Shrayas Rajagopal (shrayasr), this toy cmdlet can return the Global Airports DB data by parameters
.EXAMPLE
   Get-AirportInfo # Returns all airports
.EXAMPLE
   Get-AirportInfo -ICAOCode VOMM
.EXAMPLE
    Get-AirportInfo -IATACode MAA
.EXAMPLE
    Get-AirportInfo -City LONDON
.EXAMPLE
    Get-AirportInfo -Country Turkey
#>
function Get-AirportInfo
{
    [CmdletBinding(DefaultParameterSetName = 'All')]
    [Alias()]
    [OutputType([PSObject])]
    Param
    (
        # Get by ICAO Code
        [Parameter(Mandatory = $false, ParameterSetName = 'ByICAOCode')]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(4,4)]
        $ICAOCode,

        # Get by IATA Code
        [Parameter(Mandatory = $false, ParameterSetName = 'ByIATACode')]
        [ValidateNotNullOrEmpty()]
        [ValidateLength(3,3)]
        [ValidatePattern("[a-z]*")]
        [string]
        $IATACode,

        # Get by City
        [Parameter(Mandatory = $false, ParameterSetName = 'ByCity')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("[a-z]*")]
        [string]
        $City,

        # Get by Country
        [Parameter(Mandatory = $false, ParameterSetName = 'ByCountry')]
        [ValidateNotNullOrEmpty()]
        [ValidatePattern("[a-z]*")]
        [string]
        $Country
    )

    Begin
    {
        if ($psISE) {
            $path = Split-Path -Path $psISE.CurrentFile.FullPath        
        }
        else {
            $path = $global:PSScriptRoot
        }
        
        $customDll = Join-Path -Path $path -ChildPath "\bin\GlobalAirports.Net.dll"
        Add-Type -Path $customDll
    }
    Process
    {
        $airports = New-Object GADB.Net.GlobalAirports

        if($null -ne $ICAOCode -and $ICAOCode -ne "") {
            $res =  $airports.GetByICAOCode($ICAOCode)
            if($res -ne $null) {
                return $res
            }
            else {
                Write-Error "No result found. Please check parameters."
            }
        }
        elseif($null -ne $IATACode -and $IATACode -ne "") {
            $res = $airports.GetByIATACode($IATACode)
            if($res -ne $null) {
                return $res
            }
            else {
                Write-Error "No result found. Please check parameters."
            }
        }
        elseif($null -ne $City -and $City -ne "") {
            $res = $airports.GetByCity($City)
            if($res.Length -gt 0) {
                return $res
            }
            else {
                Write-Error "No result found. Please check parameters."
            }
        }
        elseif($null -ne $Country -and $Country -ne "") {
            $res = $airports.GetByCountry($Country)
            if($res.Length -gt 0) {
                return $res
            }
            else {
                Write-Error "No result found. Please check parameters."
            }
        }    
        else {
            return $airports.GetAllAirports()
        }
    }
    End
    {
        $airports = $null
    }
}
