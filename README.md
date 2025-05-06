# LIDA_code
A collection of some code I have written for the LIDA data scientist training programme application

# Correlations

I wrote this R script to analyse some of my PhD data. Here, I have uploaded it with some random dummy data ('dummy_data'), as the results are not yet published. The script analyses correlations between changes over time in different conditions of an experiment. The experiment has three conditions (defined as 'Adaptation Duration'), and three measurement points within each condition (defined as 'Measurement Time'). The outcome measure is 'Unique Yellow'. The question of interest is whether the differences between measurement point 1 and measurement point 2 correlate between the different conditions of adaptation duration. The script reformats the data into the correct orientation to allow this correlation analysis to be run, and also plots the data onto scattergraphs to show the relationship visually.

# Decay by trial

This script also analyses some data I collected during my PhD, and uses the same dummy data file as the previous script. The script analyses whether there is a significant change in the outcome measure across a series of trials at measurement point 2. The script first runs an ANOVA to analyse if there is a significant interaction between trial and measurement time, then a linear regression in order to estimate the slope of the trend. It plots a graph showing the data across trials for each of the three measurement time points (this looks totally random due to the dummy data but there was a good reason for doing this with the real data!!). Finally, it calculates how many additional trials would be needed to return to return the settings made at measurement point 2, to the settings made at measurement point 1, given the slope of the data. 

# UY_lookup

This python script was written to speed up looking up values from the scale on a piece of equipment to the corresponding value in wavelength, according to a calibration I had performed on the equipment. The dummy data here ('dummy_data_participant') is pretending to be an individual participant who has 10 trials for each condition and measurement point, all of which need to be converted from the equipment's aribitrary scale to the calibrated wavelength value. The calibration file contains the real calibrations for the equipment but the participant data is random.
