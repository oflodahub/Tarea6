
PACKAGES<-c("utils")
# PACKAGES es una lista con los nombres de los paquetes a utilizar.  
for (package in PACKAGES ) {
  if (!require(package, character.only=T, quietly=T)) {
     install.packages("R.utils",type="source")
     library("R.utils")
  }
}

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
	print(paste0("descomprimiendo ",descarga,'/',files,'.gz'))
	gunzip(paste0(descarga,'/',files,'.gz'),paste0(datos,'/',files))
  }
  else
  {
    print(paste0('si existe en datos ',datos,'/',files))
  }
}

# se elimina Fatalities en caso de existir
if( exists("Fatalities") ){
	printf("se elimna Fatalities")
    rm(Fatalities)
}
# termina de eliminar

# ...
for( file in FILES ){
	printf(paste0("cargando en Fatalities ",datos,'/',file,"\n"))
    if( !exists("Fatalities" ) ) {
		
        Fatalities<-read.csv( paste0(datos,'/',file), header=T, sep=",", na.strings="")
        # Cualquier otra cosa que haga falta...
    } 
# ...
# ...
    else {
        data<-read.csv(paste0(datos,'/',file), header=T, sep=",", na.strings="")
        Fatalities<-rbind(Fatalities,data)
        # Cualquier otra cosa que haga falta...
    }
}
# Se elimina la variable temporal.
print("eliminando varaibles temporales\n")
rm(data)
# ...
print(paste("número de registros ",nrow(Fatalities)))



