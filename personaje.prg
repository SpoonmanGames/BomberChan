/**** Proceso Bomber ****/
PROCESS Bomber(co_x,co_y,file,byte player, byte map_durezas)
PRIVATE

	byte			orientacion_final;
	byte			wait;	//la espera que acumula bomber para aburrirse
	byte			lag;	//demora del frame
	byte			rate_of_fire;
	byte			pos_x,pos_y;
	boolean			vertical, horizontal;
	string 			direccion_auto;
	byte 			inmune,parpadeo,veces,contador,velocidad;	

BEGIN
	
	stats.player=player;
	resolution=100;
	x=co_x*resolution;
	y=co_y*resolution;
	size=100;
	graph_inicial=1;
	graph_final=1;
	wait=0;
	lag=3;
	rate_of_fire=15;
	inmune=0;
	alpha=255;
	
	horizontal=false;
	vertical=false;
	
	IF(config_botones_player[stats.player].dispositivo==0) // Controles con Teclado
	
		LOOP
			z=500-(y/resolution);
			pos_x=locator(x/resolution,143);
			pos_y=locator(y/resolution,101+14); // Gap de 2 en el eje Vertical Y
		
			IF(key(config_botones_player[stats.player].boton_bomba))
				//delete_text(0);
				wait=0;
				IF(stats.bombas>0 && NOT(ocupado(pos_x,pos_y)) && rate_of_fire>14)
						
						mapa[pos_x][pos_y].objeto = Bomba(mapa[pos_x][pos_y].en_x,mapa[pos_x][pos_y].en_y,250,ID,map_durezas);
						rate_of_fire=0;
					END
				rate_of_fire++;
			ELSE
				rate_of_fire=15;
			END
			
			IF (key(config_botones_player[stats.player].boton_izquierda) AND vertical AND(key(config_botones_player[stats.player].boton_abajo) OR key(config_botones_player[stats.player].boton_arriba)))
			//vertical
				wait=0;
				//graph_inicial=31;
				//graph_final=40;
				IF(key(config_botones_player[stats.player].boton_abajo)) direccion_auto="DOWN"; ELIF (key(config_botones_player[stats.player].boton_arriba)) direccion_auto="UP"; END
				Avanzar(_mover_izq,ID,map_durezas,direccion_auto);
				flags = 1;
				orientacion_final=3;	
			ELIF (key(config_botones_player[stats.player].boton_derecha) AND vertical AND (key(config_botones_player[stats.player].boton_abajo) OR key(config_botones_player[stats.player].boton_arriba)))			
			//vertical
				wait=0;
				//graph_inicial=31;
				//graph_final=40;
				IF(key(config_botones_player[stats.player].boton_abajo)) direccion_auto="DOWN"; ELIF (key(config_botones_player[stats.player].boton_arriba)) direccion_auto="UP"; END
				Avanzar(_mover_der,ID,map_durezas,direccion_auto);
				flags = 0;
				orientacion_final=3;
			ELIF (key(config_botones_player[stats.player].boton_abajo) AND (key(config_botones_player[stats.player].boton_izquierda) OR key(config_botones_player[stats.player].boton_derecha)))
			//horizontal
				wait=0;
				//graph_inicial=11;
				//graph_final=20;
				direccion_auto="DOWN";
				IF(key(config_botones_player[stats.player].boton_izquierda)) 
					Avanzar(_mover_izq,ID,map_durezas,direccion_auto); 
				ELIF(key(config_botones_player[stats.player].boton_derecha)) 
					Avanzar(_mover_der,ID,map_durezas,direccion_auto);
				END
				orientacion_final=2;	
			ELIF (key(config_botones_player[stats.player].boton_arriba) AND (key(config_botones_player[stats.player].boton_izquierda) OR key(config_botones_player[stats.player].boton_derecha)))
			//horizontal
				wait=0;
				//graph_inicial=21;
				//graph_final=30;
				direccion_auto="UP";
				IF(key(config_botones_player[stats.player].boton_izquierda)) 
					Avanzar(_mover_izq,ID,map_durezas,direccion_auto); 
				ELIF(key(config_botones_player[stats.player].boton_derecha)) 
					Avanzar(_mover_der,ID,map_durezas,direccion_auto);
				END
				orientacion_final=1;
			ELIF (key(config_botones_player[stats.player].boton_abajo))
				wait=0;
				graph_inicial=11;
				graph_final=20;
				Avanzar(_mover_abajo,ID,map_durezas,"OFF");
				vertical=true;
				orientacion_final=2;	
			ELIF (key(config_botones_player[stats.player].boton_arriba))
				wait=0;
				graph_inicial=21;
				graph_final=30;
				Avanzar(_mover_arriba,ID,map_durezas,"OFF");
				vertical=true;
				orientacion_final=1;
			ELIF (key(config_botones_player[stats.player].boton_izquierda) AND NOT(horizontal))
				wait=0;
				graph_inicial=31;
				graph_final=40;
				Avanzar(_mover_izq,ID,map_durezas,"OFF");
				flags = 1;
				vertical=false;
				orientacion_final=3;	
			ELIF (key(config_botones_player[stats.player].boton_derecha))			
				wait=0;
				graph_inicial=31;
				graph_final=40;
				Avanzar(_mover_der,ID,map_durezas,"OFF");
				flags = 0;
				vertical=false;
				horizontal=true;
				orientacion_final=3;
			ELIF (key(config_botones_player[stats.player].boton_izquierda))
				wait=0;
				graph_inicial=31;
				graph_final=40;
				Avanzar(_mover_izq,ID,map_durezas,"OFF");
				flags = 1;
				vertical=false;
				horizontal=false;
				orientacion_final=3;	
			ELIF (wait==200)
				graph_inicial=1;
				graph_final=1;
				IF(graph==1) 
					wait=-100;
				END			
			ELSE  
				wait++;
				IF(orientacion_final==_Pos_arriba)
					graph_inicial=2; 
					graph_final=2;
				END
				IF(orientacion_final==_Pos_abajo)
					graph_inicial=1;
					graph_final=1;
				END
				IF(orientacion_final==_Pos_lateral)
					graph_inicial=3; 
					graph_final=3;
				END			
			END
			
			IF(lag==3)
				lag=0;
				Animacion(graph_inicial,graph_final);
			END
			
			IF(map_get_pixel(id_fpg_stages,map_durezas,x/resolution,(y/resolution)-16) == id_color_rojo AND inmune==0)
				stats.vidas--;
				inmune=1;
				veces=3; contador=0;
				parpadeo=0; velocidad=1;
			END
			
			IF (map_get_pixel(id_fpg_stages,map_durezas,x/resolution,(y/resolution)-16) == id_color_blanco)
			
				pos_x=locator(x/resolution,143);
				pos_y=locator((y/resolution)-16,101);
				
				IF(mapa[pos_x][pos_y].item==700)
					stats.bombas++;
				ELIF(mapa[pos_x][pos_y].item==701)
					IF(stats.rango!=8)
						stats.rango++;
					END
				ELIF(mapa[pos_x][pos_y].item==702)
					stats.rango=8;
				ELIF(mapa[pos_x][pos_y].item==703)
					stats.velocidad += 20;
				ELIF(mapa[pos_x][pos_y].item==704)
					stats.velocidad -= 20;
				ELIF(mapa[pos_x][pos_y].item==705)
					stats.vidas++;
				ELIF(mapa[pos_x][pos_y].item==706)
					inmune=1;
					contador=0;	veces=16;
					parpadeo=0; velocidad=0;
				END
				signal(mapa[pos_x][pos_y].objeto, S_KILL);
			END
			
			IF(stats.vidas==0)
				BREAK;
			ELSE
				IF(inmune==1)		
					IF(velocidad==0)
						inmune(parpadeo,velocidad);		//lento
						IF(parpadeo==60) parpadeo=0; contador++; END
						IF(contador==((veces*75)/100)) velocidad=1; END
					ELIF(velocidad==1)					
						inmune(parpadeo,velocidad); 	//rapido
						IF(parpadeo==30) parpadeo=0; contador++; END
					END
					
					parpadeo++;

					IF(contador==veces)
						alpha=255;
						inmune=0;
					END
				END
			END
			
			lag++;
			FRAME;
			
		END
	
	ELSE // Controles con Joystick
	
		LOOP
			z=500-(y/resolution);
			pos_x=locator(x/resolution,143);
			pos_y=locator(y/resolution,101+14); // Gap de 2 en el eje Vertical Y
			
			// Se asume que bomba siempre estara asignada a un boton
			IF (joy_getbutton(stats.player,config_botones_player[stats.player].boton_bomba))
				wait=0;
					IF(stats.bombas>0 && NOT(ocupado(pos_x,pos_y)) && rate_of_fire>14)
						
						mapa[pos_x][pos_y].objeto = Bomba(mapa[pos_x][pos_y].en_x,mapa[pos_x][pos_y].en_y,250,ID,map_durezas);
						rate_of_fire=0;
					END
				rate_of_fire++;
			ELSE
				rate_of_fire=15;
			END
			
			// Se asume que el jugador siempre usara las flechas(hat) para moverse
			IF (joy_gethat(stats.player,0)==config_botones_player[stats.player].boton_arriba OR joy_gethat(stats.player,0)==3 OR joy_gethat(stats.player,0)==9)
				wait=0;
				graph_inicial=21; //31;
				graph_final=30; //38;
				Avanzar(_mover_arriba,ID,map_durezas,"OFF");
				orientacion_final=1;
			ELIF (joy_gethat(stats.player,0)==config_botones_player[stats.player].boton_abajo OR joy_gethat(stats.player,0)==6 OR joy_gethat(stats.player,0)==12)
				wait=0;
				graph_inicial=11;//11;
				graph_final=20;//18;
				Avanzar(_mover_abajo,ID,map_durezas,"OFF"); 
				orientacion_final=2;		
			ELIF (joy_gethat(stats.player,0)==config_botones_player[stats.player].boton_derecha)			
				wait=0;
				graph_inicial=31;//21;
				graph_final=40;//28;
				Avanzar(_mover_der,ID,map_durezas,"OFF");
				flags = 0;
				orientacion_final=3;			
			ELIF (joy_gethat(stats.player,0)==config_botones_player[stats.player].boton_izquierda)			
				wait=0;
				graph_inicial=31;//21;
				graph_final=40;//28;
				Avanzar(_mover_izq,ID,map_durezas,"OFF");
				flags = 1;
				orientacion_final=3;			
			ELIF (wait==200)
				graph_inicial=1;//41;
				graph_final=1;//48;
				IF(graph==1) //48
					wait=-100;
				END			
			ELSE  
				wait++;
				IF(orientacion_final==_Pos_arriba)
					graph_inicial=2; //33
					graph_final=2; //33
				END
				IF(orientacion_final==_Pos_abajo)
					graph_inicial=1;
					graph_final=1;
				END
				IF(orientacion_final==_Pos_lateral)
					graph_inicial=3;//23; 
					graph_final=3;//23;
				END			
			END
			
			IF(lag==3)
				lag=0;
				Animacion(graph_inicial,graph_final);
			END
						
			lag++;
			FRAME;
			
			IF(map_get_pixel(id_fpg_stages,map_durezas,x/resolution,(y/resolution)-16) == id_color_rojo)
				
				BREAK;
			END
			
		END
	END
play_wav(id_wav_muere,0);
ONEXIT
	bomber_muerte(x/resolution,y/resolution);
	pjes_vivos--;
END
/**************************************/

/**** Proceso bomber_muerte ****/
PROCESS bomber_muerte(x,y)
PRIVATE
	byte lag;
BEGIN
	lag=0;
	file=father.file;
	z=father.z;
	graph=41;
	
	WHILE(NOT(graph==49))
		IF(lag==5)
			lag=0;
			Animacion(042,049);
		END
		lag++;
		FRAME;
	END
END
/**************************************/

/**** Proceso inmune() ****/
PROCESS inmune(byte lag,byte velocidad)
BEGIN
	IF(velocidad==0)
		IF(lag==6)
			father.alpha=230;
		ELIF(lag==12)
			father.alpha=215;
		ELIF(lag==18)
			father.alpha=190;
		ELIF(lag==24)
			father.alpha=175;
		ELIF(lag==30)
			father.alpha=150;
		ELIF(lag==36)
			father.alpha=125;
		ELIF(lag==42)
			father.alpha=150;			
		ELIF(lag==48)
			father.alpha=175;
		ELIF(lag==54)
			father.alpha=190;
		ELIF(lag==60)
			father.alpha=215;
		END
	ELSE
		IF(lag==3)
			father.alpha=0;
		ELIF(lag==6)
			father.alpha=150;
		ELIF(lag==9)
			father.alpha=0;
		ELIF(lag==12)
			father.alpha=150;
		ELIF(lag==15)
			father.alpha=0;
		ELIF(lag==18)
			father.alpha=150;
		ELIF(lag==21)
			father.alpha=0;			
		ELIF(lag==24)
			father.alpha=150;
		ELIF(lag==27)
			father.alpha=0;
		ELIF(lag==30)
			father.alpha=150;
		END
	END
		
END
/**************************************/