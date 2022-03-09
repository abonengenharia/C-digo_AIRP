clc
clear all
close all

%% Observa��o
% Pelo fato da eletrogeografia possuir uma distribui��o em formato de gradiente em rela��o � proximidades das linhas de transmiss�o a
% parametriza��o para esta caracter�stica ocorre de forma diferente da dos mapas que possuem apenas paletass (legenda) de cores. 
% Logo, regi�es pr�ximas da linhas apresentam maior favorabilidade e diminui a medida que h� o afastamento das linhas de tramiss�o. 

%% 
% ler o mapa original a ser padronizado
A = imread ('Eletrogeografia1.jpg');

% Dimensionamento padr�o, a exemeplo.
m = 600;
n = 900;

% Redimensionar A
I1 = imresize(A,[m n]);
I2=I1;

% Inserir dois cliques por cor na paleta (legenda) de cores do mapa (cliques feitos pelo usu�rio).
% Na eletrogeografia, em geral, s�o apresentadas duas cores: a cor que represente as linhas; e a cor que representa o restante do shape do mapa. 
% Logo, a exemplo, por possuir 2 cores s�o necess�rios 4 cliques + 2 cliques na cor fora do mapa (esta cor necessariamente precisa ser diferente das duas outras cores da legenda)
P1 = impixel(I2);

% Realizar a m�dia pela paleta de cores dos mapas: dois pontos por cada cor da peleta de cores
media1_1 = round((P1(1,1)+ P1(2,1))/2);
media1_2 = round((P1(1,2)+ P1(2,2))/2);
media1_3 = round((P1(1,3)+ P1(2,3))/2);

media2_1 = round((P1(3,1)+ P1(4,1))/2);
media2_2 = round((P1(3,2)+ P1(4,2))/2);
media2_3 = round((P1(3,3)+ P1(4,3))/2);
    

% Nesta ultima m�dia, se recebe dois cliques fora da paleta (legenda) de cores.
% Geralmente � a cor branca.
media13_1 = round((P1(15,1)+ P1(16,1))/2);
media13_2 = round((P1(15,2)+ P1(16,2))/2);
media13_3 = round((P1(15,3)+ P1(16,3))/2);

close all

%% Elimina as varia��es de cor dentro de cada cor da paleta (legenda):  Padroniza��o do mapa pelas cores da peleta (legenda) 

%Defini��es b�sicas. 
padrao = 100;
branco = 255;
Padrao1=branco;

% Definir acesso �s matrizes nos c�digos RGB

c1=1;
c2=2;
c3=3;

% Definir toler�ncias de acordo com cada cor da legenda (peleta) de cores. 

b1=10;
b2=10;

%....
b13=50;


% Contadores
z1=0;
z2=0;

%...
z13=0;


for k1=1:m
       for k2=1:n 
              
           
                
              if (        (   ( I2(k1, k2,c1) >(media1_1-b1) )   &   ( I2(k1, k2,c1)<(media1_1+b1) )   )        &        (    ( I2(k1, k2,c2) >(media1_2-b1) )   &   ( I2(k1, k2,c2)<(media1_2+b1) )   )        &        (   ( I2(k1, k2,c3) >(media1_3-b1) )   &   ( I2(k1, k2,c3)<(media1_3+b1) )   )       )
                 
                  I2(k1, k2,c1) = media1_1 ;
                  I2(k1, k2,c2) = media1_2 ;
                  I2(k1, k2,c3) = media1_3 ;
                  z1=z1+1;
                  
              
              elseif (        (   ( I2(k1, k2,c1) >(media2_1-b2) )   &   ( I2(k1, k2,c1)<(media2_1+b2) )   )        &        (    ( I2(k1, k2,c2) >(media2_2-b2) )   &   ( I2(k1, k2,c2)<(media2_2+b2) )   )        &        (   ( I2(k1, k2,c3) >(media2_3-b2) )   &   ( I2(k1, k2,c3)<(media2_3+b2) )   )       )
                 
                  I2(k1, k2,c1) = media2_1 ;
                  I2(k1, k2,c2) = media2_2 ;
                  I2(k1, k2,c3) = media2_3 ;
                  z2=z2+1;
                  
             
              else%if (        (   ( I2(k1, k2,c1) >(media4_1-b4) )   &   ( I2(k1, k2,c1)<(media4_1+b4) )   )        &        (    ( I2(k1, k2,c2) >(media4_2-b4) )   &   ( I2(k1, k2,c2)<(media4_2+b4) )   )        &        (   ( I2(k1, k2,c3) >(media4_3-b4) )   &   ( I2(k1, k2,c3)<(media4_3+b4) )   )       )
                 
                  I2(k1, k2,c1) = padrao1 ;
                  I2(k1, k2,c2) = padrao1 ;
                  I2(k1, k2,c3) = padrao1 ;
                  z4=z4+1;    
                         
              end
              
      end
end


figure, imshow(I2);

imwrite(I2, 'Eletrogeografia2.tiff');


%% Retira a paleta (legenda) de cores
% Etapa de elimina��o das legendas horizontais. 
% A elimina��o de mapas com legendas verticiais segue a mesma linha de racioc�neo, considerando a vari�vel "n".

A = imread ('Eletrogeografia2.tiff');

% Dimens�es da imagem carregada
m = size(A,1);
n = size(A,2);

I2=A;

cont1=0;
cont2=0;
linha=0;
for k1=1:m 
  % Primeira condicao: ainda fora do mapa(branco)
    if(I2(k1,:,:) ==  padrao1)
        
         cont1 = cont1+1;
         linha = linha+1;
              
  % Segunda condi��o: entra no mapa.          
    else
        cont2=cont2+1;
        cont1=0;
        linha=linha+1;
    end
    
  % A seguir, selecionamos a primeira trasi��oo de  condi��o: sai do mapa evai para o branco(novamente.
  % o restante pode simplimente ser branco, � o que queremos.
    if((cont1 == 1) & ( cont2 > 1 ))
    
            for k1=linha:m
                I2(k1,:,:)=padrao1;
            end
    end
   % o ciclo se repete logo que tivermos condi�oes de percurso entrando e saindo do mapa
end      

figure, imshow(I2);
imwrite(I2, 'Eletrogeografia3.tiff');

%% Desloca o shape do mapa para o canto superior esquerdo (referncial padr�o).
% Esta etapa possibilidade deslocar todos os mapas, um por vez, para um referencial padr�o. 

A = imread ('Eletrogeografia3.tiff');

% Dimens�es da imagem carregada
m = size(A,1);
n = size(A,2);

I1 = A;
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


% m1 apresenta o n�mero de linhas em branco antes de encontrar o mapa propriamente dito. 
% m2 presenta numero de linhas em branco depois de passar o mapa propriamente dito.

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
 
 
% n1 presenta numero de colunas em branco antes de encontrar o mapa propriamente dito. 
% n2 presenta numero de colunas em branco depois de passar o mapa propriamente dito. 
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
% Aqui fazemos o delocamente para cima, at� encontra o limite do mapa.

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

% Aqui fazemos o delocamente para � esquerda, at� encontra o limite do mapa.

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


imwrite(I3, 'Eletrogeografia4.tiff');        

figure, imshow(I3);


%% Compara com shape de mapa padr�o e readpata. 
% Nesta etapa � feita a compara��o do mapa em tratamento e feita a adapata��o para um tamanho padr�o comummo. 
% Padrozinado o tamanho de cada mapa � poss�vel paremetrizar e realizar uma somat�rio de mapas. 

A = imread ('Padrao_Contorno_Final.tiff');% Contorno de uma mapa padr�o que melhore representa o formato da regi�o estudada.
B = imread ('Eletrogeografia4.tiff'); % Continuamos com o exemplo de Insolacao_Solar.
C = imread ('Padrao_Solido_Final.tiff'); % Mapa padr�o, incluindo o contorno, totalmente preecnhido por uma cor espec�fica (preta por exemplo).

m = size(A,1);
n = size(A,2);

A1 = A;
B1 = B;
C1 = C;

% Constante para acessar o c�digo RGB.
c1=1;
c2=2;
c3=3;

% Vairaiveis do tipo padr�o
padrao1=255;
padrao2=0;
padrao3 =50;

% Vari�veis contadoras de linhas e colunas para A e B
linha_red_A=0;
coluna_red_A=0;
linha_em_branco_A=0;
coluna_em_branco_A=0;

linha_red_B=0;
coluna_red_B=0;
linha_em_branco_B=0;
coluna_em_branco_B=0;


% A seguir, s�o apresentadas quatro vari�veis que s�o iguais a zero se nenhuma das 
%condi��es nos FORs em que elas aparecem sejam satisfeita.
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
copia_B=B2;% Precisamos dessa c�pia pois utilizaremos valores antigos de B.

if(linha_red_A > linha_red_B )% Para esta condi��o � necess�rio adicionar linha(s) em B2.
    diferenca_linha =   linha_red_A - linha_red_B;
    passo_linha =   floor( linha_red_A / diferenca_linha );% Arredondamos para o menor inteiro da divisao, para garantir que possamos trabalhar dentro do limite padrao de dimens�o.     
               
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
                                  c=0;% Esta veriavel, � cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k1=1:m 
                                                      if(k1  <= linha_red_A)% N�o h� senditdo em percorremos mais que esse n�mero de linhas, j� que linha_red_A > linha_red_B.

                                                                          if(mod(k1,passo_linha)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valor atualizado de c, ganhamos novos deslocamentes, dados de forma sim�trica na matriz B.
                                                                          B2(k1, k2,c1) = copia_B(k1-c, k2,c1);
                                                                          B2(k1, k2,c2) = copia_B(k1-c, k2,c2);
                                                                          B2(k1, k2,c3) = copia_B(k1-c, k2,c3);
                                                      end
                                    end        

                 end  

elseif (linha_red_A < linha_red_B )% Para esta condi��o � necess�rio eliminar linha(s) em B2.
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
                                  c=0;% Esta veriavel, � cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k1=1:m
                                                      if(k1  <= linha_red_B)

                                                                          if(mod(k1,passo_linha)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma sim�trica na matriz B2.
                                                                          B2(k1, k2,c1) = B2(k1+c, k2,c1);
                                                                          B2(k1, k2,c2) = B2(k1+c, k2,c2);
                                                                          B2(k1, k2,c3) = B2(k1+c, k2,c3);
                                                      end
                                  end        

                                    
                 end 
end

copia_B=B2;% Precisamos atualizar a c�pia de B para que tenhamos as modifica��es nas linas salvas e prontas para serem usadas.

% Pegamos a diferenca das colunas_red entre A e B.

if(coluna_red_A > coluna_red_B )% Para esta condi��o � necess�rio adicionar coluna(s) em B2.
                diferenca_coluna =   coluna_red_A - coluna_red_B;
                passo_coluna =  floor( coluna_red_A / diferenca_coluna );
                   % A seguir, com o passo distribu�do ao longo de toda a
                   % matriz B2, podemos adicionar as colunas faltantes em B2
                         
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
                                  c=0;% Esta veriavel, � cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k2=1:n 
                                                      if(k2  <= coluna_red_A)

                                                                          if(mod(k2,passo_coluna)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma sim�trica na matriz B2.
                                                                          B2(k1, k2,c1) = copia_B(k1, k2-c,c1);
                                                                          B2(k1, k2,c2) = copia_B(k1, k2-c,c2);
                                                                          B2(k1, k2,c3) = copia_B(k1, k2-c,c3);
                                                      end
                                    end        

                 end  

elseif (coluna_red_A < coluna_red_B )% Para esta condi��o � necess�rio eliminar coluna(s) em B2.
                diferenca_coluna =  -(coluna_red_A - coluna_red_B);
                passo_coluna =  floor( coluna_red_A / diferenca_coluna );
                % A seguir, com o passo distribu�do ao longo de toda a
                % matriz B2, podemos eliminar as colunas faltantes em B2.
                
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
                                  c=0;% Esta veriavel, � cada linha , examina o passo. Se verdade, incrementa e desloca a matriz B2.
                                  for k2=1:n 
                                                      if(k2  <= coluna_red_B)

                                                                          if(mod(k2,passo_coluna)== 0)
                                                                                   c=c+1;
                                                                                   A3(k1, k2,c1) = padrao2;
                                                                                   A3(k1, k2,c2) = padrao2;
                                                                                   A3(k1, k2,c3) = padrao2;
                                                                          end
                                                                          % A cada valoor atualizado de c, ganhamos novos deslocamentes, dados de forma sim�trica na matriz B.
                                                                          B2(k1, k2,c1) = B2(k1, k2+c,c1);
                                                                          B2(k1, k2,c2) = B2(k1, k2+c,c2);
                                                                          B2(k1, k2,c3) = B2(k1, k2+c,c3);
                                                      end
                                  end        

                                    
                 end  

end


% O proximo passo consiste em comparar a borda de C(que � B) com A, e ver as mudan�as significativas ao reagrupar.
  
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

figure, imshow(B4)
imwrite(B4, 'Eletrogeografia5.tiff');        


%% Parametriza��o feita obedecendo o gradiente de favarabilidade da eletrogeografia.

A = imread ('Eletrogeografia5.tiff');

% Dimens�es da imagem carregada
m = size(A,1);
n = size(A,2);


%
I1 = imresize(A,[m n]);
I2=I1;

P1 = impixel(I2);

%Aqui, clicar 2x na cor que representa as linhas de transmiss�o.
media1_1 = round((P1(1,1)+ P1(2,1))/2);
media1_2 = round((P1(1,2)+ P1(2,2))/2);
media1_3 = round((P1(1,3)+ P1(2,3))/2);

c1=1;
c2=2;
c3=3;


padrao1=255;
padrao2=0;
padrao3=50;

padrao4=1;

maximo=139; %  Valor m�ximo estebelecido no intrevalo 0-255.

valor = media1_1 ;

% Agora vamos trocar valor por maximo, para paremetrizarmos.
for k1=1:m

            for k2=1:n

                if(I2(k1,k2,c1)==valor)
                  I2(k1,k2,c1)= maximo;
                  I2(k1,k2,c2)= padrao4;
                  I2(k1,k2,c3)= padrao4;
                end


            end
        end       

 P_C_R=0;%Para_Conferir_Right
 P_C_L=0;%Para_Conferir_Left
 P_C_U=0;%Para_Conferir_Up
 P_C_D=0;%Para_Conferir_Down
 R=1;
 L=1;
 U=1;
 D=1;
 
 z=  P_C_R + P_C_L +  P_C_U +P_C_D;

                
   contador=0;   
   padrao5 = 200;% Representa os pixels que teremos que percorrer, como distancia. Para o exemplo, excedemos esse valor com 200.
   while(padrao5 > 2)         
                
                       
                for k1=2:m-1% Para n�o extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=2:n-1
                        
                            % Condi��o para n�o trabalharmos com a cor branca(para n�o subtituirmos por cor branca - falsa).
                            if  (   ( I2(k1, k2,c1)~= padrao1 )   &   ( I2(k1, k2,c2)~= padrao1)   &   ( I2(k1, k2,c3) ~= padrao1 )   )
                               
                                    % Agora comparamos com 'maximo'.                                
                                    if (   ( I2(k1, k2,c1)== maximo )   )
                                           
                                              % Agora inserimos a logica de modifica��o mais coerente.
                                              if   ( I2(k1, k2+R,c1)== padrao3 )    

                                                  I2(k1, k2+R,c1)= maximo-1;
                                                  I2(k1, k2+R,c2)= padrao4;
                                                  I2(k1, k2+R,c3)= padrao4;
                                                 
                                                  P_C_R= P_C_R +1;



                                              end
                                    end
                            end          
                    end

                end
                % A seguir, s�o repetidos os procedimentos para os % movimentos para: esquerda(L),baixo(D),cima(U).

                % Movimento para baixo (D)

                for k2=2:n-1% Para n�o extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=2:m-1
                            % Condi��o para n�o trabalharmos com a cor branca(para n�o subtituirmos por cor branca - falsa).
                            if  (   ( I2(k1, k2,c1)~=padrao1)   &   ( I2(k1, k2,c2)~= padrao1 )   &   ( I2(k1, k2,c3) ~=padrao1 )   )
                                    % Agora comparamos com 'maximo'. 
                                   
                                    if (   ( I2(k1, k2,c1)== maximo )    )
                                                                        
                                                 % Agora inserimos a logica de modifica��o mais coerente.                                        
                                                 if    ( I2(k1+D, k2,c1)== padrao3 ) 

                                                     I2(k1+D, k2,c1)= maximo-1;
                                                     I2(k1+D, k2,c2)= padrao4;
                                                     I2(k1+D, k2,c3)= padrao4;
                                                                       
                                                     P_C_D= P_C_D +1;


                                              end
                                    end
                            end          
                    end

                end

                % Movimento para a esquerda(L)

                m1=m; % Vari�veis locais
                n1=n; 

                for k1=(m1-1):-1:2 % Para n�o extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k2=(n1-1):-1:2
                            % Condi��o para n�o trabalharmos com a cor branca(para n�o subtituirmos por cor branca - falsa)
                            if  (   ( I2(k1, k2,c1)~= padrao1 )   &   ( I2(k1, k2,c2)~= padrao1 )   &   ( I2(k1, k2,c3) ~= padrao1 )   )
                                 
                                    %agora comparamos com 'm�ximo'.
                                    if (   ( I2(k1, k2,c1)== maximo )     )
                                      
                                                  % Agora inserimos a logica de modifica��o mais coerente.
                                                  if  ( I2(k1, k2-L,c1)== padrao3 )     

                                                     I2(k1, k2-L,c1)= maximo-1; 
                                                     I2(k1, k2-L,c2)= padrao4;
                                                     I2(k1, k2-L,c3)= padrao4;
                                                  % decrementamos f3 e nos %movimentos para
                                                  %a esquerda, sem replica sequencial.                                                                   
                                                   P_C_L= P_C_L +1;

                                              end
                                    end
                            end          
                    end

                end

                % Movimento para cima (U).
                m1=m;  % Vari�veis locais.
                n1=n; 

                for k2=(n1-1):-1:2  % Para n�o extrapolarmos as extremidade usamos 2 for(s) da seguinte maneira:
                    for k1=(m1-1):-1:2
                           
                            % Condi��o para n�o trabalharmos com a cor branca(para n�o subtituirmos por cor branca - falsa).
                            if  (   ( I2(k1, k2,c1)~= padrao1 )   &   ( I2(k1, k2,c2)~= padrao1 )   &   ( I2(k1, k2,c3) ~= padrao1 )   )
                                   
                                    % Agora comparamos com 'maximo'. 
                                    if (   ( I2(k1, k2,c1)== maximo )     )
                                       
                                              % Agora inserimos a logica de modifica��o mais coerente.  
                                              if    ( I2(k1-U, k2,c1)== padrao3 )      

                                                             I2(k1-U, k2,c1)= maximo-1;
                                                             I2(k1-U, k2,c2)= padrao4;
                                                             I2(k1-U, k2,c3)= padrao4;
                                                                                                                
                                                  P_C_U= P_C_U +1;

                                              end
                                    end
                            end          
                    end

                end
              
verifica =0;
sinaliza =1;

        for k1=1:m

            for k2=1:n

                if(I2(k1,k2,c1)==padrao3)
                  verifica =    +1;
               end


            end
        end       
       
        if(verifica==0)

           sinaliza =0;

        end      
        if(sinaliza ==0)

           padrao5=1;

        end   
        
maximo = maximo-1;
padrao5 = padrao5 -1; 

contador=contador+1;

   end

   
%% Parametriza��o : Etapa 2 do AIRP
% aproveitando os movimentos de corre��o de pixel, implementamos a parametriza��o. 

% A parametriza��o consisti em atribuir pesos �s cores de acordo com a metodologia proposta.
% Nos casos de estudo, o m�ximo de caracater�sticas n�o excludentes s�o 7 e ocorre no caso da gera��o solar fotovolta�ca centralizada, considerando: 
% irradia��o solar (+); insola��o solar (+); precipita��o (-); temperatura (-); eletrogeografia (+); umidade relativa do ar (-); densidade demogr�fica (+).

% Por estarmos trabalhando com 7 caracter�sticas, logo o m�ximo da cada caracter�sitca recebe 36 e o m�nimo 1. 
% Isto, para que no somat�rio (s�ntese) n�o ultrapasse o m�ximo de 255 em um dos c�digos RGB para 8bits.  
% Observe que no caso da gera��o solar centralizada a metodologia indica 14,28% como pesos iguais para cada caracter�stica n�o impeditiva. 
% O inteiro mais pr�ximo � o 36 em rela��o ao m�ximo de 255. 

% No exemplo da eletrogeografia, a distribui��o deve ser em forma de gradiente..
% Para esta carater�stica, quanto mais pr�ximo da linha melhor a favorabilidade, enquanto mais distante pior � a gera��o analisada. 
% Assim, o m�ximo vale 36 e o m�nimo 1. 


maximo2=36;

for k1=1:m

            for k2=1:n
                
                if (I2(k1,k2,c1)>=139)
                  I2(k1,k2,c1)= 36;
                  
                elseif(I2(k1,k2,c1)>=136 & I2(k1,k2,c1)<140)
                    
                  I2(k1,k2,c1)= 35;
                  
                elseif(I2(k1,k2,c1)>=132 & I2(k1,k2,c1)<136)
                    
                  I2(k1,k2,c1)= 34;
                  
                elseif(I2(k1,k2,c1)>=128 & I2(k1,k2,c1)<132)
                    
                  I2(k1,k2,c1)= 33;
                  
                elseif(I2(k1,k2,c1)>=124 & I2(k1,k2,c1)<128)
                    
                  I2(k1,k2,c1)= 32;
                  
                elseif(I2(k1,k2,c1)>=120 & I2(k1,k2,c1)<124)
                    
                  I2(k1,k2,c1)= 31;
                
                elseif(I2(k1,k2,c1)>=116 & I2(k1,k2,c1)<120)
                    
                  I2(k1,k2,c1)= 30;
                  
                elseif(I2(k1,k2,c1)>=112 & I2(k1,k2,c1)<116)
                    
                  I2(k1,k2,c1)= 29;  
                  
                elseif(I2(k1,k2,c1)>=108 & I2(k1,k2,c1)<112)
                    
                  I2(k1,k2,c1)= 28;  
                  
                elseif(I2(k1,k2,c1)>=104 & I2(k1,k2,c1)<108)
                    
                  I2(k1,k2,c1)= 27; 
                  
                elseif(I2(k1,k2,c1)>=100 & I2(k1,k2,c1)<104)
                    
                  I2(k1,k2,c1)= 26; 
                  
                elseif(I2(k1,k2,c1)>=96 & I2(k1,k2,c1)<100)
                    
                  I2(k1,k2,c1)= 25;  
                
                elseif(I2(k1,k2,c1)>=92 & I2(k1,k2,c1)<94)
                    
                  I2(k1,k2,c1)= 24;  
                
                elseif(I2(k1,k2,c1)>=88 & I2(k1,k2,c1)<92)
                    
                  I2(k1,k2,c1)= 23;  
                  
                elseif(I2(k1,k2,c1)>=84 & I2(k1,k2,c1)<88)
                    
                  I2(k1,k2,c1)= 22;  
                  
                elseif(I2(k1,k2,c1)>=80 & I2(k1,k2,c1)<84)
                    
                  I2(k1,k2,c1)= 21;  
                  
                elseif(I2(k1,k2,c1)>=76 & I2(k1,k2,c1)<80)
                    
                  I2(k1,k2,c1)= 20;  
                 
                elseif(I2(k1,k2,c1)>=72 & I2(k1,k2,c1)<76)
                    
                  I2(k1,k2,c1)= 19;  
                
                elseif(I2(k1,k2,c1)>=68 & I2(k1,k2,c1)<72)
                    
                  I2(k1,k2,c1)= 18;  
                  
                elseif(I2(k1,k2,c1)>=64 & I2(k1,k2,c1)<68)
                    
                  I2(k1,k2,c1)= 17;  
                  
                elseif(I2(k1,k2,c1)>=60 & I2(k1,k2,c1)<64)
                    
                  I2(k1,k2,c1)= 16;  
                  
                elseif(I2(k1,k2,c1)>=56 & I2(k1,k2,c1)<60)
                    
                  I2(k1,k2,c1)= 15;  
                  
                elseif(I2(k1,k2,c1)>=52 & I2(k1,k2,c1)<56)
                    
                  I2(k1,k2,c1)= 14;  
                  
                elseif(I2(k1,k2,c1)>=48 & I2(k1,k2,c1)<52)
                    
                  I2(k1,k2,c1)= 13;  
                  
                elseif(I2(k1,k2,c1)>=44 & I2(k1,k2,c1)<48)
                    
                  I2(k1,k2,c1)= 12;  
                  
                elseif(I2(k1,k2,c1)>=40 & I2(k1,k2,c1)<44)
                    
                  I2(k1,k2,c1)= 11;  
                  
                elseif(I2(k1,k2,c1)>=36 & I2(k1,k2,c1)<40)
                    
                  I2(k1,k2,c1)= 10;  
                  
                elseif(I2(k1,k2,c1)>=32 & I2(k1,k2,c1)<36)
                    
                  I2(k1,k2,c1)= 9;  
                  
                elseif(I2(k1,k2,c1)>=28 & I2(k1,k2,c1)<32)
                    
                  I2(k1,k2,c1)= 8;  
                  
                elseif(I2(k1,k2,c1)>=24 & I2(k1,k2,c1)<28)
                    
                  I2(k1,k2,c1)= 7;  
                  
                elseif(I2(k1,k2,c1)>=20 & I2(k1,k2,c1)<24)
                    
                  I2(k1,k2,c1)= 6;  
                  
                elseif(I2(k1,k2,c1)>=16 & I2(k1,k2,c1)<20)
                    
                  I2(k1,k2,c1)= 5;  
                  
                elseif(I2(k1,k2,c1)>=12 & I2(k1,k2,c1)<16)
                    
                  I2(k1,k2,c1)= 4;  
                  
                elseif(I2(k1,k2,c1)>=8 & I2(k1,k2,c1)<12)
                    
                  I2(k1,k2,c1)= 3;  
                  
                elseif(I2(k1,k2,c1)>=4 & I2(k1,k2,c1)<8)
                    
                  I2(k1,k2,c1)= 2;  
                
                elseif(I2(k1,k2,c1)>=0 & I2(k1,k2,c1)<4)
                    
                  I2(k1,k2,c1)= 1;  
                  
                end


            end
        end                       
     

figure, imshow(I2);

imwrite(I2, 'Eletrogeografia_Final.tiff');



% A etapa subsequente consistem em somar todos os mapas. 









