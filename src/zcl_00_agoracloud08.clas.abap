CLASS zcl_00_agoracloud08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_00_AGORACLOUD08 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'This is my first class' ).

  ENDMETHOD.
ENDCLASS.
