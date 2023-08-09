function out = model
%
% Model1.m
%
% Model exported on Aug 9 2023, 19:07 by COMSOL 5.6.0.280.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath('C:\Users\Jon\Desktop\GA+NN+Physics\1.bistable\PSO+NN+Physics');

model.label('Model.mph');

model.comments(['Sonic Crystal\n\nPhononic and sonic crystals have generated rising scientific interest for very diverse technological applications. These crystals are made of periodic distributions of scatterers embedded in a matrix. Under certain conditions, acoustic band gaps can form. These are spectral bands where propagation of waves is forbidden. This model first analyzes as sonic crystal and determines its band structure. Secondly, the transmission loss through a finite sized crystal is analyzed and results compared to the band structure.']);

model.param.group.create('par2');
model.param('par2').set('t1', '1');
model.param('par2').set('t2', '1');
model.param('par2').set('a1', '50');
model.param('par2').set('h1', '10');
model.param('par2').set('R', 'sqrt(a1^2+h1^2)*2');
model.param('par2').set('disp', '2*h1');
model.param('par2').label('Parameters 2 - Geometry Unit Cell');
model.param.label('Parameters 1 - Physics');

model.component.create('comp1', false);

model.component('comp1').geom.create('geom1', 2);

model.component('comp1').label('Component 1');

model.component('comp1').curvedInterior(false);

model.result.table.create('tbl1', 'Table');

model.component('comp1').mesh.create('mesh4');

model.component('comp1').geom('geom1').label('Geometry 1');
model.component('comp1').geom('geom1').lengthUnit('mm');
model.component('comp1').geom('geom1').repairTolType('relative');
model.component('comp1').geom('geom1').create('r1', 'Rectangle');
model.component('comp1').geom('geom1').feature('r1').label('Rectangle 1');
model.component('comp1').geom('geom1').feature('r1').set('base', 'center');
model.component('comp1').geom('geom1').feature('r1').set('size', {'t1' 't2'});
model.component('comp1').geom('geom1').create('r2', 'Rectangle');
model.component('comp1').geom('geom1').feature('r2').label('Rectangle 2');
model.component('comp1').geom('geom1').feature('r2').set('pos', {'a1+t1' '-h1'});
model.component('comp1').geom('geom1').feature('r2').set('base', 'center');
model.component('comp1').geom('geom1').feature('r2').set('size', {'t1' 't2'});
model.component('comp1').geom('geom1').create('ca1', 'CircularArc');
model.component('comp1').geom('geom1').feature('ca1').label('Circular Arc 1');
model.component('comp1').geom('geom1').feature('ca1').set('specify', 'endsr');
model.component('comp1').geom('geom1').feature('ca1').set('point1', {'t1/2' '-t2/2'});
model.component('comp1').geom('geom1').feature('ca1').set('point2', {'t1/2+a1' '-t2/2-h1'});
model.component('comp1').geom('geom1').feature('ca1').set('r', 'R');
model.component('comp1').geom('geom1').create('ca2', 'CircularArc');
model.component('comp1').geom('geom1').feature('ca2').label('Circular Arc 2');
model.component('comp1').geom('geom1').feature('ca2').set('specify', 'endsr');
model.component('comp1').geom('geom1').feature('ca2').set('point1', {'t1/2' 't2/2'});
model.component('comp1').geom('geom1').feature('ca2').set('point2', {'a1+t1/2' '-h1+t2/2'});
model.component('comp1').geom('geom1').feature('ca2').set('r', 'R');
model.component('comp1').geom('geom1').feature('ca2').set('clockwise', true);
model.component('comp1').geom('geom1').create('csol1', 'ConvertToSolid');
model.component('comp1').geom('geom1').feature('csol1').label('Convert to Solid 1');
model.component('comp1').geom('geom1').feature('csol1').set('selresult', true);
model.component('comp1').geom('geom1').feature('csol1').selection('input').set({'ca1' 'ca2' 'r1' 'r2'});
model.component('comp1').geom('geom1').create('mir1', 'Mirror');
model.component('comp1').geom('geom1').feature('mir1').active(false);
model.component('comp1').geom('geom1').feature('mir1').label('Mirror 1');
model.component('comp1').geom('geom1').feature('mir1').set('selresult', true);
model.component('comp1').geom('geom1').feature('mir1').set('keep', true);
model.component('comp1').geom('geom1').feature('mir1').set('pos', {'t1+a1+t1/2' '0'});
model.component('comp1').geom('geom1').feature('mir1').selection('input').set({'csol1'});
model.component('comp1').geom('geom1').create('r3', 'Rectangle');
model.component('comp1').geom('geom1').feature('r3').active(false);
model.component('comp1').geom('geom1').feature('r3').label('Rectangle 3');
model.component('comp1').geom('geom1').feature('r3').set('pos', {'a1+3/2*t1' '-t1-h1'});
model.component('comp1').geom('geom1').feature('r3').set('base', 'center');
model.component('comp1').geom('geom1').feature('r3').set('size', {'t1' 't2/2'});
model.component('comp1').geom('geom1').feature('fin').label('Form Union');
model.component('comp1').geom('geom1').feature('fin').set('repairtoltype', 'relative');
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');

model.component('comp1').selection.create('acpr_dst_pc1', 'Explicit');
model.component('comp1').selection('acpr_dst_pc1').geom('geom1', 1);
model.component('comp1').selection.create('acpr_dst_pc2', 'Explicit');
model.component('comp1').selection('acpr_dst_pc2').geom('geom1', 1);
model.component('comp1').selection.create('ta_dst_pc1', 'Explicit');
model.component('comp1').selection('ta_dst_pc1').geom('geom1', 1);
model.component('comp1').selection.create('ta_dst_pc2', 'Explicit');
model.component('comp1').selection('ta_dst_pc2').geom('geom1', 1);
model.component('comp1').selection('acpr_dst_pc1').label('Explicit 1');
model.component('comp1').selection('acpr_dst_pc2').label('Explicit 2');
model.component('comp1').selection('ta_dst_pc1').label('Explicit 1a');
model.component('comp1').selection('ta_dst_pc2').label('Explicit 2a');

model.view.create('view2', 2);

model.component('comp1').pair.create('p11', 'Contact');
model.component('comp1').pair('p11').source.set([7 10]);
model.component('comp1').pair('p11').destination.set([7 10]);

model.component('comp1').material.create('mat4', 'Common');

model.component('comp1').physics.create('solid', 'SolidMechanics', 'geom1');
model.component('comp1').physics('solid').create('disp2', 'Displacement1', 1);
model.component('comp1').physics('solid').feature('disp2').selection.set([1]);
model.component('comp1').physics('solid').create('disp4', 'Displacement0', 0);
model.component('comp1').physics('solid').feature('disp4').selection.set([8]);
model.component('comp1').physics('solid').create('disp5', 'Displacement1', 1);
model.component('comp1').physics('solid').feature('disp5').selection.set([8]);
model.component('comp1').physics('solid').create('hmm1', 'HyperelasticModel', 2);
model.component('comp1').physics('solid').feature('hmm1').selection.all;

model.component('comp1').mesh('mesh4').autoMeshSize(3);

model.result.table('tbl1').comments([native2unicode(hex2dec({'70' 'b9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode') ': ' native2unicode(hex2dec({'70' 'b9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode') ' 1 {pev1}']);

model.thermodynamics.label('Thermodynamics Package');

model.component('comp1').view('view1').label('View 1');
model.component('comp1').view('view1').axis.label('Axis');
model.component('comp1').view('view1').axis.set('xmin', -3.379842758178711);
model.component('comp1').view('view1').axis.set('xmax', 54.379844665527344);
model.component('comp1').view('view1').axis.set('ymin', -26.547945022583008);
model.component('comp1').view('view1').axis.set('ymax', 16.547948837280273);
model.view('view2').label('View 2D 2');
model.view('view2').axis.label('Axis');
model.view('view2').axis.set('xmin', -1.0000007152557373);
model.view('view2').axis.set('xmax', 20);
model.view('view2').axis.set('ymin', -10.570915222167969);
model.view('view2').axis.set('ymax', 10.572759628295898);

model.component('comp1').pair('p11').label('Contact Pair 11');

model.component('comp1').material('mat4').label('Acrylic plastic');
model.component('comp1').material('mat4').set('family', 'custom');
model.component('comp1').material('mat4').set('diffuse', 'custom');
model.component('comp1').material('mat4').set('customdiffuse', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.component('comp1').material('mat4').set('customambient', [0.39215686274509803 0.7843137254901961 0.39215686274509803]);
model.component('comp1').material('mat4').set('noise', true);
model.component('comp1').material('mat4').set('lighting', 'phong');
model.component('comp1').material('mat4').set('shininess', 1000);
model.component('comp1').material('mat4').propertyGroup('def').label('Basic');
model.component('comp1').material('mat4').propertyGroup('def').set('thermalexpansioncoefficient', {'7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]' '0' '0' '0' '7.0e-5[1/K]'});
model.component('comp1').material('mat4').propertyGroup('def').set('heatcapacity', '1470[J/(kg*K)]');
model.component('comp1').material('mat4').propertyGroup('def').set('density', '1380[kg/m^3]');
model.component('comp1').material('mat4').propertyGroup('def').set('thermalconductivity', {'0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]' '0' '0' '0' '0.18[W/(m*K)]'});
model.component('comp1').material('mat4').propertyGroup('def').set('soundspeed', '2388');
model.component('comp1').material('mat4').propertyGroup('def').set('youngsmodulus', '2[GPa]');
model.component('comp1').material('mat4').propertyGroup('def').set('poissonsratio', '0.49');

model.component('comp1').coordSystem('sys1').label('Boundary System 1');

model.common('cminpt').label('Common Model Inputs');

model.component('comp1').physics('solid').label('Solid Mechanics');
model.component('comp1').physics('solid').prop('ShapeProperty').set('order_displacement', 1);
model.component('comp1').physics('solid').prop('d').set('d', '2[mm]');
model.component('comp1').physics('solid').prop('TransientSettings').set('text', 'Changes made to these settings only take effect when the default solver is generated.');
model.component('comp1').physics('solid').feature('lemm1').set('nu', 0.3);
model.component('comp1').physics('solid').feature('lemm1').label('Linear Elastic Material 1');
model.component('comp1').physics('solid').feature('lemm1').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('free1').label('Free 1');
model.component('comp1').physics('solid').feature('free1').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('init1').label('Initial Values 1');
model.component('comp1').physics('solid').feature('init1').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('disp2').set('Direction', [1; 1; 0]);
model.component('comp1').physics('solid').feature('disp2').label('Prescribed Displacement 2');
model.component('comp1').physics('solid').feature('disp2').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('disp4').set('Direction', [1; 1; 0]);
model.component('comp1').physics('solid').feature('disp4').set('U0', {'0'; 'disp*t/100000'; '0'});
model.component('comp1').physics('solid').feature('disp4').label('Prescribed Displacement 4');
model.component('comp1').physics('solid').feature('disp4').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('disp5').set('Direction', [1; 1; 0]);
model.component('comp1').physics('solid').feature('disp5').set('U0', {'0'; 'disp*t/100'; '0'});
model.component('comp1').physics('solid').feature('disp5').active(false);
model.component('comp1').physics('solid').feature('disp5').label('Prescribed Displacement 2.1');
model.component('comp1').physics('solid').feature('disp5').featureInfo('info').label('Equation View');
model.component('comp1').physics('solid').feature('hmm1').set('kappa', '10E6');
model.component('comp1').physics('solid').feature('hmm1').set('Compressibility_NeoHookean', 'NearlyIncompressibleQuadratic');
model.component('comp1').physics('solid').feature('hmm1').set('lambLame_mat', 'userdef');
model.component('comp1').physics('solid').feature('hmm1').set('lambLame', '1E6');
model.component('comp1').physics('solid').feature('hmm1').set('muLame_mat', 'userdef');
model.component('comp1').physics('solid').feature('hmm1').set('muLame', '1E6');
model.component('comp1').physics('solid').feature('hmm1').label('Hyperelastic Material 1');
model.component('comp1').physics('solid').feature('hmm1').featureInfo('info').label('Equation View');

model.component('comp1').mesh('mesh4').label('Mesh 4');

model.study.create('std3');
model.study('std3').create('time', 'Transient');

model.sol.create('sol2');
model.sol('sol2').study('std3');
model.sol('sol2').attach('std3');
model.sol('sol2').create('st1', 'StudyStep');
model.sol('sol2').create('v1', 'Variables');
model.sol('sol2').create('t1', 'Time');
model.sol('sol2').feature('t1').create('fc1', 'FullyCoupled');
model.sol('sol2').feature('t1').feature.remove('fcDef');

model.result.numerical.create('pev1', 'EvalPoint');
model.result.numerical.create('pev2', 'EvalPoint');
model.result.numerical('pev1').selection.set([8]);
model.result.numerical('pev1').set('probetag', 'none');
model.result.numerical('pev2').selection.set([8]);
model.result.numerical('pev2').set('probetag', 'none');
model.result.create('pg2', 'PlotGroup1D');
model.result.create('pg1', 'PlotGroup2D');
model.result('pg2').create('ptgr1', 'PointGraph');
model.result('pg2').feature('ptgr1').selection.set([8]);
model.result('pg2').feature('ptgr1').set('expr', 'solid.RFy');
model.result('pg1').create('surf1', 'Surface');
model.result('pg1').feature('surf1').set('expr', 'solid.mises');
model.result('pg1').feature('surf1').create('def', 'Deform');
model.result.export.create('anim1', 'Animation');

model.study('std3').label('Study 3');
model.study('std3').feature('time').label('Time Dependent');
model.study('std3').feature('time').set('tlist', 'range(0,1,100)');
model.study('std3').feature('time').set('plot', true);
model.study('std3').feature('time').set('plotgroup', 'pg1');

model.sol('sol2').attach('std3');
model.sol('sol2').label('Solution 2');
model.sol('sol2').feature('st1').label([native2unicode(hex2dec({'7f' '16'}), 'unicode')  native2unicode(hex2dec({'8b' 'd1'}), 'unicode')  native2unicode(hex2dec({'65' 'b9'}), 'unicode')  native2unicode(hex2dec({'7a' '0b'}), 'unicode') ': Time Dependent']);
model.sol('sol2').feature('v1').label('Dependent Variables 1');
model.sol('sol2').feature('v1').set('clist', {'range(0,1,100)' '0.1[s]'});
model.sol('sol2').feature('v1').feature('comp1_u').set('scalemethod', 'manual');
model.sol('sol2').feature('v1').feature('comp1_u').set('scaleval', '1e-2*0.0205');
model.sol('sol2').feature('t1').label('Time-Dependent Solver 1');
model.sol('sol2').feature('t1').set('tlist', 'range(0,1,100)');
model.sol('sol2').feature('t1').set('timemethod', 'genalpha');
model.sol('sol2').feature('t1').set('plot', true);
model.sol('sol2').feature('t1').set('plotgroup', 'pg1');
model.sol('sol2').feature('t1').feature('dDef').label('Direct');
model.sol('sol2').feature('t1').feature('aDef').label('Advanced');
model.sol('sol2').feature('t1').feature('aDef').set('cachepattern', true);
model.sol('sol2').feature('t1').feature('fc1').label('Fully Coupled 1');
model.sol('sol2').feature('t1').feature('fc1').set('dtech', 'auto');
model.sol('sol2').feature('t1').feature('fc1').set('maxiter', 500);
model.sol('sol2').feature('t1').feature('fc1').set('plot', true);
model.sol('sol2').feature('t1').feature('fc1').set('plotgroup', 'pg1');
model.sol('sol2').runAll;

model.result.label('Results');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').set('expr', {'if((v<h1[mm]), solid.RFy,0)'});
model.result.numerical('pev1').set('unit', {'N'});
model.result.numerical('pev1').set('descr', {[native2unicode(hex2dec({'53' 'cd'}), 'unicode')  native2unicode(hex2dec({'4f' '5c'}), 'unicode')  native2unicode(hex2dec({'75' '28'}), 'unicode')  native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode') 'y ' native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ]});
model.result.numerical('pev1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' x ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpnty' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' y ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpntz' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' z ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]});
model.result.numerical('pev1').set('dataseries', 'maximum');
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').set('expr', {'if((v>=h1[mm]), solid.RFy, 0)'});
model.result.numerical('pev2').set('unit', {'N'});
model.result.numerical('pev2').set('descr', {''});
model.result.numerical('pev2').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' x ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpnty' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' y ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpntz' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' z ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]});
model.result.numerical('pev2').set('dataseries', 'minimum');
model.result.numerical('pev1').setResult;
model.result.numerical('pev2').appendResult;
model.result('pg2').set('xlabel', [native2unicode(hex2dec({'4f' '4d'}), 'unicode')  native2unicode(hex2dec({'79' 'fb'}), 'unicode')  native2unicode(hex2dec({'57' '3a'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode') 'Y ' native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' (mm)']);
model.result('pg2').set('ylabel', [native2unicode(hex2dec({'53' 'cd'}), 'unicode')  native2unicode(hex2dec({'4f' '5c'}), 'unicode')  native2unicode(hex2dec({'75' '28'}), 'unicode')  native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode') 'y ' native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ' (N)']);
model.result('pg2').set('axislimits', true);
model.result('pg2').set('xmin', -0.3411810233851159);
model.result('pg2').set('xmax', 20.34118102338511);
model.result('pg2').set('ymin', -0.015014454256519046);
model.result('pg2').set('ymax', 0.018565866287544582);
model.result('pg2').set('xlabelactive', false);
model.result('pg2').set('ylabelactive', false);
model.result('pg2').feature('ptgr1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' x ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpnty' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' y ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpntz' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' z ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]});
model.result('pg2').feature('ptgr1').set('xdata', 'expr');
model.result('pg2').feature('ptgr1').set('xdataexpr', 'v');
model.result('pg2').feature('ptgr1').set('xdatadescr', [native2unicode(hex2dec({'4f' '4d'}), 'unicode')  native2unicode(hex2dec({'79' 'fb'}), 'unicode')  native2unicode(hex2dec({'57' '3a'}), 'unicode')  native2unicode(hex2dec({'ff' '0c'}), 'unicode') 'Y ' native2unicode(hex2dec({'52' '06'}), 'unicode')  native2unicode(hex2dec({'91' 'cf'}), 'unicode') ]);
model.result('pg2').feature('ptgr1').set('linewidth', 4);
model.result('pg1').label([native2unicode(hex2dec({'5e' '94'}), 'unicode')  native2unicode(hex2dec({'52' '9b'}), 'unicode') ' (solid)']);
model.result('pg1').set('showlegends', false);
model.result('pg1').feature('surf1').set('const', {'solid.refpntx' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' x ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpnty' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' y ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]; 'solid.refpntz' '0' [native2unicode(hex2dec({'52' '9b'}), 'unicode')  native2unicode(hex2dec({'77' 'e9'}), 'unicode')  native2unicode(hex2dec({'8b' 'a1'}), 'unicode')  native2unicode(hex2dec({'7b' '97'}), 'unicode')  native2unicode(hex2dec({'53' 'c2'}), 'unicode')  native2unicode(hex2dec({'80' '03'}), 'unicode')  native2unicode(hex2dec({'70' 'b9'}), 'unicode') ' z ' native2unicode(hex2dec({'57' '50'}), 'unicode')  native2unicode(hex2dec({'68' '07'}), 'unicode') ]});
model.result('pg1').feature('surf1').set('colortable', 'RainbowLight');
model.result('pg1').feature('surf1').set('resolution', 'normal');
model.result('pg1').feature('surf1').feature('def').set('scaleactive', true);
model.result.export('anim1').set('plotgroup', 'pg1');
model.result.export('anim1').set('giffilename', 'C:\Users\Li Xiaowen\Desktop\Untitled.gif');
model.result.export('anim1').set('solnumtype', 'inner');
model.result.export('anim1').set('solnum', [1]);
model.result.export('anim1').set('framesel', 'all');
model.result.export('anim1').set('width', 2000);
model.result.export('anim1').set('height', 1300);
model.result.export('anim1').set('zoomextents', true);
model.result.export('anim1').set('resolution', 300);
model.result.export('anim1').set('fontsize', '16');
model.result.export('anim1').set('colortheme', 'globaltheme');
model.result.export('anim1').set('customcolor', [1 1 1]);
model.result.export('anim1').set('background', 'color');
model.result.export('anim1').set('gltfincludelines', 'on');
model.result.export('anim1').set('title1d', 'on');
model.result.export('anim1').set('legend1d', 'on');
model.result.export('anim1').set('logo1d', 'on');
model.result.export('anim1').set('options1d', 'on');
model.result.export('anim1').set('title2d', 'on');
model.result.export('anim1').set('legend2d', 'on');
model.result.export('anim1').set('logo2d', 'off');
model.result.export('anim1').set('options2d', 'on');
model.result.export('anim1').set('title3d', 'on');
model.result.export('anim1').set('legend3d', 'on');
model.result.export('anim1').set('logo3d', 'on');
model.result.export('anim1').set('options3d', 'off');
model.result.export('anim1').set('axisorientation', 'on');
model.result.export('anim1').set('grid', 'on');
model.result.export('anim1').set('axes1d', 'on');
model.result.export('anim1').set('axes2d', 'off');
model.result.export('anim1').set('showgrid', 'on');
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').appendResult;

model.label('Model.mph');

model.sol('sol2').clearSolutionData;

model.result('pg2').run;
model.result.table('tbl1').clearTableData;

model.label('Model.mph');

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;

model.sol('sol2').runAll;

model.result('pg2').run;
model.result('pg2').run;
model.result('pg2').run;
model.result.numerical('pev1').set('table', 'tbl1');
model.result.numerical('pev1').setResult;
model.result.numerical('pev2').set('table', 'tbl1');
model.result.numerical('pev2').appendResult;
model.result('pg2').run;
model.result('pg2').run;
model.result.export.create('plot1', 'pg2', 'ptgr1', 'Plot');
model.result.export('plot1').set('filename', 'C:\Users\Jon\Desktop\Untitled.txt');
model.result.export('plot1').run;

model.label('Model.mph');

out = model;
