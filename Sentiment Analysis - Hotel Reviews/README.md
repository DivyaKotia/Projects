# Sentiment Analysis of Hotel Reviews

> **NLP pipeline for classifying Google Review sentiment to generate actionable hospitality insights**

## Overview

This project builds an end-to-end sentiment analysis pipeline on Google Reviews scraped from Hotel Kuber, Porbandar, Gujarat. The goal is to classify reviews as positive, negative, or neutral and surface specific operational themes — service quality, cleanliness, food, location — that management can act on.

---

## Methodology

**Step 1 — Web Scraping**  
Google Reviews scraped and stored in `Google_Reviews.csv`.

**Step 2 — EDA**  
Distribution of ratings, review length, frequency analysis. Word clouds for positive vs negative review corpora.

**Step 3 — Text Preprocessing**  
- Lowercasing, punctuation removal
- Stopword removal (NLTK)
- Tokenisation and lemmatisation

**Step 4 — Sentiment Scoring (TextBlob)**  
Polarity and subjectivity scores computed per review. Validated against star ratings.

**Step 5 — Vectorisation**  
Bag-of-Words representation using `CountVectorizer` for ML classification.

**Step 6 — Classification Model**  
Supervised classifier trained on labelled sentiment categories. Hyperparameter optimisation applied for best F1-score.

**Step 7 — Insights**  
Theme-level sentiment breakdown. Negative review clusters mapped to specific service failure points.

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python |
| NLP | NLTK, TextBlob |
| ML | Scikit-learn |
| Visualisation | WordCloud, Matplotlib, Seaborn |
| Data | pandas, `Google_Reviews.csv` (scraped) |
| Environment | Google Colab |

---

## File Structure

```
SentimentAnalysis/
├── BDA_SentimentAnalysis.ipynb    # Full pipeline: scraping → EDA → modelling → insights
└── Google_Reviews.csv             # Raw scraped review data
```

---

## Key Outputs

- Sentiment distribution across the review corpus
- Word clouds contrasting positive and negative review vocabulary
- Classifier with optimised hyperparameters
- Actionable insight report: which service dimensions drive negative sentiment most strongly
