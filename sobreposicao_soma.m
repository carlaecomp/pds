%% Sobreposicao e soma 

%% Preparando os sinais de entrada

SIZE_X = 3000/2;
SIZE_H = 220/2;

M = SIZE_H;
N = 512;
L = N - (M -1);


t_x = 0:1:(SIZE_X-1);
t_h = 0:1:(SIZE_H-1);
% syms x
% ans = rectangularPulse(t_x, -750)
% plot(ans)

X = ones(1, SIZE_X); % Porta X
plot(X)
figure
H = ones(1, SIZE_H); % Porta H

NEW_X_SIZE = SIZE_X + L -rem(SIZE_X, L);
aprox_x = NEW_X_SIZE - SIZE_X;
aprox_h = N -M;

H = [H zeros(1,aprox_h)];
X = [X zeros(1,aprox_x)];

%% Convoluindo os sinais

tam_bloco = NEW_X_SIZE/L;

Y_k = zeros(tam_bloco, N);

Y = zeros(1, tam_bloco*(N-M+1));
for k = 0:tam_bloco-1
    begin_v = (L*k+1)
    end_v = L*(k+1)
    X_l = X(begin_v:end_v);
    X_l = [X_l zeros(1, M-1)];
    length(X_l)
    length(H)
    Y_freq = fft(X_l).*fft(H);
    Y_k(k+1,:)=ifft(Y_freq); %%mudar depois aqui
    plot(Y_k(k+1,:))
    figure;
end

begin_v = 1;
end_v = L;
for k = 0:tam_bloco-2
    Y(begin_v:end_v) = Y_k(k+1,1:L);
    begin_sobre = end_v +1 ;
    end_sobre = N*(k+1);
    
    dif = end_sobre - begin_sobre+1;
    
    length(Y_k(k+1, N-dif+1:N));
%     length(Y_k(k+2, 1:dif))
%     length(Y(begin_sobre:end_sobre))
    
    
    begin_v = end_sobre+1;
    end_v = begin_v -1 + L;
    
    Y(begin_sobre:end_sobre) = Y_k(k+2, 1:dif) + Y_k(k+1, N-dif+1:N);
end
 plot(Y)

