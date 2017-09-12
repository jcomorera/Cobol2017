	   IDENTIFICATION DIVISION.
	   PROGRAM-ID. TST.
	   ENVIRONMENT DIVISION.
	   INPUT-OUTPUT SECTION.
	   FILE-CONTROL.
		   SELECT SEQUENCIAL
			   ASSIGN TO "SEQUENCIAL.TXT"
				   ORGANIZATION IS LINE SEQUENTIAL.
		   SELECT INDEXADO
			   ASSIGN TO "INDEXAT.TXT"
				   ACCESS MODE IS SEQUENTIAL
				   ORGANIZATION IS INDEXED
				   RECORD KEY IS NUMERO1.

	   DATA DIVISION.
	   FILE SECTION.
	   FD SEQUENCIAL.
			 01 SEQUENCIAL-OUT.
				  05 NUMERO      		PIC 9(5).
				  05 NOMBRE        		PIC X(20).
				  05 CANTIDAD 			PIC 9(3).
				  05 PREU-UNITAT       	PIC 9(4)V99.
				  05 ORDRE  			PIC 9(3).
				  05 ID-PRODUCTE    	PIC X(2).

	   FD INDEXADO.
			  01 INDEXADO-IN.
					 05 NUMERO1     	PIC 9(5).
					 05 NOMBRE        	PIC X(20).
					 05 CANTIDAD 		PIC 9(3).
					 05 PREU-UNITAT     PIC 9(4)V99.
					 05 ORDRE   		PIC 9(3).
					 05 ID-PRODUCTE     PIC X(2).

	   WORKING-STORAGE SECTION.
		   01 FIN-FICHERO PIC X(5) VALUE "FALSE".

	   PROCEDURE DIVISION.
	   REBUILD-RTN.
		   OPEN OUTPUT SEQUENCIAL
		   OPEN INPUT INDEXADO
		   READ INDEXADO
		   AT END SET FIN-FICHERO TO "TRUE"
		   END-READ
		   
	   PERFORM UNTIL FIN-FICHERO EQUAL "TRUE"
		   WRITE SEQUENCIAL-OUT FROM INDEXADO-IN
		   END-WRITE
		   READ INDEXADO 
		   END-READ
	   END-PERFORM.

	   CLOSE INDEXADO, SEQUENCIAL.
	   STOP RUN.  
