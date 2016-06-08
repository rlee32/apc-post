#!/usr/bin/python

import math

def tip_mach( rpm, diameter_inches, sound_speed_fps=1126 ):
  """
  Returns the tip Mach number.
  """
  rps = [ ( r / 60.0 * math.pi * 2 ) for r in rpm ]
  tip_speed_fps = [ diameter_inches / 12.0 / 2.0 * r for r in rps ]
  return [ ts / sound_speed_fps for ts in tip_speed_fps ]
  

if __name__ == "__main__":
  print tip_mach( [6000], 19 )

def metric_power_loading( thrust_lbf, power_hp ):
  pl = []
  thrust_n = [ 4.44822 * t for t in thrust_lbf ]
  metric_w = [ 745.7 * p for p in power_hp ]
  pl = [ thrust_n[k]/metric_w[k] for k in range(len(thrust_n)) ]
  return pl
