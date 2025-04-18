CLASS zcl_insert_data_a08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_data_a08 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA ls_status TYPE ztstatus_a08.
    DATA ls_priority TYPE ztpriority_a08.
    DATA ls_customer TYPE ztcustomer_a08.
    DATA ls_technician TYPE ztechnician_a8.

*    ls_status = VALUE #( status_code = 'PE'
*                        status_description = 'Pending' ).
*    INSERT  ztstatus_a08 FROM @ls_status.
*
*    ls_status = VALUE #( status_code = 'CO'
*                         status_description = 'Completed' ).
*    INSERT  ztstatus_a08 FROM @ls_status.
*
*    ls_priority = VALUE #( priority_code = 'A'
*                         priority_description = 'High' ).
*    INSERT  ztpriority_a08 FROM @ls_priority.

*    ls_priority = VALUE #( priority_code = 'B'
*                         priority_description = 'Low' ).
*    INSERT  ztpriority_a08 FROM @ls_priority.

*    ls_customer = VALUE #( customer_id = '3'
*                         name = 'Mateo Trivino'
*                         address = 'cr 80A # 30 b 45'
*                         phone = '3174501174' ).
*    INSERT  ztcustomer_a08 FROM @ls_customer.

    ls_technician = VALUE #( technician_id = '1'
                         name = 'Harold Trivino'
                         speciality = 'Developer Senior' ).
    Insert  ztechnician_a8 FROM @ls_technician.

    IF sy-subrc = 0.
      out->write( ' record inserted correctly' ).
    ELSE.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
