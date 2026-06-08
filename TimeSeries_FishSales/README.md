# Time Series Analysis of Marine Fish Sales

> **ARIMA-based demand forecasting for a Gujarat-based marine fish distributor**

## Overview

This project applies classical time series methods to forecast monthly marine fish sales for Nirma Sales, a Gujarat-based distributor. The analysis covers trend decomposition, stationarity testing, and ARIMA model selection — producing a calibrated forecast that can support inventory planning and procurement decisions.

---

## Methodology

**Step 1 — Data Loading & Visualisation**  
Monthly sales data loaded with `Month_Year` as the time index. Initial time plot to identify trend, seasonality, and anomalies.

**Step 2 — Cleaning**  
Missing values dropped. Data re-plotted post-cleaning to confirm integrity.

**Step 3 — Stationarity Testing**  
ADF (Augmented Dickey-Fuller) test applied. Differencing applied where required to achieve stationarity.

**Step 4 — ACF / PACF Analysis**  
Autocorrelation and Partial Autocorrelation functions plotted to guide ARIMA order selection (p, d, q).

**Step 5 — ARIMA Modelling**  
Model fitted on training split. Residual diagnostics performed to validate white-noise assumption.

**Step 6 — Train-Test Evaluation**  
Forecasts generated on held-out test set. RMSE and MAE computed to assess forecast accuracy.

**Step 7 — Forward Forecast**  
Best model used to produce multi-step ahead forecasts for planning horizon.

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python |
| Time Series | statsmodels (ARIMA, ACF, PACF) |
| Data Processing | pandas, NumPy |
| Visualisation | Matplotlib |

---

## File Structure

```
TimeSeries_FishSales/
├── TimeSeries_FishSales.ipynb    # Full analysis notebook
├── Report_1.pdf                  # Project report (methodology & findings)
└── Report_2.pdf                  # Extended analysis / appendix
```

---

## Key Outputs

- Identified the seasonal pattern in monthly sales (higher demand during festive and winter months)
- Selected optimal ARIMA(p,d,q) parameters via ACF/PACF and AIC minimisation
- Forecast accuracy benchmarked on held-out test period
- Multi-step ahead forecast produced for operational planning
