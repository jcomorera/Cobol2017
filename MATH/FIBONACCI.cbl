       IDENTIFICATION DIVISION.
       PROGRAM-ID.FIBONACCI.
      ************************************************************
      * PROGRAMA QUE CALCULA LA SUMA DE LA SEQUENCIA DE FIBONACCI*
      * COMENÇANTANT PER 1 Y 2 FINS AL 4.000.000                 *
      ************************************************************
       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 VARIABLES.
           05 PRIMER-DIGIT        PIC 9(07) VALUE 1.
           05 SEGON-DIGIT        PIC 9(07) VALUE 2.
           05 DIGIT-AUXILIAR    PIC 9(07).
           05 SUMA-DIGITS        PIC 9(09) VALUE 3.
           05 NUMERO-DIGITS    PIC 9(07) VALUE 2.

       PROCEDURE DIVISION.
       INICIO.

       INITIALIZE DIGIT-AUXILIAR
       INITIALIZE SUMA-DIGITS
       PERFORM PROCES
       PERFORM FINALIZAR.

       PROCES.

       PERFORM VARYING NUMERO-DIGITS FROM 1 BY 1
            UNTIL NUMERO-DIGITS EQUAL 4000000

           COMPUTE DIGIT-AUXILIAR = PRIMER-DIGIT + SEGON-DIGIT
           IF DIGIT-AUXILIAR NOT EQUAL TO PRIMER-DIGIT
               AND DIGIT-AUXILIAR NOT EQUAL TO SEGON-DIGIT
               ADD DIGIT-AUXILIAR TO SUMA-DIGITS
               IF PRIMER-DIGIT < SEGON-DIGIT
                   IF SEGON-DIGIT NOT EQUAL TO DIGIT-AUXILIAR
                      MOVE DIGIT-AUXILIAR TO PRIMER-DIGIT
                   END-IF
                ELSE
                   IF PRIMER-DIGIT NOT EQUAL TO DIGIT-AUXILIAR
                       MOVE DIGIT-AUXILIAR TO SEGON-DIGIT
                   END-IF
                END-IF
           END-IF
       END-PERFORM
       DISPLAY "SUMA DIGITS:     "SUMA-DIGITS
       DISPLAY "NUMERO-DIGITS: "NUMERO-DIGITS
       DISPLAY "PRIMER-DIGIT:    "PRIMER-DIGIT
       DISPLAY "SEGON-DIGIT:    "SEGON-DIGIT
       DISPLAY "DIGIT-AUXILIAR:"DIGIT-AUXILIAR.

       FINALIZAR.EXIT.

       GOBACK.
