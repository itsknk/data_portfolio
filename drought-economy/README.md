# Drought Impact Analysis on U.S. Agriculture 🌾📊

## Overview
This project analyzes the relationship between drought conditions, agricultural employment, food prices, and government subsidies in the U.S. (2000–2021). Using multivariate techniques, we identify how droughts correlate with economic variables and propose actionable insights for policymakers.

---

## 📁 Data Sources
- **Drought Metrics**: Weekly % of U.S. area/population affected by droughts (Levels 1–5)  
  Source: [U.S. Drought Monitor](https://droughtmonitor.unl.edu/)
- **Economic Data**:  
  - Agricultural employment (`FCET`)  
  - Government subsidies (`AGSBillions`)  
  - Producer Price Index of Food (`PPIF`)  
  - Yearly Inflation Rate (`YIR`)  
  Source: [Federal Reserve Economic Data (FRED)](https://fred.stlouisfed.org/)

---

## 🔍 Key Analyses Performed

### 1. Data Cleaning & Outlier Detection
- Removed 2020 data (COVID-19 outliers) using **Mahalanobis distance**  
- Improved correlations:
  - Yearly Inflation Rate (`YIR`) ↔ Subsidies (`AGSBillions`): **0.19 → 0.55**  
  - Subsidies (`AGSBillions`) ↔ Food Price Index (`PPIF`): **0.03 → -0.22**

### 2. Dimension Reduction (PCA)
| Principal Component | Key Variables                          | Variance Explained |
|----------------------|----------------------------------------|--------------------|
| PC1                  | Drought severity ↔ Subsidy reductions  | 29.3%              |
| PC2                  | Inflation ↔ Area drought               | 27.9%              |
| PC3                  | Employment ↔ Food prices               | 19.7%              |
**Total Variance Explained**: 76.9%

### 3. Cluster Analysis
- **K-means (3 clusters)** provided clearest insights:  
  | Cluster | Characteristics                                  |
  |---------|-------------------------------------------------|
  | 1       | High drought, low employment, high food prices  |
  | 2       | Average drought, low food prices                |
  | 3       | Low drought, low inflation                      |

### 4. Exploratory Factor Analysis (EFA)
Identified three latent factors:  
1. **Drought Severity** (PAD1 + PPD1)  
2. **Inflation** (YIR + AGSBillions)  
3. **Food Supply** (FCET + PPIF)  
**Variance Explained**: 46% | **RMSE**: 0.096

---

## 🚧 Challenges & Lessons
- **Time Series Limitations**: Weekly data caused clustering to reflect temporal trends rather than intrinsic patterns.  
- **CFA Failure**: Confirmatory Factor Analysis did not converge due to low variable correlations.  
- **Recommendations**:  
  - Use monthly/yearly aggregated data  
  - Include regional metrics and food production data  

---

## 🛠️ Reproduction Steps
1. **Install R Packages**:  
   ```r
   install.packages(c("tidyverse", "mclust", "sem", "factoextra"))
   ```
2. **Run Analysis**:  
   ```r
   source("analysis.R")
   ```
3. **Outputs**: All results auto-saved to `/results`

---
