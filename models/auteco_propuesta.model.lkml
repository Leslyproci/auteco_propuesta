connection: "auteco"

# include all the views
include: "/views/**/*.view"

datagroup: auteco_propuesta_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: auteco_propuesta_default_datagroup

explore: cubo_final {}
