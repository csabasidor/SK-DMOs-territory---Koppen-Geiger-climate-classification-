# SK DMOs territory - Köppen-Geiger climate classification
The repo contains all scripts and resulting data of the research case <br>
Similarity and Homogeneity of Climate Change in Local Destinations: A globally reproducible approach from Slovakia


### 01 Create country level Köppen-Geiger climate classification subsets<br>
**1.** Download the original Becks et al. (2023) TIFF maps from <a href = "https://www.gloh2o.org/koppen/">gloh20</a> and unzip the files into folder named (koppen_geiger_tif) <br>
**2.** Run the 01_subset_geotiff_country_level.ipynb in the created folder<be>
- In cell 1 -> Update the name for "directory", if you used other than 'koppen_geiger_tif'
- In cell 2 -> Insert your DB credentials
- In cell 2 -> Adjust vector_df (either use own PostGIS boundary or use osmnx  
- In cell 2 -> Update the name of target folders, where the country subsets should be saved.

### 02 Create subsets of DMO intersections from national subsets <br>
**1.** Run Subset Koppen-Geigen and SK DMOs intersection.ipynb
- Adjust the directory pathways
- Insert your DB credentials
- If you have your destinations boundary in Postgis, adjust kg_subset_dmos.sql and then run the loop

### 03 Analyze climate classes change, Entropy and Variance  <br>
04 analysing entropy and variance robust regerssion <br>
05 link to power bi dash + template <br>
06 link to online map <br>

cite as <br>
cite beck and peel <br>

