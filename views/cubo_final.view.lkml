view: cubo_final {
  sql_table_name: `auteco.cubo_final`
    ;;
  parameter: forecast_lag {
    type: unquoted
    {
      allowed_value: "January"
      allowed_value: "February"
      allowed_value: "March"
      allowed_value: "April"
      allowed_value: "May"
      allowed_value: "June"
      allowed_value: "July"
      allowed_value: "August"
      allowed_value: "September"
      allowed_value: "October"
      allowed_value: "November"
      allowed_value: "December"
    }
  }
  dimension: abc {
    type: string
    sql: ${TABLE}.ABC ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.Brand ;;
  }

  dimension: budget_cogs {
    type: number
    sql: ${TABLE}.Budget_COGS ;;
  }

  dimension: cog {
    type: number
    sql: ${TABLE}.COG ;;
  }

  dimension: current_dealer_price {
    type: number
    sql: ${TABLE}.Current_dealer_price ;;
  }

  dimension: customer {
    type: string
    sql: ${TABLE}.Customer ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Date ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.Description ;;
  }

  dimension: fce1_sd {
    type: number
    sql: ${TABLE}.FCE1SD ;;
  }

  dimension: fob_price {
    type: number
    sql: ${TABLE}.FOB_Price ;;
  }

  dimension: gross_profit {
    type: number
    sql: ${TABLE}.GrossProfit ;;
  }

  dimension: location {
    type: string
    sql: ${TABLE}.Location ;;
  }

  dimension: material {
    type: number
    sql: ${TABLE}.Material ;;
  }

  dimension: measure {
    type: string
    sql: ${TABLE}.Measure ;;
  }

  dimension: model {
    type: string
    sql: ${TABLE}.Model ;;
  }

  dimension: month {
    type: string
    sql: ${TABLE}.Month ;;
  }

  dimension: oem_price {
    type: number
    sql: ${TABLE}.OEM_Price ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.Revenue ;;
  }

  dimension: ss {
    type: number
    sql: ${TABLE}.SS ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.Status ;;
  }

  dimension: value {
    type: number
    sql: ${TABLE}.Value ;;
  }

  dimension: week {
    type: string
    sql: ${TABLE}.Week ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }

  dimension: z_score {
    type: number
    sql: ${TABLE}.zScore ;;
  }

  dimension: UOM {
    type: number
    sql: CASE
            WHEN ${TABLE}.UOM = 'Unidades' THEN ${TABLE}.Value
            WHEN ${TABLE}.UOM = 'Revenue' THEN ${TABLE}.Revenue
            WHEN ${TABLE}.UOM = 'Profit' THEN ${TABLE}.GrossProfit
            WHEN ${TABLE}.UOM = 'COGS' THEN ${TABLE}.COG
        END ;;
  }
  dimension: AbsVar {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'AbsVar' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Arrivals {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'ActualArrivals' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: CSOH {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'CSOH' OR  ${TABLE}.Measure = 'PSOH' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  parameter: Dimension_filtro {
    type: unquoted
    allowed_value: {
      value: "Brand"
    }
    allowed_value: {
      value: "Status"
    }
    allowed_value: {
      value: "Model"
    }
    allowed_value: {
      value: "Description"
    }
    allowed_value: {
      value: "Material"
    }
  }

  dimension: Dimension_1 {
    sql:
    {% if Dimension_filtro._parameter_value == 'Brand' %}
      ${TABLE}.Brand
    {% elsif Dimension_filtro._parameter_value == 'Status' %}
      ${TABLE}.Status
    {% elsif Dimension_filtro._parameter_value == 'Model' %}
      ${TABLE}.Model
    {% elsif Dimension_filtro._parameter_value == 'Description' %}
      ${TABLE}.Description
    {% elsif Dimension_filtro._parameter_value == 'Material' %}
      ${TABLE}.Material
    {% endif %};;
  }
  dimension: Dmd_Plan {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'SalesForecast' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: LagAbsVar {
    type: number
    sql: CASE
            WHEN ${forecast_lag} = 'January' THEN IF(${TABLE}.Measure = 'LagAbsVar_January', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'February' THEN IF(${TABLE}.Measure = 'LagAbsVar_February', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'March' THEN IF(${TABLE}.Measure= 'LagAbsVar_March',${TABLE}.UOM 0)
            WHEN ${forecast_lag} = 'April' THEN IF(${TABLE}.Measure = 'LagAbsVar_April', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'May' THEN IF(${TABLE}.Measure = 'LagAbsVar_May', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'June' THEN IF(${TABLE}.Measure = 'LagAbsVar_June', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'July' THEN IF(${TABLE}.Measure = 'LagAbsVar_July', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'August' THEN IF(${TABLE}.Measure = 'LagAbsVar_August', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'September' THEN IF(${TABLE}.Measure = 'LagAbsVar_Septembre', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'October' THEN IF(${TABLE}.Measure = 'LagAbsVar_October', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'November' THEN IF(${TABLE}.Measure= 'LagAbsVar_November', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'December' THEN IF(${TABLE}.Measure = 'LagAbsVar_December', ${TABLE}.UOM, 0)
          ELSE NULL
         END ;;
  }
  dimension: LagForecast {
    type: number
    sql: CASE
            WHEN ${forecast_lag} = 'January' THEN IF(${TABLE}.Measure = 'LagForecast_January', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'February' THEN IF(${TABLE}.Measure = 'LagForecast_February', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'March' THEN IF(${TABLE}.Measure= 'LagForecast_March',${TABLE}.UOM 0)
            WHEN ${forecast_lag} = 'April' THEN IF(${TABLE}.Measure = 'LagForecast_April', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'May' THEN IF(${TABLE}.Measure = 'LagForecast_May', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'June' THEN IF(${TABLE}.Measure = 'LagForecast_June', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'July' THEN IF(${TABLE}.Measure = 'LagForecast_July', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'August' THEN IF(${TABLE}.Measure = 'LagForecast_August', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'September' THEN IF(${TABLE}.Measure = 'LagForecast_Septembre', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'October' THEN IF(${TABLE}.Measure = 'LagForecast_October', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'November' THEN IF(${TABLE}.Measure= 'LagForecast_November', ${TABLE}.UOM, 0)
            WHEN ${forecast_lag} = 'December' THEN IF(${TABLE}.Measure = 'LagForecast_December', ${TABLE}.UOM, 0)
          ELSE NULL
         END ;;
  }
  dimension: Max {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Max' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Min {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Min' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Sell_In {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Sell_In' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Sell_Out {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Sell_Out' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Stat_FC {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Forecast' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }
  dimension: Target {
    type: number
    sql: CASE
            WHEN ${TABLE}.Measure = 'Target' THEN ${TABLE}.UOM
            ELSE '0'
         END ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: Acc_Lag_Forecast {
    type: number
    sql: 1.0 - (COALESCE(SUM(${TABLE}.LagAbsVar), 0) / COALESCE(SUM(${TABLE}.LagForecast), 0));;
  }
  measure: Acc_Zero_Lag {
    type: number
    sql: 1.0 - (COALESCE(SUM(${TABLE}.AbsVar), 0) / COALESCE(SUM(${TABLE}.Stat_FC), 0));;
  }
  measure: WOH {
    type: number
    sql: COALESCE(SUM(${TABLE}.CSOH), 0) / COALESCE(SUM(${TABLE}.Stat_FC), 0);;
  }
  measure: Var_Zero_Lag {
    type: number
    sql: COALESCE(SUM(${TABLE}.Stat_FC), 0) - COALESCE(SUM(${TABLE}.Sell_Out), 0);;
  }
  measure: Var_Lag_Forecast {
    type: number
    sql: COALESCE(SUM(${TABLE}.LagForecast), 0) - COALESCE(SUM(${TABLE}.Sell_Out), 0);;
  }
  measure: Mkt_Intel {
    type: number
    sql: COALESCE(SUM(${TABLE}.Dmd_Plan), 0) - COALESCE(SUM(${TABLE}.Stat_FC), 0);;
  }
  measure: Bias_Zero_Lag {
    type: number
    sql: COALESCE(${Var_Zero_Lag}, 0) / COALESCE(SUM(${TABLE}.Stat_FC), 0);;
  }
  measure: Bias_Lag_Forecast {
    type: number
    sql: COALESCE(${Var_Lag_Forecast}, 0) / COALESCE(SUM(${TABLE}.LagForecast), 0);;
  }


}
