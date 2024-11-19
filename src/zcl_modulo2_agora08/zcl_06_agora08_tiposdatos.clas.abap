CLASS zcl_06_agora08_tiposdatos DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_string TYPE string VALUE 'LOGALI',
          lv_char   TYPE c LENGTH 2,
          lv_int    TYPE i.

    DATA: lv_date    TYPE d,
          lv_time    TYPE t,
          lv_time2   TYPE c LENGTH 6,
          lv_decimal TYPE p LENGTH 3 DECIMALS 2.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_06_AGORA08_TIPOSDATOS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*******Conversions

*    lv_int = lv_string.
*    out->write( |Conversion string a int: { lv_int } | ).
*
*    lv_string = '20242709'.
*    lv_date = lv_string.
*
*    out->write( | Variable string: { lv_string } | ).
*    out->write( | Date: { lv_date DATE = USER } | ).
*
*    lv_date = '19860810'.
*    lv_int = lv_date.
*
*    out->write( lv_int ).


*******Truncamiento y Redondeo

*    lv_char = lv_string.
*    out->write( lv_char ).
*
*    "Redondeo
*    lv_decimal = 1 / 12.
*    out->write( lv_decimal ).

*******Declaraciones en linea

*    DATA(lv_mult) = 8 * 16.
*    out->write( lv_mult ).
*
*    DATA(lv_div) = 8 / 16.
*    out->write( lv_div ).
*
*    DATA(lv_text) = 'ABAP I - 2024'.
*    out->write( lv_text ).

*******Conversion forzada de tipos CONV

*    DATA(lv_date_inv) = '20242310'.
*    out->write( lv_date_inv ).
*
*    DATA(lv_date_inv1) = CONV d( lv_date_inv ).
*    out->write( lv_date_inv1 ).

*******Date and Time
*    lv_date = cl_abap_context_info=>get_system_date( ).
*    lv_time = cl_abap_context_info=>get_system_time( ).
*    lv_time2 = cl_abap_context_info=>get_user_time_zone( ).
*
*    out->write( lv_date ).
*    out->write( lv_time ).
*    out->write( lv_time2 ).
*
*    out->write( | Fecha: { lv_date DATE = USER } | ).
*    out->write( | Hora: { lv_time TIME = ENVIRONMENT } | ).
*    out->write( | Zona Horaria: { lv_time2 } | ).

    "Diferencia en dias
*    lv_date = '20240927'.
*    DATA(lv_date2) = cl_abap_context_info=>get_system_date( ).
*
*    DATA(lv_days) = lv_date2 - lv_date.
*    out->write( lv_days ).

    "Offset
*    lv_date = '20240927'.
*
*    DATA(lv_year) = lv_date(4).
*    out->write( | Año: { lv_year } | ).
*
*    DATA(lv_month) = lv_date+4(2).
*    out->write( | Mes: { lv_month } | ).
*
*    DATA(lv_day) = lv_date+6(2).
*    out->write( | Dia: { lv_day } | ).

*******TIMESTAMP
    "UTCLONG

    DATA: lv_time3 TYPE utclong,
          lv_time4 TYPE utclong.

    lv_time3 = utclong_current( ).
    out->write( lv_time3 ).

    "add
    lv_time3 = utclong_add( val = lv_time3 days = 1 hours = 3  ).
    out->write( lv_time3 ).

    "diff
    lv_time3 = utclong_current( ).
    lv_time4 = utclong_add( val = lv_time3 hours = 5 ).
    "out->write( lv_time3 ).
    "out->write( lv_time4 ).

    DATA(lv_total) = utclong_diff( high = lv_time4 low = lv_time3 ).
    out->write( lv_total ).

    "Conversion de UTCLONG a UTC
    TRY.
        CONVERT UTCLONG lv_time3
        TIME ZONE cl_abap_context_info=>get_user_time_zone( )
        INTO DATE lv_date
        TIME lv_time.
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        out->write( lv_error ).
    ENDTRY.
    out->write( lv_date ).
    out->write( lv_time ).

  ENDMETHOD.
ENDCLASS.
