function make_venns()

%%% D5R NeuN%%%
% dlPFC
Z = [329 0 225];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 1]},'FaceAlpha',{0.4,0.4},'EdgeColor','black')
title('dlPFC: D5R NeuN')
plot2svg('venn_dlpfc_D5RNeuN.svg')


% FEF
Z = [449 0 327];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 1]},'FaceAlpha',{0.4,0.4},'EdgeColor','black')
title('FEF: D5R NeuN')
plot2svg('venn_fef_D5RNeuN.svg')

%%% D2R NeuN %%%
% dlPFC


% FEF



%%% D2R ER81 %%%
% dlPFC
Z = [81 13 57];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
title('dlPFC: D2R ER81')
xlim([-8 9]); ylim([-7 7]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_dlpfc_D2RER81.svg')
disp(['dlPFC D2ER81: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

    % Large
    Z = [3 0 11];
    figure();
    venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
    title('dlPFC: D2R ER81, Larger Cells')
    xlim([-3 3]); ylim([-2.5 2.5]);
    set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
    plot2svg('venn_dlpfc_D2RER81_Large.svg')
    disp(['dlPFC D2ER81 Large: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

    
% FEF
Z = [31 4 12];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
title('FEF: D2R ER81')
xlim([-5 5]); ylim([-4 4]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_fef_D2RER81.svg')
disp(['FEF D2ER81: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

    %Larger:
    Z = [7 1 8];
    figure();
    venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
    title('FEF: D2R ER81, Larger Cells')
    xlim([-3 3]); ylim([-2.5 2.5]);
    set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
    plot2svg('venn_fef_D2RER81_Large.svg')
    disp(['FEF D2ER81 Large: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

    
    
%%% D5R Parv %%%
% dlPFC
Z = [21 125 83];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 1]},'FaceAlpha',{1,1},'EdgeColor','black')
title('dlPFC: D5R Parv')
xlim([-7 14]); ylim([-9 9]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_dlpfc_D5RParv.svg')
disp(['dlPFC D5R Parv: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

% FEF
Z = [11 67 42];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 1]},'FaceAlpha',{1,1},'EdgeColor','black')
title('FEF: D5R Parv')
xlim([-6 11]); ylim([-7 7]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_fef_D5RParv.svg')
disp(['FEF D5R Parv: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);


%%% D2R Parv %%%
% dlPFC
Z = [35 17 29];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
title('dlPFC: D2R Parv')
xlim([-5 8]); ylim([-5.5 5.5]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_dlpfc_D2RParv.svg')
disp(['dlPFC D2R Parv: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);


% FEF
Z = [29 21 32];
figure();
venn(Z,'FaceColor',{ [1 0 1],[0 1 0]},'FaceAlpha',{1,1},'EdgeColor','black')
title('FEF: D2R Parv')
xlim([-5 8]); ylim([-5.5 5.5]);
set(gca,'xtick',[], 'ytick',[],'xticklabel',[],'yticklabel',[]);
plot2svg('venn_fef_D2RParv.svg')
disp(['FEF D2R Parv: Cells: ' num2str(Z(1)) ', Receptors: ' num2str(Z(2)) ', Both: ' num2str(Z(3)) ', Fraction: ' num2str(Z(3) / (Z(2)+Z(3)))]);

end