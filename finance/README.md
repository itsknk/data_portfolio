# Bitcoin Price Correlation with Stock Markets Analysis 📈🔗

## Overview
This project analyzes the relationship between Bitcoin prices and traditional stock market indices (S&P 500 and XLK Technology Sector) from 2011–2021. Using econometric models, we test whether Bitcoin acts as a complementary or substitutive investment to equities, controlling for macroeconomic and blockchain-specific variables.

---

## 🎯 Objectives
1. **Primary**: Determine if S&P 500 price changes positively correlate with Bitcoin prices.  
2. **Secondary**: Assess if XLK Technology Sector Fund price changes predict Bitcoin prices.  
3. **Control Variables**: GDP, Bitcoin hash rate, and trade volume.

---

## 📂 Data Sources
| Variable               | Source                                                                 | Frequency   |
|------------------------|-----------------------------------------------------------------------|-------------|
| Bitcoin Price          | [Nasdaq Data Link](https://data.nasdaq.com/)                          | Daily       |
| S&P 500 & XLK Prices   | [Investing.com](https://www.investing.com/)                           | Daily       |
| US GDP                 | [FRED (Federal Reserve)](https://fred.stlouisfed.org/)                | Quarterly   |
| Bitcoin Hash Rate      | [Nasdaq Data Link](https://data.nasdaq.com/)                          | Daily       |
| Bitcoin Trade Volume   | [Nasdaq Data Link](https://data.nasdaq.com/)                          | Daily       |

---

## 🔍 Methodology

### Key Steps:
1. **Unit Root Testing**: Augmented Dickey-Fuller tests confirmed non-stationarity.  
   - Differencing applied to all variables (𝑡 − 𝑡−1).  
2. **Model Specifications**:  
   Five linear regression models tested incremental variable inclusion:  

   | Model | Variables Included                                   | Purpose                          |
   |-------|------------------------------------------------------|----------------------------------|
   | 1     | S&P 500                                              | Baseline correlation             |
   | 2     | XLK                                                  | Sector-specific test             |
   | 3     | S&P 500 + XLK                                        | Combined equity effect           |
   | 4     | S&P 500 + XLK + GDP + Hash Rate + Trade Volume       | Macroeconomic controls           |
   | 5     | Model 4 + Trend/Seasonality                          | Time-series adjustment           |

3. **Hypotheses**:  
   - \( H_0 \): \( \text{corr(S&P 500, Bitcoin Price)} \leq 0 \)  
   - \( H_A \): \( \text{corr(S&P 500, Bitcoin Price)} > 0 \)  

---

## 📊 Key Results

### S&P 500 Correlation
- **Statistically Significant** (\( p < 0.01 \)) across all models.  
- **Coefficient Interpretation**:  
  - 1% increase in S&P 500 → **3.1–8.9% increase** in Bitcoin price.  

### XLK Technology Sector
- **Inconclusive**:  
  - Negative coefficients in Models 3–4 (\( p < 0.05 \)).  
  - Suggests Bitcoin may act as a **substitute** for tech-sector investments.  

### Control Variables
| Variable     | Effect on Bitcoin Price | Significance |
|--------------|-------------------------|--------------|
| GDP          | Negative                | \( p < 0.05 \)|
| Hash Rate    | Positive                | \( p < 0.001 \)|
| Trade Volume | Insignificant           | \( p > 0.1 \) |

---

## 📌 Conclusions
1. **Strong S&P 500 Link**: Bitcoin prices rise with S&P 500 gains, supporting its role as a **complimentary investment**.  
2. **Tech Sector Divergence**: XLK's negative correlation suggests Bitcoin may compete with tech stocks.  
3. **Macro Impact**: GDP growth inversely affects Bitcoin, possibly due to traditional investment shifts.  

---

## 🔄 Reproduction Steps
1. **Install R Packages**:  
   ```r
   install.packages(c("dplyr", "tseries", "forecast", "readxl"))
   ```
2. **Run Analysis**:  
   ```r
   source("analysis.R")  # Generates results in /results
   ```
3. **Outputs**:  
   - Regression tables (Model 1–5 coefficients)  
   - Time-series plots (Bitcoin vs. S&P 500/XLK)  

---
