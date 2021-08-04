%% This script calculate and visualize a Three-Phase unloaded Generator bolted short circuit current. 

%% Brief explanation:
% The ac fault current in a synchronous machine can be modeled by the
% series R–L circuit if a time-varying inductance L(t) or reactance
% X(t) = w*L(t) is employed. In standard machine theory texts, the 
% following reactances are defined:
% X''d = direct axis subtransient reactance ; T''d: direct axis short circuit subtransient time constant
% X'd = direct axis transient reactance ; T’d: direct axis short circuit transient time constant
% Xa = direct axis synchronous reactance ; Ta: Armature short circuit time constant
% where X''d < X'd < Xd . The subscript d refers to the direct axis.
% There are similar quadrature axis reactances X''q, Xq, and Xq. 
% However, if the armature resistance is small, the quadrature axis reactances 
% do not significantly affect the short-circuit current. 
%--------------------------------------------------------------------------------------------
function threephasesc
%% The inputs to the function are:

% S which is the base apparent power in VA
% Ug is the Voltage in V
% percentageEg is the generator percentage operating voltage. For example:
% if The generator is operating at 5% above rated voltage, then
% percentageEg = 0.05, if the generator is operating at the rated voltage
% then percentageEg = 0 .
% f: working frequency in hertz
% Xsecond(x''d): direct axis subtransient reactance in p.u
% Xprime(x'd): direct axis transient reactance in p.u
% Xd(xd): direct axis synchronous reactance in p.u
% Tsecond(T''d): direct axis short circuit subtransient time constant in
% seconds
% Tprime(T'd): direct axis short circuit transient time constant in seconds
% Ta(Ta): Armature short circuit time constant in seconds

% Assumptions:
% We neglect the effect of q axis due that they don't significantly affect 
% the short circuit current as explained before.
% We assume maximum dc offset to obtain the worst short circuit case

%% Example (Typical input problems)
% A 500-MVA 20-kV, 60-Hz synchronous generator with reactances X”d= 0.15 p.u.,
% X’d=0.24 p.u.; Xd =1.1 p.u. and time constants T”d=0.035s, T’d=2s, TA=0.20 s. 

% The generator is operating at 5% above rated voltage and at no-load when a bolted 
% three-phase short circuit occurs on the load side of the breaker.

% Thus, the parameters to enter are as following
# S = 500000000;
% Ug = 20000;
% percentageEg = 0.05;
% f = 60;
% Xsecond = 0.15;
% Xprime = 0.24;
% Xd = 1.1;
% Tsecond = 0.035;
% Tprime = 2;
% Ta = 0.2;
%-----------------------------------------------------------------------------------------------------

S = input('Please enter the Generator apparent power S  in VA: ');
Ug = input('Please enter the Generator rated voltage V in Volt: ');
percentageEg = input('if working voltage is,for example, 5% above rated voltage, enter 0.05, if at rated voltage enter 0: ');
f = input('Please enter the Generator working frequency: ');
Xsecond = input('Please enter Xsecond (subtransient reactance) of the Generator in ohm: ');
Tsecond = input('Please enter Tsecond (subtransient Time constant) of the Generator in seconds: ');
Xprime = input('Please enter Xprime (transient reactance) of the Generator in ohm: ');
Tprime = input('Please enter Tprime (transient Time constant) of the Generator in seconds: ');
Xd = input('Please enter X (steady-state reactance) of the Generator in ohm: ');
Ta = input('Please enter Ta (steady-state Time constant) of the Generator in seconds: ');

t= 0:0.01:3; % You can change the time limit 
              % number whenever you want, just change the 
              % time end value ( 3 in this
              % example)
              
w = 2*pi*f;
Ibase = S/(sqrt(3) * Ug);
Eg = 1 + percentageEg;

Ish = zeros(1,length(t));
Iac_rms = zeros(1,length(t));
Idc_offset = zeros(1,length(t));
Ish_rms = zeros(1,length(t));
for i = 1:length(t)
    Ish(i) = sqrt(2) * Eg * ((1/Xsecond - 1/Xprime) * exp(-t(i)/Tsecond) + (1/Xprime - 1/Xd) ...
        * exp( -t(i)/Tprime) + 1/Xd) * cos(w*t(i)) - sqrt(2) * Eg * exp( -t(i)/Ta);
    Ish(i) = Ish(i) * Ibase;
    Iac_rms(i) = Eg * ((1/Xsecond - 1/Xprime) *exp(-t(i)/Tsecond) + (1/Xprime - 1/Xd) * exp(-t(i)/Tprime) + 1/Xd);
    Iac_rms(i) = Iac_rms(i) * Ibase;
    Idc_offset(i) = sqrt(2) * (Eg / Xsecond) * exp(-t(i)/Ta);
    Idc_offset(i) = Idc_offset(i) * Ibase;
    Ish_rms(i) = sqrt(Iac_rms(i)^2 + Idc_offset(i)^2);
end

plot(t,Ish,'k')
hold on
plot(t,Ish_rms,'m')
plot(t,Iac_rms,'b')
plot(t,Idc_offset,'r')
legend('Itotal-instantaneous','Itotal-rms','Iac-rms','Idc')
xlabel('Time in seconds')
ylabel('Short circuit current in Ampere')
title('Three-phase short circuit current')
grid on
xx = t(end) +0.1;
axis([-0.1 xx min(Ish(:)) max(Ish_rms(1))])


