CLASS zcl_lab_02_arithmetic_agora08 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_base_rate_sum        TYPE i VALUE 20,
          lv_corp_area_rate       TYPE i VALUE 10,
          lv_medical_service_rate TYPE i VALUE 15,
          lv_total_rate           TYPE i,
          lv_maintenance_rate     TYPE i VALUE 30,
          lv_margin_rate          TYPE i VALUE 10,
          lv_base_rate_res        TYPE i,
          lv_package_weight       TYPE i VALUE 2,
          lv_cost_per_kg          TYPE i VALUE 3,
          lv_multi_rate           TYPE i,
          lv_total_weight         TYPE i VALUE 38,
          lv_num_packages         TYPE i VALUE 4,
          lv_applied_rate         TYPE p LENGTH 8 DECIMALS 2,
          lv_total_cost           TYPE i VALUE 17,
          lv_discount_threshold   TYPE i VALUE 4,
          lv_result               TYPE p LENGTH 4 DECIMALS 2,
          lv_remainder            TYPE p LENGTH 4 DECIMALS 2,
          lv_weight               TYPE i VALUE 5,
          lv_expo                 TYPE i,
          lv_square_root          TYPE i.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_LAB_02_ARITHMETIC_AGORA08 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**** Suma / Sentencia ADD

    lv_total_rate = lv_base_rate_sum + lv_corp_area_rate + lv_medical_service_rate.
    out->write( | Total Rate SUM: { lv_total_rate } | ).

    ADD 5 TO lv_total_rate.
    out->write( | Total Rate ADD: { lv_total_rate } | ).

**** Resta / Sentencia SUBTRACT

    lv_base_rate_res = lv_maintenance_rate - lv_margin_rate.
    out->write( | Total Rate Res: { lv_base_rate_res } | ).

    SUBTRACT 4 FROM lv_base_rate_sum.
    out->write( | Total Rate SUBTRACT: { lv_base_rate_res } | ).

**** Multiplicación / Sentencia MULTIPLY
    lv_multi_rate = lv_package_weight * lv_cost_per_kg.
    out->write( | Total Rate Multi: { lv_multi_rate } | ).

    MULTIPLY lv_multi_rate BY 2.
    out->write( | Total Rate Multiply: { lv_multi_rate } | ).

****División / Sentencia DIVIDE

    lv_applied_rate = lv_total_weight / lv_num_packages.
    out->write( | Total Rate Division: { lv_applied_rate } | ).

    DIVIDE lv_applied_rate BY 3.
    out->write( | Total Rate Divide: { lv_applied_rate } | ).

****División sin resto / Sentencia DIV

    lv_result = lv_total_cost DIV lv_discount_threshold.
    out->write( | Total resul DIV: { lv_result } | ).

****Resto (residuo) de división / Sentencia MOD
    lv_total_cost = 19.
    lv_discount_threshold = 4.

    lv_remainder = lv_total_cost MOD lv_discount_threshold.
    out->write( | Total resul MOD: { lv_remainder } | ).

****Exponenciación
    lv_expo = lv_weight ** 2.
    out->write( | Total Expo: { lv_expo } | ).

    lv_expo = ipow( base = lv_weight exp = 2 ).
    out->write( | Total Expo ipow: { lv_expo } | ).

****Raíz cuadrada
    lv_square_root = sqrt( lv_expo ).
    out->write( | Total SQRT variable Expo: { lv_square_root } | ).

  ENDMETHOD.
ENDCLASS.
