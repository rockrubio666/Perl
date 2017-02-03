#!perl
#Monroy Rubio Cristian Alexis

use warnings;
use strict;

=pod

=head1 NumerosPrimos
El programa, recibe un arreglo de numeros, los recorre y ve
cuales son primos, posteriormente los imprime, esto se hace validando
si el modulo del numero entre 2,3,4 o 7 da cero.

Ejemplo:
@numeros = (2..50);
Resultado: 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47
=cut

my @numeros = (1..100);
my @primos = ();
my $x = 0;
my @pragma = ("Los pragmas son módulos que pueden mostrarnos errores o advertencias durante la compilación o nos permiten tratar de distinta forma a los arreglos o escalares");


foreach(@numeros){
	if($_ < 2 || $_ == 1){
		print($_);
	}
		
	if($_ %2 !=0 && $_ %3 != 0 && $_ %5!=0 && $_ %7 !=0 || $_ == 2 || $_ == 3 || $_ == 5 || $_ == 7 ){ 
		$primos[$x] = $_;
		$x = $x +1;
	}
}
print "@primos\n";
print "@pragma\n";
