CLASS zcl_work_order_validator_a08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      validate_create_order IMPORTING iv_customer_id   TYPE string
                                      iv_technician_id TYPE string
                                      iv_priority      TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_update_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                                      iv_status        TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,

      validate_delete_order IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                                      iv_status        TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,
      validate_status_and_priority IMPORTING iv_status       TYPE string
                                             iv_priority     TYPE string
                                   RETURNING VALUE(rv_valid) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
*  CONSTANTS: c_valid_status TYPE string VALUE 'PE CO', " Example statuses: Pending, Completed
*             c_valid_priority TYPE string VALUE 'A B'. " Example priorities: High,

    METHODS:
      check_customer_exists IMPORTING iv_customer_id   TYPE string
                            RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_technician_exists IMPORTING iv_technician_id TYPE string
                              RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_exists IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                         RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_history IMPORTING iv_work_order_id TYPE zde_work_order_agora08
                          RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_priority IMPORTING iv_priority      TYPE string
                     RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_status IMPORTING iv_status        TYPE string
                   RETURNING VALUE(rv_exists) TYPE abap_bool.

ENDCLASS.



CLASS zcl_work_order_validator_a08 IMPLEMENTATION.

  METHOD validate_create_order.
    " Check if customer exists
    DATA(lv_customer_exists) = check_customer_exists( iv_customer_id ).
    IF lv_customer_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if technician exists
    DATA(lv_technician_exists) = check_technician_exists( iv_technician_id ).
    IF lv_technician_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if priority is valid
    DATA(lv_priority) = check_priority( iv_priority ).
    IF iv_priority IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_update_order.
    " Check if the work order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if the order status is editable (e.g., Pending)
    DATA(lv_status) = check_status( iv_status ).
    IF iv_status IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_delete_order.
    " Check if the order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if the order status is "PE" (Pending)
    DATA(lv_status) = check_status( iv_status ).
    IF iv_status IS INITIAL.
      rv_valid = abap_false.
      RETURN.
*    IF iv_status NE 'PE'.
*      rv_valid = abap_false.
*      RETURN.
    ENDIF.

    " Check if the order has a history (i.e., if it has been modified before)
    DATA(lv_has_history) = check_order_history( iv_work_order_id ).
    IF lv_has_history IS NOT INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_status_and_priority.

    " Validate the status value
    DATA(lv_status) = check_status( iv_status ).
    IF iv_status IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    IF iv_status NOT IN c_valid_status.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.

    " Validate the priority value
    DATA(lv_priority) = check_priority( iv_priority ).
    IF iv_priority IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    IF iv_priority NOT IN c_valid_priority.
*      rv_valid = abap_false.
*      RETURN.
*    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD check_customer_exists.
    SELECT SINGLE FROM ztcustomer_a08
        FIELDS *
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
      FIELDS *
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
        FIELDS *
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
    FIELDS *
    WHERE priority_code = @iv_priority
    INTO @DATA(ls_priority).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_status.
    SELECT SINGLE FROM ztstatus_a08
   FIELDS *
   WHERE status_code = @iv_status
   INTO @DATA(ls_priority).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_technician_exists.
    SELECT SINGLE FROM ztechnician_A8
      FIELDS *
      WHERE technician_id = @iv_technician_id
      INTO @DATA(ls_technician).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
