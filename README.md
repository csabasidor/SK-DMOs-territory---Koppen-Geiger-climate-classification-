# SK DMOs territory - Köppen-Geiger climate classification
The repo contains all scripts and resulting data of the research case (under review): <br>
Sidor et al. (2025) Similarity and Homogeneity of Climate Change in Local Destinations: A globally reproducible approach from Slovakia <br>


### Note<br>
All charts, results may be previewed and replicated via the following notebooks. <br>
Results of SA may be found in folder [data_out](./data_out/) <br>
For some convenience the subset of Köppen-Geiger maps for Slovakia may be found in folder [kg_sk_subsets](./kg_sk_subsets) <br>

### 01 Create country level Köppen-Geiger climate classification subsets<br>
**1.** Download the original Becks et al. (2023) TIFF maps from <a href = "https://www.gloh2o.org/koppen/">gloh20</a> and unzip the files into folder named (koppen_geiger_tif) <br>
**2.** Open notebook [01_subset_geotiff_country_level.ipynb](./01_subset_geotiff_country_level.ipynb) in the created folder<be>
- In cell 1 -> Update the name for "directory", if you used other than 'koppen_geiger_tif'
- In cell 2 -> Insert your DB credentials
- In cell 2 -> Adjust vector_df (either use own PostGIS boundary or use osmnx  
- In cell 2 -> Update the name of target folders, where the country subsets should be saved.

### 02 Create subsets of DMO intersections from national subsets <br>
**1.** Open notebook [02_Subset_Koppen-Geigen_and_SK_DMOs_intersection.ipynb](./02_Subset_Koppen-Geigen_and_SK_DMOs_intersection.ipynb)
- CELL 2 -> Insert your DB credentials
- CELL 2 -> Adjust the directory pathways
- CELL 3 -> If you have your destinations boundary in Postgis, adjust kg_subset_dmos.sql and then run the loop

### 03 Analyze main climate classes' change, Entropy and Variance  <br>
**1.** Open notebook [/03_KG_clusters_main_climate_class.ipynb](./03_KG_clusters_main_climate_class.ipynb) <br>
- Cell 1 -> Insert your DB credentials and load data for all DMOs and periods as single df
- Cell 2 -> Main climates territorial weight and change over periods
- Cell 3 -> Clusters by main climate over periods
- Cell 4 -> DMOs per Cluster per period 
- Cell 5 -> Predominant main climate per cluster per period
- Cell 6 -> Similarity of clusters period vise (grid)
- Cell 7 -> Similarity of clusters period vise (corr. heatmap)
- Cell 8 -> Deeper cluster analysis (PCA)
- Cell 9 -> DMOs by variation of main climate change
- Cell 10 -> Distribution of main climates weights'change per DMO
- Cell 11 -> Deeper statistical analysis of main climates weights'change per DMO (+boxplots)
- Cell 12 -> Homogeneity Entropy and Variance
- Cell 13 -> Correlation Analysis of territory size and Homogeneity Etropy and Fluctuation
- Cell 14 -> Testing prerequisites for Regression, and adopting Huber Regression

##### Simple dashboard may be found <a href = "https://cases.idoaba.eu/sk_dmos_kgc/">here</a>

#### Please if you're using any of this, also cite the origins of the data used in this case: 
##### Beck, H., E., McVicar, T. R., Vergopolan, N., Berg, A., Lutsko, N. J., Dufour, A., Zeng, Z., & others. (2023). High-resolution (1 km) Köppen-Geiger maps for 1901–2099 based on constrained CMIP6 projections. Scientific Data, 10 (1), 724. https://doi.org/10.1038/s41597-023-02458-5 



