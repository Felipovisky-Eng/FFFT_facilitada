# My_fft - Processamento Digital de Sinais no MATLAB

`My_fft` é uma função personalizada desenvolvida para tornar a análise espectral no MATLAB mais intuitiva, completa e visual. Diferente da função `fft()` nativa, que exige cálculos manuais de eixos e ajustes de escala, esta função automatiza o preenchimento de zeros (Zero Padding), janelamento, normalização e plotagem.

## 🚀 Funcionalidades

* **Zero Padding Inteligente:** Utiliza `nextpow2` para otimizar a velocidade e a resolução visual do espectro.
* **Janelamento Integrado:** Suporte para janelas de Hamming, Hanning e Blackman.
* **Escalas Flexíveis:** Visualização em Magnitude Linear ou dB (PDS padrão).
* **Normalização:** Opções para normalização pelo valor máximo ou pelo número de amostras.
* **Frequências Negativas:** Opção de visualizar o espectro completo (com `fftshift`) ou apenas a parte positiva.
* **Plot Automático:** Gera gráficos de Magnitude e Fase formatados instantaneamente.

## 🛠 Parâmetros

| Parâmetro | Tipo | Descrição | Padrão |
| :--- | :--- | :--- | :--- |
| `Y` | Array | Vetor 1D de entrada (sinal no tempo). | **Obrigatório** |
| `fs` | Float | Frequência de amostragem em Hz. | **Obrigatório** |
| `n` | Int | Fator de resolução (ex: 2 dobra os pontos da FFT). | `2` |
| `NORM` | String | Tipo de normalização: `"maxi"`, `"porN"`, `"None"`. | `"maxi"` |
| `Escala`| String | Escala do eixo Y: `"dB"` ou `"None"`. | `"dB"` |
| `janela`| String | Janela: `"Retangular"`, `"Hamming"`, `"Hanning"`, `"Blackman"`. | `"Retangular"` |
| `plot` | Char | Habilitar gráfico: `'y'` para sim, `'n'` para não. | `'y'` |
| `lado` | String | Extensão: `"tudo"` (pos/neg) ou `"Metade"` (só pos). | `"tudo"` |

## 📦 Como instalar

1.  Baixe o arquivo `My_fft.m`.
2.  Coloque-o na pasta do seu projeto ou adicione-o ao *Path* do MATLAB:
    ```matlab
    addpath('caminho/para/a/pasta/da/funcao')
    ```

## 💻 Exemplos de Uso

### Análise Básica (Padrão)
```matlab
[mag, fase, freq] = My_fft(sinal, 1000);
