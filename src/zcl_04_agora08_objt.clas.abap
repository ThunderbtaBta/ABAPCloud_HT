CLASS zcl_04_agora08_objt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_04_AGORA08_OBJT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_num1 TYPE i VALUE 10,
          lv_num2 TYPE i,
          lv_num3 TYPE i,
          lv_date TYPE d.

    lv_date = '20240101'.

    CONSTANTS: lc_num4   TYPE i VALUE 10,
               lc_num5   TYPE i VALUE 20,
               lc_string TYPE string VALUE 'AGORA'.
    lv_num2 = 15.
    lv_num3 = lv_num1 + lv_num2.

    DATA(lv_invoice) = '12345'.
    DATA(lv_tax) = 12345.

    out->write( | La suma es de: { lv_num3 } | ).
    out->write( | { lv_date+6(2)  }/{ lv_date+4(2) }/ { lv_date+0(4) } | ).

    out->write( 'ABAP Class - Logali' ).
    out->write( |Agora08| ).

  ENDMETHOD.
ENDCLASS.
