# AirBnb Data Engineering Project

## Project Overview
This project implements a comprehensive data engineering pipeline using **DBT** (Data Build Tool) and **Snowflake**. It processes AirBnb data, transforming raw source data into actionable insights through a structured multi-layer medallion architecture.

## Tech Stack
- **Language**: Python
- **Transformation**: DBT (Data Build Tool)
- **Data Warehouse**: Snowflake
- **Dependency Management**: uv / pip
- **Cloud Storage**: AWS S3
- **Key DBT Features**: 
    - Incremental models
    - Snapshots (SCD Type 2)
    - Custom macros
    - Jinja templating
    - Data tests

## Architecture
### Medallion Architecture

#### 🥉 Bronze Layer (Raw Data)
Raw data ingested from staging with minimal transformations:
- `bronze_bookings` - Raw booking transactions
- `bronze_hosts` - Raw host information
- `bronze_listings` - Raw property listings

#### 🥈 Silver Layer (Cleaned Data)
Cleaned and standardized data:
- `silver_bookings` - Validated booking records
- `silver_hosts` - Enhanced host profiles with quality metrics
- `silver_listings` - Standardized listing information with price categorization

#### 🥇 Gold Layer (Analytics-Ready)
Business-ready datasets optimized for analytics:
- `obt` (One Big Table) - Denormalized fact table joining bookings, listings, and hosts
- `fact` - Fact table for dimensional modeling
- Ephemeral models for intermediate transformations

### Snapshots (SCD Type 2)
Slowly Changing Dimensions to track historical changes:
- `dim_bookings` - Historical booking changes
- `dim_hosts` - Historical host profile changes
- `dim_listings` - Historical listing changes

## Data Model
The core data model consists of three main entities:

-   **Hosts**: Information about AirBnb hosts (id, name, superhost status, etc.).
-   **Listings**: Details required for each property (location, room type, price, etc.).
-   **Bookings**: Transactional data for reservations (nights booked, fees, status, etc.).

## Getting Started

### Prerequisites
-   Python 3.10+
-   A Snowflake account with appropriate permissions.
-   `dbt` installed via `pip` or `uv`.
-   AWS credentials configured for S3 access.

### Installation
1.  Clone the repository:
    ```bash
    git clone <repository-url>
    cd airbnb-project
    ```

2. Create Virtual Environment
   ```bash
   python -m venv .venv
   .venv\Scripts\Activate.ps1  # Windows PowerShell
   # or
   source .venv/bin/activate    # Linux/Mac
   ```

3.  Install dependencies:
    ```bash
    # Using pip
    pip install .

    # OR using uv
    uv sync
    ```
    
    **Core Dependencies:**
    - `dbt-core>=1.11.2`
    - `dbt-snowflake>=1.11.0`


4. **Set Up Snowflake Database**
   
   Run the DDL scripts to create tables:
   ```bash
   # Execute DDL/ddl.sql in Snowflake to create staging tables
   ```

5. **Load Source Data**
   
   Load CSV files from `SourceData/` to Snowflake staging schema:
   - `bookings.csv` → `AIRBNB.STAGING.BOOKINGS`
   - `hosts.csv` → `AIRBNB.STAGING.HOSTS`
   - `listings.csv` → `AIRBNB.STAGING.LISTINGS`


## Usage

### Running dbt Commands

1. **Test Connection**
   ```bash
   cd AirBnb_DE_Project
   dbt debug
   ```

2. **Install Dependencies**
   ```bash
   dbt deps
   ```

3. **Run All Models**
   ```bash
   dbt run
   ```

4. **Run Specific Layer**
   ```bash
   dbt run --select bronze.*      # Run bronze models only
   dbt run --select silver.*      # Run silver models only
   dbt run --select gold.*        # Run gold models only
   ```

5. **Run Tests**
   ```bash
   dbt test
   ```

6. **Run Snapshots**
   ```bash
   dbt snapshot
   ```

7. **Generate Documentation**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

8. **Build Everything**
   ```bash
   dbt build  # Runs models, tests, and snapshots
   ```

## 🎯 Key Features

### 1. Incremental Loading
Bronze and silver models use incremental materialization to process only new/changed data:
```sql
{{ config(materialized='incremental') }}
{% if is_incremental() %}
    WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}
```

### 2. Custom Macros
Reusable business logic:
- **`tag()` macro**: Categorizes prices into 'low', 'medium', 'high'
  ```sql
  {{ tag('CAST(PRICE_PER_NIGHT AS INT)') }} AS PRICE_PER_NIGHT_CATEGORY
  ```

### 3. Dynamic SQL Generation
The OBT (One Big Table) model uses Jinja loops for maintainable joins:
```sql
{% set configs = [...] %}
SELECT {% for config in configs %}...{% endfor %}
```

### 4. Slowly Changing Dimensions
Track historical changes with timestamp-based snapshots:
- Valid from/to dates automatically maintained
- Historical data preserved for point-in-time analysis

### 5. Schema Organization
Automatic schema separation by layer:
- Bronze models → `AIRBNB.BRONZE.*`
- Silver models → `AIRBNB.SILVER.*`
- Gold models → `AIRBNB.GOLD.*`
