%% Filtragem

name = 'audio.wav';
[y,Fs] = audioread(name);

figure;
plot(y);
title("Sinal original");

f = 2000; % frequencia de 2000 hz
% amp = max(y)/2;
ts = 1/Fs; % periodo
T = 10; % tempo da gravacao do audio
t = 0:ts:T;
t = t(1:end -1); % garantir que tera 80000 amostras
ruido = sin(2*pi*f*t'); % ruido  senoidal com frequencia de 2000 hz

y = y + ruido;

syms x %% variavel x para calcular limite da funcao
h = sin(0.325*pi*(x - 62))/(pi*(x-62))*(0.5 -0.5*cos((2*pi*x)/124)); %% funcao do filtro a ser calculado a limite

n = 0:124;
for i=1:length(n)
    if (n(i)==62) h_n(i)=limit(h,x,62);        
    else h_n(i)= sin(0.325*pi*(n(i) - 62))/(pi*(n(i)-62))*(0.5 -0.5*cos((2*pi*n(i))/124));
    end    
end

Y_soma = sobreposicao_soma(y', h_n);

name = 'filtrado_soma.wav';
audiowrite(name, Y_soma, Fs);

figure;
plot(Y2);
title("filtragem por sobreposicao e soma")

Y_armazenamento = sobreposicao_armazenamento(y', h_n);

name = 'filtrado_armazenamento.wav';
audiowrite(name, Y_armazenamento, Fs);

figure;
plot(Y_armazenamento);
title("filtragem por sobreposicao e armazenamento");
