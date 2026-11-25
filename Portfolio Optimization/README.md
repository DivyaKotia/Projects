# Portfolio Optimization – Markowitz Model & Monte Carlo Simulation

> **Applying Modern Portfolio Theory to a diversified 5-asset Indian portfolio using 70,000 Monte Carlo simulations to explore optimal asset allocation and risk-adjusted returns.**

## Overview

This project implements **Modern Portfolio Theory (MPT)** to explore how capital can be allocated across five financial assets to achieve different risk-return objectives.

Rather than predicting individual asset prices, the focus is on portfolio construction: generating 70,000 candidate portfolios, evaluating each based on annualised return, volatility, and Sharpe Ratio, and identifying two portfolios:

- **Maximum Sharpe Ratio Portfolio:** The portfolio offering the highest risk-adjusted return.
- **Minimum Volatility Portfolio:** The portfolio with the lowest annualised volatility.

The implementation also compares these optimised portfolios against an equally weighted portfolio to understand how asset allocation influences overall portfolio performance.

---

## Assets

| Asset | Ticker | Sector / Category |
|---|---|---|
| Reliance Industries | RELIANCE.NS | Energy / Conglomerate |
| HDFC Bank | HDFCBANK.NS | Banking |
| Tata Consultancy Services | TCS.NS | Information Technology |
| GTL Infrastructure | GTLINFRA.NS | Telecom Infrastructure |
| Nippon India ETF Gold BeES | GOLDBEES.NS | Gold ETF |

The portfolio combines equities from different sectors with gold exposure, providing an opportunity to examine the impact of diversification across different asset classes and market segments.

---

## Methodology

**Step 1 — Historical Data Collection**

Historical adjusted closing prices are downloaded using `yfinance`, starting from **1 January 2021** up to the current date.

Adjusted closing prices are used to account for corporate actions such as stock splits and dividends, providing a more representative basis for analysing historical investment performance.

**Step 2 — Cumulative Returns and Daily Return Calculation**

The historical cumulative returns of the five assets are calculated and visualised to compare their performance over the selected period.

Daily simple returns are then calculated using:

`R = data.pct_change()`

Simple returns are used instead of log returns because portfolio returns can be expressed as the weighted sum of individual asset returns.

**Step 3 — Equal-Weight Portfolio**

An equally weighted portfolio is established as a baseline, with 20% of the total investment allocated to each asset.

Portfolio return is calculated using the weighted average of individual asset returns:

`Portfolio Return = Σ(wᵢ × Rᵢ)`

Portfolio volatility is calculated using the covariance matrix:

`Portfolio Volatility = √(Wᵀ × Σ × W)`

Annualisation is based on 248 trading days per year:

- Annualised return = Average daily return × 248
- Annualised volatility = Daily volatility × √248

**Step 4 — Monte Carlo Simulation**

**70,000 randomly weighted portfolios** are generated using Monte Carlo simulation.

Each portfolio follows two allocation constraints:

- No individual asset can have a weight greater than 50%.
- The combined portfolio weights must sum to 100%.

For every simulated portfolio, the annualised return, annualised volatility, and Sharpe Ratio are calculated.

The risk-free rate is assumed to be **7%**.

**Step 5 — Portfolio Selection**

The simulated portfolios are evaluated to identify:

- **Maximum Sharpe Ratio:** The portfolio with the highest excess return per unit of volatility.
- **Minimum Volatility:** The portfolio with the lowest annualised standard deviation.

**Step 6 — Visualisation and Comparison**

The analysis includes:

- Historical cumulative returns of the five assets.
- Monte Carlo simulation scatter plot showing portfolio return against volatility, with Sharpe Ratio represented through colour.
- Annualised return comparison across the three portfolios.
- Annualised volatility comparison across the three portfolios.
- Asset allocation comparison between the two optimised portfolios.

---

## Tech Stack

| Category | Tools |
|---|---|
| Programming Language | Python |
| Libraries | pandas, NumPy, Matplotlib |
| Financial Data | yfinance |
| Methodology | Modern Portfolio Theory, Monte Carlo Simulation |
| Key Metrics | Portfolio Return, Covariance, Volatility, Sharpe Ratio |

---

## Results

The simulation produced the following results:

| Portfolio | Annual Return | Annual Volatility | Sharpe Ratio |
|---|---:|---:|---:|
| **Equal-weight** | 11.06% | 16.77% | 0.242 |
| **Minimum Volatility** | 10.50% | 12.00% | 0.290 |
| **Maximum Sharpe** | 13.90% | 14.40% | 0.476 |

*Note: Returns and volatility are annualised. The Sharpe Ratio is calculated using an assumed risk-free rate of 7%.*

### Optimal Portfolio Allocations

| Asset | Maximum Sharpe | Minimum Volatility |
|---|---:|---:|
| Gold BeES | 49.3% | 44.7% |
| Reliance Industries | 32.1% | 12.9% |
| GTL Infrastructure | 11.1% | 2.3% |
| HDFC Bank | 7.4% | 17.5% |
| TCS | 0.0% | 22.6% |

### Interpretation

The **Maximum Sharpe Ratio portfolio** achieved the highest annualised return of 13.90%, with an annualised volatility of 14.40%.

The **Minimum Volatility portfolio** achieved the lowest annualised volatility of 12.00%, with an annualised return of 10.50%.

Compared with the equally weighted portfolio, both optimised portfolios achieved lower historical volatility. However, only the Maximum Sharpe portfolio generated a higher annualised return.

These results demonstrate an important principle of Modern Portfolio Theory: minimising portfolio risk and maximising risk-adjusted return are two different optimisation objectives, and they can produce significantly different asset allocations.

---

## Key Findings

1. **Asset allocation matters:** Different combinations of weights across the same five assets produce different portfolio risk-return profiles.

2. **Risk and return involve trade-offs:** The Maximum Sharpe portfolio achieved a higher return than the Minimum Volatility portfolio, but also carried higher volatility.

3. **Diversification influences portfolio risk:** The covariance between assets plays an important role in determining overall portfolio volatility.

4. **Optimisation depends on the objective:** The portfolio with the lowest volatility is not necessarily the one with the highest risk-adjusted return.

5. **Monte Carlo simulation enables exploration:** Generating 70,000 candidate portfolios provides a practical way to examine a wide range of possible asset allocations under defined constraints.

---

## Limitations and Assumptions

- The analysis is based on historical market data; past performance does not guarantee future results.
- The risk-free rate is assumed to be 7%.
- Annualisation uses 248 trading days per year.
- Portfolio allocations are constrained to a maximum of 50% per asset.
- The Monte Carlo simulation explores randomly generated allocations and does not guarantee the global optimum.
- Transaction costs, taxes, and other investment-related expenses are not incorporated.
- The results depend on the selected assets and historical observation period.

---

## Key Output

The primary output is the Monte Carlo simulation scatter plot, which visualises the risk-return characteristics of 70,000 simulated portfolios.

Each point represents a portfolio, with annualised volatility on the x-axis, annualised return on the y-axis, and Sharpe Ratio represented by colour. The Maximum Sharpe and Minimum Volatility portfolios are highlighted to illustrate the two different optimisation objectives.

The accompanying visualisations provide further insights into historical asset performance, portfolio comparisons, and the resulting asset allocations.

---

## Repository Structure

```text
Portfolio Optimization/
│
├── Portfolio_Optimization.ipynb
│   └── Python implementation of MPT using Monte Carlo simulation
│
├── Portfolio Optimization.xlsx
│   └── Portfolio optimisation using Excel
│
├── PortfolioOptimization_UsingExcel.pptx
│   └── Presentation explaining the Excel-based implementation
│
└── README.md
```
