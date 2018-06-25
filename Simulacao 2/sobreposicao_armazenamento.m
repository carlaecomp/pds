function Y = sobreposicao_armazenamento(X, H)
    
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