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

aprox_x = L -rem(SIZE_X, L);
NEW_X_SIZE = SIZE_X + aprox_x;
aprox_h = N -M;

H = [H zeros(1,aprox_h)];
X = [X zeros(1,aprox_x)];
%% Convoluindo os sinais

qtd_bloco = NEW_X_SIZE/L;

Y = zeros(qtd_bloco, N);

for k = 1:qtd_bloco-1
    begin_v = (L*k+1);
    end_v = L*(k+1);
    X_l = X(begin_v:end_v);
    
    X_l = [X_l zeros(1, M-1)];
    Y_freq = fft(X_l).*fft(H);
    Y(k+1,:) = ifft(Y_freq);
end
%% Sobreposicao

for k = 0:qtd_bloco -2
    Y(k+1,N-(M-1)+1:N) = Y(k+1,N-(M-1)+1:N) + Y(k+2, 1:(M-1));
end

sobrep = Y(:,M:N)';
Y=(sobrep(:))';

figure;
plot(Y);
title('Y');