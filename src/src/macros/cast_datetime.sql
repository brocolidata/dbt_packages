{% macro cast_datetime(datetime_field) -%}
    (TIMESTAMP_MICROS(cast({{ datetime_field }}/1000 as int)))
{%- endmacro %}