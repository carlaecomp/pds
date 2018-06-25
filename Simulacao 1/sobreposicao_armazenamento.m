%% Sobreposicao e armazenamento 

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
aprox_h = N - M;

%%% Tornando H divisivel por N
H = [H zeros(1,aprox_h)];
%%% Tornando X divisivel por L
X = [X zeros(1,aprox_x)];

%% Convoluindo os sinais

qtd_bloco = NEW_X_SIZE/L;

Y = zeros(qtd_bloco, N);

last_end_v = 0;
for k = 1:qtd_bloco-1
    begin_v = (L*k+1);
    end_v = L*(k+1);
    X_l = X(begin_v:end_v);
    
    if( k == 1) X_l = [zeros(1, M-1) X_l]; 
    else X_l = [X((last_end_v - M +2):last_end_v) X_l];
    end    
    
    Y_freq = fft(X_l).*fft(H);
    Y(k+1,:) = ifft(Y_freq);
    last_end_v = end_v;
end

sobrep = Y(:, M:N)';
Y=(sobrep(:))';

figure;
plot(Y);
title('Y Sobreposicao e Armazenamento');