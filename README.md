# apc-post
Python scripts for post-processing APC propeller performance data. 

Currently processes static thrust data. Extensions can be made for 
freestream inflow conditions.

## Usage

1. Download desired performance data files into 'database' folder.  
2. Run 'output.py', modifying the main script to output the desired propeller 
  performance files in the folder 'processed'.
3. Run 'plot.m', a MATLAB script, to plot the results. Modify this script to 
  plot those files output in the previous step in 'processed'.  

