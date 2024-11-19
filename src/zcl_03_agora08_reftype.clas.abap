CLASS zcl_03_agora08_reftype DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_03_AGORA08_REFTYPE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Referencias elementales
    DATA: lvr_int    TYPE REF TO i, "Variable de tipo referencia
          lvr_string TYPE REF TO string.

* Referencias a tablas
    DATA lvr_ddic_tab TYPE REF TO /dmo/airport. " refrencia a una tabla de la BD

* Referencia a otra variable que esta refenciada
    DATA lvr_int2 LIKE lvr_int. " referencia a otra variable que esta refenciada

****
    TYPES: ltyr_int TYPE REF TO i.
    DATA lvr_int3 TYPE ltyr_int.

* Tablas internas de referecnia

    DATA lt_itab TYPE TABLE OF REF TO /dmo/airport.

******
* Referencia a una clase global  (Objetos)
    DATA lo_ref TYPE REF TO zcl_02_agora08_complexty.

  ENDMETHOD.
ENDCLASS.
