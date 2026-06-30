# BrightTV Viewership Analytics — Project Plan
**Project:** CVM Viewership Analytics & Growth Strategy  
**Client:** BrightTV CEO / Customer Value Management Team  
**Deliverable:** 20-minute executive presentation + supporting analysis  
**Objective:** Grow BrightTV subscription base for the current financial year

---

## Project Overview

| Item | Detail |
|---|---|
| Project Sponsor | BrightTV CEO |
| Primary Stakeholder | CVM (Customer Value Management) Team |
| Analyst | Data Analytics Consultant |
| Data Sources | User Profiles dataset + Viewership Transactions dataset |
| Presentation Length | 20 minutes |
| Timeline | 2-week sprint (typical consulting engagement) |

---

## Scope of Work

The engagement covers four core analytical questions:

1. User and usage trend insights
2. Factors that influence content consumption
3. Content recommendations for low-consumption days
4. Initiatives to grow BrightTV's subscriber base

---

## Work Breakdown Structure

### Phase 1: Data Ingestion & Quality Assessment (Days 1–2)

| Task | Owner | Output |
|---|---|---|
| Receive and review raw datasets | Analyst | Confirmed file receipt |
| Audit data structure (columns, types, nulls) | Analyst | Data dictionary |
| Identify and document quality issues | Analyst | DQ issue log |
| UTC → SAST timezone conversion | Analyst | Clean transformed dataset |
| Resolve UserID discrepancy (UserID vs userid column) | Analyst | Standardised key |
| Handle incomplete profiles (Age = 0, None fields) | Analyst | Flagged records |

**Milestone:** Clean, analysis-ready dataset ✓

---

### Phase 2: Exploratory Data Analysis (Days 3–5)

| Task | Owner | Output |
|---|---|---|
| User profile analysis (age, gender, province, race) | Analyst | Demographic summary |
| Viewership KPIs (sessions, watch time, avg duration) | Analyst | KPI table |
| Day-of-week consumption pattern | Analyst | DOW breakdown |
| Hourly viewing pattern (SAST) | Analyst | Peak hour analysis |
| Monthly trend analysis (Jan–Mar) | Analyst | Growth trend |
| Channel performance (sessions + watch time) | Analyst | Channel rankings |
| Cross-dimension analysis (age × channel, province × consumption) | Analyst | Segment insights |
| User segmentation (frequency, recency, depth of viewing) | Analyst | User segments |
| Inactive user identification (registered, never watched) | Analyst | Re-engagement list |

**Milestone:** EDA complete, key insights documented ✓

---

### Phase 3: Insight Development & Hypothesis Validation (Days 6–8)

| Task | Owner | Output |
|---|---|---|
| Identify top consumption drivers | Analyst | Factor analysis |
| Monday low-consumption root cause investigation | Analyst | Root cause note |
| Content gap analysis vs consumption preferences | Analyst | Content gap map |
| Benchmark against SA streaming market (contextual) | Analyst | Market context |
| Draft 6–8 strategic recommendations | Analyst | Recommendation deck |
| Prioritise recommendations by impact & feasibility | Analyst | Prioritisation matrix |

**Milestone:** Validated insights and recommendation set ✓

---

### Phase 4: Dashboard & Visualisation Build (Days 7–9)

| Task | Owner | Output |
|---|---|---|
| Define KPI cards (sessions, viewers, watch time, channels) | Analyst | KPI layout |
| Build Day-of-Week and Hourly charts | Analyst | Interactive charts |
| Build Channel Performance chart | Analyst | Bar/horizontal chart |
| Build Monthly Growth chart | Analyst | Trend chart |
| Build Demographic breakdown (age, gender, province) | Analyst | Distribution charts |
| Add insight annotations to each visual | Analyst | Annotated dashboard |
| Final dashboard QA and styling | Analyst | Polished dashboard |

**Milestone:** Interactive analytics dashboard complete ✓

---

### Phase 5: Presentation Development (Days 9–11)

| Task | Owner | Output |
|---|---|---|
| Design slide structure (20 min = ~12–15 slides) | Analyst | Slide outline |
| Slide 1–2: Executive summary & business context | Analyst | Intro slides |
| Slide 3–5: User profile & demographic insights | Analyst | User section |
| Slide 6–8: Viewership trends & consumption patterns | Analyst | Trend section |
| Slide 9–10: Factors influencing consumption | Analyst | Drivers section |
| Slide 11–12: Monday fix — content recommendations | Analyst | Content recs |
| Slide 13–15: Growth initiatives for subscriber base | Analyst | Growth recs |
| Stakeholder review & feedback incorporation | CVM Team + Analyst | Revised deck |
| Final polish & rehearsal timing check | Analyst | Final presentation |

**Milestone:** 20-minute presentation ready to deliver ✓

---

### Phase 6: Presentation Delivery (Day 12–14)

| Task | Owner |
|---|---|
| Pre-meeting technical check (slides, dashboard) | Analyst |
| Deliver 20-minute presentation to CEO & CVM team | Analyst |
| Q&A session (allow 10 min buffer after presentation) | Analyst + CVM |
| Distribute EDA report and dashboard to stakeholders | Analyst |
| Agree on next steps / follow-on analysis scope | CVM Team |

---

## Presentation Structure (20 Minutes)

| Segment | Duration | Content |
|---|---|---|
| Opening & Context | 2 min | Business objective, data overview, methodology |
| User Profile Insights | 3 min | Demographics: age, gender, province, inactive users |
| Usage Trends | 4 min | Sessions over time, day of week, hourly peaks, monthly growth |
| Consumption Drivers | 3 min | Sports dependency, genre preferences, time-of-day, demographics |
| Monday Content Fix | 3 min | Low-day diagnosis + 4 specific content recommendations |
| Growth Initiatives | 4 min | 4 strategic initiatives to grow subscriber base |
| Summary & Next Steps | 1 min | Key takeaways, recommended quick wins |

---

## Key Questions the Presentation Answers

| # | Question | Answered In |
|---|---|---|
| 1 | What are the user and usage trends? | Slides 3–8, Dashboard |
| 2 | What factors influence consumption? | Slide 9–10 |
| 3 | What content for low-consumption days? | Slide 11–12 |
| 4 | What initiatives grow the user base? | Slide 13–15 |

---

## Assumptions & Dependencies

- Dataset is a representative sample of the actual subscriber base (not anonymised subset)
- UTC+2 offset applies uniformly (no DST adjustment needed for SA)
- "Consumption" = session count and watch duration (not unique viewers per day)
- Financial year aligns with calendar year (Jan–Dec)
- Any additional external data (e.g. SA census demographics, streaming market benchmarks) will be sourced independently to enrich the presentation

---

## Risk Register

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Data completeness gaps (920 incomplete profiles) | High | Medium | Flag in EDA, exclude from demographic analysis, note as data quality issue |
| Sports seasonality skews March data | High | Medium | Separate sports-driven vs organic growth in trend analysis |
| Short Q1 period limits trend confidence | Medium | Medium | Note limitations, recommend tracking full 12-month cycle |
| Stakeholder scope creep during Q&A | Low | Low | Prepare "parking lot" list for post-presentation follow-up |

---

## Deliverables Checklist

- [x] EDA Report (written analysis with findings and recommendations)
- [x] Interactive Analytics Dashboard (HTML — shareable, no software required)
- [x] Project Plan (this document)
- [ ] Executive Presentation Deck (PowerPoint — 12–15 slides, 20 min)
- [ ] CVM Recommendation Summary (1-page executive summary)

---

*BrightTV CVM Analytics Project · Consultant Engagement · Q1 2016 Data*
