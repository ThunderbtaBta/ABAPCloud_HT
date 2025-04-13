CLASS zcl_work_order_validator_a08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      validate_create_order IMPORTING iv_customer_id   TYPE string
                                      iv_technician_id TYPE string
                                      iv_priority      TYPE string
                            EXPORTING ev_error_message TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_update_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                            EXPORTING ev_error_message TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_delete_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                            EXPORTING ev_error_message TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_status_and_priority IMPORTING iv_status       TYPE string
                                             iv_priority     TYPE string
                                   EXPORTING ev_error_message TYPE string
                                   RETURNING VALUE(rv_valid) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS:
      check_customer_exists IMPORTING iv_customer_id   TYPE string
                            RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_technician_exists IMPORTING iv_technician_id TYPE string
                              RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_exists IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                         RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_history IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                          RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_priority IMPORTING iv_priority_id   TYPE string
                     RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_status IMPORTING iv_status_id     TYPE string
                   RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_status IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                         RETURNING VALUE(rv_status) TYPE string.

ENDCLASS.

CLASS zcl_work_order_validator_a08 IMPLEMENTATION.

  METHOD validate_create_order.
    " Check if customer exists
    DATA(lv_customer_exists) = check_customer_exists( iv_customer_id ).
    IF lv_customer_exists IS INITIAL.
      rv_valid = abap_false.
      ev_error_message = 'Cliente no existe.'.
      RETURN.
    ENDIF.

    " Check if technician exists
    DATA(lv_technician_exists) = check_technician_exists( iv_technician_id ).
    IF lv_technician_exists IS INITIAL.
      rv_valid = abap_false.
      ev_error_message = 'Tecnico no existe.'.
      RETURN.
    ENDIF.

    " Check if priority is valid
    DATA(lv_priority) = check_priority( iv_priority ).
    IF check_priority( iv_priority ) = abap_false.
      rv_valid = abap_false.
      ev_error_message = 'Prioridad no válida.'.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_update_order.
    " Check if the work order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      ev_error_message = 'Orden de trabajo no existe.'.
      RETURN.
    ENDIF.

    " Check if the order status is editable (e.g., Pending)
    DATA(lv_status) = check_order_status( iv_work_order_id ).
    IF lv_status NE 'PE'.
      rv_valid = abap_false.
      ev_error_message = 'Estado no permite actualziaciones.'.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_delete_order.
    " Check if the order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      ev_error_message = 'Orden de trabajo no existe.'.
      RETURN.
    ENDIF.

    " Check if the order status is "PE" (Pending)
    DATA(lv_status) = check_order_status( iv_work_order_id ).
    IF lv_status NE 'PE'.
      rv_valid = abap_false.
      ev_error_message = 'Estado no permite Eliminacion.'.
      RETURN.
    ENDIF.

    " Check if the order has a history (i.e., if it has been modified before)
    DATA(lv_has_history) = check_order_history( iv_work_order_id ).
    IF lv_has_history IS NOT INITIAL.
      rv_valid = abap_false.
      ev_error_message = 'Orden con historial no puede eliminarse.'.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_status_and_priority.

    " Validate the status value
    DATA(lv_status) = check_status( iv_status ).
    IF  check_status( iv_status ) = abap_false.
      rv_valid = abap_false.
      ev_error_message = 'Estado no válido.'.
      RETURN.
    ENDIF.

    " Validate the priority value
    DATA(lv_priority) = check_priority( iv_priority ).
    IF check_priority( iv_priority ) = abap_false.
      rv_valid = abap_false.
      ev_error_message = 'Prioridad no válida.'.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD check_customer_exists.
    SELECT SINGLE FROM ztcustomer_a08
        FIELDS customer_id
        WHERE customer_id = @iv_customer_id
        INTO @DATA(ls_customer).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_order_exists.
    SELECT SINGLE FROM ztwork_order_a8
      FIELDS status
      WHERE work_order_id = @iv_work_order_id
      INTO @DATA(ls_workorder).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_order_history.
    SELECT SINGLE FROM ztwork_orderh_a8
        FIELDS work_order_id
        WHERE work_order_id = @iv_work_order_id
        INTO @DATA(ls_work_orderhist).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_priority.
    SELECT SINGLE FROM ztpriority_a08
    FIELDS priority_code
    WHERE priority_code = @iv_priority_id
    INTO @DATA(ls_priority).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_status.
    SELECT SINGLE FROM ztstatus_a08
   FIELDS status_code
   WHERE status_code = @iv_status_id
   INTO @DATA(ls_status).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD check_order_status.
    SELECT SINGLE FROM ztwork_order_a8
  FIELDS *
  WHERE work_order_id = @iv_work_order_id
  INTO @DATA(ls_workorder).

    IF sy-subrc = 0.
      rv_status = ls_workorder-status.
    ELSE.
      rv_status = ''.
    ENDIF.
  ENDMETHOD.

  METHOD check_technician_exists.
    SELECT SINGLE FROM ztechnician_A8
      FIELDS technician_id
      WHERE technician_id = @iv_technician_id
      INTO @DATA(ls_technician).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
