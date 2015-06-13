/**** Proceso Bomba ****/
PROCESS Bomba(x,y,tiempo,bomber bomberchan, byte durezas)
PRIVATE
	byte lag,i,muriendo,bomberman_rango;
	signed byte pos_x,pos_y;
BEGIN
	bomberchan.stats.bombas--;
	bomberman_rango=bomberchan.stats.rango;
	
	file=id_fpg_stages;
	
	graph=503;
	play_wav(id_wav_putbomb,0,1);
	z=502;
	
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	
	lag=0;

	muriendo=1;
	
	IF(map_get_pixel(id_fpg_stages,durezas,x,y-16)==id_color_rojo)
		tiempo = timer[0]+5; // 0.05 segundo más para morir... D:
		muriendo=0;
	ELSE
		tiempo=timer[0]+(tiempo);
		da_vinci(file,1,id_color_verde,x,y);
	END	
	
	WHILE(tiempo>timer[0])
		
		IF(map_get_pixel(id_fpg_stages,durezas,x,y-16)==id_color_rojo AND muriendo==1)
			tiempo = timer[0]+5; // 0.05 segundo más para morir... D:
			muriendo=0;
		END
		
		IF(lag==12)
			lag=0;
			Animacion(501,504);
		END

		lag++;
		FRAME;
	END
	play_wav(id_wav_explosion,0,2);
ONEXIT
	//da_vinci(file,1,id_color_negro,x,y); // Pinta negro en su posicion
	mapa[pos_x][pos_y].objeto=0; // Vuelve 0 la ID de su posicion
	
	IF(exists(bomberchan)) // Solo si aun vive el Bomber Padre
		bomberchan.stats.bombas++;	// Permite colocar una nueva bomba
	END
	
	bracito(x,y,"centro"); //Explosion al medio
	
	FOR(i=1;i<=bomberman_rango;i++) // Hacia arriba
		IF(pos_y-i>=0) // Determina el limite superior del mapa
			IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x][pos_y-i].en_x,mapa[pos_x][pos_y-i].en_y) != id_color_amarillo) // Si en algun cuadrado superior no se encuentra un bloque indestructible...
				IF(mapa[pos_x][pos_y-i].objeto==0) // Si en algun bloque superior no se encuentra otro objeto
					IF(i==bomberman_rango)
						bracito(x,y-(32*i),"arriba"); // Coloca un brazito final
					ELSE
						bracito(x,y-(32*i),"vertical"); // Coloca un brazito
					END
				ELSE
					IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x][pos_y-i].en_x,mapa[pos_x][pos_y-i].en_y-1) == id_color_verde) // Si hay otra bomba en algun bloque superior
						da_vinci(file,1,id_color_rojo,mapa[pos_x][pos_y-i].en_x,mapa[pos_x][pos_y-i].en_y);
						BREAK;
					ELSE
						signal(mapa[pos_x][pos_y-i].objeto,S_KILL);	// Mata al objeto
						BREAK;
					END	
				END
			ELSE
				BREAK; // Si encuentra un indestructible arriba se detiene
			END
		ELSE
			BREAK; // si alcanzo el limite superior se detiene
		END
	END
	
	FOR(i=1;i<=bomberman_rango;i++) //Hacia abajo
		IF(pos_y+i<=10)
			IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x][pos_y+i].en_x,mapa[pos_x][pos_y+i].en_y) != id_color_amarillo)
				IF(mapa[pos_x][pos_y+i].objeto==0)
					IF(i==bomberman_rango)
						bracito(x,y+(32*i),"abajo");
					ELSE
						bracito(x,y+(32*i),"vertical");
					END
				ELSE
					IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x][pos_y+i].en_x,mapa[pos_x][pos_y+i].en_y-1) == id_color_verde)
						da_vinci(file,1,id_color_rojo,mapa[pos_x][pos_y+i].en_x,mapa[pos_x][pos_y+i].en_y);
						BREAK;
					ELSE
						signal(mapa[pos_x][pos_y+i].objeto,S_KILL);
						BREAK;
					END
				END
			ELSE
				BREAK;
			END
		ELSE
			BREAK;
		END
	END
	
	FOR(i=1;i<=bomberman_rango;i++) //Hacia la derecha
		IF(pos_x+i<=12)
			IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x+i][pos_y].en_x,mapa[pos_x+i][pos_y].en_y) != id_color_amarillo)
				IF(mapa[pos_x+i][pos_y].objeto==0)
					IF(i==bomberman_rango)
						bracito(x+(32*i),y,"der");
					ELSE
						bracito(x+(32*i),y,"horizontal");
					END
				ELSE
					IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x+i][pos_y].en_x,mapa[pos_x+i][pos_y].en_y-1) == id_color_verde)
						da_vinci(file,1,id_color_rojo,mapa[pos_x+i][pos_y].en_x,mapa[pos_x+i][pos_y].en_y);
						BREAK;
					ELSE
						signal(mapa[pos_x+i][pos_y].objeto,S_KILL);
						BREAK;
					END
				END
			ELSE
				BREAK;
			END
		ELSE
			BREAK;
		END
	END
	
	FOR(i=1;i<=bomberman_rango;i++) //Hacia la izquierda
		IF(pos_x-i>=0)
			IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x-i][pos_y].en_x,mapa[pos_x-i][pos_y].en_y) != id_color_amarillo)
				IF(mapa[pos_x-i][pos_y].objeto==0)
					IF(i==bomberman_rango)
						bracito(x-(32*i),y,"izq");
					ELSE
						bracito(x-(32*i),y,"horizontal");
					END
				ELSE
					IF(map_get_pixel(id_fpg_stages,durezas,mapa[pos_x-i][pos_y].en_x,mapa[pos_x-i][pos_y].en_y-1) == id_color_verde)
						da_vinci(file,1,id_color_rojo,mapa[pos_x-i][pos_y].en_x,mapa[pos_x-i][pos_y].en_y);
						BREAK;
					ELSE
						signal(mapa[pos_x-i][pos_y].objeto,S_KILL);
						BREAK;
					END
				END
			ELSE
				BREAK;
			END
		ELSE
			BREAK;
		END
	END
END
/**************************************/

/**** Proceso bloque ****/
PROCESS bloque(x,y, byte mapa_elegido)
PRIVATE
	byte lag;
BEGIN
	z=503;
	
	file=id_fpg_stages;
	size=100;
	IF(mapa_elegido==1)
		graph=15;
	ELIF(mapa_elegido==2)
		graph=21;
	END
	lag=0;
	da_vinci(id_fpg_stages,1,id_color_azul,x,y);
	LOOP
		FRAME;
	END
ONEXIT
	bloque_muere(x,y);
END
/**************************************/

/**** Proceso bloque ****/
PROCESS bloque_muere(x,y)
PRIVATE
	byte lag, pos_x, pos_y;
BEGIN
	lag=0;
	file=id_fpg_stages;
	graph=father.graph;
	z=father.z;
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	WHILE(NOT(graph==20))
		IF(lag==5)
			lag=0;
			Animacion(016,020);
		END
		lag++;
		FRAME;
	END
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
	mapa[pos_x][pos_y].objeto=0;
	IF(mapa[pos_x][pos_y].item==700)
		mapa[pos_x][pos_y].objeto=item_bomba(x,y);
	ELIF(mapa[pos_x][pos_y].item==701)
		mapa[pos_x][pos_y].objeto=item_fuego(x,y);
	ELIF(mapa[pos_x][pos_y].item==702)
		mapa[pos_x][pos_y].objeto=item_fuego_max(x,y);
	ELIF(mapa[pos_x][pos_y].item==703)
		mapa[pos_x][pos_y].objeto=item_patines(x,y);
	ELIF(mapa[pos_x][pos_y].item==704)
		mapa[pos_x][pos_y].objeto=item_sandalia(x,y);
	ELIF(mapa[pos_x][pos_y].item==705)
		mapa[pos_x][pos_y].objeto=item_vidas(x,y);
	ELIF(mapa[pos_x][pos_y].item==706)
		mapa[pos_x][pos_y].objeto=item_armadura(x,y);
	END
END
/**************************************/

/**** Proceso item_bomba ****/
PROCESS item_bomba(x,y)
PRIVATE
	byte pos_x,pos_y;
BEGIN
	file=id_fpg_stages;
	graph=700;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END
	
ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_fuego****/
PROCESS item_fuego(x,y)
PRIVATE
	byte pos_x,pos_y;

BEGIN
	file=id_fpg_stages;
	graph=701;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END
	
ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_fuego_max ****/
PROCESS item_fuego_max(x,y)
PRIVATE
	byte pos_x,pos_y;

BEGIN
	file=id_fpg_stages;
	graph=702;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END
	
ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_patines ****/
PROCESS item_patines(x,y)
PRIVATE
	byte pos_x,pos_y;

BEGIN
	file=id_fpg_stages;
	graph=703;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END
	
ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_sandalia ****/
PROCESS item_sandalia(x,y)
PRIVATE
	byte pos_x,pos_y;
BEGIN
	file=id_fpg_stages;
	graph=704;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END

ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_vidas ****/
PROCESS item_vidas(x,y)
PRIVATE
	byte pos_x,pos_y;
BEGIN
	file=id_fpg_stages;
	graph=705;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END

ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/

/**** Proceso item_vidas ****/
PROCESS item_armadura(x,y)
PRIVATE
	byte pos_x,pos_y;
BEGIN
	file=id_fpg_stages;
	graph=706;
	z=504;
	borde_items(x,y);
	pos_x=locator(x,143);
	pos_y=locator(y,101);
	da_vinci(id_fpg_stages,1,id_color_blanco,x,y);
	LOOP
		IF(map_get_pixel(id_fpg_stages,1,x,y) == id_color_rojo)
				BREAK;
		END
		FRAME;
	END

ONEXIT
	mapa[pos_x][pos_y].item=0;
	mapa[pos_x][pos_y].objeto=0;
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);
END
/**************************************/
