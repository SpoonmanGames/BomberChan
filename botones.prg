/**** Proceso opciones ****/
PROCESS options()
PRIVATE
	byte player;
	byte nivel;
BEGIN
	LOOP
		SWITCH(sub_level)
			CASE 0: //Sub menu de options
				go = false;
				nivel = 1;
				
				write(id_fnt_submenu_titulo,320,160,4,"Configurar Controles");
				write(id_fnt_submenu_normal,140,200,3,"Player 1");
				write(id_fnt_submenu_normal,140,232,3,"Player 2");
				write(id_fnt_submenu_normal,140,264,3,"Player 3");
				write(id_fnt_submenu_normal,140,296,3,"Player 4");
				write(id_fnt_submenu_normal,140,328,3,"Player 5");
				
				puntero(120,200,328,200,true);
				
				LOOP
					IF (key(_UP))
						WHILE(key(_UP)) FRAME; END
						nivel -= 1;
						IF(nivel==0) nivel=5; END
					ELIF (key(_DOWN))
						WHILE(key(_DOWN)) FRAME; END
						nivel += 1;
						IF(nivel==6) nivel=1; END
					ELIF(go==true)
						sub_level = nivel;
						sub_sub_level=0;
						BREAK;
					ELIF(key(_esc)) 
						WHILE(key(_esc)) FRAME; END
						level = 0;
						BREAK;
					END
					
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				fade_on();
			
			END
			
			CASE 1: // Player 1
				configurar_botones(0);
				LOOP								
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				signal( Type configurar_botones, S_KILL_TREE);
				fade_on();
			END
			
			CASE 2: // Player 2
				configurar_botones(1);
				LOOP					
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				signal( Type configurar_botones, S_KILL_TREE);
				fade_on();
			END
			
			CASE 3: // Player 1
				configurar_botones(2);
				LOOP								
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				signal( Type configurar_botones, S_KILL_TREE);
				fade_on();
			END
			
			CASE 4: // Player 1
				configurar_botones(3);
				LOOP								
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				signal( Type configurar_botones, S_KILL_TREE);
				fade_on();
			END
			
			CASE 5: // Player 1
				configurar_botones(4);
				LOOP								
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				signal( Type configurar_botones, S_KILL_TREE);
				fade_on();
			END
		END
		FRAME;
	END
END
/**************************************/

/**** Proceso configurar_botones ****/
PROCESS configurar_botones(byte player)
PRIVATE
	byte nivel;
BEGIN
	LOOP
		SWITCH(sub_sub_level)
			CASE 0: //Sub sub menu de configurar botones
				go = false;
				nivel = 1;
			
				write(id_fnt_submenu_titulo,320,200,4,"Dispositivo??");
				write(id_fnt_submenu_normal,140,240,3,"Teclado");
				write(id_fnt_submenu_normal,140,272,3,"Joystick PSX o PS2");
				
				puntero(120,240,272,240,true);
				
				LOOP
					IF (key(_UP))
						WHILE(key(_UP)) FRAME; END
						nivel -= 1;
						IF(nivel==0) nivel=2; END
					ELIF (key(_DOWN))
						WHILE(key(_DOWN)) FRAME; END
						nivel += 1;
						IF(nivel==3) nivel=1; END
					ELIF(go==true) 
						sub_sub_level = nivel;
						BREAK;
					ELIF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						sub_level = 0;
						BREAK;
					END
					
					FRAME;
				END
								
				fade_off();
				delete_text(0);
				fade_on();
			
			END
			
			CASE 1: //Configurar teclado
				config_botones_player[player].dispositivo=0;
				configurar_teclado(player);
				LOOP
					IF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						sub_level=0;
					END
				
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				fade_on();
			END
			
			CASE 2: //Configurar Joystick
				config_botones_player[player].dispositivo=1;
				configurar_joystick(player);
				LOOP
					IF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						sub_level=0;
					END
				
					IF(sub_level==0)
						BREAK;
					END
					FRAME;
				END
				
				fade_off();
				fade_on();
			END
		END
		FRAME;
	END
END
/**************************************/

/**** Proceso configurar_teclado ****/
PROCESS configurar_teclado(byte player)	
PRIVATE
	//byte *btn;
	byte avanzar;
BEGIN
	avanzar=0;
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: arriba");
	REPEAT		
		IF(scan_code) 
			IF(NOT(key(_esc)))

				config_botones_player[player].boton_arriba=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END 
		END
		FRAME;
	UNTIL(avanzar==1)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: abajo");
	REPEAT
		IF(scan_code)
			IF(NOT(key(_esc)))
			
				config_botones_player[player].boton_abajo=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==2)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: izquierda");
	REPEAT	
		IF(scan_code)
			IF(NOT(key(_esc)))
			
				config_botones_player[player].boton_izquierda=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==3)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: derecha");
	REPEAT
		IF(scan_code)
			IF(NOT(key(_esc)))
			
				config_botones_player[player].boton_derecha=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==4)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: bomba");
	REPEAT
		IF(scan_code)
			IF(NOT(key(_esc)))
			
				config_botones_player[player].boton_bomba=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==5)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: especial");
	REPEAT
		IF(scan_code)	
			IF(NOT(key(_esc)))

				config_botones_player[player].boton_especial=detectar_boton_teclado();	
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==6)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: detonar");
	REPEAT
		IF(scan_code)
			IF(NOT(key(_esc)))
			
				config_botones_player[player].boton_detonar=detectar_boton_teclado();
			
				WHILE(scan_code)
					FRAME;
				END
				avanzar++;
			END
		END
		FRAME;
	UNTIL(avanzar==7)
	delete_text(0);
	
	save("config/botones.sav",config_botones_player);
	sub_level=0;
	
END
/**************************************/

/**** Proceso detectar_boton_teclado ****/
PROCESS detectar_boton_teclado()
BEGIN
	IF(scan_code)
		IF(NOT(key(_esc)))
			return scan_code;
		END
	END
END
/**************************************/


/**** Proceso configurar_joystick ****/
PROCESS configurar_joystick(byte player)	
PRIVATE
	byte avanzar;
BEGIN
	avanzar=0;
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: arriba");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_arriba=detectar_boton_joystick(player);
			
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==1)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: abajo");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_abajo=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==2)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: izquierda");
	REPEAT		
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_izquierda=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==3)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: derecha");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_derecha=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==4)
	delete_text(0);
		
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: bomba");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_bomba=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==5)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: especial");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_especial=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==6)
	delete_text(0);
	
	write(id_fnt_submenu_normal,320,240,4,"Presione boton: detonar");
	REPEAT
		IF(joy_getActualButton(player))
		
			config_botones_player[player].boton_detonar=detectar_boton_joystick(player);
		
			WHILE(joy_getActualButton(player))
				FRAME;
			END
				avanzar++;
		END
		FRAME;
	UNTIL(avanzar==7)
	delete_text(0);
	
	save("config/botones.sav",config_botones_player);
	sub_level=0;
	
END
/**************************************/

/**** Proceso detectar_boton_joystick ****/
PROCESS detectar_boton_joystick(byte player)
BEGIN
	IF(joy_gethat(player,0)==_hat_up)
		return _hat_up;
	ELSIF(joy_gethat(player,0)==_hat_right)
		return _hat_right;
	ELSIF(joy_gethat(player,0)==_hat_down)
		return _hat_down;
	ELSIF(joy_gethat(player,0)==_hat_left)
		return _hat_left;
	ELSIF(joy_getbutton(player,_joy_triangulo))		
		return _joy_triangulo;
	ELSIF(joy_getbutton(player,_joy_circulo))		
		return _joy_circulo;
	ELSIF(joy_getbutton(player,_joy_equis))		
		return _joy_equis;
	ELSIF(joy_getbutton(player,_joy_cuadrado))		
		return _joy_cuadrado;
	ELSIF(joy_getbutton(player,_joy_L2))		
		return _joy_L2;
	ELSIF(joy_getbutton(player,_joy_R2))		
		return _joy_R2;
	ELSIF(joy_getbutton(player,_joy_L1))		
		return _joy_L1;
	ELSIF(joy_getbutton(player,_joy_R1))		
		return _joy_R1;
	ELSIF(joy_getbutton(player,_joy_select))		
		return _joy_select;
	ELSIF(joy_getbutton(player,_joy_start))		
		return _joy_start;
	ELSIF(joy_getbutton(player,_joy_L3))		
		return _joy_L3;
	ELSIF(joy_getbutton(player,_joy_R3))		
		return _joy_R3;
	END
END
/**************************************/

/**** Proceso joy_getActualButton ****/
PROCESS joy_getActualButton(byte player)
BEGIN
	IF(joy_gethat(player,0)==_hat_up)
		RETURN 1;
	ELSIF(joy_gethat(player,0)==_hat_right)
		RETURN 1;
	ELSIF(joy_gethat(player,0)==_hat_down)
		RETURN 1;
	ELSIF(joy_gethat(player,0)==_hat_left)
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_triangulo))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_circulo))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_equis))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_cuadrado))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_L2))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_R2))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_L1))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_R1))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_select))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_start))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_L3))
		RETURN 1;
	ELSIF(joy_getbutton(player,_joy_R3))
		RETURN 1;
	END
	RETURN 0;
END
/**************************************/