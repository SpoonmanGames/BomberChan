/**** Proceso Animacion ****/
PROCESS Animacion(int inicial, int final)
BEGIN
	father.graph=father.graph+1;						//Hace avanzar el graph
	IF(father.graph<inicial OR father.graph>final)		//Evalua que este en el rango
		father.graph=inicial;							// Si no lo esta se deja el graph inicial
	END
END
/**************************************/

/**** Proceso da_vinci ****/
PROCESS da_vinci(int IDFILE, int NUM_GRAPH, int COLOR, int X0, int Y0) //Cuadrado de 32x32
BEGIN
	drawing_map(IDFILE,NUM_GRAPH);
	
	drawing_color(COLOR);
	
	draw_box(X0-15,Y0-31,X0+16,Y0);
END
/**************************************/

/**** Proceso da_bomba ****/
PROCESS da_bomba(int IDFILE, int NUM_GRAPH, int COLOR, int X0, int Y0) //Cuadrado de 31x31
BEGIN
	drawing_map(IDFILE,NUM_GRAPH);
	
	drawing_color(COLOR);
	
	draw_box(X0-14,Y0-30,X0+15,Y0-1);
END
/**************************************/

/**** Proceso bracito ****/
PROCESS bracito(x,y, string tipo_bracito)
PRIVATE
	graph_inicial;
	graph_final;
	byte lag;
	choque;
BEGIN
	lag=0;
	z=501;
	file=id_fpg_stages;
	
	da_vinci(id_fpg_stages,1,id_color_rojo,x,y); // Pinta de color rojo el cuadrado donde aparece
	
	SWITCH(tipo_bracito)
		CASE "centro":
			graph_inicial=661;
			graph_final=669;
			
			LOOP
				IF(lag==3)
					Animacion(graph_inicial,graph_final);
					lag=0;
				END
				
				FRAME;
				
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "izq":
			graph_inicial=631;
			graph_final=639;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "der":
			graph_inicial=611;
			graph_final=619;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "arriba":
			graph_inicial=621;
			graph_final=629;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "abajo":
			graph_inicial=601;
			graph_final=609;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "horizontal":
			graph_inicial=641;
			graph_final=649;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
		CASE "vertical":
			graph_inicial=651;
			graph_final=659;
			LOOP
				IF(lag==3)
				Animacion(graph_inicial,graph_final);
				lag=0;
				END

				FRAME;
				IF(graph==graph_final)
					BREAK;
				END
				lag++;
			END
		END
	END
ONEXIT
	da_vinci(id_fpg_stages,1,id_color_negro,x,y);	
END
/**************************************/

/**** Proceso Loading ****/
PROCESS Loading(byte espera)
PRIVATE
	byte i;
	byte espera_std;
BEGIN
	signal_action(S_KILL,S_IGN);
	espera_std=10;
	file=id_fpg_menu;
	x=320;
	y=240;
	z=0;
	FROM i=0 TO espera_std;
		fade_off();
		FRAME;
	END
	graph=21;
	FROM i=0 TO espera_std;
		fade_on();
		FRAME;
	END
	FROM i=0 TO espera;
		FRAME;
	END
	FROM i=0 TO espera_std;
		fade_off();
		FRAME;
	END

	graph=999;
	FROM i=0 TO espera_std;
		fade_on();
		FRAME;
	END	
END
/**************************************/

/**** Proceso Reloj ****/
PROCESS reloj(int tiempo_total)
PRIVATE
	int minutos; int min;
	byte segundos_u; int seg_u;
	byte segundos_d; int seg_d;
	byte lag;
BEGIN
	lag=60;
	minutos=tiempo_total;
	segundos_d=0;
	segundos_u=0;

	IF(tiempo_total==6)
		write(id_fnt_tiempou,125,23,3,"-:--");
	ELSE
		min = write(id_fnt_tiempou,125,23,4,""+minutos);
		write(id_fnt_tiempou,140,23,4,":");
		seg_d = write(id_fnt_tiempou,155,23,4,""+segundos_d);
		seg_u = write(id_fnt_tiempou,175,23,4,""+segundos_u);
	END
	
	FRAME;
	
	LOOP

		IF(tiempo_total==6)
			BREAK;
		END
	
		IF(lag==60)
			delete_text(seg_u);
			IF(segundos_u==0)
				segundos_u=9;
			ELSE
				segundos_u--;
			END
			seg_u = write(id_fnt_tiempou,175,23,4,""+segundos_u);
			lag=0;
		
			IF(segundos_u==9)
				delete_text(seg_d);
				IF(segundos_d==0)
					segundos_d=5;
				ELSE
					segundos_d--;
				END
				seg_d = write(id_fnt_tiempou,155,23,4,""+segundos_d);
				
				delete_text(min);
				IF(segundos_d==5)
					minutos--;
				END
				min = write(id_fnt_tiempou,125,23,4,""+minutos);
			END
		END
		
		IF(pjes_vivos==1 OR pjes_vivos==0)
			delete_text(0);
			BREAK;
		END
		
		IF(minutos==0 AND segundos_d==0 AND segundos_u==0)
			BREAK;
		END
		lag++;
		FRAME;
	END
END
/**************************************/

/**** Proceso borde_items ****/
PROCESS borde_items(x,y)
PRIVATE
	byte lag;
BEGIN
	file=id_fpg_stages;
	z=father.z+1;
	graph=695;
	lag=0;
	
	LOOP
		IF(NOT(exists(father)))
			BREAK;
		END
		
		IF(lag==7)
			Animacion(695,699);
			lag=0;
		END
		lag++;
		FRAME;
	END
END
