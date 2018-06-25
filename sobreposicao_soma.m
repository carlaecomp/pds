function Y = sobreposicao_soma(X, H)

    SIZE_X = length(X);
    SIZE_H = length(H);

    M = SIZE_H;
    N = 512;
    L = N - (M -1);
    
    aprox_x = L -rem(SIZE_X, L);
    NEW_X_SIZE = SIZE_X + aprox_x;
    aprox_h = N - M;

    
    H = [H zeros(1,aprox_h)];
    X = [X zeros(1,aprox_x)];

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

    for k = 0:qtd_bloco -2
        Y(k+1,N-(M-1)+1:N) = Y(k+1,N-(M-1)+1:N) + Y(k+2, 1:(M-1));
    end

    sobrep = Y(:,M:N)';
    Y=(sobrep(:))';