       IDENTIFICATION DIVISION.
       PROGRAM-ID.WEBR.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INFILE01 ASSIGN TO "FA.txt"
                  ORGANIZATION IS LINE SEQUENTIAL
                  STATUS IS FS-INFILE01.
           SELECT INFILE02 ASSIGN TO "FB.txt"
                  ORGANIZATION IS LINE SEQUENTIAL
                  STATUS IS FS-INFILE02.
           SELECT WEB ASSIGN TO "report.html"
                   ORGANIZATION IS LINE SEQUENTIAL
                   STATUS IS FS-WEB.
       DATA DIVISION.
       FILE SECTION.
       FD INFILE01.
       01 REG-INFILE01.
            05 FILLER    PIC X(100).
       FD INFILE02.
       01 REG-INFILE02.
            05 FILLER    PIC X(100).
       FD WEB.
       01 REG-WEB.
           05 FILLER   PIC X(100).

       WORKING-STORAGE SECTION.

       01 WS-VARIABLES.
           05 WS-VARIABLE01        PIC X(80).
           05 WS-VARIABLE02        PIC X(80).
       01 FILE-STATUS.
           05 FS-INFILE01 PIC X(02).
           05 FS-INFILE02 PIC x(02).
           05 FS-WEB PIC X(02).
       01 HTML.
           05 HTML00     PIC X(70) VALUE
           "<!DOCTYPE HTML><html>".
           05 HTML01     PIC X(70) VALUE
           "<head><title>WEBREPORT</title></head>".
           05 HTML02     PIC X(60) VALUE
           "<body STYLE=""background-color:grey""><h1>WEBREPORT</h1>".
		   05 HTML0202     PIC X(60) VALUE
           "<h1 STYLE=""align:center"">WEBREPORT</h1>".
           05 HTML03     PIC X(60) VALUE
           "<table STYLE=""align:center,border:4px"">".
           05 HTML04     PIC X(10) VALUE
           "<tr>".
           05 HTML05     PIC X(10) VALUE
           "</tr>".
           05 HTML06     PIC X(10) VALUE
           "<td>".
           05 HTML07     PIC X(10) VALUE
           "</td>".
           05 HTML08     PIC X(30) VALUE
           "</table></body></html>".

       01 SWITCHES PIC X.
           88 FIN-FICHER VALUE'S'.
           88 NO-FIN-FICHER VALUE'N'.

       PROCEDURE DIVISION.

       INCIO.
        PERFORM OBRIR-FITXERS
        PERFORM PROCES
        PERFORM FINALIZAR.
       FIN.EXIT.

       OBRIR-FITXERS.

       OPEN INPUT INFILE01
               INFILE02
       OPEN OUTPUT WEB.

       FIN.EXIT.

       LLEGIR01.
       READ INFILE01
       SET NO-FIN-FICHER TO TRUE
       EVALUATE FS-INFILE01
           WHEN ZEROES
               MOVE REG-INFILE01 TO WS-VARIABLE01
           WHEN 10
               SET FIN-FICHER TO TRUE
               DISPLAY "FINAL FICHER1"
           WHEN OTHER
               SET FIN-FICHER TO TRUE
               DISPLAY "ERROR AL OBRIR EL FITXER1"
               DISPLAY "ERROR NUM: "FS-INFILE01
       END-EVALUATE.
       FIN.EXIT.

       LLEGIR02.
       READ INFILE02
       SET NO-FIN-FICHER TO TRUE
       EVALUATE FS-INFILE02
           WHEN ZEROES
               MOVE REG-INFILE02 TO WS-VARIABLE02
           WHEN 10
               SET FIN-FICHER TO TRUE
               DISPLAY "FINAL FICHER2"
           WHEN OTHER
               SET FIN-FICHER TO TRUE
               DISPLAY "ERROR AL OBRIR EL FITXER2"
               DISPLAY "ERROR NUM: "FS-INFILE02
       END-EVALUATE.
       FIN.EXIT.

       WEBS.
       WRITE REG-WEB FROM HTML00
       WRITE REG-WEB FROM HTML01
       WRITE REG-WEB FROM HTML02.
       WRITE REG-WEB FROM HTML0202.
       WRITE REG-WEB FROM HTML03.
       FIN.EXIT.

       PROCES.
       PERFORM WEBS
	   SET NO-FIN-FICHER TO TRUE
       PERFORM UNTIL FIN-FICHER
           PERFORM LLEGIR01
           PERFORM LLEGIR02
           WRITE REG-WEB FROM HTML04
           WRITE REG-WEB FROM HTML06
           WRITE REG-WEB FROM WS-VARIABLE01
		   WRITE REG-WEB FROM HTML07
		   WRITE REG-WEB FROM HTML06
		   WRITE REG-WEB FROM WS-VARIABLE02
		   WRITE REG-WEB FROM HTML07
		   WRITE REG-WEB FROM HTML05
           
           WRITE REG-WEB FROM SPACES
       END-PERFORM
       WRITE REG-WEB FROM HTML07.

       FIN.EXIT.
       FINALIZAR.
       STOP RUN.
       GOBACK.
       END PROGRAM WEBR.
