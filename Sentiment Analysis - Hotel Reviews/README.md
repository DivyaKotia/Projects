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

**Step 4 — Sentiment Scoring (NLTK VADER)**  
Polarity scores computed per review using `SentimentIntensityAnalyzer`. Compound score used to derive a binary sentiment label (`pos`/`neg`), validated against star ratings. This VADER-derived label is the primary sentiment signal used in the EDA and insight stages below.

**Step 5 — Supervised Classification (separate experiment)**  
As a secondary experiment, the VADER-derived labels were also used to train supervised classifiers — Logistic Regression and Random Forest — across multiple text vectorisation approaches (Bag-of-Words via `CountVectorizer`, and TF-IDF via `TfidfVectorizer`, both unigram and bigram), to test whether a trained model could reproduce VADER's sentiment labelling from raw text alone.

**Step 6 — Vectorisation**  
Bag-of-Words (`CountVectorizer`, unigram and bigram) and TF-IDF (`TfidfVectorizer`, word-level and n-gram) compared independently as feature representations for the classification experiment above.

**Step 7 — Classification Models**  
Logistic Regression and Random Forest trained across all vectorisation variants, evaluated via 5-fold cross-validation. Random Forest hyperparameters (`max_depth`, `max_features`, `min_samples_split`, `n_estimators`) tuned via `GridSearchCV`.

**Step 8 — Insights**  
Theme-level sentiment breakdown via word frequency and word clouds. Negative review clusters mapped to specific service failure points.

**Known limitation:** the dataset carries a class imbalance (skewed toward positive reviews) that was identified but not corrected for — noted here rather than omitted, since it affects how much weight the classification accuracy figures below should be given.

---

## Tech Stack

| Category | Tools |
|---|---|
| Language | Python |
| NLP | NLTK (VADER, stopwords, lemmatisation) |
| ML | Scikit-learn (Logistic Regression, Random Forest, GridSearchCV) |
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

- Sentiment distribution across the review corpus, cross-checked against star ratings
- Word clouds contrasting positive and negative review vocabulary
- **Classification experiment:** Logistic Regression and Random Forest, cross-validated, achieved **84–87% accuracy** at reproducing VADER's own sentiment label (the classifier's target variable was VADER's compound-score-derived label, not an independent human or star-rating ground truth) — consistent across Bag-of-Words and TF-IDF feature representations. This measures how well a trained model can recover VADER's rule-based labelling from raw text, not independent classification accuracy against ground truth.
- Actionable insight report: which service dimensions drive negative sentiment most strongly
