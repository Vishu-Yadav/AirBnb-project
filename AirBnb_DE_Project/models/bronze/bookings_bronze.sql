{# {% set incremental_load = 1 %} #}
{# {% set incremental_col = 'CREATED_AT' %} #}


{# select * from {{ source('staging', 'bookings') }}       it is a jinja variable that is why we use double curly braces #}
{# {% if incremental_load == 1 %} #}
{# where {{ incremental_col }} > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})      'this' keyword is used to refer to the current model #}
{# {% endif %} #}

{# SELECT MAX(CREATED_AT) FROM {{ ref("bookings_bronze") }} #}



{# Above thing can be done like below #}
{{ config(materialized = 'incremental') }}

SELECT * FROM  {{ source('staging', 'bookings') }}

{% if is_incremental() %}
    WHERE CREATED_AT > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})
{% endif %}
