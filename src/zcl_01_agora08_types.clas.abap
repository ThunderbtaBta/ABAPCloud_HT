CLASS zcl_01_agora08_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun. "Visualizar las impresiones en el codigo

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_01_AGORA08_TYPES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_string TYPE string, "Variable de tipo string
          lv_int    TYPE i VALUE 2024,         "Variable de tipo entero
          lv_date   TYPE d,         "Variable de tipo date
          lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '20.5',
          lv_car    TYPE c LENGTH 10 VALUE 'Agora'.


    lv_string = '20241810'.
    lv_date = '20241810'.

    out->write( lv_string ).
    out->write( lv_int ).
    out->write( lv_date ).
    out->write( lv_dec ).
    out->write( lv_car ).

  ENDMETHOD.
ENDCLASS.
