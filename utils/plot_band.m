% This code plots a band chart with its confidence interval. Only works
% within dynare.

function [x] = plot_band(variavel, datas)


global M_ oo_ ;

%variavel = "DLA_CPI";
tmp = strmatch(variavel,M_.endo_names,'exact');
size = length(oo_.Smoother.State_uncertainty(1,1,:));
var_aux = "";

for i=1:size
    aux = diag(oo_.Smoother.State_uncertainty(:,:,i));
    var_aux = [var_aux aux(tmp)];
end

var_aux = var_aux(2:size+1);

var_aux = abs(double(var_aux));
% a = dseries('data_novo.csv');

mean = oo_.SmoothedVariables.(variavel);
sup = oo_.SmoothedVariables.(variavel) + transpose(2*sqrt(double(var_aux)));
inf =  oo_.SmoothedVariables.(variavel)-transpose(2*sqrt(double(var_aux)));


length([sup -(sup-inf)]);
x = figure('visible','off');
b = area(datas, [sup -(sup-inf)]);
b(1).LineStyle = "none";
b(1).FaceAlpha = 0;
b(1).FaceColor = [1,1,1];
b(2).FaceColor = [0.5,0.5,0.5];
b(2).FaceAlpha = 0.5;
b(2).LineStyle = "none";

hold on;
%plot(sup, 'r-')
%plot(inf, 'r-')
plot(datas, mean,'b');
grid on;
hold off;
title("Variável", variavel,'Interpreter','none');


end


