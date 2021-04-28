# Data and Plan for Analysis
In order to leverage time series analysis to answer this question, this project will investigate:
- How HVAC system operation affects energy consumption over time
- How HVAC system operation affect the collected metrics of comfort over time

## Four System Aspects with relation to energy consumption, Current Questions
- Heating/Cooling
	- Data exists for hot/cold water data for building not AHU
	- Currently are focusing on the second floor of Olsson which is serviced by two specific air handling units.
		-	Is there a way to separate out the energy consumption for these two systems?
		-	Should we expand to a building-wide view? Floor?
			- Error grows with more granular analysis, could just wait for metering
			-
		-	Is looking at consumption on an AHU level a valid perspective?
- Fans
	-	We have supply flow air and fan status but we need a methodology of connecting this to data to energy usage, or just generally a method to understand fan energy consumption.
- Pumps
	- Evaluate whether we have useful data which will help us understand pump energy consumption
- Additional helpful system context?
- Walkthrough: http://icoweb.fm.virginia.edu/anyglass/pubdisplay/UVa/Customers/LinkLab0202/Home.gdfx
  - Is above the most relevant/useful source of information on system operation?

## Notes
- electricity is not particularly seasonal, smaller proportion of energy consumption than heating and Cooling
- biggest first level is having c02 sensors as they give us a window into occupancy and how ventilatin is working with it
- occupancy data could also be interesting to look at
- humidity is other comfort metric
- link is super useful
  - amount of fresh air is calculated
  - if you know OA temp and fraction of OA we can calculate energy consumption
  - can translate airflow to fan enery using an assumption about fan efficience
    - use general fan law to assume efficieny is around 60-70%
      - 60% of energy put into fan moves airfaster
      - 40% goes to heat technically?? source of error **potentially add temp for fan**
- vav boxes are also important
- air at a given temp and humidity has a given enthalpy, moving to different temp and humid changes enthalpy, likely a lookup table, can multiply this by mass of air from CFM and this might be a good estimate of enery consumption
- sensible and latent heat
- use UVA's global humidity measure, temp
- determine return air fraction (fraction leaving)

- use data we have on energy consumption as validation to tweak assumptions
- the "fraction" will change based on conditions
- AHU is "on" when in occupied mode
- How is occupied mode determined?
  - Optimum stop start mode can affect ramp up time
- occupancy data is combination scheduled and some collected data?
- supply fan may come on without triggering occupancy
- question whether 2w and 2e are on the same schedule
- % VFD is super useful for energy consumption

- Links:
  - https://www.engineeringtoolbox.com/cooling-heating-equations-d_747.html
  - https://www.engineeringtoolbox.com/psychrometric-terms-d_239.html
  - https://av8rdas.files.wordpress.com/2015/09/image_thumb102.png?w=400&h=218
  - https://www.engineeringtoolbox.com/fans-efficiency-power-consumption-d_197.html
  -


## Current Data

### For each air handling unit we have:

- Temperature data (deg F):
 - RA-T; Return Air
 - SA-T; Supply Air
 - PH-T; Pre-Heat Air
 - MA-T; Mixed Air

- Fans (logical on/off, Variable Frequency Drive perecntage):
  - R-FN; Return Fan
  - S-FN; Supply Fan

- Humidity:
  - RA-H; Return Air (% rel. humidity)

- Ducts:
  - EXH-D; Exhaust (%, open? documentation unclear)
  - OA-D; Outside Air (%, open? documentation unclear)

- Heating/Cooling:
  - **PH-V; Pre-Heat Valve (% Open)**
  - **CHW-V; Chilled Water Valve (% Open)**

- Occupied (logical 0/1)

### For each room we have:
- **HW-V; Hot Water Valve (%, open? documentation unclear)**
- SA-T; Supply Air Temperature (73.3 deg F)
- SA-F; Supply Air Flow (CFM)
- SA-F-SP; Supply Air Flow Set-Point
- ZN-T; Unconfirmed but appears to be temperature set-point (deg F)
- Temperature (deg C)
- co2 (only select rooms, PPM)
- Heating/Cooling:
  - PH-V; Pre-Heat Valve (% Open)
  - CHW-V; Chilled Water Valve (% Open)
- Occupied (logical 0/1)
