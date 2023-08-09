function yy=Model(x)
dbstop if error
global Index Individual

Individual=x;

import com.comsol.model.*
import com.comsol.model.util.*

GA=mphload('Model');
GA.hist.disable;

GA.param('par2').set('t1', x(1));
GA.param('par2').set('t2', x(2));
GA.param('par2').set('a1', x(3));
GA.param('par2').set('h1', x(4));

GA.study('std3').run;

GA.result.numerical('pev1').setResult;
GA.result.numerical('pev2').appendResult;

y=mphtable(GA,'tbl1').data;

ModelUtil.remove('GA')
ModelUtil.remove('Model')

%%%%%% Fitness %%%%%%
yy=-y(2)/y(1);

B(1,1)=x(1);
B(1,2)=x(2);
B(1,3)=x(3);
B(1,4)=x(4);
B(1,5)=y(1);
B(1,6)=y(2);
B(1,7)=yy;
B(1,8)=Index;

name=[num2str(Index) '.txt'];
fid = fopen(name,'w');
for i=1:1:8
    fprintf(fid,'%10.4f',B(i));
    fprintf(fid,'\n');
end
fclose(fid);
Index=Index+1;

end
