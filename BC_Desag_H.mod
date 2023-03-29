close all;
addpath utils

var 
DLA_CPI
DLA_CPI_LIVRES
DLA_CPI_CORE
DLA_CPI_A
DLA_CPI_S
DLA_CPI_I
DLA_CPI_C
W_CPI_A
W_CPI_S
W_CPI_I
W_CPI_C
D4L_CPI
D4L_CPI_CORE
D4L_CPI_LIVRES
D4L_CPI_A
D4L_CPI_S
D4L_CPI_I
D4L_CPI_C
D_E_D4L_CPI
E_D4L_CPI
META
DLA_CAMBIO
D4L_CAMBIO
CAMBIO_PPC
DIFF_JURO
CDS
Z
FEDFUNDS
STANCE
JURO_NOMINAL
JURO_NEUTRO
E_JURO_NOMINAL
E1_JURO_NOMINAL
E2_JURO_NOMINAL
E3_JURO_NOMINAL
E4_JURO_NOMINAL
INCERTEZA
D4L_GDP_BAR
G
HIATO
DLA_GDP
D4L_GDP
UNR
UNR_BAR
UNR_GAP
CAPU
CAPU_BAR
CAPU_GAP   
DUM_LANINA
DUM_ELNINO
DLA_COMM_METAL
DLA_COMM_AGRO
DLA_COMM_ENERGY
DLA_COMM_BRENT
DLA_COMM_USD
DLA_COMM_BRL
DUM_ENERGIA
D_DLA_COMM_BRENT_BRL
D_DLA_COMM_BRL
D_DLA_COMM_METAL_BRL
D_DLA_COMM_AGRO_BRL
JURO_REAL
CAGED_GAP
PIB_GAP
D4L_COMM_ENERGIA
D4L_COMM_BRENT
A
B;

varexo 
RES_HIATO
RES_JURO_NOMINAL
RES_DLA_CAMBIO
RES_E_D4L_CPI
RES_Z
RES_G
RES_DLA_CPI_A
RES_DLA_CPI_S
RES_DLA_CPI_I
RES_DLA_CPI_C
RES_UNR_GAP
RES_CAPU_GAP
RES_W_CPI_S
RES_W_CPI_I
RES_W_CPI_C
RES_DLA_COMM_AGRO
RES_DLA_COMM_ENERGY
RES_DLA_COMM_METAL
RES_DLA_COMM_BRENT
RES_E_JURO_NOMINAL
RES_CAGED_GAP
RES_PIB_GAP
RES_DUM_ENERGIA
RES_DUM_LANINA
RES_DUM_ELNINO
RES_CDS
RES_FEDFUNDS
RES_INCERTEZA
RES_META
RES_A
RES_B;


parameters 
alphas2
alphas3
alphas6
alphas7
alphai2
alphai30
alphai31
alphai4
alphai5
alphai6
alphaa2
alphaa3
alphaa5
alphaa6
alphaa7
alphaa8
alphac1
alphac2
alphac3
alphac4
sigma1
sigma2
sigma3
sigma4
sigma5
beta1
beta2
beta4
teta1
teta2
teta3
phi1
phi2
phi3
phi4
phi5
tau
ss_G
deltadiff
gaps_devpad
kappa1
kappa2
kappa3;



sigma5 = 0.8;
ss_G = 2;




phi1 = 0.7723;
phi2 = 0.0700;
phi3 = 0.0382;
phi4 = 0.0018;
phi5 = 0.0488;
alphaa2 = 0.1943;
alphaa3 = 0.0723;
alphaa5 = 0.0410;
alphaa6 = 0.5718;
alphaa7 = 1.2875;
alphaa8 = -1.2970;
alphas2 = 0.3104;
alphas3 = 0.2464;
alphas6 = 0.2634;
alphas7 = 0.0143;
alphai2 = 0.6473;
alphai30 = 0.0100;
alphai31 = 0.0179;
alphai4 = 0.0139;
alphai5 = 0.0165;
alphai6 = 0.1234;
alphac1 = 0.6408;
alphac2 = 0.0278;
alphac3 = 0.0027;
alphac4 = 19.8767;
beta1 = 0.7816;
beta2 = 0.1552;
beta4 = 0.0505;
tau = 0.7537;
teta1 = 1.5396;
teta2 = -0.6416;
teta3 = 2.5;
sigma1 = 0.4123;
sigma2 = 0.2500;
sigma3 = 0.3385;
sigma4 = 0.0346;
deltadiff = 7.8905;
gaps_devpad = 1.0444;
kappa1 = 0.9857;
kappa2 = 1.1060;
kappa3 = 0.7955;

model;

%Inflação -----------------------------------------------------------------
DLA_CPI = ((W_CPI_A*DLA_CPI_A) + (W_CPI_S*DLA_CPI_S) + (W_CPI_I*DLA_CPI_I) + (W_CPI_C*DLA_CPI_C))/(W_CPI_A + W_CPI_S + W_CPI_I + W_CPI_C);
DLA_CPI_CORE = ((W_CPI_S*DLA_CPI_S) + (W_CPI_I*DLA_CPI_I))/(W_CPI_S + W_CPI_I);
DLA_CPI_LIVRES = ((W_CPI_S*DLA_CPI_S) + (W_CPI_I*DLA_CPI_I) + (W_CPI_A*DLA_CPI_A))/(W_CPI_S + W_CPI_I + W_CPI_A);

D4L_CPI     = (DLA_CPI + DLA_CPI(-1) + DLA_CPI(-2) + DLA_CPI(-3))/4;
D4L_CPI_CORE = (DLA_CPI_CORE + DLA_CPI_CORE(-1) + DLA_CPI_CORE(-2) + DLA_CPI_CORE(-3))/4;
D4L_CPI_LIVRES = (DLA_CPI_LIVRES + DLA_CPI_LIVRES(-1) + DLA_CPI_LIVRES(-2) + DLA_CPI_LIVRES(-3))/4;
META = META(-1) + RES_META;




% ------------------------ Atualização dos Pesos das Inflações Setoriais.
W_CPI_C = W_CPI_C(-1)*(1+DLA_CPI_C(-1)/400)/(1+((W_CPI_A(-1)*DLA_CPI_A(-1)) + (W_CPI_S(-1)*DLA_CPI_S(-1)) + (W_CPI_I(-1)*DLA_CPI_I(-1)) + (W_CPI_C(-1)*DLA_CPI_C(-1)))/(W_CPI_A(-1) + W_CPI_S(-1) + W_CPI_I(-1) + W_CPI_C(-1))/400) + RES_W_CPI_C;
W_CPI_I = W_CPI_I(-1)*(1+DLA_CPI_I(-1)/400)/(1+((W_CPI_A(-1)*DLA_CPI_A(-1)) + (W_CPI_S(-1)*DLA_CPI_S(-1)) + (W_CPI_I(-1)*DLA_CPI_I(-1)) + (W_CPI_C(-1)*DLA_CPI_C(-1)))/(W_CPI_A(-1) + W_CPI_S(-1) + W_CPI_I(-1) + W_CPI_C(-1))/400) + RES_W_CPI_I;
W_CPI_S = W_CPI_S(-1)*(1+DLA_CPI_S(-1)/400)/(1+((W_CPI_A(-1)*DLA_CPI_A(-1)) + (W_CPI_S(-1)*DLA_CPI_S(-1)) + (W_CPI_I(-1)*DLA_CPI_I(-1)) + (W_CPI_C(-1)*DLA_CPI_C(-1)))/(W_CPI_A(-1) + W_CPI_S(-1) + W_CPI_I(-1) + W_CPI_C(-1))/400) + RES_W_CPI_S;
W_CPI_A = 1 - W_CPI_S - W_CPI_I - W_CPI_C;




% ------------------------ Contrução da Equação de Expectativas
D_E_D4L_CPI = phi1*D_E_D4L_CPI(-1) + phi2*(D4L_CPI(+4) - META(+4)) + phi3*(D4L_CPI(-1) - META(-1)) + phi4*(DLA_CAMBIO - CAMBIO_PPC) + phi5*HIATO + RES_E_D4L_CPI;
E_D4L_CPI = D_E_D4L_CPI + META;




% ------------------------ Contrução da Curva de Phillips de Alimentação
DLA_CPI_A = A + META + alphaa2*(DLA_CPI_A(-1) - META(-1) - A(-1)) + (1-alphaa2)*D_E_D4L_CPI + alphaa3*D_DLA_COMM_AGRO_BRL + alphaa6*HIATO + alphaa5*(DLA_CAMBIO(-2) - CAMBIO_PPC(-2)) +
((alphaa7*DUM_ELNINO + alphaa8*DUM_LANINA) + (alphaa7*DUM_ELNINO(-1) + alphaa8*DUM_LANINA(-1)) + (alphaa7*DUM_ELNINO(-2) + alphaa8*DUM_LANINA(-2)))/3 -
((alphaa7*DUM_ELNINO(-3) + alphaa8*DUM_LANINA(-3)) + (alphaa7*DUM_ELNINO(-4) + alphaa8*DUM_LANINA(-4)) + (alphaa7*DUM_ELNINO(-5) + alphaa8*DUM_LANINA(-5)))/3 +
RES_DLA_CPI_A;
D4L_CPI_A = (DLA_CPI_A + DLA_CPI_A(-1) + DLA_CPI_A(-2) + DLA_CPI_A(-3))/4;
A = A(-1) + RES_A;

DUM_ELNINO = DUM_ELNINO(-1) + RES_DUM_ELNINO;
DUM_LANINA = DUM_LANINA(-1) + RES_DUM_LANINA;




% ------------------------ Contrução da Curva de Phillips de Serviços
DLA_CPI_S =  -(W_CPI_A*A + W_CPI_I*B)/W_CPI_S + META +  alphas2*(D4L_CPI(-1)-META(-1)) + alphas3*(D4L_CPI_S(-1)-META(-1)+(W_CPI_A*A(-1) + W_CPI_I*B(-1))/W_CPI_S) + (1-alphas2 - alphas3)*D_E_D4L_CPI + alphas6*HIATO + alphas7*(D4L_COMM_BRENT + D4L_CAMBIO - CAMBIO_PPC) + RES_DLA_CPI_S;
D4L_CPI_S = (DLA_CPI_S + DLA_CPI_S(-1) + DLA_CPI_S(-2) + DLA_CPI_S(-3))/4;




% ------------------------ Contrução da Curva de Phillips de Industriais
DLA_CPI_I = B + META + alphai2*(DLA_CPI_I(-1) - META(-1) - B(-1)) + (1-alphai2)*D_E_D4L_CPI + alphai30*D_DLA_COMM_METAL_BRL + alphai31*D_DLA_COMM_METAL_BRL(-1) + alphai4*DLA_COMM_ENERGY + alphai5*(DLA_CAMBIO(-1) - CAMBIO_PPC(-1)) + alphai6*HIATO + RES_DLA_CPI_I;
D4L_CPI_I = (DLA_CPI_I + DLA_CPI_I(-1) + DLA_CPI_I(-2) + DLA_CPI_I(-3))/4;
B = B(-1) + RES_B;




% ------------------------ Contrução da Curva de Phillips de Controlados
DLA_CPI_C = alphac1*DLA_CPI(-1) + (1-alphac1)*E_D4L_CPI + alphac2*D_DLA_COMM_BRL + alphac3*D_DLA_COMM_BRL(-1) + alphac4*DUM_ENERGIA + RES_DLA_CPI_C;
D4L_CPI_C = (DLA_CPI_C + DLA_CPI_C(-1) + DLA_CPI_C(-2) + DLA_CPI_C(-3))/4;
DUM_ENERGIA = 0 + RES_DUM_ENERGIA;




% ------------------------ Atividade
HIATO = beta1*HIATO(-1) - beta2*STANCE(-1) - beta4*INCERTEZA + RES_HIATO;
D4L_GDP_BAR = (G + G(-1) + G(-2) + G(-3))/4;
D4L_GDP     = (DLA_GDP + DLA_GDP(-1) + DLA_GDP(-2) + DLA_GDP(-3))/4;
HIATO = HIATO(-1) + DLA_GDP/4 - G/4;
G = (1-tau)*G(-1) + tau*ss_G + RES_G;
INCERTEZA = 0.8*INCERTEZA(-1) + RES_INCERTEZA;




% ------------------------ Regra da taxa de Juros
JURO_NOMINAL = teta1*JURO_NOMINAL(-1) + teta2*JURO_NOMINAL(-2) + (1-teta1-teta2)*(JURO_NEUTRO + META + teta3*(E_D4L_CPI - META)) + RES_JURO_NOMINAL;
E_JURO_NOMINAL = (JURO_NOMINAL*0.5 + E1_JURO_NOMINAL + E2_JURO_NOMINAL + E3_JURO_NOMINAL + E4_JURO_NOMINAL*0.5)/4 + RES_E_JURO_NOMINAL;
STANCE = E_JURO_NOMINAL - E_D4L_CPI - JURO_NEUTRO;
JURO_REAL = E_JURO_NOMINAL - E_D4L_CPI;
JURO_NEUTRO = Z;
Z = Z(-1) + RES_Z;
E1_JURO_NOMINAL = JURO_NOMINAL(+1);
E2_JURO_NOMINAL = JURO_NOMINAL(+2);
E3_JURO_NOMINAL = JURO_NOMINAL(+3);
E4_JURO_NOMINAL = JURO_NOMINAL(+4);



% ------------------------ Bloco de Commodities
DLA_COMM_METAL = sigma1*DLA_COMM_METAL(-1) + RES_DLA_COMM_METAL;
DLA_COMM_AGRO = sigma2*DLA_COMM_AGRO(-1) + RES_DLA_COMM_AGRO;
DLA_COMM_ENERGY = sigma3*DLA_COMM_ENERGY(-1) + RES_DLA_COMM_ENERGY;
DLA_COMM_BRENT = sigma4*DLA_COMM_BRENT(-1) + RES_DLA_COMM_BRENT;

DLA_COMM_USD = DLA_COMM_METAL*0.17 + DLA_COMM_AGRO*0.68 + DLA_COMM_ENERGY*0.14;
DLA_COMM_BRL = DLA_COMM_USD + DLA_CAMBIO;

D_DLA_COMM_METAL_BRL = DLA_COMM_METAL + DLA_CAMBIO - CAMBIO_PPC;
D_DLA_COMM_AGRO_BRL = DLA_COMM_AGRO + DLA_CAMBIO - CAMBIO_PPC;
D_DLA_COMM_BRENT_BRL = DLA_COMM_BRENT + DLA_CAMBIO - CAMBIO_PPC;
D_DLA_COMM_BRL = DLA_COMM_BRL - CAMBIO_PPC;

D4L_COMM_ENERGIA = (DLA_COMM_ENERGY + DLA_COMM_ENERGY(-1) + DLA_COMM_ENERGY(-2) + DLA_COMM_ENERGY(-3))/4;
D4L_COMM_BRENT = (DLA_COMM_BRENT + DLA_COMM_BRENT(-1) + DLA_COMM_BRENT(-2) + DLA_COMM_BRENT(-3))/4;



% ------------------------ Setor Externo
DLA_CAMBIO = CAMBIO_PPC - deltadiff*(DIFF_JURO - DIFF_JURO(-1)) + RES_DLA_CAMBIO;
CAMBIO_PPC = META - 2;
D4L_CAMBIO = (DLA_CAMBIO + DLA_CAMBIO(-1) + DLA_CAMBIO(-2) + DLA_CAMBIO(-3))/4;
DIFF_JURO = JURO_NOMINAL - (FEDFUNDS + CDS/100);
CDS = CDS(-1) + RES_CDS;
FEDFUNDS = FEDFUNDS(-1) + RES_FEDFUNDS;



% ------------------------ Desemprego
UNR_GAP/kappa1 = HIATO(-1) + gaps_devpad*RES_UNR_GAP;
UNR_BAR = 10.17;
UNR_GAP = UNR_BAR - UNR;




% ------------------------ NUCI ou CAPU
CAPU_GAP/kappa2 = HIATO + gaps_devpad*RES_CAPU_GAP;
CAPU_BAR = 80.82;
CAPU = CAPU_BAR + CAPU_GAP;




% ------------------------ Equações de Informação do Output Gap
CAGED_GAP/kappa3 = HIATO(-1) + gaps_devpad*RES_CAGED_GAP;
PIB_GAP = HIATO + gaps_devpad*RES_PIB_GAP;



end;



shocks;
var RES_HIATO;  stderr 0.8;
var RES_JURO_NOMINAL;  stderr 0.49;
var RES_DLA_CAMBIO;  stderr 26;
var RES_E_D4L_CPI;  stderr 0.21;
var RES_Z;  stderr 0.15; 
var RES_G;  stderr 3.7;
var RES_DLA_CPI_A;  stderr 8.43;
var RES_DLA_CPI_S;  stderr 1.09;
var RES_DLA_CPI_I;  stderr 2.3;
var RES_DLA_CPI_C;  stderr 3.83;
var RES_UNR_GAP;  stderr 1;
var RES_CAPU_GAP;  stderr 1;
var RES_W_CPI_S;  stderr 0.003;
var RES_W_CPI_I;  stderr 0.003;
var RES_W_CPI_C;  stderr 0.003;
var RES_DLA_COMM_AGRO;  stderr 25.1667;
var RES_DLA_COMM_ENERGY;  stderr 42.8683;
var RES_DLA_COMM_METAL;  stderr 35.3208;
var RES_DLA_COMM_BRENT;  stderr 62.4240;
var RES_E_JURO_NOMINAL;  stderr 0.46;
var RES_CAGED_GAP;  stderr 1;
var RES_PIB_GAP;  stderr 1;
var RES_DUM_ELNINO;  stderr 1;
var RES_DUM_LANINA;  stderr 1;
var RES_DUM_ENERGIA;  stderr 1;
var RES_CDS;  stderr 66;
var RES_FEDFUNDS;  stderr 1;
var RES_INCERTEZA;  stderr 7;
var RES_META;  stderr 1;
var RES_A; stderr 0.01;
var RES_B; stderr 0.01;
corr RES_DLA_COMM_BRENT, RES_DLA_COMM_ENERGY = 0.7;
end;




varobs
E_D4L_CPI
DLA_CAMBIO
JURO_NOMINAL
E_JURO_NOMINAL
META
CDS
FEDFUNDS
DLA_GDP
CAPU
UNR
DLA_CPI_A
DLA_CPI_S
DLA_CPI_I
DLA_CPI_C
W_CPI_S
W_CPI_I
W_CPI_C
DLA_COMM_METAL
DLA_COMM_AGRO
DLA_COMM_ENERGY
DLA_COMM_BRENT
CAGED_GAP
PIB_GAP
DUM_LANINA
DUM_ELNINO
DUM_ENERGIA
INCERTEZA;




initval;
META = 3;
DLA_CPI = META;
DLA_CPI_LIVRES = META;
DLA_CPI_CORE = META;
DLA_CPI_A = META;
DLA_CPI_S = META;
DLA_CPI_I = META;
DLA_CPI_C = META;
W_CPI_A = 1/4;
W_CPI_S = 1/4;
W_CPI_I = 1/4;
W_CPI_C = 1/4;
D4L_CPI = META;
D4L_CPI_CORE = META;
D4L_CPI_LIVRES = META;
D4L_CPI_A = META;
D4L_CPI_S = META;
D4L_CPI_I = META;
D4L_CPI_C = META;
D_E_D4L_CPI = 0;
E_D4L_CPI = META;
DLA_CAMBIO = META - 2;
D4L_CAMBIO = META - 2;
CAMBIO_PPC = META - 2;
CDS = 200;
Z = 0;
FEDFUNDS = 2;
STANCE = 0;
JURO_NEUTRO = 0;
JURO_NOMINAL = META + JURO_NEUTRO;
E_JURO_NOMINAL = JURO_NOMINAL;
E1_JURO_NOMINAL = JURO_NOMINAL;
E2_JURO_NOMINAL = JURO_NOMINAL;
E3_JURO_NOMINAL = JURO_NOMINAL;
E4_JURO_NOMINAL = JURO_NOMINAL;
DIFF_JURO = JURO_NOMINAL - (FEDFUNDS + CDS/100);
INCERTEZA = 0;
D4L_GDP_BAR = ss_G;
G = ss_G;
HIATO = 0;
DLA_GDP = ss_G;
D4L_GDP = ss_G;
UNR = 10.17;
UNR_GAP = 0;
UNR_BAR = 10.17;
CAPU = 80.82;
CAPU_GAP = 0;
CAPU_BAR = 80.82;
JURO_REAL = JURO_NEUTRO;
CAGED_GAP = 0;
PIB_GAP = 0;
DLA_COMM_METAL = 0;
DLA_COMM_AGRO = 0;
DLA_COMM_ENERGY = 0;
D4L_COMM_ENERGIA = 0;
DLA_COMM_BRENT = 0;
D_DLA_COMM_METAL_BRL = DLA_COMM_METAL + DLA_CAMBIO - CAMBIO_PPC;
D_DLA_COMM_AGRO_BRL = DLA_COMM_AGRO + DLA_CAMBIO - CAMBIO_PPC;
D_DLA_COMM_BRENT_BRL = DLA_COMM_BRENT + DLA_CAMBIO - CAMBIO_PPC;
DLA_COMM_USD = DLA_COMM_METAL*0.17 + DLA_COMM_AGRO*0.68 + DLA_COMM_ENERGY*0.14;
DLA_COMM_BRL = DLA_COMM_USD + DLA_CAMBIO;
D_DLA_COMM_BRL = DLA_COMM_BRL - CAMBIO_PPC;
end;


steady;


estimated_params;
stderr RES_META, 0.12, uniform_pdf, , ,      0, 1;
stderr RES_W_CPI_S, 0.001, uniform_pdf, , ,      0, 1;
stderr RES_W_CPI_I, 0.001, uniform_pdf, , ,      0, 1;
stderr RES_W_CPI_C, 0.001, uniform_pdf, , ,      0, 1;

phi1, 0.77,    uniform_pdf, , ,      0.01, 0.95;
phi2, 0.06,    uniform_pdf, , ,      0, 1;
phi3, 0.03,    uniform_pdf, , ,      -1, 1;
phi4, 0.0018,    uniform_pdf, , ,      -0.1, 0.1;
phi5, 0.05,    uniform_pdf, , ,      -1, 1;
stderr RES_E_D4L_CPI, 0.18, uniform_pdf, , ,      0, 3;


alphaa2, 0.19,    uniform_pdf, , ,      -1, 0.95;
alphaa3, 0.07,    uniform_pdf, , ,      -1, 0.95;
alphaa5, 0.04,    uniform_pdf, , ,      -1, 0.95;
alphaa6, 0.56,    uniform_pdf, , ,      0.01, 0.95;
alphaa7, 1.3044,    uniform_pdf, , ,      -10, 10;
alphaa8, -1.3044,    uniform_pdf, , ,      -10, 10;
stderr RES_DLA_CPI_A, 6.6, uniform_pdf, , ,      0, 10;
stderr RES_DUM_LANINA, 0.4, uniform_pdf, , ,      0, 1;
stderr RES_DUM_ELNINO, 0.4, uniform_pdf, , ,      0, 1;

alphas2, 0.29,    uniform_pdf, , ,      0.01, 0.95;
alphas3, 0.23,    uniform_pdf, , ,      0.01, 0.95;
alphas6, 0.27,    uniform_pdf, , ,      0.01, 0.95;
alphas7, 0.01,    uniform_pdf, , ,      0, 0.95;
stderr RES_DLA_CPI_S, 1.05, uniform_pdf, , ,      0, 5;
stderr RES_A, 0.2, uniform_pdf, , ,      0, 1;

alphai2, 0.68,    uniform_pdf, , ,      0.01, 0.95;
alphai30, 0.01,    uniform_pdf, , ,      0, 0.95;
alphai31, 0.01,    uniform_pdf, , ,      0, 0.95;
alphai4, 0.0095,    uniform_pdf, , ,      -1, 0.95;
alphai5, 0.0085,    uniform_pdf, , ,      0, 0.95;
alphai6, 0.095,    uniform_pdf, , ,      0.01, 0.95;
stderr RES_DLA_CPI_I, 1.9, uniform_pdf, , ,      0, 5;
stderr RES_B, 0.01, uniform_pdf, , ,      0, 1;

alphac1, 0.61,    uniform_pdf, , ,      0.01, 1;
alphac2, 0.02,    uniform_pdf, , ,      -0.1, 0.1;
alphac3, 0.002,    uniform_pdf, , ,      -0.1, 0.1;
alphac4, 20,    uniform_pdf, , ,      0, 25;
stderr RES_DLA_CPI_C, 3.8, uniform_pdf, , ,      0, 5;
stderr RES_DUM_ENERGIA, 0.2, uniform_pdf, , ,      0, 1;


beta1, 0.7,    uniform_pdf, , ,      0.01, 0.95;
beta2, 0.2,    uniform_pdf, , ,      0.01, 0.95;
beta4, 0.05,    beta_pdf,      0.05, 0.005;
tau, 0.1,    normal_pdf,      0.1, 0.5;
stderr RES_HIATO, 0.7, uniform_pdf, , ,      0.01, 1;
stderr RES_G, 2.7, uniform_pdf, , ,      0, 10;
stderr RES_INCERTEZA, 10, uniform_pdf, , ,      0.01, 20;

teta1, 1.5,    uniform_pdf, , ,      0, 2;
teta2, -0.6,    uniform_pdf, , ,      -1, 1;
teta3, 2.5,    uniform_pdf, , ,      0, 8;
stderr RES_JURO_NOMINAL, 0.6, uniform_pdf, , ,      0.01, 3;
stderr RES_E_JURO_NOMINAL, 0.6, uniform_pdf, , ,      0.01, 3;
stderr RES_Z, inv_gamma_pdf, 0.1  , 0.01;


sigma1, 0.1,    uniform_pdf, , ,      0, 1;
sigma2, 0.1,    uniform_pdf, , ,      0, 1;
sigma3, 0.1,    uniform_pdf, , ,      0, 1;
sigma4, 0.1,    uniform_pdf, , ,      0, 1;
stderr RES_DLA_COMM_AGRO, 30, uniform_pdf, , ,      0, 100;
stderr RES_DLA_COMM_ENERGY, 30, uniform_pdf, , ,      0, 100;
stderr RES_DLA_COMM_METAL, 30, uniform_pdf, , ,      0, 100;
stderr RES_DLA_COMM_BRENT, 30, uniform_pdf, , ,      0, 100;
//corr RES_DLA_COMM_BRENT, RES_DLA_COMM_ENERGY, 0.7, uniform_pdf, , ,      0, 1;

deltadiff, 6,    uniform_pdf, , ,      0, 10;
stderr RES_DLA_CAMBIO, 27, uniform_pdf, , ,      0, 35;
stderr RES_CDS, 66, uniform_pdf, , ,      0, 100;
stderr RES_FEDFUNDS, 4, uniform_pdf, , ,      0, 40;

gaps_devpad, 1.2,    uniform_pdf, , ,      0, 2;
kappa1, 1,    uniform_pdf, , ,      0, 3;
kappa2, 2,    uniform_pdf, , ,      0, 3;
kappa3, 0.77,    uniform_pdf, , ,      0, 3;
end;




options_.filter_covariance = 1;
options_.filter_decomposition = 1;



%Primeira Linha realiza a estimação do modelo considerando a prior dada.
%Segunda linha apenas carrega a ultima estimação realizada.
//estimation(datafile=data_file, mode_compute=1, nograph,  mh_replic=0, filtered_vars,filter_step_ahead=[1:12], forecast=16,conf_sig=0.70, first_obs=1, nobs=64,diffuse_filter,smoothed_state_uncertainty) 
//estimation(datafile=data_file, mode_compute=0, mode_file='BC_Desag_H\Output\BC_Desag_H_mode.mat', nograph,  mh_replic=0, filtered_vars,filter_step_ahead=[1:12], forecast=16, first_obs=13, conf_sig=0.70, diffuse_filter, smoothed_state_uncertainty) 
estimation(datafile=data_file, mode_compute=0, mode_file='BC_Desag_H\Output\BC_Desag_H_mode.mat', nograph,  mh_replic=0, filtered_vars,filter_step_ahead=[1:12], forecast=16, conf_sig=0.70, diffuse_filter, smoothed_state_uncertainty) 
D4L_CPI D4L_CPI_A D4L_CPI_I D4L_CPI_S STANCE JURO_NOMINAL HIATO JURO_NEUTRO;



firstdate = '2004Q1'; 
Years = floor((dataset_.dates.time-1) / 4)+2004;
Quarters = rem((dataset_.dates.time-1), 4) + 1;
Months = Quarters * 3;
ProperDates = datetime(Years, Months, 1);
ProperDates.Format = 'QQQ-yyyy';
datas = ProperDates;


a = plot_band("JURO_NOMINAL", datas);
shg







%%to make more dynamic for report
data_file;
nobs = 92;

%%gl_report
%%canada_report_extra__US

%% set firstdate
firstdate = '2004Q1'; 

%% set in-sample ahead forecast steps
fcast_steps = [1 4 8 12];

%% calculate the forecasts
max_step = max(fcast_steps);


[fy,fx,Fy,Fx,Udecomp,ndiffuse] = calc_fcast_all_4a;
//[fy,fx,Fy,Fx,Udecomp,ndiffuse] = calc_fcast_all(max_step);
%% save the forecasts
save([M_.dname '_forecasts.mat'], 'fy', 'fx', 'Fy', 'Fx', 'Udecomp', 'ndiffuse');




//disp(sprintf('\n'));disp('Reporting forecast errors');
//report_fcast_errors(fy, Fy, ndiffuse, fcast_steps, firstdate);
//report_smoothed_errors_4(fx, Fx, ndiffuse, strvcat('D4L_CPI'), fcast_steps, firstdate);


exo_ord = [1 4 2 5 3 6 7 8 9 10];
disp('Reporting dynamic forecasts 1 period ahead');
in_sample_forecast(fx, Fx, Udecomp, ndiffuse, 1, 12, exo_ord, firstdate,var_list_);


