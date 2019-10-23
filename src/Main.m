clear; close all; clc;

% ЧАСТОТНЫЙ СИГНАЛ I
L1F_PT = zeros(1,511);
x = [1 1 1 1 1 1 1 1 1]; % Стартовая последовательность
for i = 1:511
   L1F_PT(i) = x(7);
   x_temporary = xor(x(5), x(9));
   x = circshift(x,[0 1]);
   x(1) = x_temporary;
end
L1F_PT(L1F_PT==1)=-1;
L1F_PT(L1F_PT==0)=1;
L1F_PT = kron(ones(1,1e3),L1F_PT);

Freq_chipVT = 5.11e6; % Частота следования импульсов
T = 0:1/Freq_chipVT:1 - 1/Freq_chipVT; % Дискреты времени, определяющие формируемую ПСП
Number_PRN_RAZR = 25; % Число разрядов генератора ДК
x1 = ones(1,Number_PRN_RAZR); % Начальное состояние ГДК
L1F_VT = nan(1, length(T)); % Формирование ДК
for t = 1:length(T)
    L1F_VT(t) = x1(10);
    temp = xor(x1(3),x1(25));
    x1 = circshift(x1,[0 1]);
    x1(1) = temp;
end
L1F_VT(L1F_VT==1)=-1;
L1F_VT(L1F_VT==0)=1;

Freq_chipVT = 5110000.0023;
%Freq_chipVT = 5.11e6;
Freq_chipPT = Freq_chipVT/10;
TGIP_VT = length(L1F_VT)/Freq_chipVT;
TGIP_PT=length(L1F_PT)/Freq_chipPT;
Freq = Freq_chipVT*24;


Signal = complex(Sampling(TGIP_PT,L1F_PT,Freq),Sampling(TGIP_VT,L1F_VT,Freq));
Signal(1:1e3) = 2*Signal(1:1e3);
Signal = circshift(Signal,[0 -ceil(Freq*30700e-9)]);
save('Signal_LF.mat','Signal','Freq');
clear;
