clc
clear all
close all

% ler o mapa original a ser padronizado
A = imread ('Insolacao_Solar1.jpg');

% Dimensionamento padrão, a exemeplo.
m = 600;
n = 900;

% Redimensionar A
I1 = imresize(A,[m n]);
I2=I1;

% Inserir dois cliques por cor na paleta (legenda) de cores do mapa (cliques feitos pelo usuário)
% o exemplo seguinte possui 6 cores (12 cliques) + 2 cliques na cor branca(fora do mapa)
P1 = impixel(I2);

% Realizar a média pela paleta de cores dos mapas: dois pontos por cada cor
%da peleta de cores
media1_1 = round((P1(1,1)+ P1(2,1))/2);
media1_2 = round((P1(1,2)+ P1(2,2))/2);
media1_3 = round((P1(1,3)+ P1(2,3))/2);

media2_1 = round((P1(3,1)+ P1(4,1))/2);
media2_2 = round((P1(3,2)+ P1(4,2))/2);
media2_3 = round((P1(3,3)+ P1(4,3))/2);

media3_1 = round((P1(5,1)+ P1(6,1))/2);
media3_2 = round((P1(5,2)+ P1(6,2))/2);
media3_3 = round((P1(5,3)+ P1(6,3))/2);

media4_1 = round((P1(7,1)+ P1(8,1))/2);
media4_2 = round((P1(7,2)+ P1(8,2))/2);
media4_3 = round((P1(7,3)+ P1(8,3))/2);

media5_1 = round((P1(9,1)+ P1(10,1))/2);
media5_2 = round((P1(9,2)+ P1(10,2))/2);
media5_3 = round((P1(9,3)+ P1(10,3))/2);

media6_1 = round((P1(11,1)+ P1(12,1))/2);
media6_2 = round((P1(11,2)+ P1(12,2))/2);
media6_3 = round((P1(11,3)+ P1(12,3))/2);


% Nesta ultima média, se recebe o clique do branco, fora da paleta (legenda) de cores
media13_1 = round((P1(15,1)+ P1(16,1))/2);
media13_2 = round((P1(15,2)+ P1(16,2))/2);
media13_3 = round((P1(15,3)+ P1(16,3))/2);

%Definições básicas. 
padrao = 100;
branco = 255;

close all
%% Elimina as variações de cor dentro de cada cor da paleta (legenda):  Padronização do mapa pelas cores da peleta (legenda) 

% Nesta etapa, para otimizar o processamento computacional, já inserimos a Etapa 2 do AIRP. Ou seja, inserimos a parametrização.

% A parametrização consisti em atribuir pesos às cores de acordo com a metodologia proposta.
% Nos casos de estudo, o máximo de caracaterísticas não excludentes são 7 e ocorre no caso da geração solar fotovoltaíca centralizada, considerando: 
% irradiação solar (+); insolação solar (+); precipitação (-); temperatura (-); eletrogeografia (+); umidade relativa do ar (-); densidade demográfica (+).

% Por estarmos trabalhando com 7 características, logo o máximo da cada caracterísitca recebe 36 e o mínimo 1. 
% Isto, para que no somatório (síntese) não ultrapasse o máximo de 255 em um dos códigos RGB para 8bits.  
% Observe que no caso da geração solar centralizada a metodologia indica 14,28% como pesos iguais para cada característica não impeditiva. 
%O inteiro mais próximo é o 36 em relação ao máximo de 255. 

% No exemplo da insolação solar adotado, a paleta (legenda) de cores apresenta 6 médias.
% Para esta caraterística, quanto maior a média melhor e quanto menor médio pior em relação à geração analisada. 
% Assim, é necessário inserir um passo para cálculo e distribuição na parametrização, conforme a seguir.
% (36-1)/(6-1)=7. logo, para esta característica, o passo é 7. 
% Para passo não inteiro, arredondar para o menor inteiro.


% Definir acesso às matrizes nos códigos RGB

c1=1;
c2=2;
c3=3;

% Definir tolerâncias de acordo com cada cor da legenda (peleta) de cores. 

b1=10;
b2=10;
b3=15;
b4=20;
b5=10;
b6=15;
%....
b13=50;


% Contadores
z1=0;
z2=0;
z3=0;
z4=0;
z5=0;
z6=0;
%...
z13=0;


minimo =1;

for k1=1:m
       for k2=1:n 
              
           
                
              if (        (   ( I2(k1, k2,c1) >(media1_1-b1) )   &   ( I2(k1, k2,c1)<(media1_1+b1) )   )        &        (    ( I2(k1, k2,c2) >(media1_2-b1) )   &   ( I2(k1, k2,c2)<(media1_2+b1) )   )        &        (   ( I2(k1, k2,c3) >(media1_3-b1) )   &   ( I2(k1, k2,c3)<(media1_3+b1) )   )       )
 
                  % Para a situação não paremetrizada
%                   I2(k1, k2,c1) = media1_1 ; 
%                   I2(k1, k2,c2) = media1_2 ;
%                   I2(k1, k2,c3) = media1_3 ;

                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 36; 
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;
                  
                  z1=z1+1;
                  
              
              elseif (        (   ( I2(k1, k2,c1) >(media2_1-b2) )   &   ( I2(k1, k2,c1)<(media2_1+b2) )   )        &        (    ( I2(k1, k2,c2) >(media2_2-b2) )   &   ( I2(k1, k2,c2)<(media2_2+b2) )   )        &        (   ( I2(k1, k2,c3) >(media2_3-b2) )   &   ( I2(k1, k2,c3)<(media2_3+b2) )   )       )
                  % Para a situação não paremetrizada 
%                   I2(k1, k2,c1) = media2_1 ;
%                   I2(k1, k2,c2) = media2_2 ;
%                   I2(k1, k2,c3) = media2_3 ;
                  
                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 29 ;
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;
                  z2=z2+1;
                  
                  
              elseif (        (   ( I2(k1, k2,c1) >(media3_1-b3) )   &   ( I2(k1, k2,c1)<(media3_1+b3) )   )        &        (    ( I2(k1, k2,c2) >(media3_2-b3) )   &   ( I2(k1, k2,c2)<(media3_2+b3) )   )        &        (   ( I2(k1, k2,c3) >(media3_3-b3) )   &   ( I2(k1, k2,c3)<(media3_3+b3) )   )       )
                  % Para a situação não paremetrizada 
%                   I2(k1, k2,c1) = media3_1 ;
%                   I2(k1, k2,c2) = media3_2 ;
%                   I2(k1, k2,c3) = media3_3 ;
                  
                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 22 ;
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;
                  z3=z3+1;
                  
              elseif (        (   ( I2(k1, k2,c1) >(media4_1-b4) )   &   ( I2(k1, k2,c1)<(media4_1+b4) )   )        &        (    ( I2(k1, k2,c2) >(media4_2-b4) )   &   ( I2(k1, k2,c2)<(media4_2+b4) )   )        &        (   ( I2(k1, k2,c3) >(media4_3-b4) )   &   ( I2(k1, k2,c3)<(media4_3+b4) )   )       )
          
                  % Para a situação não paremetrizada                  
%                   I2(k1, k2,c1) = media4_1 ;
%                   I2(k1, k2,c2) = media4_2 ;
%                   I2(k1, k2,c3) = media4_3 ;
                  
                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 15;
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;      
                  z4=z4+1;
                  
                  
              elseif (        (   ( I2(k1, k2,c1) >(media5_1-b5) )   &   ( I2(k1, k2,c1)<(media5_1+b5) )   )        &        (    ( I2(k1, k2,c2) >(media5_2-b5) )   &   ( I2(k1, k2,c2)<(media5_2+b5) )   )        &        (   ( I2(k1, k2,c3) >(media5_3-b5) )   &   ( I2(k1, k2,c3)<(media5_3+b5) )   )       )
                  % Para a situação não paremetrizada    
%                   I2(k1, k2,c1) = media5_1 ;
%                   I2(k1, k2,c2) = media5_2 ;
%                   I2(k1, k2,c3) = media5_3 ;
%                   
                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 8;
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;      
                  z5=z5+1;
                  
                  
              elseif (        (   ( I2(k1, k2,c1) >(media6_1-b6) )   &   ( I2(k1, k2,c1)<(media6_1+b6) )   )        &        (    ( I2(k1, k2,c2) >(media6_2-b6) )   &   ( I2(k1, k2,c2)<(media6_2+b6) )   )        &        (   ( I2(k1, k2,c3) >(media6_3-b6) )   &   ( I2(k1, k2,c3)<(media6_3+b6) )   )       )
 
                  % Para a situação não paremetrizada 
%                   I2(k1, k2,c1) = media6_1 ;
%                   I2(k1, k2,c2) = media6_2 ;
%                   I2(k1, k2,c3) = media6_3 ;
%                   
                  % Para a situação paremetrizada (Etapa 2 do AIRP)
                  I2(k1, k2,c1) = 1;
                  I2(k1, k2,c2) = minimo ;
                  I2(k1, k2,c3) = minimo ;      
                  
                  z6=z6+1;
                 
                  
              elseif (        (   ( I2(k1, k2,c1) >(media13_1-b13) )   &   ( I2(k1, k2,c1)<(media13_1+b13) )   )        &        (    ( I2(k1, k2,c2) >(media13_2-b13) )   &   ( I2(k1, k2,c2)<(media13_2+b13) )   )        &        (   ( I2(k1, k2,c3) >(media13_3-b13) )   &   ( I2(k1, k2,c3)<(media13_3+b13) )   )       )
                 
                  I2(k1, k2,c1) = branco;
                  I2(k1, k2,c2) = branco;
                  I2(k1, k2,c3) = branco;
                  z13=z13+1;
                  
                  
              else
                  I2(k1, k2,c1) = padrao ;
                  I2(k1, k2,c2) = padrao ;
                  I2(k1, k2,c3) = padrao ;
                  z14=z14+1;
                  
              end
              
      end
end
z=z1+z2+z3+z4+z5+z6+z7+z8+z9+z10+z13+z14;
%figure, imshow(I1);

I3=I2;
%figure, imshow(I3);



%% Corrige o pixel circundado por uma única cor padrão (operação tapa "buraco")
% Operação considera a circunscrição do pixel à direita, esquerda, acima e abaixo.


% Defininir constantes para os movimentos:
R=1;
L=1;
U=1;
D=1;


zeta=0;
for k1=2:m-1
    
    for k2=2:n-1
       
      
           if  (  ( I2(k1, k2,c1)~= I2(k1, k2+R,c1) )   &   ( I2(k1, k2,c2)~= I2(k1, k2+R,c2) )   &   ( I2(k1, k2,c3) ~= I2(k1, k2+R,c3)  )   ) 
               
                      if (        (   ( I2(k1, k2+R,c1)== I2(k1, k2-L,c1) )   &   ( I2(k1, k2+R,c2)== I2(k1, k2-L,c2) )   &   ( I2(k1, k2+R,c3) == I2(k1, k2-L,c3)  )   )        &                                           (   ( I2(k1, k2+R,c1)== I2(k1+D, k2,c1) )   &   ( I2(k1, k2+R,c2)== I2(k1+D, k2,c2) )   &   ( I2(k1, k2+R,c3) == I2(k1+D, k2,c3)  )   )        &                                  (   ( I2(k1, k2+R,c1)== I2(k1-U, k2,c1) )   &   ( I2(k1, k2+R,c2)== I2(k1-U, k2,c2) )   &   ( I2(k1, k2+R,c3) == I2(k1-U, k2,c3)  )   )                  )
                  
                  
              I2(k1, k2,c1) = I2(k1, k2+R,c1);
              I2(k1, k2,c2) = I2(k1, k2+R,c2);
              I2(k1, k2,c3) = I2(k1, k2+R,c3);
              
              zeta=zeta+1;
              
              end
               
         

       end      
        
    end
end

I4=I2;
%figure, imshow(I4);




%% Corrige os padrões cinza identificados com o preenchimento pela cor mais próxima.
% O movimento considera preencher o pixel padrão com um movimento (direita, esquerada, acima ou abaixo) por vez, evitando seguir apenas uma direção de preenchimento.
% Portanto, para cada movimento em uma direção pula-se o endereço do pixel subsequente.
% São feitas verreduras até o completo preenchimento das cores "padrão" (cinza)


P_C_R=0;% Para_Conferir
                P_C_L=0;
                P_C_U=0;
                P_C_D=0;
for inter=1:150 % Pode-se estabalecer um máximo de iterações ou inserer um while com a condição de não existência de uma cor padrão nas matrizes. 
               

                f1=0;% Condação essencial para entrar pela primeira vez no último if
                f2=0;
                f3=0;
                f4=0;

                for k1=2:m-1% Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=2:n-1
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa)
                            if  (   ( I2(k1, k2,c1)~= media13_1 )   &   ( I2(k1, k2,c2)~= media13_2 )   &   ( I2(k1, k2,c3) ~= media13_3 )   )
                               
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if (   ( I2(k1, k2,c1)~= padrao )   &   ( I2(k1, k2,c2)~= padrao )   &   ( I2(k1, k2,c3) ~= padrao )   )
                                      
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (        (   ( I2(k1, k2+R,c1)== padrao )   &   ( I2(k1, k2+R,c2)== padrao )   &   ( I2(k1, k2+R,c3) == padrao )   )        &        (f1~=k2)        ) 

                                                  I2(k1, k2+R,c1)= I2(k1, k2,c1);
                                                  I2(k1, k2+R,c2)= I2(k1, k2,c2);
                                                  I2(k1, k2+R,c3)= I2(k1, k2,c3);
                                                  
                                                  % Aqui, incrementamos f1 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para a direita.
                                                  f1=k2+R;
                                                                               
                                                  P_C_R= P_C_R +1;



                                              end
                                    end
                            end          
                    end

                end
                
                % A seguir, são repetidos os procedimentos para os % movimentos para: esquerda(L),baixo(D),cima(U).

                %movimento para baixo (D)

                for k2=2:n-1 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=2:m-1
                        
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa)
                            if  (   ( I2(k1, k2,c1)~= media13_1 )   &   ( I2(k1, k2,c2)~= media13_2 )   &   ( I2(k1, k2,c3) ~= media13_3 )   )
                                
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if (   ( I2(k1, k2,c1)~= padrao )   &   ( I2(k1, k2,c2)~= padrao )   &   ( I2(k1, k2,c3) ~= padrao )   )
                                        
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (        (   ( I2(k1+D, k2,c1)== padrao )   &   ( I2(k1+D, k2,c2)== padrao )   &   ( I2(k1+D, k2,c3) == padrao )   )        &        (f2~=k1)        ) 

                                                  I2(k1+D, k2,c1)= I2(k1, k2,c1);
                                                  I2(k1+D, k2,c2)= I2(k1, k2,c2);
                                                  I2(k1+D, k2,c3)= I2(k1, k2,c3);

                                                  f2=k1+D;
                                                  % Aqui, incrementamos f2 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para baixo.                            
                                                   P_C_D= P_C_D +1;


                                              end
                                    end
                            end          
                    end

                end

                %movimento para a esquerda(L)

                m1=m; %variáveis locais
                n1=n; 

                for k1=(m1-1):-1:2 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=(n1-1):-1:2
                        
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa)
                            if  (   ( I2(k1, k2,c1)~= media13_1 )   &   ( I2(k1, k2,c2)~= media13_2 )   &   ( I2(k1, k2,c3) ~= media13_3 )   )
                                
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if (   ( I2(k1, k2,c1)~= padrao )   &   ( I2(k1, k2,c2)~= padrao )   &   ( I2(k1, k2,c3) ~= padrao )   )
                                        
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (        (   ( I2(k1, k2-L,c1)== padrao )   &   ( I2(k1, k2-L,c2)== padrao )   &   ( I2(k1, k2-L,c3) == padrao )   )        &        (f3~=k2)        ) 

                                                  I2(k1, k2-L,c1)= I2(k1, k2,c1);
                                                  I2(k1, k2-L,c2)= I2(k1, k2,c2);
                                                  I2(k1, k2-L,c3)= I2(k1, k2,c3);

                                                  f3=k2-L;
                                                  % Aqui, incrementamos f3 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para à esquerda.                                                             
                                                   P_C_L= P_C_L +1;

                                              end
                                    end
                            end          
                    end

                end

                %movimento para cima (U)
                m1=m; %variáveis locais
                n1=n; 

                for k2=(n1-1):-1:2 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=(m1-1):-1:2
                        
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa)
                            if  (   ( I2(k1, k2,c1)~= media13_1 )   &   ( I2(k1, k2,c2)~= media13_2 )   &   ( I2(k1, k2,c3) ~= media13_3 )   )
                                  
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if (   ( I2(k1, k2,c1)~= padrao )   &   ( I2(k1, k2,c2)~= padrao )   &   ( I2(k1, k2,c3) ~= padrao )   )
                                        
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (        (   ( I2(k1-U, k2,c1)== padrao )   &   ( I2(k1-U, k2-L,c2)== padrao )   &   ( I2(k1-U, k2-L,c3) == padrao )   )        &        (f4~=k1)        ) 

                                                  I2(k1-U, k2,c1)= I2(k1, k2,c1);
                                                  I2(k1-U, k2,c2)= I2(k1, k2,c2);
                                                  I2(k1-U, k2,c3)= I2(k1, k2,c3);

                                                  f4=k1-U;
                                                  
                                                  % Aqui, incrementamos f3 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para baixo.                                                                
                                                  P_C_U= P_C_U +1;

                                              end
                                    end
                            end          
                    end

                end
end
                 
             
figure, imshow(I1);
figure, imshow(I2);
figure, imshow(I3);
                
imwrite(I2, 'Insolacao_Solar2.tiff');


%% Retira a paleta (legenda) de cores
% Etapa de eliminação das legendas horizontais. 
% A eliminação de mapas com legendas verticiais segue a mesma linha de raciocíneo, considerando a variável "n".

A = imread ('Insolacao_Solar2.tiff');
I2=A;
cont1=0;
cont2=0;
linha=0;

for k1=1:m 
  % Primeira condição:ainda fora do mapa(geralmente cores brancas)
    if(I2(k1,:,:) == (branco))
        
              cont1 = cont1+1;
              linha=linha+1;
              
   % Segunda condição: adentra pixels que realmente fazem parte do mapa.          
    else
        cont2=cont2+1;
        cont1=0;
        linha=linha+1;
    end
    
    % A seguir, selecionamos a primeira trasição de  condição: sai do mapa e vai para o branco(novamente).
    % O restante pode simplimente ser branco: é o que queremos. 
    
    if((cont1 == 1) & ( cont2 > 1 ))
    
            for k1=linha:m
                I2(k1,:,:)=branco;
            end
    end
    % O ciclo se repete logo que tivermos condiçoes de percurso entrando e saindo do mapa
end      

figure, imshow(I2);

imwrite(I2, 'Insolacao_Solar3.tiff');

%% Desloca o shape do mapa para o canto superior esquerdo (referncial padrão).
% Esta etapa possibilidade deslocar todos os mapas, um por vez, para um referencial padrão. 

A = imread ('Insolacao_Solar3.tiff');

% Dimensões da imagem carregada
m = size(A,1);
n = size(A,2);

%
I1 = imresize(A,[m n]);
I2=I1;

c1=1;
c2=2;
c3=3;

padrao1=255;
padrao2=0;
m1=0;
m2=0;
n1=0;
n2=0;

p=50;


% m1 presenta numero de linhas em branco antes de encontrar o mapa propriamente dito 
% m2 presenta numero de linhas em branco depois de passar o mapa propriamente dito 

for k1=1:m        
            
          if(k1<150)
               if  (      (    ( I2(k1,:,c1) >= (padrao1-p) )     &     ( I2(k1,:,c2) >= (padrao1-p)    ) )   &     ( I2(k1,:,c3) >= (padrao1-p) )    ) 

               m1=m1+1;
               end
          end
          
          if(k1>(m-150))
               if  (      (    ( I2(k1,:,c1) >= (padrao1-p) )     &     ( I2(k1,:,c2) >= (padrao1-p)    ) )   &     ( I2(k1,:,c3) >= (padrao1-p) )    ) 

                   m2=m2+1;
               end
          end       
                     
                         
end
 
 
% n1 presenta numero de colunas em branco antes de encontrar o mapa propriamente dito 
% n2 presenta numero de colunas em branco depois de passar o mapa propriamente dito 
 for k2=1:n       
            
          if(k2<150)
               if  (      (    ( I2(:,k2,c1) >= (padrao1-p) )     &     ( I2(:,k2,c2) >= (padrao1-p)    ) )   &     ( I2(:,k2,c3) >= (padrao1-p) )    ) 

               n1=n1+1;
               end
          end
          
          if(k2>(n-150))
               if  (      (    ( I2(:,k2,c1) >= (padrao1-p) )     &     ( I2(:,k2,c2) >= (padrao1-p)    ) )   &     ( I2(:,k2,c3) >= (padrao1-p) )    ) 

                   n2=n2+1;
               end
          end       
                     
                         
 end
 

I3=I2;

% Aqui fazemos o delocamente para cima do shape do mapa, até encontrar o limite da figura.
for k1=1:m
    for k2=1:n
        
        if(k1<(m-m1))
               I3(k1, k2,c1) =  I3(k1+m1, k2,c1);
               I3(k1, k2,c2) =  I3(k1+m1, k2,c2);
               I3(k1, k2,c3) =  I3(k1+m1, k2,c3) ;

        else
               I3(k1, k2,c1) =  padrao1;
               I3(k1, k2,c2) =  padrao1;
               I3(k1, k2,c3) =  padrao1;
               
      
        end
           
    end
end 

figure, imshow(I2);
figure, imshow(I3); 

% Aqui fazemos o delocamente para à esqeurda do shape do mapa, até encontrar o limite da figura.

for k1=1:m
    for k2=1:n
        
        if(k2<(n-n1))
               I3(k1, k2,c1) =  I3(k1, k2+n1,c1);
               I3(k1, k2,c2) =  I3(k1, k2+n1,c2);
               I3(k1, k2,c3) =  I3(k1, k2+n1,c3) ;
               
         
        else
               I3(k1, k2,c1) =  padrao1;
               I3(k1, k2,c2) =  padrao1;
               I3(k1, k2,c3) =  padrao1;
               
       
        end
           
    end
end     

imwrite(I3, 'Insolacao_Solar4.tiff');        

figure, imshow(I3);


%% Compara com shape de mapa padrão e readpata. 
% Nesta etapa é feita a comparação do mapa em tratamento e feita a adapatação para um tamanho padrão comummo. 
% Padrozinado o tamanho de cada mapa é possível paremetrizar e realizar uma somatório de mapas. 


A = imread ('Padrao_Contorno_Final.tiff'); % Contorno de uma mapa padrão que melhore representa o formato da região estudada.
B = imread ('Insolacao_Solar4.tiff'); % Continuamos com o exemplo de Insolacao_Solar.
C = imread ('Padrao_Solido_Final.tiff'); % Mapa padrão, incluindo o contorno, totalmente preecnhido por uma cor específica (preta por exemplo).

m = size(A,1);
n = size(A,2);

A1 = A;
B1 = B;
C1 = C;


c1=1;
c2=2;
c3=3;

% Vairaiveis do tipo padrão
padrao1=255;
padrao2=0;
padrao3 =200;

% Variáveis contadoras de linhas e colunas para A e B
linha_red_A=0; % O vermelho é referente ao contorno do shape do mapa: (255,0,0).
coluna_red_A=0;
linha_em_branco_A=0;
coluna_em_branco_A=0;

linha_red_B=0;
coluna_red_B=0;
linha_em_branco_B=0;
coluna_em_branco_B=0;

% A seguir, são apresentadas quatro variáveis que são iguais a zero se nenhuma das 
%condições nos FORs em que elas aparecem sejam satisfeita.
diferenca_linha=0;
diferenca_coluna=0;
intercala_linha  = 0;
intercala_coluna = 0;



% Os dois FORs a seguir percorrem A1.
% Buscando as linhas que possuem vermelho e abragem o mapa.
for k1=1:m 
    
         if  ( A1(k1, :,:) == padrao1)
        
               linha_em_branco_A= linha_em_branco_A +1;              
          
         else
               linha_red_A=linha_red_A +1;
         end
end

% Buscando as colunas que possuem vermelho e abragem o mapa: pixels de fato do mapa.
for k2=1:n
       
        if  ( A1(:,k2,:) == padrao1)
        
               coluna_em_branco_A = coluna_em_branco_A +1;              
          
         else
               coluna_red_A=coluna_red_A +1;
        
        end 
end

% Os dois FORs a seguir percorrem B1.
% Buscando as linhas que possuem qualquer cor, exceto a branca: pixels de fato do mapa.
for k1=1:m 
    
         if  ( B1(k1, :,:) == padrao1)
        
               linha_em_branco_B= linha_em_branco_B +1;              
          
         else
               linha_red_B=linha_red_B +1;
         end
end

% Buscando as colunas que possuem qualquer cor, exceto a branca: pixels de fato do mapa.
for k2=1:n
       
        if  ( B1(:,k2,:) == padrao1)
        
               coluna_em_branco_B = coluna_em_branco_B +1;              
          
         else
               coluna_red_B=coluna_red_B +1;
        
        end 
end

B2=B1;
A2=A1;
A3=A2;

% Realizando a diferenca das linhas_red entre A e B.
copia_B=B2; % Precisamos dessa cópia pois utilizaremos valores antigos de B.

if(linha_red_A > linha_red_B )% Para esta condição é necessário adicionar linha(s) em B2.
    diferenca_linha =   linha_red_A - linha_red_B;
    passo_linha =   floor( linha_red_A / diferenca_linha );% Arredondamos para o menor inteiro da divisao, para garantir que possamos trabalhar dentro do limite padrao de dimensão.     
                 
                for k1=1:m 
                                  for k2=1:n

                                                      if( A2(k1,k2,1) ~= 200)
                                                           A3(k1, k2,c1) = B1(k1, k2,c1);
                                                           A3(k1, k2,c2) = B1(k1, k2,c2);
                                                           A3(k1, k2,c3) = B1(k1, k2,c3);

                                                      end

                                  end
                end    
                
                        
                
                for k2=1:n
                                  c=0;% Esta veriavel, à cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k1=1:m 
                                                      if(k1  <= linha_red_A)% Não há senditdo em percorremos mais que esse número de linhas, já que linha_red_A > linha_red_B.

                                                                          if(mod(k1,passo_linha)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valor atualizado de c, ganhamos novos deslocamentes, dados de forma simétrica na matriz B.
                                                                          B2(k1, k2,c1) = copia_B(k1-c, k2,c1);
                                                                          B2(k1, k2,c2) = copia_B(k1-c, k2,c2);
                                                                          B2(k1, k2,c3) = copia_B(k1-c, k2,c3);
                                                      end
                                    end        

                 end  

elseif (linha_red_A < linha_red_B )% Para esta condição é necessário eliminar linha(s) em B2.
    diferenca_linha = -( linha_red_A - linha_red_B);
    passo_linha =   floor( linha_red_A / diferenca_linha );% Sempre delimitado pela menor quantidade de linhas(entre A e B).
                 
                 for k1=1:m 
                                  for k2=1:n

                                                      if( A2(k1,k2,1) ~= 200)
                                                           A3(k1, k2,c1) = B1(k1, k2,c1);
                                                           A3(k1, k2,c2) = B1(k1, k2,c2);
                                                           A3(k1, k2,c3) = B1(k1, k2,c3);

                                                      end

                                  end
                 end    
                
                        
                
                 for  k2=1:n
                                  c=0;% Esta veriavel, à cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k1=1:m
                                                      if(k1  <= linha_red_B)

                                                                          if(mod(k1,passo_linha)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma simétrica na matriz B2.
                                                                          B2(k1, k2,c1) = B2(k1+c, k2,c1);
                                                                          B2(k1, k2,c2) = B2(k1+c, k2,c2);
                                                                          B2(k1, k2,c3) = B2(k1+c, k2,c3);
                                                      end
                                  end        

                                    
                 end 
end

copia_B=B2;% Precisamos atualizar a cópia de B para que tenhamos as modificações nas linas salvas e prontas para serem usadas.

% Pegamos a diferenca das colunas_red entre A e B.

if(coluna_red_A > coluna_red_B )% Para esta condição é necessário adicionar coluna(s) em B2.
                diferenca_coluna =   coluna_red_A - coluna_red_B;
                passo_coluna =  floor( coluna_red_A / diferenca_coluna );
                   % A seguir, com o passo distribuído ao longo de toda a
                   % matriz B2, podemos adicionar as colunas faltantes em B2.
                         
                   for k1=1:m 
                                  for k2=1:n

                                                      if( A2(k1,k2,1) ~= 200)
                                                           A3(k1, k2,c1) = B1(k1, k2,c1);
                                                           A3(k1, k2,c2) = B1(k1, k2,c2);
                                                           A3(k1, k2,c3) = B1(k1, k2,c3);

                                                      end

                                  end
                 end    
                
                        
                
                for k1=1:m
                                  c=0;% Esta veriavel, à cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k2=1:n 
                                                      if(k2  <= coluna_red_A)

                                                                          if(mod(k2,passo_coluna)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma simétrica na matriz B2.
                                                                          B2(k1, k2,c1) = copia_B(k1, k2-c,c1);
                                                                          B2(k1, k2,c2) = copia_B(k1, k2-c,c2);
                                                                          B2(k1, k2,c3) = copia_B(k1, k2-c,c3);
                                                      end
                                    end        

                 end  

elseif (coluna_red_A < coluna_red_B )% Para esta condição é necessário eliminar coluna(s) em B2.
                diferenca_coluna =  -(coluna_red_A - coluna_red_B);
                passo_coluna =  floor( coluna_red_A / diferenca_coluna );
                % A seguir, com o passo distribuído ao longo de toda a
                % matriz B2, podemos eliminar as colunas faltantes em B2
                
                for k1=1:m 
                                  for k2=1:n

                                                      if( A2(k1,k2,1) ~= 200)
                                                           A3(k1, k2,c1) = B1(k1, k2,c1);
                                                           A3(k1, k2,c2) = B1(k1, k2,c2);
                                                           A3(k1, k2,c3) = B1(k1, k2,c3);

                                                      end

                                  end
                 end    
                
                        
                
                for k1=1:m
                                  c=0;% Esta veriavel, à cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k2=1:n 
                                                      if(k2  <= coluna_red_B)

                                                                          if(mod(k2,passo_coluna)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma simétrica na matriz B.
                                                                          B2(k1, k2,c1) = B2(k1, k2+c,c1);
                                                                          B2(k1, k2,c2) = B2(k1, k2+c,c2);
                                                                          B2(k1, k2,c3) = B2(k1, k2+c,c3);
                                                      end
                                  end        

                                    
                 end  

end

% O proximo passo consiste em comparar a borda de C(que é B) com A, e ver as mudanças significativas ao reagrupar.
  
for k1=1:m 
    for k2=1:n
       
      if( A1(k1,k2,1) ~= 200)
           A1(k1, k2,c1) = B2(k1, k2,c1);
           A1(k1, k2,c2) = B2(k1, k2,c2);
           A1(k1, k2,c3) = B2(k1, k2,c3);
                       
      end
                            
    end
end           
B3=B2;    

% Agora compara B com o mapa padrao completo, que seria C(totalmente na cor preta(0,0,0), por exemplo).
for k1=1:m 
    for k2=1:n
       
      if( C1(k1,k2,:) == padrao1)
          
           B3(k1, k2,:) = padrao1;
           
      end
      
      if(  C1(k1,k2,:) == padrao2 &  B3(k1, k2,:) == padrao1  )
           B3(k1, k2,:) = padrao3;     
      end
                            
    end
end         
B4=B3;



% Por fim aplicamos o algoritimo para subtituir padrao3 pela cor mais próxima.
% Ou seja, algo parecido com o que foi feito para tapar buracos, utilizado no início da padornização das cores.

 P_C_R=0;%Para_Conferir_Right
 P_C_L=0;%Para_Conferir_Left
 P_C_U=0;%Para_Conferir_Up
 P_C_D=0;%Para_Conferir_Down
 R=1;
 L=1;
 U=1;
 D=1;
for inter=1:50 % Valor menor visto que os mapas já passara um processamento e estão mais próximos de um padrão comum.
               

                f1=0;% Condiçao essencial para entrar pela primeira vez no ultimo if.
                f2=0;
                f3=0;
                f4=0;

                for k1=2:m-1% Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=2:n-1
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa).
                            if    (  B4(k1, k2,c1)~= padrao1  )  
                                    
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if   (  B4(k1, k2,c1)~= padrao3   )   
                                             
                                             % Agora inserimos a logica de modificação mais coerente.
                                              if (        (    B4(k1, k2+R,:) == padrao3  )     &        (f1~=k2)        ) 

                                                  B4(k1, k2+R,c1)=  B4(k1, k2,c1);
                                                  B4(k1, k2+R,c2)=  B4(k1, k2,c2);
                                                  B4(k1, k2+R,c3)=  B4(k1, k2,c3);

                                                  f1=k2+R;
                                                  % Aqui, incrementamos f1 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para a direita.l e evitar a replica de apenas uma cor.
                                                 
                                                  P_C_R= P_C_R +1;



                                              end
                                    end
                            end          
                    end

                end
                % A seguir, são repetidos os procedimentos para os % movimentos para: esquerda(L),baixo(D),cima(U).

                % Movimento para baixo (D).

                for k2=2:n-1 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=2:m-1
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa).
                            if     (  B4(k1, k2,:)~= padrao1 )   
                                
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if   (  B4(k1, k2,:)~= padrao3 )  
                                        
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (          (  B4(k1+D, k2,:)== padrao3 )       &        (f2~=k1)        ) 

                                                  B4(k1+D, k2,c1)=  B4(k1, k2,c1);
                                                  B4(k1+D, k2,c2)=  B4(k1, k2,c2);
                                                  B4(k1+D, k2,c3)=  B4(k1, k2,c3);

                                                  f2=k1+D;
                                                  % Aqui, incrementamos f2 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para baixo.                               
                                                   P_C_D= P_C_D +1;


                                              end
                                    end
                            end          
                    end

                end

                % Movimento para a esquerda(L).

                m1=m; % Variáveis locais.
                n1=n; 

                for k1=(m1-1):-1:2 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=(n1-1):-1:2
                        
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa).
                            if     (   B4(k1, k2,:)~=padrao1 ) 
                                
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if   (  B4(k1, k2,:)~= padrao3 )  
                                        
                                              % Agora inserimos a logica de modificação mais coerente.
                                              if (           (  B4(k1, k2-L,:)== padrao3 )          &        (f3~=k2)        ) 

                                                  B4(k1, k2-L,c1)=  B4(k1, k2,c1);
                                                  B4(k1, k2-L,c2)=  B4(k1, k2,c2);
                                                  B4(k1, k2-L,c3)=  B4(k1, k2,c3);

                                                  f3=k2-L;
                                                  % Aqui, incrementamos f3 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para à esquerda.                                                            
                                                   P_C_L= P_C_L +1;

                                              end
                                    end
                            end          
                    end

                end

                % Movimento para cima (U).
                m1=m; % Variáveis locais.
                n1=n; 

                for k2=(n1-1):-1:2 % Para não extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=(m1-1):-1:2
                        
                            % Condição para não trabalharmos com a cor branca(para não subtituirmos por cor branca - falsa).
                            if     (  B4(k1, k2,:)~= padrao1 ) 
                                
                                    % Agora comparamos com 'padrao'. 
                                    % Assim, excluímos o que não nos interessa que é padrão, assim como branco na condiçao anterior.
                                    if    (  B4(k1, k2,c1)~= padrao3 )
                                        
                                              % Agora inserimos a logica de modificação mais coerente. 
                                              if (          (  B4(k1-U, k2,c1)== padrao3 )           &        (f4~=k1)        ) 

                                                  B4(k1-U, k2,c1)=  B4(k1, k2,c1);
                                                  B4(k1-U, k2,c2)=  B4(k1, k2,c2);
                                                  B4(k1-U, k2,c3)=  B4(k1, k2,c3);

                                                  f4=k1-U;
                                                  % Aqui, incrementamos f3 para podermos pular a posiçao atual e evitar o vício no preenchimento por apenas uma cor.
                                                  % Aqui é feito o movimento para baixo.                                                         
                                                  P_C_U= P_C_U +1;

                                              end
                                    end
                            end          
                    end

                end
end


imwrite(B4, 'Insolacao_Solar_Final.tiff');        

figure, imshow(B1);
figure, imshow(B2);
figure, imshow(B3);
figure, imshow(B4);


% Em seguida, repete-se os procedimentos anterioes para as outras características analisadas.
% Assim são obtidos os mapas finais para ser realizada a etapa subsequente, a de síntese. 



