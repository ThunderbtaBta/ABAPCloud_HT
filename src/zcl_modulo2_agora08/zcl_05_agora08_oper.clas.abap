CLASS zcl_05_agora08_oper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_05_AGORA08_OPER IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*******OPERADORES
    DATA: lv_num_a TYPE i VALUE 10,
          lv_num_b TYPE i VALUE 6,
          lv_total TYPE p LENGTH 6 DECIMALS 2.

* SUMA
    " +
*    lv_total = lv_num_a + lv_num_b.
*    out->write( | Numero a: { lv_num_a } Numero b: { lv_num_b } Total: { lv_total } | ).
*
*    "ADD
*    ADD 5 TO lv_total.
*    out->write( | Total ADD: { lv_total } | ).
*
*    "Acumuladores +=   Asignacion compuesta
*
*    lv_total += 10.
*    out->write( | Total Acumuladores: { lv_total } | ).
*
*    "Limpiar Variable
*    CLEAR lv_total.
*    out->write( | Limpiar Variable : { lv_total } | ).


* RESTA
*    "-
*    lv_total = lv_num_a - lv_num_b.
*    out->write( | Numero a: { lv_num_a } Numero b: { lv_num_b } Total: { lv_total } | ).
*
*    " SUBTRACT
*    SUBTRACT 2 FROM lv_total.
*    out->write( | Total SUBTRACT: { lv_total } | ).
*
*    "-=  Asignacion compuesta
*    lv_total -= 1.
*    out->write( | Total Asignacion compuesta: { lv_total } | ).

* Multiplicacion
    "*
    lv_total = lv_num_a * lv_num_b.
    out->write( | Numero a: { lv_num_a } Numero b: { lv_num_b } Total: { lv_total } | ).

    " Multiply
    MULTIPLY lv_total BY 2.
    out->write( | Total MULTIPLY: { lv_total } | ).

    MULTIPLY lv_total BY lv_num_b.
    out->write( | Total MULTIPLY 2 var: { lv_total } | ).

    "*=  Asignacion compuesta
    lv_total *= 2.
    out->write( | Total Asignacion compuesta: { lv_total } | ).

* Division
*    " /
*    lv_total = lv_num_a / lv_num_b.
*    out->write( | Numero a: { lv_num_a } Numero b: { lv_num_b } Total: { lv_total } | ).
*
*    " Divide
*
*    DIVIDE lv_total BY 2.
*    out->write( | Total Divide: { lv_total } | ).
*
*    CLEAR lv_total.
*
*    lv_total = ( lv_num_a * lv_num_b ) / 3.
*    out->write( | Total promedio: { lv_total } | ).
*
**** DIV
*    lv_num_a = 15.
*    lv_num_b = 2.
*
*    lv_total = lv_num_a / lv_num_b.
*    out->write( | Total division: { lv_total } | ).
*
*    lv_total = lv_num_a DIV lv_num_b.
*    out->write( | Total div: { lv_total } | ).
*
**** MOD
*    lv_num_a = 15.
*    lv_num_b = 2.
*
*    lv_total = lv_num_a / lv_num_b.
*    out->write( | Total division: { lv_total } | ).
*
*    lv_total = lv_num_a MOD lv_num_b.
*    out->write( | Total Mod: { lv_total } | ).


* Exponencial
*    lv_num_a = 3.
*    out->write( | Numero a: { lv_num_a } | ).
*
*    lv_num_a = lv_num_a ** 2.
*    out->write( | Numero a expo 2: { lv_num_a } | ).
*
*    CLEAR lv_num_a.
*
*    lv_num_a = 3.
*    DATA(lv_expo) = 3.
*    lv_num_a = lv_num_a ** lv_expo.
*    out->write( | Numero a expo variable: { lv_num_a } | ).

    "ipow
*    lv_num_a = 3.
*    DATA(lv_result) = ipow( base = 2 exp = 3 ).
*    out->write( | Numero ipow : { lv_result } | ).
*
*    DATA(lv_result1) = ipow( base = lv_num_a exp = lv_num_b ).
*    out->write( | Numero ipow : { lv_result1 } | ).

* Raiz Cuadrada SQRT
*    lv_num_a = sqrt( 25 ).
*    out->write( | Numero SQRT : { lv_num_a } | ).
*
*    lv_num_b = 9.
*    lv_num_b = sqrt( lv_num_b ).
*    out->write( | Numero SQRT : { lv_num_b } | ).


  ENDMETHOD.
ENDCLASS.
