#!/usr/bin/perl
#Monroy Rubio Cristian Alexis

use warnings;
use 5.014;
use strict;

=pod

=head1 Buscador con expresiones
Este programa va a buscar correos, direcciones ip, urls y nombres de dominio.
Esto con ayuda de expresiones regulares, para ello recibe como parametro el nombre del archivo
y devuelve como resultado el número de coincidencias y el nombre de la coincidencia

Ejemplo:

perl 02CMonroy.pl datos.txt

Total | IP

10 	  | 192.168.0.1

=cut
my $num_args = $#ARGV + 1; #$#ARGV, guarda el numero de elementos en el arreglo, se le suma 1 debido a que $#ARGV -1 = @ARGV
my $arg1 = $ARGV[0];
#Num args
if($num_args != 1){ # !=1, ya que no toma en cuenta ni "perl", ni "el archivo.pl"
	print ("Error, introducelo de la siguiente forma: \n");
	print ("perl archivo.pl archivo.txt\n");
}else{
	print("Aquí vamos :,v\n");
}

#archivo existente 
if (not -e $arg1 ) {
	print ("El archivo o ruta  no existe :,v \n");
}

#Variables para contar
my $ip = 0; 
my $correo = 0;
my $dominio = 0;
my $url = 0;

#Hashes
my %totalIp=();
my %totalCorreo=();
my %totalDominio=();
my %totalUrl=();

#Archivo de salida y log
my $archivo = "Coincidencias.txt";
my $log;

#Variables usadas para acceder a los valores
my $clave = 0;
my $contador = 0;

open(FI, "<", $arg1) or die "No se puede\n";
open($log, ">", "log.txt") or die "No se puede\n";
open(STDERR, ">>&=", $log);
$log->autoflush(1);


while(<FI>){
	chomp;
			if(/http(s)?\:\/\/(([A-Za-z]{3,50}\.){2,})([A-Za-z]*)(\/[_A-Za-z-]{1,100}){2,}/){ #urls
				$url++;
					if(defined $totalUrl{$&}){ #Si la url ya se encuentra en el hash, 
						$totalUrl{$&} = $totalUrl{$&} + 1; #Le suma uno a su valor
					}else{ #De lo contrario
						$totalUrl{$&}=1; #Lo agrega al hash
					}
			}
			elsif(/([_A-Za-z0-9-]+)([\.|\,|\;|\:\?\¿\{\}\!\¡]+)*([_A-Za-z0-9-]+)([\.|\,|\;|\:\?\¿\{\}\!\¡])*([A-Za-z0-9]+)*\@([A-Za-z0-9-]+)*(\.[A-Za-z0-9]+)*/){ #correos
				$correo++;
				if(defined $totalCorreo{$&}){
						$totalCorreo{$&} = $totalCorreo{$&} + 1;
					}else{
						$totalCorreo{$&}=1;
					}
			}elsif(/(([A-Za-z]{3,50}\.){2,})([A-Za-z0-9]*)/){ #dominios
				$dominio++;
				if(defined $totalDominio{$&}){
						$totalDominio{$&} = $totalDominio{$&} + 1;
					}else{
						$totalDominio{$&}=1;
					}
				
			}elsif(/(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])/){ #ips
				$ip++;
				if(defined $totalIp{$&}){
						$totalIp{$&} = $totalIp{$&} + 1;
					}else{
						$totalIp{$&}=1;
					}
			}
	}
close(FI);


open(FO,">", $archivo) or die "No se puede escribir :,v\n";
print("Revisa el archivo Coincidencias.txt para ver los resultados :v\n");


print (FO "----------Correos desglosados---------\n");
print (FO "Total   |  Correo\n");
foreach $clave (sort keys %totalCorreo){ #Por cada clave, ordenados de acuerdo al codigo ascii
	
	print(FO "",$totalCorreo{$clave}, "   |   ", "   $clave\n"); #Imprime cada clave con su valor
}
print(FO "Coincidencias correo: $correo\n");


print (FO "----------Ip's desglosadas----------\n");
print (FO "Total   |  Ip\n");
foreach $clave (sort keys %totalIp){
	
	print(FO "",$totalIp{$clave}, "   |   ", "   $clave\n");
}
print (FO "Coincidencias ip: $ip\n");

print (FO "----------Dominios desglosadas----------\n");
print (FO "Total   |  Dominio\n");
foreach $clave (sort keys %totalDominio){
	
	print(FO "",$totalDominio{$clave}, "   |   ", "   $clave\n");
}
print(FO "Coincidencias dominio: $dominio\n");

print (FO "----------Url's desglosadas----------\n");
print (FO "Total   |  URL\n");
foreach $clave (sort keys %totalUrl){
	
	print(FO "",$totalUrl{$clave}, "   |   ", "   $clave\n");
}
print(FO "Coincidencias url: $url\n");

close(FO);
