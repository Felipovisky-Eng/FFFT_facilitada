        function [magnitude, fase, frequencia] = My_fft(Y, fs, n, NORM, Escala, janela, Plot, lado)
    % Função FFT personalizada e simplificada e com o fftshift
                % magnitude, Fase, Frequências = My_fft ( Y , fs , n , NORM , Escala,
                  % janela,  plot, lado)
                % Y = [Array] meu vetor 1D de entrada que quero analizar as frequências
                % fs = [float] meu valor de amostragem
                % n = [int  ] Relação para reslução da FFT, um número inteiro que se relaciona com o tamanho do vetor de dados. Exemplo:
                   % n = 2 , Y tem 128 amostras, N da fft = 256.
                   % Manter o n = 1 faz a fft de leigo, e fração de 1 (Ex.: 1/2) faz o truncamento
                   % ela utiliza automatico o nextpow2 para poder colocar y em uma base 2
                    % Valor padrão = 2
                % Norm = [STRING] tipo de normalização, [ maxi , porN , None]
                   % maxi = Faz a normalização dividindo a fft de Y pelo seu valor máximo
                   % porN = Divide a FFT DE Y pelo valor tamanho de Y
                   % None = Nenhuma normalização
                    % Valor padrão = maxi
                % Escala = [STRING] A escala da fft [dB , None]
                    % dB = Escala em logaritimo de base 10 com 20 dB/década (Padrão de PDS)
                    % None = Escala padrão
                      % Valor padrão = dB
                % Janela = [STRING] tipo de janelamento aplicado a Y antes da FFT
                    % [Retangular, Hamming, Hanning,Blackman]
                        % Valor padrão = Retangular
                % Plot = [CHAR] Habilita ou desabilita a plotagem de gráficos [y,n]
                    % y = Habilita os gráficos
                    % n = Desabilita os gráficos
                        % Valor padrão = y
                % lado = [Char] se vai plotar só a parte negativa ou positiva [tudo,
                     % Metade]
                     % tudo = frequencias negativas e positivas
                     % Metade = frequencias positivas somente
                        % Valor padrão = tudo

    arguments
        Y
        fs
        n = 2
        NORM = "maxi"
        Escala = "dB"
        janela = "Retangular"
        Plot = "y"
        lado = "tudo"
    end

    L = length(Y);
    
    % --- 1. JANELAMENTO ---
    switch lower(janela)
        case "hamming";    Y = Y .* hamming(L)';
        case "hanning";    Y = Y .* hann(L)';
        case "blackman";   Y = Y .* blackman(L)';
        % Retangular não faz nada (janela de 1s)
    end

    % --- 2. RESOLUÇÃO (n e nextpow2) ---
    N_fft = 2^nextpow2(L * n);

    % --- 3. EXECUÇÃO DA FFT ---
    % Usamos fftshift para centralizar as frequências negativas e positivas
    S_comp = fftshift(fft(Y, N_fft)); 
    
    % Vetor de frequências
    frequencia = (-N_fft/2 : N_fft/2 - 1) * (fs / N_fft);

    % --- 4. MAGNITUDE E FASE ---
    magnitude = abs(S_comp);
    fase = angle(S_comp); % Em radianos

    % --- 5. NORMALIZAÇÃO ---
    if NORM == "maxi"
        magnitude = magnitude / max(magnitude);
    elseif NORM == "porN"
        magnitude = magnitude / L;
    end

    % --- 6. ESCALA ---
    if Escala == "dB"
        magnitude = 20 * log10(magnitude + eps); % eps evita log(0)
    end

    % --- 7. SELEÇÃO DE LADO (Corte) ---
    if lado == "Metade"
        indices = frequencia >= 0;
        frequencia = frequencia(indices);
        magnitude = magnitude(indices);
        fase = fase(indices);
    end

    % --- 8. PLOT ---
    if Plot == "y"
        figure;
        subplot(2,1,1);
        plot(frequencia, magnitude);
        title('Magnitude da FFT');
        grid on;
        if Escala == "dB", ylabel('dB'); else, ylabel('Magnitude'); end
        
        subplot(2,1,2);
        plot(frequencia, fase);
        title('Fase (rad)');
        grid on;
        xlabel('Frequência (Hz)');
    end
end