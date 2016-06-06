#!/usr/bin/python

import os
import extract

def output_matrix(filename):
  """
  filename: name of performance data file as in 'database'.
  Outputs a simple space-delimited file readable by MATLAB's dlmread.
  """
  inputdirectory = "database/"
  outputdirectory = "processed/"
  performance = extract.get_static_performance( inputdirectory + filename )
  with open(outputdirectory+filename, 'w') as f:
    for line in performance[1:]:
      for elem in line:
        f.write(str(elem)+"\t")
      f.write("\n")
  return

def get_prop_name(filename):
  name = filename.replace('.dat','')
  name = name.replace('PER3_','')
  return name

def output_data_by_rpm(filename):
  inputfile = "database/"+filename
  output_directory = "processed/"+get_prop_name(filename)
  if os.path.isdir(output_directory):
    os.system("rm -r "+output_directory)
  os.mkdir(output_directory)
  rpm = extract.get_rpm(inputfile)
  for r in rpm:
    data = extract.get_data_by_rpm(inputfile, int(r))
    with open(output_directory+"/rpm"+str(int(r))+".dat", 'w') as f:
      f.write(data)
  return

if __name__ == "__main__":
  for f in os.listdir("database"):
    output_matrix( f )
    output_data_by_rpm( f )



