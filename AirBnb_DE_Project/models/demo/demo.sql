{{ config(materialized='view')}}

select * from AIRBNB_PROJECT.STAGING_LAYER.listings



{# jinja example #}

{# 1) Without Jinja #}
select * from {{ref('bookings_bronze')}}
where NIGHTS_BOOKED > 3

{# 2) With Jinja #}
{% set nights_booked = 3 %}                  {# this is a jinja variable which has value as 3#}

select * from {{ref('bookings_bronze')}}
where NIGHTS_BOOKED > {{ nights_booked }}