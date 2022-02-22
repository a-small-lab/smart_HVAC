# This code will serve as the skeleton for the prediction model. Created by Matthew Caruso (mmcnh)

# TODO: load packages, libraries, etc


# TODO: LOAD DATA: PULL FROM AWAIR, GRAFANA, BAS, OTHER?
# Achieve three main goals: 1) IAQ metrics 3) energy metrics 3) occupancy metrics

# 1) IAQ metrics: if we are using 211, note that the two sensor outputs (211-omni and 211-wall-back) must be averaged
CO2 = 850
TVOC = 375
PM = 1.1
temp = 72
# per 15 minutes
productivity_value = 15/3   
# assuming peak performance at $60 per hour, $15 per 15 minutes.
# must divide by the number of IAQ parameters in play due to assumed cumulative effect of each IAQ species
# otherwise, assumed "full" loss is tripled in value if each species contributes "full" effect

# 2) Energy metrics: review energy document to determine all parameters
CFM = 150
temp_differential = 15
humid_differential = 10        
fan_vfd = 10
cost_per_kwh = 0.09

# 3) Occupancy-proxy metrics
dB = 71
lx = 172

# TODO: Generate predictions of what 15, 30, 45 minute IAQ may be. 
# Output: ppm, ppb, ug predictions of future state.


# IAQ COST FUNCTIONS
# "predicted" ppm values given current IAQ, occupancy, and system state will be generated and passed to these cost functions
# no need to generate 15, 30, 45, 60 minute cost calculator: instead, predict metric and pass to cost generator

# Determines 15min cost due to CO2 ppm. Cost is maximized at 2636ppm.
CO2_cost <- function(ppm) {
  # determine cost factor given cost equation
  if (ppm <= 600) {
    cost_factor = 0
  }
  else if (ppm <= 3000) {
    cost_factor = -0.0000000102*(ppm^3) + 0.0000426852*(ppm^2) + 0.0016666667*(ppm) - 14.1666666667
  }
  else {
    cost_factor = 100
  }
  # check if cost_factor outside bounds, constrain if so
  if (100 < cost_factor) {
    cost_factor = 100
  }
  
  cost = productivity_value * (cost_factor/100)
  return(cost)
}

# Determines 15m loss due to TVOC ppb. Cost is maximized at 2000ppb.
TVOC_cost <- function(ppb) {
  # determine cost factor given cost equation
  if (ppb <= 200) {
    cost_factor = 0
  }
  else if (ppb <= 2000) {
    cost_factor = y = 0.0000000285*(ppb^3) - 0.0001294643*(ppb^2) + 0.2137400794*(ppb) - 37.7976190476
  }
  else {
    cost_factor = 100
  }
  # check if cost_factor outside bounds, constrain if so
  if (100 < cost_factor) {
    cost_factor = 100
  }
  
  cost = productivity_value * (cost_factor/100)
  return(cost)
}

# Determines 15min cost due to PM2.5 ug/m^3. Cost is maximized at 35ug/m^3.
PM_cost <- function(ug) {
  # determine cost factor given cost equation
  if (ug <= 2) {
    cost_factor = 0
  }
  else if (ug <= 35) {
    cost_factor = y = -0.0869*(ug^2) + 6.2117*(ug) - 11.063

  }
  else {
    cost_factor = 100
  }
  # check if cost_factor outside bounds, constrain if so
  if (100 < cost_factor) {
    cost_factor = 100
  }
  
  cost = productivity_value * (cost_factor/100)
  return(cost)
}

# TODO: determine if we are controlling for temperature, given we are unsure how temperature changes over time from Mahsa's paper.
# Determines 15min cost due to temperature. 

# IAQ SINGLE-STEP COST
# Do we control for predictions of moving along IAQ curves in future time? ie, air quality is not a step function

# Defines the next step's cost of IAQ (15 minutes)
step_IAQ_cost <- function(CO2_ppm, TVOC_ppb, PM_ug) {
  total_iaq_cost = CO2_cost(CO2_ppm) + TVOC_cost(TVOC_ppb) + PM_cost(PM_ug)
  return(total_iaq_cost)
}

# IAQ NEXT-HOUR COST
hour_IAQ_cost <- function() {
  # need current, +15m prediction, +30min prediction, +45min predictions of IAQ metrics to be passed here
  cost_IAQ_0_15 <- step_IAQ_cost(IAQ_current_metrics)
  cost_IAQ_15_30 <- step_IAQ_cost(IAQ_15m_metrics)
  cost_IAQ_30_45 <- step_IAQ_cost(IAQ_30m_metrics)
  cost_IAQ_45_60 <- step_IAQ_cost(IAQ_45m_metrics)
  total_iaq_cost <- cost_IAQ_0_15 + cost_IAQ_15_30 + cost_IAQ_30_45 + cost_IAQ_45_60
  return(total_iaq_cost)
}

# ENERGY: DETERMINE COST OF CONDITIONING FOR THE NEXT HOUR