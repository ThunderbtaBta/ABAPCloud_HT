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
                                rv_ls_work_order TYPE ztwork_order_a8,

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

    DATA: ls_work_order TYPE ztwork_order_a8.
    DATA: lv_error_message TYPE string.
    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    IF iv_work_order_id IS INITIAL.
      rv_message = 'ID de orden de trabajo no proporcionado.'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_create_order( EXPORTING iv_customer_id   = iv_customer_id
                                           iv_technician_id = iv_technician_id
                                           iv_priority      = iv_priority
                                           IMPORTING ev_error_message = lv_error_message ) = abap_false.

      rv_message =  lv_error_message.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_status_and_priority( EXPORTING iv_status = iv_status iv_priority = iv_priority ) = abap_false.
      rv_message = 'Estado o Prioridad no válido.'.
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

    INSERT ztwork_order_a8 FROM @ls_work_order.
    IF sy-subrc = 0.
      rv_message =  | Orden de Trabajo { iv_work_order_id } registrada correctamente|  .
      rv_valid = abap_true.
    ELSE.
      rv_message =  | Orden de Trabajo { iv_work_order_id } no fue registrada correctamente|  .
      rv_valid = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD read_work_order.

    IF iv_work_order_id IS INITIAL.
      rv_message = 'ID de orden de trabajo no proporcionado.'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE FROM ztwork_order_a8
    FIELDS *
    WHERE work_order_id = @iv_work_order_id
    INTO @rv_ls_work_order.

    IF sy-subrc = 0.
      rv_message =  | Orden de Trabajo { iv_work_order_id } existe|  .
      rv_valid = abap_true.

    ELSE.
      rv_message =  | Orden de Trabajo { iv_work_order_id } no existe |  .
      rv_valid = abap_false.
    ENDIF.


  ENDMETHOD.

  METHOD delete_work_order.

    DATA: ls_work_order TYPE ztwork_order_a8.
    DATA: lv_error_message TYPE string.
    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    IF iv_work_order_id IS INITIAL.
      rv_message = 'ID de orden de trabajo no proporcionado.'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_delete_order( EXPORTING iv_work_order_id  = iv_work_order_id
                                           IMPORTING ev_error_message = lv_error_message ) = abap_false.

      rv_message = lv_error_message.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    TRY.
        DELETE FROM ztwork_order_a8 WHERE work_order_id = @iv_work_order_id.
      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        rv_message = |Orden de Trabajo { iv_work_order_id } Fallo: { lx_sql_db->get_text( ) }|.
        rv_valid = abap_false.
        RETURN.
    ENDTRY.
    IF sy-subrc = 0.
      rv_message = |Orden de Trabajo { iv_work_order_id } Eliminada|.
      rv_valid = abap_true.
    ELSE.
      rv_message = |Orden de Trabajo { iv_work_order_id } NO se puede eliminar|.
      rv_valid = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD update_work_order.

    DATA: lv_work_order_update TYPE string.
    DATA: lv_error_message TYPE string.
    DATA(lo_instance) = NEW zcl_work_order_validator_a08( ).

    IF iv_work_order_id IS INITIAL.
      rv_message = 'ID de orden de trabajo no proporcionado.'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_update_order( EXPORTING iv_work_order_id   = iv_work_order_id
                                           IMPORTING ev_error_message = lv_error_message ) = abap_false.

      rv_message = lv_error_message.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_create_order( EXPORTING iv_customer_id   = iv_customer_id
                                                         iv_technician_id = iv_technician_id
                                                         iv_priority      = iv_priority
                                               IMPORTING ev_error_message = lv_error_message ) = abap_false.

      rv_message =  lv_error_message.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    IF lo_instance->validate_status_and_priority( iv_status = iv_status iv_priority = iv_priority ) = abap_false.
      rv_message = 'Estado no válido.'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    SELECT SINGLE FROM ztwork_order_a8
  FIELDS *
  WHERE work_order_id = @iv_work_order_id
  INTO @DATA(ls_work_order).

    IF sy-subrc = 0.

      IF ls_work_order-customer_id   NE iv_customer_id.
        lv_work_order_update = | / Cliente Antes: { ls_work_order-customer_id }  , Id Despues : { iv_customer_id }|.
      ENDIF.

      IF ls_work_order-technician_id   NE iv_technician_id.
        lv_work_order_update = lv_work_order_update && | / Tecnico Antes: { ls_work_order-technician_id }  , Despues : { iv_technician_id  } |.
      ENDIF.

      IF ls_work_order-priority   NE iv_priority.
        lv_work_order_update = lv_work_order_update && | / Prioridad Antes: { ls_work_order-Priority }  , Despues : { iv_Priority  } |.
      ENDIF.

      IF ls_work_order-status   NE iv_status.
        lv_work_order_update = lv_work_order_update && | / Estado Antes: { ls_work_order-status }  , Despues : { iv_status  } |.
      ENDIF.

      IF ls_work_order-description   NE iv_description.
        lv_work_order_update = lv_work_order_update && | / Descripcion Antes: { ls_work_order-description }  , Despues : { iv_description  } |.
      ENDIF.

      IF ls_work_order-creation_date   NE iv_creation_date.
        lv_work_order_update = lv_work_order_update && | / Fecha Antes: { ls_work_order-creation_date }  , Despues : { iv_creation_date  } |.
      ENDIF.

      ls_work_order-customer_id   = iv_customer_id.
      ls_work_order-technician_id = iv_technician_id.
      ls_work_order-priority      = iv_priority.
      ls_work_order-status        = iv_status.
      ls_work_order-description   = iv_description.
      ls_work_order-creation_date = iv_creation_date.

      TRY.
          UPDATE ztwork_order_a8 FROM @ls_work_order.
        CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
          rv_message =  | Orden de Trabajo { iv_work_order_id } NO se puede actualizar : { lx_sql_db->get_text(  ) }|  .
          rv_valid = abap_false.
          RETURN.
      ENDTRY.

      IF lv_work_order_update IS INITIAL.
        rv_message = |Orden de Trabajo { iv_work_order_id } Actualizada (no changes)|.
        rv_valid = abap_true.
        RETURN.
      ENDIF.

      IF sy-subrc = 0.

        DATA: ls_work_order_hist TYPE ztwork_orderh_a8.
        DATA: lv_count TYPE i.

        DATA: lv_date TYPE d.
        lv_date = cl_abap_context_info=>get_system_date( ).

        SELECT COUNT(*)
          FROM ztwork_orderh_a8
          INTO @lv_count.

        ls_work_order_hist = VALUE #( history_id = lv_count + 1
                                      work_order_id = iv_work_order_id
                                      change_description   = lv_work_order_update
                                      modification_date  = lv_date ).

        INSERT ztwork_orderh_a8 FROM @ls_work_order_hist.
        IF sy-subrc = 0.
          rv_message =  | Orden de Trabajo { iv_work_order_id } actualizada |  .
          rv_valid = abap_true.
        ELSE.
          rv_message =  | Orden de Trabajo { iv_work_order_id } no actualizada |  .
          rv_valid = abap_false.
        ENDIF.

      ELSE.
        rv_message =  | Orden de Trabajo { iv_work_order_id } no actualizada en la tabla|  .
        rv_valid = abap_false.
      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
