# ESG Drivers of Stock Returns — Regression Study

> **Quantifying which ESG variables significantly explain company Revenue, using regression on 600+ ESG parameters across 21 Indian energy sector companies**

## Overview

This study asks: which ESG (Environmental, Social, Governance) indicators significantly explain company Revenue? Using ESG data sourced from LSEG Workspace and Bloomberg Terminal across 21 Indian energy sector companies and 9 sub-sectors, a multiple linear regression framework was built, diagnosed, and refined through systematic variable elimination to isolate the ESG factors that actually carry explanatory power — as opposed to the hundreds that don't.

A parallel notebook pipeline (`ESG_StockPrices.ipynb`) extends the same ESG dataset to test predictive power over annual stock returns using a Random Forest framework, run alongside the R-based Revenue regression as a second, ML-driven angle on the same question.

This is a companion study to the [LSTM vs ARIMA Forecasting](https://github.com/DivyaKotia/Model-for-Price-Discovery-of-Energy-Companies-Stocks) project, using the same 21-company universe.

---

## Data Pipeline

**1. `Download_StocksData.ipynb`** — Pulls historical stock prices (2000–present) for the company universe via `yfinance`; stores company-wise processed CSVs as input for return calculation.

**2. `ESG_DataCleaning.ipynb`** — Standardises raw ESG Excel exports: currency conversion (USD → INR at a fixed spot rate), percentage/year parsing, `"--"` → NA handling, and reshaping from wide to long format (`Parameter | Year | Value`) across four pillars — Environment, Social, Governance, Controversies.

**3. `ESG_StockPrices.ipynb`** — Merges cleaned ESG data with yearly stock returns (Company + Year as merge key). Applies missing-value handling (drop, median-fill, cap at 50% missingness), IQR-based outlier capping, train/test split with `StandardScaler`, then a three-method hybrid feature selection (Random Forest + Extra Trees importance, Mutual Information, intersection/union ranking) feeding a `RandomForestRegressor`. Statistical assumption checks performed: linearity, residual normality (Anderson–Darling), multicollinearity (VIF), autocorrelation (Durbin–Watson).

**4. `ESG_Regression_Revenue.R`** — The core empirical model: OLS regression of Revenue on ESG variables, refined through systematic diagnostics (below).

---

## Methodology — Revenue Regression (R)

1. **Baseline model** — `Revenue ~ all ESG variables`, after removing non-analytical identifier columns (Company, Industry, Year)
2. **Multicollinearity check** — VIF via the `car` package; removed `S_Number of Employees (from CSR reporting)` for redundancy
3. **Outlier detection** — standardised residuals + `outlierTest()`; removed two anomalous observations
4. **Diagnostics** — residual plots, Q-Q plot, fitted-vs-residual analysis to assess normality and linearity
5. **Backward elimination** — five variables sequentially dropped by p-value significance:
   - `E_Electricity Purchased`
   - `E_Waste Total`
   - `G_Total Senior Executives Compensation to Revenues`
   - `S_Women Employees`
   - `G_Enterprise Value (incl. Cash & ST Investments, USD)`
6. **Model selection** — tracked R² and Adjusted R² across 8 iterations (Fit1 → Fit8), cross-validated against R's automated `step(..., direction="backward")`

---

## Results

| Model | R² | Adjusted R² |
|---|---|---|
| Fit 1 (baseline) | 0.8336 | 0.8180 |
| Fit 8 (final) | 0.8507 | 0.8415 |

The final model (**Fit 8**) explains roughly **85% of the variation in Revenue** after eliminating multicollinear and statistically insignificant predictors — a meaningful improvement in both fit and interpretability over the unrefined baseline, achieved by removing noise rather than adding complexity.

In the parallel Random Forest pipeline targeting annual stock return (rather than Revenue), hybrid feature selection reduced the 600+ candidate ESG variables to **10–15 statistically and predictively significant factors**, though the notebook's own diagnostic notes flag the ESG–stock-return relationship as comparatively weak despite some evidence of linearity — a more modest result than the Revenue regression's 85% fit, and one worth stating plainly rather than glossing over.

---

## Tech Stack

| Category | Tools |
|---|---|
| Languages | Python, R |
| ESG Data | LSEG Workspace, Bloomberg Terminal (institutional access) |
| Stock Data | yfinance |
| Regression | R (`lm`, `car::vif`, `car::outlierTest`, `step`) |
| ML Pipeline | Random Forest, Extra Trees, Mutual Information (scikit-learn) |
| Processing | pandas, NumPy |
| Diagnostics | Anderson–Darling, Durbin–Watson, VIF |

---

## File Structure

```
ESG Drivers of Stock Returns — Regression Study/
├── Download_StocksData.ipynb       # Stock price ingestion (yfinance)
├── ESG_DataCleaning.ipynb          # ESG data standardisation, wide-to-long reshape
├── ESG_StockPrices.ipynb           # ESG + returns merge, RF feature selection, modelling
└── ESG_Regression_Revenue.R        # Core OLS regression, VIF, backward elimination
```

---

## Context

Research conducted at IIM Ahmedabad under institutional access to LSEG Workspace and Bloomberg Terminal. Same 21-company universe as the companion [LSTM vs ARIMA](https://github.com/DivyaKotia/Model-for-Price-Discovery-of-Energy-Companies-Stocks) forecasting project.
