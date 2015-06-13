/**** Proceso quick_play ****/
PROCESS quick_play(string	player1,
			string	player2,
			string	player3,
			string	player4,
			string	player5,
			string	com_level,
			byte	battles,
			int		time_partida,
			string	s_death,
			string	missil_b,
			byte	mapa_elegido)
PRIVATE
	byte fila, columna1, columna2, columna3, columna4, columna5;
	int pl1,pl2,pl3,pl4,pl5;
	byte tiempo,lag;
	
	int m_empezando;	
BEGIN
	x=320;
	y=240;
	z=8;
	graph=999;
	
	m_empezando=load_song("sounds/03.ogg");
	
	LOOP
		SWITCH(sub_level)
			CASE 0: //Sub menu de elección de player
				go = false;
				fila = 1;
				columna1 = 2;
				columna2 = 2;
				columna3 = 1;
				columna4 = 1;
				columna5 = 1;
				
				write(id_fnt_submenu_titulo,320,160,4,"Players");
				write(id_fnt_submenu_normal,220,200,3,"Player 1: "); pl1 = write(id_fnt_submenu_normal,400,200,3,player1);
				write(id_fnt_submenu_normal,220,232,3,"Player 2: "); pl2 = write(id_fnt_submenu_normal,400,232,3,player2);
				write(id_fnt_submenu_normal,220,264,3,"Player 3: "); pl3 = write(id_fnt_submenu_normal,400,264,3,player3);
				write(id_fnt_submenu_normal,220,296,3,"Player 4: "); pl4 = write(id_fnt_submenu_normal,400,296,3,player4);
				write(id_fnt_submenu_normal,220,328,3,"Player 5: "); pl5 = write(id_fnt_submenu_normal,400,328,3,player5);
				
				puntero(200,200,328,200,false);
				
				LOOP
					IF (key(_UP))
						WHILE(key(_UP)) FRAME; END
						fila -= 1;
						IF(fila==0) fila=5; END
					ELIF (key(_DOWN))
						WHILE(key(_DOWN)) FRAME; END
						fila += 1;
						IF(fila==6) fila=1; END
					ELIF (key(_RIGHT))
						WHILE (key(_RIGHT)) FRAME; END
						
						IF(fila==1)
							delete_text(pl1);
							IF(columna1==1)
								player1 = "MAN";
								pjes_vivos++;
								columna1++;
							ELIF(columna1==2)
								player1 = "COM";
								columna1++;
							END
							pl1 = write(id_fnt_submenu_normal,400,200,3,player1);
						ELIF (fila==2)
							delete_text(pl2);
							IF(columna2==1)
								player2 = "MAN";
								pjes_vivos++;
								columna2++;
							ELIF(columna2==2)
								player2 = "COM";
								columna2++;
							END
							pl2 = write(id_fnt_submenu_normal,400,232,3,player2);
						ELIF (fila==3)
							delete_text(pl3);
							IF(columna3==1)
								player3 = "MAN";
								pjes_vivos++;
								columna3++;
							ELIF(columna3==2)
								player3 = "COM";
								columna3++;
							END
							pl3 = write(id_fnt_submenu_normal,400,264,3,player3);
						ELIF (fila==4)
							delete_text(pl4);
							IF(columna4==1)
								player4 = "MAN";
								pjes_vivos++;
								columna4++;
							ELIF(columna4==2)
								player4 = "COM";
								columna4++;
							END
							pl4 = write(id_fnt_submenu_normal,400,296,3,player4);
						ELIF (fila==5)
							delete_text(pl5);
							IF(columna5==1)
								player5 = "MAN";
								pjes_vivos++;
								columna5++;
							ELIF(columna5==2)
								player5 = "COM";
								columna5++;
							END
							pl5 = write(id_fnt_submenu_normal,400,328,3,player5);
						END
						
					ELIF (key(_LEFT))
						WHILE (key(_LEFT)) FRAME; END
						
						IF(fila==1)
							delete_text(pl1);
							IF(columna1==2 AND pjes_vivos!=2)
								player1 = "OFF";
								pjes_vivos--;
								columna1--;
							ELIF(columna1==3)
								player1 = "MAN";
								columna1--;
							END
							pl1 = write(id_fnt_submenu_normal,400,200,3,player1);
						ELIF (fila==2)
							delete_text(pl2);
							IF(columna2==2 AND pjes_vivos!=2)
								player2 = "OFF";
								pjes_vivos--;
								columna2--;
							ELIF(columna2==3)
								player2 = "MAN";
								columna2--;
							END
							pl2 = write(id_fnt_submenu_normal,400,232,3,player2);
						ELIF (fila==3)
							delete_text(pl3);
							IF(columna3==2 AND pjes_vivos!=2)
								player3 = "OFF";
								pjes_vivos--;
								columna3--;
							ELIF(columna3==3)
								player3 = "MAN";
								columna3--;
							END
							pl3 = write(id_fnt_submenu_normal,400,264,3,player3);
						ELIF (fila==4)
							delete_text(pl4);
							IF(columna4==2 AND pjes_vivos!=2)
								player4 = "OFF";
								pjes_vivos--;
								columna4--;
							ELIF(columna4==3)
								player4 = "MAN";
								columna4--;
							END
							pl4 = write(id_fnt_submenu_normal,400,296,3,player4);
						ELIF (fila==5)
							delete_text(pl5);
							IF(columna5==2 AND pjes_vivos!=2)
								player5 = "OFF";
								pjes_vivos--;
								columna5--;
							ELIF(columna5==3)
								player5 = "MAN";
								columna5--;
							END
							pl5 = write(id_fnt_submenu_normal,400,328,3,player5);
						END
						
					ELIF(go==true) 
						sub_level = 1;
						BREAK;
					ELIF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						fade_music_off(400);
						level = 0;
						BREAK;
					END
					
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				fade_on();
			
			END
			
			CASE 1: // OPCIONES RAPIDAS
				go = false;
				fila = 1;
				columna1 = 2;
				columna4 = 3;
				columna5 = 2;
				
				write(id_fnt_submenu_titulo,320,160,4,"Opciones Rapidas");
				write(id_fnt_submenu_normal,140,200,3,"COM level: "); pl1 = write(id_fnt_submenu_normal,400,200,3,com_level);
				write(id_fnt_submenu_normal,140,232,3,"Battles: "); pl2 = write(id_fnt_submenu_normal,400,232,3,""+battles);
				write(id_fnt_submenu_normal,140,264,3,"Time: "); pl3 = write(id_fnt_submenu_normal,400,264,3,""+time_partida+":00");
				write(id_fnt_submenu_normal,140,296,3,"Sudden Death: "); pl4 = write(id_fnt_submenu_normal,400,296,3,s_death);
				write(id_fnt_submenu_normal,140,328,3,"Misil Bomber: "); pl5 = write(id_fnt_submenu_normal,400,328,3,missil_b);
				
				puntero(120,200,328,200,false);
				
				LOOP
					IF (key(_UP))
						WHILE(key(_UP)) FRAME; END
						fila -= 1;
						IF(fila==0) fila=5; END
					ELIF (key(_DOWN))
						WHILE(key(_DOWN)) FRAME; END
						fila += 1;
						IF(fila==6) fila=1; END
					ELIF (key(_RIGHT))
						WHILE (key(_RIGHT)) FRAME; END
						
						IF(fila==1)
							delete_text(pl1);
							IF(columna1==1)
								com_level = "Medium";
								columna1++;
							ELIF(columna1==2)
								com_level = "Hard";
								columna1++;
							END
							pl1 = write(id_fnt_submenu_normal,400,200,3,com_level);
						ELIF (fila==2)
							delete_text(pl2);
							IF(battles!=6)
								battles++;
							END
							pl2 = write(id_fnt_submenu_normal,400,232,3,""+battles);
						ELIF (fila==3)
							delete_text(pl3);
							IF(time_partida!=6)
								time_partida++;
							END
							IF(time_partida==6)
								pl3 = write(id_fnt_submenu_normal,400,264,3,"INFINITO");
							ELSE
								pl3 = write(id_fnt_submenu_normal,400,264,3,""+time_partida+":00");
							END
						ELIF (fila==4)
							delete_text(pl4);
							IF(columna4==1)
								s_death = "ON";
								columna4++;
							ELIF(columna4==2)
								s_death = "Random";
								columna4++;
							END
							pl4 = write(id_fnt_submenu_normal,400,296,3,s_death);
						ELIF (fila==5)
							delete_text(pl5);
							IF(columna5==1)
								missil_b = "ON";
								columna5++;
							ELIF(columna5==2)
								missil_b = "Super";
								columna5++;
							END
							pl5 = write(id_fnt_submenu_normal,400,328,3,missil_b);
						END
						
					ELIF (key(_LEFT))
						WHILE (key(_LEFT)) FRAME; END
						
						IF(fila==1)
							delete_text(pl1);
							IF(columna1==2)
								com_level = "Easy";
								columna1--;
							ELIF(columna1==3)
								com_level = "Medium";
								columna1--;
							END
							pl1 = write(id_fnt_submenu_normal,400,200,3,com_level);
						ELIF (fila==2)
							delete_text(pl2);
							IF(battles!=1)
								battles--;
							END
							pl2 = write(id_fnt_submenu_normal,400,232,3,""+battles);
						ELIF (fila==3)
							delete_text(pl3);
							IF(time_partida!=1)
								time_partida--;
							END
							pl3 = write(id_fnt_submenu_normal,400,264,3,""+time_partida+":00");
						ELIF (fila==4)
							delete_text(pl4);
							IF(columna4==2)
								s_death = "OFF";
								columna4--;
							ELIF(columna4==3)
								s_death = "ON";
								columna4--;
							END
							pl4 = write(id_fnt_submenu_normal,400,296,3,s_death);
						ELIF (fila==5)
							delete_text(pl5);
							IF(columna5==2)
								missil_b = "OFF";
								columna5--;
							ELIF(columna5==3)
								missil_b = "ON";
								columna5--;
							END
							pl5 = write(id_fnt_submenu_normal,400,328,3,missil_b);
						END
						
					ELIF(go==true) 
						sub_level = 2;
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
			
			CASE 2: // ELEGIR MAPA
				write(id_fnt_submenu_titulo,320,80,4,"Elige el Escenario");
				graph=9;
				write(id_fnt_submenu_normal,300,390,4,"Stage: ");
				pl1 = write(id_fnt_submenu_titulo,370,390,4,""+mapa_elegido);
				LOOP
					IF (key(_RIGHT))
						WHILE (key(_RIGHT)) FRAME; END
						mapa_elegido++;
						IF(mapa_elegido==3) mapa_elegido=1;END
						delete_text(pl1);
						write(id_fnt_submenu_titulo,370,390,4,""+mapa_elegido);
					ELIF (key(_LEFT))
						WHILE (key(_LEFT)) FRAME; END
						mapa_elegido--;
						IF(mapa_elegido==0) mapa_elegido=2;END
						delete_text(pl1);
						write(id_fnt_submenu_titulo,370,390,4,""+mapa_elegido);
					ELIF(key(_enter))
						WHILE(key(_enter)) FRAME; END
						stop_song();
						play_song(m_empezando,1);
						lag=0;
						REPEAT
							IF(lag==240)
								stop_song();
							END
							lag++;
							FRAME;
						UNTIL(NOT(is_playing_song()));
						sub_level = 3;
						BREAK;
					ELIF(key(_esc))
						WHILE(key(_esc)) FRAME; END
						mapa_elegido=1;
						graph=999;
						sub_level = 1;
						BREAK;
					END
					
					IF(mapa_elegido==1)
						graph=9;
					ELIF(mapa_elegido==2)
						graph=10;
					END
					FRAME;
				END
				
				fade_off();
				delete_text(0);
				fade_on();
			END
						
			CASE 3: // INICIAR PARTIDA
				signal ( Type fondo_submenu, S_KILL);
				lanzar_partida(player1,player2,player3,player4,player5,com_level,battles,time_partida,s_death,missil_b,mapa_elegido);
			END
		END
		FRAME;
	END
END
/**************************************/

/**** Proceso lanzar_partida ****/
PROCESS lanzar_partida(string	p1,
			string	p2,
			string	p3,
			string	p4,
			string	p5,
			string	com_level,
			byte	battles,
			int	tiempo_partida,
			string	s_death,
			string	missil_b
			byte	map)
PRIVATE
	byte i,j,mapa_; // Para escribir las X
	int reloj;
	byte luchadores;
	
	int m_peliando;

BEGIN
	
	let_me_alone();
	loading(25); // Lanzar pantalla LOADING
	stop_song();
	m_peliando=load_song("sounds/04.ogg");
	id_wav_putbomb=load_wav("sounds/04.wav");
	id_wav_explosion=load_wav("sounds/05.wav");
	id_wav_muere=load_wav("sounds/06.wav");
	
	id_fnt_tiempou=load_fnt("fonts/tiempou.fnt");
	id_fpg_bomber_white=load_fpg("images/bomber_white.fpg");// Carga un fpg de un bomberman blanco
	id_fpg_bomber_black=load_fpg("images/bomber_black.fpg");// Carga un fpg de un bomberman negro
	id_fpg_bomber_skyblue=load_fpg("images/bomber_skyblue.fpg");// Carga un fpg de un bomberman blanco
	id_fpg_bomber_yellow=load_fpg("images/bomber_yellow.fpg");// Carga un fpg de un bomberman negro
	id_fpg_bomber_green=load_fpg("images/bomber_green.fpg");// Carga un fpg de un bomberman blanco
	id_fpg_stages=load_fpg("images/Tiles.fpg");
	
	reloj=tiempo_partida;
	luchadores=pjes_vivos;
	
	REPEAT
		FRAME;
	UNTIL(son.graph==21) // Esperar hasta que LOADING tape la pantalla
	
	FOR(i=0;i<13;i++) // Inicializa los valores del mapa
		FOR(j=0;j<11;j++)
			mapa[ i ][ j ].en_x = 127 + (32*i);
			mapa[ i ][ j ].en_y = 101 + (32*j);
			mapa[ i ][ j ].objeto = 0;
			mapa[ i ][ j ].item = 0;
		END
	END
	
	IF(p1=="MAN") //Posicionar jugadores en el mapa, con freeze
		bomber[0]=bomber(127,101,id_fpg_bomber_white,0,1);
		signal(bomber[0],S_FREEZE);
	END
	IF(p2=="MAN")
		bomber[1]=bomber(127+(32*12),101+(32*10),id_fpg_bomber_black,1,1);
		signal(bomber[1],S_FREEZE);
	END
	IF(p3=="MAN")
		bomber[2]=bomber(127,101+(32*10),id_fpg_bomber_skyblue,2,1);
		signal(bomber[2],S_FREEZE);
	END
	IF(p4=="MAN")
		bomber[3]=bomber(127+(32*12),101,id_fpg_bomber_yellow,3,1);
		signal(bomber[3],S_FREEZE);
	END
	IF(p5=="MAN")
		bomber[4]=bomber(127+(32*6),101+(32*5),id_fpg_bomber_green,4,1);
		signal(bomber[4],S_FREEZE);
	END
		
	put_screen(id_fpg_stages,map+1); // Pone el fondo

	colocador_bloques(map,p1,p2,p3,p4,p5,pjes_vivos); // Pone los bloques de acuerdo a ese mapa
	colocador_items(25); // pone items
	FROM i=0 TO 25;
		FRAME;
	END // Espera la correcta colocacion de los bloques
	dibujar_durezas_fijas(); 
	REPEAT
		FRAME;
	UNTIL(NOT exists(TYPE LOADING)) //Espera hasta que no exista LOADING
	
	signal(ALL_PROCESS,S_WAKEUP); // Todos pueden moverse, comienza la partida
	reloj=timer[0]+(reloj*60*100);
	
	reloj(tiempo_partida);
	play_song(m_peliando,-1);
	LOOP // Condicionales de termino de la partida
		IF(tiempo_partida!=6)
			IF(timer[0]>=reloj) // Cuando el timer alcance el limite 
				loading(50);
				REPEAT
					FRAME;
				UNTIL(son.graph==21)
				BREAK;
			END
		END
		IF(pjes_vivos==1 OR pjes_vivos==0)
			FROM i=0 TO 30;
				FRAME;
			END
			IF(pjes_vivos==1) //VICTORIA DEL SUPERVIVIENTE
				loading(50);
				REPEAT
					FRAME;
				UNTIL(son.graph==21)
				BREAK;
			ELSE			//VICTORIA DE SUPERVIVIENTE
				loading(50);
				REPEAT
					FRAME;
				UNTIL(son.graph==21)
				BREAK;
			END
		END
		IF(key(_P))
			WHILE(key(_P)) FRAME; END
			clear_screen();
			IF(mapa_==1)
				mapa_=map+1;
			ELSE
				mapa_=1;
			END
			put_screen(id_fpg_stages,mapa_);
		ELIF(key(_esc))
			WHILE(key(_esc)) FRAME; END
			fade_music_off(400);
			loading(50);
			REPEAT
				FRAME;
			UNTIL(son.graph==21)
			BREAK;
		END
		FRAME;
	END
	
	delete_text(0);
	clear_screen();
	signal(ALL_PROCESS,S_KILL);
	
	FROM i=0 TO 50;
		FRAME;
	END // Espera la correcta muerte de items
	signal(ALL_PROCESS,S_KILL);
	
	fpg_unload(id_fpg_bomber_black);
	fpg_unload(id_fpg_bomber_white);
	fnt_unload(id_fnt_tiempou);
	
	REPEAT
		FRAME;
	UNTIL(son.graph==999)
	fpg_unload(id_fpg_stages);
	pjes_vivos = luchadores;
	level=1;
	sub_level=2;
	menu(p1,p2,p3,p4,p5,com_level,battles,tiempo_partida,s_death,missil_b,map);
	fondo_submenu();
	play_song(id_m_sub_menu,-1);
END
/**************************************/

/**** Proceso colocador_bloques ****/
FUNCTION colocador_bloques(byte mapa_elegido, string p1, string p2, string p3, string p4, string p5, byte cantidad_players)
PRIVATE
	byte i,j,tmp;

BEGIN
	FOR(i=0;i<13;i++)
		FOR(j=0;j<11;j++)
			mapa[ i ][ j ].objeto = bloque( 127+(32*i) , 101+(32*j) , mapa_elegido);
		END
	END
	
	/* mata bloques de esquinas */
	
	IF(p1=="MAN" OR p1=="COM") // esquina superior izquierda
		signal(mapa[0][0].objeto,S_KILL); mapa[0][0].objeto=0;
		signal(mapa[1][0].objeto,S_KILL); mapa[1][0].objeto=0;
		signal(mapa[0][1].objeto,S_KILL); mapa[0][1].objeto=0;
	END
	
	IF(p4=="MAN" OR p4=="COM") // esquina superior derecha
		signal(mapa[12][0].objeto,S_KILL); mapa[12][0].objeto=0;
		signal(mapa[12][1].objeto,S_KILL); mapa[12][1].objeto=0;
		signal(mapa[11][0].objeto,S_KILL); mapa[11][0].objeto=0;
	END
	
	IF(p3=="MAN" OR p3=="COM") // esquina inferior izquierda
		signal(mapa[0][10].objeto,S_KILL); mapa[0][10].objeto=0;
		signal(mapa[0][9].objeto,S_KILL);  mapa[0][9].objeto=0;
		signal(mapa[1][10].objeto,S_KILL); mapa[1][10].objeto=0;
	END
	
	IF(p2=="MAN" OR p2=="COM") // esquina inferior derecha
		signal(mapa[12][10].objeto,S_KILL); mapa[12][10].objeto=0;
		signal(mapa[12][9].objeto,S_KILL);  mapa[12][9].objeto=0;
		signal(mapa[11][10].objeto,S_KILL); mapa[11][10].objeto=0;
	END
	
	IF(p5=="MAN" OR p5=="COM")// centro
		signal(mapa[6][5].objeto,S_KILL); mapa[6][5].objeto=0;
		signal(mapa[5][4].objeto,S_KILL); mapa[5][4].objeto=0;
		signal(mapa[6][4].objeto,S_KILL); mapa[6][4].objeto=0;
		signal(mapa[7][4].objeto,S_KILL); mapa[7][4].objeto=0;
		signal(mapa[5][6].objeto,S_KILL); mapa[5][6].objeto=0;
		signal(mapa[6][6].objeto,S_KILL); mapa[6][6].objeto=0;
		signal(mapa[7][6].objeto,S_KILL); mapa[7][6].objeto=0;
	END
	
	// Muestra los bloques indestructibles
	FOR(i=1;i<13;i=i+2)
		FOR(j=1;j<11;j=j+2)
			signal(mapa[i][j].objeto,S_KILL); 
			mapa[i][j].objeto=0;		
		END
	END

	// Determina cuantos bloques aleatorios deben ser mostrados
	IF (cantidad_players==2)
		tmp=27;
	ELIF (cantidad_players==3)
		tmp=24;
	ELIF (cantidad_players==4)
		tmp=21;
	ELIF (cantidad_players==5)
		tmp=14;
	END

	rand_seed(time());
		
	WHILE(0<tmp)
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0)
			tmp--;
			signal(mapa[i][j].objeto,S_KILL); 
			mapa[i][j].objeto=0;
		END
	END	
END
/**************************************/

/**** Proceso dibujar_durezas_fijas ****/
FUNCTION dibujar_durezas_fijas()
PRIVATE
	byte i,j;
BEGIN
	FROM i=0 TO 14; //Rectangulo horizontal superior
		da_vinci(id_fpg_stages,1,id_color_amarillo,95+(32*i),69);
	END

	FROM i=0 TO 14; //Rectangulo horizontal inferior
		da_vinci(id_fpg_stages,1,id_color_amarillo,95+(32*i),69+(32*12));
	END

	FROM i=0 TO 10; //Rectangulo vertical izquierdo
		da_vinci(id_fpg_stages,1,id_color_amarillo,95,101+(32*i));
	END

	FROM i=0 TO 10; //Rectangulo vertical derecho
		da_vinci(id_fpg_stages,1,id_color_amarillo,95+(32*14),101+(32*i));
	END
	
	FOR(i=1;i<13;i=i+2) //Cuadrados internos
		FOR(j=1;j<11;j=j+2)
			da_vinci(id_fpg_stages,1,id_color_amarillo,mapa[i][j].en_x,mapa[i][j].en_y);
		END
	END	
END
/**************************************/

/**** Proceso colocador_items ****/
FUNCTION colocador_items(byte cantidad)
PRIVATE
	byte i,j;
BEGIN

	rand_seed(time());
	
	REPEAT
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=700; //Bomba
		END
	UNTIL(cantidad==17)
	
	REPEAT
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=701; //Fuego
		END
	UNTIL(cantidad==12)	
	
	REPEAT 
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=702; //Fuego Max
		END
	UNTIL (cantidad==10)
	
	REPEAT 
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=703; //Patines
		END
	UNTIL (cantidad==6)
	
	REPEAT 
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=704; //Sandalias
		END
	UNTIL (cantidad==4)
	
	REPEAT 
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=705; //Vidas
		END
	UNTIL (cantidad==2)
	
	REPEAT 
		i=rand(0,12);
		j=rand(0,10);
		IF(mapa[i][j].objeto!=0 AND mapa[i][j].item==0)
			cantidad--; 
			mapa[i][j].item=706; //Armaduras
		END
	UNTIL (cantidad==0)
END
/**************************************/
