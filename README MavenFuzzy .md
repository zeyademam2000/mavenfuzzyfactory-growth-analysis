# mavenfuzzyfactory-growth-analysis
End-to-end e-commerce growth analysis using MySQL &amp; Power BI — built at DEBI Business Analytics Hackathon 2026.
# 🧸 MavenFuzzyFactory Growth Analysis — Business Analytics Hackathon

A full end-to-end business analytics project analyzing the growth of an e-commerce company (MavenFuzzyFactory) — covering data quality, traffic channels, conversion funnels, product performance, and strategic recommendations.

Built by **Team 12** during the **DEBI Business Analytics Hackathon (March 2026)**.

---

## 🔗 Live Dashboard

👉 **[View Interactive Power BI Dashboard](https://app.powerbi.com/view?r=eyJrIjoiNGE4MzBhYzAtMzdkOS00MzU0LTk3MTQtZGIwMjQ0MWE4MTJhIiwidCI6ImRmODY3OWNkLWE4MGUtNDVkOC05OWFjLWM4M2VkN2ZmOTVhMCJ9)**

---

## 📊 Project Overview

MavenFuzzyFactory is a fictional e-commerce company selling stuffed animals. This project analyzes **3+ years of data** (2012–2015) to build a growth narrative for an investor presentation — answering the question:

> *"How has the business grown, and where should we invest next?"*

---

## 🗂️ Project Structure

```
├── team_12_presentation.pptx   → Full investor presentation (21 slides)
├── team_12_checking.sql        → Data quality audit queries
└── team_12_cleaned_views.sql   → Cleaned SQL views for analysis
```

---

## 🔍 Key Findings

### 📈 Growth Story
- Revenue per session grew from **$1.57** (Q1 2012) → **$5.12** (Q1 2015) — 226% increase
- Conversion rate improved from **3.14%** → **8.42%**
- Revenue per order increased from **$49.99** → **$60.89**

### 📣 Channel Mix
- **Gsearch nonbrand** dominates traffic — ~75% of new sessions
- **28.87%** of revenue comes from brand/direct/organic — unaffected if paid ads doubled
- Brand awareness and organic traffic growing steadily over time

### 🛒 Conversion Funnel
| Funnel Step | Sessions | Drop-off |
|---|---|---|
| Base | 266,356 | — |
| Products | 149,089 | 44% ⬇️ |
| Cart | 54,038 | 20% ⬇️ |
| Billing | 29,451 | 2.66% ⬇️ |
| **Thank You** | **18,304** | **6.87% conversion** |

> 💡 A 10% improvement at the Billing step = **+$77.5K/month** in additional revenue

### 🧸 Top Product
**The Original Mr. Fuzzy** — highest revenue (~$170K), highest margin, and top priority product

---

## 🧹 Data Quality Audit

Before any analysis, we ran a full SQL data quality check:

| Issue | Records | Action |
|---|---|---|
| Invalid Prices (zero/negative) | 8 orders | Excluded |
| Cost > Price | 3 orders | Excluded |
| Impossible Timestamps | 7 pageviews | Excluded |
| Fake Test Products (ID 99) | Multiple | Excluded |
| Price Errors (Products 3 & 4) | Multiple | Corrected to $49.99 & $24.99 |
| Text Inconsistencies | Multiple fields | Trimmed & lowercased |

---

## 💡 Strategic Recommendations

1. **Fix Billing Page UX** → Biggest revenue leak, proven by A/B test (billing-2 outperformed billing)
2. **Increase acquisition bids on Gsearch** → Repeat customers return organically, so CLV is higher than it appears
3. **Diversify traffic channels** → Reduce 75% dependency on Gsearch
4. **Strict QA with supplier** → Past refund spikes tied to Mr. Fuzzy defects

### 💰 $100K Budget Allocation
See slide 19 in the presentation for the full budget breakdown.

---

## 🛠️ Tools Used

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)

- **MySQL** — Data quality checks, cleaning, and analytical views
- **Power BI** — Interactive dashboard and data storytelling

---

## 👥 Team 12

| Name | ID |
|---|---|
| Jana Mohamed Gomaa | BA2614049 |
| Toka Mohamed Hassan | BA2614100 |
| Yousef Ahmed Mohamed | BA2614102 |
| Nour Gomaa Abdel Sadek | BA2614084 |
| **Zeyad Emam Mostafa** | BA2614105 |

---

## 👤 My Profile

**Zeyad Emam Mostafa**
📍 Cairo, Egypt
🔗 [LinkedIn](https://www.linkedin.com/in/zeyademam) | 🐙 [GitHub](https://github.com/zeyademam2000)

---

*Presented at the DEBI Business Analytics Hackathon — March 2026*

