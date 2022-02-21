# Methodology for Estimating Olsson 2nd Floor Energy Consumption

There are three primary aspects of energy consumption of the VAV (variable air volume) HVAC system used in Olsson Hall.

- Heating/Cooling
- Fan Operation
- Pump Operation

## Remaining Questions and Points of Uncertainty

### Heating/Cooling
- figure out how to use a Mollier diagram/calculator
- confirm that %_OutdoorAir is percentage of outdoor air in mixed air, not percent outdoor air duct is open
- confirm that temperature differential is the difference between the temperature of supply air and mixed air for initial heating/coolin
- confirm that energy consumption calculations are done for each AHU for inital cooling heating, then again per VAV box to get reheating energy consumption
  - temperature differential for each VAV box is AHU supply temp - VAV box supply temp
- find humidity weather data
- is SEER relevant at all? Doesn't seem link it but worth checking

### Fans
- unsure what the pressure terms in the equations mean. Is this general atmospheric data (e.g. weather data) or internal data (interior building pressure)
- how should i factor heat produced by the fan into the heating/cooling equations?

# Energy Estimation Procedures
## Heating/Cooling

There are three main energy consuming portions of the heating/cooling process

1. Inital Heating/Cooling
   - Occurs at thu AHU level when mixed air is heated/cooled to supply air temperature
2. Reheating
   - Occurs at the VAV box level to ensure each room is maintained at the correct temperature
3. Humidity Removal
   - Occurs at the AHU level to create suitable supply air

The below equations can be applied to estimate energy consumption from these processes

####  Equations
Source: https://www.engineeringtoolbox.com/cooling-heating-equations-d_747.html
##### Equation 1, Sensible Heat
h_s = c\*ρ\*q\*dt

where:

h = sensible heat (kW)\
c = specific heat of air (1.006 kJ/kg C)\
ρ = density of air (1.202 kg/m3)\
q = air volume flow (m3/s)\
dt = temperature difference (C)

##### Equation 2, Air Temperatures and %OutdoorAir
%_OutdoorAir = (t_mixed - t_return)/(t_outdoor - t_return)

##### Equation 3, Latent Heat
h_l = ρ\*h_we\*q\*dw_kg

where:

h_l = latent heat (kW)\
ρ = density of air (1.202 kg/m3)\
q = air volume flow (m3/s)\
h_we = latent heat evaporization water (2454 kJ/kg - in air at atmospheric pressure and 20oC)\
dw_kg = humidity ratio difference (kg water/kg dry air)

##### Equation 4, Latent and Sensible Heat
h_t = ρ\*q\*dh

where:

h_t = total heat (kW)\
q = air volume flow (m3/s)\
ρ = density of air (1.202 kg/m3)\
dh = enthalpy difference (kJ/kg)

Where dh can be estimated using the Mollier diagram\

## Fan Operaion
Source: https://www.engineeringtoolbox.com/fans-efficiency-power-consumption-d_197.html

#### Power Used by Fan
P = dp*q/mu

where:

mu = fan efficiency (values between 0 - 1)\
dp = total pressure (Pa) \
q = air volume delivered by the fan (m3/s)\
P = power used by the fan (W, Nm/s)

- We can assume 60-70% efficiency and tweak using the energy consumption data we have/get over time.
- Air flow in CFM is available per AHU
- **Obtain local weather/air pressure data to estimate dp?**

#### Heating Caused by Fan Inefficiency
dt = dp / 1000

where:

dt = temperature increase (K)\
dp = increased pressure head (Pa) **not entirely sure what this means yet**

#### Pump Operation
We have been advised that energy consumption here is negligble compared to other contributors and thus will not investigate this are for now.
