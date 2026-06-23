# ESG Drivers of Stock Returns — Regression Study

> **Quantifying the impact of 600+ ESG variables on stock returns of Indian energy sector companies using OLS regression**

## Overview

This study investigates whether ESG (Environmental, Social, Governance) performance metrics have a statistically significant relationship with stock returns for Indian energy sector companies. Using ESG data extracted from LSEG Workspace and processed across E, S, G, and Controversies dimensions, an OLS regression framework was applied to identify which ESG factors are meaningful predictors of revenue and returns.

This is a companion study to the [LSTM vs ARIMA Forecasting](../../Model-for-Price-Discovery-of-Energy-Companies-Stocks/) project, using the same company universe.

---

## Data

- **ESG data source:** LSEG Workspace (institutional access, IIM Ahmedabad)
- **Coverage:** Indian energy sector companies, multi-year panel
- **Variables:** 600+ ESG parameters across four pillars — Environment, Social, Governance, Controversies
- **Stock data:** Price and return series via Yahoo Finance API

---

## Methodology

**Step 1 — Data Acquisition & Cleaning (`ESG_DataCleaning.ipynb`)**  
Raw ESG files extracted from LSEG Workspace in Excel format. Currency normalisation (USD → INR at spot rate), string parsing, and percentage conversion applied. Data structured into four sub-pillars: Environment, Social, Governance, Controversies.

**Step 2 — Stock Price Processing (`ESG_StockPrices.ipynb`)**  
Yearly returns computed for each company. Combined with ESG scores into a panel dataset for regression.

**Step 3 — OLS Regression (`ESG_Regression_Revenue.R`)**  
- Baseline model: Revenue ~ all ESG variables  
- VIF (Variance Inflation Factor) checks to remove multicollinear predictors  
- Stepwise variable elimination by p-value  
- Outlier detection via standardised residuals and `outlierTest()`  
- Residual diagnostics: Q-Q plot, fitted vs residuals, `residualPlots()`  
- Final model retains only statistically significant ESG drivers (p < 0.05)

**Step 4 — Data Download (`Download_StocksData.ipynb`)**  
Automated retrieval of stock price data to keep the dataset current.

---

## File Structure

```
MSc. Project_Forecasting and ESG Analysis/
├── ESG_DataCleaning.ipynb          # Data ingestion, currency normalisation, structuring
├── ESG_StockPrices.ipynb           # Return computation, panel dataset construction
├── ESG_Regression_Revenue.R        # OLS regression, VIF, outlier removal, diagnostics
└── Download_StocksData.ipynb       # Automated stock data retrieval (yfinance)
```

---

## Tech Stack

| Category | Tools |
|---|---|
| Languages | Python, R |
| ESG Data | LSEG Workspace (institutional) |
| Stock Data | yfinance |
| Regression | R (`lm`, `car` — VIF, `outlierTest`) |
| Processing | pandas, NumPy, openpyxl |
| Visualisation | Matplotlib, R base plots |

---

## Key Findings

- After VIF-based multicollinearity filtering and outlier removal, a parsimonious set of ESG variables showed statistically significant relationships with revenue (p < 0.05)
- Governance and Environmental sub-pillars contributed more predictive power than Social metrics in this sector
- The study demonstrates that ESG performance is not merely a reporting exercise — select metrics carry quantifiable financial signal in the Indian energy sector

---

## Context

Research conducted at IIM Ahmedabad under institutional access to LSEG Workspace and Bloomberg Terminal.
