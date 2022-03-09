clc
clear all
close all

%Leitura dos mapas parametrizados (mesmo tamanhno e refenrecial)
%O Exemplo a seguir contempla os mapas da geração solar concentrada

%Caracterísitcas não excludentes
A = imread ('Irradiacao_Solar_Final.tiff');
B = imread ('Insolacao_Solar_Final.tiff');
C = imread ('Precipitacao_Final.');
D = imread ('Temperatura_Final.');
E = imread ('Eletrogeografia_Final.');
F = imread ('Umidade_Relativa__Final.');
G = imread ('Densidade_Demografica_Final.');

% Soma
Soma_Final = A+B+C+D+E+F+G;
figure, imshow(Soma_Final);

% Caracteísticas excludentes
I = imread ('Preservacao_Ambiental_Final.tiff');
J = imread ('Declividade_Final.tiff');
L = imread ('Hidrografia_Final.tiff');


m = size(A,1);
n = size(A,2);

%Adicionando as áreas de exclusão em soma final. 

for k1=1:m
    for k2=1:n
        if( (I(k1,k2,1)==0) || (J(k1,k2,1)==0)|| (L(k1,k2,1)==0)  )
            
        Soma_Final(k1,k2,1)=0;           
         end
    end 
end

figure, imshow(Soma_Final);
%Salvando o mapa soma final
imwrite(Soma_Final, 'Soma_Final.tiff');



