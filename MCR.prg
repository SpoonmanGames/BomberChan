// Procesos encargados de:
// Movimiento, Colisiones y Redondeo

/**** Proceso Avanzar ****/
PROCESS Avanzar(byte direccion, bomber bomberman, byte durezas, string direccion_auto)
PRIVATE
	int 	colisionador_izquierdo;
	int		colisionador_derecho;
	int		colisionador_central_izq;
	int		colisionador_central;
	int		colisionador_central_der;
	int 	colisionador_pies;
	
	int		avance_x;
	int		avance_y;
	
	byte 	pos_central,pos_pies;
	
BEGIN
	x=(father.x/father.resolution);
	y=(father.y/father.resolution);
	avance_x=0;
	avance_y=0;
	
	colisionador_pies	   	=	map_get_pixel(id_fpg_stages,durezas,x,y-16);
	
	IF(direccion_auto=="OFF")
		SWITCH(direccion)
			CASE _mover_arriba:
				colisionador_izquierdo =	map_get_pixel(id_fpg_stages,durezas, x-14,y-33);
				colisionador_derecho   =	map_get_pixel(id_fpg_stages,durezas, x+15,y-33);
				colisionador_central_izq =  map_get_pixel(id_fpg_stages,durezas, x-7,y-33);
				colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y-33);
				colisionador_central_der =  map_get_pixel(id_fpg_stages,durezas, x+8,y-33);
				//colisionador_pies	   =	map_get_pixel(id_fpg_stages,durezas,x,y-16);
								
				//write(0,x,y-33,4,"X");
								
				IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
					IF(colisionador_central_izq == id_color_amarillo)
						father.x += bomberman.stats.velocidad;
					ELIF(colisionador_izquierdo==id_color_amarillo)
						father.x += bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					ELIF(colisionador_central_der == id_color_amarillo)
						father.x -= bomberman.stats.velocidad;					
					ELIF(colisionador_derecho==id_color_amarillo)
						father.x -= bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					END
					
					avance_y = bomberman.stats.velocidad;
				ELIF(colisionador_central == id_color_verde AND colisionador_pies == id_color_verde) // BPP
					
					/* posiciones*/
					pos_central = locator(y-33,101);
					pos_pies = locator(y-16,101);
					
					IF(pos_central == pos_pies)
						avance_y = bomberman.stats.velocidad;
					END
					
				ELIF(colisionador_central_der == id_color_amarillo AND colisionador_central_izq != id_color_amarillo)
					colisionador_central_izq=map_get_pixel(id_fpg_stages,durezas, x-16,y-15);
					IF(colisionador_central_izq!=id_color_verde)
						father.x -= bomberman.stats.velocidad;		
					END
				ELIF(colisionador_central_izq == id_color_amarillo AND colisionador_central_der != id_color_amarillo)
					colisionador_central_der=map_get_pixel(id_fpg_stages,durezas, x+17,y-15);
					IF(colisionador_central_der!=id_color_verde)
						father.x += bomberman.stats.velocidad;		
					END
				END

				father.y -= avance_y;
				
			END
			
			CASE _mover_abajo:
				colisionador_derecho	=	map_get_pixel(id_fpg_stages,durezas, x-14,y+1);
				colisionador_izquierdo	=	map_get_pixel(id_fpg_stages,durezas, x+15,y+1);
				colisionador_central_izq =  map_get_pixel(id_fpg_stages,durezas, x+8,y+1);
				colisionador_central	=	map_get_pixel(id_fpg_stages,durezas, x,y+1);
				colisionador_central_der =  map_get_pixel(id_fpg_stages,durezas, x-7,y+1);
				//colisionador_pies	  	=	map_get_pixel(id_fpg_stages,durezas,x,y-16);
				
				IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)			
					IF(colisionador_central_izq == id_color_amarillo)
						father.x -= bomberman.stats.velocidad;
					ELIF(colisionador_izquierdo==id_color_amarillo)
						father.x -= bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					ELIF(colisionador_central_der == id_color_amarillo)
						father.x += bomberman.stats.velocidad;					
					ELIF(colisionador_derecho==id_color_amarillo)
						father.x += bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					END
					
					avance_y = bomberman.stats.velocidad;
				ELIF(colisionador_central == id_color_verde AND colisionador_pies == id_color_verde) //BPP
				
					/* posiciones*/
					pos_central = locator(y+1,101);
					pos_pies = locator(y-16,101);
					
					IF(pos_central == pos_pies)
						avance_y = bomberman.stats.velocidad;
					END
					
				ELIF(colisionador_central_der == id_color_amarillo AND colisionador_central_izq != id_color_amarillo)
					colisionador_central_der=map_get_pixel(id_fpg_stages,durezas, x+17,y-15);
					IF(colisionador_central_der!=id_color_verde)
						father.x += bomberman.stats.velocidad;		
					END
				ELIF(colisionador_central_izq == id_color_amarillo AND colisionador_central_der != id_color_amarillo)
					colisionador_central_izq=map_get_pixel(id_fpg_stages,durezas, x-16,y-15);
					IF(colisionador_central_izq!=id_color_verde)
						father.x -= bomberman.stats.velocidad;		
					END
				END
				
				father.y += avance_y;
				
			END
			
			CASE _mover_izq:
				colisionador_izquierdo	=	map_get_pixel(id_fpg_stages,durezas, x-16,y-1);
				colisionador_derecho	=	map_get_pixel(id_fpg_stages,durezas, x-16,y-30);
				colisionador_central_izq =  map_get_pixel(id_fpg_stages,durezas, x-16,y-7);
				colisionador_central	=	map_get_pixel(id_fpg_stages,durezas, x-16,y-15);
				colisionador_central_der =  map_get_pixel(id_fpg_stages,durezas, x-16,y-23);
				//colisionador_pies	   	=	map_get_pixel(id_fpg_stages,durezas,x,y-16);
				
				IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)			
					IF(colisionador_central_izq == id_color_amarillo)
						father.y -= bomberman.stats.velocidad;
					ELIF(colisionador_izquierdo==id_color_amarillo)
						father.y -= bomberman.stats.velocidad;
						avance_x = bomberman.stats.velocidad;
					ELIF(colisionador_central_der == id_color_amarillo)
						father.y += bomberman.stats.velocidad;					
					ELIF(colisionador_derecho==id_color_amarillo)
						father.y += bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					END
					
					avance_x = bomberman.stats.velocidad;
				ELIF(colisionador_central == id_color_verde AND colisionador_pies == id_color_verde) //BPP
					
					/* posiciones*/
					pos_central = locator(x-16,143);
					pos_pies = locator(x,143);
					
					IF(pos_central == pos_pies)
						avance_x = bomberman.stats.velocidad;
					END
					
					
				ELIF(colisionador_central_der == id_color_amarillo AND colisionador_central_izq != id_color_amarillo)
					colisionador_central_izq=map_get_pixel(id_fpg_stages,durezas, x,y+1);
					IF(colisionador_central_izq!=id_color_verde)
						father.y += bomberman.stats.velocidad;
					END
				ELIF(colisionador_central_izq == id_color_amarillo AND colisionador_central_der != id_color_amarillo)
					colisionador_central_der=map_get_pixel(id_fpg_stages,durezas, x,y-33);
					IF(colisionador_central_der!=id_color_verde)
						father.y -= bomberman.stats.velocidad;
					END
				END
				
				father.x=father.x-avance_x;
				
			END
			
			CASE _mover_der:
				colisionador_izquierdo	=	map_get_pixel(id_fpg_stages,durezas, x+17,y-30);
				colisionador_derecho	=	map_get_pixel(id_fpg_stages,durezas, x+17,y-1);
				colisionador_central_izq =  map_get_pixel(id_fpg_stages,durezas, x+17,y-23);
				colisionador_central	=	map_get_pixel(id_fpg_stages,durezas, x+17,y-15);
				colisionador_central_der =  map_get_pixel(id_fpg_stages,durezas, x+17,y-7);				
				//colisionador_pies	   	=	map_get_pixel(id_fpg_stages,durezas,x,y-16);
				
				IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)			
					IF(colisionador_central_izq == id_color_amarillo)
						father.y += bomberman.stats.velocidad;
					ELIF(colisionador_izquierdo==id_color_amarillo)
						father.y += bomberman.stats.velocidad;
						avance_x = bomberman.stats.velocidad;
					ELIF(colisionador_central_der == id_color_amarillo)
						father.y -= bomberman.stats.velocidad;					
					ELIF(colisionador_derecho==id_color_amarillo)
						father.y -= bomberman.stats.velocidad;
						avance_y = bomberman.stats.velocidad;
					END
					
					avance_x = bomberman.stats.velocidad;
				ELIF(colisionador_central == id_color_verde AND colisionador_pies == id_color_verde) // BPP
					
					/* posiciones*/
					pos_central = locator(x+17,143);
					pos_pies = locator(x,143);
					
					IF(pos_central == pos_pies)
						avance_x = bomberman.stats.velocidad;
					END
					
				ELIF(colisionador_central_der == id_color_amarillo AND colisionador_central_izq != id_color_amarillo)
					colisionador_central_der=map_get_pixel(id_fpg_stages,durezas, x,y+1);
					IF(colisionador_central_der!=id_color_verde)
						father.y -= bomberman.stats.velocidad;
					END		
				ELIF(colisionador_central_izq == id_color_amarillo AND colisionador_central_der != id_color_amarillo)
					colisionador_central_izq=map_get_pixel(id_fpg_stages,durezas, x,y+1);
					IF(colisionador_central_izq!=id_color_verde)
						father.y += bomberman.stats.velocidad;
					END	
				END

				father.x=father.x+avance_x;
				
			END
		END
	ELSE
		IF(direccion_auto=="UP")
			SWITCH (direccion)
				CASE _mover_der: // ARRIBA Y DERECHA
				
					colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x+15,y-33); //derecho hacia arriba
					colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y-30); //izquierdo hacia la derecha

					IF(colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
					
						colisionador_izquierdo =	map_get_pixel(id_fpg_stages,durezas, x-14,y-33); //izquierdo hacia arriba
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y);  //derecho hacia la derecha
						IF((colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)AND colisionador_pies!=id_color_verde)
			
							IF(colisionador_derecho!=id_color_amarillo)
								father.x += bomberman.stats.velocidad;
							END
							bomberman.graph_inicial=31;
							bomberman.graph_final=40;
							father.flags=0;
							
						ELIF(colisionador_pies==id_color_verde)
								father.y -= bomberman.stats.velocidad;
								father.x += bomberman.stats.velocidad;
						ELIF(colisionador_izquierdo == id_color_amarillo OR colisionador_izquierdo == id_color_azul OR colisionador_izquierdo == id_color_verde)
							
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y-33); //central hacia arriba
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
							
								father.x += bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=0;
							ELSE
								bomberman.graph_inicial=21;
								bomberman.graph_final=30;
								father.x += bomberman.stats.velocidad; 
								father.y -= bomberman.stats.velocidad;
							END
						ELIF(colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
						
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x+17,y-15); //central hacia derecha
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
			
								father.y -= bomberman.stats.velocidad;
								bomberman.graph_inicial=21;
								bomberman.graph_final=30;
							ELSE
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=0;
								father.x += bomberman.stats.velocidad;
								father.y -= bomberman.stats.velocidad;							
							END
						ELIF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
							father.y -= bomberman.stats.velocidad;
							bomberman.graph_inicial=21;
							bomberman.graph_final=30;
						END
					
					ELIF (colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
					
						colisionador_izquierdo  =	map_get_pixel(id_fpg_stages,durezas, x+17,y-1); //derecho hacia la derecha
						IF (colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
							father.y -= bomberman.stats.velocidad;
							bomberman.graph_inicial=21;
							bomberman.graph_final=30;								
						END
					ELIF(colisionador_central == id_color_verde AND colisionador_pies == id_color_verde)
						pos_central=locator(y-33,101);
						pos_pies=locator(y-16,101);
						IF(pos_central==pos_pies)
							father.y -= bomberman.stats.velocidad;
						END
						bomberman.graph_inicial=21;
						bomberman.graph_final=30;
					ELSE
						colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y-33); //central hacia arriba
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y-15); //central hacia derecha
						IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde
							AND colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
							IF(colisionador_pies==id_color_verde)
								father.x += bomberman.stats.velocidad;
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								flags=0;
							ELSE
								father.x -= bomberman.stats.velocidad;
								father.y -= bomberman.stats.velocidad;
								bomberman.graph_inicial=21;
								bomberman.graph_final=30;
							END
						END
					END					
				END
				
				CASE _mover_izq: // ARRIBA E IZQUIERDA
				
					colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x-14,y-33); //izquierdo hacia arriba
					colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-30); //derecho hacia la izquierda
					
					IF(colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
					
						colisionador_izquierdo =	map_get_pixel(id_fpg_stages,durezas, x+15,y-33); //derecho hacia arriba
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-1);  //izquierdo hacia la izquierda
						IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
						
							father.x -= bomberman.stats.velocidad;
							bomberman.graph_inicial=31;
							bomberman.graph_final=40;
							father.flags=1;
						ELIF(colisionador_izquierdo == id_color_amarillo OR colisionador_izquierdo == id_color_azul OR colisionador_izquierdo == id_color_verde)
							
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y-33); //central hacia arriba
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
							
								father.x -= bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=1;
							ELSE
								father.x -= bomberman.stats.velocidad; 
								father.y -= bomberman.stats.velocidad;
								bomberman.graph_inicial=21;
								bomberman.graph_final=30;
							END
						ELIF(colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
						
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x-16,y-15); //central hacia izquierda
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
			
								father.y -= bomberman.stats.velocidad;
								bomberman.graph_inicial=21;
								bomberman.graph_final=30;
							ELSE
								father.x -= bomberman.stats.velocidad;
								father.y -= bomberman.stats.velocidad; 
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=1;						
							END
						ELIF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
							father.y -= bomberman.stats.velocidad;
							bomberman.graph_inicial=21;
							bomberman.graph_final=30;
						END
					
					ELIF (colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
					
						IF (colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
							father.y -= bomberman.stats.velocidad;
							bomberman.graph_inicial=21;
							bomberman.graph_final=30;								
						END
					
					ELSE
						colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y-33); //central hacia arriba
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-15); //central hacia izquierda
						IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde
							AND colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
							father.x += bomberman.stats.velocidad;
							father.y -= bomberman.stats.velocidad;
							bomberman.graph_inicial=21;
							bomberman.graph_final=30;
						END
					END
				END
			END		
			
		ELIF(direccion_auto=="DOWN")
		
			SWITCH (direccion)
				CASE _mover_der: // ABAJO Y DERECHA
					colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x+15,y+1); //izquierdo hacia abajo
					colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y); //derecho hacia la derecha

					IF(colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
					
						colisionador_izquierdo =	map_get_pixel(id_fpg_stages,durezas, x-14,y+1); //derecho hacia abajo
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y-30);  //izquierdo hacia la derecha
						IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
						
							father.x += bomberman.stats.velocidad;
							bomberman.graph_inicial=31;
							bomberman.graph_final=40;
							father.flags=0;
						ELIF(colisionador_izquierdo == id_color_amarillo OR colisionador_izquierdo == id_color_azul OR colisionador_izquierdo == id_color_verde)
							
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y+1); //central hacia abajo
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
							
								father.x += bomberman.stats.velocidad; 
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=0;
							ELSE
								father.x += bomberman.stats.velocidad;
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=11;
								bomberman.graph_final=20;
							END
						ELIF(colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
						
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x+17,y-15); //central hacia derecha
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
			
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=11;
								bomberman.graph_final=20;
							ELSE
								father.x += bomberman.stats.velocidad;
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=0;					
							END
						ELIF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
							father.y += bomberman.stats.velocidad;
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;
						END
					
					ELIF (colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
				
						IF (colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
							father.y += bomberman.stats.velocidad;
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;							
						END
					
					ELSE
						colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y+1); //central hacia abajo
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x+17,y-15); //central hacia derecha
						IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde
							AND colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
							father.x -= bomberman.stats.velocidad;
							father.y += bomberman.stats.velocidad;
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;
						END
					END		
				END
				
				CASE _mover_izq: //ABAJO E IZQUIERDA
				
					colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x-14,y+1); //derecho hacia abajo
					colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-1); //izquierdo hacia la izquierda
					
					IF(colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
					
						colisionador_izquierdo =	map_get_pixel(id_fpg_stages,durezas, x+15,y+1); //izquierdo hacia abajo
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-30);  //derecha hacia la izquierda
						IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
						
							father.x -= bomberman.stats.velocidad;
							bomberman.graph_inicial=31;
							bomberman.graph_final=40;
							father.flags=1;
						ELIF(colisionador_izquierdo == id_color_amarillo OR colisionador_izquierdo == id_color_azul OR colisionador_izquierdo == id_color_verde)
							
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y+1); //central hacia abajo
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
							
								father.x -= bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=1;
							ELSE
								father.x -= bomberman.stats.velocidad; 
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=11;
								bomberman.graph_final=20;
							END
						ELIF(colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
						
							colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x-16,y-15); //central hacia izquierda
							IF(colisionador_central == id_color_amarillo OR colisionador_central == id_color_azul OR colisionador_central == id_color_verde)
			
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=11;
								bomberman.graph_final=20;
							ELSE
								father.x -= bomberman.stats.velocidad;
								father.y += bomberman.stats.velocidad;
								bomberman.graph_inicial=31;
								bomberman.graph_final=40;
								father.flags=1;					
							END
						ELIF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
							father.y += bomberman.stats.velocidad;	
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;
						END
					
					ELIF (colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde)
					
						IF (colisionador_derecho == id_color_amarillo OR colisionador_derecho == id_color_azul OR colisionador_derecho == id_color_verde)
							father.y += bomberman.stats.velocidad;
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;									
						END
					
					ELSE
						colisionador_central   =	map_get_pixel(id_fpg_stages,durezas, x,y+1); //central hacia abajo
						colisionador_derecho   =    map_get_pixel(id_fpg_stages,durezas, x-16,y-15); //central hacia izquierda
						IF(colisionador_central != id_color_amarillo AND colisionador_central != id_color_azul AND colisionador_central != id_color_verde
							AND colisionador_derecho != id_color_amarillo AND colisionador_derecho != id_color_azul AND colisionador_derecho != id_color_verde)
							father.x += bomberman.stats.velocidad;
							father.y += bomberman.stats.velocidad;
							bomberman.graph_inicial=11;
							bomberman.graph_final=20;
						END
					END
				END				
			END
		END
	END
END
/**************************************/
