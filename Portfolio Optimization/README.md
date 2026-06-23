# Portfolio Optimization — Markowitz Model & Monte Carlo Simulation

> **Constructing the efficient frontier for a 5-asset Indian portfolio using Modern Portfolio Theory and 70,000-scenario Monte Carlo simulation**

## Overview

This project implements Modern Portfolio Theory (MPT) to determine how capital should be allocated across five assets to maximise risk-adjusted return. Rather than predicting individual stock prices, the goal is allocation: generating thousands of candidate portfolios, evaluating each on return, volatility, and Sharpe Ratio, then selecting the Maximum Sharpe and Minimum Volatility portfolios from the resulting efficient frontier.

---

## Assets

| Asset | Sector |
|---|---|
| RELIANCE.NS | Energy / Conglomerate |
| HDFCBANK.NS | Banking |
| TCS.NS | Information Technology |
| GTLINFRA.NS | Telecom Infrastructure |
| GOLDCASE.NS | Gold ETF |

Deliberately diversified across equity, banking, technology, infrastructure, and a commodity hedge (gold).

---

## Methodology

**Step 1 — Data Collection**  
Adjusted Close prices downloaded via `yfinance` (23 June 2021 → present). Adjusted Close used specifically because it accounts for splits and dividends, giving a true measure of investment performance rather than raw price movement.

**Step 2 — Return Estimation**  
Daily log returns computed: `R = ln(1 + pct_change)`. Log returns preferred over simple returns for better statistical behaviour and easier time-aggregation. Annualised using 248 trading days/year.

**Step 3 — Initial Equal-Weight Portfolio**  
Baseline portfolio with 20% allocated to each of the 5 assets, computed via standard portfolio return (`Σwᵢrᵢ`) and volatility (`√(WᵀCW)`) formulas, where C is the return covariance matrix.

**Step 4 — Monte Carlo Simulation**  
**70,000 randomly weighted portfolios** generated, each respecting two constraints: no single asset above 50% allocation, and weights summing to 1. For each portfolio: annual return, annual volatility, and Sharpe Ratio computed using a **7% risk-free rate**.

**Step 5 — Portfolio Selection**  
From the 70,000 simulated portfolios, two are extracted: the Maximum Sharpe Ratio portfolio (best risk-adjusted return) and the Minimum Volatility portfolio (lowest risk, regardless of return).

**Step 6 — Efficient Frontier Visualisation**  
All 70,000 portfolios plotted (volatility on x-axis, return on y-axis, Sharpe Ratio as colour), with the two selected portfolios marked.

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python |
| Libraries | pandas, NumPy, Matplotlib, Seaborn |
| Data | yfinance |
| Method | Monte Carlo simulation, Modern Portfolio Theory |

---

## File Structure

```
├── Portfolio_Optimization.ipynb    # Full Monte Carlo MPT implementation
└── README.md
```

---

## Results

| Portfolio | Annual Return | Annual Volatility | Sharpe Ratio |
|---|---|---|---|
| **Maximum Sharpe Ratio** | 18.8% | 15.8% | 0.742 |
| **Minimum Volatility** | 3.5% | 13.3% | **−0.260** |

**Maximum Sharpe portfolio** allocated heavily toward Gold ETF (47.9%) and HDFC Bank (44.7%), with Reliance, TCS, and GTLINFRA together contributing under 8%. The optimiser identified Gold + Banking as the most efficient combination over this period — TCS and GTLINFRA added volatility without proportionate return, so the optimisation pushed their weights toward zero.

**Minimum Volatility portfolio** achieved the lowest possible risk (13.3%) through more balanced diversification (Gold 27.7%, TCS 25.9%, HDFC Bank 24.8%, Reliance 19.7%, GTLINFRA 1.9%) — but its 3.5% return sits *below* the 7% risk-free rate, producing a **negative Sharpe Ratio**. This is reported as-is rather than smoothed over: the safest portfolio in this universe was not an attractive one on a risk-adjusted basis over the study period. It illustrates a real finding of Modern Portfolio Theory — minimising volatility and maximising risk-adjusted return are not the same objective, and chasing the former without checking the latter can produce an allocation that underperforms simply holding risk-free assets.

---

## Key Findings

1. Portfolio allocation had a greater impact on outcomes than individual stock selection
2. The optimiser converged on a Gold + Banking combination for risk-adjusted return — not an intuitive pairing, but one the data supported over this window
3. Minimising volatility alone, without reference to the risk-free rate, can produce a portfolio that's "safe" but financially unattractive (negative Sharpe)
4. Monte Carlo simulation at scale (70,000 portfolios) made it possible to map the full risk-return tradeoff space rather than relying on a handful of manually chosen allocations


## Key Output

The Monte Carlo scatter plot visualises thousands of simulated portfolios in risk-return space, with the efficient frontier clearly demarcated. The optimal Sharpe portfolio typically concentrates weight toward low-correlation assets — demonstrating the quantitative case for diversification.
