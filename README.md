# AirBnb Data Engineering Project

## Project Overview
This project implements a comprehensive data engineering pipeline using **dbt** (data build tool) and **Snowflake**. It processes AirBnb data, transforming raw source data into actionable insights through a structured multi-layer architecture.

## Tech Stack
- **Language**: Python
- **Transformation**: dbt (data build tool)
- **Data Warehouse**: Snowflake
- **Dependency Management**: uv / pip

## Architecture
The project follows a standard Medallion Architecture:

1.  **Bronze Layer (Raw)**: Raw data ingestion from source files.
2.  **Silver Layer (Cleaned)**: Data cleaning, type casting, and standardization.
3.  **Gold Layer (Aggregated)**: Business-level aggregates and metrics ready for analysis.

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

### Installation
1.  Clone the repository:
    ```bash
    git clone <repository-url>
    cd airbnb-project
    ```

2.  Install dependencies:
    ```bash
    # Using pip
    pip install .

    # OR using uv
    uv sync
    ```

### Configuration
1.  Configure your `profiles.yml` (usually in `~/.dbt/`) to connect to your Snowflake instance.
2.  Ensure the profile name in `dbt_project.yml` matches your configuration.

### Running the Project
1.  Navigate to the dbt project directory:
    ```bash
    cd AirBnb_DE_Project
    ```

2.  Run the dbt models:
    ```bash
    dbt run
    ```

3.  Run data tests:
    ```bash
    dbt test
    ```
