{% set incremental_load = 1 %}
{% set incremental_col = 'CREATED_AT' %}

select * from {{ source('staging', 'listings') }}       {# it is a jinja variable that is why we use double curly braces #}
{% if incremental_load == 1 %}
where {{ incremental_col }} > (SELECT COALESCE(MAX(CREATED_AT), '1900-01-01') FROM {{ this }})      {# 'this' keyword is used to refer to the current model #}
{% endif %}