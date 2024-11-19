CLASS zcl_07_agora08_campotexto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_07_AGORA08_CAMPOTEXTO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

***** Text symbols
    out->write( TEXT-001 ).
    out->write( TEXT-msg ).

***** Parameters
    DATA lv_text TYPE string VALUE 'AGORA ABAP'.
    DATA(lv_string) = find( val = lv_text sub = 'A' case = abap_true occ = 1 off = 3 ).

    out->write( lv_string ).

***** Funciones de descripcion
    "strlen() and numofchar()

    DATA(lv_num) = numofchar( lv_text ).
    out->write( lv_num ).
    DATA(lv_num1) = strlen( lv_text ).
    out->write( lv_num1 ).

    "Funciones de busqueda
    "count()

    DATA(lv_string1) = '   AGORA ABaP  '.
    lv_num = count( val = lv_string1 sub = 'A' ).
    out->write( | Count: { lv_num } | ).

    lv_num = count_any_of( val = lv_string1 sub = 'AB' ).
    out->write( | Count any of: { lv_num } | ).

    lv_num = count_any_not_of( val = lv_string1 sub = 'AB' ).
    out->write( | Count any not of: { lv_num } | ).

    " Find
    lv_num = find( val = lv_string1 sub = 'RA' ).
    out->write( | find: { lv_num } | ).

    lv_num = find_any_of( val = lv_string1 sub = 'RA' ).
    out->write( | Find any of: { lv_num } | ).

    lv_num = find_any_not_of( val = lv_string1 sub = 'RA' ).
    out->write( | Find any not of: { lv_num } | ).


***** Funciones de Procesamiento

    DATA lv_text1 TYPE string VALUE '¡Harold Trivino! de AGORA bienvenido a ABAP Cloud Master'.

    "Mayus Minus
    out->write( | To Upper = {      to_upper( lv_text1 ) } | ).
    out->write( | To Lower = {      to_lower( lv_text1 ) } | ).
    out->write( | To Mixed = {      to_mixed( lv_text1 ) } | ).
    out->write( | From Upper = { from_mixed(  lv_text1 ) } | ).

    "order
    out->write( | Reverse = { reverse( lv_text1 ) } | ).
    out->write( | shift left places = { shift_left( val = lv_text1 places = 5 ) } | ).
    out->write( | shift right places = { shift_right( val = lv_text1 places = 5 ) } | ).
    out->write( | shift left circ = { shift_left( val = lv_text1 circular = 5 ) } | ).
    out->write( | shift right circ = { shift_right( val = lv_text1 circular = 5 ) } | ).

    "Substring
    out->write( | substring         = { substring(          val = lv_text1 off = 7 len = 9 ) } | ).
    out->write( | Substring_from    = { substring_from(     val = lv_text1 sub = 'Trivino' ) } | ).
    out->write( | Substring_after   = { substring_after(    val = lv_text1 sub = 'Trivino' ) } | ).
    out->write( | Substring_to      = { substring_to(       val = lv_text1 sub = 'Trivino' ) } | ).
    out->write( | Substring_before  = { substring_before(   val = lv_text1 sub = 'Trivino' ) } | ).

    "others
    out->write( | condense =    { condense( val = lv_text1 ) } | ).
    out->write( | Repeat  =     { repeat(   val = lv_text1 occ = 2 ) } | ).
    out->write( | segment1  =   { segment(  val = lv_text1 sep = '!' index = 1 ) } | ).
    out->write( | segment2  =   { segment(  val = lv_text1 sep = '!' index = 2 ) } | ).

















  ENDMETHOD.
ENDCLASS.
