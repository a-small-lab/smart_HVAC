The first portion of the project, focused on HVAC operation and energy consumption, requires the collection and organization of data related to HVAC system operation for each air handling unit, including:

- Temperature data (deg F):
 - Return Air
 - Supply Air

- Humidity:
  - Return Air (% rel. humidity)

- Heating/Cooling:
  - Pre-Heat Valve (% Open)
  - Chilled Water Valve (% Open)

- Energy Consumption (Calculated from above if not available)

- Supply Air Volume (ft^3/min)

- Air Handling Unit SEER

### Calculation of energy consumption using SEER ratio

The below methodology is pending verification from UVA facilities experts.

SEER = BTU/Watt-Hours = total change in heat energy in conditioned space divided by energy consumed to condition space


#### Calculating BTU/hr for heating operation\
BTU/hr = C * del(T) * M\

Where:

- C is the specific heat of air (approx. 1 kJ/Kg*K)
- del(T) is the change in temperature
- M is the mass of air = rho*V, using an approximate density of 1.2 Kg/m^3
- Given our data an adjustment will also have to be made to convert from cubic feet per **minute** to BTU per **hour**.


#### Calculating BTU/hr for cooling operation\
An additional term can be included in calculating BTU related to the removal of humidity:\

BTU/hr = C * del(T) * M + (0.68 * CFM * del(w_gr))

Where:

- CFM = airflow in cubic feet per minute
- del(w_gr) = change in humidity ratio in grains

Data is not currently available on humidity removal, so the heating methodology will be applied as an estimated of energy consumption under cooling operation.


## HVAC System Operation and Collected Metrics of Comfort

The second portion of the project, focused on HVAC operation and comfort, requires the collection and organization of data related to HVAC system operation for each air handling unit and room status indicators for all rooms serviced by an air handling unit including:

1. Detailed data on HVAC system operation
2. Data on CO2, temperature, humidity, occupancy, and other selected metrics

This analysis will be set aside for now, pending later investigation.

## Improving HVAC System Control Policy

Once both phases of analysis are complete and system dynamics are adequately understood, simulation can be used to develop an optimized control mechanism to minimize energy usage while maintaining occupant safety.


# Exploratory Data Analysis


# Data and Data Generating Process
