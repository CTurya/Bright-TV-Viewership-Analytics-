# BrightTV Viewership Analytics

A full data analytics case study built for a CVM (Customer Value Management) strategy presentation — covering exploratory data analysis, an interactive Databricks dashboard, and a stakeholder-ready presentation deck.

**Business objective:** Provide BrightTV's CVM team with data-driven insights to grow the subscription base, identify what drives content consumption, and recommend strategies to boost engagement on low-activity days.

---

## Project Overview

| Deliverable | Description |
|---|---|
| [`presentation/BrightTV_Presentation.pptx`](presentation/BrightTV_Presentation.pptx) | 14-slide, 20-minute executive presentation answering all 4 case study questions |
| [`dashboard/BrightTV_Dashboard.html`](dashboard/BrightTV_Dashboard.html) | Interactive HTML analytics dashboard |
| [`eda/BrightTV_EDA_Report.md`](eda/BrightTV_EDA_Report.md) | Full written exploratory data analysis |
| [`sql/brighttv_clean_view.sql`](sql/brighttv_clean_view.sql) | Final Databricks SQL view — cleaned, joined, UTC→SAST converted |
| [`sql/exploration_queries.sql`](sql/exploration_queries.sql) | Initial data exploration queries |
| [`gantt/BrightTV_Gantt_Chart.png`](gantt/BrightTV_Gantt_Chart.png) | 14-day project plan Gantt chart |
| [`eda/BrightTV_Project_Plan.md`](eda/BrightTV_Project_Plan.md) | Full 6-phase project plan and work breakdown |

---

## Case Study Questions Answered

1. **User & usage trends** — Who's watching, when, and how much (sessions, demographics, channel performance)
2. **Factors influencing consumption** — Content type, day of week, time of day, demographics, geography
3. **Low-consumption day content strategy** — Monday-specific content recommendations backed by viewing data
4. **Growth initiatives** — Strategies to grow BrightTV's subscriber base, including underserved segments

---

## Tools & Technologies

- **Databricks SQL** — data cleaning, transformation, and view creation
- **Databricks Dashboards** — interactive analytics dashboard 
- **PowerPoint** — executive presentation deck
- **Miro** — EDA report and project documentation
- **Microsoft Excel** - Data anlysis and Pivot tables
- **Data Storytelling** - Visualizations
- **Canva**- Project Plan / Gantt Chart

---

## Dataset

The dataset consists of two tables:
- **User Profiles** (5,375 rows) — demographics: age, gender, race, province, contact info
- **Viewership Transactions** (10,000 rows) — session-level data: channel, timestamp (UTC), duration

All timestamps were converted from UTC to South African Standard Time (SAST, UTC+2) as required by the case study brief.

---

### Exploratory Data Analysis

I used Miro to document all of the below:

| Business Question        | Analysis                |
| ------------------------ | ----------------------- |
| Who are our users?       | Gender, Age             |
| When do they watch?      | Day, Hour, Month        |
| What do they watch?      | Content, Genre          |
| What drives consumption? | User Segment Analysis   |
| What should we promote?  | Content Recommendations |
| How do we grow?          | Growth Initiatives      |
---

## Key Findings

- **+119% session growth** from January to March 2016
- **Sports content drives 48%** of all watch time — high dependency risk
- **Monday is the weakest day** — 43% fewer sessions than Friday
- **Only 12% of users are female** vs ~51% of the SA population — major growth opportunity
- **989 registered users never watched** — a low-cost re-engagement opportunity

---
### Dashboard Development

Created an interactive Databricks dashboard containing:

* Executive Summary
* User Trends
* Consumption Drivers
* Business Recommendations
---
### Consumption Drivers

* Determined factors associated with higher consumption
* Compared engagement across user segments
* Evaluated content performance  
---

### Low Consumption Opportunities

* Identified periods with lower engagement
* Recommended content categories to increase viewership during off-peak periods
---

## Business Recommendations

1. Promote high-performing content during low-consumption periods.
2. Implement personalized content recommendations.
3. Launch referral campaigns to acquire new subscribers.
4. Introduce retention campaigns targeting less active users.
5. Use targeted marketing based on user behaviour patterns.

----

## 👤 Author

**Charlotte Turya**  
Data Analyst | Information Management Consultant  
[LinkedIn](https://www.linkedin.com/in/charlotte-t-457bb8200/) · [GitHub](https://github.com/CTurya)
















