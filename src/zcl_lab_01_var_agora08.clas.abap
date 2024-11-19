CLASS zcl_lab_01_var_agora08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAB_01_VAR_AGORA08 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*1. Tipo de datos Elementales
* Fecha y Hora
    DATA: mv_purchase_date TYPE d,
          mv_purchase_time TYPE t,

* Price y TAX
          mv_price         TYPE f VALUE '10.5',
          mv_tax           TYPE i VALUE 16,

* Increase y discounts
          mv_increase      TYPE decfloat16 VALUE '20.5',
          mv_discounts     TYPE decfloat16 VALUE '10.5',

* Type y Shipping
          mv_type          TYPE c LENGTH 10 VALUE 'PC',
          mv_shipping      TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36',

* id_code y qr_code
          mv_id_code       TYPE n LENGTH 4 VALUE '1110',
          mv_qr_code       TYPE x LENGTH 5 VALUE 'F5CF'.

    mv_purchase_date = sy-datum.
    mv_purchase_time = sy-timlo.

*2. Tipos de datos complejos
    TYPES: BEGIN OF mty_customer,
             id       TYPE i,
             customer TYPE c LENGTH 15,
             age      TYPE i,
           END OF mty_customer.

* Asignar valores
    DATA ls_customer TYPE mty_customer.
    ls_customer = VALUE #( id = 1030528232
                           customer = 'Harold Triviño'
                           age = 37 ).

    out->write( |ID: { ls_customer-id } Customer: { ls_customer-customer } Age: { ls_customer-age } | ).

*3. Tipos de datos referencia
    DATA ms_employees TYPE TABLE OF REF TO /dmo/employee_hr.
    "ms_employees = VALUE #( client = 100              ).


*4. Objetos de datos
    DATA: mv_product  TYPE string VALUE 'Laptop',
          mv_bar_code TYPE xstring VALUE '12121 121211'.

*5. Constantes
    CONSTANTS: mc_price     TYPE f VALUE '10.5',
               mc_tax       TYPE i VALUE 20,
               mc_increase  TYPE decfloat16 VALUE '30.5',
               mc_discounts TYPE decfloat16 VALUE '110.5',
               mc_type      TYPE c LENGTH 10 VALUE 'XBOS',
               mc_shipping  TYPE p LENGTH 8 DECIMALS 2 VALUE '45.36',
               mc_id_code   TYPE n LENGTH 4 VALUE '1100',
               mc_qr_code   TYPE x LENGTH 5 VALUE 'A4CF'.

*6. Declaracion en linea
    DATA(lv_product) = mv_product.
    DATA(lv_bar_cade) = mv_bar_code.


  ENDMETHOD.
ENDCLASS.
