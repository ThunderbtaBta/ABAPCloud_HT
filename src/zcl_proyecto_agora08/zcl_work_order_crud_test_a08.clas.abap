CLASS zcl_work_order_crud_test_a08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS:
      test_create_work_order EXPORTING rv_valid   TYPE abap_bool
                                       rv_message TYPE string,
      test_read_work_order   EXPORTING rv_valid        TYPE abap_bool
                                       rv_message      TYPE string
                                       rv_ls_workorder TYPE ztwork_order_a8,
      test_update_work_order EXPORTING rv_valid   TYPE abap_bool
                                       rv_message TYPE string,
      test_delete_work_order EXPORTING rv_valid   TYPE abap_bool
                                       rv_message TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_work_order_crud_test_a08 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA: lv_message TYPE string,
          lv_valid   TYPE abap_bool,
          lv_test    TYPE c.  "1-create, 2-read, 3-update, 4-delete

    DATA ls_workorder TYPE ztwork_order_a8.

*  test crud
    lv_test = '4'.

    CASE lv_test.
      WHEN '1'.
        test_create_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        out->write( | { lv_message }| ).

      WHEN '2'.
        test_read_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message
                                            rv_ls_workorder =  ls_workorder ).
        IF lv_valid = abap_false.
          out->write( | { lv_message } | ).
        ELSE.
          out->write(  ls_workorder ).
        ENDIF.

      WHEN '3'.
        test_update_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        out->write( | { lv_message }| ).

      WHEN '4'.
        test_delete_work_order(   IMPORTING
                                            rv_valid = lv_valid
                                            rv_message = lv_message ).

        IF lv_valid = abap_false.
          out->write( | { lv_message }| ).
        ELSE.
          out->write( | Orden de Trabajo Eliminada | ).
        ENDIF.
    ENDCASE.

  ENDMETHOD.

  METHOD test_create_work_order.

    DATA(lo_instance) = NEW zcl_work_order_crud_handler_a8( ).

    lo_instance->create_work_order( EXPORTING  iv_work_order_id = 5
                                      iv_customer_id  = '1'
                                      iv_technician_id = '2'
                                      iv_priority = 'A'
                                      iv_status = 'PE'
                                      iv_description = 'Registro prueba 5'
                                      iv_creation_date = '20250418' "YYY-MM-DD
                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).

  ENDMETHOD.

  METHOD test_read_work_order.

    DATA(lo_instance) = NEW zcl_work_order_crud_handler_a8( ).

    lo_instance->read_work_order( EXPORTING  iv_work_order_id = 1

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message
                                      rv_ls_work_order = rv_ls_workorder ).

  ENDMETHOD.



  METHOD test_update_work_order.
    DATA(lo_instance) = NEW zcl_work_order_crud_handler_a8( ).

    lo_instance->update_work_order( EXPORTING  iv_work_order_id = 5
                                      iv_customer_id  = '2'
                                      iv_technician_id = '2'
                                      iv_priority = 'A'
                                      iv_status = 'PE'
                                      iv_description = 'Modificacion Fecha '
                                      iv_creation_date = '20250420' "YYY-MM-DD

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).

  ENDMETHOD.

   METHOD test_delete_work_order.
    DATA(lo_instance) = NEW zcl_work_order_crud_handler_a8( ).

    lo_instance->delete_work_order( EXPORTING  iv_work_order_id = 5

                                      IMPORTING
                                      rv_valid = rv_valid
                                      rv_message = rv_message ).

  ENDMETHOD.
ENDCLASS.
