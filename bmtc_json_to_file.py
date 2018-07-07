# -*- coding: utf-8 -*-
"""
Created on Mon Jul  2 15:06:11 2018

@author: Sreenivasulu Parimi
"""

import pandas as pd
import numpy as np
import json


'''
#json.loads(js)
df = pd.read_json(js)
lat = [x[0] for x in df['latlons']]
lon = [x[1] for x in df['latlons']]
df['lat'] = lat
df['lon'] = lon
print(df)
'''
#df = pd.read_json('.../Coursera/Developing-Data-Products-Course-Project/bmtc_routes_map_sample.csv')
df = pd.read_csv('.../Coursera/Developing-Data-Products-Course-Project/bmtc_routes_map_sample.csv')
#df = df.drop(columns=['origin', 'departure_from_origin'])

df = df.drop(['origin', 'departure_from_origin'], axis=1)
df_json = pd.read_json(df['map_json_content'][0])
lat = [x[0] for x in df_json['latlons']]
lon = [x[1] for x in df_json['latlons']]
df_json['lat'] = lat
df_json['lon'] = lon
final_df = df_json.drop(['latlons'], axis=1)

for i in range(len(df)):
    df_json = pd.read_json(df['map_json_content'][i])
    lat = [x[0] for x in df_json['latlons']]
    lon = [x[1] for x in df_json['latlons']]
    df_json['lat'] = lat
    df_json['lon'] = lon
    final_df = df_json.drop(['latlons'], axis=1)
    #final_df.to_csv('.../Coursera/Developing-Data-Products-Course-Project/bmtc.csv', encoding='utf-8', index=False)
    final_df.to_csv('.../Coursera/Developing-Data-Products-Course-Project/bmtc%i.csv'%+i, encoding='utf-8', index=False)
    