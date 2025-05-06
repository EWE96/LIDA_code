# -*- coding: utf-8 -*-
"""
Created on Fri Jul 29 14:32:49 2022

@author: ee728
"""

import pandas as pd
import os

#import participant file and calibration file(s)

os.chdir('') #set path to file

partfile = 'dummy_data_participant.xlsx'
calibrationfile = 'Colorimeter calibration final.xlsx'

#create dataframe of relevant calibration file sheet

calibrationsheet = pd.read_excel(calibrationfile, sheet_name = 'Lookup all')

#read lookup table from calibration file into a dictionary

calibrationdf = calibrationsheet[['Cm','Test arm 1']]
calibrationdf['Cm'] = calibrationdf['Cm'].round(2)

UY_lookup = pd.Series(calibrationdf['Test arm 1'].values,index = calibrationdf['Cm']).to_dict()

#create a list of dataframes for each sheet in participant file

sheetnames = ['15m UY',  '1h UY',  '4h UY',]
sheets = []

for item in sheetnames:
    df = pd.read_excel(partfile, sheet_name = item)
    item = df
    sheets.append(item)
    
#convert to lists all columns with data to be calibrated from relevant sheets

sheetnums = [0,1,2]

#make lists for the wavelengths, remove nan values

for x in sheetnums:    
    df = sheets[x]
    preUY = df['Pre-adaptation'].values.tolist()
    preUY = [x for x in preUY if str(x) != 'nan']
    fivepostUY = df['5-post'].values.tolist()
    fivepostUY = [x for x in fivepostUY if str(x) != 'nan']
    sixtypostUY = df['60-post'].values.tolist()
    sixtypostUY = [x for x in sixtypostUY if str(x) != 'nan']
    
    prewavelengths = []
    
    #lookup each data point as key in lookup table and return value
    
    for item in preUY:
        wavelength = UY_lookup[item]
        #place returned values into a list
        prewavelengths.append(wavelength)
        #read list of returned values into appropriate column and sheet of participant file
        #df['Pre-adaptation wavelength'] = wavelengths
    
    print(f'Pre-adaptation - Sheet{x+1}')
    for num in prewavelengths:
        print(num)
        
    fivewavelengths = []
   
    #lookup each data point as key in lookup table and return value
   
    for item in fivepostUY:
       wavelength = UY_lookup[item]
       #place returned values into a list
       fivewavelengths.append(wavelength)
   
    print(f'5-post-adaptation - Sheet{x+1}')
    for num in fivewavelengths:
       print(num)
       
    sixtywavelengths = []
       
    #lookup each data point as key in lookup table and return value
   
    for item in sixtypostUY:
       wavelength = UY_lookup[item]
       #place returned values into a list
       sixtywavelengths.append(wavelength)
   
    print(f'60-post-adaptation - Sheet{x+1}')
    for num in sixtywavelengths:
       print(num)
       
