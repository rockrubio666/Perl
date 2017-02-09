#!/usr/bin/perl
#Monroy Rubio Cristian Alexis

use warnings;
use strict;
use HTML::Template; #Importa HTML Template
=pod

=head1 Passwd y HTML
El programa tiene 2 subrutinas, en passwd, recibe un archivo, en este caso una copia de /etc/passwd
y devolverá como resultado, cada uno de los elementos del archivo, separados por ":".

En la segunda rutina llamada showFrom, se crea el template de html, usando los parametros recibidios de la
subrutina passwd.

Ejemplo:
my $filename = "passwd.txt"
archivo passwd.html

También hice un intento de separar el shell :,v
Se imprime como shell2 en el html :v :v 
=cut


open FILE,">passwd.html" or die "Error";
print FILE &showForm();
close FILE;

sub showForm{
		my $output;
		my $template = HTML::Template->new(filename => './template.tmpl');
		my $info=&passwd;
		my @loop_data=();
		while(@{$info->[0]}){
				my %row_data;
				$row_data{llaveprin}=shift @{$info->[0]};
				$row_data{user}=shift @{$info->[1]};
				$row_data{pass}=shift @{$info->[2]};
				$row_data{uid}=shift @{$info->[3]};
				$row_data{gid}=shift @{$info->[4]};
				$row_data{desc}=shift @{$info->[5]};
				$row_data{home}=shift @{$info->[6]};
				$row_data{shell}=shift @{$info->[7]};
				$row_data{shell2}=shift @{$info->[8]};
				push(@loop_data,\%row_data);
		}
		$template->param(interfaces => \@loop_data); 
		$output.=$template->output();
		return $output;
}
sub passwd{
	
	my $filename="passwd.txt";
	my %hash2;
	my %hash3;
	open FR,"<",$filename;
	my @file = (<FR>); 
	for(@file){
		my %hash;
		if(/(.*):(.*):(.*):(.*):(.*):(.*):(.*)/){
			$hash{"user"} = $1; 
			$hash{"pass"} = $2;
			$hash{"uid"}  = $3;
			$hash{"gid"}  = $4;
			$hash{"desc"} = $5;
			$hash{"home"} = $6;
			$hash{"shell"}= $7;
			
			for ($7){
				my %shell;
				if(/(.*)\/(.*)\/(.*)/){
					$shell{"usr"} = $1;
					$shell{"bin"} = $2;
					$shell{"nologin"} = $3;
				}
			}
		}
		
		my $temp = $hash{"user"}; 
		$hash2{$temp}=\%hash; 
		
		my $temp2 = $hash{"shell"}; 
		$hash3{$temp2}=\%hash; 
	}	
		
		my @llaveprin = %hash2;
		my @shell2 = %hash3;
		my @user;
		my @pass;
		my @uid;
		my @gid;
		my @desc;
		my @home;
		my @shell;
		my @usr;
		my @bin;
		my @nologin;
		
		
		
		for my $llaveprin(keys %hash2){
			my @tmp= $hash2{$llaveprin}->{user},"\n"||" ";
			push(@user,shift @tmp);
			@tmp= $hash2{$llaveprin}->{pass},"\n"||" "; 
			push(@pass,shift @tmp);
			@tmp= $hash2{$llaveprin}->{uid},"\n"||" ";
			push(@uid,shift @tmp);
			@tmp= $hash2{$llaveprin}->{gid},"\n"||" ";
			push(@gid,shift @tmp);
			@tmp= $hash2{$llaveprin}->{desc},"\n"||" ";
			push(@desc,shift @tmp);
			@tmp= $hash2{$llaveprin}->{home},"\n"||" ";
			push(@home,shift @tmp);
			@tmp= $hash2{$llaveprin}->{shell},"\n"||" ";
			push(@shell,shift @tmp);
			
			for my $shell2(keys %hash3){
				my @tmp1= $hash3{$shell2}->{usr},"\n"||" ";
				push(@usr,shift @tmp1);
				@tmp1= $hash3{$shell2}->{bin},"\n"||" ";
				push(@bin,shift @tmp1);
				@tmp1= $hash3{$shell2}->{nologin},"\n"||" ";
				push(@nologin,shift @tmp1);
			}
			
		}
		my @info=(\@llaveprin,\@user,\@pass,\@uid,\@gid,\@desc,\@home,\@shell,\@shell2,\@usr,\@bin,\@nologin);
		return \@info;
	close FR;

}
