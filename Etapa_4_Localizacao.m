clc
clear all
close all

%Leitura do mapa padrão totalmente preenchido.
%O Exemplo a seguir contempla os mapas da geração solar concentrada...
A = imread('Padrao_Solido_Final.tiff');

m = size(A,1);
n = size(A,2);

I2 = A;


c1=1;
c2=2;
c3=3;

padrao1=255;
padrao2=0;

% Exemplo de um mapa da federação brasileira com seus limites:
extA = 37.174863;  %valor correspondente a latitude do extremo norte.
extB = 36.990842;  %valor correspondente a latitude do extremo sul.
extC = 6.948487;   %valor correspondente a longitude do extremo oeste.
extD = 7.154161;   %valor correspondente a longitude do extremo leste.


inc1 = (extD - extC)/n;  %incremento da longitude
inc2 = (extB - extA)/m;  %incremento da latitude

% Aqui deixaremos o mapa em dois padroes de cor: padrao1 e padrao2
for k1=1:m 
    for k2=1:n
       
      
           if  (      (    ( I2(k1, k2,c1) <= (padrao1-10) )     &     ( I2(k1, k2,c2) <= (padrao1-10)    ) )   &     ( I2(k1, k2,c1) <= (padrao1-10) )    ) 
               
              % Qualquer cor difernte de branco agora será padrao2              
              I2(k1, k2,c1) = padrao2;
              I2(k1, k2,c2) = padrao2;
              I2(k1, k2,c3) = padrao2;
              
              
           else
              I2(k1, k2,c1) = padrao1;
              I2(k1, k2,c2) = padrao1;
              I2(k1, k2,c3) = padrao1;
              
            
                        
           end
           
    end
end      
figure, imshow(I2); 

% Idetificamos e atribuímos valores às linhas onde possuem as extremidades do mapa, com valores da latitude(norte-sul).
cont1=0;
d1=0;
DELTA1 =0;
DELTA2 =0;

for k1=1:m        
      
           if(I2(k1,:,:) == padrao1 )
                cont1=0;
           else 
              
               cont1=cont1+1;
               d1=d1+1;
           end
           
           
           if(cont1 == c1)
               I2(k1,:,c1) = extA; 
               I2(k1+1,:,c1) = extA;
           
                     
           elseif(cont1 > c1 )
                if( mod(d1,3)==0)
                     I2(k1, :,   c1) =  I2(k1-1, : , c1) + 1;
                     I2(k1+1, :,   c1) =  I2(k1, : , c1);
                     I2(k1+2, :,   c1) =  I2(k1, : , c1);
                     
                     DELTA1 = DELTA1 +1;
                end
           end          
               
 
end 

figure, imshow(I2); 
%  Idetificamos e atribuímos valores às linhas onde possuem as extremidades do mapa, com valores da longitude(leste-oeste).

cont2=0;
d2=0;
for k2=1:n        
      
           if(I2(:,k2,c3) ~= padrao2 )
                cont2=0;
           else 
              
               cont2=cont2+1;
               d2=d2+1;
           end
           
           
           if(cont2 == c1)
               I2(:,k2,c2) = extD; 
               I2(:,k2+1,c2) = extD;
               I2(:,k2+2,c2) = extD;
               
           
                     
           elseif(cont2 > c1 )
               if( mod(d2,4)==0)
                     
                     I2(:, k2,   c2) =  I2( :, k2-1 , c2) + 1;
                     I2(:, k2+1,   c2) =  I2( :, k2 , c2);
                     I2(:, k2+2,   c2) =  I2( :, k2 , c2);
                     I2(:, k2+3,   c2) =  I2( :, k2 , c2);
                     
                     DELTA2 = DELTA2 +1; 
               end    
               
           end          
               
 
end      
figure, imshow(I2);

I3=I2;

% Agora eliminamos todos os dados que não estao no shape do mapa (área excedente do mapa).

for k1=1:m 
    for k2=1:n
       if ( I2(k1,k2,c3) ~= padrao2)
            I2(k1,k2,:) = padrao1;
           
       end
       
    end
end      

                                                                          
figure, imshow(I2);        

imwrite(I2, 'GPS.tiff');  



%% Relacionando Soma Final com o Mapa Padrão georefenciado

% Leitura dos mapas GPS e Soma Final.

A = imread('GPS.tiff');
B = imread('Soma_Final.tiff');


H2 = A;
I2=  B;


Copia_H2 = H2;
Copia_I2 = I2;

% Utilizamos todas as camadas do cógido RGB para fins de informação:

% A favorabilidade é armazenada na camada R do código RGB.
% A latitude é armazenada na camada G do código RGB.
% A longitude é armazenada na camada B do código RGB.

for k1=1:m
    for k2=1:n
        I2(k1,k2,2) = H2(k1,k2,1);
        I2(k1,k2,3) = H2(k1,k2,2);
         
    end 
end

% Gravando o mapa de favorabilidade devidamente georeferenciado. 
imwrite(I2, 'GPS_Parametrizado.tiff');
%% Testando o cálculo da favorabilidade georeferenciada.
% Vamos pegar apenas um poonto por vez.
GPS = impixel(I2);

% Cálculo da latitude, variação nas linhas (de cima para baixo).

Latitude_Extremo_Norte = -6.050678; %Valor precisa ser consultado para a respectiva região.
Latitude_Extremo_Sul = -8.301435; %Valor precisa ser consultado para a respectiva região.

Variacao_Norte_Sul_Conhecida = ( Latitude_Extremo_Sul - Latitude_Extremo_Norte );

DELTA1 = 158; % Este valor é obtido considerando o número efetivo de linhas usadas.

DELTA1_Desconhecido = double ( GPS (1,2));


Variacao_Norte_Sul_Desonhecida = (Variacao_Norte_Sul_Conhecida * DELTA1_Desconhecido)/DELTA1;

% Cálculo da Longitude: variação nas colunas (da esquerda para direita). 

Longitude_Extremo_Leste = -34.796385; %Valor precisa ser consultado para a respectiva região.
Longitude_Extremo_Oeste = -38.761014; %Valor precisa ser consultado para a respectiva região.


Variacao_Leste_Oeste_conhecida = ( Longitude_Extremo_Oeste - Longitude_Extremo_Leste );


DELTA2 = 200;  % Este valor é obtido considerando o número efetivo de colunas usadas.

DELTA2_Desconhecido = double ( GPS (1,3));


Variacao_Leste_Oeste_Desonhecida = ( Variacao_Leste_Oeste_conhecida * DELTA2_Desconhecido )/DELTA2;

% Agora conhecendo a devida conversão, tanto para a latitude como para a longitude, temos  o cálculo do GPS real:

Intensidade_Vermelho = GPS (1,1)% Favorabilidade
Latitude = Latitude_Extremo_Norte + Variacao_Norte_Sul_Desonhecida %latitude
Longitude = Longitude_Extremo_Leste + Variacao_Leste_Oeste_Desonhecida % longitude


% Com o término desta etapa, temos todos os pixels de favorabilidade devidamente georeferenciados e passíveis de serem acessados. 

%% Observação: 
% Para a exibição do mapa final em padrões de cores variantes podem ser utilizadas as funções contour, surf entre outras. 







