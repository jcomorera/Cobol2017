IDENTIFICATION DIVISION.
PROGRAM-ID. CRUCE-ARCHIVOS.
ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER.           IBM-3083.
       OBJECT-COMPUTER.           IBM-3083.
	   INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
	   SELECT FITXER1 ASSIGN TO "FITXER1.TXT" STATUS IS FS-FITXER1.
	   SELECT FITXER2 ASSIGN TO "FITXER2.TXT" STATUS IS FS-FITXER2.
	   SELECT SORTIDA ASSIGN TO "SORTIDA.TXT" STATUS IS FS-SORTIDA.

DATA DIVISION.
FILE SECTION.
FD FITXER1
	DATA RECORD IS REG-FITXER1.
	01 REG-FITXER1.
		05 REG-ID1 	PIC 9(3).
		05 REG-NOM 	PIC X(10).
FD FITXER2
	DATA RECORD IS REG-FITXER2.
	01 REG-FITXER2.
		05 REG-ID2 		PIC 9(3).
		05 REG-CUENTA 	PIC X(10).
FD SORTIDA
	DATA RECORD IS REG-SORTIDA.
	01 REG-SORTIDA.
		05 REG-TEXT-SORTIDA 	PIC X(80).
		
WORKING-STORAGE SECTION.
	01 WX-FITXER1.
		05 WX-ID1 PIC 9(3).
		05 WX-NOM PIC X(10).
	01 WX-FITXER2.
		05 WX-ID2    PIC 9(3).
		05 WX-CUENTA PIC X(10).
	01 FS-STATUS.
		05 FS-FITXER1 PIC X(2).
		05 FS-FITXER2 PIC X(2).
		05 FS-SORTIDA PIC X(2).
	01 VARIABLES.
		05 ID1    PIC 9(3).
		05 NOM    PIC X(10).
		05 ID2    PIC 9(3).
		05 CUENTA PIC X(10).
		
	01 MISATGES.
		05 MSG-IGUAL.
			10 FILLER           PIC X(8) VALUE "LA CLAU ".
			10 MSG-IGUAL-ID1    PIC 9(3).
			10 FILLER           PIC X(9) VALUE " AMB NOM ".
			10 MSG-IGUAL-NOM    PIC X(10).
			10 FILLER           PIC X(30) VALUE " TÉ EL NUMERO DE COMPTE ".
			10 MSG-IGUAL-CUENTA PIC X(10).
		05 MSG-MENOR.
			10 FILLER           PIC X(8) VALUE "LA CLAU ".
			10 MSG-MENOR-ID1    PIC 9(3).
			10 FILLER           PIC X(24) VALUE " NO TÉ NUMERO DE COMPTE".
		05 MSG-MAJOR.
			10 FILLER           PIC X(38) VALUE "NO HI HA TITULAR PEL NUMERO DE COMPTE ".
			10 MSG-MAJOR-CUENTA PIC X(10).
			
	01 VALORS.
		05 VALORID01    PIC 9(03).
		05 VALORID02    PIC 9(03).
		05 VALORNOM		PIC X(10).
		05 VALORCUENTA  PIC X(10).
		
	01 TAULA-AUX.
		05 CUENTA-AUX	PIC X(10) OCCURS 7 TIMES.
		
	01 UTILITARIS.
		05 INDEXT		PIC 9(01).
		05 CONTADOR		PIC 9(01).
							
	88 FINAL-FITXER1 VALUE 'TRUE'.
	88 FINAL-FITXER2 VALUE 'TRUE'.
		
	
	
PROCEDURE DIVISION.
	INICI.
		PERFORM OBRIR-FITXERS THRU 010-FINAL
		PERFORM LLEGIR-FITXER1 THRU 020-FINAL
		PERFORM LLEGIR-FITXER2 THRU 030-FINAL
		PERFORM PROCES THRU 040-FINAL UNTIL FINAL-FITXER1 OR FINAL-FITXER2		
		GOBACK.
		
		
	OBRIR-FITXERS.
		OPEN INPUT FITXER1
		OPEN INPUT FITXER2
		OPEN OUTPUT SORTIDA.
	010-FINAL. EXIT.
	
	LLEGIR-FITXER1.
		READ FITXER1 INTO WX-FITXER1
		
		EVALUATE FS-FITXER1
			WHEN ZEROES
				MOVE WX-ID1 TO ID1
				MOVE WX-NOM TO NOM
			WHEN 10
				SET FINAL-FITXER1 TO TRUE
				MOVE HIGH-VALUES TO ID1
			WHEN OTHER
				PERFORM 070-FINAL
			END-EVALUATE.
	020-FINAL. EXIT.
	
	LLEGIR-FITXER2.
		READ FITXER2 INTO WX-FITXER2
		
		EVALUATE FS-FITXER2
			WHEN ZEROES
				MOVE WX-ID2 TO ID2
				MOVE WX-CUENTA TO CUENTA
			WHEN 10
				SET FINAL-FITXER2 TO TRUE
				MOVE HIGH-VALUES TO ID2
			WHEN OTHER
				PERFORM 070-FINAL
			END-EVALUATE.
	030-FINAL. EXIT.
	
	PROCES.
		EVALUATE TRUE
			WHEN ID1 = ID2
				MOVE ID2 TO VALORID02
				MOVE ID1 TO VALORID01
				MOVE CUENTA TO VALORCUENTA
				MOVE NOM TO VALORNOM
				PERFORM LLEGIR-FITXER2		
				IF ID2 NOT EQUAL TO VALORID02
				THEN
				MOVE VALORCUENTA TO CUENTA-AUX (1)
				MOVE 1 TO INDEXT
				PERFORM	(UNTIL ID2 EQUAL VALORID02) OR FINAL-FITXER2
					ADD 1 TO INDEXT
					MOVE CUENTA TO CUENTA-AUX (INDEXT)
					PERFORM LLEGIR-FITXER2
					MOVE ID2 TO VALORID02
				END-PERFORM
					MOVE 0 TO INDEXT
					ADD 1 TO CONTADOR
				PERFORM UNTIL ID1 > VALORID01 OR FINAL-FITXER1
					PERFORM UNTIL INDEXT EQUAL TO CONTADOR
						ADD 1 TO INDEXT
						MOVE ID1 TO MSG-IGUAL-ID1
						MOVE NOM TO MSG-IGUAL-NOM
						MOVE CUENTA-AUX (INDEXT) TO MSG-IGUAL-CUENTA
						WRITE REG-SORTIDA FROM MSG-IGUAL BEFORE ADVANING 1 LINE
					END-PERFORM
					PERFORM LLEGIR-FITXER1
					MOVE ID1 TO VALORID01
					MOVE 0 TO INDEXT
				END-PERFORM		
				ELSE
				MOVE VALORID01 TO MSG-IGUAL-ID1
				MOVE VALORNOM TO MSG-IGUAL-NOM
				MOVE VALORCUENTA TO MSG-IGUAL-CUENTA
				WRITE REG-SORTIDA FROM MSG-IGUAL BEFORE ADVANING 1 LINE
				END-IF
				
			WHEN ID1 < ID2
				MOVE ID1 TO MSG-MENOR-ID1
				WRITE REG-SORTIDA FROM MSG-MENOR BEFORE ADVANING 1 LINE
				PERFORM LLEGIR-FITXER1
				
			WHEN ID1 > ID2
				MOVE CUENTA TO MSG-MAJOR-CUENTA
				WRITE REG-SORTIDA FROM MSG-MAJOR BEFORE ADVANING 1 LINE
				PERFORM LLEGIR-FITXER2
				
		END-EVALUATE.
	040-FINAL. EXIT.
	
	070-FINAL.
		CLOSE FITXER1
			  FITXER2
		      SORTIDA
		STOP RUN
		GOBACK.
		