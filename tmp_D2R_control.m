D2Rn_R = 2; D2Rn_CT = 336; D2Rn_RCT = 260;
D2Ro_R = [2,2,3,20,2,8,11]; D2Ro_CT = [370 882 202 908 662 217 972]; D2Ro_RCT = [61, 22, 313, 238, 47, 346, 144];


D2Ro_Total = sum( [D2Ro_CT; D2Ro_RCT], 1 );


D2Ro_Props = D2Ro_RCT ./ D2Ro_Total;
D2Ro_Props_avg = mean(D2Ro_Props);
D2Ro_Prop_STD = std( D2Ro_Props );

D2Rn_Prop = D2Rn_CT / (D2Rn_CT + D2Rn_RCT);

figure(); bar(D2Ro_Props_avg);
hold on; errorbar( 1, D2Ro_Props_avg, D2Ro_Prop_STD );
bar( 2, D2Rn_Prop );
ylim( [0, 1] );
hold off;

