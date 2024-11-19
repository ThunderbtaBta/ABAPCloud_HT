CLASS zcl_lab_03_datatypes_agora08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    DATA: mv_char      TYPE c LENGTH 10 VALUE '12345',
          mv_num       TYPE i,
          mv_float     TYPE f,
          mv_trunc     TYPE i,
          mv_round     TYPE i,
          mv_date_1    TYPE d,
          mv_date_2    TYPE d,
          mv_days      TYPE i,
          mv_time      TYPE t,
          mv_timestamp TYPE utclong.



    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAB_03_DATATYPES_AGORA08 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Conversion de tipo de datos
    mv_num = mv_char.
    out->write( | Conversion de char a int: { mv_num } | ).

    mv_float = mv_char.
    out->write( | Conversion de char a int: { mv_float } | ).

* Truncamiento y redondeo
    mv_float = '123.45'.

    mv_trunc  = mv_float.
    out->write( | Truncar Valor: { mv_trunc } | ).

    mv_float += '0.5'.
    out->write( | Sumar Valor: { mv_float } | ).

    mv_round  = mv_float.
    out->write( | Redondear Valor: { mv_round } | ).

* Declaracion en Linea
    DATA(lv_text) = 'ABAP'.
    out->write( | Declarcion en linea: { lv_text } | ).

* Conversion de tipo forzado
    mv_char = CONV i( mv_num ).
    out->write( | Convesion forzada CONV: { mv_char } | ).

* Calculo de fecha y hora
    mv_date_1 = cl_abap_context_info=>get_system_date( ).
    mv_date_2 = cl_abap_context_info=>get_system_date( ) + 5.

    out->write( | Fecha 1: { mv_date_1 DATE = USER } | ).
    out->write( | Fecha 2: { mv_date_2 DATE = USER } | ).

    mv_days = mv_date_2 - mv_date_1.
    out->write( | Diferencia en dias: { mv_days } | ).

* Campos TIMESTAMP
    mv_timestamp = utclong_current( ).

    out->write( | Fecha Timestamp: { mv_timestamp } | ).

    TRY.
        CONVERT UTCLONG mv_timestamp
        TIME ZONE cl_abap_context_info=>get_user_time_zone( )
        INTO DATE mv_date_2
        TIME mv_time.
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        out->write( lv_error ).
    ENDTRY.
    out->write( | Fecha: { mv_date_2 DATE = USER } | ).
    out->write( | Hora: { mv_time TIME = ENVIRONMENT } | ).


    DATA:mv_date_3 TYPE utclong,
         mv_date_4 TYPE utclong.

    mv_date_3 = utclong_current( ).
    mv_date_4 = utclong_add( val = mv_date_3 days = -2 ).

    out->write( | Dias restados: { mv_date_4 } | ).

  ENDMETHOD.
ENDCLASS.
