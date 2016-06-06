#!/usr/bin/python

import re
import physics

def get_geometry(datafile):
  """
  Assumes first line contains geometry information.
  """
  diameter = 0
  pitch = 0
  with open(datafile, 'r') as f:
    for line in f:
      spec = line.strip().split()[0]
      spec = re.sub( '[A-Z]', '', spec )
      specs = spec.split('x')
      diameter = float( specs[0] )
      pitch = float( specs[1].split('-')[0] )
      break
  return (diameter, pitch)

def get_rpm(datafile):
  rpm = []
  with open(datafile, 'r') as f:
    for line in f:
      if "PROP RPM" in line:
        rpm.append( float( line.strip().split()[3] ) )
  return rpm

def get_static_thrust(datafile):
  thrust = []
  with open(datafile, 'r') as f:
    for line in f:
      data = line.strip().split()
      if len(data) > 1:
        if "0.0" == data[0]:
          thrust.append( float( data[7] ) )
  return thrust

def get_static_power(datafile):
  power = []
  with open(datafile, 'r') as f:
    for line in f:
      data = line.strip().split()
      if len(data) > 1:
        if "0.0" == data[0]:
          power.append( float( data[5] ) )
  return power

def print_list(list_):
  for ll in list_:
    print ll
  return

def get_static_performance(datafile):
  (diameter, pitch) = get_geometry(datafile)
  print "=========="
  print "Read data for "+str(diameter)+" x "+str(pitch)+" propeller"
  thrust = get_static_thrust(datafile)
  power = get_static_power(datafile)
  pl = [ 1000.0 * p for p in physics.metric_power_loading(thrust, power) ]
  rpm = get_rpm(datafile)
  m = physics.tip_mach( rpm, diameter )
  performance = []
  performance.append(("Tip Mach", "Thrust (lbf)", "Power Loading ( N / kW )"))
  for i in range(len(thrust)):
    item = (m[i], thrust[i], pl[i])
    performance.append(item)
  print "=========="
  return performance

def get_data_by_rpm(datafile, rpm):
  data = "";
  with open(datafile, 'r') as f:
    for line in f:
      if "PROP RPM" in line and str(rpm) in line:
        for line in f:
          if "PROP RPM" in line:
            return data
          data += line
  return data

if __name__ == "__main__":
  print "Test"
  # print print_list( get_static_performance("database/PER3_19x8E.dat") )
  # print print_list( get_static_performance("database/PER3_13x55EP.dat") )
  # print print_list( get_static_performance("database/PER3_16x55MR.dat") )
  # print print_list( get_static_performance("database/PER3_15x55MR.dat") )
  # print print_list( get_static_performance("database/PER3_22x8.dat") )
  # print print_list( get_static_performance("database/PER3_27x13E.dat") )
  # print print_list( get_static_performance("database/PER3_26x13E.dat") )
  # print print_list( get_static_performance("database/PER3_24x12E.dat") )
  # print print_list( get_static_performance("database/PER3_18x55MR.dat") )
  # print print_list( get_static_performance("database/PER3_17x12E.dat") )
  # print print_list( get_static_performance("database/PER3_17x6E.dat") )
  # print print_list( get_static_performance("database/PER3_20x8E.dat") )
  # print print_list( get_static_performance("database/PER3_13x65E.dat") )
  # print print_list( get_static_performance("database/PER3_16x4E.dat") )
  # print print_list( get_static_performance("database/PER3_19x11.dat") )
  data = get_data_by_rpm("database/PER3_19x11.dat", 2000)
  print data
