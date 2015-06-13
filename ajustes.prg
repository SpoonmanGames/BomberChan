/**** Funcion ocupado ****/
FUNCTION ocupado(byte lx, byte ly)
BEGIN
	RETURN mapa[ lx ][ ly ].objeto;
END
/**************************************/

/**** Funcion locator ****/
FUNCTION locator(int posicion, int rango)
//rango: >143 para X y >101 para Y
PRIVATE
	byte lugar;
	int referencia;
BEGIN
	lugar=0;
	referencia=posicion;
	
	WHILE(referencia>rango)
		referencia -= 32;
		lugar++;
	END
	RETURN lugar;
END
/**************************************/
