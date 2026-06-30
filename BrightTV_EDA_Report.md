# BrightTV Viewership — Exploratory Data Analysis Report
**Prepared for:** CVM Team Presentation  
**Data Period:** January – March 2016 (UTC → SAST, UTC+2)  
**Analyst:** Data Analytics Consultant  

---

## 1. Dataset Overview

| Dataset | Records | Key Fields |
|---|---|---|
| User Profiles | 5,375 rows | UserID, Name, Gender, Race, Age, Province |
| Viewership (Transactions) | 10,000 rows | UserID, Channel, RecordDate (UTC), Duration |

**Note:** All timestamps converted from UTC to South African Standard Time (SAST = UTC+2) as required.

---

## 2. Data Quality Findings

### User Profiles
- **920 incomplete profiles** (Age = 0, Name/Surname/Gender/Province = None) — 17% of total user base. These are likely registered but unverified accounts.
- **Gender imbalance in data**: 88% male, 12% female among profiled users. Significant female data gap — possibly registration friction or under-served audience.
- **Age range**: 9 to 114 years (one outlier at 114 — likely data entry error). Core IQR: 26–39 years.
- **Race field**: Contains "None" values — not all users provided this demographic.

### Viewership Transactions
- **Duplicate UserID column** (`UserID` and `userid`) — values differ on some records. Used `UserID` (uppercase) as primary key throughout.
- **Duration field** stored as string (HH:MM:SS) — converted to decimal minutes for all calculations.
- **Session-level granularity**: Each row = 1 viewing session. Users can have multiple sessions per day.

---

## 3. User Profile Analysis

### 3.1 Geographic Distribution

| Province | Users | % Share |
|---|---|---|
| Gauteng | 1,704 | 38.2% |
| Western Cape | 791 | 17.7% |
| KwaZulu-Natal | 480 | 10.8% |
| Mpumalanga | 420 | 9.4% |
| Limpopo | 368 | 8.3% |
| Eastern Cape | 287 | 6.4% |
| North West | 161 | 3.6% |
| Free State | 156 | 3.5% |
| Northern Cape | 86 | 1.9% |

**Insight:** Gauteng dominates — expected given population density. However, KZN (10.8% users), Eastern Cape (6.4%), and Free State (3.5%) are potentially underpenetrated given their actual population share in SA.

### 3.2 Age Distribution

| Age Group | Users | % Share |
|---|---|---|
| < 18 | 124 | 2.8% |
| 18–24 | 638 | 14.3% |
| 25–34 | 1,894 | 42.5% |
| 35–44 | 1,215 | 27.3% |
| 45–54 | 454 | 10.2% |
| 55+ | 130 | 2.9% |

**Insight:** The 25–44 bracket accounts for ~70% of all profiled users. The youth segment (18–24) is present but relatively small, while the 55+ market is almost untapped.

### 3.3 Gender

- **Male:** 3,916 (88%)  
- **Female:** 537 (12%)  

**Insight:** This is a significant red flag — either the platform skews heavily male, or female users are not completing registration. Given that South Africa is ~51% female, this represents a major growth opportunity.

---

## 4. Viewership / Consumption Analysis

### 4.1 Overall Metrics

| Metric | Value |
|---|---|
| Total sessions | 10,000 |
| Unique viewers in period | 4,386 |
| Non-viewing registered users | ~989 (profiled, never watched in period) |
| Total watch time | 89,893 mins (≈ 1,498 hours) |
| Average session duration | 9.4 minutes |
| Median sessions per user | 1 (highly skewed — power users drag average up) |
| Max sessions (single user) | 37 sessions |

### 4.2 Sessions by Day of Week

| Day | Sessions | Avg Duration (mins) |
|---|---|---|
| Monday | 957 | 7.4 |
| Tuesday | 1,322 | 9.4 |
| Wednesday | 1,553 | 9.2 |
| Thursday | 1,441 | 10.0 |
| Friday | 1,675 | 9.3 |
| Saturday | 1,633 | **11.2** |
| Sunday | 1,419 | 8.6 |

**Key Finding:** Monday is the weakest day — 43% fewer sessions than Friday and the shortest average session length (7.4 mins). Saturday has both the second-highest session volume AND the highest average duration, making it the highest-quality consumption day.

### 4.3 Hourly Patterns (SAST)

Viewing splits into clear time blocks:

| Time Block | Sessions | Avg Duration |
|---|---|---|
| Late Night (00:00–05:59) | 432 | 10.2 mins |
| Morning (06:00–11:59) | 1,824 | 7.8 mins |
| Afternoon (12:00–17:59) | 3,490 | 10.8 mins |
| Evening (18:00–21:59) | 2,418 | 9.4 mins |
| Night (22:00–23:59) | 1,366 | 7.9 mins |

**Peak hours (by volume):** 17:00–20:00 SAST — aligns with after-work/school hours.  
**Highest quality (avg duration):** 12:00–17:00 — afternoon viewers stay longest per session.  
**Overnight (02:00–04:00):** Surprisingly high average duration (17 mins at 02h, 12 mins at 03h) — niche but committed audience, possibly students or shift workers.

### 4.4 Monthly Trend

| Month | Sessions | Month-on-Month Growth |
|---|---|---|
| January 2016 | 2,199 | — |
| February 2016 | 2,980 | +35.5% |
| March 2016 | 4,816 | +61.6% |

**Insight:** Strong positive growth trajectory — platform is gaining momentum. March's jump likely driven by ICC Cricket World Cup 2011 replays/events showing high viewership. The 119% growth from Jan→Mar is encouraging but needs to be validated against new subscriber acquisition data.

### 4.5 Top Channels by Total Watch Time

| Rank | Channel | Total Mins | % of All Viewing |
|---|---|---|---|
| 1 | ICC Cricket World Cup 2011 | 24,727 | 27.5% |
| 2 | Supersport Live Events | 18,791 | 20.9% |
| 3 | Channel O | 11,565 | 12.9% |
| 4 | Trace TV | 11,515 | 12.8% |
| 5 | SuperSport Blitz | 5,440 | 6.1% |
| 6 | Boomerang | 4,395 | 4.9% |
| 7 | Cartoon Network | 4,215 | 4.7% |
| 8 | CNN | 4,066 | 4.5% |
| 9 | E! Entertainment | 2,219 | 2.5% |
| 10 | Africa Magic | 1,473 | 1.6% |

**Insight:** Sports dominates — ICC Cricket + SuperSport = 48.4% of all viewing minutes. Music channels (Channel O, Trace TV) are the #2 content category at 25.7%. Children's content (Cartoon Network + Boomerang) = 9.6% — a notable and loyal niche.

---

## 5. Factors Influencing Consumption

Based on the analysis, the following factors drive viewership:

1. **Sports Events** — Live and archived cricket/football drive the highest session volumes and durations. Seasonal effects (ICC tournament in data period) heavily inflate March numbers.

2. **Day of Week** — Weekdays (especially Fri) and Saturday outperform Monday significantly. Work-from-home or leisure scheduling drives patterns.

3. **Time of Day** — Afternoon and post-work evening (15:00–20:00 SAST) are peak windows. Content strategy should prioritise this window.

4. **Age Group** — 25–44 year olds are the core. 45–54 year olds watch the longest per session (10.9 mins avg), indicating deeper engagement despite smaller numbers.

5. **Province** — Gauteng leads in volume, but Free State users show the highest average session duration (11.2 mins) — quality over quantity market.

6. **Content Genre** — Sports > Music > Kids > News > Entertainment (by watch time). Genre preferences should guide acquisition and scheduling decisions.

7. **Gender** — Male-skewed viewership aligns with sports-heavy content. Female viewership is concentrated in E! Entertainment and Africa Magic, indicating clear genre preferences if targeted.

---

## 6. Key Risks & Gaps

- **Sports dependency:** 48% of viewing tied to sports (ICC + SuperSport). When sports events end, consumption risk is high. Diversification is critical.
- **Low female engagement:** 12% of profiles, 9% of sessions — platform has not resonated with female audience.
- **Short session lengths:** Avg 9.4 mins suggests casual browsing rather than deep engagement. Binge-watching / series content could increase depth.
- **Inactive users:** ~989 registered users never watched during the period. Risk of churn before first engagement.
- **Monday drop-off:** No clear reason (no bank holidays in Jan–Mar consistently) — likely a scheduling/content gap on Mondays.

---

## 7. Recommendations Summary

### Grow the User Base
1. **Female-first content campaign** — Invest in lifestyle, drama, and reality TV genres targeting women 25–44.
2. **Provincial expansion** — Targeted marketing in KZN, Eastern Cape & Limpopo (currently underpenetrated vs population size).
3. **Youth activation** — Shorter content formats, social media integration (Trace TV / Channel O leverage) for 18–24 audience.
4. **Win-back dormant users** — Personalised re-engagement emails with curated content previews for the ~989 inactive profiles.

### Increase Consumption
5. **Monday content drops** — Exclusive Monday shows (reality/drama, music countdown, Monday sports highlights) to address the session gap.
6. **Afternoon scheduling** — Double down on 12:00–17:00 slot where dwell time is highest.
7. **Series binge strategy** — Africa Magic, M-Net, and Vuzu should anchor serialised content to increase session depth.
8. **Family viewing block** — 18:00–20:00 kids + family slot to capture the household unit, not just individual viewers.

---

*Data Source: BrightTV Dataset (User Profiles + Viewership Transactions) | Analysis Period: Q1 2016 | Times in SAST (UTC+2)*
