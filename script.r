# se establece el directorio de trabajo
setwd("D:/Informacion/master/Almacenamiento de datos y su administracion/wdr")
url<-'http://www1.ncdc.noaa.gov/pub/data/swdi/stormevents/csvfiles/'
datos<-'datos'
descarga<-'download'

# Se establece el valoR de las variables usadas en
# las siguientes funciones
if( !file.exists(descarga) ) {
  dir.create(file.path(descarga), recursive=TRUE) 
   if( !dir.exists(descarga) ) {
      stop("No existe directorio")
   }
}

if( !file.exists(datos) ) {
  dir.create(file.path(datos), recursive=TRUE) 
   if( !dir.exists(datos) ) {
      stop("No existe directorio")
   }
}


FILES<-c(
'StormEvents_fatalities-ftp_v1.0_d2001_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2002_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2003_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2004_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2005_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2006_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2007_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2008_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2009_c20160223.csv', 
'StormEvents_fatalities-ftp_v1.0_d2010_c20160223.csv')


# FILES es la lista de archivos para ser descargados.
# Otras variables deben ser declaradas para evitar colocar rutas en el código.
for( files in FILES ){
  # Se valida si el archivo descompactado ya existe en el área de datos.
  if( ! file.exists(paste0(datos,'/',files))) {
    print(paste0('no existe en datos ',datos,'/',files))
  # Si no existe se busca el archivo compactado en el área de descarga.
    if( ! file.exists(paste0(descarga,'/',files,'.gz'))){
        print(paste0('no existe en descarga ',descarga,'/',files,'.gz'))
        download.file(paste0(url,'/',files,'.gz'),paste0(descarga,'/',files,'.gz'))
    }
    else
	{
	   print(paste0('si existe en descarga ',descarga,'/',files,'.gz'))
	}
	# aqui debo descomprimir revisar el package en que esta gunzip()
  }
  else
  {
    print(paste0('si existe en datos ',datos,'/',files))
  }
}