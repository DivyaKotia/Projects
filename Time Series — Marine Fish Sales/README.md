# Time Series Analysis of Marine Fish Sales

> **ARIMA-based demand forecasting for a Gujarat-based marine fish distributor**

## Overview

This project applies classical time series methods to forecast monthly marine fish sales for a Gujarat-based distributor. The analysis covers trend decomposition, stationarity testing, and ARIMA/SARIMA model selection — producing a calibrated forecast that can support inventory planning and procurement decisions.

---

## Methodology

**Step 1 — Data Loading & Visualisation**  
Monthly sales data loaded with `Month_Year` as the time index. Initial time plot to identify trend, seasonality, and anomalies.

**Step 2 — Cleaning**  
Missing values dropped. Data re-plotted post-cleaning to confirm integrity.

**Step 3 — Stationarity Testing**  
ADF (Augmented Dickey-Fuller) test applied. Differencing applied where required to achieve stationarity.

**Step 4 — ACF / PACF Analysis**  
Autocorrelation and Partial Autocorrelation functions plotted to guide ARIMA order selection (p, d, q). Oscillating ACF pattern suggested seasonal effects, though AR/MA structure could not be confidently finalised from ACF/PACF alone — motivating the move to more advanced models below.

**Step 5 — Seasonal Index & Trend Baseline**  
Monthly seasonal indices computed directly from the data: **October showed the largest seasonal increase (+52,642)**, **February the largest seasonal decrease (−90,807)** — confirming a strong, recurring seasonal cycle. A least-squares linear trend line fit to the raw series returned **R² = 0.369**: trend alone explains only 37% of the variation in sales, leaving the bulk of the movement to seasonality and other drivers. This result is the direct motivation for moving to a seasonal model (SARIMA) rather than relying on trend extrapolation.

**Step 6 — ARIMA Modelling**  
Baseline ARIMA(1,1,1) fitted on training split. Residual diagnostics performed to validate white-noise assumption.

**Step 7 — Seasonal Decomposition & SARIMA**  
Multiplicative seasonality identified in the sales pattern via decomposition (`yₜ = Tₜ + Sₜ + Cₜ + eₜ`). SARIMA(2,1,3)(0,1,1,12) fitted to capture the seasonal component the baseline ARIMA and the linear trend model both missed.

**Step 8 — Train-Test Evaluation**  
Forecasts generated on held-out test set. RMSE, MAE, MAPE, and R² computed to assess forecast accuracy (full comparison below).

**Step 9 — Forward Forecast**  
Best model used to produce multi-step ahead forecasts for planning horizon.

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python |
| Time Series | statsmodels (ARIMA, SARIMA, ACF, PACF) |
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

## Data Constraint

The dataset spans 96 monthly observations, reduced to **65 usable points** after removing months with genuine zero sales — these are not missing-data artifacts but real gaps caused by the seasonal fishing prohibition during monsoon months. This is a structural feature of the business, not noise to be imputed: any model trained on this data has to forecast around real, recurring no-sales windows from a comparatively small sample. The metrics below should be read against that constraint — 65 points is a thin base for estimating a 12-month seasonal cycle with confidence.

---

## Model Evaluation

| Metric | ARIMA(1,1,1) | SARIMA(2,1,3)(0,1,1,12) |
|---|---|---|
| AIC | 1657.66 | 1352.46 |
| MSE | 9,467,130,794.62 | 8,623,152,599.02 |
| R² | 0.219 | 0.289 |
| MAE | 78,035.74 | 80,427.09 |
| MAPE | 31.9% | 33.4% |

Results were mixed, not a clean win for either model. SARIMA improved AIC by 18.4% and explained more variance (R² 0.289 vs 0.219), reflecting a better in-sample fit to the seasonal pattern. ARIMA, however, produced lower MAE and MAPE on the held-out test set — likely because SARIMA's seasonal terms are being estimated from roughly five observed annual cycles, a thin base that limits how stable those seasonal parameters are out-of-sample.

SARIMA was selected as the operational model because the project's planning use case depends on capturing *when* demand rises and falls (the seasonal shape), not just minimising point-forecast error — but the higher MAPE (~33%) on both models is a direct consequence of the 65-point sample, not a modelling failure, and is reported here rather than smoothed over.

---

## Key Outputs

- Identified multiplicative seasonal pattern in monthly sales (higher demand during festive and winter months; zero-sales months during the monsoon fishing prohibition).
- Full model comparison (AIC, MSE, R², MAE, MAPE) detailed above — SARIMA preferred for seasonal-shape capture despite a marginally higher MAPE, given the planning use case and the 65-point data constraint.
- Multi-step ahead forecast produced for operational planning, using the SARIMA model as final.
