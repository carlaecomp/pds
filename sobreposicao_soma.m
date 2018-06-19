%% Sobreposicao e soma 

%% Preparando os sinais de entrada

SIZE_X = 3000;
SIZE_H = 220;

M = SIZE_H;
N = 512;
L = N - (M -1);

t_x = -SIZE_X/2:SIZE_X/2-1;
t_h = -SIZE_H/2:SIZE_H/2-1;
X = rectangularPulse(-SIZE_X/4, SIZE_X/4, t_x);
H = rectangularPulse(-SIZE_H/4, SIZE_H/4, t_h);

NEW_X_SIZE = SIZE_X + L -rem(SIZE_X, L);
aprox_x = L -rem(SIZE_X, L);
aprox_h = N -M;

H = [H zeros(1,aprox_h)];
length(H)
X = [X zeros(1,aprox_x)];
length(X)
%% Convoluindo os sinais

tam_bloco = NEW_X_SIZE/L;

Y_k = zeros(tam_bloco, N);

Y = zeros(1, tam_bloco*(N-M+1));
plot(conv(X,H))
title("conv do matlab")
figure

for k = 0:tam_bloco-1
    begin_v = (L*k+1);
    end_v = L*(k+1);
    X_l = X(begin_v:end_v);
    X_l = [X_l zeros(1, M-1)];
    Y_freq = fft(X_l).*fft(H);
    Y_k(k+1,:) = ifft(Y_freq); %%mudar depois aqui
%     plot(Y_k(k+1,:))
%     title(strcat("conv parcial", num2str(k)))
%     figure
%     plot(conv(X_l, H))
%     title(strcat("conv parcial 2 ",num2str(k))
%     figure
end

begin_v = 1;
end_v = L;
for k = 0:tam_bloco-2
    Y(begin_v:end_v) = Y_k(k+1,1:L);
    begin_sobre = end_v +1 ;
    end_sobre = N*(k+1)+1;
    
    dif = end_sobre - begin_sobre+1; 
    
    
    
    begin_v = end_sobre+1;
    end_v = begin_v -1 + L
    
    Y(begin_sobre:end_sobre) = Y_k(k+1, N-dif+1:N) + Y_k(k+2, 1:dif);
    plot(Y)
    title('Y');
    figure
    
end
%  plot(Y)
%  title('Y');