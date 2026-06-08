# Portfolio Optimization — Markowitz Model & Monte Carlo Simulation

> **Constructing the efficient frontier for a 5-stock Indian equity portfolio using Modern Portfolio Theory**

## Overview

This project applies the Markowitz Mean-Variance framework to identify optimal portfolios from a set of five NSE-listed stocks: Reliance Industries, HDFC Bank, TCS, Quant Mid Cap, and CIPLA. A Monte Carlo simulation generates thousands of random weight allocations to trace the efficient frontier, from which the Maximum Sharpe Ratio and Minimum Volatility portfolios are extracted.

---

## Methodology

**Step 1 — Data & Preprocessing**  
Historical price data retrieved and cleaned. Daily log returns computed. Annualised return and covariance matrix constructed.

**Step 2 — Equal-Weight Baseline**  
Portfolio performance evaluated with uniform weights to establish a naive benchmark.

**Step 3 — Monte Carlo Simulation**  
10,000+ random weight vectors generated (summing to 1.0). For each allocation, annualised return, volatility, and Sharpe Ratio computed.

**Step 4 — Efficient Frontier**  
All simulated portfolios plotted in return–volatility space. Two key portfolios identified:
- **Maximum Sharpe Ratio Portfolio** — best risk-adjusted return
- **Minimum Variance Portfolio** — lowest possible volatility

**Step 5 — Excel Implementation**  
Full model replicated in Excel using Solver for cross-validation and accessibility.

---

## Stocks Covered

| Stock | Sector |
|---|---|
| Reliance Industries | Energy / Conglomerate |
| HDFC Bank | Banking |
| TCS | IT Services |
| Quant Mid Cap | Mid-Cap Fund |
| CIPLA | Pharmaceuticals |

---

## Key Concepts

- **Sharpe Ratio** = (Portfolio Return − Risk-Free Rate) / Portfolio Std Dev
- **Efficient Frontier** = set of portfolios with maximum return for each level of risk
- **Diversification benefit** = portfolios with mixed weights outperform equal-weight on risk-adjusted basis when assets are imperfectly correlated

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python, Excel |
| Libraries | pandas, NumPy, Matplotlib |
| Financial | yfinance (data), Markowitz MPT |
| Optimisation | Monte Carlo (Python), Solver (Excel) |

---

## File Structure

```
├── Portfolio Optimization.ipynb           # Full Python implementation
├── Portfolio Optimization.xlsx            # Excel model with Solver
└── PortfolioOptimization_UsingExcel.pptx  # Slide deck walkthrough
```

---

## Key Output

The Monte Carlo scatter plot visualises thousands of simulated portfolios in risk-return space, with the efficient frontier clearly demarcated. The optimal Sharpe portfolio typically concentrates weight toward low-correlation assets — demonstrating the quantitative case for diversification.
