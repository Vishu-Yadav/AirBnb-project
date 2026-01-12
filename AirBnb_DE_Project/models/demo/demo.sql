{{ config(materialized='view')}}

select * from AIRBNB_PROJECT.STAGING_LAYER.listings

{# Note - A dbt model file must compile to ONE SQL query – otherwise it will throw error
❌ Snowflake views do not allow multiple SELECT statements
❌ dbt models = one final SELECT
That’s why Snowflake complains at every select after the first one. #}


{# jinja example #}

{# 1) Without Jinja variable #}
{# select * from {{ref('bookings_bronze')}}            here ref is used for Model referencing 
where NIGHTS_BOOKED > 3 #}

{# 2) With Jinja variable #}
{# {% set nights_booked = 3 %}                  this is a jinja variable which has value as 3

select * from {{ref('bookings_bronze')}}
where NIGHTS_BOOKED > {{ nights_booked }} #}



{# 3) Jinja if-else example #}
{# 
{% set flag = 1 %}

select * from {{ref('bookings_bronze')}}
{% if flag == 1 %}
    where NIGHTS_BOOKED > 3
{% else %}
    where NIGHTS_BOOKED <= 3
{% endif %} 
#}

{# Note - for if-else we use {% %}, not like this –> {{% %}} –> these double curly braces are used for variables and here it will cause error #}


{# 4) Loop #}
{# 
{% set cols = ['NIGHTS_BOOKED', 'BOOKING_ID', 'BOOKING_AMOUNT'] %}

SELECT 
{% for col in cols %}
    {{ col }}
        {% if not loop.last %}, {% endif %}
{% endfor %}
FROM {{ ref('bookings_bronze') }} 
#}
