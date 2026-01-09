{{ config(materialized='view')}}

select * from AIRBNB_PROJECT.STAGING_LAYER.listings