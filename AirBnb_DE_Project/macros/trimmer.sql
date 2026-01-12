{# trimming the column name and then converting it to uppercase #}

{% macro trimmer(column_name, node) %}
    {{ col_name | trim | upper }}
{% endmacro %}