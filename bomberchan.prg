/**** Estructuras ****/
TYPE tp_config_botones
	byte dispositivo; // 0 para teclado 1 para joystick
	byte boton_arriba;
	byte boton_abajo;
	byte boton_izquierda;
	byte boton_derecha;
	byte boton_bomba;
	byte boton_especial;
	byte boton_detonar;
END

TYPE tp_stats
	byte			player=0;
	byte			vidas=1;	  // carroña = 0
	int				velocidad=200;  
	byte			bombas=2;
	byte			rango=2;	   // Maximo = 8
	byte			tipo_bomba=0; // Bomba default = 0
	byte			maldicion=0;  // estar sano = 0
	byte 			able=1; // Enable = 1
END

TYPE tp_estadisticas
	string			nombre="Bomber-chan";
	unsigned byte	victoria=0;
	unsigned byte	derrota=0;
	unsigned int	muertes=0;
	unsigned int	asesinatos=0;
END

TYPE tp_mapa
	int en_x;
	int en_y;
	int objeto; // 0 si no hay objeto en ese lugar (guardara IDs)
	int item; // 0 si no hay item
END
/**************************************/

include "DLL/import.prg";

/**** Constantes ****/
CONST
	_Pos_arriba=1;
	_Pos_abajo=2;
	_Pos_lateral=3;
	
	_mover_arriba=1;
	_mover_abajo=2;
	_mover_izq=3;
	_mover_der=4;
	
	_hat_up=1;
	_hat_right=2;
	_hat_down=4;
	_hat_left=8;
	
	_joy_triangulo=0;
	_joy_circulo=1;
	_joy_equis=2;
	_joy_cuadrado=3;
	
	_joy_L2=4;
	_joy_R2=5;
	_joy_L1=6;
	_joy_R1=7;
	
	_joy_select=8;
	_joy_start=9;
	
	_joy_L3=10;
	_joy_R3=11;
END
/**************************************/

/**** Variables Globales ****/
GLOBAL
	/* Configuracion de botones */
	tp_config_botones config_botones_player[4];
	
	/* PERSONAJES */
	bomber bomber[4];
	byte	pjes_vivos;
	
	/* IDENTIFICADORES(ID) */
	int id_fpg_stages;
	int id_fpg_menu;
	int id_fnt_menu_normal;
	int id_fnt_submenu_normal;
	int id_fnt_submenu_titulo;
	int id_fnt_tiempou;
	int id_color_amarillo;
	int id_color_rojo;
	int id_color_verde;
	int id_color_azul;
	int id_color_negro;
	int id_color_blanco;
	int id_fpg_bomber_white;
	int id_fpg_bomber_black;
	int id_fpg_bomber_skyblue;
	int id_fpg_bomber_green;
	int id_fpg_bomber_yellow;
	int id_m_sub_menu;
	int id_wav_moverse;
	int id_wav_escoger;
	int id_wav_volver;
	int id_wav_muere;
	int id_wav_putbomb;
	int id_wav_explosion;
	
	/* PARA DIFERENTES 'PANTALLAS' */
	byte level;
	byte sub_level;
	byte sub_sub_level;
	boolean go;
	
	/* POSICION EN EL MAPA */
	tp_mapa mapa[ 12 ][ 10 ];
	
END

DECLARE Process bomber(co_x,co_y,file, byte player, byte map_durezas) // file = ID del file fpg
	PUBLIC
		tp_stats		stats;
		tp_estadisticas estadisticas;
		unsigned int	graph_inicial; //futuros argumentos para process animacion
		unsigned int	graph_final;
	END
END
/**************************************/

include "DLL/include.prg";

/**** Proceso Main ****/
PROCESS Main();
BEGIN

	set_title("Bomber-CHAN! BETA v.0.4");
	set_icon(load_fpg("images/menu.fpg"),2);
	set_mode(640,480,32,MODE_WINDOW);

	set_fps(60,9);
	set_song_volume(0);
	id_color_amarillo=rgb(228,255,0);                    	// Obtiene el color amarillo
	id_color_rojo=rgb(255,0,0);								// Obtiene el color rojo
	id_color_verde=rgb(0,255,0);							// Obtiene el color verde
	id_color_azul=rgb(0,0,255);								// Obtiene el color azul
	id_color_negro=rgb(0,0,0);								// Obtiene el color negro
	id_color_blanco=rgb(255,255,255);						// Obtiene el color blanco
	
	load("config/botones.sav", config_botones_player);
	level=0;

	pjes_vivos=2;
	menu("MAN","MAN","OFF","OFF","OFF","Medium",1,1,"Random","ON",1);
	
END
/**************************************/
