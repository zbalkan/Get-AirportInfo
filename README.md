# Get-AirportInfo
Based on [GlobalAirports.Net](https://github.com/shrayasr/GlobalAirports.Net) by Shrayas Rajagopal ([shrayasr](https://github.com/shrayasr)), this toy cmdlet can return the Global Airports DB data by parameters


## Installation
1. Download and extract the repository on your computer.
2. Create a folder named `bin` in the same directory.
3. [GlobalAirports.Net](https://github.com/shrayasr/GlobalAirports.Net) does not have releases. So you may need to build the dll by yourself. I just didn't think it would be ethical to include it here.
4. Move the dll into the `bin` directory.

## Usage
### All Airports
`Get-AirportInfo`
### By ICAO Code
`Get-AirportInfo -ICAOCode VOMM`
### By IATA Code
`Get-AirportInfo -IATACode MAA`
### By City
`Get-AirportInfo -City LONDON`
### By Country
`Get-AirportInfo -Country Turkey`
