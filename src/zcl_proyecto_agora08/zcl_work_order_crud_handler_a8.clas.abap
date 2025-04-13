CLASS zcl_work_order_crud_handler_a8 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      create_work_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                                  iv_customer_id   TYPE string
                                  iv_technician_id TYPE string
                                  iv_priority      TYPE string
                                  iv_status        TYPE string
                                  iv_description   TYPE string
                                  iv_creation_date TYPE d
                        EXPORTING rv_valid         TYPE abap_bool
                                  rv_message       TYPE string,

      read_work_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                      EXPORTING rv_valid         TYPE abap_bool
                                rv_message       TYPE string
                                rv_ls_work_order TYPE ztwork_order,
      update_work_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                                  iv_customer_id   TYPE string
                                  iv_technician_id TYPE string
                                  iv_priority      TYPE string
                                  iv_status        TYPE string
                                  iv_description   TYPE string
                                  iv_creation_date TYPE d

                        EXPORTING rv_valid         TYPE abap_bool
                                  rv_message       TYPE string,
      delete_work_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                        EXPORTING rv_valid         TYPE abap_bool
                                  rv_message       TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_work_order_crud_handler_a8 IMPLEMENTATION.

  METHOD create_work_order.

    DATA: ls_work_order TYPE ztwork_order.

    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    " Llamar al método de instancia

    IF lo_instance->validate_create_order( iv_customer_id   = iv_customer_id
                                           iv_technician_id = iv_technician_id
                                           iv_priority      = iv_priority ) = abap_false.

      rv_message =  | Data validation of creating work order not valid, please check |  .
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    ls_work_order = VALUE #( work_order_id = iv_work_order_id
                            customer_id   = iv_customer_id
                            technician_id = iv_technician_id
                            priority      = iv_priority
                            status        = iv_status
                            description   = iv_description
                            creation_date = iv_creation_date ).
    TRY.
        INSERT ztwork_order FROM @ls_work_order.
      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        rv_message =  | Work order { iv_work_order_id } was not inserted correctly : { lx_sql_db->get_text(  ) }|  .
        rv_valid = abap_false.
        RETURN.
    ENDTRY.

    IF sy-subrc = 0.
      rv_message =  | Work order { iv_work_order_id } inserted correctly|  .
      rv_valid = abap_true.
    ELSE.
      rv_message =  | Work order { iv_work_order_id } was not inserted correctly in table|  .
      rv_valid = abap_false.
    ENDIF.




  ENDMETHOD.

  METHOD read_work_order.
    SELECT SINGLE FROM ztwork_order
    FIELDS *
    WHERE work_order_id = @iv_work_order_id
    INTO @rv_ls_work_order.

    IF sy-subrc = 0.
      rv_message =  | Work order { iv_work_order_id } exists|  .
      rv_valid = abap_true.

    ELSE.
      rv_message =  | Work order { iv_work_order_id } Not exists |  .
      rv_valid = abap_false.
    ENDIF.


  ENDMETHOD.

  METHOD delete_work_order.

    DATA: ls_work_order TYPE ztwork_order.

    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    " Llamar al método de instancia

    IF lo_instance->validate_delete_order( iv_work_order_id = iv_work_order_id ) = abap_false.

      rv_message =  | Data validation of deleting work order not valid, please check |  .
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE FROM ztwork_order
    FIELDS *
    WHERE work_order_id = @iv_work_order_id
    INTO @DATA(ls_work_order_delete).

    IF sy-subrc = 0.

      DELETE ztwork_order FROM @ls_work_order_delete.

      IF sy-subrc = 0.
        rv_valid = abap_true.
        RETURN.
      ELSE.
        rv_valid = abap_false.
        RETURN.

      ENDIF.

    ENDIF.


  ENDMETHOD.

  METHOD update_work_order.

    DATA: lv_work_order_update TYPE string.
    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    " Llamar al método de instancia

    IF lo_instance->validate_update_order( iv_work_order_id   = iv_work_order_id ) = abap_false.

      rv_message =  | Data validation of updating work order not valid, please check |  .
      rv_valid = abap_false.
      RETURN.
    ENDIF.


* this good to validate to if the customer, technician or priority modify exists.

    DATA(lo_instance_mod) = NEW zcl_work_order_validator_a08( ).

    " Llamar al método de instancia

    IF lo_instance_mod->validate_create_order( iv_customer_id   = iv_customer_id
                                           iv_technician_id = iv_technician_id
                                           iv_priority      = iv_priority ) = abap_false.

      rv_message =  | Data validation (customer, technician or priority) of updating   work order not valid, please check |  .
      rv_valid = abap_false.
      RETURN.
    ENDIF.


    SELECT SINGLE FROM ztwork_order
  FIELDS *
  WHERE work_order_id = @iv_work_order_id
  INTO @DATA(ls_work_order).

    IF sy-subrc = 0.

      IF ls_work_order-customer_id   NE iv_customer_id.
        lv_work_order_update = | / Cust Before: { ls_work_order-customer_id }  , After iv_customer_id |.
      ENDIF.

      IF ls_work_order-technician_id   NE iv_technician_id.
        lv_work_order_update = lv_work_order_update && | / Technician Before: { ls_work_order-technician_id }  , After : { iv_technician_id  } |.
      ENDIF.

      IF ls_work_order-priority   NE iv_priority.
        lv_work_order_update = lv_work_order_update && | / Priority Before: { ls_work_order-Priority }  , After : { iv_Priority  } |.
      ENDIF.

      IF ls_work_order-status   NE iv_status.
        lv_work_order_update = lv_work_order_update && | / Status Before: { ls_work_order-status }  , After : { iv_status  } |.
      ENDIF.

      IF ls_work_order-description   NE iv_description.
        lv_work_order_update = lv_work_order_update && | / Description Before: { ls_work_order-description }  , After : { iv_description  } |.
      ENDIF.

      IF ls_work_order-creation_date   NE iv_creation_date.
        lv_work_order_update = lv_work_order_update && | / Creation Date Before: { ls_work_order-creation_date }  , After : { iv_creation_date  } |.
      ENDIF.

      ls_work_order-customer_id   = iv_customer_id.
      ls_work_order-technician_id = iv_technician_id.
      ls_work_order-priority      = iv_priority.
      ls_work_order-status        = iv_status.
      ls_work_order-description   = iv_description.
      ls_work_order-creation_date = iv_creation_date.

      TRY.
          UPDATE ztwork_order FROM @ls_work_order.
        CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
          rv_message =  | Work order { iv_work_order_id } was not updated correctly : { lx_sql_db->get_text(  ) }|  .
          rv_valid = abap_false.
          RETURN.
      ENDTRY.

      IF sy-subrc = 0.

        " now creating the history
        "  select all the rows in table

        DATA: ls_wohist TYPE ztwork_orderh_a8.
        DATA: lv_count TYPE i.

        DATA: lv_date TYPE d.
        lv_date = cl_abap_context_info=>get_system_date( ).

        SELECT COUNT(*)
          FROM ztwork_orderh_a8
          INTO @lv_count.

        ls_wohist = VALUE #( history_id = lv_count + 1
                             work_order_id = iv_work_order_id
                          change_description   = lv_work_order_update
                          modification_date  = lv_date
                           ).

        INSERT ztwork_orderh_a8 FROM @ls_wohist.
        IF sy-subrc = 0.
          rv_message =  | Work order { iv_work_order_id } updated correctly with history in table|  .
          rv_valid = abap_true.
        ELSE.
          rv_message =  | Work order { iv_work_order_id } not updated correctly with history in table|  .
          rv_valid = abap_true.
        ENDIF.

      ELSE.
        rv_message =  | Work order { iv_work_order_id } was not updated correctly in table|  .
        rv_valid = abap_false.
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
