{# Metadata driven pipeline #}
{% set configs = [
        {
            "table" : "AIRBNB_PROJECT.SILVER.BOOKINGS_SILVER",
            "columns" : "bookings_silver.*",
            "alias" : "bookings_silver"
        },
        {
            "table" : "AIRBNB_PROJECT.SILVER.LISTINGS_SILVER",
            "columns" : "listings_silver.HOST_ID, listings_silver.PROPERTY_TYPE, listings_silver.ROOM_TYPE, listings_silver.CITY, listings_silver.COUNTRY, listings_silver.ACCOMMODATES, listings_silver.BEDROOMS, listings_silver.BATHROOMS, listings_silver.PRICE_PER_NIGHT, listings_silver.PRICE_PER_NIGHT_CATEGORY, listings_silver.CREATED_AT AS LISTING_CREATED_AT",
            "alias" : "listings_silver",
            "join_condition" : "bookings_silver.listing_id = listings_silver.listing_id"
        },
        {
            "table" : "AIRBNB_PROJECT.SILVER.HOSTS_SILVER",
            "columns" : "hosts_silver.HOST_NAME, hosts_silver.HOST_SINCE, hosts_silver.IS_SUPERHOST, hosts_silver.RESPONSE_RATE, hosts_silver.RESPONSE_RATE_QUALITY, hosts_silver.CREATED_AT AS HOST_CREATED_AT",
            "alias" : "hosts_silver",
            "join_condition" : "listings_silver.host_id = hosts_silver.host_id"
        }
    ]
%}


SELECT
    {% for config in configs %}
        {{ config['columns'] }} {% if not loop.last %} , {% endif %}
    {% endfor %}
FROM
    {% for config in configs %}
        {% if loop.first %}
            {{ config['table'] }} AS {{ config['alias'] }}
        {% else %}
    LEFT JOIN {{ config['table'] }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
        {% endif %}
    {% endfor %}