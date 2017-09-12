# Cobol2017
	Programas simples utilizando cobol.
	
	Algunos de los códigos que trabajan con ficheros son optimizables,
	debido a que el copilador online no acepta ficheros i/o.
	
	CSV_SIMPLETXT:  -Convierte un fichero csv a un fichero de texto line-sequencial.
			-Elimina el delimitador, en este caso la ','.
			-Utiliza SORT para ordenar los registros.
			-Elimina repeticiones y muestra numero de repeticiones.	
			-Crea el informe en un documento .txt , pudiendo cambiar el formato en la input-ouput section.
	
	SIMPLETXT-XML:	-Utilizando el informe generado en el CSV_SIMPLETXT, convertimos el texto a formato .xml simple.
			-Se podria utilizar este proceso para grandes cantidades de datos.
			-Con poca modificacíon creariamos elementos raiz.

	SIMPLETXT-JSON:	-Utilizando el informe generado en el CSV_SIMPLETXT, convertimos el texto a formato .json simple.
			-Se podria utilizar este proceso para grandes cantidades de datos.
			
	TXT-CSV:	-Utilizando el informe en formato .txt generado en el CSV_SIMPLETXT hacemos la conversion a formato csv.
			-Se conservan los caracteres de espacio para una futura conversion.
	
	CRUCE_FICHEROS: -Cruces de ficheros: 1-1 | 1-N | N-N | 1-1-1 | 1-1-1-1 .
			
			
