CLASS zcl_02_agora08_complexty DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_02_AGORA08_COMPLEXTY IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

* Creacion de estructura tipo estructurado
    TYPES: BEGIN OF lty_employee,
             id   TYPE i,
             name TYPE string,
             age  TYPE i,
           END OF lty_employee.

* Declarra una estructura de tipo lty_employee
    DATA ls_employee TYPE lty_employee.

    " Asignar valores a los campos de una estructura
    ls_employee = VALUE #( id = 12345
                           name = 'Harold'
                           age = 37 ).

    out->write( | ID: { ls_employee-id } NAME: { ls_employee-name } AGE: { ls_employee-age } | ).

* Creacion de estructura tipo enumerado
    TYPES: BEGIN OF ENUM lty_invoice_status,
             pending_payment,
             paid,
           END OF ENUM lty_invoice_status.

    DATA lv_status TYPE lty_invoice_status.
    lv_status = pending_payment.

    "out->write( lv_status ).

  ENDMETHOD.
ENDCLASS.
