#  Netflix Titles SQL Analysis Project

This project contains a full SQL-based exploration and analysis of Netflix's content library dataset using the `netflix_titles.csv` file.

##  Dataset Overview
- **Source**: Netflix via Kaggle ([Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows))
- **File**: `netflix_titles.csv`
- **Records**: ~8800+ titles
- **Fields**: show ID, type, title, director, cast, country, date added, release year, rating, duration, listed_in, description

## 🛠 Tools Used
- **MySQL** – For all SQL analysis and data cleaning
- **Tableau** – For building interactive dashboards and insights visualization

##  Analysis Workflow

###  1. Data Cleaning
- Removed duplicates based on title, type, and release year.
- Filled NULL or blank values with 'Unknown'.
- Standardized and extracted date fields.

###  2. Feature Engineering
- Added `year_added` column from `date_added` for trend analysis.

###  3. Exploratory Data Analysis (EDA)
- Movie vs TV Show breakdown
- Titles added per year
- Top countries by content
- Common content ratings
- Popular genres
- Average movie length
- Season counts for TV Shows
- Most frequent directors
- Multi-genre content detection

###  4. Key Insights
- Netflix hosts more movies than TV shows.
- USA and India dominate content contribution.
- Ratings like TV-MA and TV-14 are the most common.
- Drama, Comedy, and Documentary dominate the genre landscape.
- Average movie duration is ~95 minutes.
- Most TV Shows are single-season.

##  Files in This Repository
- `netflix_analysis.sql` – Full SQL analysis with inline insights.
- `README.md` – Project documentation.
- `netflix_titles.csv` – Original dataset (optional).

##  Dashboard (Created in Tableau)
**Visual Suggestions**:
- Pie chart for Movie vs TV Show
- Line chart for Titles added by year
- Bar chart for Country-wise content count
- Pie chart for content rating distribution
- Word cloud / bar for genre frequency
- Histogram for TV Show season distribution
- KPI card for average movie duration
- Top 10 most frequent directors

## 👨‍💻 Author
**Anubhav Sharma**  
 | MySQL • Tableau   
*Project Management | Data Analytics | Dashboard Design*

---

