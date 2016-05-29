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

if __name__ == "__main__":
  for file in os.listdir("database"):
    output_matrix( file )




