import os

import pandas as pd
import snowflake.connector
import streamlit as st


st.set_page_config(
    page_title="Airbnb Open Data Analytics",
    page_icon="",
    layout="wide",
)


def get_connection():
    return snowflake.connector.connect(
        account=os.environ["SNOWFLAKE_ACCOUNT"],
        user=os.environ["SNOWFLAKE_USER"],
        password=os.environ["SNOWFLAKE_PASSWORD"],
        role=os.environ.get("SNOWFLAKE_ROLE", "ACCOUNTADMIN"),
        warehouse=os.environ.get("SNOWFLAKE_WAREHOUSE", "COMPUTE_WH"),
        database=os.environ.get("SNOWFLAKE_DATABASE", "AIRBNB_ANALYTICS"),
        schema="MARTS",
    )


@st.cache_data(ttl=600)
def run_query(sql: str) -> pd.DataFrame:
    with get_connection() as conn:
        return pd.read_sql(sql, conn)


st.title("Airbnb Open Data Analytics")

neighbourhood_df = run_query(
    """
    select
        calendar_month,
        neighbourhood_group,
        neighbourhood,
        active_listings,
        available_days,
        unavailable_days,
        average_daily_price,
        estimated_unavailable_revenue,
        unavailable_rate
    from agg_neighbourhood_monthly_performance
    """
)

listing_df = run_query(
    """
    select
        listing_id,
        host_id,
        calendar_month,
        neighbourhood,
        neighbourhood_group,
        room_type,
        average_daily_price,
        estimated_unavailable_revenue,
        unavailable_rate
    from agg_listing_monthly_performance
    """
)

host_df = run_query(
    """
    select
        host_id,
        host_name,
        host_is_superhost,
        listings_in_dataset,
        host_tenure_days
    from dim_hosts
    """
)

neighbourhoods = sorted(neighbourhood_df["NEIGHBOURHOOD"].dropna().unique())
selected_neighbourhoods = st.sidebar.multiselect(
    "Neighbourhood",
    neighbourhoods,
    default=neighbourhoods[:10],
)

room_types = sorted(listing_df["ROOM_TYPE"].dropna().unique())
selected_room_types = st.sidebar.multiselect(
    "Room type",
    room_types,
    default=room_types,
)

filtered_neighbourhood = neighbourhood_df[
    neighbourhood_df["NEIGHBOURHOOD"].isin(selected_neighbourhoods)
]
filtered_listing = listing_df[listing_df["ROOM_TYPE"].isin(selected_room_types)]

total_listings = int(listing_df["LISTING_ID"].nunique())
estimated_revenue = neighbourhood_df["ESTIMATED_UNAVAILABLE_REVENUE"].sum()
avg_price = neighbourhood_df["AVERAGE_DAILY_PRICE"].mean()
avg_unavailable_rate = neighbourhood_df["UNAVAILABLE_RATE"].mean()

metric_1, metric_2, metric_3, metric_4 = st.columns(4)
metric_1.metric("Active listings", f"{total_listings:,}")
metric_2.metric("Estimated unavailable revenue", f"${estimated_revenue:,.0f}")
metric_3.metric("Average daily price", f"${avg_price:,.0f}")
metric_4.metric("Avg unavailable rate", f"{avg_unavailable_rate:.1%}")

st.subheader("Neighbourhood Monthly Performance")
st.dataframe(
    filtered_neighbourhood.sort_values(
        "ESTIMATED_UNAVAILABLE_REVENUE", ascending=False
    ),
    use_container_width=True,
)

st.subheader("Estimated Revenue by Neighbourhood")
revenue_chart = (
    filtered_neighbourhood.groupby("NEIGHBOURHOOD", as_index=False)[
        "ESTIMATED_UNAVAILABLE_REVENUE"
    ]
    .sum()
    .sort_values("ESTIMATED_UNAVAILABLE_REVENUE", ascending=False)
    .head(20)
)
st.bar_chart(
    revenue_chart,
    x="NEIGHBOURHOOD",
    y="ESTIMATED_UNAVAILABLE_REVENUE",
)

st.subheader("Room Type Price Comparison")
room_type_chart = (
    filtered_listing.groupby("ROOM_TYPE", as_index=False)["AVERAGE_DAILY_PRICE"]
    .mean()
    .sort_values("AVERAGE_DAILY_PRICE", ascending=False)
)
st.bar_chart(room_type_chart, x="ROOM_TYPE", y="AVERAGE_DAILY_PRICE")

st.subheader("Top Hosts by Listings")
st.dataframe(
    host_df.sort_values("LISTINGS_IN_DATASET", ascending=False).head(25),
    use_container_width=True,
)

