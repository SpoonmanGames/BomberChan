/**** Proceso Menu ****/
PROCESS Menu(string	def_p1,
			string	def_p2,
			string	def_p3,
			string	def_p4,
			string	def_p5,
			string	def_com_level,
			byte	def_battles,
			int	def_time_partida,
			string	def_s_death,
			string	def_missil_b
			byte	def_mapa_elegido)
PRIVATE
	byte tiempo;
	byte nivel;
	byte i;
	int m_portada;
	int m_credits;
	int caca;
BEGIN

	x=320;
	y=260;
	file=id_fpg_menu;
	
	m_portada=load_song("sounds/01.ogg");
	m_credits=load_song("sounds/05.ogg");
	id_m_sub_menu=load_song("sounds/02.ogg");
	
	id_fpg_menu=load_fpg("images/Menu.fpg");
	id_fnt_menu_normal=load_fnt("fonts/menu-normal.fnt");
	id_fnt_submenu_normal=load_fnt("fonts/submenu-normal.fnt");
	id_fnt_submenu_titulo=load_fnt("fonts/submenu-titulo.fnt");
	id_wav_moverse=load_wav("sounds/01.wav");
	id_wav_escoger=load_wav("sounds/02.wav");
	id_wav_volver=load_wav("sounds/03.wav");
	LOOP
		SWITCH(level)
			CASE 0: 	//Menu Principal
				go=false;
				graph=999;
				play_song(m_portada,1);
				nivel=1;
				Portada();
				LOOP
					IF (key(_up))
						WHILE(key(_up)) FRAME; END
						nivel -= 1;
						play_wav(id_wav_moverse,0);
						IF(nivel==0) nivel=8; END
					ELIF (key(_down))
						WHILE(key(_down)) FRAME; END
						nivel += 1;
						play_wav(id_wav_moverse,0);
						IF(nivel==9) nivel=1; END
					ELIF (key(_enter))
						WHILE(key(_enter)) FRAME; END
						play_wav(id_wav_escoger,0);
						FROM i=0 to 25;
							FRAME;
						END
						fade_music_off(400);
						level = nivel;
						BREAK; 
					END
					
					IF(key(_right))
						scroll[0].x0 +=2;
					ELIF(key(_left))
						scroll[0].x0 -=2;
					END
					
					FRAME;
				END
	
				fade_off();
				delete_text(0);
				stop_scroll(0);
				signal(ALL_PROCESS,S_KILL);
				IF(nivel!=7) 
					fondo_submenu();
					IF(nivel==6) 
						play_song(m_credits,1);
					ELSE
						play_song(id_m_sub_menu,-1);
					END
					fade_on();
				END
			END
			
			CASE 1: // Quick Play
				quick_play(def_p1,
				def_p2,
				def_p3,
				def_p4,
				def_p5,
				def_com_level,
				def_battles,
				def_time_partida,
				def_s_death,
				def_missil_b,
				def_mapa_elegido);				
				LOOP
					IF(level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0); 
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END
			
			CASE 2: // Classic
				write(id_fnt_submenu_titulo,320,120,4,"Bomber-CHAN!");
				graph=7;
				LOOP
					IF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						play_wav(id_wav_volver,0);
						fade_music_off(400);
						level=0;
						BREAK;
					END
					
					FRAME;
				END	

				fade_off();
				graph=999;
				delete_text(0); 
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END
			
			CASE 3: // Extreme
				write(id_fnt_submenu_titulo,320,120,4,"Bomber-CHAN!");
				graph=7;
				LOOP
					IF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						play_wav(id_wav_volver,0);
						fade_music_off(400);
						level=0;
						BREAK;
					END
					
					FRAME;
				END	

				fade_off();
				graph=999;
				delete_text(0); 
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END
			
			CASE 4: // Perfiles
				write(id_fnt_submenu_titulo,320,120,4,"Bomber-CHAN!");
				graph=7;
				LOOP
					IF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						play_wav(id_wav_volver,0);
						fade_music_off(400);
						level=0;
						BREAK;
					END
					
					FRAME;
				END	

				fade_off();
				graph=999;
				delete_text(0); 
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END
				
			CASE 5: // Options
				sub_level=0;
				options();
				LOOP					
					IF(level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END

			CASE 6: // Creditos
				

				caca=-480;
				LOOP
				
				write(id_fnt_submenu_titulo,320,120-caca,4,"Bomber-CHAN!");
				write(id_fnt_submenu_titulo,320,170-caca,4,"AGRADECIMIENTOS A");
				write(id_fnt_submenu_normal,320,232-caca,4,"Todos los que sabian del");
				write(id_fnt_submenu_normal,320,264-caca,4,"proyecto y apoyaron *o*");
				write(id_fnt_submenu_normal,320,328-caca,4,"Especial mencion a Venus,");
				write(id_fnt_submenu_normal,320,360-caca,4,"ella mejoro nuestro codigo <3");
				write(id_fnt_submenu_normal,320,424-caca,4,"Ragnaroz, por HOLA");
				write(id_fnt_submenu_normal,320,465-caca,4,"Hudson, la razon es obvia!");
				write(id_fnt_submenu_titulo,320,575-caca,4,"STAFF");
				write(id_fnt_submenu_normal,320,625-caca,4,"Theby (programacion)");
				write(id_fnt_submenu_normal,320,657-caca,4,"Hen (tai) (programacion)");
				write(id_fnt_submenu_normal,320,689-caca,4,"Rojo (graficos, masajes)");
				write(id_fnt_submenu_titulo,320,689+240-caca,4,"REPORTAR BUGS!");
				
				caca++;
					IF(key(_enter))
						caca++;
					END
					IF(key(_esc)OR caca>=(689+240))
						WHILE(key(_esc) OR key(_enter)) FRAME; END
						play_wav(id_wav_volver,0);
						level=0;
						BREAK;
					END
					
					FRAME;
					delete_text(0);
				END	

				fade_off();
				graph=999;
				fade_music_off(400);
				delete_text(0); 
				signal(ALL_PROCESS,S_KILL);
				fade_on();
			END
			
			CASE 7: // Exit
				fade_on();
				FROM tiempo=0 TO 20;
					fade_off();
					FRAME;
				END
				fade_music_off(400);
				fpg_unload(id_fpg_menu);   // libera la memoria usada para el menu
				fnt_unload(id_fnt_submenu_normal);
				fnt_unload(id_fnt_submenu_titulo);
				fnt_unload(id_fnt_menu_normal);
				unload_song(id_m_sub_menu);
				unload_song(m_credits);
				unload_song(m_portada);
				exit("Adieu!");
			END
			
			CASE 8:
				lanzar_partida("MAN","MAN","OFF","OFF","OFF","MEDIUM",1,6,"RANDOM","SUPER",1);
			END
		END
		FRAME;
	END
END
/**************************************/

/**** Proceso Portada ****/
PROCESS Portada()
PRIVATE
	int id_texto;
	byte texto;
BEGIN

	start_scroll(0,id_fpg_menu,5,0,0,0);
	scroll[0].x0 = 150;
	
	//put_screen(id_fpg_menu,1);
	
	x=320;
	y=50;
	file=id_fpg_menu;
	graph=6;
	
	texto=1;
	id_texto=write(id_fnt_menu_normal,320,392,4,"Partida Rapida");
	
	/* BOTONES
	botones player 1
	write(0,0,10,0,"Dispositivo: "+config_botones_player[0].dispositivo);
	write(0,0,20,0,"Arriba: "+ config_botones_player[0].boton_arriba);
	write(0,0,30,0,"Abajo: "+ config_botones_player[0].boton_abajo);
	write(0,0,40,0,"Izquierda: "+ config_botones_player[0].boton_izquierda);
	write(0,0,50,0,"Derecha: "+ config_botones_player[0].boton_derecha);
	write(0,0,60,0,"Bomba: "+ config_botones_player[0].boton_bomba);
	write(0,0,70,0,"Especial: "+ config_botones_player[0].boton_especial);
	write(0,0,80,0,"Detonar: "+ config_botones_player[0].boton_detonar);
	
	/* botones player 2 
	write(0,0,110,0,"Dispositivo: "+config_botones_player[1].dispositivo);
	write(0,0,120,0,"Arriba: "+ config_botones_player[1].boton_arriba);
	write(0,0,130,0,"Abajo: "+ config_botones_player[1].boton_abajo);
	write(0,0,140,0,"Izquierda: "+ config_botones_player[1].boton_izquierda);
	write(0,0,150,0,"Derecha: "+ config_botones_player[1].boton_derecha);
	write(0,0,160,0,"Bomba: "+ config_botones_player[1].boton_bomba);
	write(0,0,170,0,"Especial: "+ config_botones_player[1].boton_especial);
	write(0,0,180,0,"Detonar: "+ config_botones_player[1].boton_detonar);
	
	/* botones player 3 
	write(0,0,210,0,"Dispositivo: "+config_botones_player[2].dispositivo);
	write(0,0,220,0,"Arriba: "+ config_botones_player[2].boton_arriba);
	write(0,0,230,0,"Abajo: "+ config_botones_player[2].boton_abajo);
	write(0,0,240,0,"Izquierda: "+ config_botones_player[2].boton_izquierda);
	write(0,0,250,0,"Derecha: "+ config_botones_player[2].boton_derecha);
	write(0,0,260,0,"Bomba: "+ config_botones_player[2].boton_bomba);
	write(0,0,270,0,"Especial: "+ config_botones_player[2].boton_especial);
	write(0,0,280,0,"Detonar: "+ config_botones_player[2].boton_detonar);
	
	/* botones player 4 
	write(0,640,10,2,"Dispositivo: "+config_botones_player[3].dispositivo);
	write(0,640,20,2,"Arriba: "+ config_botones_player[3].boton_arriba);
	write(0,640,30,2,"Abajo: "+ config_botones_player[3].boton_abajo);
	write(0,640,40,2,"Izquierda: "+ config_botones_player[3].boton_izquierda);
	write(0,640,50,2,"Derecha: "+ config_botones_player[3].boton_derecha);
	write(0,640,60,2,"Bomba: "+ config_botones_player[3].boton_bomba);
	write(0,640,70,2,"Especial: "+ config_botones_player[3].boton_especial);
	write(0,640,80,2,"Detonar: "+ config_botones_player[3].boton_detonar);
	
	/* botones player 5 
	write(0,640,110,2,"Dispositivo: "+config_botones_player[4].dispositivo);
	write(0,640,120,2,"Arriba: "+ config_botones_player[4].boton_arriba);
	write(0,640,130,2,"Abajo: "+ config_botones_player[4].boton_abajo);
	write(0,640,140,2,"Izquierda: "+ config_botones_player[4].boton_izquierda);
	write(0,640,150,2,"Derecha: "+ config_botones_player[4].boton_derecha);
	write(0,640,160,2,"Bomba: "+ config_botones_player[4].boton_bomba);
	write(0,640,170,2,"Especial: "+ config_botones_player[4].boton_especial);
	write(0,640,180,2,"Detonar: "+ config_botones_player[4].boton_detonar);
	*/
	
	LOOP
		IF (key(_up))
			WHILE(key(_up)) FRAME; END
			texto--;
			IF(texto==0) texto=8; END
		ELIF(key(_down))
			WHILE(key(_down)) FRAME; END
			texto++;
			IF(texto==9) texto=1; END
		END
		
		delete_text(id_texto);
			
		IF(texto==1)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Partida Rapida");
		ELIF(texto==2)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Modo Clasico");
		ELIF(texto==3)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Modo Extremo");
		ELIF(texto==4)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Perfiles");
		ELIF(texto==5)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Configuracion");
		ELIF(texto==6)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Creditos");
		ELIF(texto==7)
			id_texto=write(id_fnt_menu_normal,320,392,4,"Salir");
		ELIF
			id_texto=write(id_fnt_menu_normal,320,392,4,"DEBUG");
		END
		FRAME;
	END
END
/**************************************/

/**** Proceso puntero ****/
PROCESS puntero(x,y,int max, int min,boolean animacion)
PRIVATE
	byte lag,i;
BEGIN
	file=id_fpg_menu;
	graph=12;
	lag=5;
	z=9;
	LOOP
		IF(lag==5)
			lag=0;
		END
	
		IF (key(_up))
			WHILE(key(_up)) FRAME; END
			y -= 32;
			play_wav(id_wav_moverse,0);
			IF(y<min) y = max;; END
		ELIF (key(_down))
			WHILE(key(_down)) FRAME; END
			y += 32;
			play_wav(id_wav_moverse,0);
			IF(y>max) y = min;; END
		ELIF (key(_enter))
			WHILE(key(_enter)) FRAME; END
			play_wav(id_wav_escoger,0);
			IF(animacion == true) 
				puntero_elige(x,y); 
			ELSE
				FROM i=0 to 25;
					FRAME;
				END
				go=true;
			END
			BREAK;
		END
		
		IF(key(_esc) && level!=0) play_wav(id_wav_volver,0); BREAK; END
		
		lag++;
		FRAME;
	END
END
/**************************************/

/**** Proceso puntero_elige ****/
PROCESS puntero_elige(x,y);
PRIVATE
	byte i;
BEGIN
	file=id_fpg_menu;
	graph=11;
	z=father.z;
	FROM i=0 to 25;
		FRAME;
	END
	graph=12;
	FROM i=0 to 25;
		FRAME;
	END
	graph=11;
	FROM i=0 to 25;
		FRAME;
	END
	go=true;
END
/**************************************/

/**** Proceso fondo_submenu ****/
PROCESS fondo_submenu();
PRIVATE
	byte lag,sub;
BEGIN
	x=320;
	y=240;
	graph=3;
	lag=0;
	z=10;
	LOOP
		IF(lag==100)
			IF(graph==3)
				graph=4;
			ELIF(graph==4)
				graph=3;
			END
			lag=0;
		END
		lag++;
		FRAME;
	END
END
/**************************************/
